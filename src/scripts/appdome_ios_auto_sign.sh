#!/bin/bash

echo "Appdome iOS auto sign"
mkdir output
VAR="${SIGNOVERRIDES}"
ls
if [[ -n "$VAR" ]]; then
    echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${APPDOME_API_KEY}" --fusion_set_id "${FUSIONSET}" --app files/"$(basename "$APPFILE")" --sign_on_appdome --keystore files/"$(basename "$KEYSTORE")" --keystore_pass "${KEYSTORE_PASS}" --provisioning_profiles files/"$(basename "$PROVISIONING_PROFILES")" --entitlements files/"$(basename "$ENTITLEMENTS")" --sign_overrides files/"$(basename "$SIGNOVERRIDES")" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
    python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${APPDOME_API_KEY}" --fusion_set_id "${FUSIONSET}" --app files/"$(basename "$APPFILE")" --sign_on_appdome --keystore files/"$(basename "$KEYSTORE")" --keystore_pass "${KEYSTORE_PASS}" --provisioning_profiles files/"$(basename "$PROVISIONING_PROFILES")" --entitlements files/"$(basename "$ENTITLEMENTS")" --sign_overrides files/"$(basename "$SIGNOVERRIDES")" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
else
    echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${APPDOME_API_KEY}" --fusion_set_id "${FUSIONSET}" --app files/"$(basename "$APPFILE")" --sign_on_appdome --keystore files/"$(basename "$KEYSTORE")" --keystore_pass "${KEYSTORE_PASS}" --provisioning_profiles files/"$(basename "$PROVISIONING_PROFILES")" --entitlements files/"$(basename "$ENTITLEMENTS")" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
    python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${APPDOME_API_KEY}" --fusion_set_id "${FUSIONSET}" --app files/"$(basename "$APPFILE")" --sign_on_appdome --keystore files/"$(basename "$KEYSTORE")" --keystore_pass "${KEYSTORE_PASS}" --provisioning_profiles files/"$(basename "$PROVISIONING_PROFILES")" --entitlements files/"$(basename "$ENTITLEMENTS")" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
fi