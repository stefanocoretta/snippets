Filter (pass Hann band): 400, 0, 100
sound_band = selected("Sound")

spectrum = To Spectrum: "no"
Rename: "original"

spectrum_hilbert = Copy: "hilbert"
Formula: "if row=1 then Spectrum_original[2,col] else -Spectrum_original[1,col] fi"
sound_hilbert = To Sound

samples = Get number of samples

Formula: "abs(self)"
matrix = Down to Matrix
period = Get column distance

m1_time = 0.006
m2_time = 0.016

for sample from 1 to samples
    current = sample * period
    selectObject: sound_hilbert
    mean_before = Get mean: 1, current - m1_time - m2_time, current - m1_time
    mean_after = Get mean: 1, current + m1_time, current + m1_time + m2_time
    window_average = (mean_before + mean_after) / 2
    current_value = Get value at time: 1, current, "Sinc70"
    plosion = current_value / window_average

    if plosion == undefined
        plosion = 0
	elif plosion < 4
		plosion = 0
    endif

    selectObject: matrix
    Set value: 1, sample, plosion
endfor

To Sound
To PointProcess (extrema): 1, "yes", "no", "Sinc70"
burst = Get time from index: 1
