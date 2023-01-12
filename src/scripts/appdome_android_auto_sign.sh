#!/bin/bash

echo "Appdome Android Auto Sign"
mkdir output
VAR="${SIGNOVERRIDES}"
ls
if [[ -n "$VAR" ]]; then
    VAR="${GOOGLEPLAYSIGN}"
    if [ "$VAR" = true ]; then
        echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${APPDOME_API_KEY}" --fusion_set_id "${FUSIONSET}" --app files/"$(basename "$APPFILE")" --sign_on_appdome --keystore files/"$(basename "$KEYSTORE")" --keystore_pass "${KEYSTORE_PASS}" --keystore_alias "${KEYSTORE_ALIAS}" --key_pass "${KEYSTORE_KEY_PASS}" --sign_overrides files/"$(basename "$SIGNOVERRIDES")" --google_play_signing --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
        python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${APPDOME_API_KEY}" --fusion_set_id "${FUSIONSET}" --app files/"$(basename "$APPFILE")" --sign_on_appdome --keystore files/"$(basename "$KEYSTORE")" --keystore_pass "${KEYSTORE_PASS}" --keystore_alias "${KEYSTORE_ALIAS}" --key_pass "${KEYSTORE_KEY_PASS}" --sign_overrides files/"$(basename "$SIGNOVERRIDES")" --google_play_signing --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
    else
        echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${APPDOME_API_KEY}" --fusion_set_id "${FUSIONSET}" --app files/"$(basename "$APPFILE")" --sign_on_appdome --keystore files/"$(basename "$KEYSTORE")" --keystore_pass "${KEYSTORE_PASS}" --keystore_alias "${KEYSTORE_ALIAS}" --key_pass "${KEYSTORE_KEY_PASS}" --sign_overrides files/"$(basename "$SIGNOVERRIDES")" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
        python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${APPDOME_API_KEY}" --fusion_set_id "${FUSIONSET}" --app files/"$(basename "$APPFILE")" --sign_on_appdome --keystore files/"$(basename "$KEYSTORE")" --keystore_pass "${KEYSTORE_PASS}" --keystore_alias "${KEYSTORE_ALIAS}" --key_pass "${KEYSTORE_KEY_PASS}" --sign_overrides files/"$(basename "$SIGNOVERRIDES")" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
    fi
else
    VAR="${GOOGLEPLAYSIGN}"
    if [ "$VAR" = true ]; then
        echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${APPDOME_API_KEY}" --fusion_set_id "${FUSIONSET}" --app files/"$(basename "$APPFILE")" --google_play_signing --sign_on_appdome --keystore files/"$(basename "$KEYSTORE")" --keystore_pass "${KEYSTORE_PASS}" --keystore_alias "${KEYSTORE_ALIAS}" --key_pass "${KEYSTORE_KEY_PASS}" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf 
        python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${APPDOME_API_KEY}" --fusion_set_id "${FUSIONSET}" --app files/"$(basename "$APPFILE")" --google_play_signing --sign_on_appdome --keystore files/"$(basename "$KEYSTORE")" --keystore_pass "${KEYSTORE_PASS}" --keystore_alias "${KEYSTORE_ALIAS}" --key_pass "${KEYSTORE_KEY_PASS}" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
    else
        echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${APPDOME_API_KEY}" --fusion_set_id "${FUSIONSET}" --app files/"$(basename "$APPFILE")" --sign_on_appdome --keystore files/"$(basename "$KEYSTORE")" --keystore_pass "${KEYSTORE_PASS}" --keystore_alias "${KEYSTORE_ALIAS}" --key_pass "${KEYSTORE_KEY_PASS}" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
        python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${APPDOME_API_KEY}" --fusion_set_id "${FUSIONSET}" --app files/"$(basename "$APPFILE")" --sign_on_appdome --keystore files/"$(basename "$KEYSTORE")" --keystore_pass "${KEYSTORE_PASS}" --keystore_alias "${KEYSTORE_ALIAS}" --key_pass "${KEYSTORE_KEY_PASS}" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
    fi
fi