#!/usr/bin/env bash

flameshot gui --raw | convert -resize 400% png:- png:- | tesseract -l ara stdin stdout | xclip -selection clipboard