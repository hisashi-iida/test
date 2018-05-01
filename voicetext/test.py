#!/usr/local/bin/python3

from pyVoiceText import VoiceText

mykey='emwix5ragfw1sux7'
vt = VoiceText(mykey)
vt.fetch(text='こんにちは世界', speaker='hikari', emotion_level=1, pitch=100, speed=300, volume=100)

