# rv32_processor

Datapath Pipeline 
![Alt text](https://github.com/sprsr/rv32_processor/blob/main/diagrams/block_diagrams/Datapath%20Pipeline.png)

Right Now IMEM is a 4Kb Instruction Cache.  No method of fetching from main memory or dynamic cache transfer <br>
To be added later <br> <br> <br>

Risc V RV32I Instruction Format <br>
Instruction Variants  <br>
Type R, I, S, B, U, J <br>
(Image from RV32I Specification Section 2.3: https://riscv.org/wp-content/uploads/2019/06/riscv-spec.pdf) <br>
![alt text](https://github.com/sprsr/rv32_processor/blob/main/diagrams/standard/rv32i_formats.png)
Immediate Construction Format <br>
Important to the Immediate Generator located in immGen/immGen.v <br>
![alt text](https://github.com/sprsr/rv32_processor/blob/main/diagrams/standard/rv32i_immediate_formats.png)
<br> <br> <br>
Control Unit <br>
pc_sel Signal <br> 
![alt text](https://github.com/sprsr/rv32_processor/blob/main/diagrams/block_diagrams/pc_sel.png)
![alt text](https://github.com/sprsr/rv32_processor/blob/main/diagrams/block_diagrams/pc_sel2.png)
