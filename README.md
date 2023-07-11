# rv32_processor

<h3>Datapath Pipeline </h3><br>
![alt text](diagrams/block_diagrams/Datapath Pipeline.png)
Right Now IMEM is a 4Kb Instruction Cache.  No method of fetching from main memory or dynamic cache transfer <br>
To be added later <br>
<h3>Risc V RV32I Instruction Format </h3><br>
<h4> Instruction Variants </h4> <br>
Type R, I, S, B, U, J <br>
(Image from RV32I Specification Section 2.3: https://riscv.org/wp-content/uploads/2019/06/riscv-spec.pdf) <br>
![alt text](https://github.com/sprsr/rv32_processor/blob/main/diagrams/standard/rv32i_formats.png)
<h4> Immediate Construction Format </h4><br>
Important to the Immediate Generator located in immGen/immGen.v <br>
![alt text](https://github.com/sprsr/rv32_processor/blob/main/diagrams/standard/rv32i_immediate_formats.png)
Control Unit <br>
pc_sel Signal <br> 
![alt text](https://github.com/sprsr/rv32_processor/blob/main/diagrams/block_diagrams/pc_sel.png)
![alt text](https://github.com/sprsr/rv32_processor/blob/main/diagrams/block_diagrams/pc_sel2.png)
