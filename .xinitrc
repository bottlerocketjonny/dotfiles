#!/bin/bash

if [[ $(hostname) == "macbook-air" ]]; then
    echo "Xft.dpi: 96" >> ~/.Xresources
else
    echo "Xft.dpi: 120" >> ~/.Xresources
fi

xrdb -merge ~/.Xresources

