#!/bin/bash
source "$(dirname "$0")/utils.sh"


echo "Appdome iOS private sign"
# echo -n "${!PROVISIONING_PROFILES}" | base64 -d > appdome_files/provisioning_profiles.mobileprovision
ls appdome_files
mkdir appdome_outputs


expand_env_vars_with_prefix "MOBILE_PROVISION_PROFILE_FILE" provisioning_args
echo "📋 Provisioning profile paths: ${provisioning_args}"
echo "🧾 Provisioning profiles passed to Appdome: ${provisioning_args}"


VAR="${SIGNOVERRIDES}"

basename=$(basename "$OUTPUT")
extension="${APPFILE##*.}"


if [[ $basename == *.* ]]; then
  echo "Variable already has an extension."
else
  # Concatenate the extension of the APPFILE
  export OUTPUT="${basename}.${extension}"
fi

echo "Output file name: ${OUTPUT}"

if [[ -n "$VAR" ]]; then
    echo "detected sign overrides"
    if [[ -n "${TEAMID}" ]]; then
        command="python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} -t ${TEAMID} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --private_signing --provisioning_profiles appdome_files/provisioning_profiles.mobileprovision --sign_overrides appdome_files/$(basename "$SIGNOVERRIDES") --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
    else
        command="python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --private_signing --provisioning_profiles appdome_files/provisioning_profiles.mobileprovision --sign_overrides appdome_files/$(basename "$SIGNOVERRIDES") --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
    fi
else
    echo "no sign overrides"
    if [[ -n "${TEAMID}" ]]; then
        command="python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} -t ${TEAMID} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --private_signing --provisioning_profiles appdome_files/provisioning_profiles.mobileprovision --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
    else   
        command="python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --private_signing --provisioning_profiles appdome_files/provisioning_profiles.mobileprovision --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
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

