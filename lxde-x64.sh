#!/bin/bash
DESKTOP="lxde"
echo "========================="
echo "| ${DESKTOP} VOID x86_64    |"
echo " ------------------------"
CURRENT=https://voidlinux.com.br/repo/current
MUTILIB=https://voidlinux.com.br/repo/current/multilib
NONFREE=https://voidlinux.com.br/repo/current/nonfree
FILENAME="void-live-${DESKTOP}-unofficial"
DATE=$(date +%Y%m%d)
KERNEL=$(uname -r)
BUILDDIR="$(pwd)/build"

#shift $((OPTIND - 1))

#: ${ARCH:=$(uname -m)}

sudo ./mklive.sh \
    -a x86_64 \
    -r ${CURRENT} \
#    -r ${MUTILIB} \
    -r ${NONFREE} \
    -p "$(grep '^[^#].' ${DESKTOP}-x64.packages)" \
    -T "Void Linux ${DESKTOP} Unofficial" \
    -o ${FILENAME}-x86_64-${KERNEL}-${DATE}.iso \
    -S "acpid dbus dhcpcd wpa_supplicant lxdm polkitd"

if [ ! -f ${FILENAME}-x86_64-${KERNEL}-${DATE}.iso ];then
    retries=${1}
    until [[ $retries -gt 2 ]];do
        echo "Retrying build ${retries}" 
        ((retries++))
        bash ${0} ${retries}

    done
    if [[ ! -f ${FILENAME}-x86_64-${KERNEL}-${DATE}.iso ]];then    
        echo "Error: ${FILENAME}-x86_64-${KERNEL}-${DATE}.iso : does not exist! Aborting!"
        echo "ERR=1" > error-status.txt
        exit 1
    fi
fi

sha256sum ${FILENAME}-x86_64-${KERNEL}-${DATE}.iso >> sha256sums.txt

if [ ! -f sha256sums.txt ];then
    echo "Missing checksum file, aborting!"
    echo "ERR=1" > error-status.txt
    exit 1
fi

if [ ! -d "${BUILDDIR}" ];then
    mkdir ${BUILDDIR}
fi

#mv ${FILENAME}-x86_64-${KERNEL}-${DATE}.iso build
