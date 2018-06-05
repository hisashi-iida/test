#!/usr/bin/env python3

def translate(infile, outfile,target):
    # Imports the Google Cloud client library
    from google.cloud import translate
    translate_client = translate.Client()
    text = open(infile, 'r').read()
    translation = translate_client.translate(
        text,
        target_language=target)
    open(outfile, 'w').write(u'{}'.format(translation['translatedText']))

if __name__ == '__main__':
    import sys
    argv = sys.argv
    translate(argv[1], argv[2], argv[3])

