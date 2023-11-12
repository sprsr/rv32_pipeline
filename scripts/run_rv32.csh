# Compile Project
iverilog -g2012 -o rv32 -c ../link/file_list.txt
vvp rv32
gtkwave rv32_tb.vcd &
