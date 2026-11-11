

module spi_master #(
    parameter DATA_WIDTH = 8,
    parameter CLK_DIV = 25,
    parameter MOSI_MSB_FIRST = 1
)(
    input wire clk,
    input wire rst_n,
    input wire start,
    input wire [DATA_WIDTH-1:0] data_miso,
    output reg [DATA_WIDTH-1:0] data_mosi,
    output reg done,
    output reg sclk,
    output wire mosi,
    input wire miso
);


    clk_div #(.DIV(CLK_DIV)) cdiv(
        .clk(clk),
        .rst_n(rst_n),
        .clk_out(sclk)
    );


    transmitter #(
        .DATA_WIDTH(DATA_WIDTH),
        .MSB_FIRST(MOSI_MSB_FIRST)
    ) mosi_tx (
        .clk(sclk),
        .rst_n(rst_n),
        .start(start),
        .data_in(data_mosi),
        .data_out(mosi),
        .done(done)
    );

    




endmodule
