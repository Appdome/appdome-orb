#!/bin/bash


mkdir -p appdome_files
echo "Downloading android file"
if [[ "${APPFILE}" == http* ]]; then
    wget "${APPFILE}" -O appdome_files/"$(basename "$APPFILE")"
else
    ls -la "${APPFILE}" --ignore=filename
fi

if [[ -n "${SIGNOVERRIDES}" ]]; then
    echo "Downloading sign overrides"
    echo "${SIGNOVERRIDES}"
    wget "${SIGNOVERRIDES}" -O appdome_files/"$(basename "$SIGNOVERRIDES")"
fi
ls appdome_files


