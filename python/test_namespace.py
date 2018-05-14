
def myfunc(arg):
    from inspect import currentframe, getframeinfo
    frameinfo = getframeinfo(currentframe())
    print(frameinfo.filename, '(', frameinfo.lineno, ')')
#    print('filename is', function.__name__, 'filename is ')


animal = 'fruitbat'


def print_globals():
    print('inside print_global:', animal)
    animal = 'wombat'
    print('inside print_global:', animal)


myfunc("hoge")
print_globals()