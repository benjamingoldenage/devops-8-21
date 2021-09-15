# Coding Challenge - 002: Trending Topic

The purpose of this coding challenge is to write a program that finds the trending topic from the extracted list of tweets.

## Learning Outcomes

At the end of this coding challenge, students will be able to;

- Analyze a problem, identify, and apply programming knowledge for an appropriate solution.

- Implement conditional statements effectively to solve a problem.

- Implement loops to solve a problem.

- Execute operations on strings.

- Make use of random numbers to solve a problem.

- Decompose the problem into sub-problems and solve them distinctly using functions.

- Implement lists and dictionaries to solve a problem.

- Read files to extract information.

- Demonstrate their knowledge of algorithmic design principles by solving the problem effectively.

## Problem Statement

In this coding challenge, you are going to find the trending topic from the given tweets. Trending topic means the most repeated topic on a given day. You are given
a text file consisting of tweets about "Jerusalem". In the files, the first two elements are date and username. After those, there is the tweet. You have to keep track
of the count of every word in every tweet. And finally, display the top tweets. You are going to display the top tweets as much as the input that is going to be
asked from the user. So if the user gives 5 as an input, you have to display the top 5 trending topics.

- Expected Output:

```text
Please enter a number: 5
Jerusalem
capital
Israel
Palestine
trump
```


## Computational Thinking

### Decomposition

- Find the amount of the words occurring.

- Find the word that occurs the most.

### Algorithm Design

- Step 1: Read the files.

- Step 2: Go through each word in the file and count their occurrences.

- Step 3: After that pick the most occurring words.

- Step 4: Print the most occurring words with respect to the user input.
