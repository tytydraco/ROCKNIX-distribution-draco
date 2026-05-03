#!/usr/bin/env bash

indocker() {
    docker run \
        --rm --log-driver none \
        -v "$(pwd)":/build \
        -w /build \
        -it \
        -e PROJECT=ROCKNIX \
        -e DEVICE=H700 \
        -e ARCH=aarch64 \
        rocknix-build \
        bash -lc "$@"
}

menuconfig() {
    indocker "make kconfig-menuconfig-H700"
}

makekernel() {
    indocker "./scripts/build linux"
}

makefull() {
    indocker "make H700"
}

clean() {
    indocker "make distclean"
}

saveconfig() {
    cp projects/ROCKNIX/devices/H700/linux/linux.aarch64.conf ../linux.aarch64.conf
}

update() {
    git pull --rebase
}