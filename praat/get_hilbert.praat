sound = selected("Sound")
name$ = selected$("Sound")

selectObject: sound
spectrum = To Spectrum: "no"
Rename: "original"

spectrumHilbert = Copy: "hilbert"
Formula: "if row=1 then Spectrum_original[2,col] else -Spectrum_original[1,col] fi"
soundHilbert = To Sound

env = Copy: "'name$'_ENV"
Formula: "sqrt(self^2 + Sound_'name$'[]^2)"

selectObject: soundHilbert
tfs_method1 = Copy: "'name$'_TFS_method1"
Formula: "cos(arctan2(self, Sound_'name$'[]))"

selectObject: env
inverseEnv = Copy: "inverse_ENV"
Formula: "1/self"
selectObject: sound
tfs_method2 = Copy: "'name$'_TFS_method2"
Formula: "self * Sound_inverse_ENV[]"