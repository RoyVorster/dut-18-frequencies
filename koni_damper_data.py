import glob
import string
import re

# ADD INPUT FOLDER AND OUTPUT FILE PATH HERE
inFolder = 'DATFiles/'
outFile = 'DATAFILE.m'

## Function used to make names readable
def slugify(s, slug_char): 
    s = s.lower()
    for c in [' ', '-', '.', '/']:
        s = s.replace(c, '_')

    s = re.sub('\W', '', s)

    s = s.replace('_', ' ')
    s = re.sub('\s+', ' ', s)
    s = s.strip()

    if (slug_char):
        s = s.replace(' ', slug_char)
        return s

    s = s.replace(' ', '-')

    return s

## Actually modify data and make file
rep = ['\r', '\n', ',']

getNext = 0
dat = []
lines = []
names = []
for fname in glob.glob(inFolder + '*.asc'):
	f = open(fname, 'rb')
	fdat = [line.decode('cp1252').strip() for line in f.readlines()]
	for line in fdat:
		for i in rep:
			line = line.replace(i, ' ')

		if getNext:
			names.append(line)
			getNext = 0

		if line and line[0] == 'F':
			getNext = 1


		if line and line[0].isdigit():
			line = line.replace('L', '')
			line = line.replace('H', '')
			lines.append(line)

	dat.append(lines)
	lines = []

	f.close()

f = open(outFile, 'w+')

for i in range(len(dat)):
	for j in range(len(dat[i])):
		if j == 0:
			f.write('%s = [%s;\n' % (slugify(names[i],'_'), dat[i][j]))
		elif (j + 1) == len(dat[i]):
			f.write('%s];\n\n' % dat[i][j])
		else:
			f.write('%s;\n' % dat[i][j])

f.close()