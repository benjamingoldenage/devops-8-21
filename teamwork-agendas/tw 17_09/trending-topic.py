def findCounts():
  stopWords = ["a", "about", "above", "after", "again", "against", "all", "am", "an", "and", "any", "are", "aren't", "as", "at", "be", "because", "been", "before", "being", "below", "between", "both", "but", "by", "can't", "cannot", "could", "couldn't", "did", "didn't", "do", "does", "doesn't", "doing", "don't", "down", "during", "each", "few", "for", "from", "further", "had", "hadn't", "has", "hasn't", "have", "haven't", "having", "he", "he'd", "he'll", "he's", "her", "here", "here's", "hers", "herself", "him", "himself", "his", "how", "how's", "i", "i'd", "i'll", "i'm", "i've", "if", "in", "into", "is", "isn't", "it", "it's", "its", "itself", "let's", "me", "more", "most", "mustn't", "my", "myself", "no", "nor", "not", "of", "off", "on", "once", "only", "or", "other", "ought", "our", "ours", "ourselves", "out", "over", "own", "same", "shan't", "she", "she'd", "she'll", "she's", "should", "shouldn't", "so", "some", "such", "than", "that", "that's", "the", "their", "theirs", "them", "themselves", "then", "there", "there's", "these", "they", "they'd", "they'll", "they're", "they've", "this", "those", "through", "to", "too", "under", "until", "up", "very", "was", "wasn't", "we", "we'd", "we'll", "we're", "we've", "were", "weren't", "what", "what's", "when", "when's", "where", "where's", "which", "while", "who", "who's", "whom", "why", "why's", "with", "won't", "would", "wouldn't", "you", "you'd", "you'll", "you're", "you've", "your", "yours", "yourself", "yourselves"]
  myFile = open("tweets_Jerusalem_small.txt","r",encoding="latin-1")
  allWords = []
  counts = []
  for line in myFile:
    tweet = line.strip().split("\t")[2]
    words = tweet.split(" ")
    for word in words:
      if len(word) > 3 and "http" not in word:
        word = word.lower()
        word = word.strip(".,!?:@# ")
        if word not in stopWords:
          if word in allWords:
            counts[allWords.index(word)] += 1
          else:
            allWords.append(word)
            counts.append(1)
  myFile.close()
  return allWords, counts

# find the most freq ones
def findFreqs (words, counts, num):
  for i in range(num):
    maxOccur = max(counts)
    for idx in range(len(counts)):
      if counts[idx] == maxOccur:
        print(words[idx])
        words.pop(idx)
        counts.pop(idx)
        break

# MAIN PROGRAM
n = int(input("Please enter a number: "))
words, counts = findCounts()
findFreqs(words, counts, n)
