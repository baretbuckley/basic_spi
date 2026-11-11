

module shift_reg #(
    parameter int DATA_WIDTH = 8,
    parameter bool MSB = 1,
    parameter bool POS_EDGE = 1
) (
    input logic clk,
    input logic rst_n,
    input logic[DATA_WIDTH-1:0] init_data,
    input logic write_en,
    input wire shift_in,
    output logic[DATA_WIDTH-1:0] stored_data,
    output wire shift_out
);


    reg [DATA_WIDTH-1:0] shift_reg;
    always @(posedge clk or negedge clk or negedge rst_n) begin
        if (~rst_n)
            shift_reg <= 0;
        else if (write_en)
            shift_reg <= init_data;
        else if (POS_EDGE == clk) begin
            if (MSB)
                shift_reg <= {shift_reg[DATA_WIDTH-2:0], shift_in};
            else
                shift_reg <= {shift_in, shift_reg[DATA_WIDTH-2:0]};
        end
    end

    assign shift_out = (MSB)? shift_reg[DATA_WIDTH-1] : shift_reg[0];

endmodule
