# Compile Project
iverilog -g2012 -o pc -c ../link/file_list.txt
vvp pc 
gtkwave pc_tb.vcd &
