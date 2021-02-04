# TWRP device tree for Motorola One

## How to Build

```
# Sync Source code
mkdir ~/TWRP-9 && cd ~/TWRP-9
repo init --depth=1 -u git://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b twrp-9.0
repo sync  -f --force-sync --no-clone-bundle --no-tags -j$(nproc --all)

# Logcat read failed FIX
cd bootable/recovery 
git fetch https://gerrit.twrp.me/android_bootable_recovery refs/changes/98/3298/2 && git cherry-pick FETCH_HEAD
cd ../..

# No recovery installer zip FIX
cd build
git fetch "https://gerrit.omnirom.org/android_build" refs/changes/82/33182/5 && git cherry-pick FETCH_HEAD
cd ..
```
## Sources
Big Thanks to LinkBoi00, he helped me a lot with decryption and bootslot's
Without him i propably will never fix these issue's

Kernel source: https://github.com/100Daisy/android_kernel_motorola_deen/tree/pe-ten (currently using prebuilt kernel & dt)

[![Build Status](https://cloud.drone.io/api/badges/100Daisy/twrp_device_motorola_deen/status.svg)](https://cloud.drone.io/100Daisy/twrp_device_motorola_deen)

###### Donate
[PayPal](https://www.paypal.me/100Daisy)