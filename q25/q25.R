v1 <- 12232269
v2 <- 19452773

loop <- 0
x <- 1
while (x != v1) {
    loop <- loop + 1
    x <- (x * 7) %% 20201227
}

x <- 1
for (i in seq_len(loop)) {
    x <- (x * 19452773) %% 20201227
}
print(x)
