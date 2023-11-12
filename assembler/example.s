add x9, x8, x0 # x9=&A[0]
add x10, x0, x0 # sum = 0
add x11, x0 x0 # i = 0
addi x13, x0, 20 # x13 = 20

Loop:
lw x12, 0(x9) # x12=A[i]
add x10, x10, x12 # sum +=
addi x9, x9, 4  # &A[i++]
addi x11, x11, 1 #i ++
blt x11, x13, Loop
