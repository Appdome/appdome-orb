#!/bin/bash
echo "Appdome iOS Auto-DEV private sign"
echo -n "${!PROVISIONING_PROFILES}" | base64 -d > appdome_files/provisioning_profiles.mobileprovision
echo -n "${!ENTITLEMENTS}" | base64 -d > appdome_files/Entitlements.plist
ls appdome_files
mkdir -p appdome_outputs
VAR="${SIGNOVERRIDES}"

basename=$(basename "$OUTPUT")
export OUTPUT="${basename}.sh"

echo "Output file name: ${OUTPUT}"

ls
entitlements_arg=""
if [[ -s appdome_files/Entitlements.plist ]]; then
    entitlements_arg="--entitlements appdome_files/Entitlements.plist"
fi

if [[ -n "$VAR" ]]; then
    echo "detected sign overrides"
    command="python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --auto_dev_private_signing --provisioning_profiles appdome_files/provisioning_profiles.mobileprovision ${entitlements_arg} --sign_overrides appdome_files/$(basename "$SIGNOVERRIDES") --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
else
    echo "no sign overrides"
    command="python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --auto_dev_private_signing --provisioning_profiles appdome_files/provisioning_profiles.mobileprovision ${entitlements_arg} --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
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