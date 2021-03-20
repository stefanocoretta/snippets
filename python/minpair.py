x = ["puku", "piku", "buku", "baku", "beku", "siku", "sikun", "tekun", "sekun"]

def minpair(wordlist):
    for n1,word1 in enumerate(wordlist):
        for word2 in wordlist[n1+1:]:
            if len(word1)==len(word2):
                ndiff=0
                for n,letter in enumerate(word1):
                    if word2[n]!=letter:
                        ndiff+=1
                if ndiff==1:
                        print (word1, word2)




### My version


def minpair_same(x):
    y = {}
    for s in range(len(x)):
        if s < len(x) - 1:
            for word in x:
                y[word] = {}
                wordtwo = x[s+1]
                y[word][wordtwo] = []
                for i in range(len(word)):
                    if word[i] == wordtwo[i]:
                        y[word][wordtwo].append("Yes")
                    else:
                        y[word][wordtwo].append("No")
                if y[word][wordtwo].count("No") == 1:
                    print wordtwo + " " + word

def minpair(x):
    l_max = len(max(x, key= len))
    l_min = len(min(x, key= len))
    z = []
    for s in range(l_min, l_max + 1):
        for word in x:
            if len(word) == s:
                z.append(word)
        minpair_same(z)
        z = []














def minimalpair(x):
    for word in x:
        for s in range(0,len(x)):
            wordtwo = x[s]
            for i in range(len(word)):
                if word[i] == x[s][i]:
                    print word + " - " + wordtwo + " " + "Yes"
                else:
                    print word + " - " + wordtwo + " " + "No"

def minpair(x):
    y = {}
    for word in x:
        y[word] = []
        for s in range(len(x)):
            y[word].append([])
            for i in range(len(word)):
                if word[i] == x[s][i]:
                    y[word][s].append("Yes")
                else:
                    y[word][s].append("No")
    return y

def minpair(x):
    y = {}
    for word in x:
        y[word] = {}
        for s in range(len(x)):
            wordtwo = x[s]
            y[word][wordtwo] = []
            for i in range(len(word)):
                if word[i] == x[s][i]:
                    print "YES"
                else:
                    print "NO"
    return y

# Script for minimal pairs: works with list of same length words only and pairs are repeated
def minpair(x):
    y = {}
    for word in x:
        y[word] = {}
        for s in range(len(x)):
            wordtwo = x[s]
            y[word][wordtwo] = []
            for i in range(len(word)):
                if word[i] == x[s][i]:
                    y[word][wordtwo].append("Yes")
                else:
                    y[word][wordtwo].append("No")
            if y[word][wordtwo].count("No") == 1:
                print word + " " + wordtwo

def lista(x):
    l_max = len(max(x, key= len))
    print l_max
    l_min = len(min(x, key= len))
    print l_min
    z = []
    for s in range(l_min, l_max + 1):
        for word in x:
            if len(word) == s:
                z.append(word)
        print z
        minpair(z)
        z = []


# Function for minimal pairs: same length only but does not repeat pairs
def minpair(x):
    y = {}
    for s in range(len(x)):
        if s < len(x) - 1:
            for word in x:
                y[word] = {}
                wordtwo = x[s+1]
                y[word][wordtwo] = []
                for i in range(len(word)):
                    if word[i] == wordtwo[i]:
                        y[word][wordtwo].append("Yes")
                    else:
                        y[word][wordtwo].append("No")
                if y[word][wordtwo].count("No") == 1:
                    print word + " " + wordtwo
    print y
