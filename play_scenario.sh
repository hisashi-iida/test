#!/usr/bin/env bash
count=1
mp3files=""
cat ${1} | while read i; do
    head=${i:0:5}
    body="${i:5}"
    echo "${body}" > tmp.txt
    case ${head} in
    "[ply]")
        pushd aws
        ./aws_polly.py ../tmp.txt ../${count}.mp3
        popd
    ;;
    "[gcp]")
        pushd gcp
        ./gcp_tts.py ../tmp.txt ../${count}.mp3 j
        popd
    ;;
    "[vtx]")
        pushd voicetext
        ./voicetext.py ../tmp.txt ../${count}.mp3
        popd
    ;;
    esac
    count=`echo "${count} + 1" | bc`
done
count=0
for f in `ls *.mp3`; do
    ffmpeg -i ${f} -ar 44100 ${f}.wav
    wavfiles="${wavfiles} ${f}.wav"
done

sox ${wavfiles} output.wav
rm *.mp3.wav *.mp3
