# My dotfiles

```
git clone git@github.com:rbo/dotfiles.git
./install 
```

Based on https://github.com/anishathalye/dotbot


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
