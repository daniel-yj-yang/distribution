#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Feb  7 21:17:50 2018

@author: Daniel Yang (daniel.yj.yang@gmail.com)
"""

import numpy as np
from scipy import stats
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
n = np.arange(0, 30)  # the number of possible occurrences of interest, say the number of customers that might show up during 4:30-4:45pm
lambda_coef = 10   # long-run average, say, the expected number of customers in Walmart cashier lane between 4:30-4:45pm is 10
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