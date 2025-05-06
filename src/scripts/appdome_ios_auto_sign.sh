#!/bin/bash

echo "Appdome iOS auto sign"
echo -n "${!P12_FILE}" | base64 -d > appdome_files/Cert.p12



# Handle provisioning profiles and entitlements
provisioning_args=""
entitlements_args=""

for i in "" _2 _3 _4; do
    profile_var="PROVISIONING_PROFILES${i}"
    ent_var="ENTITLEMENTS${i}"

    profile_value="${!profile_var}"
    ent_value="${!ent_var}"

    if [[ -n "$profile_value" && -n "$ent_value" ]]; then
        profile_path="appdome_files/provisioning_profile${i}.mobileprovision"
        ent_path="appdome_files/Entitlements${i}.plist"

        echo "Decoding $profile_var and $ent_var"
        echo -n "$profile_value" | base64 -d > "$profile_path"
        echo -n "$ent_value" | base64 -d > "$ent_path"

        provisioning_args+="$profile_path,"
        entitlements_args+="$ent_path,"
    fi
done

# Remove trailing commas
provisioning_args="${provisioning_args%,}"
entitlements_args="${entitlements_args%,}"

# Set entitlements_arg for the command string (as comma-separated list)
if [[ -n "$entitlements_args" ]]; then
    entitlements_arg="--entitlements ${entitlements_args}"
else
    entitlements_arg=""
fi

ls appdome_files
mkdir -p appdome_outputs
VAR="${SIGNOVERRIDES}"

basename=$(basename "$OUTPUT")
extension="${APPFILE##*.}"

if [[ $basename == *.* ]]; then
  echo "Variable already has an extension."
else
  export OUTPUT="${basename}.${extension}"
fi

echo "Output file name: ${OUTPUT}"

ls

if [[ -n "$VAR" ]]; then
    echo "detected sign overrides"
    command="python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --sign_on_appdome --keystore appdome_files/Cert.p12 --keystore_pass ${!P12_PASS} --provisioning_profiles appdome_files/provisioning_profiles.mobileprovision ${entitlements_arg} --sign_overrides appdome_files/$(basename "$SIGNOVERRIDES") --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
else
    echo "no sign overrides"
    command="python3 ./appdome-api-python/appdome-api-python/appdome_api.py --api_key ${!APPDOME_API_KEY} --fusion_set_id ${!FUSIONSET} --app appdome_files/$(basename "$APPFILE") --sign_on_appdome --keystore appdome_files/Cert.p12 --keystore_pass ${!P12_PASS} --provisioning_profiles appdome_files/provisioning_profiles.mobileprovision ${entitlements_arg} --output ./appdome_outputs/${OUTPUT} --certificate_output ./appdome_outputs/certificate.pdf"
fi

if [[ -n "${TEAMID}" ]]; then
    command+=" -t ${TEAMID}"
fi

if [ "${BUILD_WITH_LOGS}" -eq 1 ]; then
    command+=" --diagnostic_logs"
fi

if [[ -n "${BUILD_TO_TEST}" && "${BUILD_TO_TEST}" != "NONE" ]]; then
    command+=" --build_to_test_vendor ${BUILD_TO_TEST,,}"
fi

echo "$command"
eval "$command"