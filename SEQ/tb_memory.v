`include "memory.v"

module tb_memory;
    wire dmemError;
    wire [63:0] valueRead;
    reg clk;
    reg [63:0] memAddress;
    reg readEN;
    reg writeEn;
    reg [63:0] valueWrite;

    memory DUT(dmemError,valueRead,clk,memAddress,readEN,writeEn,valueWrite);

    initial begin
        $dumpfile("tb_memory.vcd");
        $dumpvars(0, tb_memory);
    end

    always begin
        clk = ~clk;
        #5;
    end
    
    always @(posedge clk) begin
        #5
        $display($time,"ns ", "value read = ",valueRead," Dmem_Error = ",dmemError);
    end

    initial begin
        #5
        clk <= 0;
        readEN <= 0;
        writeEn <= 0;
        memAddress <= 0;
        valueWrite <= 0;
        #10
        writeEn <= 1;
        memAddress <= 10;
        valueWrite <= 6000;
        #10 
        writeEn <= 1;
        memAddress <= 10000;
        valueWrite <= 100;

        #10
        readEN <= 1;
        memAddress <=10;

        #10
        writeEn <= 0; 
        memAddress <= 10;
        
        #10
        memAddress <= -465;

        #10
        memAddress <= 5;

        #10
        memAddress <= 0;

        #10 
        readEN <= 0;

        #10 
        $finish;
    end
endmodule