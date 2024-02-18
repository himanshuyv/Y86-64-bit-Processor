module register_file(clk, reg_id_write, valueread, reg_id_read, valueWrite, readEn, writeEn)
reg [63:0] registers [15:0];

genvar i;
    generate
        for (i=0;i16; i = i+1)begin
            initial registers[i] <= i;
        end
    endgenerate

    always@(*) begin 
        if(WriteEn == 1)
        begin
            registers[reg_id_write] <= valueWrite;
        end
        if(readEn == 1)
        begin
            valueread <= registers[reg_id_read];
        end
    end


endmodule