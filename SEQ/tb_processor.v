`include "processor.v"

module tb_processor;
    reg clk;
    processor DUT(clk);
    
    initial begin
        $dumpfile("tb_processor.vcd");
        $dumpvars(0,tb_processor);
    end

    always begin
        clk = ~clk;
        #5;
    end

    initial begin
        clk <= 1;
        #300
        $finish;
    end


endmodule