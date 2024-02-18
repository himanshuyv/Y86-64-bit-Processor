`include "And64Bit.v"

module tb_And64Bit;
    reg [63:0] A;
    reg [63:0] B;
    wire [63:0] Out;
    reg enable;
    And64Bit DUT(Out,A,B,enable);
    initial begin
        $dumpfile("tb_And64Bit.vcd");
        $dumpvars(0,tb_And64Bit);
        $monitor ($time, "A=%b, B=%b, Out=%b", A, B,Out);
        A <= 4;
        B <= 3;
        enable <=1;
        #10; 
        A <= 7;
        B <= 3;
        enable<=1;
        $finish;
    end
endmodule