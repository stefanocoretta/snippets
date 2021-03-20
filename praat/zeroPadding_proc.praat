
procedure zeroPadding: .num, .numZeros
    .highestVal = 10 ^ .numZeros

    .num$ = string$: .num
    .numLen = length: .num$

    .numToAdd = .numZeros - .numLen

    .zeroPrefix$ = ""
    if .numToAdd > 0
        for i from 1 to .numToAdd
            .zeroPrefix$ = .zeroPrefix$ + "0"
        endfor
    endif

    .return$ = .zeroPrefix$ + .num$
endproc
