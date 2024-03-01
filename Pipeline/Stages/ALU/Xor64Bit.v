module Xor64Bit(Out,A,B, enable);
    input [63:0] A;
    input [63:0] B;
    wire [63:0] out;
    input enable;
    output [63:0] Out;
    genvar i;
    generate
        for (i = 0;i < 64;i = i+1)
        begin
            xor X1(out[i],A[i],B[i]);
            and and_inst(Out[i], enable, out[i]);
        end
    endgenerate
endmodule