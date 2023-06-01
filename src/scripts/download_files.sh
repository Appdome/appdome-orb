#!/bin/bash


mkdir files
echo 'export ARTIFACTS_LOCATION="~/appdome_workspace/output/"' >> "$BASH_ENV"
echo "Downloading android file"
wget "${APPFILE}" -O files/"$(basename "$APPFILE")"
if [[ -n "${SIGNOVERRIDES}" ]]; then
    echo "Downloading sign overrides"
    echo "${SIGNOVERRIDES}"
    wget "${SIGNOVERRIDES}" -O files/"$(basename "$SIGNOVERRIDES")"
fi
ls files


