#!/bin/bash

base64 --decode "${!P12_FILE}" > files/Cert.p12
base64 --decode "${!PROVISIONING_PROFILES}" > files/provisioning_profiles.mobileprovision
base64 --decode "${!ENTITLEMENTS}" > files/Entitlements.plist

echo "Appdome iOS auto sign"
mkdir output
VAR="${SIGNOVERRIDES}"
ls
if [[ -n "$VAR" ]]; then
    echo "detected sign overrides"
    echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${FUSIONSET}" --app files/"$(basename "$APPFILE")" --sign_on_appdome --keystore files/Cert.p12 --keystore_pass "${!P12_PASS}" --provisioning_profiles files/provisioning_profiles.mobileprovision --entitlements files/Entitlements.plist --sign_overrides files/"$(basename "$SIGNOVERRIDES")" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
    python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${FUSIONSET}" --app files/"$(basename "$APPFILE")" --sign_on_appdome --keystore files/Cert.p12 --keystore_pass "${!P12_PASS}" --provisioning_profiles files/provisioning_profiles.mobileprovision --entitlements files/Entitlements.plist --sign_overrides files/"$(basename "$SIGNOVERRIDES")" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
else
    echo "no sign overrides"
    echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${FUSIONSET}" --app files/"$(basename "$APPFILE")" --sign_on_appdome --keystore files/Cert.p12 --keystore_pass "${!P12_PASS}" --provisioning_profiles files/provisioning_profiles.mobileprovision --entitlements files/Entitlements.plist --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
    python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${FUSIONSET}" --app files/"$(basename "$APPFILE")" --sign_on_appdome --keystore files/Cert.p12 --keystore_pass "${!P12_PASS}" --provisioning_profiles files/provisioning_profiles.mobileprovision --entitlements files/Entitlements.plist --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
fi