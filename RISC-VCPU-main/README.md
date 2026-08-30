Project Overview: Building a single-cycle RV32I core using a Basys 3 FPGA and synthesising on Vivado. VSCode will be used with verilog. Using the book "Digital Design and Computer Architecture RISC-V Edition" book written by sarah L Harris and David Money Harris as a guide. 




## Scope: To run programs in Vivado first, then using the Basys3 with switches as input and LEDs as output.


## Module List: 
## State Elements:
Register File(regfile): The module where register values are stored. 2 addresses, each able to point at the same 32 registers. A third address is stored where I can write into a register if writeEnable3 is on. Otherwise, the writeData should not be written. The readData1 and readData2 are combinatorialm, while writing data is based on a clock. Register x0 should always display 0 when read and should not be able to be written into.

Data Memory(DATAM): Stores 32-bit data and reads it based on the address pointed to by the input address. Writes data into that address if writeEnable is on. Uses a clock for writing, 
but reading should be combinatorial. Stored in 32-bit words.

Instruction Memory (INSTRM): Stores 32-bit instructions and reads it based on what the 32-bit address points at. Purely combinatorial.

PC(PC): Relatively easy to write. The program counter that fetches instructions on a clock based on PCNext. Resets the PC to 0 if reset is turned on immediately.

## Additional Elements:

PCPlus4: Combinatorially increments the current PC value by 4. This serves as a way to go through the instructions and keeps running if left unbothered.

Extend: Extends the Immediate to a 32 bit string in case it is chosen as source B for the ALU. Extends depending on the type of instruction. The type of Instruction is chosen using the ImmSrc.

PCTarget: Takes the Immediate Extension and adds it to the PCTarget. This is used for offsetting the PCTarget, which can be useful for  Branching or Jumping

ALU: Performs an operation based on a ALUControl. It gets inputs from 2 Source  A and Source B. Source A is the ReadAddress1 from the register file, while Source B is either ReadAddress2 or the Immediate Extended from the Extend module, based on a ALU Source input from the Control Unit. The ALU can add, subtract, compare using AND or OR bitwise, and determine whether A is less than B, where the Result is 0 if A is greater than B, and 32'd1 if A is less than B. The Result is always 32 bits. If the Result is 0, a separate output Zero is turned on, which can be used for branching purposes. A Message will show during simulation if the ALUControl happens to be 111. 

ALUDecoder: Decodes and determines the ALU Operation based on the Funct3, Funct7 bit 5, the Operation bit 5, and the ALUOp. If the ALUOp is 2'b00, the ALUControl adds, which is used for I and S-type instructions. O If the ALUOp is 2'b01, the ALUControl subtracts, which is useful for Branch Equal. If the ALUControl is 2'b10, than a certain operation from the ALU is performed based on whatever combination of funct3 and Opb5funct7b5 (Strewn together) match the table provided by Harris & Harris. If there is any combination of the inputs that do not match to an output ALUControl, then ALUControl will output 111, which will ping an error in the ALU.

MainDecoder: Decodes the Operation Code from the instructions and outputs many different functions based on the type of instruction we want. The outputs are Register Write, Memory Write, ALUSource, Result Source, Branch, Immediate Source, ALU Operation, and Jump, which all are determined based on what the specific operation code is used. For example, the operation code "0000011" Is a loadwrite I type, which would have Register Write on to save the value wanted to the register, Immediate Source to 0, which is an I-type Extension, ALU Source to 1, since we want the Immediate Extension to be added with the ReadAddress1, Memory Write to 0, since we are loading into the register, not the data memory, Result Source to 2'b01, which is source that matches to ReadData from the Data Memory, Branch to 0, since we are not branching, ALUOp to 2'b00, which matches to loadwrite and adds automatically, and finally jump, which is zero since we are not jumping.

Control Unit: This combines the MainDecoder and ALUDecoder together, using the ALUOp output from the Main Decoder, and directly feeding that into the ALUDecoder. Otherwise, the Outputs are mostly the same, except there is an additional output PC Source, which determines whether to use the PC Plus 4 module, or the PC Target Module. This is based on whether Zero and Branch are on, which determines whether it is time to branch to the PCTarget, or if Jump is on, which jumps to the address on the PCTarget. 

DataPath: This module shows the path of data within the computer. The info starts at the PC, which ideally has the address of 0, which is the start of the instructions. The data flows to the instruction memory, which outputs the instructions at address[0]. That instruction then splits to do many different things. Some of the instructions go to point at the Address1 input and the Address2 input of the register file. The whole instruction goes to into the Extend module have its immediate properly extended depending on the instruction type. Afterwards, the ALU recieves the data based on what the control units determines is correct to go into it. The Result of the ALU is used for the address of the DataMemory, which is saved again depending on nthe control unit. Finally, the Result of either the output of the DataMemory, the ALUResult, or the PCPlus4 are used and fed into WriteData3 in the register file. Separately, the PCPlus4 module takes the Program file and increments by four combinatorially. The PCTarget module uses the PC value and offsets it by the ImmExt value to determines where to branch/jump if the instructions requires so. Finally, both of those values go into a Mux, where the selector PC source comes from the Source unit. 

Top Module: Combines both the datapath and Control unit together to create a functional microprocessor. The inputs reset and clk are included to control when to reset the PC and to have a clock for the processor.

ClockDivider: Mainly used to see the processor "think" instead of immediately doing the processes. Works in 0.5 second cycles.




 ## Testing:
All tested using the simulation feature on Vivado, using test benches and $display messages to determine whether the modules are working as intended.

Register file (regfile): Tested whether attempting to write into register 0 will do anything by attempting to write into register 0x when writeEnable3 is on, whether rD1 and rD2 are displaying correctly by pointing at register 3 and 7 using address 1 and 2 respectively and checking readData 1 and readData 2. Tested whether writeData was properly transferring data to the register that address3 is pointing at when writeEnable3 is on. Tested whether turning off writeEnable3 would prevent data from being written into address3. Tested whether rD1 and rD2 will display 0 if pointed to register 0x, even if register 0x happens to have a value for some reason.

Data Memory(DATAM): Tested whether writeData value gets properly writes to the data index the address points to when writeEnable is on. Also tested whether turning off write enable stops the write data from writing into the data index being pointed to

Instruction Memory (INSTRM): Tested whether poitning at any certain instruction gives the correct instruction value at that index based on the address.

PC(PC): Tested whether the reset immediately switched the PC to 0 and then whether the PCNext properly transfers to the PC.

After this, I only tested certain modules to save time. I chose to do the ALU, since it's the main operations that affect the rest of the modules greatly, the extend since it was important that the immediate was correct for every instruction type, and the top module, to  make sure everything was working well.

ALU: Tested to see whether all the operations would work correctly. Also tested to see if the Zero would turn on and off depending on the ALUResult. 

Extend: Tested to see that each instruction type would have its proper immediate. Reverse engineered the Extension to find the proper IN, so that each Extension would be the same. 

TopModule: Tested whether everything was working correctly. Tested every instruction type available (I,R,Load,Save,Branch,Jump) and various cases for each.

## Implementation:
 A simple implementation where a password must be inserted into the BASYS 3 board using the switches on it. When the password is inputed, all the LEDs will be on, showing that the password was correct. If the switches are wrong after inputting the password, the LEDs will stop being on.