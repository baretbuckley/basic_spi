



module receiver #(
    parameter int DATA_WIDTH = 8,
    parameter bit MSB_FIRST = 1,
    parameter bit POS_EDGE = 1
)(
    input wire clk,
    input wire rst_n,
    input logic data_in,
    output wire [DATA_WIDTH-1:0] data_out,
    output reg received
);

    wire [DATA_WIDTH-1:0] reg_data;
    shift_reg #(
        .DATA_WIDTH(DATA_WIDTH),
        .MSB(MSB_FIRST),
        .POS_EDGE(POS_EDGE)
    ) sreg (
        .clk(clk),
        .rst_n(rst_n),
        .shift_in(data_in),
        .stored_data(data_out)
    );


    // bit count also used to track if transmitting is complete
    reg [$clog2(DATA_WIDTH):0] bit_count = 0;

    // // Received is pulsed when bit_count == 0
    // //   i.e. bit_count == 0 and last cycle bit_count != 0
    // // Received_hold held high when bit_count == 0
    // reg received_hold = 1;
    // always @(posedge clk or negedge clk or negedge rst_n) begin
    //     if (!rst_n) begin
    //         received <= 0;
    //         received_hold <= 1;
    //     end else if (clk == POS_EDGE) begin
    //         received_hold <= (bit_count == 0)? 1 : 0;
    //         received <= (bit_count == 0);
    //     end
    // end

    always @(posedge clk or negedge clk or negedge rst_n) begin
        if (!rst_n) begin
            received <= 0;
        end else if (clk == POS_EDGE) begin
            received <= (bit_count == DATA_WIDTH-1);
        end
    end

    
    always @(posedge clk or negedge clk or negedge rst_n) begin
        if (!rst_n) begin
            bit_count <= 0;
            // data_out <= 0;
        end
        else if (clk == POS_EDGE) begin
            if (bit_count == DATA_WIDTH-1) begin
                bit_count <= 0;
                // data_out <= reg_data;
            end else
                bit_count <= bit_count + 1;
        end
    end






endmodule