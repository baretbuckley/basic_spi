



module transmitter #(
    parameter int DATA_WIDTH = 8,
    parameter bool MSB_FIRST = 1,
    parameter bool POS_EDGE = 1
)(
    input wire clk,
    input wire rst_n,
    input wire [DATA_WIDTH-1:0] data_in, // Input data to transmit. Not copied to internal reg, must remain stable while done is low
    output wire data_out,
    output reg done
);

    typedef enum logic[1:0] {
        Idle,
        NextBit,
        EndPacket,
        SendData
    } State;

    State state = Idle;
    reg [$clog2(DATA_WIDTH):0] bit_idx = 0;

    assign data_out = ~rst_n & data_in[bit_idx];
    assign done = (state == Idle) || (state == EndPacket);

    always @(posedge clk or negedge clk or rst_n) begin
        if (!rst_n) begin
            state <= Idle;
            bit_idx <= 0;
        end else case(state)
            Idle:
                if (clk == POS_EDGE) 
                    state <= (DATA_WIDTH==1)? EndPacket:NextBit;
            NextBit:
                if (clk != POS_EDGE) begin
                    state <= send_data;
                    bit_idx <= bit_idx + 1;
                end
            EndPacket:
                if (clk != POS_EDGE) begin
                    state <= send_data;
                    bit_idx <= 0;
                end
            SendData:
                if (clk == POS_EDGE) begin
                    state <= (bit_idx == DATA_WIDTH-1)? EndPacket : NextBit;
                end
            default: begin end
        endcase
    end

endmodule
