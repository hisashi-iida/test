#!/usr/bin/env bash

export GOOGLE_APPLICATION_CREDENTIALS=`pwd`/ttstest_sa.json

NUM=1
currfile=`printf "%06d" ${NUM}`
test -f ${currfile}.txt && rm ${currfile}.txt
total=0

cat "${1}" | while read line; do
    echo "${line}" >> ${currfile}.txt
    nchars=`echo ${line} | wc -m`
    total=`echo "${total} + ${nchars}" | bc`

    if test ${total} -gt 3000; then
        if test -f ${currfile}.mp3; then
            echo ${currfile}.mp3 is already exist
        else
            echo ${total}
            for i in {1..10}; do
                time ./test_tts.py ${currfile}.txt ${currfile}.mp3 j && break;
                sleep 5;
            done
        fi
        NUM=`echo "${NUM} + 1" | bc`
        currfile=`printf "%06d" ${NUM}`
        test -f ${currfile}.txt && rm ${currfile}.txt
        total=0
    fi
done

if test ${total} -gt 0; then
    echo ${total}
    time ./test_tts.py ${currfile}.txt ${currfile}.mp3 j
fi

for mp3file in `ls *.mp3`; do
    bn=`basename ${mp3file} .mp3`
    wavfile=${bn}.wav
    ffmpeg -i ${mp3file} ${wavfile} > /dev/null
done

sox `ls *.wav | sort` 000000.wav


METAFILE=metadata.opf
TITLE="`./parse_metadata.py ${METAFILE} t` (GCP TTS)"
ARTIST=`./parse_metadata.py ${METAFILE} c`
ALBUM="${TITLE}"
CART="cover.jpg"

#sox 000000.wav -r 44100 -c 2 "${TITLE}.wav" echo  1.0 0.75 100 0.3 reverb
sox 000000.wav -r 44100 -c 2 "${TITLE}.wav" echo  1.0 0.3 100 0.05
lame --tt "${TITLE}" --tl "${ALBUM}" --ta "${ARTIST}" --ti "${CART}" "${TITLE}.wav" "${TITLE}.mp3"

