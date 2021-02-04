#!bin/bash

# Go to the working directory
mkdir ~/TWRP-9 && cd ~/TWRP-9
# Configure git
git config --global user.email "100Daisy@protonmail.com"
git config --global user.name "GitDaisy"
git config --global color.ui false
# Sync the source
repo init --depth=1 -u git://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b twrp-9.0
repo sync  -f --force-sync --no-clone-bundle --no-tags -j$(nproc --all)
# Clone device tree and common tree
git clone --depth=1 https://github.com/100Daisy/twrp_device_motorola_deen -b android-9 device/motorola/deen
# Build recovery image
export ALLOW_MISSING_DEPENDENCIES=true; . build/envsetup.sh; lunch omni_deen-eng; make -j$(nproc --all) recoveryimage
# Make the recovery installer
cd build
git fetch "https://gerrit.omnirom.org/android_build" refs/changes/82/33182/5 && git cherry-pick FETCH_HEAD
cd ..
# Rename and copy the files
twrp_version=$(cat ~/TWRP-9/bootable/recovery/variables.h | grep "define TW_MAIN_VERSION_STR" | cut -d '"' -f2)
date_time=$(date +"%d%m%Y%H%M")
mkdir ~/final
cp recovery.img ~/final/twrp-$twrp_version-deen-"$date_time"-unofficial.img
cp recovery-installer.zip ~/final/twrp-$twrp_version-deen-"$date_time"-unofficial.zip
# Upload to oshi.at
curl -T ~/final/*.img https://oshi.at 
curl -T ~/final/*.zip https://oshi.at