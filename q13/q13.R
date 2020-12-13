options(scipen = 999)
x <- read.table("input.txt")
time <- as.numeric(x[1,1])
buses <- x[2,1]
buses <- as.numeric(na.omit(as.numeric(strsplit(buses, ',')[[1]])))

# part a
wait <- buses - (time %% buses)
min(wait) * buses[which.min(wait)]

# part b
buses <- x[2,1]
buses <- as.numeric(as.numeric(strsplit(buses, ',')[[1]]))
delays <- which(!is.na(buses))
buses <- buses[!is.na(buses)]

# find lower common multiple starting from start and incrementing by increment
lcm <- function(buses, delays, start, increment) {
  i <- 0
  found <- c()
  while (TRUE) {
    n <- i * increment + start
    if (all((n + delays) %% buses == 0)) found <- c(found, n)
    if (length(found) == 2) break
    i <- i + 1
  }
  found
}

## odd algorithm, but it works...
## we don't want to test every number, so we find options that work for 2
## buses, then expand to 3 and so on. We only test numbers that are valid for
## previous buses at each step.
cur <- c(1, 2)
for (m in 2:length(buses)) {
  cur <- lcm(buses[1:m], delays[1:m], cur[1], diff(cur))
}
cur[1] + 1
