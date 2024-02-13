module FullAdder(Cout,S,A,B,Cin);
    input A,B,Cin;
    output Cout,S;
    wire S1out,C1out,C2out;
    xor g1(S1out,A,B);
    xor g2(S,S1out,Cin);
    and g3(C1out,A,B);
    and g4(C2out,S1out,Cin);
    or g5(Cout,C1out,C2out);
endmodule

module Adder(OF,Sum,A,B, enable);
    input [63:0] A;
    input [63:0] B;
    input enable;
    output [63:0] Sum;
    wire [63:0] sum;
    wire OverFlow;
    output OF;
    wire [63:0] TempCarryOut;
    FullAdder X1(TempCarryOut[0],sum[0],A[0],B[0],1'b0);
    and and_inst1(Sum[0], enable, sum[0]);
    genvar i;
    generate
        for (i = 1;i<64;i = i+1)
        begin
            FullAdder X1(TempCarryOut[i],sum[i],A[i],B[i],TempCarryOut[i-1]);
            and and_inst2(Sum[i], enable, sum[i]);
        end
    endgenerate

    xnor(AxnorB, A[63], B[63]);
    xor(AxorSum, A[63], sum[63]);
    and(OverFlow, AxnorB, AxorSum);
    and and_inst3(OF, enable, OverFlow);
endmodule