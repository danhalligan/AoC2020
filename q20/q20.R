options(scipen = 9999)
options(width = 100)

parse_data <- function(file) {
    x <- readLines(file)
    gaps <- which(x == "")
    titles <- x[c(1, gaps + 1)]
    titles <- sub("Tile (\\d+):", "\\1", titles)
    starts <- c(2, gaps + 2)
    ends <- c(gaps - 1, length(x))
    tiles <- lapply(seq_along(titles), function(i) x[starts[i]:ends[i]])

    parse_tile <- function(tile) {
        do.call(rbind, strsplit(tile, ""))
    }
    tiles <- lapply(tiles, parse_tile)
    names(tiles) <- titles
    tiles
}

# rotae 90 clockwise
rotate <- function(tile) t(apply(t(tile), 1, rev))

flip <- function(tile) t(apply(tile, 1, rev))

# verbose...
gen_tiles <- function(tile) {
    list(
        tile,
        rotate(tile),
        rotate(rotate(tile)),
        rotate(rotate(rotate(tile))),
        flip(tile),
        rotate(flip(tile)),
        rotate(rotate(flip(tile))),
        rotate(rotate(rotate(flip(tile))))
    )
}

# We save rotated images into a list.
# This looks up the index of that using i and j
ind <- function(i, j) (i - 1) * d + j


# check image can be added to grid by looking at previously assigned images
valid <- function(grid, rotation, i, j, x) {
    if (i > 1) {
        prev <- rotation[[ind(i-1, j)]]
        if (!all(prev[, 10] == x[, 1])) return(FALSE)
    }
    if (j > 1) {
        prev <- rotation[[ind(i, j-1)]]
        if (!all(prev[10, ] == x[1, ])) return(FALSE)
    }
    return(TRUE)
}

# recursive backtracking
# place a tile in a given orientation in top left, then try to place valid tiles
# to fill in the rest of the grid. Backtrack if we fail...
rsolve <- function(grid, rotation) {
    for (i in 1:nrow(grid)) {
        for (j in 1:ncol(grid)) {
            if (is.na(grid[i, j])) {
                for (name in setdiff(names(tiles), grid)) {
                    options <- gen_tiles(tiles[[name]])
                    for (r in seq_along(options)) {
                        if (valid(grid, rotation, i, j, options[[r]])) {
                            grid[i, j] <- name
                            rotation[[ind(i,j)]] <- options[[r]]
                            print(grid)
                            o <- rsolve(grid, rotation)
                            if (!is.null(o)) return(o)
                            grid[i, j] <- NA
                            rotation[[ind(i,j)]] <- NULL
                        }
                    }
                }
                return(NULL)
            }
        }
    }
    return(list(grid, rotation))
}

# part a
tiles <- parse_data("input.txt")
d <- sqrt(length(tiles))
grid <- matrix(NA,  nrow = d, ncol = d)
rotation <- list()
solution <- rsolve(grid, rotation)
grid <- solution[[1]]
corners <- c(grid[1,1], grid[1, d], grid[d, 1], grid[d, d])
corners <- as.numeric(corners)
prod(corners)


# part b
image <- solution[[2]]
image <- lapply(image, function(x) x[2:9, 2:9])
image <- lapply(1:d, function(i) do.call(rbind, image[1:d + (d * (i - 1))]))
image <- do.call(cbind, image)

# this is not quite right since this might find monsters that run off the end
# of a row. So, it might overcount...
find_monsters <- function(img) {
    regex <- "(?=..................#..{76}#....##....##....###.{76}.#..#..#..#..#..#...)"
    imagestr <- apply(img, 1, paste0, collapse = "")
    imagestr <- paste0(imagestr, collapse = "")
    if (grepl(regex, imagestr, perl = TRUE)) {
        length(gregexpr(regex, imagestr, perl = TRUE)[[1]])
    } else {
        0
    }
}

monsters <- sum(sapply(gen_tiles(image), find_monsters))
sum(image == "#") - (15 * monsters)
