# distribution
Covering the major kinds of distributions

<hr>
1. <a href="https://en.wikipedia.org/wiki/Normal_distribution">Normal distribution</a>

According to the **central limit theorem**, with sample size n>=30 (that is, a sufficiently large sample size), regardless the distribution of the population, all the sample mean will follow a (1) normal distribution (a continuous probability distribution), (2) the mean of all samples will be approximately equal to the mean of the population, and (3) the variance of all the sample means will be equal to the variance of the population divided by sample size.

<img src="./images/normal_distribution.png" width="50%" />

<hr>
2. <a href="https://en.wikipedia.org/wiki/Poisson_distribution">Poisson distribution</a>

A **discrete** probability distribution that expresses the probability of a given number of **discrete** events (e.g., number of visitors on an Amazon website) occurring in a fixed interval of time (e.g., between 10:00-10:30pm on a Tuesday night) or space if these events occur with a known constant rate (e.g., on average, there are 1000 visitors between 10-10:30pm on a Tuesday night) and independently of the time since the last event.

Example: the probability of n visitiors between 10-10:30am on a Tuesday night:<br>
<img src="./images/Poisson_distribution.png" width="50%" />

<hr>
3. <a href="https://en.wikipedia.org/wiki/Binomial_distribution">Binomial distribution</a>

A **discrete** probability distribution of the number of successes in a sequence of n independent experiments (e.g., n=10 coins tossed), each asking a yes–no question (e.g., coin toss being a head or tail).

Example: the probability of heads over 10 coin tosses:<br>
<img src="./images/binomial_distribution.png" width="50%" />

Here is a <a href="https://danielyang.shinyapps.io/Binomial_distribution/">Shiny app</a> I created to play around the number of total coin tosses and visualize the changes in the distribution.

<hr>
4. <a href="https://en.wikipedia.org/wiki/Logistic_distribution">Logistic distribution</a>

A continuous probability distribution that has important roles in logistic regression and neural networks.
Its shape looks like a bell shape, but it tends to have heavier tails than a normal distribution

Example: A logistic distribution with mu (location = 10) and s (scale = 1):<br>
<img src="./images/logistic_distribution.png" width="50%" />
