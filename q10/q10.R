options(scipen=999)

x <- read.table("input.txt")[[1]]
x <- sort(c(0, x, max(x) + 3))

# part a
prod(rle(sort(diff(x)))$lengths)

# part b
r <- rle(diff(x))
prod(c(1,2,4,7)[r$lengths[r$values == 1]])

