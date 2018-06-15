
In this exercise, we will implement a similar technique that is used nowadays as part in radar tracking applications.
Using a state space description of the kinematics of a ship, we will develop a predictor that can predict the position
of the ship and provides us with an uncertainty region. For that purpose, the mean and the covariance matrix of the
state will be propagated in time. But before we can actually implement the prediction we must find a suitable state
space model that can describe the process. For that purpose, we use a registration of the path of ship.
