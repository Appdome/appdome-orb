#!/bin/bash


mkdir files
echo "Downloading android file"
wget "${APPFILE}" -O files/"$(basename "$APPFILE")"
if [[ -n "${SIGNOVERRIDES}" ]]; then
    echo "Downloading sign overrides"
    echo "${SIGNOVERRIDES}"
    wget "${SIGNOVERRIDES}" -O files/"$(basename "$SIGNOVERRIDES")"
fi
ls files


