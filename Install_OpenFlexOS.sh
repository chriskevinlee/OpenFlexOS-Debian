#!/bin/bash
 
# Check to make sure script has root/sudo permissions
    if [ "$(id -u)" -ne 0 ]; then
        echo "Please run this script with sudo:"
        echo "sudo $0"
        exit 1
    fi

# Clear's output, Welcomes and ask the user if like to install OpenFlexOS
    clear
    echo "Welcome to OpenFlexOS Installation script"
    read -p "Would you like to start installing OpenFlexOS? (y/n) " yn

# Displays a invalid input message to the user if y or n is not selected
    while [[ ! $yn =~ ^(y|n)$ ]]; do
        clear
        echo "Invalid Input. You Entered $yn"
        read -p "Would you like to start installing OpenFlexOS? (y/n) " yn
    done

# Function: List of packages to be install
    install_packages () {
        apt -y install sudo
        apt -y install --no-install-recommends sddm
        apt -y install mpv
        apt -y install xscreensaver
        apt -y install feh
        apt -y install rofi
        apt -y install dmenu
        apt -y install arandr
        apt -y install wget
        apt -y install xarchiver
        apt -y install p7zip
        apt -y install unzip
        apt -y install xdg-user-dirs
        apt -y install alacritty
        apt -y install conky-all
        apt -y install lsd
        apt -y install bat
        apt -y install pavucontrol-qt
        apt -y install pipewire-pulse
        apt -y install git
        apt -y install qml-module-qtgraphicaleffects qml-module-qtquick-controls2 libqt5svg5 libqt5svg5-dev
        apt -y install zsh
        apt -y install zsh-syntax-highlighting
        apt -y install firefox-esr
        apt -y install flameshot
        apt -y install htop
        apt -y install caja
        apt -y install policykit-1-gnome
        apt -y install sxiv
        apt -y install qt5ct
        apt -y install qt6ct
        apt -y install qt5-style-kvantum
        apt -y install lxappearance
        apt -y install materia-gtk-theme
        apt -y install dunst
        apt -y install picom
        apt -y install wmctrl
        apt -y install galculator
        apt -y install python3-psutil
        apt -y install network-manager
        apt -y install curl

        git clone https://github.com/zsh-users/zsh-autosuggestions.git /usr/share/zsh/plugins/zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-history-substring-search /usr/share/zsh/plugins/zsh-history-substring-search
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /usr/share/zsh/plugins/zsh-syntax-highlighting

        wget -P /tmp/ https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/NerdFontsSymbolsOnly.zip
        sudo unzip -d /usr/share/fonts /tmp/NerdFontsSymbolsOnly.zip
        sudo fc-cache -fv

        apt install libconfig-dev libdbus-1-dev libegl-dev libev-dev libgl-dev libepoxy-dev libpcre2-dev libpixman-1-dev libx11-xcb-dev libxcb1-dev libxcb-composite0-dev libxcb-damage0-dev libxcb-dpms0-dev libxcb-glx0-dev libxcb-image0-dev libxcb-present-dev libxcb-randr0-dev libxcb-render0-dev libxcb-render-util0-dev libxcb-shape0-dev libxcb-util-dev libxcb-xfixes0-dev libxext-dev meson ninja-build uthash-dev
        
        cd /tmp
        git clone https://github.com/FT-Labs/picom.git
        cd picom
        meson setup --buildtype=release build
        ninja -C build
        ninja -C build install
    }

