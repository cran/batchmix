% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotSampledClusterMeans.R
\name{plotSampledClusterMeans}
\alias{plotSampledClusterMeans}
\title{Plot sampled cluster means}
\usage{
plotSampledClusterMeans(samples, burn_in = 0)
}
\arguments{
\item{samples}{The output of the ``batchUnsupervisedMixtureModel`` or
``batchSemiSupervisedMixtureModel`` functions.}

\item{burn_in}{The samples at the beginning of the chain to drop. Defaults to 0.}
}
\value{
A ggplot object of the values in each sampled cluster mean per iteration.
}
\description{
Plot the sampled values for the cluster means in each
dimension from the output of the mixture model functions. Not recommended
for large K or P.
}
\examples{

# Data in matrix format
X <- matrix(c(rnorm(100, 0, 1), rnorm(100, 3, 1)), ncol = 2, byrow = TRUE)

# Observed batches represented by integers
batch_vec <- sample(seq(1, 5), size = 100, replace = TRUE)

# MCMC iterations (this is too low for real use)
R <- 100
thin <- 5

# MCMC samples and BIC vector
samples <- runBatchMix(X, R, thin, batch_vec, "MVN")

# Plot the sampled value of the cluster means against MCMC iteration
plotSampledClusterMeans(samples)

}
