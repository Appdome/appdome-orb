#!/bin/bash

process_provisioning_profiles() {
  declare -g provisioning_args=""
  mkdir -p appdome_files

  # Loop over all MOBILE_PROVISION_PROFILE* environment variables
  while IFS='=' read -r env_var _; do
    value="${!env_var}"
    if [[ -n "$value" ]]; then
      index="${env_var##*_}"
      [[ "$index" =~ ^[0-9]+$ ]] || index=""

      file="appdome_files/provisioning_profile${index}.mobileprovision"
      echo "Processing \$${env_var} → $file"

      if echo -n "$value" | base64 --decode &>/dev/null; then
        echo -n "$value" | base64 --decode > "$file"
        echo "Decoded and wrote to $file"
        provisioning_args+="$file "
      else
        echo "Skipping $env_var: invalid base64"
      fi
    fi
  done < <(env | grep "^MOBILE_PROVISION_PROFILE")

  # Trim leading/trailing/multiple spaces safely
  provisioning_args="$(echo "$provisioning_args" | xargs)"
  echo "Collected provisioning profiles: $provisioning_args"
}


echo "Appdome iOS private sign"
process_provisioning_profiles
ls appdome_files
mkdir appdome_outputs
VAR="${SIGNOVERRIDES}"

basename=$(basename "$OUTPUT")
extension="${APPFILE##*.}"


if [[ $basename == *.* ]]; then
  echo "Variable already has an extension."
else
  # Concatenate the extension of the APPFILE
  export OUTPUT="${basename}.${extension}"
fi


provisioning_arg=""
[[ -n "$provisioning_args" ]] && provisioning_arg="--provisioning_profiles $provisioning_args"


echo "Output file name: ${OUTPUT}"

if [[ -n "$VAR" ]]; then
    echo "detected sign overrides"
    if [[ -n "${TEAMID}" ]]; then
        command="python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} -t ${TEAMID} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --private_signing ${provisioning_arg} --sign_overrides appdome_files/$(basename "$SIGNOVERRIDES") --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
    else
        command="python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --private_signing ${provisioning_arg} --sign_overrides appdome_files/$(basename "$SIGNOVERRIDES") --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
    fi
else
    echo "no sign overrides"
    if [[ -n "${TEAMID}" ]]; then
        command="python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} -t ${TEAMID} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --private_signing ${provisioning_arg} --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
    else   
        command="python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --private_signing ${provisioning_arg} --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
    fi  
fi

if [ "${BUILD_WITH_LOGS}" -eq 1 ]; then
    command+=" --diagnostic_logs"
fi

if [[ -n "${BUILD_TO_TEST}" && "${BUILD_TO_TEST}" != "NONE" ]]; then
    command+=" --build_to_test_vendor ${BUILD_TO_TEST,,}"
fi

echo "$command"
eval "$command"

