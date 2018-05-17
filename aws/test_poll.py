#!/usr/bin/env python3

import boto3

client = boto3.client('polly')

response = client.synthesize_speech(
    OutputFormat='mp3',
    SpeechMarkTypes='sentence',
    Text='こんにちは世界。私はポリーです。私の日本語はいかがでしょうか？',
    TextType='text',
    VoiceId='Mizuki'
#    VoiceId='Takumi'
)
