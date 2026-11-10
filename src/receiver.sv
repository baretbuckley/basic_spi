



module receiver #(
    parameter DATA_WIDTH = 8,
    parameter MSB_FIRST = 1
)(
    input wire clk,
    input wire rst_n,
    input wire start,
    input wire [DATA_WIDTH-1:0] data_in,
    output wire data_out,
    output reg done
);


    // bit count also used to track if transmitting is complete
    reg [$clog2(DATA_WIDTH):0] bit_count = DATA_WIDTH;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            done <= 0;
        end else begin
            done <= (bit_count == DATA_WIDTH)? 1 : 0;
        end
    end

    neg_edge_shift_reg #(.DATA_WIDTH(DATA_WIDTH), .MSB(MSB_FIRST)) sreg (
        .clk(clk),
        .rst_n(rst_n),
        .init_data(data_in),
        .write_en(start),
        .next(data_out)
    );


    always @(negedge clk or negedge rst_n) begin
        if (!rst_n) begin
            bit_count <= DATA_WIDTH;
        end
        else if (bit_count == DATA_WIDTH) begin
            if (start) bit_count <= 0;
        end else begin
            bit_count <= bit_count + 1;
        end
    end






endmodule