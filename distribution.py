#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Feb  7 21:17:50 2018

@author: Daniel Yang (daniel.yj.yang@gmail.com)
"""

import numpy as np
from scipy import stats, exp
from matplotlib import pyplot as plt

# Normal Distribution
mu = 0 # mean
sigma = 1 # standard deviation
x = np.arange(-5,5,0.1)

y = stats.norm.pdf(x, mu, sigma)
plt.figure(num=None, figsize=(8, 6), dpi=80, facecolor='w', edgecolor='k')
plt.plot(x, y)
plt.title('Normal: mu=%.1f, sigma=%.1f'%(mu, sigma))
plt.xlabel('x')
plt.ylabel('Probability density')
plt.ylim(-0.05, 0.45)
plt.show()

y = stats.norm.cdf(x, mu, sigma)
plt.figure(num=None, figsize=(8, 6), dpi=80, facecolor='w', edgecolor='k')
plt.plot(x, y)
plt.title('Normal: mu=%.1f, sigma=%.1f'%(mu, sigma))
plt.xlabel('x')
plt.ylabel('Cumulative distribution')
plt.ylim(-0.1, 1.1)
plt.show()







# Bivariate normal distribution
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import multivariate_normal
#from mpl_toolkits.mplot3d import Axes3D

#Parameters to set
mu_x = 0
variance_x = 1

mu_y = 0
variance_y = 1

#Create grid and multivariate normal
x = np.linspace(-4,4,500)
y = np.linspace(-4,4,500)
X, Y = np.meshgrid(x,y)
pos = np.empty(X.shape + (2,))
pos[:, :, 0] = X; pos[:, :, 1] = Y
rv = multivariate_normal([mu_x, mu_y], [[variance_x, 0], [0, variance_y]])

#Make a 3D plot
fig = plt.figure(num=None, figsize=(8, 6), dpi=300, facecolor='w', edgecolor='k')
ax = fig.gca(projection='3d')
ax.plot_wireframe(X, Y, rv.pdf(pos),rcount=25, ccount=25)
#ax.plot_surface(X, Y, rv.pdf(pos),cmap='viridis',linewidth=0)
ax.set_xlabel('X axis')
ax.set_ylabel('Y axis')
ax.set_zlabel('Z axis')
plt.show()

#Make a 3D plot
fig = plt.figure(num=None, figsize=(8, 6), dpi=300, facecolor='w', edgecolor='k')
ax = fig.gca(projection='3d')
ax.plot_wireframe(X, Y, rv.cdf(pos),rcount=25, ccount=25)
#ax.plot_surface(X, Y, rv.pdf(pos),cmap='viridis',linewidth=0)
ax.set_xlabel('X axis')
ax.set_ylabel('Y axis')
ax.set_zlabel('Z axis')
plt.show()










# Student's t-distribution
mu = 0 # mean
sigma = 1 # standard deviation
df = 1
x = np.arange(-5,5,0.1)

y = stats.t.pdf(x, df, mu, sigma)
plt.figure(num=None, figsize=(8, 6), dpi=80, facecolor='w', edgecolor='k')
plt.plot(x, y)
plt.title('Student\' t-distribution: df=%.0f, mu=%.1f, sigma=%.1f'%(df, mu, sigma))
plt.xlabel('x')
plt.ylabel('Probability density')
plt.ylim(-0.05, 0.45)
plt.show()

y = stats.t.cdf(x, df, mu, sigma)
plt.figure(num=None, figsize=(8, 6), dpi=80, facecolor='w', edgecolor='k')
plt.plot(x, y)
plt.title('Student\' t-distribution: df=%.0f, mu=%.1f, sigma=%.1f'%(df, mu, sigma))
plt.xlabel('x')
plt.ylabel('Cumulative distribution')
plt.ylim(-0.1, 1.1)
plt.show()


# Poisson Distribution
# For discrete outcomes (e.g., the number of customers visiting your lane in a supermarket for check out during 4:30-4:50), with known expected average outcome
# Watch this for the Wal-Mart example (https://www.youtube.com/watch?v=8px7xuk_7OU)
n = np.arange(970, 1030)  # the number of possible occurrences of interest, say the number of visitors that might show up during 10-10:30pm on a Tuesday night
lambda_coef = 1000   # long-run average, say, the expected number of customers in Amazon website between 10:00-10:30pm on a Tuesday night is 1000
y = stats.poisson.pmf(n, lambda_coef)  # Probability Mass Function is the probability density function for discrete outcome
plt.figure(num=None, figsize=(8, 6), dpi=80, facecolor='w', edgecolor='k')
plt.plot(n, y, 'o-')
plt.show()
# Question: What is the probability that exactly 7 customers enter your lane between 4:30-4:45?
print("The probability that exactly 7 customers enter my lane between 4:30-4:45 is {0:.2f}%".format(100*stats.poisson.pmf(7, 10)))




# Bernoulli Distribution
k = np.array([0,1]) # 0 = tail, 1 = head
p = 0.7 # probability of the head
y = stats.bernoulli.pmf(k, p)
fig = plt.figure(num=None, figsize=(8, 6), dpi=80, facecolor='w', edgecolor='k')
ax = fig.add_axes([0,0,1,1])
ax.bar(['0','1'], y)
plt.xlabel('k')
plt.ylim(0,1)
plt.show()


y = stats.bernoulli.cdf(k, p)
fig = plt.figure(num=None, figsize=(8, 6), dpi=80, facecolor='w', edgecolor='k')
ax = fig.add_axes([0,0,1,1])
ax.bar(['0','1'], y)
plt.xlabel('k')
plt.ylim(0,1)
plt.show()





# Binomial Distribution
n = 10 # number of coins tossed
k = np.arange(0,n+1) # number of heads
p = 0.5 # probability of the head
y = stats.binom.pmf(k, n, p)
plt.figure(num=None, figsize=(8, 6), dpi=80, facecolor='w', edgecolor='k')
plt.bar(k,y)
plt.xlabel('k')
plt.plot(k, y, 'o-r')
plt.show()

y = stats.binom.cdf(k, n, p)
plt.figure(num=None, figsize=(8, 6), dpi=80, facecolor='w', edgecolor='k')
plt.bar(k,y)
plt.xlabel('k')
plt.plot(k, y, 'o-r')
plt.show()









# Multinomial Distribution
n = 20 # 10 # 3 # 2 # number of trials (k-sided dice rolled)
p = [1/6, 1/6, 1/6, 1/6, 1/6, 1/6] # probability of the each side of a 6-sided dice, should sum to 1

rv = stats.multinomial(n, p) # A multinomial random variable

x_samples = rv.rvs(size = 1000000, random_state=12345) # draw random samples.
x_samples = np.unique(x_samples, axis = 0)
# each sample consists of number of outcomes for event-1, event-2, ..., event-k, should num to n
# for example, if n = 9, then x = [2, 1, 2, 1, 2, 1] means the each of the odd-number sides (1,3,5) appearing 2 times and each of the even-number sides (2,4,6) appearing 1 time

x_samples.shape # the # of rows is the distinct possible outcomes of rolling the dice n times

y = rv.pmf(x = x_samples)

# Number of occurrences for each side
# [≥1, ≥1, ≥1, ≥1, ≥1, ≥1]
x_samples_subset = x_samples[np.where(
    (x_samples[:, 0] >= 1) &
    (x_samples[:, 1] >= 1) &
    (x_samples[:, 2] >= 1) &
    (x_samples[:, 3] >= 1) &
    (x_samples[:, 4] >= 1) &
    (x_samples[:, 5] >= 1))]

x_samples_subset.shape

y = rv.pmf(x = x_samples_subset)
sum(y)

# Investment example
n = 100
p = [75/100, 20/100, 5/100]
rv = stats.multinomial(n, p) # A multinomial random variable
x_samples = rv.rvs(size = 10000000, random_state=12345) # draw random samples.
x_samples = np.unique(x_samples, axis = 0)
x_samples.shape # the # of rows is the distinct possible outcomes of rolling the dice n times
# Number of occurrences for each side
# [≥1, ≥1, ≥1, ≥1, ≥1, ≥1]
x_samples_subset = x_samples[np.where(
    (x_samples[:, 0] >= 70) &
    (x_samples[:, 1] <= 25) &
    (x_samples[:, 2] <= 5))]

x_samples_subset.shape

y = rv.pmf(x = x_samples_subset)
sum(y)





# Geometric Distribution
k = np.arange(1,11) # number of heads
p = 0.5 # probability of the head
y = stats.geom.pmf(k, p)
plt.figure(num=None, figsize=(8, 6), dpi=80, facecolor='w', edgecolor='k')
plt.bar(k,y)
plt.xlabel('k')
plt.plot(k, y, 'o-r')
plt.show()

y = stats.geom.cdf(k, p)
plt.figure(num=None, figsize=(8, 6), dpi=80, facecolor='w', edgecolor='k')
plt.bar(k,y)
plt.xlabel('k')
plt.plot(k, y, 'o-r')
plt.show()





# Logistic distribution
# https://docs.scipy.org/doc/numpy/reference/generated/numpy.random.logistic.html
loc, scale = 10, 1
s = np.random.logistic(loc, scale, 100000)
count, bins, ignored = plt.hist(s, bins=50)

def logistic_pdf(x, loc, scale):
    return exp((loc-x)/scale)/(scale*(1+exp((loc-x)/scale))**2)

def logistic_cdf(x, loc, scale):
    return 1/(1+(exp((loc-x)/scale)))

plt.plot(bins, logistic_pdf(bins, loc, scale)*count.max()/logistic_pdf(bins, loc, scale).max())
plt.show()

plt.plot(bins, logistic_cdf(bins, loc, scale)*count.max()/logistic_cdf(bins, loc, scale).max())
plt.show()



# Logistic distribution
loc, scale = 10, 1
x = np.arange(-5,25,0.1)
y = stats.logistic.pdf(x, loc, scale) # pdf
plt.figure(num=None, figsize=(8, 6), dpi=80, facecolor='w', edgecolor='k')
plt.plot(x, y)
plt.show()

y = stats.logistic.cdf(x, loc, scale) # cdf
plt.figure(num=None, figsize=(8, 6), dpi=80, facecolor='w', edgecolor='k')
plt.plot(x, y)
plt.show()

# Chi-square distribution
# https://machinelearningmastery.com/statistical-data-distributions/
# plot the chi-squared pdf
from numpy import arange
from matplotlib import pyplot
from scipy.stats import chi2
# define the distribution parameters
sample_space = arange(0, 10, 0.01)
dof = 1 # 3
# calculate the pdf
pdf = chi2.pdf(sample_space, dof)
# plot
pyplot.plot(sample_space, pdf)
pyplot.show()
# calculate the cdf
cdf = chi2.cdf(sample_space, dof)
# plot
pyplot.plot(sample_space, cdf)
pyplot.show()


