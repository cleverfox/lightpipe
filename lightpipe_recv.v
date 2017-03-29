module lightpipe_recv(
    input rclk, // 8x mclk
    input mclk, // The master clock for this module
    input rst,
    input wclk, 
    output reg [23:0] chan1,
    output reg [23:0] chan2,
    output reg [23:0] chan3,
    output reg [23:0] chan4,
    output reg [23:0] chan5,
    output reg [23:0] chan6,
    output reg [23:0] chan7,
    output reg [23:0] chan8,
    output reg [3:0] user,
    input adat
);

wire oe, data;
nrzi_decoder nrzi_inst (
    rclk,
    ~rst,
    adat,
    oe,
    in
);

/*
frame_detector frame_detector (
   mclk,
   ~rst,
   in,
   */



endmodule

