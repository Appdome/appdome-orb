#!/bin/bash

echo "Appdome Android Auto-DEV private sign"
mkdir output
VAR="${SIGNOVERRIDES}"
if  ${BUILD_WITH_LOGS} ; then
	BUILD_WITH_LOGS="-build_with_logs"
fi

echo $BUILD_WITH_LOGS
ls
if [[ -n "$VAR" ]]; then
    echo "detected sign overrides"
    if [ "${GOOGLEPLAYSIGN}" -eq 1 ]; then
        echo "google play sign"
        if [[ -n "${TEAMID}" ]]; then
            echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --auto_dev_private_signing --signing_fingerprint  "${!FINGERPRINT}" --sign_overrides files/"$(basename "$SIGNOVERRIDES")" --google_play_signing --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
            python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --auto_dev_private_signing --signing_fingerprint  "${!FINGERPRINT}" --sign_overrides files/"$(basename "$SIGNOVERRIDES")" --google_play_signing --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
        else
            echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --auto_dev_private_signing --signing_fingerprint  "${!FINGERPRINT}" --sign_overrides files/"$(basename "$SIGNOVERRIDES")" --google_play_signing --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
            python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --auto_dev_private_signing --signing_fingerprint  "${!FINGERPRINT}" --sign_overrides files/"$(basename "$SIGNOVERRIDES")" --google_play_signing --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
        fi
    else
        echo "no google play sign"
        if [[ -n "${TEAMID}" ]]; then
            echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --auto_dev_private_signing --signing_fingerprint  "${!FINGERPRINT}" --sign_overrides files/"$(basename "$SIGNOVERRIDES")" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
            python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --auto_dev_private_signing --signing_fingerprint  "${!FINGERPRINT}" --sign_overrides files/"$(basename "$SIGNOVERRIDES")" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
        else
            echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --auto_dev_private_signing --signing_fingerprint  "${!FINGERPRINT}" --sign_overrides files/"$(basename "$SIGNOVERRIDES")" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
            python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --auto_dev_private_signing --signing_fingerprint  "${!FINGERPRINT}" --sign_overrides files/"$(basename "$SIGNOVERRIDES")" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
        fi
    fi
else
    echo "no sign overrides"
    if [ "${GOOGLEPLAYSIGN}" -eq 1 ]; then
        echo "google play sign"
        if [[ -n "${TEAMID}" ]]; then
            echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --auto_dev_private_signing --signing_fingerprint "${!FINGERPRINT}" --google_play_signing --output ./output"${OUTPUT}" --certificate_output ./output/certificate.pdf
            python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --auto_dev_private_signing --signing_fingerprint "${!FINGERPRINT}" --google_play_signing --output ./output"${OUTPUT}" --certificate_output ./output/certificate.pdf
        else
            echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --auto_dev_private_signing --signing_fingerprint "${!FINGERPRINT}" --google_play_signing --output ./output"${OUTPUT}" --certificate_output ./output/certificate.pdf
            python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --auto_dev_private_signing --signing_fingerprint "${!FINGERPRINT}" --google_play_signing --output ./output"${OUTPUT}" --certificate_output ./output/certificate.pdf
        fi
    else
        echo "no google play sign"
        if [[ -n "${TEAMID}" ]]; then
            echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --auto_dev_private_signing --signing_fingerprint "${!FINGERPRINT}" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
            python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" -t "${TEAMID}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --auto_dev_private_signing --signing_fingerprint "${!FINGERPRINT}" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
        else    
            echo python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --auto_dev_private_signing --signing_fingerprint "${!FINGERPRINT}" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
            python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key "${!APPDOME_API_KEY}" --fusion_set_id "${!FUSIONSET}" --app files/"$(basename "$APPFILE")" --auto_dev_private_signing --signing_fingerprint "${!FINGERPRINT}" --output ./output/"${OUTPUT}" --certificate_output ./output/certificate.pdf
        fi
    fi
fi