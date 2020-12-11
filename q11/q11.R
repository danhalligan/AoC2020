library(dplyr)

update <- function(x) {
    d1 <- nrow(x)
    d2 <- ncol(x)
    y <- matrix(NA, d1 + 2, d2 + 2)
    y[1 + (1:d1), 1 + (1:d2)] <- x
    i <- 1:length(y)
    dim(i) <- dim(y)
    i <- i[1 + (1:d1), 1 + (1:d2)]
    dim(i) <- NULL
    ry <- nrow(y)
    nx <- tibble(
            pos = i,
            seat = y[i],
            n1 = y[i - ry - 1],
            n2 = y[i - ry],
            n3 = y[i - ry + 1],
            n4 = y[i - 1],
            n5 = y[i + 1],
            n6 = y[i + ry - 1],
            n7 = y[i + ry],
            n8 = y[i + ry + 1]
        ) %>%
        rowwise() %>%
        mutate(
            n_occupied = sum(c_across(n1:n8) == "#", na.rm = TRUE),
            new = case_when(
                seat == "L" && n_occupied == 0  ~ "#",
                seat == "#" && n_occupied >= 4  ~ "L",
                TRUE ~ seat
            )
        )
    matrix(nx$new, nrow = d1, ncol = d2)
}

x <- read.table("input.txt", stringsAsFactors = FALSE)[[1]]
mat <- do.call(rbind, strsplit(x, ''))

i <- 0
while(TRUE) {
    print(i)
    new <- update(mat)
    if (all(new == mat)) break
    mat <- new
    i <- i + 1
}
sum(mat == "#")