# Function: Get zsh path, checks to see if any users already exists if not it ask the user to create a user and allows user to copy config files to already existing users and added users
   users_function() {

    get_zsh_path() {
        if [[ -x /bin/zsh ]]; then
            echo "/bin/zsh"
        elif [[ -x /usr/bin/zsh ]]; then
            echo "/usr/bin/zsh"
        else
            echo "zsh not found" >&2
            exit 1
        fi
    }

    zsh_path=$(get_zsh_path)

   while true; do  # Start a loop to repeat the process
    clear
    # Get the list of users again (including any newly added users)
    users=($(grep "/home/" /etc/passwd | awk -F : '{print $1}'))

    # This code will run if there ARE users on the system with Home Directories
    if [[ ${#users[@]} -ge 0 ]]; then
        # Declare an empty array to store users without the file
        missing_users=()

        # Loop through users and check for the existence of the file
        for user in "${users[@]}"; do
            user_home=$(eval echo "~$user")  # Get the home directory for each user
            if [[ ! -d "$user_home/.config/$lower_main" ]]; then
                missing_users+=("$user")  # Add user to the list of missing users
            fi
        done

        # Display the users who are missing the file
        echo "These users do not have $main configuration directory and files:"
        for ((i = 0; i < ${#missing_users[@]}; i++)); do
            echo "$(($i + 1)). ${missing_users[i]}"
        done

        echo "0. Add a new user"  # Option to add a new user
        echo "q. Quit To Main Menu"  # Option to quit the loop

        # Ask for user input to copy the file
        echo "Please enter the number(s) of the user(s) you want to copy the file to (comma-separated, e.g., 1,2,3), 0 to add a new user, or 'q' to quit:"
        read -r user_input

        # Handle quit option
        if [[ $user_input == "q" ]]; then
            echo "Exiting..."
            break
        fi

        # Convert input into an array
        selected_users=($(echo "$user_input" | tr ',' ' '))

        # Handle the case for creating a new user
        if [[ " ${selected_users[@]} " =~ " 0 " ]]; then
            read -p "Please Enter a username: " username
            while [[ -z $username ]]; do
                echo "Invalid Input"
                read -p "Please Enter a username: " username
            done

            sudo useradd -m $username
            sudo passwd $username

            read -p "Would you like to make $username a sudo user? y/n " yn
            while [[ -z $yn ]] || [[ ! $yn =~ [yn] ]]; do
                echo "Invalid Input"
                read -p "Would you like to make $username a sudo user? y/n " yn
            done
            if [[ $yn = y ]]; then
                sudo usermod -aG sudo $username
            fi

            # Add new user to the missing_users array for copying files
            missing_users+=("$username")
        fi

        # Copy the file to selected users' home directories
        for idx in "${selected_users[@]}"; do
            # Skip option "0" as it has already been handled
            if [[ $idx == 0 ]]; then
                continue
            fi

            user_to_copy=${missing_users[$((idx - 1))]}  # Adjust for 0-based index
            user_home=$(eval echo "~$user_to_copy")
            echo "Copying files to $user_home"

            mkdir -p $user_home/.config
            cp -r OpenFlexOS-Configs/config/$lower_main $user_home/.config/$lower_main
            cp -r OpenFlexOS-Configs/config/gtk-3.0 $user_home/.config/gtk-3.0
            cp -r OpenFlexOS-Configs/config/Kvantum/ $user_home/.config/Kvantum
            cp -r OpenFlexOS-Configs/config/qt5ct/ $user_home/.config/qt5ct
            cp -r OpenFlexOS-Configs/config/qt6ct/ $user_home/.config/qt6ct
            cp -r OpenFlexOS-Configs/config/picom $user_home/.config/picom
            cp -r OpenFlexOS-Configs/config/sxiv $user_home/.config/sxiv
            cp -r OpenFlexOS-Configs/config/wallpapers/ $user_home/.config/wallpapers/
            cp OpenFlexOS-Configs/dot.gtkrc-2.0 $user_home/.gtkrc-2.0
            cp OpenFlexOS-Configs/dot.xscreensaver $user_home/.xscreensaver
            cp OpenFlexOS-Configs/dot.zshrc $user_home/.zshrc
            cp OpenFlexOS-Configs/dot.bashrc $user_home/.bashrc
            cp OpenFlexOS-Configs/dot.p10k.zsh $user_home/.p10k.zsh
            git clone https://github.com/romkatv/powerlevel10k.git $user_home/.config/powerlevel10k/
            chsh -s "$zsh_path" $user_to_copy
            chown -R $user_to_copy:$user_to_copy $user_home
            chmod -R +x $user_home/.config/$lower_main/scripts/
        done

        # Refresh the missing_users array after copying files
        missing_users=()
    else
        echo "No users with home directories found."
        break  # Exit the loop if no users are found
    fi
    done  # End of loop
    }
     
# Function: Set environment variables for qt and gtk theme
        set_env_variables() {
            echo "QT_QPA_PLATFORMTHEME=qt5ct" >> /etc/environment
            echo "QT_AUTO_SCREEN_SCALE_FACTOR=0" >> /etc/environment
            echo "QT_SCALE_FACTOR=1" >> /etc/environment
            echo "QT_FONT_DPI=96" >> /etc/environment
        }

# Function: clone configs
    clone_configs () {
        git clone https://github.com/chriskevinlee/OpenFlexOS-Configs.git
    }


# Function: Enables sddm and copy config files
        enable_copytheme_ssdm () {
            systemctl enable sddm
            sddm --example-config > /etc/sddm.conf
            mkdir -p /usr/share/sddm/themes/
            cp -r OpenFlexOS-Configs/corners /usr/share/sddm/themes/
            sed -i s/Current=debian-theme/Current=corners/ /etc/sddm.conf
        }

# Function: Copy config files to /etc/skel for newly created usersf
        copy_config_skel () {
            if [[ ! -d /etc/skel/.config ]]; then
                mkdir /etc/skel/.config
                if [[ ! -d /etc/skel/.config/wallpapers ]]; then
                    cp -r OpenFlexOS-Configs/config/wallpapers/ /etc/skel/.config/wallpapers/
                else
                    echo "Wallpapers directory already exists. Skipping copy."
                fi
                cp -r OpenFlexOS-Configs/config/$lower_main /etc/skel/.config/$lower_main
                cp -r OpenFlexOS-Configs/config/gtk-3.0 /etc/skel/.config/gtk-3.0
                cp -r OpenFlexOS-Configs/config/Kvantum/ /etc/skel/.config/Kvantum
                cp -r OpenFlexOS-Configs/config/qt5ct/ /etc/skel/.config/qt5ct
                cp -r OpenFlexOS-Configs/config/qt6ct/ /etc/skel/.config/qt6ct
                cp -r OpenFlexOS-Configs/config/picom /etc/skel/.config/picom
                cp -r OpenFlexOS-Configs/config/sxiv /etc/skel/.config/sxiv
                cp OpenFlexOS-Configs/dot.gtkrc-2.0 /etc/skel/.gtkrc-2.0
                cp OpenFlexOS-Configs/dot.xscreensaver /etc/skel/.xscreensaver
                cp OpenFlexOS-Configs/dot.zshrc /etc/skel/.zshrc
                cp OpenFlexOS-Configs/dot.bashrc /etc/skel/.bashrc
                cp OpenFlexOS-Configs/dot.p10k.zsh /etc/skel/.p10k.zsh
                chmod -R +x /etc/skel/.config/$lower_main/scripts/
                git clone https://github.com/romkatv/powerlevel10k.git /etc/skel/.config/powerlevel10k/
            elif [[  -d /etc/skel/.config ]]; then
                if [[ ! -d /etc/skel/.config/wallpapers ]]; then
                    cp -r OpenFlexOS-Configs/config/wallpapers/ /etc/skel/.config/wallpapers/
                else
                    echo "Wallpapers directory already exists. Skipping copy."
                fi
                cp -r OpenFlexOS-Configs/config/$lower_main /etc/skel/.config/$lower_main
                cp -r OpenFlexOS-Configs/config/gtk-3.0 /etc/skel/.config/gtk-3.0
                cp -r OpenFlexOS-Configs/config/Kvantum/ /etc/skel/.config/Kvantum
                cp -r OpenFlexOS-Configs/config/qt5ct/ /etc/skel/.config/qt5ct
                cp -r OpenFlexOS-Configs/config/qt6ct/ /etc/skel/.config/qt6ct
                cp -r OpenFlexOS-Configs/config/picom /etc/skel/.config/picom
                cp -r OpenFlexOS-Configs/config/sxiv /etc/skel/.config/sxiv
                cp OpenFlexOS-Configs/dot.gtkrc-2.0 /etc/skel/.gtkrc-2.0
                cp OpenFlexOS-Configs/dot.xscreensaver /etc/skel/.xscreensaver
                cp OpenFlexOS-Configs/dot.zshrc /etc/skel/.zshrc
                cp OpenFlexOS-Configs/dot.bashrc /etc/skel/.bashrc
                cp OpenFlexOS-Configs/dot.p10k.zsh /etc/skel/.p10k.zsh
                chmod -R +x /etc/skel/.config/$lower_main/scripts/
                git clone https://github.com/romkatv/powerlevel10k.git /etc/skel/.config/powerlevel10k/ 
            fi
    }

# Function: Miscellaneous configurations 
    miscellaneous_configs () {
         cp OpenFlexOS-Configs/wallpaper_changer.sh /usr/local/bin/wallpaper_changer.sh
        chmod +x /usr/local/bin/wallpaper_changer.sh
        cp OpenFlexOS-Configs/wallpaper.desktop /usr/share/applications/wallpaper.desktop

        cp -r OpenFlexOS-Configs/Midnight-Red /usr/share/themes/Midnight-Red
        cp -r OpenFlexOS-Configs/Midnight-Green /usr/share/themes/Midnight-Green
        cp -r OpenFlexOS-Configs/Arc-Darkest /usr/share/themes/Arc-Darkest
        cp -r OpenFlexOS-Configs/Vivid-Dark-Icons /usr/share/icons/Vivid-Dark-Icons
                            
        mkdir -p /usr/share/zsh/plugins/zsh-sudo
        wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh -P /usr/share/zsh/plugins/zsh-sudo
        apt-file update

        chmod +s /sbin/reboot               
        clear
        # Setup hibination
        SWAP_INFO=$(swapon --show --noheadings)
        SWAP_DEVICE=$(echo "$SWAP_INFO" | awk '{print $1}')

        # Configure resume in initramfs-tools
        echo "RESUME=$SWAP_DEVICE" | sudo tee /etc/initramfs-tools/conf.d/resume

        # Regenerate initramfs
        sudo update-initramfs -u

        sed -i  's|SHELL=/bin/sh|SHELL=/bin/zsh|' /etc/default/useradd

        # Update GRUB to include resume parameter
        sudo sed -i "s|GRUB_CMDLINE_LINUX=\"\"|GRUB_CMDLINE_LINUX=\"resume=$SWAP_DEVICE\"|" /etc/default/grub
        sudo update-grub

    apt -y remove ifupdown
    mv /etc/network/interfaces /etc/network/interfaces.BK
    }

# If the User selects y the installation will start
    if [[ $yn = y ]]; then
    read -p "Would you like to update? (y/n) " yn

    # Gives a invaild input message if y or n is not entered
    while [[ ! $yn = y ]] && [[ ! $yn = n ]]; do
        clear
        echo "Invaild Input! You Entered $yn"
        read -p "Would you like to update? (y/n) " yn
    done

    # Runs system updates if y is selected
    if [[ $yn = y ]]; then
        echo "Updating..."
        sleep 5
        apt update && apt upgrade -y
    fi
    clear

    # Set's a array, asks the user which window manager to install and sets a promt to tell the user to use a number
    options=("Qtile" "Openbox" "User configuration" "Exit Installation Script" "Reboot" "PowerOff")
    echo "Main Menu: Please Choose a Window Manager to install"
    PS3="Please Choose a Number: "

    select main in "${options[@]}"
        do
        case $main in
            # Installs everything needed to run Qtile
                "Qtile" )
                    lower_main=$(echo "$main" | tr '[:upper:]' '[:lower:]')

                    clear
                    echo "Installing required packages for Qtile-OpenFlexOS..."
                    sleep 5
                    
                    apt -y install python3-pip
                    apt -y install python3-cffi libpangocairo-1.0-0 --reinstall
                    apt -y install python3-full
                    apt -y install git
                    pip3 install xcffib==0.12.1 --break-system-packages
                    pip3 install --no-cache-dir --no-build-isolation cairocffi==1.4.0 --break-system-packages
                    pip3 install git+https://github.com/qtile/qtile --break-system-packages
                    mkdir /usr/share/xsessions/
                    echo "[Desktop Entry]" >> /usr/share/xsessions/qtile.desktop
                    echo "Name=Qtile" >> /usr/share/xsessions/qtile.desktop
                    echo "Comment=Qtile Session" >> /usr/share/xsessions/qtile.desktop
                    echo "Exec=qtile start" >> /usr/share/xsessions/qtile.desktop
                    echo "Type=Application" >> /usr/share/xsessions/qtile.desktop
                    echo "Keywords=wm;tiling" >> /usr/share/xsessions/qtile.desktop

                    install_packages

                    clone_configs
                    
                    enable_copytheme_ssdm

                    copy_config_skel

                    set_env_variables

                    miscellaneous_configs

                    mv /usr/share/wayland-sessions/qtile-wayland.desktop /usr/share/wayland-sessions/qtile-wayland.desktop.bak

                    users_function
                ;;
                "Openbox" )
                    lower_main=$(echo "$main" | tr '[:upper:]' '[:lower:]')

                    echo "Installing required packages for Openbox-OpenFlexOS..."
                    sleep 5
                    apt -y install openbox # Window Manager
                    apt -y install tint2 # status bar Window Manager
                    apt -y install obconf # Set Openbox Theme
                    install_packages

                    clone_configs
                    
                    enable_copytheme_ssdm

                    copy_config_skel

                    set_env_variables

                    miscellaneous_configs

                    cp -r OpenFlexOS-Configs/Vedanta-dark-openbox /usr/share/themes/Vedanta-dark-openbox

                    users_function
                ;;

                "User configuration" )
                    clear
                    while true; do
                        read -p "To copy configuration files, Please Choose a Window Manager (openbox, qtile) or leave blank to add a user: " wm
                        if [[ $wm = openbox ]]; then
                            lower_main=openbox
                            users_function
                            break
                        elif [[ $wm = qtile ]]; then
                            lower_main=qtile
                            users_function
                            break
                        elif [[ -z $wm ]]; then
                            users_function
                            break
                        else
                            clear
                            echo "Invalid Input..."
                        fi
                    done
                ;;

                "Exit Installation Script" )
                    echo "Exiting Installation Script..."
                    sleep 3
                    exit 0
                ;;
                "Reboot" )
                    reboot
                ;;
                "PowerOff" )
                    poweroff
                ;;
        esac
    clear
    echo "Main Menu: Please Choose a Window Manager to install"
    REPLY=
    done
    fi

# If the user enters n then the install it exit
    if [[ $yn = n ]]; then
        echo "Exiting OpenFlexOS Installation..."
        sleep 5
        exit 0
    fi
