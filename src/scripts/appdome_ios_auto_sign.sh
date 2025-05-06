#!/bin/bash

# Collects and decodes all provisioning and entitlement env vars
process_ios_signing_inputs() {
  declare -g provisioning_args=""
  declare -g entitlements_args=""

  mkdir -p appdome_files

  for prefix in MOBILE_PROVISION_PROFILE ENTITLEMENTS; do
    while IFS='=' read -r env_var _; do
      value="${!env_var}"
      if [[ -n "$value" ]]; then
        index="${env_var##*_}"
        [[ "$index" =~ ^[0-9]+$ ]] || index=""

        if [[ "$prefix" == "MOBILE_PROVISION_PROFILE" ]]; then
          file="appdome_files/provisioning_profile${index}.mobileprovision"
        else
          file="appdome_files/Entitlements${index}.plist"
        fi

        echo "🔍 Processing \$${env_var} → $file"

        # Validate base64 before decoding
        if echo -n "$value" | base64 --decode &>/dev/null; then
          echo -n "$value" | base64 --decode > "$file"
          echo "✅ Decoded and wrote to $file"

          if [[ "$prefix" == "MOBILE_PROVISION_PROFILE" ]]; then
            provisioning_args+="$file,"
          else
            entitlements_args+="$file,"
          fi
        else
          echo "❌ Skipping $env_var: invalid base64"
        fi
      else
        echo "⚠️  $env_var is set but empty, skipping."
      fi
    done < <(env | grep "^${prefix}")
  done

  # Strip trailing commas
  provisioning_args="${provisioning_args%,}"
  entitlements_args="${entitlements_args%,}"

  # Count files
  num_prov=$(grep -o "," <<< "$provisioning_args" | wc -l)
  num_ent=$(grep -o "," <<< "$entitlements_args" | wc -l)
  [[ -n "$provisioning_args" ]] && ((num_prov++))
  [[ -n "$entitlements_args" ]] && ((num_ent++))

  echo "📦 Collected $num_prov provisioning profile(s)"
  echo "📦 Collected $num_ent entitlement file(s)"
}

echo "Appdome iOS auto sign"
process_ios_signing_inputs

echo -n "${!P12_FILE}" | base64 -d > appdome_files/Cert.p12
ls appdome_files
mkdir -p appdome_outputs
VAR="${SIGNOVERRIDES}"

basename=$(basename "$OUTPUT")
extension="${APPFILE##*.}"

if [[ $basename == *.* ]]; then
  echo "Variable already has an extension."
else
  export OUTPUT="${basename}.${extension}"
fi

echo "Output file name: ${OUTPUT}"

ls
if [[ -n "$entitlements_args" ]]; then
    entitlements_arg="--entitlements ${entitlements_args}"
else
    entitlements_arg=""
fi
if [[ -n "$provisioning_args" ]]; then
    provisioning_arg="--provisioning_profiles ${provisioning_args}"
else
    provisioning_arg=""
fi

if [[ -n "$VAR" ]]; then
    echo "detected sign overrides"
    command="python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --sign_on_appdome --keystore appdome_files/Cert.p12 --keystore_pass ${!P12_PASS} ${provisioning_arg} ${entitlements_arg} --sign_overrides appdome_files/$(basename "$SIGNOVERRIDES") --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
else
    echo "no sign overrides"
    command="python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --sign_on_appdome --keystore appdome_files/Cert.p12 --keystore_pass ${!P12_PASS} ${provisioning_arg} ${entitlements_arg} --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
fi

if [[ -n "${TEAMID}" ]]; then
    command+=" -t ${TEAMID}"
fi

if [ "${BUILD_WITH_LOGS}" -eq 1 ]; then
    command+=" --diagnostic_logs"
fi

if [[ -n "${BUILD_TO_TEST}" && "${BUILD_TO_TEST}" != "NONE" ]]; then
    command+=" --build_to_test_vendor ${BUILD_TO_TEST,,}"
fi

echo "$command"
eval "$command"