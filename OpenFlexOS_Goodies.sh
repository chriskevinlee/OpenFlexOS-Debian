#!/bin/bash

    if [ "$(id -u)" -ne 0 ]; then
        echo "Please run this script with sudo:"
        exit 1
    fi

clear
echo "Please choose a package to install"

package_list=("vlc" "virtualbox" "gparted" "filezilla" "qbittorrent" "isoimagewriter" "obs-studio" "gimp" "audacity" "discord" "virt-manager-and-kvm" "Bluetooth" "Screen Brightness" "Exit Script")

PS3="Please Choose a Number: "
select user_package in "${package_list[@]}"
do
    case $user_package in
        "vlc" )
            clear

            echo "Media Player that Supports most multimedia files and dvd play back"
            read -p "Would you like to install $user_package? " install

            while [[ -z $install || ( $install != "y" && $install != "n" ) ]]; do
             read -p "Would you like to install $user_package? " install
            done

            if [[ $install = y ]]; then
                sudo apt install -y vlc
            fi

            ;;
        "virtualbox" )
            clear

            echo "Virtualization platform to run virtual machines (VM's)"
            read -p "Would you like to install $user_package? " install

            while [[ -z $install || ( $install != "y" && $install != "n" ) ]]; do
             read -p "Would you like to install $user_package? " install
            done

            if [[ $install = y ]]; then
                sudo echo "" >> /etc/apt/sources.list
                sudo echo "# VirtualBox" >> /etc/apt/sources.list
                sudo echo "deb http://deb.debian.org/debian/ sid main contrib non-free" >> /etc/apt/sources.list
                sudo apt update
                sudo apt -y install virtualbox
            fi

            ;;
        "gparted" )
            clear

            echo "A Partition manager"
            read -p "Would you like to install $user_package? " install

            while [[ -z $install || ( $install != "y" && $install != "n" ) ]]; do
             read -p "Would you like to install $user_package? " install
            done

            if [[ $install = y ]]; then
                sudo apt install -y gparted
            fi

            ;;
        "filezilla" )
            clear

            echo "A FTP, FTPS and SFTP client to access ftp servers"
            read -p "Would you like to install $user_package? " install

            while [[ -z $install || ( $install != "y" && $install != "n" ) ]]; do
             read -p "Would you like to install $user_package? " install
            done

            if [[ $install = y ]]; then
                sudo apt install -y filezilla
            fi

            ;;
        "qbittorrent" )
            clear

            echo "BitTorrent client to download torrent files"
            read -p "Would you like to install $user_package? " install

            while [[ -z $install || ( $install != "y" && $install != "n" ) ]]; do
             read -p "Would you like to install $user_package? " install
            done

            if [[ $install = y ]]; then
                sudo apt install -y qbittorrent
            fi

            ;;
        "isoimagewriter" )
            clear

            echo "Flash ISO images to USB"
            read -p "Would you like to install $user_package? " install

            while [[ -z $install || ( $install != "y" && $install != "n" ) ]]; do
             read -p "Would you like to install $user_package? " install
            done

            if [[ $install = y ]]; then
                sudo apt -y install snapd
                sudo snap install snapd
                sudo snap install isoimagewriter

                sudo echo "[Desktop Entry]" >> /usr/share/applications/isoimagewriter.desktop
                sudo echo "Name=ISO Image Writer" >> /usr/share/applications/isoimagewriter.desktop
                sudo echo "Comment=Write ISO images to USB drives" >> /usr/share/applications/isoimagewriter.desktop
                sudo echo "Exec=/snap/bin/isoimagewriter" >> /usr/share/applications/isoimagewriter.desktop
                sudo echo "Icon=/snap/isoimagewriter/current/meta/gui/isoimagewriter.png" >> /usr/share/applications/isoimagewriter.desktop
                sudo echo "Terminal=false" >> /usr/share/applications/isoimagewriter.desktop
                sudo echo "Type=Application" >> /usr/share/applications/isoimagewriter.desktop
                sudo echo "Categories=Utility;" >> /usr/share/applications/isoimagewriter.desktop

                sudo update-desktop-database

            fi

            ;;
        "obs-studio" )
            clear

            echo "Recording and live streaming software"
            read -p "Would you like to install $user_package? " install

            while [[ -z $install || ( $install != "y" && $install != "n" ) ]]; do
             read -p "Would you like to install $user_package? " install
            done

            if [[ $install = y ]]; then
                sudo apt install -y obs-studio
            fi

            ;;
        "gimp" )
            clear

            echo "Image editing software"
            read -p "Would you like to install $user_package? " install

            while [[ -z $install || ( $install != "y" && $install != "n" ) ]]; do
             read -p "Would you like to install $user_package? " install
            done

            if [[ $install = y ]]; then
                sudo apt install -y gimp
            fi

            ;;
        "audacity" )
            clear

            echo "Audio editing software"
            read -p "Would you like to install $user_package? " install

            while [[ -z $install || ( $install != "y" && $install != "n" ) ]]; do
             read -p "Would you like to install $user_package? " install
            done

            if [[ $install = y ]]; then
                sudo apt install -y audacity
            fi

            ;;
        "discord" )
            clear

            echo "Voice and Text Chat"
            read -p "Would you like to install $user_package? " install

            while [[ -z $install || ( $install != "y" && $install != "n" ) ]]; do
             read -p "Would you like to install $user_package? " install
            done

            if [[ $install = y ]]; then
                sudo apt install snapd
                sudo snap install snapd
                sudo snap install discord

                sudo echo "[Desktop Entry]" >> /usr/share/applications/discord.desktop
                sudo echo "Name=Discord" >> /usr/share/applications/discord.desktop
                sudo echo "Comment=Chat and Video Application" >> /usr/share/applications/discord.desktop
                sudo echo "Exec=/snap/bin/discord" >> /usr/share/applications/discord.desktop
                sudo echo "Icon=/snap/discord/current/meta/gui/discord.png" >> /usr/share/applications/discord.desktop
                sudo echo "Terminal=false" >> /usr/share/applications/discord.desktop
                sudo echo "Type=Application" >> /usr/share/applications/discord.desktop
                sudo echo "Categories=Network;InstantMessaging;" >> /usr/share/applications/discord.desktop

                sudo update-desktop-database
            fi

            ;;
        "virt-manager-and-kvm" )
            clear

            echo "Virtualization platform to run virtual machines (VM's)"
            read -p "Would you like to install $user_package? " install

            while [[ -z $install || ( $install != "y" && $install != "n" ) ]]; do
             read -p "Would you like to install $user_package? " install
            done

            if [[ $install = y ]]; then
                sudo apt -y install qemu-system libvirt-daemon-system virt-manager
                sudo usermod -aG libvirt $USER # Assuming $USER is the sudo user

            fi

            ;;
        "Bluetooth" )
            clear

            echo "Bluetooth control using bluez and blueman"
            read -p "Would you like to install $user_package? " install

            while [[ -z $install || ( $install != "y" && $install != "n" ) ]]; do
             read -p "Would you like to installlll $user_package? " install
            done

            if [[ $install = y ]]; then
                sudo apt install -y bluez #  Bluetooth baemon
                sudo apt install -y blueman # Bluetooth GUI
                sudo systemctl enable bluetooth
            fi

         ;;
        "Screen Brightness" )
            clear

            echo "Scren brightness control using brightnessctl"
            read -p "Would you like to install $user_package? " install

            while [[ -z $install || ( $install != "y" && $install != "n" ) ]]; do
             read -p "Would you like to install $user_package? " install
            done

            if [[ $install = y ]]; then
                sudo apt install -y brightnessctl # Brighness Control
            fi

           ;;

        "Exit Script" )
       exit
         ;;
         
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
    clear
    echo "Please choose a package to install"
    REPLY=
done




# "TeamViewer(AUR)" "Sublime Text 4(AUR)" "Brave(AUR)" "TimeShift(AUR)"
