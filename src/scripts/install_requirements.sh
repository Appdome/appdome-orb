#!/bin/bash

ls "$ROOT_DIR/appdome_workspace/"
pip3 install -r "$ROOT_DIR/appdome_workspace/appdome-api-python/requirements.txt"
sudo apt install wget