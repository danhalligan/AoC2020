div <- function(parts) {
  function(x, selection) {
    split(x, rep(parts, each = length(x)/2))[[selection]]
  }
}

seatid <- function(seat) {
  row <- Reduce(div(c("F", "B")), seat[1:7], init = 0:127)
  col <- Reduce(div(c("L", "R")), seat[8:10], init = 0:7)
  row * 8 + col
}

x <- strsplit(readLines("input.txt"), "")
taken <- sapply(x, seatid)

# Part 1
max(taken)

# Part 2
taken <- sort(taken)
as.numeric(taken[which(diff(taken) == 2)] + 1)
