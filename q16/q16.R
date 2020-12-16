options(scipen = 999)

# nasty parsing to begin with
parse_dat <- function(file) {
    dat <- readLines(file)
    gaps <- which(dat == "")
    rules <- list()
    for (rule in dat[0:(gaps[1] - 1)]) {
        s <- strsplit(rule, ": ")[[1]]
        name <- s[1]
        ranges <- strsplit(s[2], " or ")[[1]]
        ranges <- lapply(strsplit(ranges, "-"), as.numeric)
        ranges <- lapply(ranges, function(v) v[1]:v[2])
        rules[[name]] <- unlist(ranges)
    }

    ticket <- as.numeric(strsplit(dat[gaps[1] + 2], ",")[[1]])

    nearby <- strsplit(dat[(gaps[2] + 2):length(dat)], ",")
    nearby <- lapply(nearby, as.numeric)
    list(rules = rules, ticket = ticket, nearby = nearby)
}

dat <- parse_dat("input.txt")

# part a
invalid <- lapply(dat$nearby, function(t) {
    valid <- sapply(dat$rules, function(r) t %in% r)
    valid <- rowSums(valid) >= 1
    t[!valid]
})
sum(unlist(invalid))

# part b
valid <- sapply(dat$nearby, function(t) {
    valid <- sapply(dat$rules, function(r) t %in% r)
    valid <- rowSums(valid) >= 1
    all(valid)
})

vdat <- do.call(rbind, dat$nearby[valid])
assigns <- c()
possible <- lapply(dat$rules, function(rule) {
    which(apply(vdat, 2, function(v) all(v %in% rule)))
})
while (length(assigns) < 20) {
    known <- which(sapply(possible, length) == 1)
    assigns <- c(assigns, possible[known])
    possible <- lapply(possible, setdiff, assigns)
}
keep <- assigns[grep("departure", names(assigns))]
prod(dat$ticket[as.numeric(keep)])
