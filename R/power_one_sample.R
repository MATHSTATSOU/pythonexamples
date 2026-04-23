#' Power for a One-Sample Mean Test
#'
#' Computes the power of a one-sample mean test using a normal approximation.
#' The calculation is performed in Python via the \pkg{reticulate} package.
#'
#' @param delta True mean difference (\eqn{\mu - \mu_0}).
#' @param sigma Population standard deviation.
#' @param n Sample size.
#' @param alpha Significance level.
#' @param alternative One of \code{"two-sided"}, \code{"greater"}, or \code{"less"}.
#'
#' @return Numeric value giving the power of the test.
#'
#' @examples
#' one_sample_power(delta = 0.5, sigma = 1, n = 25)
#'
#' @export
one_sample_power <- function(delta,
                             sigma,
                             n,
                             alpha = 0.05,
                             alternative = "two-sided") {

  stopifnot(n > 0, sigma > 0)

  # Locate python directory (installed vs dev)
  python_dir <- system.file("python", package = "pythonexamples")

  if (python_dir == "") {
    # Development mode fallback
    python_dir <- file.path(
      rprojroot::find_package_root_file(),
      "inst", "python"
    )
  }

  # Make python aware of this directory
  reticulate::source_python(
    file.path(python_dir, "power.py")
  )

  # Call the Python function directly
  one_sample_power(
    delta = delta,
    sigma = sigma,
    n = as.integer(n),
    alpha = alpha,
    alternative = alternative
  )
}
