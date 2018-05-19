#!/usr/bin/env bash
count=1
test -f "${1}" || exit -1
rm 000*.txt 000*.mp3.wav 000*.mp3
rm x*.wav
test -f list.txt && rm list.txt
cat ${1} | while read i; do
    head=${i:0:5}
    body="${i:5}"
    mp3file=$(pwd)/$(printf "%06d" ${count}).mp3
    txtfile=$(pwd)/$(printf "%06d" ${count}).txt
    echo "${body}" > ${txtfile}
    case ${head} in
    "[ply]")
        pushd aws
        ./aws_polly.py ${txtfile} ${mp3file} &
        popd
    ;;
    "[gcp]")
        pushd gcp
        ./gcp_tts.py ${txtfile} ${mp3file} j &
        popd
    ;;
    "[vtx]")
        pushd voicetext
        ./voicetext.py ${txtfile} ${mp3file} &
        popd
    ;;
    esac
    count=$(echo "${count} + 1" | bc)
    echo ${mp3file} >> list.txt
done
while true; do
    tts_complete="true"
    for f in $(cat list.txt); do
        if test ! -f ${f}; then
            tts_complete="false"
            break;
        fi
    done
    if test "${tts_complete}" = "true"; then
        break;
    fi
    sleep 0.5
done
sleep 1
rm list.txt
for f in $(ls *.mp3 | sort); do
    ffmpeg -i ${f} -ar 44100 ${f}.wav > /dev/null
    wavfiles="${wavfiles} ${f}.wav"
done
sox ${wavfiles} x1.wav
rm 000*.txt 000*.mp3.wav 000*.mp3
#ffmpeg -i x1.wav -af "atempo=0.7" x0_7.wav
#ffmpeg -i x1.wav -af "atempo=1.5" x1_5.wav
ffmpeg -i x1.wav -af "atempo=2" x2.wav > /dev/null
#ffmpeg -i x1.wav -af "atempo=1.25,atempo=2" x2_5.wav
#ffmpeg -i x1.wav -af "atempo=1.5,atempo=2" x3.wav
#ffmpeg -i x1.wav -af "atempo=1.75,atempo=2" x3_5.wav
#ffmpeg -i x1.wav -af "atempo=2,atempo=2" x4.wav

play x2.wav
