% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/checkDataGenerationInputs.R
\name{checkDataGenerationInputs}
\alias{checkDataGenerationInputs}
\title{Check data generation inputs}
\usage{
checkDataGenerationInputs(
  N,
  P,
  group_means,
  group_std_devs,
  batch_shift,
  batch_scale,
  group_weights,
  batch_weights,
  type,
  group_dfs,
  frac_known,
  permute_variables,
  scale_data
)
}
\arguments{
\item{N}{The number of items (rows) to generate.}

\item{P}{The number of columns in the generated dataset.}

\item{group_means}{A vector of the group means for a column.}

\item{group_std_devs}{A vector of group standard deviations for a column.}

\item{batch_shift}{A vector of batch means in a column.}

\item{batch_scale}{A vector of batch standard deviations within a column.}

\item{group_weights}{A K x B matrix of the expected proportion of N in each group in each batch.}

\item{batch_weights}{A vector of the expected proportion of N in each batch.}

\item{type}{A string indicating if data should be generated from
multivariate normal ("MVN") or multivariate t ("MVT") densities.}

\item{group_dfs}{A K-vector of the group specific degrees of freedom.}

\item{frac_known}{The number of items with known labels.}

\item{permute_variables}{Logical indicating if group and batch means and
standard deviations should be permuted in each column or not.}

\item{scale_data}{Logical indicating if data should be mean centred and
standardised.}
}
\value{
No return value, called for side effects.
}
\description{
Checks that the inputs for the ``generateBatchData`` function
are correct. For internal use only.
}
\examples{
N <- 500
P <- 2
K <- 2
B <- 5
mean_dist <- 4
batch_dist <- 0.3
group_means <- seq(1, K) * mean_dist
batch_shift <- rnorm(B, mean = batch_dist, sd = batch_dist)
group_std_devs <- rep(2, K)
batch_scale <- rep(1.2, B)
group_weights <- rep(1 / K, K)
batch_weights <- rep(1 / B, B)
type <- "MVT"
group_dfs <- c(4, 7)
frac_known <- 0.3
permute_variables <- TRUE
scale_data <- FALSE

checkDataGenerationInputs(
  N,
  P,
  group_means,
  group_std_devs,
  batch_shift,
  batch_scale,
  group_weights,
  batch_weights,
  type,
  group_dfs,
  frac_known,
  permute_variables,
  scale_data
)
}
