#!/bin/bash

expand_env_vars_with_prefix() {
  local prefix="$1"
  local out_var="$2"

  if [[ -z "$prefix" || -z "$out_var" ]]; then
    echo "❌ Usage: expand_env_vars_with_prefix <PREFIX> <output_variable>" >&2
    return 1
  fi

  local file_paths=""
  local env_var
  local count=0

  echo "🔍 Scanning environment variables starting with: $prefix"
  while IFS='=' read -r env_var _; do
    local value="${!env_var}"
    if [[ -n "$value" ]]; then
      local index="${env_var##*_}"
      [[ "$index" =~ ^[0-9]+$ ]] || index=""  # use index only if numeric suffix

      local file_name="${prefix,,}${index}.decoded"
      local path="appdome_files/$file_name"

      echo "✅ Found env var: $env_var"
      echo "📦 Writing to: $path"
      echo -n "$value" | base64 -d > "$path"

      # Optional: show preview
      echo "🔎 Preview of decoded content (first 3 lines of $path):"
      head -n 3 "$path" || echo "(file not readable)"

      file_paths+="$path,"
      ((count++))
    fi
  done < <(env | grep "^${prefix}")

  file_paths="${file_paths%,}"
  eval "$out_var=\"$file_paths\""

  echo "📋 Final list for $out_var: $file_paths"
  echo "🧮 Total matched variables with prefix '${prefix}': $count"
}



# === Appdome iOS private sign ===

echo "Appdome iOS private sign"
mkdir -p appdome_files
mkdir -p appdome_outputs

expand_env_vars_with_prefix "MOBILE_PROVISION_PROFILE_FILE" provisioning_args
# shellcheck disable=SC2154
echo "📋 Provisioning profile paths: ${provisioning_args}"
# shellcheck disable=SC2154
echo "🧾 Provisioning profiles passed to Appdome: ${provisioning_args}"

VAR="${SIGNOVERRIDES}"

basename=$(basename "$OUTPUT")
extension="${APPFILE##*.}"

if [[ $basename == *.* ]]; then
  echo "Variable already has an extension."
else
  export OUTPUT="${basename}.${extension}"
fi

echo "Output file name: ${OUTPUT}"

# Build command based on overrides and team ID
if [[ -n "$VAR" ]]; then
    echo "detected sign overrides"
    if [[ -n "${TEAMID}" ]]; then
        command="python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} -t ${TEAMID} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --private_signing --provisioning_profiles ${provisioning_args} --sign_overrides appdome_files/$(basename "$SIGNOVERRIDES") --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
    else
        command="python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --private_signing --provisioning_profiles ${provisioning_args} --sign_overrides appdome_files/$(basename "$SIGNOVERRIDES") --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
    fi
else
    echo "no sign overrides"
    if [[ -n "${TEAMID}" ]]; then
        command="python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} -t ${TEAMID} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --private_signing --provisioning_profiles ${provisioning_args} --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
    else   
        command="python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --private_signing --provisioning_profiles ${provisioning_args} --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
    fi  
fi

# Optional Appdome CLI args
if [ "${BUILD_WITH_LOGS}" -eq 1 ]; then
    command+=" --diagnostic_logs"
fi

if [[ -n "${BUILD_TO_TEST}" && "${BUILD_TO_TEST}" != "NONE" ]]; then
    command+=" --build_to_test_vendor ${BUILD_TO_TEST,,}"
fi

echo "$command"
eval "$command"
