




module receiver_tb ();

    reg clk, rst_n;
    reg [7:0] data_in;
    wire data_wire;
    wire [7:0] data_out;
    wire received;
    wire tx_done;

    task automatic send_data(input bit [7:0] data);
        begin
            data_in = data;
            for (int i = 0; i < 16; i++) begin
                #5 clk = ~clk;
            end
        end
    endtask

    transmitter #(
        .DATA_WIDTH(8),
        .MSB_FIRST(1),
        .POS_EDGE(1)
    ) transmit (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(data_in),
        .wire_out(data_wire),
        .done(tx_done)
    );

    receiver #(
        .DATA_WIDTH(8),
        .MSB_FIRST(1),
        .POS_EDGE(1)
    ) receive (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(data_wire),
        .data_out(data_out),
        .received(received)
    );

    initial begin
        clk = 0;
        rst_n = 0;
        data_in = 0;

        #10 rst_n = 1;
        #10 send_data(8'hA5);
        #10 send_data(8'h5A);

        #10 rst_n = 0;
        #10 rst_n = 1;

        #10 send_data(8'hF0);
        #10 send_data(8'hF0);

        data_in = 8'hFF;
        for (int i = 0; i < 4; i++) begin
            #5 clk = ~clk;
        end
        #10 rst_n = 0;
        #10 rst_n = 1;
        #10 send_data(8'hAA);
        


    end

endmodule
