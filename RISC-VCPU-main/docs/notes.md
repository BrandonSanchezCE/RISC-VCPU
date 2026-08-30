Name Register Number Use
zero x0 Constant value 0
ra x1 Return address
sp x2 Stack pointer
gp x3 Global pointer
tp x4 Thread pointer
t0−2 x5−7 Temporary registers
s0/fp x8 Saved register/Frame pointer
s1 x9 Saved register
a0−1 x10−11 Function arguments/Return values
a2−7 x12−17 Function arguments
s2−11 x18−27 Saved registers
t3−6 x28−31 Temporary registers

Shifting a value left by N multiplies it by 2^n and right divides it by 2^n


Types of instructions:
R-Type instructions: Uses three registers as operands: two as sources and one as a destination. 32 bits. Encodes rd = rs1 OP rs2
    7-bit op is the operation code. funct7 and funct3 are the function fields. These together determine what to do with the two source codes. 
I-Type Instructions: uses 2 register operands and one immediate operand. 32 bits Encodes rd = rs1 OP immediate
    12-bit immediate field. Only one source register. Also has a 7 bit operation code and a funct3, but not a funct 7.
S/B-Type instructions: Uses 2 register operands and one immediate operand. 32 bits. S-type stores rs2 into address rs1 + immediate. B-type encodes if (rs1 == rs2) PC += immediate 
    Both registers are source registers. It replaces the rd and funct 7 with an immediate imm. Therefore, the S-type immediate is split between whree the funct 7 would go, and where the rd would go in an R-type instruction, while the 
U-Type instructions: Uses one destination register, an operation code, and a 20 bit immediate. 32 bits. Encodes rd = immediate <<12(lui) or rd = PC +  (immediate << 12) (auipc)

J-Type Instructions:  Similar to U-Type but the immediate value is formattech imm20, 10:1, 11, 19:12, 0.


Immediate Encodings - RISC-V usese 32-bit signed immediates. Only 12 to 21 bits of the immediate are encoded in the insturction. The immediate for I and S use  instruction[31:20] for it's imm[11:0] and instruction[31] for imm[31:12]
S-type uses imm[11:5] = instr[31:25], imm[4:0] = instr[11:7], and imm[31:12] = instr[31] sign extend. 


Mode: An addressing mode defines how an instruction specifies its operands.

Register-Only Addressing: uses registers for all sources and destination operands.

Immediate Addressing: Uses an immediate, along with registers, as operands.

Base Addressing: Adds the base address in register rs1 to the sign-extended 12-bit found in the immediate field.

PC-Relative Addressing: The singned offset encoded in the immediate field is added to the PC to obtain the targest address, the new PC.

