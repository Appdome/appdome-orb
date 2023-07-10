#!/bin/bash

echo "Appdome iOS private sign"
echo -n "${!PROVISIONING_PROFILES}" | base64 -d > appdome_files/provisioning_profiles.mobileprovision
ls appdome_files
mkdir appdome_outputs
VAR="${SIGNOVERRIDES}"

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
        command="python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} -t ${TEAMID} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --private_signing --provisioning_profiles appdome_files/provisioning_profiles.mobileprovision --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
    fi  
fi

if [ "${BUILD_WITH_LOGS}" -eq 1 ]; then
    command+=" --diagnostic_logs"
fi

if [[ -n "${SECOND_OUTPUT}" ]]; then
    command+=" --second_output ./appdome_outputs/${SECOND_OUTPUT}"
fi

if [[ -n "${BUILD_TO_TEST}" && "${BUILD_TO_TEST}" != "NONE" ]]; then
    command+=" --build_to_test_vendor ${BUILD_TO_TEST,,}"
fi

echo "$command"
eval "$command"

