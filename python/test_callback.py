def edit_story(words, func):
    for word in words:
        print(func(word))


def enliven(word):
    return word.capitalize() + '!'


stairs = ['thud', 'meow', 'thud', 'hiss']

edit_story(stairs, enliven)

# 無名関数lambda
print('lambda')
edit_story(stairs, lambda word: word.capitalize() + '!')

