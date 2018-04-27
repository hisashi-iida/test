class Animal:
    def __init__(self, kind, name, color):
        self.kind = kind
        self.name = name
        self.color = color
        self.is_transformed = False

    def transform(self, newcolor):
        if self.is_transformed:
            print('animal can transform only once')
            return False
        self.color = newcolor
        self.is_transformed = True
        return True

    def printcolor(self):
        print(self.color)


cat = Animal('cat', 'mike', 'white')

cat.printcolor()
cat.transform('black')
cat.printcolor()
cat.transform('yellow')
cat.printcolor()

dict = {'red': '赤', 'blue': '青', 'yellow': '黄色'}
print(dict['red'])
print(dict['yellow'])
print(dict['blue'])
str = 'red blue yellow'
new_str = str.replace('red', '赤')

print(str)
print(new_str)

i = 1
str = i.__str__()
tmp = str + new_str
print(tmp)