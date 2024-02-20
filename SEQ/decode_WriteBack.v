module decode_WriteBack(valA, valB, rA, rB, valE, valM, icode, Cnd, clk);
    output reg [63:0] valA;
    output reg [63:0] valB;
    input [63:0] valE;
    input [63:0] valM;
    input [3:0] icode;
    input [3:0] rA;
    input [3:0] rB;
    reg [3:0] dstE;
    reg [3:0] dstM;
    input Cnd;
    reg [3:0] srcA;
    reg [3:0] srcB;
    input clk;

    reg [63:0] reg_file[15:0];
    genvar i;
    generate
        for (i=0; i<16;i = i+1)begin
            initial begin
                reg_file[i] = i;
            end
        end
    endgenerate

    always @(*)
    begin
        if(icode == 2 || icode ==4 || icode == 6 || icode == 10)
        begin
            srcA = rA;
        end
        else if(icode == 11 || icode == 9)
        begin
            srcA = 4;
        end
        else
        begin
            srcA = 15;
        end
        if(icode == 4 || icode == 5 || icode == 6)
        begin
            srcB = rB;
        end
        else if(icode == 10 || icode == 11 || icode == 8 || icode == 9)
        begin
            srcB = 4;
        end
        else
        begin 
            srcB = 15;
        end
        valA = reg_file[srcA];
        valB = reg_file[srcB];
    end

    always@ (negedge clk)
    begin
        if(icode == 6 || icode == 3)
        begin
            dstE = rB;
        end
        else if(icode == 2)
        begin
            if(Cnd)
            begin
                dstE = rB;
            end
        end
        else if(icode == 10 || icode == 11 || icode == 8 || icode == 9)
        begin
            dstE = 4;
        end
        else
        begin
            dstE = 15;
        end
        if(icode == 5 || icode == 11)
        begin
            dstM = rA;
        end
        else
        begin
            dstM = 15;
        end
        reg_file[dstE] = valE;
        reg_file[dstM] = valM;
    end

    initial
    begin
        $monitor("rax = %d ,rcx = %d, rdx = %d, rbx = %d, rsp = %d, rbp = %d, rsi = %d, rdi = %d, r8 = %d, r9 = %d, r10 = %d, r11 = %d, r12 = %d, r13 = %d, r14 = %d, r15 = %d",reg_file[0],reg_file[1],reg_file[2],reg_file[3],reg_file[4],reg_file[5],reg_file[6],reg_file[7],reg_file[8],reg_file[9],reg_file[10],reg_file[11],reg_file[12],reg_file[13],reg_file[14], reg_file[15]);
    end
endmodule