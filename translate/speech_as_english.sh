#!/usr/bin/env bash
./translate.py ${1} tmp.txt en 
../gcp/gcp_tts.py tmp.txt tmp.mp3 e

play tmp.mp3
#test -f tmpx2.wav && rm tmpx2.wav
#ffmpeg -i tmp.mp3 -af "atempo=2" tmpx2.wav
#play tmpx2.wav
