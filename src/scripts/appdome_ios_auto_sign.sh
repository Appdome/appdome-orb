#!/bin/bash

echo "Appdome iOS auto sign"
echo -n "${!P12_FILE}" | base64 -d > appdome_files/Cert.p12
echo -n "${!PROVISIONING_PROFILES}" | base64 -d > appdome_files/provisioning_profiles.mobileprovision
echo -n "${!ENTITLEMENTS}" | base64 -d > appdome_files/Entitlements.plist
ls appdome_files
mkdir appdome_outputs
VAR="${SIGNOVERRIDES}"
ls
if [[ -n "$VAR" ]]; then
    echo "detected sign overrides"
    if [[ -n "${TEAMID}" ]]; then
        echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --sign_on_appdome --keystore appdome_files/Cert.p12 --keystore_pass "${!P12_PASS}" --provisioning_profiles appdome_files/provisioning_profiles.mobileprovision --entitlements appdome_files/Entitlements.plist --sign_overrides appdome_files/"$(basename "$SIGNOVERRIDES")" --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
        python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --sign_on_appdome --keystore appdome_files/Cert.p12 --keystore_pass "${!P12_PASS}" --provisioning_profiles appdome_files/provisioning_profiles.mobileprovision --entitlements appdome_files/Entitlements.plist --sign_overrides appdome_files/"$(basename "$SIGNOVERRIDES")" --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
    else
        echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --sign_on_appdome --keystore appdome_files/Cert.p12 --keystore_pass "${!P12_PASS}" --provisioning_profiles appdome_files/provisioning_profiles.mobileprovision --entitlements appdome_files/Entitlements.plist --sign_overrides appdome_files/"$(basename "$SIGNOVERRIDES")" --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
        python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --sign_on_appdome --keystore appdome_files/Cert.p12 --keystore_pass "${!P12_PASS}" --provisioning_profiles appdome_files/provisioning_profiles.mobileprovision --entitlements appdome_files/Entitlements.plist --sign_overrides appdome_files/"$(basename "$SIGNOVERRIDES")" --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
    fi
else
    echo "no sign overrides"
    if [[ -n "${TEAMID}" ]]; then
        echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --sign_on_appdome --keystore appdome_files/Cert.p12 --keystore_pass "${!P12_PASS}" --provisioning_profiles appdome_files/provisioning_profiles.mobileprovision --entitlements appdome_files/Entitlements.plist --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
        python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --sign_on_appdome --keystore appdome_files/Cert.p12 --keystore_pass "${!P12_PASS}" --provisioning_profiles appdome_files/provisioning_profiles.mobileprovision --entitlements appdome_files/Entitlements.plist --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
    else
        echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --sign_on_appdome --keystore appdome_files/Cert.p12 --keystore_pass "${!P12_PASS}" --provisioning_profiles appdome_files/provisioning_profiles.mobileprovision --entitlements appdome_files/Entitlements.plist --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
        python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --sign_on_appdome --keystore appdome_files/Cert.p12 --keystore_pass "${!P12_PASS}" --provisioning_profiles appdome_files/provisioning_profiles.mobileprovision --entitlements appdome_files/Entitlements.plist --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
    fi
fi