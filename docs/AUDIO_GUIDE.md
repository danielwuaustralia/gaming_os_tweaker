# Audio

## General

- If you use High Definition Audio Device, you can decrease the audio latency buffer by using one of the solutions
  - <https://github.com/miniant-git/REAL>
  - <https://github.com/spddl/LowAudioLatency>

- `HDAudBus.sys` high DPC latency.
  - Disable every sound device that you are not using. Be microfone and/or headset/others. You can open with `control mmsys.cpl sounds` on `cmd` or `powershell`. Or just open Sound in Control Panel.
  - Another possible cause would be if you are using `low_audio_latency_no_console` to reduce audio buffer.

## Optional

- EqualizerAPO <https://sourceforge.net/projects/equalizerapo/>
  - It's a tool that can help you improve your listening and prevent hearing damange
  - There are multiple tools like this one, even the one built-in from Windows. I tested and I felt that this had the lowest latency and best results, I didnt measure anything though.
  - It also has plugins that make it more complete where other solutions do not.
  - It seems to reduce the audio that is going beyond a certain threshold, usually a gun fire is way louder than a footstep, it will reduce only part of the audio that is higher from that threshold set. Having the possibility to keep firing audio and footsteps audio in the same level per say.
  - A few useful plugins
    - Loudmax <https://loudmax.blogspot.com/>
    - Reacomp <https://plugins4free.com/plugin/471/>
    - RoughtRider3 <https://www.audiodamage.com/pages/free-downloads>
  - I know that Loudmax and Reacomp can work together.
  - You may look for how to do the setting or setup how you want.
  - (References)
    - <https://www.reddit.com/r/EscapefromTarkov/comments/f04go3/comment/fgs0sgw/?utm_source=share&utm_medium=web2x&context=3>
    - <https://www.youtube.com/watch?v=vXuAwpt4WsQ>
    - <https://www.youtube.com/watch?v=OeW5sZ6djt8>

- FiiO BTR5 2021 DAC/AMP
  - Driver - <https://forum.fiio.com/note/showNoteContent.do?id=202105191527366657910&tid=17>
  - Firmware - <https://forum.fiio.com/note/showNoteContent.do?id=202204291000067884656&tid=117> - <https://forum.fiio.com/note/showNoteContent.do?id=202109101658479885270>
