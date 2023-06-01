#!/bin/bash


echo "Appdome Android private sign"
mkdir appdome_outputs
VAR="${SIGNOVERRIDES}"
ls
if [[ -n "$VAR" ]]; then
    echo "detected sign overrides"
    if [ "${GOOGLEPLAYSIGN}" -eq 1 ]; then
        echo "google play sign"
        if [[ -n "${TEAMID}" ]]; then
            echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --private_signing --signing_fingerprint  "${!FINGERPRINT}" --sign_overrides appdome_files/"$(basename "$SIGNOVERRIDES")" --google_play_signing --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
            python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --private_signing --signing_fingerprint  "${!FINGERPRINT}" --sign_overrides appdome_files/"$(basename "$SIGNOVERRIDES")" --google_play_signing --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
        else
            echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --private_signing --signing_fingerprint  "${!FINGERPRINT}" --sign_overrides appdome_files/"$(basename "$SIGNOVERRIDES")" --google_play_signing --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
            python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --private_signing --signing_fingerprint  "${!FINGERPRINT}" --sign_overrides appdome_files/"$(basename "$SIGNOVERRIDES")" --google_play_signing --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
        fi
    else
        echo "no google play sign"
        if [[ -n "${TEAMID}" ]]; then
            echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --private_signing --signing_fingerprint  "${!FINGERPRINT}" --sign_overrides appdome_files/"$(basename "$SIGNOVERRIDES")" --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
            python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --private_signing --signing_fingerprint  "${!FINGERPRINT}" --sign_overrides appdome_files/"$(basename "$SIGNOVERRIDES")" --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
        else
            echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --private_signing --signing_fingerprint  "${!FINGERPRINT}" --sign_overrides appdome_files/"$(basename "$SIGNOVERRIDES")" --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
            python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --private_signing --signing_fingerprint  "${!FINGERPRINT}" --sign_overrides appdome_files/"$(basename "$SIGNOVERRIDES")" --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
        fi
    fi
else
    echo "no sign overrides"
    if [ "${GOOGLEPLAYSIGN}" -eq 1 ]; then
        echo "google play sign"
        if [[ -n "${TEAMID}" ]]; then
            echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --private_signing --signing_fingerprint "${!FINGERPRINT}" --google_play_signing --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
            python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --private_signing --signing_fingerprint "${!FINGERPRINT}" --google_play_signing --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
        else
            echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --private_signing --signing_fingerprint "${!FINGERPRINT}" --google_play_signing --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
            python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --private_signing --signing_fingerprint "${!FINGERPRINT}" --google_play_signing --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
        fi
    else
        echo "no google play sign"
        if [[ -n "${TEAMID}" ]]; then
            echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --private_signing --signing_fingerprint "${!FINGERPRINT}" --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
            python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --private_signing --signing_fingerprint "${!FINGERPRINT}" --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
        else
            echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --private_signing --signing_fingerprint "${!FINGERPRINT}" --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
            python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app appdome_files/"$(basename "$APPFILE")" --private_signing --signing_fingerprint "${!FINGERPRINT}" --output ./appdome_outputs/"${OUTPUT}" --certificate_output ./appdome_outputs/certificate.pdf
        fi
    fi
fi