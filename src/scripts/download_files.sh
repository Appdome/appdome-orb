#!/bin/bash


mkdir files
echo "Downloading android file"
if [[ "${APPFILE}" == http* ]]; then
    wget "${APPFILE}" -O files/"$(basename "$APPFILE")"
else
    cp "${APPFILE}" files/
fi

if [[ -n "${SIGNOVERRIDES}" ]]; then
    echo "Downloading sign overrides"
    echo "${SIGNOVERRIDES}"
    wget "${SIGNOVERRIDES}" -O files/"$(basename "$SIGNOVERRIDES")"
fi
ls files


