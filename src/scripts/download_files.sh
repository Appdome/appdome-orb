#!/bin/bash


mkdir appdome_files
echo "Downloading android file"
wget "${APPFILE}" -O appdome_files/"$(basename "$APPFILE")"
if [[ -n "${SIGNOVERRIDES}" ]]; then
    echo "Downloading sign overrides"
    echo "${SIGNOVERRIDES}"
    wget "${SIGNOVERRIDES}" -O appdome_files/"$(basename "$SIGNOVERRIDES")"
fi
ls appdome_files


