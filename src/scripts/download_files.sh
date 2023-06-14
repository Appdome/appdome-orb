#!/bin/bash


mkdir appdome_files
echo "Downloading android file"


mkdir -p appdome_files
echo "Downloading android file"
if [[ "${APPFILE}" == http* ]]; then
    wget "${APPFILE}" -O appdome_files/"$(basename "$APPFILE")"
else
    ls -la "${APPFILE}"
    cp "${APPFILE}" appdome_files/
fi


if [[ -n "${SIGNOVERRIDES}" ]]; then
    echo "Downloading sign overrides"
    echo "${SIGNOVERRIDES}"
    wget "${SIGNOVERRIDES}" -O appdome_files/"$(basename "$SIGNOVERRIDES")"
fi
ls appdome_files


