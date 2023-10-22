#!/bin/bash

echo "Appdome Android Auto-DEV private sign"
mkdir appdome_outputs
VAR="${SIGNOVERRIDES}"

basename=$(basename "$OUTPUT")


export OUTPUT="${basename}.sh"


echo "Output file name: ${OUTPUT}"


ls
if [[ -n "$VAR" ]]; then
    echo "detected sign overrides"
    if [ "${GOOGLEPLAYSIGN}" -eq 1 ]; then
        echo "google play sign"
        if [[ -n "${TEAMID}" ]]; then
            command="python3 ./appdome_workspace/appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} -t ${TEAMID} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --auto_dev_private_signing --signing_fingerprint  ${!FINGERPRINT} --sign_overrides appdome_files/$(basename "$SIGNOVERRIDES") --google_play_signing --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
        else
            command="python3 ./appdome_workspace/appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --auto_dev_private_signing --signing_fingerprint  ${!FINGERPRINT} --sign_overrides appdome_files/$(basename "$SIGNOVERRIDES") --google_play_signing --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
        fi
    else
        echo "no google play sign"
        if [[ -n "${TEAMID}" ]]; then
            command="python3 ./appdome_workspace/appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} -t ${TEAMID} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --auto_dev_private_signing --signing_fingerprint  ${!FINGERPRINT} --sign_overrides appdome_files/$(basename "$SIGNOVERRIDES") --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
        else
            command="python3 ./appdome_workspace/appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --auto_dev_private_signing --signing_fingerprint  ${!FINGERPRINT} --sign_overrides appdome_files/$(basename "$SIGNOVERRIDES") --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
        fi
    fi
else
    echo "no sign overrides"
    if [ "${GOOGLEPLAYSIGN}" -eq 1 ]; then
        echo "google play sign"
        if [[ -n "${TEAMID}" ]]; then
            command="python3 ./appdome_workspace/appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} -t ${TEAMID} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --auto_dev_private_signing --signing_fingerprint ${!FINGERPRINT} --google_play_signing --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
        else
            command="python3 ./appdome_workspace/appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --auto_dev_private_signing --signing_fingerprint ${!FINGERPRINT}--google_play_signing --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
        fi
    else
        echo "no google play sign"
        if [[ -n "${TEAMID}" ]]; then
            command="python3 ./appdome_workspace/appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} -t ${TEAMID} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --auto_dev_private_signing --signing_fingerprint ${!FINGERPRINT} --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
        else    
            command="python3 ./appdome_workspace/appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --auto_dev_private_signing --signing_fingerprint ${!FINGERPRINT} --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
        fi
    fi
fi

if [ "${BUILD_WITH_LOGS}" -eq 1 ]; then
    command+=" --diagnostic_logs"
fi

if [[ -n "${BUILD_TO_TEST}" && "${BUILD_TO_TEST}" != "NONE" ]]; then
    command+=" --build_to_test_vendor ${BUILD_TO_TEST,,}"
fi

echo "$command"
eval "$command"