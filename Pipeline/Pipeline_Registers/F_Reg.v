module F_reg(F_predPC,f_predPC,F_stall,clk);
    output reg [63:0] F_predPC;
    input [63:0] f_predPC;
    input F_stall;
    input clk;
    reg [63:0] tempPC;
    always @(posedge clk)
    begin
        tempPC = F_predPC;
        F_predPC = f_predPC;    
        if (F_stall == 1)
        begin
            F_predPC = tempPC;
        end
    end
endmodule