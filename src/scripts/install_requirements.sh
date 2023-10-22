#!/bin/bash

ls "$ROOT_DIR/appdome_workspace/appdome-api-python/"
git pull
pip3 install -r "$ROOT_DIR/appdome_workspace/requirements.txt"
sudo apt install wget