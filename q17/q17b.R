centre <- function(x) {
    lapply(dim(x), function(i) 2:(i - 1))
}

neighbours <- function(x, y, z, w) {
    list(
        (x - 1):(x + 1),
        (y - 1):(y + 1),
        (z - 1):(z + 1),
        (w - 1):(w + 1)
    )
}

pad <- function(x) {
    d <- dim(x)
    n <- array(FALSE, d + 2)
    c <- centre(n)
    n[c[[1]], c[[2]], c[[3]], c[[4]]] <- x
    n
}

update <- function(dat) {
    dat <- pad(dat)
    ndat <- dat
    c <- centre(dat)
    for (x in c[[1]]) {
        for (y in c[[2]]) {
            for (z in c[[3]]) {
                for (w in c[[4]]) {
                    n <- neighbours(x, y, z, w)
                    s <- sum(dat[n[[1]], n[[2]], n[[3]], n[[4]]]) - dat[x, y, z, w]
                    if (dat[x, y, z, w]) {
                        if (!s %in% c(2, 3)) ndat[x, y, z, w] <- FALSE
                    } else {
                        if (s == 3) ndat[x, y, z, w] <- TRUE
                    }
                }
            }
        }
    }
    ndat
}

dat <- do.call(rbind, strsplit(readLines("input.txt"), "")) == "#"
dim(dat) <- c(dim(dat)[1], dim(dat)[2], 1, 1)
dat <- pad(dat)
for (i in 1:6) dat <- update(dat)
sum(dat)

