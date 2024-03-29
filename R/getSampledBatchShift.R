#!/usr/bin/Rscript
#' @title Get sampled batch shift
#' @description Given an array of sampled batch mean shifts from the
#' ``mixtureModel`` function, acquire a tidy version ready for ``ggplot2`` use.
#' @param sampled_batch_shift A 3D array of sampled batch mean shifts.
#' @param B The number of batches present. Defaults to the number of columns in
#' the batch mean matrix from the first sample.
#' @param P The dimension of the batch mean shifts. Defaults to the number of
#' rows in the batch mean matrix from the first sample.
#' @param R The number of iterations run. Defaults to the number of slices in
#' the sampled batch mean array.
#' @param thin The thinning factor of the sampler. Defaults to 1.
#' @return A data.frame of three columns; the parameter, the sampled value and the iteration.
#' @export
#' @examples
#'
#' # Data in matrix format
#' X <- matrix(c(rnorm(100, 0, 1), rnorm(100, 3, 1)), ncol = 2, byrow = TRUE)
#'
#' # Observed batches represented by integers
#' batch_vec <- sample(seq(1, 5), size = 100, replace = TRUE)
#'
#' # MCMC iterations (this is too low for real use)
#' R <- 100
#' thin <- 5
#'
#' # MCMC samples
#' samples <- runBatchMix(X, R, thin, batch_vec, "MVN")
#'
#' batch_shift_df <- getSampledBatchShift(samples$batch_shift,
#'   R = R,
#'   thin = thin
#' )
#'
#' @importFrom tidyr pivot_longer contains
getSampledBatchShift <- function(sampled_batch_shift,
                                 B = dim(sampled_batch_shift)[2],
                                 P = dim(sampled_batch_shift)[1],
                                 R = dim(sampled_batch_shift)[3],
                                 thin = 1) {
  # Check that the values of R and thin make sense
  if (floor(R / thin) != dim(sampled_batch_shift)[3]) {
    stop("The ratio of R to thin does not match the number of samples present.")
  }

  # Stack the sampled matrices on top of each other
  sample_df <- data.frame(t(apply(sampled_batch_shift, 3L, rbind)))

  # Indices over columns and batches
  col_inds <- seq(1, P)
  batch_inds <- seq(1, B)

  # Give sensible column names
  colnames(sample_df) <- paste0(
    "M_",
    sort(as.numeric(levels(interaction(batch_inds, col_inds, sep = ""))))
  )

  # Add a variable for the iteration the sample comes from
  iterations <- seq(1, R / thin) * thin
  sample_df$Iteration <- iterations

  # Pivot to a long format ready for ``ggplot2``
  long_sample_df <- tidyr::pivot_longer(sample_df, tidyr::contains("M_"))
  long_sample_df$Dimension <- rep(col_inds, nrow(long_sample_df) / P)
  long_sample_df$Batch <- rep(batch_inds, nrow(long_sample_df) / (B * P),
    each = P
  )

  long_sample_df
}
