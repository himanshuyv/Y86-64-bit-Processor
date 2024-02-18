module And64Bit(Out,A,B, enable);
    input [63:0] A;
    input [63:0] B;
    output [63:0] Out;
    input enable;
    genvar i;
    generate
        for (i = 0;i < 64;i = i+1)
        begin
            and X1(Out[i],A[i],B[i] , enable);
        end
    endgenerate
endmodule