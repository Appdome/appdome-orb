#!/bin/bash


mkdir files
echo "export ARTIFACTS_LOCATION=\"/home/circleci/appdome_workspace/output\"" >> "$BASH_ENV"
echo "ARTIFACTS_LOCATION is set to: $ARTIFACTS_LOCATION"
echo "Downloading android file"
wget "${APPFILE}" -O files/"$(basename "$APPFILE")"
if [[ -n "${SIGNOVERRIDES}" ]]; then
    echo "Downloading sign overrides"
    echo "${SIGNOVERRIDES}"
    wget "${SIGNOVERRIDES}" -O files/"$(basename "$SIGNOVERRIDES")"
fi
ls files


