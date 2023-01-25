#!/bin/sh

ARCH=
IMAGE=

while getopts "a:b:v:s:I:hr:" opt; do
case $opt in
	a) ARCH="$OPTARG";;
	b) IMAGE="$OPTARG";;
	v) LINUX_VERSION="$OPTARG";;
	S) SERVICE_LIST="$OPTARG";;
	I) INCLUDE_DIRECTORY="$OPTARG";;
	h) echo "${0#/*}: [-a arch] [-b base|e|xfce|mate|cinnamon|gnome|kde|lxde|lxqt|openbox|jwm|fluxboxwm|blackboxwm|bspwm|herbstluftwm] [-r repo]" >&2; exit 1;;
	r) REPO="-r $OPTARG $REPO";;
esac
done
shift $((OPTIND - 1))

: ${ARCH:=$(uname -m)}

readonly DATE=$(date +%Y%m%d)
readonly BASE_IMG=void-live-${ARCH}-${DATE}.iso
readonly E_IMG=void-live-${ARCH}-${DATE}-enlightenment.iso
readonly XFCE_IMG=void-live-${ARCH}-${DATE}-xfce.iso
readonly MATE_IMG=void-live-${ARCH}-${DATE}-mate.iso
readonly CINNAMON_IMG=void-live-${ARCH}-${DATE}-cinnamon.iso
readonly GNOME_IMG=void-live-${ARCH}-${DATE}-gnome.iso
readonly KDE_IMG=void-live-${ARCH}-${DATE}-kde.iso
readonly LXDE_IMG=void-live-${ARCH}-${DATE}-lxde.iso
readonly LXQT_IMG=void-live-${ARCH}-${DATE}-lxqt.iso
readonly OPENBOX_IMG=void-live-${ARCH}-${DATE}-openbox.iso
readonly JWM_IMG=void-live-${ARCH}-${DATE}-jwm.iso
readonly FLUXBOXWM_IMG=void-live-${ARCH}-${DATE}-fluxboxwm.iso 
readonly BLACKBOXWM_IMG=void-live-${ARCH}-${DATE}-blackboxwm.iso
readonly BSPWM_IMG=void-live-${ARCH}-${DATE}-bspwm.iso
readonly HERBSTLUFTWM_IMG=void-live-${ARCH}-${DATE}-herbstluftwm.iso

readonly GRUB="grub-i386-efi grub-x86_64-efi"

readonly BASE_PKGS="dialog kmod cryptsetup lvm2 mdadm fuzzypkg vpm void-docs-browse xdg-user-dirs papirus-icon-theme plata-theme gsettings-desktop-schemas ntfs-3g fuse-exfat exfat-utils $GRUB"
readonly KERNEL_VERSION="linux5.15"
readonly X_PKGS="$BASE_PKGS xorg-minimal xorg-input-drivers xorg-video-drivers setxkbmap xauth font-misc-misc terminus-font dejavu-fonts-ttf alsa-plugins-pulseaudio xdg-utils xdg-user-dirs xterm"
readonly E_PKGS="$X_PKGS lxdm enlightenment terminology udisks2 firefox-esr"
readonly XFCE_PKGS="$X_PKGS lxdm xfce4 gnome-themes-standard gnome-keyring network-manager-applet gvfs-afc gvfs-mtp gvfs-smb udisks2 firefox-esr"
readonly MATE_PKGS="$X_PKGS lxdm mate mate-extra gnome-keyring network-manager-applet gvfs-afc gvfs-mtp gvfs-smb udisks2 firefox-esr"
readonly CINNAMON_PKGS="$X_PKGS lxdm cinnamon gnome-keyring colord gnome-terminal gvfs-afc gvfs-mtp gvfs-smb udisks2 firefox-esr"
readonly GNOME_PKGS="$X_PKGS gnome gnome-terminal firefox-esr"
readonly KDE_PKGS="$X_PKGS kde5 konsole firefox dolphin"
readonly LXDE_PKGS="$X_PKGS $KERNEL_VERSION lxdm  gvfs-afc gvfs-mtp gvfs-smb udisks2 network-manager-applet firefox-esr openbox pcmanfm lxde-icon-theme lxde-common lxappearance lxsession lxterminal lxlauncher lxinput lxrandr lxpanel lxtask gpicview upower"
readonly LXQT_PKGS="$X_PKGS lxdm lxqt gvfs-afc gvfs-mtp gvfs-smb udisks2 network-manager-applet qupzilla"
readonly OPENBOX_PKGS="$X_PKGS lxdm openbox libopenbox obmenu-generator pcmanfm gvfs-afc gvfs-mtp gvfs-smb udisks2 network-manager-applet firefox-esr tint2 lxappearance obconf nitrogen menumaker xdgmenumaker"
readonly JWM_PKGS="$X_PKGS lxdm jwm jwm-settings-manager obmenu-generator pcmanfm gvfs-afc gvfs-mtp gvfs-smb udisks2 network-manager-applet firefox-esr nitrogen menumaker xdgmenumaker"
readonly FLUXBOXWM_PKGS="$X_PKGS lxdm fluxbox gvfs-afc gvfs-mtp gvfs-smb udisks2 network-manager-applet pcmanfm chromium volumeicon cbatticon terminator"
readonly BLACKBOXWM_PKGS="$X_PKGS lxdm blackboxwm gvfs-afc gvfs-mtp gvfs-smb udisks2 network-manager-applet pcmanfm chromium obkeys"
readonly BSPWM_PKGS="X_PKGS lxdm bspwm sxhkd gvfs-afc gvfs-mtp gvfs-smb udisks2 network-manager-applet pcmanfm firefox-esr volumeicon tint2 tint2conf st nitrogen lxappearance rofi picom"
readonly HERBSTLUFTWM_PKGS="$X_PKGS lxdm herbstluftwm gvfs-afc gvfs-mtp gvfs-smb udisks2 network-manager-applet pcmanfm firefox-esr sakura lxappearance picom dzen2 dmenu"

