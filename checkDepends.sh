#!/bin/bash

# Put your dependencies below.

depends="autotools python rsync tar makeinfo pkg-config doxygen pandoc gettext libiconv libz libgnutls libidn2 flex libpsl gcc"

# If you want to install automaticly missing packages set autoInstall variable to "y".

autoInstall="n"

missing=""

function installMissing() {
    command -v yum > /dev/null && packageManager="yum" || packageManager="apt"
    $packageManager update -y && $packageManager install -y $missing
}

for package in ${depends}; do
    hash $package 2>/dev/null
    if [ $? -ne 0 ]; then
        missing="$missing $package"
    fi
done

echo "Missing packages;"
echo ${missing}

if [${autoInstall,,} -eq "y"]; then
    [ -z $missing ] && exit 0 || installMissing
fi

