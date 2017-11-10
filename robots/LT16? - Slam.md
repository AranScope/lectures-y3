# LT16 - SLAM

- Simultaneous location and mapping
- Occupancy grid representation of space
- 2 sources of error: odometry and distance sensing

## Inverse sensor models
We can process our sensor readings to remove erroneous values. We do this by learning an inverse sensor model.

With Bayes we come up with an observation model, so what is the probability of the hypothesis given the data.

The only hypothesis we can have about a grid cell, is it has something in it or not. So when we apply Bayes we can reason about each grid cell independently. The cells aren't independent but this assumption simplifies the amount of computation we have to do.

Train our neural network to know the probability of occupancy by a certain object, given images


OPTICS clustering then bayesian inference on the centroids?