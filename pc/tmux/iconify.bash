#!/bin/bash
if [[ "$1" == "nvim" ]]; then
	echo " NeoVim"
elif [[ "$1" == "ssh" ]]; then
	echo " SSH"
elif [[ "$1" == "nano" ]]; then
	echo " Nano"
elif [[ "$1" == *"cargo"* ]]; then
	echo "󱘗 Rust Cargo"
elif [[ "$1" == "npm" ]]; then
	echo " NPM"
elif [[ "$1" == "mpv" ]]; then
	echo " MPV"
elif [[ "$1" == "zsh" ]]; then
	echo "  ZSH"
elif [[ "$1" == "lazygit" ]]; then
	echo " Lazygit"
elif [[ "$1" == "btop" || "$1" == "top" || "$1" == "htop" ]]; then
	echo " Process manager"
else
	echo "  $1"
fi
