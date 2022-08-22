#!/bin/sh

command -v git > /dev/null || $(printf ""$(echo "\033[31m")"This program requires git in order to run!"$(echo "[0m")"\n" && exit)
command -v pacman > /dev/null || $(printf ""$(echo "\033[31m")"This program requires you to be using an Arch-based distribution in order to run!"$(echo "[0m")"\n" && exit)

cdsmi() {
	cd $1
	sudo make install
	cd ..
}

compile_from_source() {
	cd /tmp
	git clone https://github.com/LukeSmithXYZ/dmenu
	git clone https://github.com/LukeSmithXYZ/st
	git clone https://git.cbps.xyz/swindlesmccoop/dwm
	git clone https://git.cbps.xyz/swindlesmccoop/dwmblocks
	git clone https://git.cbps.xyz/swindlesmccoop/PKGBUILDS

	cdsmi dmenu
	cdsmi st
	cdsmi dwm
	cdsmi dwmblocks

	cd PKGBUILDs/vgmstream
	makepkg -si
	cd -
}

get_paru() {
	sudo pacman -S --needed base-devel
	git clone https://aur.archlinux.org/paru.git
	cd paru
	makepkg -si
}

get_deps() {
	paru -Sy
	paru -S --needed < packages.txt
	pip install i3ipc ueberzug
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
