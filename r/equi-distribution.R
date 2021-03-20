# A function that takes a specified number of equidistant objects on a scale (like word frequency)


equiDistr <- function(x, n) {
  x <- unique(x)
  N <- length(x)
  ideal <- seq(min(x),max(x),(max(x)-min(x))/(n-1))
  cost.mat  <- outer(ideal, x, function(z, y) abs(z-y))
  row.signs <- rep("==", n)
  row.rhs   <- rep(1, n)
  col.signs <- rep("<=", N)
  col.rhs   <- rep(1, N)
  sol <- lp.transport(cost.mat, "min", row.signs, row.rhs, col.signs, col.rhs)$solution
  final <- x[apply(sol, 1, which.max)]
  return(final)
}