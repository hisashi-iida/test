#!/usr/bin/env python3

from google.cloud import vision
from google.cloud.vision import types
import sys

content = open(sys.argv[1], 'rb').read()
image = types.Image(content=content)
client = vision.ImageAnnotatorClient()
result = client.text_detection(image=image)
texts = result.text_annotations
for text in texts:
    print(text.description)

