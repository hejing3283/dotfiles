#!/usr/bin/python
#J.HE
#desp: split big file into smaller ones according to first colunm(tab delimited)
#input: <file to split> <optional: selected key file> 
#ouput: <tempFolder with all splitted file>


usage = 'python splitByKey.py \
        -h help \
        -i[ifile=] <input file> \
        -o[ofile="temp-"+ifile] optional\
        -s[buffersize=1000] optional\
        -k[keyfile=''] optional'
example = 'python /Volumes/ac_lab/jh3283/scripts/projFocus/ceRNA/processData/splitByKey.py \
        -i test.mat \
        -o testOut \
        -s 20 \
        -k gene.list'


##---funcS
def debugPrintDict(d):
    for k,v in d.iteritems():
        print k,v
##---funcE


ERR = "ERROR"
import sys,getopt
import os,collections
argv = sys.argv[1:]
input = ''
keyfile = ''
output = ''
bufferSize = 500
try:
    opts,args = getopt.getopt(argv,"hi:o:s:k:",\
    ["ifile=","ofile=","buffersize=","odir="])
except getopt.GetoptError:
    print usage + "\n" + example 
    sys.exit(2)
for opt, arg in opts:
    if opt == '-h':
        print usage + "\n" + example 
        sys.exit()
    elif opt in ("-i","--ifile"):
        input = arg
    elif opt in ("-s","--buffersize"):
        bufferSize = long(arg)
    elif opt in ("-k","--keyfile"):
        keyfile = arg
    elif opt in ("-o","--odir"):
        output = arg

CWD = os.path.abspath('.')    
if not output:
    output = output+ "-temp"
    # ### check if input is abspath or relative path later...
    # go ahead with abspath now 
else:
    pass
print('Script path:\t'+ sys.argv[0])
print('Input file:\t' + input)
print('Output folder:\t'+ output)

if keyfile:
    keylist=[]
    with open(keyfile) as f:
        keylist=[line.strip().split("\t",1)[0] for line in f.readlines()]
    keyLen = len(keylist)
    print "input key number\t" + str(keyLen)
    keyDict = dict.fromkeys(keylist)
else:
    keyDict = collections.defaultdict(set)

if not os.path.exists(output):
    os.mkdir(output)
    os.chdir(output)
else:
    os.chdir(output)
    ### os.listdir() take relative path, need to improve 
    for the_file in os.listdir(output):
        file_path = os.path.join(output, the_file)
        try:
            os.remove(file_path)
        except:
            pass

def writeFile(file,value):
    outputH = open(file,'a')
    outputH.write(value)
    outputH.close()
with open(input, buffering=1000000) as f:
    line = f.readline()
    while line:
        key,val = line.strip().split(None,1)    
        valPrev = keyDict.get(key,[])      
        if valPrev and len(valPrev) >= bufferSize:
            writeFile(key,"".join(valPrev))
            keyDict[key] = []
        elif not valPrev:
            try:
                if key in keylist:
                    keyDict[key] = [line]
            except:
                keyDict[key] = [line]
        else:
            try:
                if key in keylist:
                    keyDict[key].append(line)
            except:
                keyDict[key].append(line)          
        line = f.readline()

for k, v in keyDict.items():
    try:
        lv = len(v)
        if lv > 1:
            writeFile(k,"".join(v))
        else:
            writeFile(k, v)
    except:
        pass
    
os.chdir(CWD)
print "[=====END=====]"

