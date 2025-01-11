#!/bin/bash

TERM=xterm-256color
APP=$(echo -e "Note\nNeovim\nFirefox\nThunar\nAlacritty\nBluetooth\nLock\nWhatsApp\nReddit\nTwitter\nChatGPT\nFosstodon\nGitHub\nI USE ARCH BTW" | fzf --reverse --border rounded)

if [[ "$APP" == "Neovim" ]]; then
	setsid alacritty -e nvim &
	sleep 0.1
elif [[ "$APP" == "Note" ]]; then
	nvim ~/notes/notes.txt
	sleep 0.1
elif [[ "$APP" == "Firefox" ]]; then
	setsid firefox &
	sleep 0.1
elif [[ "$APP" == "Thunar" ]]; then
	setsid thunar &
	sleep 0.1
elif [[ "$APP" == "Alacritty" ]]; then
	setsid alacritty > /dev/null 2>&1 &
	sleep 0.1
elif [[ "$APP" == "Bluetooth" ]]; then
	setsid blueman-manager &
	sleep 0.1
elif [[ "$APP" == "WhatsApp" ]]; then
	firefox --new-tab --url "web.whatsapp.com"
	sleep 0.1
elif [[ "$APP" == "Reddit" ]]; then
	firefox --new-tab --url "reddit.com"
	sleep 0.1
elif [[ "$APP" == "Twitter" ]]; then
	firefox --new-tab --url "x.com"
	sleep 0.1
elif [[ "$APP" == "ChatGPT" ]]; then
	firefox --new-tab --url "chatgpt.com"
	sleep 0.1
elif [[ "$APP" == "Fosstodon" ]]; then
	firefox --new-tab --url "fosstodon.com"
	sleep 0.1
elif [[ "$APP" == "GitHub" ]]; then
	firefox --new-tab --url "github.com"
	sleep 0.1
elif [[ "$APP" == "I USE ARCH BTW" ]]; then
	neofetch
	sleep 5
fi
