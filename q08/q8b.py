import copy

def validate(dat):
    seen = set()
    acc = 0
    line = 0
    while True and line not in seen:
        if line >= len(dat):
            return acc
        seen.add(line)
        instruction, num = dat[line]
        if instruction == "nop":
            line += 1
        elif instruction == "acc":
            acc += num
            line += 1
        elif instruction == "jmp":
            line += num
        else:
            raise Exception("Error!")
    return False

f = open("input.txt", "r")
dat = f.readlines()
dat = [x.split(" ") for x in dat]
dat = [[x[0], int(x[1])] for x in dat]

for i in range(len(dat)):
    tdat = copy.deepcopy(dat)
    if tdat[i][0] == "nop":
        tdat[i][0] = "jmp"
    elif tdat[i][0] == "jmp":
        tdat[i][0] = "nop"
    if validate(tdat):
        break

validate(tdat)