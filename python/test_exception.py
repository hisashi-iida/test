
short_list = [1, 2, 3]
position = 5

try:
    short_list[position]

except Exception as err:
    print('caught an exception (', err, ')')
    print('need a position between 0 and', len(short_list)-1, 'but got', position)

short_list[position]