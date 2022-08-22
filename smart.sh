#!/bin/sh

if ! command -v git > /dev/null; then
	printf "\033[0;31mThis program requires git in order to run!\n" && exit
fi

get_repos() {
	git clone https://github.com/lukesmithxyz/dmenu
	git clone https://github.com/lukesmithxyz/st
}

bootstrap() {
	echo "Any programs that have configuration files in my repo will overwrite any existing ones in ~/.config."
	read -r -p "Continue? (y/n): " CONT
	[ "$CONT" = y ] || $(echo "Invalid input or user has terminated!" && exit)

	cd /tmp
	git clone https://git.cbps.xyz/swindlesmccoop/not-just-dotfiles --recurse-submodules
	cd not-just-dotfiles
	cp -r .config/* "$HOME/.config/"
	cp -r .local/* "$HOME/.local/"
	sudo cp .zprofile /etc/zsh/zshenv || echo "You do not have sudo permission! Skipping zsh env."
}

dwm_route() {
	git clone https://git.cbps.xyz/swindlesmccoop/dwm
	git clone https://git.cbps.xyz/swindlesmccoop/dwmblocks
}




i3wm_route() {
	printf "hi\n"
}


bspwm_route() {
	printf "hi\n"
}

printf "HI\n"
