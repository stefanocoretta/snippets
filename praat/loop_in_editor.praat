form Folder with audio and TG files
  word path /Users/stefano/Desktop/loop
endform

tg = Create Strings as file list: "tg_list", "'path$'/*.TextGrid"
tg_num = Get number of strings

log$ = "'path$'/log.txt"

if fileReadable(log$)
  pauseScript: "Log file found! Continue from where you left?"

  log = Read Strings from raw text file: log$
  last$ = Get string: 1
  last = number: last$
  next = last + 1
else
  writeFileLine: log$, "1"
  next = 1
endif

for tg_id from next to tg_num
  selectObject: tg
  tg_name$ = Get string: tg_id
  wav_name$ = tg_name$ - ".TextGrid" + ".wav"
  
  current_tg = Read from file: "'path$'/'tg_name$'"
  current_wav = Read from file: "'path$'/'wav_name$'"
  
  selectObject: current_wav, current_tg
    View & Edit
    editor: current_tg
      pauseScript: "Fix annotation, then click Continue when done (changes are saved automatically)."
      Close
    endeditor

  selectObject: current_tg
  Save as text file: "'path$'/'tg_name$'"
  writeFileLine: log$, "'tg_id'"

endfor