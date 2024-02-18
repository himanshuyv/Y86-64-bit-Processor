`include "And64Bit.v"
`include "Subtractor.v"

module decoder(input s0, input s1, output A, output B, output C, output D);
and(A, !s0, !s1);
and(B, !s0, s1);
and(C, s0, !s1);
and(D, s0, s1);
endmodule

module ALU_Wrapper(OF,out,control, A, B);
input [1:0] control;
input [63:0] A;
input [63:0] B;
output [63:0] out;
wire [63:0] difference;
wire [63:0] sum;
wire [63:0] andout;
wire [63:0] xorout;
output OF;
wire OF_Adder;
wire OF_Subtractor;
wire Aen, Ben, Cen, Den;
decoder decoder_inst(.s0(control[1]), .s1(control[0]), .A(Aen), .B(Ben), .C(Cen), .D(Den));
Adder adder_inst(.OF(OF_Adder), .Sum(sum), .A(A), .B(B), .enable(Aen));
And64Bit And64Bi_inst(.Out(andout), .A(A), .B(B), .enable(Cen));
Xor64Bit Xor64Bit_inst(.Out(xorout), .A(A), .B(B), .enable(Den));
Subtractor Subtractor_inst(.OF(OF_Subtractor), .Sum(difference), .A(A), .B(B), .enable(Ben));
or(OF, OF_Subtractor, OF_Adder);
genvar i;
generate
    for (i = 0;i<64;i = i+1)
    begin
        or(out[i] , sum[i], andout[i], xorout[i], difference[i]);
    end
endgenerate
endmodule