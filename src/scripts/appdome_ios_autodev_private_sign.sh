#!/bin/bash
echo "Appdome iOS Auto-DEV private sign"
echo -n "${!PROVISIONING_PROFILES}" | base64 -d > files/provisioning_profiles.mobileprovision
ls files
mkdir output
VAR="${SIGNOVERRIDES}"
ls
if [[ -n "$VAR" ]]; then
    echo "detected sign overrides"
    echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --auto_dev_private_signing --provisioning_profiles files/provisioning_profiles.mobileprovision --sign_overrides files/"$(basename "$SIGNOVERRIDES")" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
    python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --auto_dev_private_signing --provisioning_profiles files/provisioning_profiles.mobileprovision --sign_overrides files/"$(basename "$SIGNOVERRIDES")" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
else
    echo "no sign overrides"
    echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --auto_dev_private_signing --provisioning_profiles files/provisioning_profiles.mobileprovision --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
    python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --auto_dev_private_signing --provisioning_profiles files/provisioning_profiles.mobileprovision --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
fi