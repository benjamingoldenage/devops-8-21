from collections import Counter
votes = Counter(["A", "A", "A", "B", "C", "A", "D"])
print ("Most common vote is", votes.most_common(1)[0][0], "Number of votes is", votes.most_common(1)[0][1])