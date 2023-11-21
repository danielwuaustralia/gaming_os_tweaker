# Peripherals

## General

- If you dont have a external PCIe USB card, you want to use the best controller in the motherboard. One from CPU is faster, and from Chipset is slower. It would be better to have Mouse, Keyboard and Controller on the fast one. You can check the controllers available with USB Tree View. It seems that the first controller in the list is usually the best one. <https://www.uwe-sieber.de/usbtreeview_e.html> - <https://www.youtube.com/watch?v=82K3Pb0178g>

- Auto disable Interrupt Moderation aka IMOD (XHCI) and/or Interrupt Threshold Control (EHCI) [OTHERS_GUIDE.md#interrupt-moderation-usb](./OTHERS_GUIDE.md#interrupt-moderation-usb)

- Convert games or DPI sensitivity by using <https://www.mouse-sensitivity.com/>

- Keyboard measurements <https://github.com/mat1jaczyyy/Keyboard-Inspector> and <https://blog.seethis.link/scan-rate-estimator/>

- You should consider using vendor driver for USB. Check <https://github.com/amitxv/PC-Tuning/blob/main/docs/research.md#microsoft-usb-driver-latency-penalty> for more information.

- Nice cursor option <https://github.com/ful1e5/Bibata_Cursor> or straight using a larger size usually helps not lose sight of the cursor.

## Mouse

- Just as it's recommended by rawaccel, set mouse DPI to 1600, it has lower latency, than lower DPI values.
- Best solution for mouse acceleration <https://github.com/a1xd/rawaccel>
  - My personal preference
    - Game at 1.0 Sens
    - Anisotrophy > Domain Y > 4
    - Rotation: -3.5 | <https://www.youtube.com/watch?v=AsTcv792DBA>
    - Type: Motivity
    - Multiplier: 1.15
    - Gain: Disabled
    - Growth Rate: 0.000001
    - Motivity: 1.6-1.8
    - Midpoint: 18-20
- Reduce Mouse Debounce Time - <https://www.highrez.co.uk/downloads/xmousebuttoncontrol.htm> (If your own mouse software does not provide the option)
  - In Settings > Advanced
  - (Check) De-bounce (ignore) rapid mouse button clicks, and set to 1ms
  - (Check) Fixup (debounce) tilt wheel auto-repeat - Repeat tilt rate to 1ms
  - Set CPU Priority to Realtime
- (At your own risk) You can overclock the USB mouse hz by following this tutorial <https://www.overclock.net/threads/usb-mouse-hard-overclocking-2000-hz.1589644/>
  - It should help reduce input lag / make it more responsive at some extent. <https://www.youtube.com/watch?v=x0wcJM4FtXQ> - <https://www.youtube.com/watch?v=ahsO5bhBUtk>
  - If you dont want to overclock, in some devices like controllers, you can at least reduce the input delay, by setting what will make bInterval to 1. <https://www.youtube.com/watch?v=_Sqgy95iAwE>
- If you have a mouse like Logitech, sometimes might be better to not have their software running in the background.
- I feel that mouse above 1000hz, at least I got a 4000hz, there is a more responsive feel to the smaller adjustments, it's not as floaty, it's a small, but good improvement. I read that it reduces jitter between the updates and does reduce input latency too, very little, but does.
- Mouse skeets dots, if you put more on the mouse, the more control and stopping power it will have, the less, it will slide faster.

## Controller

- Use PS4/5 controllers in the PC - <https://ds4-windows.com/>
