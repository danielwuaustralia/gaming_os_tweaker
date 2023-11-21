: <<URLS
 https://github.com/AdelKS/LinuxGamingGuide
 https://wiki.archlinux.org/title/gaming#Starting_games_in_a_separate_X_server
 https://us.download.nvidia.com/XFree86/Linux-x86_64/535.129.03/README/index.html
 https://wiki.archlinux.org/title/NVIDIA/Tips_and_tricks
 https://linux-gaming.kwindu.eu/index.php?title=Improving_performance
 https://wiki.archlinux.org/title/improving_performance
 https://github.com/CachyOS/CachyOS-Settings
 https://wiki.archlinux.org/title/gaming
 https://steamcommunity.com/sharedfiles/filedetails/?id=1787799592
 https://gist.github.com/dante-robinson/cd620c7283a6cc1fcdd97b2d139b72fa#performance
 https://codeberg.org/LinuxCafeFederation/awesome-gnu-linux-gaming
 https://github.com/leandromoreira/linux-network-performance-parameters
URLS

# --------------------------------------------------------------------------------------

# Disable USB polling
echo "options drm_kms_helper poll=N" | sudo tee -a /etc/modprobe.d/local.conf

echo "MUTTER_DEBUG_ENABLE_ATOMIC_KMS=0" | sudo tee -a /etc/environment
echo "MUTTER_DEBUG_FORCE_KMS_MODE=simple" | sudo tee -a /etc/environment

echo "CLUTTER_PAINT=disable-dynamic-max-render-time" | sudo tee -a /etc/environment


# AMD Only
sudo tee -a /etc/X11/xorg.conf.d/20-amdgpu.conf << EOF
Section "Device"
        Identifier "AMD"
        Driver "amdgpu"
        Option "TearFree" "false"
        Option "EnablePageFlip" "false"
EndSection
EOF
