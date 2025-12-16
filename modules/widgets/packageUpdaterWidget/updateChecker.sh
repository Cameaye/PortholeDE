#!/bin/bash

# Official repos
updates=$(checkupdates 2>/dev/null | wc -l)

# AUR (optional)
aur_updates=$(yay -Qua 2>/dev/null | wc -l)

echo $((updates + aur_updates))
