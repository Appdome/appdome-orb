#!/bin/bash

echo "Appdome iOS private sign"
echo -n "${!PROVISIONING_PROFILES}" | base64 -d > files/provisioning_profiles.mobileprovision
ls files
mkdir output
VAR="${SIGNOVERRIDES}"

if [[ -n "$VAR" ]]; then
    echo "detected sign overrides"
    if [[ -n "${TEAMID}" ]]; then
        command="python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} -t ${TEAMID} --fusion_set_id ${!FUSIONSET} --app files/$(basename "$APPFILE") --private_signing --provisioning_profiles files/provisioning_profiles.mobileprovision --sign_overrides files/$(basename "$SIGNOVERRIDES") --output ./output/${OUTPUT} --certificate_output ./output/certificate.pdf"
    else
        command="python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} --fusion_set_id ${!FUSIONSET} --app files/$(basename "$APPFILE") --private_signing --provisioning_profiles files/provisioning_profiles.mobileprovision --sign_overrides files/$(basename "$SIGNOVERRIDES") --output ./output/${OUTPUT} --certificate_output ./output/certificate.pdf"
    fi
else
    echo "no sign overrides"
    if [[ -n "${TEAMID}" ]]; then
        command="python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} -t ${TEAMID} --fusion_set_id ${!FUSIONSET} --app files/$(basename "$APPFILE") --private_signing --provisioning_profiles files/provisioning_profiles.mobileprovision --output ./output/${OUTPUT} --certificate_output ./output/certificate.pdf"
    else   
        command="python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} -t ${TEAMID} --fusion_set_id ${!FUSIONSET} --app files/$(basename "$APPFILE") --private_signing --provisioning_profiles files/provisioning_profiles.mobileprovision --output ./output/${OUTPUT} --certificate_output ./output/certificate.pdf"
    fi  
fi

if [[ -n "${BUILD_LOGS}" ]]; then
    command+=" --diagnostic_logs"
fi

echo "$command"
eval "$command"

