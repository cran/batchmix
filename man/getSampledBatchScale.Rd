% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getSampledBatchScale.R
\name{getSampledBatchScale}
\alias{getSampledBatchScale}
\title{Get sampled batch shift}
\usage{
getSampledBatchScale(
  sampled_batch_scale,
  B = dim(sampled_batch_scale)[2],
  P = dim(sampled_batch_scale)[1],
  R = dim(sampled_batch_scale)[3],
  thin = 1
)
}
\arguments{
\item{sampled_batch_scale}{A 3D array of sampled batch mean shifts.}

\item{B}{The number of batches present. Defaults to the number of columns in
the batch mean matrix from the first sample.}

\item{P}{The dimension of the batch mean shifts. Defaults to the number of
rows in the batch mean matrix from the first sample.}

\item{R}{The number of iterations run. Defaults to the number of slices in
the sampled batch mean array.}

\item{thin}{The thinning factor of the sampler. Defaults to 1.}
}
\value{
A data.frame of three columns; the parameter, the sampled value and the iteration.
}
\description{
Given an array of sampled batch scales from the
``mixtureModel`` function, acquire a tidy version ready for ``ggplot2`` use.
}
\examples{

# Data in matrix format
X <- matrix(c(rnorm(100, 0, 1), rnorm(100, 3, 1)), ncol = 2, byrow = TRUE)

# Observed batches represented by integers
batch_vec <- sample(seq(1, 5), size = 100, replace = TRUE)

# MCMC iterations (this is too low for real use)
R <- 100
thin <- 5

# MCMC samples
samples <- runBatchMix(X, R, thin, batch_vec, "MVN")

batch_scale_df <- getSampledBatchShift(samples$batch_scale, R = R, thin = thin)

}
