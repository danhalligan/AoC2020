library(stringr)
library(dplyr)
library(readr)

x <- read_delim("input.txt", " ", col_names = c("range", "char", "pass")) %>%
    mutate(char = str_extract(char, "^\\w")) %>%
    mutate(min = as.numeric(str_extract(range, "^\\d+"))) %>%
    mutate(max = as.numeric(str_extract(range, "\\d+$")))

# Q1
check_pass <- function(pass, char, min, max, ...) {
    count <- sum(str_split(pass, "")[[1]] == char)
    count >= min && count <= max
}

sum(pmap_lgl(x, check_pass))

# Q2
check_pass_v2 <- function(pass, char, min, max, ...) {
    (str_sub(pass, min, min) == char) + (str_sub(pass, max, max) == char) == 1
}

sum(pmap_lgl(x, check_pass_v2))
