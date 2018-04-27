#!/usr/bin/python3

import soundfile as sf

input1_fn='input1.wav'
input2_fn='input2.wav'
output_fn='output.wav'

data1, samplerate1 = sf.read(input1_fn)
data2, samplerate2 = sf.read(input2_fn)

if samplerate1 != samplerate2:
    raise ValueError('sample rates are unmatched')

with sf.SoundFile(output_fn, 'w', samplerate1, 2) as f:
    f.write(data1)
    f.write(data2)

