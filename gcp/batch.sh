#!/usr/bin/env bash

NUM=1
currfile=`printf "%06d" ${NUM}`
test -f ${currfile}.txt && rm ${currfile}.txt
total=0

cat "${1}" | while read line; do
    echo "${line}" >> ${currfile}.txt
    nchars=`echo ${line} | wc -m`
    total=`echo "${total} + ${nchars}" | bc`

    if test ${total} -gt 3000; then
        ./test_tts.py ${currfile}.txt ${currfile}.mp3 j
        NUM=`echo "${NUM} + 1" | bc`
        currfile=`printf "%06d" ${NUM}`
        test -f ${currfile}.txt && rm ${currfile}.txt
        total=0
    fi
done

if test ${total} -gt 0; then
    ./test_tts.py ${currfile}.txt ${currfile}.mp3 j
fi

for mp3file in `ls *.mp3`; do
    bn=`basename ${mp3file} .mp3`
    wavfile=${bn}.wav
    ffmpeg -i ${mp3file} ${wavfile} > /dev/null
done

sox `ls *.wav | sort` 999999.wav

sox 999999.wav -r 44100 -c 2 "${1}.wav" echo  1.0 0.75 100 0.3 reverb

METAFILE=metadata.opf
TITLE=`./parse_metadata.py ${METAFILE} t`
ARTIST=`./parse_metadata.py ${METAFILE} c`
ALBUM="${TITLE}"
CART="cover.jpg"

lame --tt "${TITLE}" --tl "${ALBUM}" --ta "${ARTIST}" --ti "${CART}" "${1}.wav" "${1}.mp3"

