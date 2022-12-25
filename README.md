# Derivative Based Optimization
## Steepest Gradient Descent
The method of steepest descent based on the direction of gradients at a particular point and is calculated using the derivative of the function with respect to the given dimensions. It is different from the gradient descent where step size or learning rate at each and every step is static, however in the case of steepest descent an optimal step size is selected based on the position where minimal level set value of the function is obtained. Here, the step size can identified using the 1D search methods such as golden section or fibonacci search method.

<img src="https://github.com/neofinitycode/Optimization/blob/main/Derivative%20Based/Images/Steepest-Descent.png" width=20% height=20%>

<img src="https://github.com/neofinitycode/Optimization/blob/main/Derivative%20Based/Images/Steepest-Descent_1.png" width=20% height=20%>

## Conjugate Gradient Method
This algorithm tries to identify the directions which are conjugate/perpendicular to all the previously calculated directions in order to move forward towards the convergence without requiring the knowledge of hessian values.

<img src="https://github.com/neofinitycode/Optimization/blob/main/Derivative%20Based/Images/Conjugate-Gradient.png" width=40% height=40%>

<img src="https://github.com/neofinitycode/Optimization/blob/main/Derivative%20Based/Images/Conjugate-Gradient_1.png" width=20% height=20%>

<img src="https://github.com/neofinitycode/Optimization/blob/main/Derivative%20Based/Images/Conjugate-Gradient_2.png" width=20% height=20%>

## Newton's Method
Instead of step size, Newton's method relies on the Hessian value (double derivative) of the function and attempts to reach the local minima within single step but there is a necessary condition that Hessian matrix should be positive definite if the minimization is required else, the algorithm can shoot in different directions without reaching the minimum value. Moreover, it is not guaranteed that Newton's method will always converge and it may stuck in between where the hessian  matrix does not satisfy sylvester's test for positive definite. 

<img src="https://github.com/neofinitycode/Optimization/blob/main/Derivative%20Based/Images/Newton's-Method.png" width=20% height=20%>

### Quasi Newton Method
Since, the computation of inverse of Hessian matrix is expensive, this algorithm came up with the approximation for the inverse of Hessian matrix using objective function and gradient information without calculating the actual inverse using the rank one correlation algorithm

<img src="https://github.com/neofinitycode/Optimization/blob/main/Derivative%20Based/Images/Quasi-Newton.png" width=50% height=50%>

### DFP
Davidon, Fletcher, Powell algorithm deals with the problem associated with Quasi Newton method where Hessian matrix for next iteration may not be positive definite, hence the DFp alogrithm inherits the property of previous iteration's positive definite Hessian matrix to the next iteration's Hessian matrix. But there is also another problem with DFP which is for no-quadratic problems there is a chance for this algorithm getting stuck or in other words finding minima at saddle point since these depends on the curvature of the function.

<img src="https://github.com/neofinitycode/Optimization/blob/main/Derivative%20Based/Images/DFP.png" width=50% height=50%>

### BFGS Method
Here, BFGS tries to approximate the Hessian matrix instead of inverse of the Hessian matrix using the idea of duality.

<img src="https://github.com/neofinitycode/Optimization/blob/main/Derivative%20Based/Images/BFGS.png" width=50% height=50%>


# Derivative Free Optimization
## Genetics Algorithm
A genetic algorithm is an optimization technique which is derivative free and based on randomization by analyzing the fitness function (objective function) of the population. The idea of genetic algorithms starts from selecting initial points at random called as initial population. Then evaluate the objective functions for the initial population, this evaluation helps in creation of new population. By delving deeper into this creation of new population there are certain manipulation/operations are performed called as cross-over and mutation. Repeating this procedure number of times until any stopping criteria (number of generations, difference of objective function between previous and current generation is small, etc) is met.

![alt text](https://github.com/neofinitycode/Optimization/blob/main/Derivative%20Free/Images/GA_flow.png)

### Chromosomes and Representation Schemes:
Since, genetic algorithms used for various optimization problems where real-valued optimal values are identified through iterative process. Hence, to represent the initial population of such problems there is encoding that has to be performed initially in order to understand mutation and cross-over easy. This encoding maps the real values to a set consisting of string of symbols with equal length which are termed as chromosomes, a common set used is binary string. The representation scheme identifies the length of the chromosome, once the scheme is identified initialize the population by selecting random points. However, in the case of Travelling Salesman Problem encoding is not required and each chromosome can be considered as the one of the path from origin city to the destination city by travelling each city once and this path may or may not be optimal in general, it is chosen at random and many of such random paths create initial population. 

### Evaluation:
Once the initial population is generated objective function is calculated for each of the chromosome for example in our case, it is the total distance from origin to destination city 
### Selection and Evolution:
For the first stage apply an operation of selection, where a set of mating pool is segregated equal to the initial population size based on random procedure such as for each chromosome proportion of objective function for that chromosome with total of all objective value for whole population is identified. Now, there exists two techniques for the selection of chromosome of which one is roulette wheel within, multiple chromosome are assigned to same slots and randomly from those slots chromosomes are picked and appended to the mating pool. One the other hand the other approach is tournament scheme where, select two chromosomes at random and compare their fitness value whichever is higher keep it in mating pool and similarly, perform this until the mating pool size is equal to population size.

<img src="https://github.com/neofinitycode/Optimization/blob/main/Derivative%20Free/Images/Selection.png" width=20% height=20%>

Next stage is the evolution where cross-over and mutation happens. The cross-over operation considers pair of chromosomes called as parents and generates a new off-spring chromosomes as given in the figure below, however the cross-over rate has to be chosen beforehand in order to cross those number of bits in the chromosome but the position may differ but number is constant.

<img src="https://github.com/neofinitycode/Optimization/blob/main/Derivative%20Free/Images/cross-over.png" width=50% height=50%>

Furthermore, mutation operation which takes each chromosome from the mating pool and randomly changes the order of the bits given by figure below or in the case of TSP change the order of subarray for a path and place it to different location in the whole path without having repeats since, we want to visit each city once. Here, as well there exist mutation rate which is the number of bits that can be changed and is given as an initial/static values.

![alt text](https://github.com/neofinitycode/Optimization/blob/main/Derivative%20Free/Images/mutation.png)
