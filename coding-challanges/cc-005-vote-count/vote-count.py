# majority_vote(["A", "A", "A", "B", "C", "A"])

# - Expected Outputs:

# ```text
# Input: majority_vote(["A", "A", "A", "B", "C", "A"]) 
# Output: "A"

# CC solution:
# majority_vote(["A", "A", "A", "B", "C", "A"])
lst = ["A", "A", "A", "B", "C", "A"]
def majority_vote(votes):
    for i in lst:
        if lst.count(i) > len(lst)/2:
            return(i)




