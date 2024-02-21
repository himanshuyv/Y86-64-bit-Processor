module data_memory(valM, stat, valA, valP, valE, icode, instr_valid, imem_error, clk);
    output reg [2:0] stat;
    output reg [63:0] valM;
    input clk;
    input [63:0] valA;
    input [63:0] valP;
    input [63:0] valE;
    input [3:0] icode;
    input instr_valid;
    input imem_error;
    reg dmemError;
    reg [63:0] memReg[0:8191];
    genvar i;
    generate
        for (i=0; i<64;i = i+1)begin
            initial begin
                memReg[i] = 0;
            end
        end
    endgenerate
    reg [63:0] mem_addr;
    reg [63:0] mem_data;
    reg mem_read;
    reg mem_write;
    always @(*)
    begin
        if(icode == 10 || icode == 8 || icode == 4 || icode == 5)
        begin
            mem_addr = valE;
        end
        else if(icode == 11 || icode == 9)
        begin 
            mem_addr = valA;
        end

        if (icode == 4 || icode == 10)
        begin
            mem_data = valA;
        end
        else if (icode == 8)
        begin
            mem_data = valP;
        end

        if (icode == 5 || icode == 9 || icode == 11)
        begin
            mem_read = 1;
        end
        else
        begin
            mem_read = 0;
        end

        if (icode == 4 || icode == 8 || icode == 10)
        begin
            mem_write = 1;
        end
        else
        begin
            mem_write = 0;
        end


        if (mem_read == 1)
        begin
            valM = memReg[mem_addr];
        end

        dmemError =0;
        if(mem_addr > 8191)
        begin
            dmemError = 1;
        end

        if(instr_valid == 1)
        begin
            stat = 1;
        end
        else if(instr_valid == 0)
        begin
            stat = 3;
        end

        if(imem_error == 1 || dmemError == 1)
        begin
            stat = 2;
        end
        if(icode == 0)
        begin
            stat = 4;
        end
    end
    always@(negedge clk)
    begin
        if (mem_write == 1)
        begin
            memReg[mem_addr] = mem_data;
        end
    end

endmodule