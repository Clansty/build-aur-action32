FROM fdupoux/archlinux32:latest

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN date

WORKDIR /tmp
COPY pacman.conf /etc/pacman.conf

RUN pacman-key --init
RUN pacman -Syu --noconfirm base-devel git nodejs-lts-gallium jdk11-openjdk go yay



COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"] 
