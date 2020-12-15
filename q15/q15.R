
part1 <- function(start, n = 2020) {
    x <- start
    while (length(x) <= n) {
        match <- which(x == x[length(x)])
        if (length(match) == 1) {
            x <- c(x, 0)
        } else {
            x <- c(x, -diff(rev(match)[1:2]))
        }
    }
    x
}

part1(c(0,3,6), 12)
part1(c(2, 15, 0, 9, 1, 20))[2020]


# OK so brute force won't work for part 2.
# even with environments -- still too slow :-(

part2 <- function(start, n = 2020) {
    lastpos <- new.env()
    for (i in seq_along(start)) {
        assign(as.character(start[i]), i, envir = lastpos)
    }
    last <- as.character(start[length(start)])
    i <- length(start) + 1
    while (i <= n) {
        if (i %% 100000 == 0) print(i)
        pos <- get(last, lastpos)
        last <- ifelse(length(pos) == 1, 0, diff(tail(pos, 2)))
        last <- as.character(last)
        assign(last, c(lastpos[[last]], i), lastpos)
        i <- i + 1
    }
    last
}

part2(c(0, 3, 6), 2020)
part2(c(2, 15, 0, 9, 1, 20), 2020)
options(scipen = 999)
part2(c(2, 15, 0, 9, 1, 20), 30000000)
