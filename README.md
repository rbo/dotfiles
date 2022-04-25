# My dotfiles of my Fedora Silverblue workstation

with sway & co

![Screenshot](screenshot.png)

```
git clone git@github.com:rbo/dotfiles.git
./install
```

Based on https://github.com/anishathalye/dotbot

And my Fedora Toolbox: https://github.com/rbo/fedora-toolbox

## My current `rpm-ostree status`

```bash
$ rpm-ostree status
State: idle
Deployments:
● fedora:fedora/35/x86_64/silverblue
                   Version: 35.20220413.0 (2022-04-13T14:52:30Z)
                BaseCommit: b64f41b66e13b6dbdf62e6e267be25eac1da5a9d1870c5e20a97d108f0d04c6e
              GPGSignature: Valid signature by 787EA6AE1147EEE56C40B30CDB4639719867C58F
           LayeredPackages: arm-image-installer borgbackup.x86_64 brightlight code dunst feh ffmpeg
                            firefox-wayland fontawesome-fonts-web.noarch fontawesome-fonts.noarch git
                            gnome-boxes google-chrome-stable grim hdparm htop ImageMagick imv iotop
                            kitty libva-utils libvirt libvirt-daemon-config-network maim mako minicom
                            NetworkManager-tui.x86_64 nnn nordvpn pavucontrol powerline-fonts pv
                            python3-pip redhat-display-fonts.noarch redhat-text-fonts.noarch screen
                            slurp strace swappy sway swaybg swayidle swaylock texlive-fontawesome.noarch
                            tmux vim virt-manager.noarch virt-viewer waybar wdisplays wev
                            wf-recorder.x86_64 wofi xdg-desktop-portal-wlr yubico-piv-tool
             LocalPackages: nordvpn-release-1.0.0-1.noarch rpmfusion-free-release-35-1.noarch
                            rpmfusion-nonfree-release-35-1.noarch

  fedora:fedora/35/x86_64/silverblue
                   Version: 35.20220413.0 (2022-04-13T14:52:30Z)
                BaseCommit: b64f41b66e13b6dbdf62e6e267be25eac1da5a9d1870c5e20a97d108f0d04c6e
              GPGSignature: Valid signature by 787EA6AE1147EEE56C40B30CDB4639719867C58F
           LayeredPackages: arm-image-installer borgbackup.x86_64 brightlight code dunst feh ffmpeg
                            firefox-wayland fontawesome-fonts-web.noarch fontawesome-fonts.noarch git
                            gnome-boxes google-chrome-stable grim htop ImageMagick imv iotop kitty
                            libva-utils libvirt libvirt-daemon-config-network maim mako minicom
                            NetworkManager-tui.x86_64 nnn nordvpn pavucontrol powerline-fonts pv
                            python3-pip redhat-display-fonts.noarch redhat-text-fonts.noarch screen
                            slurp strace swappy sway swaybg swayidle swaylock texlive-fontawesome.noarch
                            tmux vim virt-manager.noarch virt-viewer waybar wdisplays wev
                            wf-recorder.x86_64 wofi xdg-desktop-portal-wlr yubico-piv-tool
             LocalPackages: nordvpn-release-1.0.0-1.noarch rpmfusion-free-release-35-1.noarch
                            rpmfusion-nonfree-release-35-1.noarch
```

## Keyboard setup

```
$ localectl  set-x11-keymap us pc105 altgr-intl caps:escape
$ localectl
   System Locale: LANG=en_US.utf8
       VC Keymap: us-altgr-intl
      X11 Layout: us
       X11 Model: pc105
     X11 Variant: altgr-intl
     X11 Options: caps:escape

# if needed per session
$ setxkbmap -layout us -variant altgr-intl
```

### Apply keyboard settings:

```
  echo "1" > /sys/module/hid_apple/parameters/swap_opt_cmd
```

## Setup polkit for libvirt

Polkit
https://goldmann.pl/blog/2012/12/03/configuring-polkit-in-fedora-18-to-access-virt-manager/

/etc/polkit-1/rules.d/80-libvirt-manage.rules
polkit.addRule(function(action, subject) {
      if (action.id == "org.libvirt.unix.manage" && subject.local &&
        subject.active && subject.isInGroup("wheel")) {
              return polkit.Result.YES;
                }
});
