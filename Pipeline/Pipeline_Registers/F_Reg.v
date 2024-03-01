module F_reg(F_predPC,f_predPC,clk);
    output reg [63:0] F_predPC;
    input [63:0] f_predPC;
    input clk;
    always @(*)
    begin
        F_predPC = f_predPC;    
    end
endmodule