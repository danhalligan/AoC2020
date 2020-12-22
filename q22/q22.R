x <- readLines("input.txt")

decks <- list(
    as.numeric(x[2:26]),
    as.numeric(x[29:53])
)

decks <- list(
    c(9,2,6,3,1),
    c(5,8,4,7,10)
)

i <- 0
while (all(sapply(decks, length) > 0)) {
    play <- c(decks[[1]][1], decks[[2]][1])
    decks[[1]] <- decks[[1]][-1]
    decks[[2]] <- decks[[2]][-1]
    decks[[which.max(play)]] <- c(decks[[which.max(play)]], rev(sort(play)))
    i <- i + 1
}

winner <- which(sapply(decks, length) > 0)
score <- sum(decks[[winner]] * length(decks[[winner]]):1)


#### Part b #####

# do two rounds match
match <- function(r1, r2) {
    all(identical(r1[[1]], r2[[1]]), identical(r1[[2]], r2[[2]]))
}

# does a round match any previous rounds
anymatch <- function(rounds, round)  {
    if (!length(rounds)) return(FALSE)
    any(sapply(rounds, match, r2 = round))
}

round <- function(decks) {
    # cat("-- Round --\n")
    # cat("Player 1: ", paste(decks[[1]], collapse = ", "), "\n")
    # cat("Player 2: ", paste(decks[[2]], collapse = ", "), "\n")
    play <- c(decks[[1]][1], decks[[2]][1])
    # cat("Player 1 plays: ", play[1], "\n")
    # cat("Player 2 plays: ", play[2], "\n")
    decks[[1]] <- decks[[1]][-1]
    decks[[2]] <- decks[[2]][-1]
    if (length(decks[[1]]) >= play[1] && length(decks[[2]]) >= play[2]) {
        # recurse
        subdecks <- list(decks[[1]][seq_len(play[1])], decks[[2]][seq_len(play[2])])
        res <- game(subdecks)
        winner <- res$winner
    } else {
        winner <- which.max(play)
    }
    # cat("Player", winner, "wins\n")
    if (winner == 2) play <- rev(play)
    decks[[winner]] <- c(decks[[winner]], play)
    list(winner = winner, decks = decks)
}

game <- function(decks) {
    rounds <- list()
    while (all(sapply(decks, length) > 0)) {
        if (anymatch(rounds, decks)) {
            winner <- 1
            break
        }
        rounds <- append(rounds, list(decks))
        out <- round(decks)
        winner <- out$winner
        decks <- out$decks
    }
    list(winner = winner, decks = decks)
}

game(list(c(9,2,6,3,1), c(5,8,4,7,10)))

game(list(as.numeric(x[2:26]), as.numeric(x[29:53])))

