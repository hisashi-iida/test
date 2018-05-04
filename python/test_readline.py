#!/usr/local/bin/python3


infn='test.txt'

f = open(infn, 'r')
line = f.readline();
print('line #1 is :', line)
line = f.readline();
print('line #2 is :', line)
f.close()



