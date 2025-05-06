#!/bin/bash

# Counts all env vars at runtime
print_env_var() {
  local var_name="$1"

  if [[ -z "$var_name" ]]; then
    echo "❌ Usage: print_env_var <ENV_VAR_NAME>" >&2
    return 1
  fi

  if [[ -z "${!var_name:-}" ]]; then
    echo "⚠️  Environment variable '$var_name' is not set or is empty."
  else
    echo "🔎 $var_name=${!var_name}"
  fi
}




# === Appdome iOS private sign ===

echo "Appdome iOS private sign"
mkdir -p appdome_files
mkdir -p appdome_outputs

print_env_var "TEST"



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
        command="python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} -t ${TEAMID} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --private_signing --provisioning_profiles ds --sign_overrides appdome_files/$(basename "$SIGNOVERRIDES") --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
    else
        command="python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --private_signing --provisioning_profiles ds --sign_overrides appdome_files/$(basename "$SIGNOVERRIDES") --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
    fi
else
    echo "no sign overrides"
    if [[ -n "${TEAMID}" ]]; then
        command="python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} -t ${TEAMID} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --private_signing --provisioning_profiles ds --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
    else   
        command="python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --private_signing --provisioning_profiles sd --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
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
