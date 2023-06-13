#!/bin/bash

echo "Appdome iOS private sign"
echo -n "${!PROVISIONING_PROFILES}" | base64 -d > files/provisioning_profiles.mobileprovision
ls files
mkdir output
VAR="${SIGNOVERRIDES}"

if [ "${BUILD_WITH_LOGS}" = true ]; then
  BUILD_LOGS="-build_with_logs"
else
  BUILD_LOGS=""
fi
echo BUILD_WITH_LOGS = "${BUILD_WITH_LOGS}"
echo build_logs = "$BUILD_LOGS"

ls

if [[ -n "$VAR" ]]; then
    echo "detected sign overrides"
    if [[ -n "${TEAMID}" ]]; then
        echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --private_signing --provisioning_profiles files/provisioning_profiles.mobileprovision --sign_overrides files/"$(basename "$SIGNOVERRIDES")" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
        python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}"  -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --private_signing --provisioning_profiles files/provisioning_profiles.mobileprovision --sign_overrides files/"$(basename "$SIGNOVERRIDES")" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
    else
        echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --private_signing --provisioning_profiles files/provisioning_profiles.mobileprovision --sign_overrides files/"$(basename "$SIGNOVERRIDES")" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
        python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --private_signing --provisioning_profiles files/provisioning_profiles.mobileprovision --sign_overrides files/"$(basename "$SIGNOVERRIDES")" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
    fi
else
    echo "no sign overrides"
    if [[ -n "${TEAMID}" ]]; then
        echo on3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --private_signing --provisioning_profiles files/provisioning_profiles.mobileprovision --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
        python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --private_signing --provisioning_profiles files/provisioning_profiles.mobileprovision --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
    else   
        echo on3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --private_signing --provisioning_profiles files/provisioning_profiles.mobileprovision --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
        python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --private_signing --provisioning_profiles files/provisioning_profiles.mobileprovision --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
    fi  
fi