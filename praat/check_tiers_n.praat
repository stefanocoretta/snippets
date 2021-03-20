select all
number = numberOfSelected()

for i to number
	files [i] = selected (i)
endfor

writeInfo: ""

for i to number
	selectObject: files [i]
	filename$ = selected$ ()
	tiers = Get number of tiers
	if tiers != 4
		appendInfoLine: filename$, " ", tiers
	endif
endfor
