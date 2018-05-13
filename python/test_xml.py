#!/usr/bin/env python3

import xml.etree.ElementTree as et
import sys

def xmlparse(fn):
    tree = et.ElementTree(file=fn)
    root = tree.getroot()
    for child in root:
        for grandchild in child:
            if grandchild.tag == '{http://purl.org/dc/elements/1.1/}title':
                print(grandchild.text)
                break
        for grandchild in child:
            if grandchild.tag == '{http://purl.org/dc/elements/1.1/}creator':
                print(grandchild.text)
                break


if __name__ == "__main__":
    a = sys.argv
    xmlparse(a[1])