[ ! -x mklive.sh ] && exit 0

if [ -z "$IMAGE" -o "$IMAGE" = base ]; then
	if [ ! -e $BASE_IMG ]; then
		./mklive.sh -a $ARCH -o $BASE_IMG -p "$BASE_PKGS" ${REPO} "$@"
	fi
fi
if [ -z "$IMAGE" -o "$IMAGE" = e ]; then
	if [ ! -e $E_IMG ]; then
		./mklive.sh -a $ARCH -o $E_IMG -p "$E_PKGS" ${REPO} "$@"
	fi
fi
if [ -z "$IMAGE" -o "$IMAGE" = xfce ]; then
	if [ ! -e $XFCE_IMG ]; then
		./mklive.sh -a $ARCH -o $XFCE_IMG -p "$XFCE_PKGS" ${REPO} "$@"
	fi
fi
if [ -z "$IMAGE" -o "$IMAGE" = mate ]; then
	if [ ! -e $MATE_IMG ]; then
		./mklive.sh -a $ARCH -o $MATE_IMG -p "$MATE_PKGS" ${REPO} "$@"
	fi
fi
if [ -z "$IMAGE" -o "$IMAGE" = cinnamon ]; then
	if [ ! -e $CINNAMON_IMG ]; then
		./mklive.sh -a $ARCH -o $CINNAMON_IMG -p "$CINNAMON_PKGS" ${REPO} "$@"
	fi
fi

if [ -z "$IMAGE" -o "$IMAGE" = gnome ]; then
	if [ ! -e $GNOME_IMG ]; then
		./mklive.sh -a $ARCH -o $GNOME_IMG -p "$GNOME_PKGS" ${REPO} "$@"
	fi
fi

if [ -z "$IMAGE" -o "$IMAGE" = lxde ]; then
	if [ ! -e $LXDE_IMG ]; then
		./mklive.sh -a $ARCH -o $LXDE_IMG -p "$LXDE_PKGS" ${REPO} "$@" -S "lxdm NetworkManager dbus" -v "linux5.15"
	fi
fi
if [ -z "$IMAGE" -o "$IMAGE" = lxqt ]; then
	if [ ! -e $LXQT_IMG ]; then
		./mklive.sh -a $ARCH -o $LXQT_IMG -p "$LXQT_PKGS" ${REPO} "$@"
	fi
fi
if [ -z "$IMAGE" -o "$IMAGE" = kde ]; then
	if [ ! -e $KDE_IMG ]; then
		./mklive.sh -a $ARCH -o $KDE_IMG -p "$KDE_PKGS" ${REPO} "$@"
    fi
fi
if [ -z "$IMAGE" -o "$IMAGE" = openbox ]; then
	if [ ! -e $OPENBOX_IMG ]; then
		./mklive.sh -a $ARCH -o $OPENBOX_IMG -p "$OPENBOX_PKGS" ${REPO} "$@"
	fi
fi
if [ -z "$IMAGE" -o "$IMAGE" = jwm ]; then
	if [ ! -e $JWM_IMG ]; then
		./mklive.sh -a $ARCH -o $JWM_IMG -p "$JWM_PKGS" ${REPO} "$@"
	fi
fi
if [ -z "$IMAGE" -o "$IMAGE" = blackboxwm ]; then
	if [ ! -e $BLACKBOXWM_IMG ]; then
		./mklive.sh -a $ARCH -o $BLACKBOXWM_IMG -p "$BLACKBOXWM_PKGS" ${REPO} "$@"
	fi
fi
if [ -z "$IMAGE" -o "$IMAGE" = fluxboxwm ]; then
	if [ ! -e $FLUXBOXWM_IMG ]; then
		./mklive.sh -a $ARCH -o $FLUXBOXWM_IMG -p "$FLUXBOXWM_PKGS" ${REPO} "$@" -S "NetworkManager dbus"
	fi
fi
if [ -z "$IMAGE" -o "$IMAGE" = bspwm ]; then
	if [ ! -e $BSPWM_IMG ]; then
		./mklive.sh -a $ARCH -o $BSPWM_IMG -p "$BSPWM_PKGS" ${REPO} "$@" -S "NetworkManager dbus" -I ""
	fi
fi
if [ -z "$IMAGE" -o "$IMAGE" = herbstluftwm ]; then
        if [ ! -e $HERBSTLUFTWM_IMG ]; then
                ./mklive.sh -a $ARCH -o $HERBSTLUFTWM_IMG -p $"HERBSTLUFTWM_PKGS" "${REPO} "$@" -S "NetworkManager dbus"
        fi
