form Select data
  comment Set path to wav audio file and TextGrid:
  sentence wav ~/Desktop/untitled.wav
  sentence tg ~/Desktop/untitled.TextGrid
endform

wav = Read from file: wav$
tg = Read from file: tg$
selectObject: wav
wav_end = Get end time
sp = To Spectrogram: 0.005, 5000, 0.002, 20, "Gaussian"
selectObject: wav
pitch = To Pitch: 0, 75, 600

Erase all

start = 0
end = wav_end
width = 7

selectObject: tg
tg_tiers = Get number of tiers
tg_extent = 3 + 0.5 * (tg_tiers)

12
Helvetica

Select inner viewport: 1, width, 1.5, 3
selectObject: sp
Paint: start, end, 0, 0, 100, "no", 45, 6, 0, "no"
Line width: 3
selectObject: pitch
Draw: 0, 0, 0, 500, "no"
Line width: 1
Draw inner box

Select inner viewport: 1, width, 1, tg_extent
selectObject: tg
Draw: start, end, "yes", "yes", "no"

Select inner viewport: 1, width, 1, 1.5
selectObject: wav
Draw: start, end, 0, 0, "no", "Curve"

Select inner viewport: 1, width, 1.5, 3
Axes: start, end, 0, 5000
Marks left: 2, "yes", "yes", "no"
Text left: "no", "Freq. (Hz)"

Select inner viewport: 1, width, 1, tg_extent
Draw inner box
Marks bottom every: 1, 0.25, "yes", "yes", "no"
Text bottom: "yes", "Time (s)"

Select outer viewport: 0.5, width + 0.5, 0.75, tg_extent + 0.5
Save as 600-dpi PNG file: "p-k.png"