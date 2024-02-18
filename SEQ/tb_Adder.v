`include "Adder.v"

module tb_Adder;
    reg [63:0] A;
    reg [63:0] B;
    reg enable;
    wire [63:0] Sum;
    wire OverFlow;
    Adder DUT(OverFlow,Sum,A,B, enable);
    initial begin
        $dumpfile("tb_Adder.vcd");
        $dumpvars(0,tb_Adder);
        $monitor ($time, "A=%b, B=%b,Sum=%b, OverFlow=%b", A, B,Sum, OverFlow);
        A <= -2;
        B <= 1;
        enable <=1;
        #10; 
        A <= 3;
        B <= 4;
        #10
        A <= 7;
        B <= 9;
        #10; 
        A <= 9;
        B <= 7;
        #10
        A <= -2;
        B <= -1;
        #10; 
        A <= 13;
        B <= 4;
        #10
        A <= -2;
        B <= -11;
        #10; 
        A <= 10000;
        B <= -10000;
        #10
        A <= 64'b0111111111111111111111111111111111111111111111111111111111111111;
        B <= 64'b0111111111111111111111111111111111111111111111111111111111111111;
        #10
        $finish;
    end
endmodule