m <- 50
n <- 50
k <- 100
a <- array(rnorm(m*n*k), c(m, n, k))

b <- matrix(a, c(m*n, k))

bcor <- cor(b)
diag(bcor) <- NA

cors <- apply(bcor, 2, mean, na.rm = TRUE)
range(cors)
max(cors)
