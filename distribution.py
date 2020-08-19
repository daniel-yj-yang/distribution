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





# Binomial Distribution
n = 10 # number of coins tossed
k = np.arange(0,n+1) # number of heads
p = 0.5 # probability of the head
y = stats.binom.pmf(k, n, p)
plt.figure(num=None, figsize=(8, 6), dpi=80, facecolor='w', edgecolor='k')
plt.plot(k, y, 'o-')
plt.show()



# Logistic distribution
# https://docs.scipy.org/doc/numpy/reference/generated/numpy.random.logistic.html
loc, scale = 10, 1
s = np.random.logistic(loc, scale, 10000)
count, bins, ignored = plt.hist(s, bins=50)

def logist(x, loc, scale):
    return exp((loc-x)/scale)/(scale*(1+exp((loc-x)/scale))**2)
plt.plot(bins, logist(bins, loc, scale)*count.max()/logist(bins, loc, scale).max())
plt.show()




# Chi-square distribution
# https://machinelearningmastery.com/statistical-data-distributions/
# plot the chi-squared pdf
from numpy import arange
from matplotlib import pyplot
from scipy.stats import chi2
# define the distribution parameters
sample_space = arange(0, 50, 0.01)
dof = 20
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
