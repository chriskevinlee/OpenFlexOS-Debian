#!/bin/bash

source /home/$USER/.config/qtile/scripts/sound.sh

chosen=$(printf " Lock\n󰍃 Logout\n󰜉 Reboot\n Suspend\n Hibernate\n⏻ PowerOff\n" | rofi -config /home/$USER/.config/qtile/rofi/config.rasi -dmenu -p "Power" -i -theme-str)

case "$chosen" in
    " Lock")
        yes_no=$(printf " no\n yes" | rofi -config /home/$USER/.config/qtile/rofi/config.rasi -dmenu -p "Would You Like to $chosen" -i -theme-str)
        case $yes_no in
            [no]* ) exit;;
            [yes]* )
                if [[ "$active_sounds" = yes && ! -z "$lock_sound" && -f "${sounds_dir}${lock_sound}" ]]; then
                    mpv --no-video "${sounds_dir}${lock_sound}" && xscreensaver-command -lock
                else
                    xscreensaver-command -lock
                fi
                ;;
        esac
        ;;
    "󰍃 Logout")
        yes_no=$(printf " no\n yes" | rofi -config /home/$USER/.config/qtile/rofi/config.rasi -dmenu -p "Would You Like to $chosen" -i -theme-str)
        case $yes_no in
            [no]* ) exit;;
            [yes]* )
                if [[ "$active_sounds" = yes && ! -z "$logout_sound" && -f "${sounds_dir}${logout_sound}" ]]; then
                    mpv --no-video "${sounds_dir}${logout_sound}" && qtile cmd-obj -o cmd -f shutdown
                else
                    qtile cmd-obj -o cmd -f shutdown
                    
                fi
                ;;
        esac
        ;;
    "󰜉 Reboot")
        yes_no=$(printf " no\n yes" | rofi -config /home/$USER/.config/qtile/rofi/config.rasi -dmenu -p "Would You Like to $chosen" -i -theme-str)
        case $yes_no in
            [no]* ) exit;;
            [yes]* )
                if [[ "$active_sounds" = yes && ! -z "$reboot_sound" && -f "${sounds_dir}${reboot_sound}" ]]; then
                    mpv --no-video "${sounds_dir}${reboot_sound}" && /sbin/reboot
                else
                    /sbin/reboot
                fi
                ;;
        esac
        ;;
    " Suspend")
        yes_no=$(printf " no\n yes" | rofi -config /home/$USER/.config/qtile/rofi/config.rasi -dmenu -p "Would You Like to $chosen" -i -theme-str)
        case $yes_no in
            [no]* ) exit;;
            [yes]* )
                if [[ "$active_sounds" = yes && ! -z "$suspend_sound" && -f "${sounds_dir}${suspend_sound}" ]]; then
                    mpv --no-video "${sounds_dir}${suspend_sound}" && systemctl suspend
                else
                    systemctl suspend
                fi
                ;;
        esac
        ;;
    " Hibernate")
        yes_no=$(printf " no\n yes" | rofi -config /home/$USER/.config/qtile/rofi/config.rasi -dmenu -p "Would You Like to $chosen" -i -theme-str)
        case $yes_no in
            [no]* ) exit;;
            [yes]* )
                if [[ "$active_sounds" = yes && ! -z "$hibernate_sound" && -f "${sounds_dir}${hibernate_sound}" ]]; then
                    mpv --no-video "${sounds_dir}${hibernate_sound}" && systemctl hibernate
                else
                    systemctl hibernate
                fi
                ;;
        esac
        ;;
    "⏻ PowerOff")
        yes_no=$(printf " no\n yes" | rofi -config /home/$USER/.config/qtile/rofi/config.rasi -dmenu -p "Would You Like to $chosen" -i -theme-str)
        case $yes_no in
            [no]* ) exit;;
            [yes]* )
                if [[ "$active_sounds" = yes && ! -z "$poweroff_sound" && -f "${sounds_dir}${poweroff_sound}" ]]; then
                    mpv --no-video "${sounds_dir}${poweroff_sound}" && /sbin/poweroff
                else
                    /sbin/poweroff
                fi
                ;;
        esac
        ;;
esac
