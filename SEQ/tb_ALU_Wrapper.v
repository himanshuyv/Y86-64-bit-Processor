`include "ALU_Wrapper.v"

module tb_ALU_Wrapper;
    reg [63:0] A;
    reg [63:0] B;
    reg [1:0] control;
    wire [63:0] out;
    wire OF;
    ALU_Wrapper DUT(OF,out,control,A,B);
    initial begin
        $dumpfile("tb_ALU_Wrapper.vcd");
        $dumpvars(0,tb_ALU_Wrapper);
        $monitor ($time, "Control=%b, A=%b, B=%b,Out=%b, OF=%b", control, A, B,out, OF);
        A <= -25000; 
        B <= 138947938;
        control <= 0;
        #10; 
        A <= 348;
        B <= 4390;
        control <= 2;
        #10
        A <= 798;
        B <= 999;
        control <= 3; 
        #10; 
        A <= 978;
        B <= 7379;
        control <= 1;
        #10
        A <= -23748;
        B <= -17378;
        control <=0;
        #10; 
        B <= 13;
        A <= 4;
        #10
        A <= -2;
        B <= -11;
        #10; 
        A <= 10000;
        B <= -10000;
        #10
        A <= 1000000000000000000000000000000000000000000000000000000000000001;
        B <= 2;
        control <=1;
        #10
        $finish;
    end
endmodule