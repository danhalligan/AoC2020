div <- function(x, s) matrix(x, ncol = 2)[, s]

seatid <- function(seat) {
  seat <- c("F" = 1, "B" = 2, "L" = 1, "R" = 2)[seat]
  row <- Reduce(div, seat[1:7], init = 0:127)
  col <- Reduce(div, seat[8:10], init = 0:7)
  row * 8 + col
}

x <- strsplit(readLines("input.txt"), "")
taken <- sapply(x, seatid)

# Part 1
max(taken)

# Part 2
taken <- sort(taken)
taken[which(diff(taken) == 2)] + 1
