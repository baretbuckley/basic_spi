

module neg_edge_shift_reg #(
    parameter DATA_WIDTH = 8,
    parameter MSB = 1
) (
    input logic[DATA_WIDTH-1:0] init_data,
    input logic write_en,
    output wire next
);

    reg [DATA_WIDTH-1:0] reg_data = 0;
    
    assign next = (MSB)? reg_data[DATA_WIDTH-1] : reg_data[0];

    always @(negedge clk) begin
        if (write_en)
            reg_data <= init_data;
        else if (MSB)
            reg_data <= {reg_data[DATA_WIDTH-1 : 1], 1'b0};
        else
            reg_data <= {1'b0, reg_data[DATA_WIDTH-2:0]};
    end
endmodule
