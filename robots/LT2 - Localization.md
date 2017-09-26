# LT2 - Localization
## Where am I?
- Knowing where you are is a key problem in robotics.
- Hard in mobile platforms because 
    - No direct way of knowing where you are
    Indirect methods involve unreliable data
- The problem is (mostly) addressed by probabilistic frameworks.

## Combining evidence
- Start with a belief (all possible locations)
- Cut down belief by combining it with new data to form a new belief
- Repeat process. reducing overall belief and hence, number of possible places for agent
- This is non-probabilistic and relies on all candidates acting independently

## Combining uncertain evidence
- Instead of yes/no, return a number between [0, 1]
- This is the certainty of matching the data set
- Data is now called the 'data likelihood', in contains the likelihood of the agent being in that space
- To find a new belief: multiply current belief cell value with data cell value
- Belief is a probability distribution, add values sum to 1
- Data is a likelihood as the values don't sum to 1
- New belief is no longer a probability distribution so needs to be converted back
- To do this add up all cell values and divide each by the sum of the cell values
- As probability accumulates, more likely areas gain higher probabilities
- This allows possibility to recover from a failed sensor (given a good sensor model)
- This is a recursive bayesian filter

## Bayes' rule
$$    
\begin{equation}
    x+1 = 2 \\
    y+2 = 3 
\end{equation}
$$
## Bayes' rule recap
