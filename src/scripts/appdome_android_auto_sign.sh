#!/bin/bash
echo "Appdome Android Auto Sign"
mkdir -p appdome_outputs
echo -n "${!KEYSTORE}" | base64 -d > appdome_files/keystore.keystore
ls appdome_files
VAR="${SIGNOVERRIDES}"

if [[ -n "$VAR" ]]; then
    echo "detected sign overrides"
    if [ "${GOOGLEPLAYSIGN}" -eq 1 ]; then
        echo "google play sign"
        if [[ -n "${TEAMID}" ]]; then
            echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --sign_on_appdome --keystore appdome_files/keystore.keystore --keystore_pass "${!KEYSTORE_PASS}" --keystore_alias "${!KEYSTORE_ALIAS_ENV}" --key_pass "${!KEYSTORE_KEY_PASS}" --sign_overrides appdome_files/"$(basename "$SIGNOVERRIDES")" --google_play_signing --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
            python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --sign_on_appdome --keystore appdome_files/keystore.keystore --keystore_pass "${!KEYSTORE_PASS}" --keystore_alias "${!KEYSTORE_ALIAS_ENV}" --key_pass "${!KEYSTORE_KEY_PASS}" --sign_overrides appdome_files/"$(basename "$SIGNOVERRIDES")" --google_play_signing --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
        else
            echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --sign_on_appdome --keystore appdome_files/keystore.keystore --keystore_pass "${!KEYSTORE_PASS}" --keystore_alias "${!KEYSTORE_ALIAS_ENV}" --key_pass "${!KEYSTORE_KEY_PASS}" --sign_overrides appdome_files/"$(basename "$SIGNOVERRIDES")" --google_play_signing --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
            python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --sign_on_appdome --keystore appdome_files/keystore.keystore --keystore_pass "${!KEYSTORE_PASS}" --keystore_alias "${!KEYSTORE_ALIAS_ENV}" --key_pass "${!KEYSTORE_KEY_PASS}" --sign_overrides appdome_files/"$(basename "$SIGNOVERRIDES")" --google_play_signing --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
        fi
    else
        echo "no google play sign"
        if [[ -n "${TEAMID}" ]]; then
            echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --sign_on_appdome --keystore appdome_files/keystore.keystore --keystore_pass "${!KEYSTORE_PASS}" --keystore_alias "${!KEYSTORE_ALIAS_ENV}" --key_pass "${!KEYSTORE_KEY_PASS}" --sign_overrides appdome_files/"$(basename "$SIGNOVERRIDES")" --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
            python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --sign_on_appdome --keystore appdome_files/keystore.keystore --keystore_pass "${!KEYSTORE_PASS}" --keystore_alias "${!KEYSTORE_ALIAS_ENV}" --key_pass "${!KEYSTORE_KEY_PASS}" --sign_overrides appdome_files/"$(basename "$SIGNOVERRIDES")" --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
        else
            echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --sign_on_appdome --keystore appdome_files/keystore.keystore --keystore_pass "${!KEYSTORE_PASS}" --keystore_alias "${!KEYSTORE_ALIAS_ENV}" --key_pass "${!KEYSTORE_KEY_PASS}" --sign_overrides appdome_files/"$(basename "$SIGNOVERRIDES")" --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
            python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --sign_on_appdome --keystore appdome_files/keystore.keystore --keystore_pass "${!KEYSTORE_PASS}" --keystore_alias "${!KEYSTORE_ALIAS_ENV}" --key_pass "${!KEYSTORE_KEY_PASS}" --sign_overrides appdome_files/"$(basename "$SIGNOVERRIDES")" --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
        fi
    fi
else
    echo "no sign overrides"
    if [ "${GOOGLEPLAYSIGN}" -eq 1 ]; then
        echo "google play sign"
        if [[ -n "${TEAMID}" ]]; then
            echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --google_play_signing --sign_on_appdome --keystore appdome_files/keystore.keystore --keystore_pass "${!KEYSTORE_PASS}" --keystore_alias "${!KEYSTORE_ALIAS_ENV}" --key_pass "${!KEYSTORE_KEY_PASS}" --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf 
            python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --google_play_signing --sign_on_appdome --keystore appdome_files/keystore.keystore --keystore_pass "${!KEYSTORE_PASS}" --keystore_alias "${!KEYSTORE_ALIAS_ENV}" --key_pass "${!KEYSTORE_KEY_PASS}" --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
        else
            echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --google_play_signing --sign_on_appdome --keystore appdome_files/keystore.keystore --keystore_pass "${!KEYSTORE_PASS}" --keystore_alias "${!KEYSTORE_ALIAS_ENV}" --key_pass "${!KEYSTORE_KEY_PASS}" --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf 
            python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --google_play_signing --sign_on_appdome --keystore appdome_files/keystore.keystore --keystore_pass "${!KEYSTORE_PASS}" --keystore_alias "${!KEYSTORE_ALIAS_ENV}" --key_pass "${!KEYSTORE_KEY_PASS}" --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
        fi
    else
        echo "no google play sign"
        if [[ -n "${TEAMID}" ]]; then
            echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --sign_on_appdome --keystore appdome_files/keystore.keystore --keystore_pass "${!KEYSTORE_PASS}" --keystore_alias "${!KEYSTORE_ALIAS_ENV}" --key_pass "${!KEYSTORE_KEY_PASS}" --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
            python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --sign_on_appdome --keystore appdome_files/keystore.keystore --keystore_pass "${!KEYSTORE_PASS}" --keystore_alias "${!KEYSTORE_ALIAS_ENV}" --key_pass "${!KEYSTORE_KEY_PASS}" --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
        else
            echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --sign_on_appdome --keystore appdome_files/keystore.keystore --keystore_pass "${!KEYSTORE_PASS}" --keystore_alias "${!KEYSTORE_ALIAS_ENV}" --key_pass "${!KEYSTORE_KEY_PASS}" --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
            python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --sign_on_appdome --keystore appdome_files/keystore.keystore --keystore_pass "${!KEYSTORE_PASS}" --keystore_alias "${!KEYSTORE_ALIAS_ENV}" --key_pass "${!KEYSTORE_KEY_PASS}" --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
        fi
    fi
fi