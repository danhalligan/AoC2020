f = open("input.txt", "r")
dat = f.readlines()

seen = set()
acc = 0
line = 0
while True and line not in seen:
    seen.add(line)
    instruction, num = dat[line].split(" ")
    if instruction == "nop":
        line += 1
    elif instruction == "acc":
        acc += int(num)
        line += 1
    elif instruction == "jmp":
        line += int(num)
    else:
        print("Error!")

print(acc)