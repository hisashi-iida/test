#!/usr/bin/env bash
count=1
test -f "${1}" || exit -1
rm 000*.txt 000*.mp3.wav 000*.mp3 > /dev/null 2>&1
rm x*.wav > /dev/null 2>&1
test -f mp3files_list.txt && rm mp3files_list.txt
cat ${1} | while read i; do
    head=${i:0:5}
    body="${i:5}"
    mp3file=$(pwd)/$(printf "%06d" ${count}).mp3
    txtfile=$(pwd)/$(printf "%06d" ${count}).txt
    echo "${body}" > ${txtfile}
    case ${head} in
    "[ply]")
        pushd aws > /dev/null
        ./aws_polly.py ${txtfile} ${mp3file} &
        popd > /dev/null
    ;;
    "[gcp]")
        pushd gcp > /dev/null
        ./gcp_tts.py ${txtfile} ${mp3file} j &
        popd > /dev/null
    ;;
    "[vtx]")
        pushd voicetext > /dev/null
        ./voicetext.py ${txtfile} ${mp3file} &
        popd > /dev/null
    ;;
    esac
    count=$(echo "${count} + 1" | bc)
    echo ${mp3file} >> mp3files_list.txt
done
while true; do
    all_mp3files_completed="true"
    for f in $(cat mp3files_list.txt); do
        if test ! -f ${f}; then
            all_mp3files_completed="false"
            break;
        fi
    done
    if test "${all_mp3files_completed}" = "true"; then
        break;
    fi
    sleep 0.1
done
sleep 0.1
wavfiles=""
for f in $(cat mp3files_list.txt); do
    ffmpeg -i ${f} -ar 44100 ${f}.wav > /dev/null 2>&1
    wavfiles="${wavfiles} ${f}.wav"
done
sox ${wavfiles} x1.wav
ffmpeg -i x1.wav -af "atempo=2" x2.wav > /dev/null 2>&1

play x2.wav


rm mp3files_list.txt
rm 000*.txt 000*.mp3.wav 000*.mp3
