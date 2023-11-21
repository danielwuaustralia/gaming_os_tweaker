# GPU

## General

- You can improve the Vibrance in each choosen game, without having to set for everything
  - <https://vibrancegui.com/>
  - I find that 70/75% being the best values, some use at 100%
- You can reduce input lag and crosstalk by making adjustments to pixel and refresh rate <https://forums.blurbusters.com/viewtopic.php?t=8946>
- Fix 1% and 0.1% lows with MSI Afterburner + Rivaturner <https://www.guru3d.com/files-details/msi-afterburner-beta-download.html>
  - Cap the fps using Rivaturner to a value that is able to withhold, and you should see improvements in not dropping much below that value, where in other cases may cause stutters
  - Only seem to work with Rivaturner limiter
  - Reference <https://www.youtube.com/watch?v=3QFH_YBOhNg>
- If you have a monitor with HDMI 2.1, there is a way to reduce latency
  - Download CRU at <https://www.monitortests.com/forum/Thread-Custom-Resolution-Utility-CRU>
  - Enable Fast Vactive
  - Enable Auto Low Latency Mode
  - Done
- (Optional) If you are looking to improve your display calibration
  - Profiles at <https://tftcentral.co.uk/articles/icc_profiles>
  - Alternative tool <https://displaycal.net/>
    - It can improve further than windows does, but it seems you need to keep it open
    - <https://www.youtube.com/watch?v=65VVCXBmnbs>
- Run games in borderless mode (if not natively available)
  - <https://www.pcgamingwiki.com/wiki/Glossary:Windowed>

## Nvidia

- You can start with DDU if you have a driver installed
- Download at <https://www.guru3d.com/files-details/display-driver-uninstaller-download.html>
- Select your GPU as Nvidia
- Clean and Restart

After Restart (Debloat)

- Download at <https://www.techpowerup.com/download/techpowerup-nvcleanstall/> or the optional, but less featured <https://forums.guru3d.com/threads/nvslimmer-nvidia-driver-slimming-utility.423072/>
- Download the nvidia driver that you want
- Open NVCleanstall and select Use driver files on Disk > Select the driver
- Next, I recommend the bare minimum `Display Driver (required)` only
- Next,
  - Disable Installer Telemetry & Advertising
  - Show Expert Tweaks [Disable HDCP]
- Next, Install
- Next every step, once you are finished with nividia installer, you can close the nvcleanstall

After

- Use nvidiaProfileInspector from `scripts/tools` or get at <https://github.com/Orbmu2k/nvidiaProfileInspector/releases>
- Import the `scripts/config/apps/low_latency.nip` and apply
- (Optional) there is a script that can do this automatically, at `scripts/optional_helpers`, called `import_nip.cmd`

Optionally after

- In Nvidia Control Panel > Display > Adjust desktop size and position > No Scaling + Display + Override the scaling mode ON. Multiple sources said to have the lowest latency, at least on recent hardware.

**You are done!**

---

## AMD

> I dont have one to do it correctly. But some steps should be similar to nvidia.

Option to debloat AMD drivers before install <https://github.com/GSDragoon/RadeonSoftwareSlimmer>
