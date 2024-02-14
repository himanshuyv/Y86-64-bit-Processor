`include "Subtractor.v"

module tb_Subtractor;
    reg [63:0] A;
    reg [63:0] B;
    wire [63:0] Sum;
    wire OverFlow;
    reg enable;
    Subtractor DUT(OverFlow,Sum,A,B,enable);
    initial begin
        $dumpfile("tb_Subtractor.vcd");
        $dumpvars(0,tb_Subtractor);
        $monitor ($time, "A=%b, B=%b,Sum=%b, OverFlow=%b", A, B,Sum, OverFlow);
        A <= -2;
        B <= 1;
        enable <= 1;
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
        A <= 64'b0000000000000000000000000000000000000000000000000000000000000001;
        B <= 64'b1000000000000000000000000000000000000000000000000000000000000000;
        #10
        $finish;
    end
endmodule