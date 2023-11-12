from riscv_assembler.convert import AssemblyConverter as AC
# instantiate
convert = AC(output_mode = 'f', nibble_mode = True, hex_mode = False)

# Convert a whole .s file to text file
convert("test.s" "test.out")

# Convert string of assembly to bin
#cnv_str = "add x1 0x 0x\nadd x2 x0 x1"
#convert(cnv_str, "result.bin")


# Convert a string and print output with no nibbles
#convert.output_mode = 'p'
#convert.nibble_mode = False
#convert.convert(cnv_str)


# Convert a string and save to array
#convert.output_mode = 'a'
#result = convert(cnv_str)

