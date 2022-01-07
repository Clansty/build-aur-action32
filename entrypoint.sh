#!/bin/bash

pkgname=$1

yay -Syu

useradd builder -m
echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
git clone https://aur.archlinux.org/$pkgname.git
cd $pkgname
source PKGBUILD
chmod -R a+rw .

sudo --set-home -u builder yay -S --noconfirm --needed --asdeps "${makedepends[@]}" "${depends[@]}"
sudo --set-home -u builder CARCH=aarch64 makepkg -sfA

cd $pkgname
echo ::set-output name=filelist::$(sudo --set-home -u builder makepkg --packagelist | xargs)
