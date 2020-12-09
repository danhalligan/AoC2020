x <- read.table("input.txt")[[1]]

# part 1
prod(x[which(sapply(x, function(i) any(i + x == 2020)))])

dat <- expand.grid(a = x, b = x)
match <- which(rowSums(dat) == 2020)[1]
prod(as.numeric(dat[match, ]))

# part 2
dat <- expand.grid(a = x, b = x, c = x)
match <- which(rowSums(dat) == 2020)[1]
prod(as.numeric(dat[match, ]))
