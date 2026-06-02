#' Golden Section
#'
#' @param f the function to minimize/ maximize
#' @param interval the interval over which the function is to be evaluated
#' @param tol the toloerance
#' @param max_iter maximum number of iterations
#'
#' @returns a list of useful statistics
#' @export
#'
#' @examples
#' f <- function(x) (x - 2)^2
#' result <- golden_section(f, c(0, 5))
#' print(result)
golden_section <- function(f, interval, tol = 1e-8, max_iter = 1000) {
  # Extract interval
  a <- interval[1]
  b <- interval[2]

  # Golden ratio constant
  tau <- (sqrt(5) - 1) / 2

  # Initial interior points
  x1 <- b - tau * (b - a)
  x2 <- a + tau * (b - a)

  # Evaluate function
  f1 <- f(x1)
  f2 <- f(x2)

  iter <- 0

  while ((b - a) > tol && iter < max_iter) {

    if (f1 < f2) {
      # Minimum is in [a, x2]
      b <- x2

      # Reuse x1
      x2 <- x1
      f2 <- f1

      # Compute new x1
      x1 <- b - tau * (b - a)
      f1 <- f(x1)

    } else {
      # Minimum is in [x1, b]
      a <- x1

      # Reuse x2
      x1 <- x2
      f1 <- f2

      # Compute new x2
      x2 <- a + tau * (b - a)
      f2 <- f(x2)
    }

    iter <- iter + 1
  }

  # Final estimate (midpoint)
  x_min <- (a + b) / 2

  list(
    minimum = x_min,
    objective = f(x_min),
    iterations = iter,
    interval = c(a, b)
  )
}



