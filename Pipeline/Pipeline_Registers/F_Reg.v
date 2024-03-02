module F_reg(F_predPC,f_predPC,F_stall,clk);
    output reg [63:0] F_predPC;
    input [63:0] f_predPC;
    input F_stall;
    input clk;
    always @(posedge clk)
    begin
        if (F_stall != 1)
        begin
            F_predPC = f_predPC;    
        end
    end
endmodule