x <- read.table("input.txt")[[1]]

# Part 1
valid <- function(n) x[n] %in% colSums(combn(x[(n-25):(n-1)], 2))
num <- x[which(!sapply(26:length(x), valid)) + 25]

# Part 2
library(zoo)
for (len in 2:1000) if (any(rollapply(x, len, sum) == num)) break
i <- which(rollapply(x, len, sum) == num)
sum(range(x[i:(i+len-1)]))
