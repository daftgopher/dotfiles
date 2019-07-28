import random
import os
import sys

path = sys.path[0]
files = list(filter(lambda file: file.endswith('.txt'), os.listdir("%s/pokemon_ascii" % path)))
selected = random.sample(files, 1)[0]

f = open('%s/pokemon_ascii/%s' % (path, selected) , "r")

if f.mode == 'r':
    contents = f.read()
    print(contents)
