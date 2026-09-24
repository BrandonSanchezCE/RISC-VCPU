module Extend(
    input [31:0] In,
    input [2:0]ImmSrc,
    output reg[31:0]ImmExt


);

always @(*) begin
    if (ImmSrc == 3'b000)
        ImmExt = {{20{In[31]}}, In [31:20]}; //I-Type
    else if (ImmSrc == 3'b001)
        ImmExt = {{20{In[31]}}, In[31:25], In[11:7]}; // S-Type
    else if (ImmSrc == 3'b010)
        ImmExt = {{20{In[31]}}, In[7], In[30:25], In[11:8], 1'b0}; // B-Type
    else if (ImmSrc == 3'b011)
        ImmExt = {{12{In[31]}}, In[19:12], In[20], In[30:21], 1'b0}; //J-Type
    else if (ImmSrc == 3'b100)
        ImmExt = {In[31:12],12'b0}; //U-Type
    else 
        ImmExt = 0;
end




endmodule
