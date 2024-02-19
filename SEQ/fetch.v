`include "instructionMemory.v"

module fetch(icode,ifun,rA,rB,valC,valP,stat,PC);
    output reg [3:0] icode;
    output reg [3:0] ifun;
    output reg [3:0] rA;
    output reg [3:0] rB;
    output reg [63:0] valC;
    output reg [63:0] valP;
    output reg [3:0] stat;
    input wire [63:0] PC;
    reg need_regids;
    reg need_valC;
    wire [7:0] im_out [0:9];
    wire imem_error;
    reg [63:0] iPC;
    instructionMemory X1(im_out[0],im_out[1],im_out[2],im_out[3],im_out[4],im_out[5],im_out[6],im_out[7],im_out[8],im_out[9],imem_error,iPC);
    always @(*)
    begin
        iPC = PC;
        stat <= 0;
        icode <= im_out[0][7:4];
        ifun <= im_out[0][3:0];   
        
        if (imem_error==1)
        begin
            stat <= 2;
        end
        else
        begin
            if(icode == 2 || icode == 3 || icode == 4 || icode == 5 ||icode == 6 || icode == 10 || icode == 11) 
            begin
                need_regids = 1; 
                rA <= im_out[1][7:4];
                rB <= im_out[1][3:0];
            end
            else
            begin
                need_regids = 0;
                rA <= 15;
                rB <= 15;
            end

            if (icode == 3 || icode == 4 || icode == 5 || icode == 7 || icode == 8)
            begin
                need_valC = 1;
                valC[7:0] <= im_out[need_regids+1];
                valC[15:8] <= im_out[need_regids+2];
                valC[23:16] <= im_out[need_regids+3];
                valC[31:24] <= im_out[need_regids+4];
                valC[39:32] <= im_out[need_regids+5];
                valC[47:40] <= im_out[need_regids+6];
                valC[55:48] <= im_out[need_regids+7];
                valC[63:56] <= im_out[need_regids+8];
            end
            else
            begin
                need_valC = 0;
            end


            valP = PC + 1 + need_regids + 8*need_valC;
            
            if (icode == 0 || icode == 1 || icode == 9)
            begin
                if (icode == 0)
                begin
                    stat <= 1;
                end

                if (ifun != 0)
                begin
                    stat <= 3;
                end
            end   
            
            else if (icode == 2 || icode == 6 || icode == 10 || icode == 11)
            begin
                if ((icode == 2 && (ifun<0 || ifun>6)) || ((icode==6) && (ifun<0 || ifun>3)) || ((icode == 10 || icode == 11) && (rB != 15 || ifun!=0)))
                begin
                    stat <= 3;
                end
            end   
            
            else if (icode == 3 || icode == 4 || icode == 5 || icode ==7 || icode==8)
            begin
                if (icode != 7 && icode != 8)
                begin
                    if ((icode == 3 && rA != 15) || ifun!=0)
                    begin
                        stat <= 3;
                    end
                end
                else
                begin
                    if ((icode == 7 && (ifun<0 || ifun>6)) || (icode == 8 && ifun != 0))
                    begin
                        stat <= 3;
                    end
                end
            end

            else
            begin
                stat <= 3;
            end
        end
    end
endmodule