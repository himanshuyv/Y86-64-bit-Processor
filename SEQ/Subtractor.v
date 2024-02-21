`include "Adder.v"
`include "Xor64Bit.v"

module Subtractor(OF,Sum,A,B, enable);
    input [63:0] A;
    input [63:0] B;
    input enable;
    wire [63:0] tempSum;
    output [63:0] Sum;
    wire OverFlow;
    output OF;
    wire [63:0] Bcomplement;
    Xor64Bit Xc(Bcomplement,B,64'hFFFFFFFFFFFFFFFF, 1'b1);
    wire [63:0] TempCarryOut;
    FullAdder X1(TempCarryOut[0],tempSum[0],A[0],Bcomplement[0],1'b1);
    and and_inst2(Sum[0], enable, tempSum[0]);
    genvar i;
    generate
        for (i = 1;i<64;i = i+1)
        begin
            FullAdder X1(TempCarryOut[i],tempSum[i],A[i],Bcomplement[i],TempCarryOut[i-1]);
            and and_inst1(Sum[i], enable, tempSum[i]);
        end
    endgenerate
    xor(AxnorB, A[63], B[63]);
    xnor(AxnorSum, B[63], tempSum[63]);
    and(OverFlow, AxnorB, AxnorSum);
    and and_inst3(OF, enable, OverFlow);
endmodule
