`include "Xor64Bit.v"

module tb_Xor64Bit;
    reg [63:0] A;
    reg [63:0] B;
    wire [63:0] Out;
    reg enable;
    Xor64Bit DUT(Out,A,B,enable);
    initial begin
        $dumpfile("tb_Xor64Bit.vcd");
        $dumpvars(0,tb_Xor64Bit);
        $monitor ($time, "A=%b, B=%b, Out=%b", A, B,Out);
        A <= 1;
        B <= 2;
        enable <= 1;
        #10; 
        A <= 3;
        B <= 4;
        $finish;
    end
endmodule