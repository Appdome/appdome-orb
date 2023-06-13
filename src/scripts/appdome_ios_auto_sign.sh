#!/bin/bash

echo "Appdome iOS auto sign"
echo -n "${!P12_FILE}" | base64 -d > files/Cert.p12
echo -n "${!PROVISIONING_PROFILES}" | base64 -d > files/provisioning_profiles.mobileprovision
echo -n "${!ENTITLEMENTS}" | base64 -d > files/Entitlements.plist
ls files
mkdir output
VAR="${SIGNOVERRIDES}"
if [ "${BUILD_WITH_LOGS}" = true ]; then
  BUILD_LOGS="-build_with_logs"
else
  BUILD_LOGS=""
fi

echo "$BUILD_LOGS"

ls
if [[ -n "$VAR" ]]; then
    echo "detected sign overrides"
    if [[ -n "${TEAMID}" ]]; then
        echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --sign_on_appdome --keystore files/Cert.p12 --keystore_pass "${!P12_PASS}" --provisioning_profiles files/provisioning_profiles.mobileprovision --entitlements files/Entitlements.plist --sign_overrides files/"$(basename "$SIGNOVERRIDES")" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
        python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --sign_on_appdome --keystore files/Cert.p12 --keystore_pass "${!P12_PASS}" --provisioning_profiles files/provisioning_profiles.mobileprovision --entitlements files/Entitlements.plist --sign_overrides files/"$(basename "$SIGNOVERRIDES")" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
    else
        echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --sign_on_appdome --keystore files/Cert.p12 --keystore_pass "${!P12_PASS}" --provisioning_profiles files/provisioning_profiles.mobileprovision --entitlements files/Entitlements.plist --sign_overrides files/"$(basename "$SIGNOVERRIDES")" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
        python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --sign_on_appdome --keystore files/Cert.p12 --keystore_pass "${!P12_PASS}" --provisioning_profiles files/provisioning_profiles.mobileprovision --entitlements files/Entitlements.plist --sign_overrides files/"$(basename "$SIGNOVERRIDES")" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
    fi
else
    echo "no sign overrides"
    if [[ -n "${TEAMID}" ]]; then
        echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --sign_on_appdome --keystore files/Cert.p12 --keystore_pass "${!P12_PASS}" --provisioning_profiles files/provisioning_profiles.mobileprovision --entitlements files/Entitlements.plist --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
        python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --sign_on_appdome --keystore files/Cert.p12 --keystore_pass "${!P12_PASS}" --provisioning_profiles files/provisioning_profiles.mobileprovision --entitlements files/Entitlements.plist --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
    else
        echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --sign_on_appdome --keystore files/Cert.p12 --keystore_pass "${!P12_PASS}" --provisioning_profiles files/provisioning_profiles.mobileprovision --entitlements files/Entitlements.plist --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
        python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --sign_on_appdome --keystore files/Cert.p12 --keystore_pass "${!P12_PASS}" --provisioning_profiles files/provisioning_profiles.mobileprovision --entitlements files/Entitlements.plist --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
    fi
fi