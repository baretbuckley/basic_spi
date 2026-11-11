

module receiver_tb ();

    reg clk, rst_n, start, data_in;
    wire [7:0] data_out;
    wire received;

    receiver #(
        .DATA_WIDTH(8),
        .MSB_FIRST(1),
        .POS_EDGE(1)
    ) receive (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(data_in),
        .data_out(data_out),
        .received(received)
    );

    initial begin
        clk = 0;
        rst_n = 0;
        start = 0;
        data_in = 0;

        for (int i = 0; i < 32; i++) begin
            #5 clk = ~clk;
        end

        data_in = 1;
        for (int i = 0; i < 16; i++) begin
            #5 clk = ~clk;
        end

        data_in = 1;
        #5 clk = ~clk;
        #5 clk = ~clk;
        data_in = 1;
        #5 clk = ~clk;
        #5 clk = ~clk;
        data_in = 0;
        #5 clk = ~clk;
        #5 clk = ~clk;
        data_in = 0;
        #5 clk = ~clk;
        #5 clk = ~clk;
        data_in = 1;
        #5 clk = ~clk;
        #5 clk = ~clk;
        data_in = 0;
        #5 clk = ~clk;
        #5 clk = ~clk;
        data_in = 1;
        #5 clk = ~clk;
        #5 clk = ~clk;
        data_in = 0;
        #5 clk = ~clk;
        #5 clk = ~clk;



    end

endmodule
