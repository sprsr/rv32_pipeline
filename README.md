# rv32_processor <br>
Starting with a Basic 5 stage pipeline that handles RV32I with minimal control logic.  <br>
Would like to add peripherals and support for other RV standards and extensions <br> 

Datapath Pipeline 
![Alt text](https://github.com/sprsr/rv32_processor/blob/main/diagrams/block_diagrams/Datapath%20Pipeline.png)

Right Now IMEM is a 4Kb Instruction Cache.  No method of fetching from main memory or dynamic cache transfer <br>
To be added later <br> <br> <br>

Risc V RV32I Instruction Format <br>
Instruction Variants  <br>
Type R, I, S, B, U, J <br>
(Image from RV32I Specification Section 2.3: https://riscv.org/wp-content/uploads/2019/06/riscv-spec.pdf) <br>
![alt text](https://github.com/sprsr/rv32_processor/blob/main/diagrams/standard/rv32i_formats.png) <br>
Immediate Construction Format <br>
Important to the Immediate Generator located in immGen/immGen.v <br>
![alt text](https://github.com/sprsr/rv32_processor/blob/main/diagrams/standard/rv32i_immediate_formats.png)
<br> <br> <br>
Control Unit <br>
pc_sel Signal <br> 
![alt text](https://github.com/sprsr/rv32_processor/blob/main/diagrams/block_diagrams/pc_sel.png)
![alt text](https://github.com/sprsr/rv32_processor/blob/main/diagrams/block_diagrams/pc_sel2.png)

Current Status <br>
11/6/23 : Currently adding instructions into control unit <br>
Inst  BrEq	BrLT	a_sel	b_sel	alu_sel	mem_wr	RegWEn	immSel	BrUn	pc_sel	wb_sel

Ctl   1 2 3 4 5 6 7 8 9 A B
LUI	  x	x	0	1	9	0	1	4	x	0	1
AUIPC	x	x	1	1	2	0	1	4	x	0	1
JAL	  x	x	1	1	2	0	1	5	x	1	2
JALR	x	x	0	1	2	0	1	1	x	1	2
BEQ	  0	x	0	0	2	0	0	3	x	0	x
BEQ	  1	x	0	0	2	0	0	3	x	1	x
BNE	  1	x	0	0	2	0	0	3	x	0	x
BNE	  0	x	0	0	2	0	0	3	x	1	x
BLT	  x	0	0	0	2	0	0	3	0	0	x
BLT	  x	1	0	0	2	0	0	3	0	1	x
BGE	  x	0	0	0	2	0	0	3	0	1	x
BGE	  x	1	0	0	2	0	0	3	0	0	x
BLT	  x	0	0	0	2	0	0	3	1	0	x
BLT	  x	1	0	0	2	0	0	3	1	1	x
BGE	  x	0	0	0	2	0	0	3	1	1	x
BGE	  x	1	0	0	2	0	0	3	1	0	x
LB	  x	x	0	1	2	0	1	1	0	0	0
LH	  x	x	0	1	2	0	1	1	0	0	0
LW	  x	x	0	1	2	0	1	1	0	0	0
LBU	  x	x	0	1	2	0	1	1	0	0	0
LHU	  x	x	0	1	2	0	1	1	0	0	0
SB	  x	x	0	1	2	1	0	2	0	0	0
SH	  x	x	0	1	2	1	0	2	0	0	0
SW	  x	x	0	1	2	1	0	2	0	0	0
ADDI	x	x	0	1	2	0	1	1	0	0	1
STLI	x	x	0	1	8	0	1	1	0	0	1

