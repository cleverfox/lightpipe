`timescale 1us / 10ns
module i2s_tb;

parameter AUDIO_DW = 24;
reg lrclk;
wire sdata;
reg [AUDIO_DW-1:0] left_tx_chan;
reg [AUDIO_DW-1:0] right_tx_chan;
wire [AUDIO_DW-1:0] left_rx_chan;
wire [AUDIO_DW-1:0] right_rx_chan;
reg sclk = 1'b1;
reg rst = 1'b1;
reg format = 1'b0;

reg [AUDIO_DW-1:0] bitcnt;

always #5 sclk <= ~sclk;
always #270 lrclk <= ~lrclk;
initial #20 rst = 0;

always @(negedge sclk)
    if (rst)
        bitcnt <= 1;
    else if (bitcnt >= AUDIO_DW)
        bitcnt <= 1;
    else
        bitcnt <= bitcnt + 1;

i2s_tx #(
    .AUDIO_DW	(AUDIO_DW)
) i2s_tx0 (
    .sclk		(sclk),
    .rst		(rst),
    .lj             (format),

    .lrclk		(lrclk),
    .sdata		(sdata),

    .left_chan	(left_tx_chan),
    .right_chan	(right_tx_chan)
);

i2s_rx #(
    .AUDIO_DW	(AUDIO_DW)
) i2s_rx0 (
    .sclk		(sclk),
    .rst		(rst),

    .lrclk		(lrclk),
    .sdata		(sdata),

    .left_chan	(left_rx_chan),
    .right_chan	(right_rx_chan)
);

initial begin
    sclk=0;
    lrclk=1;
    left_tx_chan = 24'haaaaaa;
    right_tx_chan = 24'h555555;
    bitcnt = 24'h0;
    @(negedge rst);
    @(posedge lrclk);
    @(negedge lrclk);
    left_tx_chan = 24'hffffff;
    right_tx_chan = 24'h000000;
    @(posedge lrclk);
    @(negedge lrclk);
    left_tx_chan = 24'h000000;
    right_tx_chan = 24'hffffff;
    @(posedge lrclk);
    @(negedge lrclk);
    @(posedge lrclk);
    @(negedge lrclk);
    @(posedge sclk);
    @(negedge sclk);
    if (left_rx_chan == left_tx_chan && right_rx_chan == right_tx_chan)
        $display("Test passed!");
    else
        $display("Test failed!");
    #200 $finish();
end

initial
begin
    $dumpfile("out.vcd");
    $dumpvars(0,i2s_tb);
end

//наблюдаем на некоторыми сигналами системы
initial
    $monitor($stime,, lrclk,, sdata);


endmodule
