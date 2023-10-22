#!/bin/bash
echo "Appdome Android Auto Sign"
mkdir appdome_outputs
echo -n "${!KEYSTORE}" | base64 -d > appdome_files/keystore.keystore
ls appdome_files
VAR="${SIGNOVERRIDES}"

basename=$(basename "$OUTPUT")
extension="${APPFILE##*.}"


if [[ $basename == *.* ]]; then
  echo "Variable already has an extension."
else
  # Concatenate the extension of the APPFILE
  export OUTPUT="${basename}.${extension}"
fi

echo "Output file name: ${OUTPUT}"

if [[ -n "$VAR" ]]; then
    echo "detected sign overrides"
    if [ "${GOOGLEPLAYSIGN}" -eq 1 ]; then
        echo "google play sign"
        if [[ -n "${TEAMID}" ]]; then
            command="python3 $ROOT_DIR/appdome_workspace/appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} -t ${TEAMID} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --sign_on_appdome --keystore appdome_files/keystore.keystore --keystore_pass ${!KEYSTORE_PASS} --keystore_alias ${!KEYSTORE_ALIAS_ENV} --key_pass ${!KEYSTORE_KEY_PASS} --sign_overrides appdome_files/$(basename "$SIGNOVERRIDES") --google_play_signing --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
        else
            command="python3 $ROOT_DIR/appdome_workspace/appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --sign_on_appdome --keystore appdome_files/keystore.keystore --keystore_pass ${!KEYSTORE_PASS} --keystore_alias ${!KEYSTORE_ALIAS_ENV} --key_pass ${!KEYSTORE_KEY_PASS} --sign_overrides appdome_files/$(basename "$SIGNOVERRIDES") --google_play_signing --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
        fi
    else
        echo "no google play sign"
        if [[ -n "${TEAMID}" ]]; then
            command="python3 $ROOT_DIR/appdome_workspace/appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} -t ${TEAMID} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --sign_on_appdome --keystore appdome_files/keystore.keystore --keystore_pass ${!KEYSTORE_PASS} --keystore_alias ${!KEYSTORE_ALIAS_ENV} --key_pass ${!KEYSTORE_KEY_PASS} --sign_overrides appdome_files/$(basename "$SIGNOVERRIDES") --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
        else
            command="python3 $ROOT_DIR/appdome_workspace/appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --sign_on_appdome --keystore appdome_files/keystore.keystore --keystore_pass ${!KEYSTORE_PASS} --keystore_alias ${!KEYSTORE_ALIAS_ENV} --key_pass ${!KEYSTORE_KEY_PASS} --sign_overrides appdome_files/$(basename "$SIGNOVERRIDES") --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
        fi
    fi
else
    echo "no sign overrides"
    if [ "${GOOGLEPLAYSIGN}" -eq 1 ]; then
        echo "google play sign"
        if [[ -n "${TEAMID}" ]]; then
            command="python3 $ROOT_DIR/appdome_workspace/appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} -t ${TEAMID} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --google_play_signing --sign_on_appdome --keystore appdome_files/keystore.keystore --keystore_pass ${!KEYSTORE_PASS} --keystore_alias ${!KEYSTORE_ALIAS_ENV} --key_pass ${!KEYSTORE_KEY_PASS} --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
        else
            command="python3 $ROOT_DIR/appdome_workspace/appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --google_play_signing --sign_on_appdome --keystore appdome_files/keystore.keystore --keystore_pass ${!KEYSTORE_PASS} --keystore_alias ${!KEYSTORE_ALIAS_ENV} --key_pass ${!KEYSTORE_KEY_PASS} --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
        fi
    else
        echo "no google play sign"
        if [[ -n "${TEAMID}" ]]; then
            command="python3 $ROOT_DIR/appdome_workspace/appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} -t ${TEAMID} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --sign_on_appdome --keystore appdome_files/keystore.keystore --keystore_pass ${!KEYSTORE_PASS} --keystore_alias ${!KEYSTORE_ALIAS_ENV} --key_pass ${!KEYSTORE_KEY_PASS} --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
        else
            command="python3 $ROOT_DIR/appdome_workspace/appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --sign_on_appdome --keystore appdome_files/keystore.keystore --keystore_pass ${!KEYSTORE_PASS} --keystore_alias ${!KEYSTORE_ALIAS_ENV} --key_pass ${!KEYSTORE_KEY_PASS} --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
        fi
    fi
fi

if [ "${BUILD_WITH_LOGS}" -eq 1 ]; then
    command+=" --diagnostic_logs"
fi

if [ "${SECOND_OUTPUT}" -eq 1 ]; then
    command+=" --sign_second_output ./appdome_outputs/Appdome_Universal_App.apk"
fi

if [[ -n "${BUILD_TO_TEST}" && "${BUILD_TO_TEST}" != "NONE" ]]; then
    command+=" --build_to_test_vendor ${BUILD_TO_TEST,,}"
fi


echo "$command"
eval "$command"