#!/bin/bash
echo "Appdome Android Auto Sign"
mkdir output
mkdir secret
ls
echo "${!KEYSTORE}" > files/keystore.keystore
ls secret/
VAR="${SIGNOVERRIDES}"

if [[ -n "$VAR" ]]; then
    echo "detected sign overrides"
    if [ "${GOOGLEPLAYSIGN}" -eq 1 ]; then
        echo "google play sign"
        echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${FUSIONSET}" --app files/"$(basename "$APPFILE")" --sign_on_appdome --keystore files/keystore.keystore --keystore_pass "${!KEYSTORE_PASS}" --keystore_alias "${!KEYSTORE_ALIAS_ENV}" --key_pass "${!KEYSTORE_KEY_PASS}" --sign_overrides files/"$(basename "$SIGNOVERRIDES")" --google_play_signing --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
        python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${FUSIONSET}" --app files/"$(basename "$APPFILE")" --sign_on_appdome --keystore files/keystore.keystore --keystore_pass "${!KEYSTORE_PASS}" --keystore_alias "${!KEYSTORE_ALIAS_ENV}" --key_pass "${!KEYSTORE_KEY_PASS}" --sign_overrides files/"$(basename "$SIGNOVERRIDES")" --google_play_signing --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
    else
        echo "no google play sign"
        echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${FUSIONSET}" --app files/"$(basename "$APPFILE")" --sign_on_appdome --keystore files/keystore.keystore --keystore_pass "${!KEYSTORE_PASS}" --keystore_alias "${!KEYSTORE_ALIAS_ENV}" --key_pass "${!KEYSTORE_KEY_PASS}" --sign_overrides files/"$(basename "$SIGNOVERRIDES")" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
        python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${FUSIONSET}" --app files/"$(basename "$APPFILE")" --sign_on_appdome --keystore files/keystore.keystore --keystore_pass "${!KEYSTORE_PASS}" --keystore_alias "${!KEYSTORE_ALIAS_ENV}" --key_pass "${!KEYSTORE_KEY_PASS}" --sign_overrides files/"$(basename "$SIGNOVERRIDES")" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
    fi
else
    echo "no sign overrides"
    if [ "${GOOGLEPLAYSIGN}" -eq 1 ]; then
        echo "google play sign"
        echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${FUSIONSET}" --app files/"$(basename "$APPFILE")" --google_play_signing --sign_on_appdome --keystore files/keystore.keystore --keystore_pass "${!KEYSTORE_PASS}" --keystore_alias "${!KEYSTORE_ALIAS_ENV}" --key_pass "${!KEYSTORE_KEY_PASS}" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf 
        python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${FUSIONSET}" --app files/"$(basename "$APPFILE")" --google_play_signing --sign_on_appdome --keystore files/keystore.keystore --keystore_pass "${!KEYSTORE_PASS}" --keystore_alias "${!KEYSTORE_ALIAS_ENV}" --key_pass "${!KEYSTORE_KEY_PASS}" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
    else
        echo "no google play sign"
        echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${FUSIONSET}" --app files/"$(basename "$APPFILE")" --sign_on_appdome --keystore files/keystore.keystore --keystore_pass "${!KEYSTORE_PASS}" --keystore_alias "${!KEYSTORE_ALIAS_ENV}" --key_pass "${!KEYSTORE_KEY_PASS}" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
        python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${FUSIONSET}" --app files/"$(basename "$APPFILE")" --sign_on_appdome --keystore files/keystore.keystore --keystore_pass "${!KEYSTORE_PASS}" --keystore_alias "${!KEYSTORE_ALIAS_ENV}" --key_pass "${!KEYSTORE_KEY_PASS}" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
    fi
fi