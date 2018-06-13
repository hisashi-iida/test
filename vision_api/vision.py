#!/usr/bin/env python3
import io
import os

# Imports the Google Cloud client library
from google.cloud import vision
from google.cloud.vision import types

# Instantiates a client
client = vision.ImageAnnotatorClient()

# The name of the image file to annotate
#file_name = os.path.join(
#    os.path.dirname(__file__),
#        'resources/wakeupcat.jpg')

import sys
argv = sys.argv
file_name = argv[1];

# Loads the image into memory
with io.open(file_name, 'rb') as image_file:
    content = image_file.read()

    image = types.Image(content=content)

# Performs text detection on the image file
response = client.text_detection(image=image)
texts = response.text_annotations

print('Labels:')
for text in texts:
        print(text.description)

