rm(list=ls())

x = rnorm(100)

n = 50

# generate 10 samples and use them to calculate the standard error of our population
lstMeans = vector(length=n)

for (i in 1:n) {
  samp = sample(x, 50)
  lstMeans[i] = mean(samp)
}

mean(lstMeans)
sd(lstMeans)

sd(x)/sqrt(length(x))
mean(x)
