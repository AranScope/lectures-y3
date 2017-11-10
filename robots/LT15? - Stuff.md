# LT15? - Stuff

Given how much he's been talking about advanced planning (MDP, dynamic programing etc.) should we be worried about how our project doesn't really cover any of that.

Instead of creating a context map of the world we could integrate exploration and object mapping together, so the robot can find a table without knowing if one exists at the start of the plan. Rewards would be based on how similar the object is to a table e.g. a chair is similar to a table, we could use word2vec to calculate the similarity of objects, or by similarity of the colour profiles of the image?

Q learning will eventually converge on the reward values that value iteration would calculate. There is a theorem that proves this.

Bellmans curse of dimensionality as we have to iterate over all the states.

In reality both actions and states are a continuous space