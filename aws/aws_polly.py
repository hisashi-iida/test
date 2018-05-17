#!/usr/bin/env python3

def aws_polly(textfile, outputfile):
    import boto3
    response = boto3.client('polly').synthesize_speech(
        OutputFormat='mp3',
        Text=open(textfile, 'r').read(),
        TextType='text',
        VoiceId='Mizuki'
    )
    open(outputfile, 'wb').write(response['AudioStream'].read())

if __name__ == '__main__':
    import sys
    argv = sys.argv
    aws_polly(argv[1], argv[2])

