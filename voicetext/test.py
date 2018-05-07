#!/usr/bin/env python3

from pyVoiceText import VoiceText

def voicetext(mykey, text, outfile, speed):
    vt = VoiceText(mykey)
    wave = vt.fetch(
        text=text,
        speaker='hikari',
        emotion_level=1,
        pitch=100,
        speed=speed,
        volume=100)
    vt.save(wave, outfile)


if __name__ == "__main__":
    mykey=open('./key.txt', 'r').read(16)
    voicetext(mykey, 'Hello World', 'out1.wav', 100)
    voicetext(mykey, 'こんにちは世界', 'out2.wav', 300)
