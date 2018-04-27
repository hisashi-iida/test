#!/usr/bin/python3

import xml.etree.ElementTree as et

tree = et.ElementTree(file='test.xml')
root = tree.getroot()
print(root.tag)
for child in root:
    print('tag:', child.tag, 'attributes:', child.attrib)
    for grandchild in child:
        print('    tag:', grandchild.tag)
        print('    attributes:', grandchild.attrib)
        print('    text:', grandchild.text)


