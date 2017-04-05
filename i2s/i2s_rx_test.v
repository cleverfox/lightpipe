`timescale 1us / 10ns
module i2s_tb;

parameter AUDIO_DW = 24;
reg lrclk;
reg sdata;
wire [AUDIO_DW-1:0] left_rx_chan;
wire [AUDIO_DW-1:0] right_rx_chan;
reg sclk;
reg rst;
reg format;
reg [7:0]ob;

i2s_rx #(
    .AUDIO_DW	(AUDIO_DW)
) i2s_rx0 (
    .rst		(rst),
    .format             (format),

    .sclk		(sclk),
    .lrclk		(lrclk),
    .sdata		(sdata),

    .left_chan	(left_rx_chan),
    .right_chan	(right_rx_chan)
);

always 
    #2 sclk <= ~sclk;

always  
    #96 lrclk <= ~lrclk;

initial begin
    //i2s
    format=0;
    rst=0;
    sclk=0;
    lrclk=1;
    @(posedge lrclk);
    rst=1;
    @(negedge lrclk);

    //w1 R
    @(negedge sclk); sdata=0; ob=23-23;
    @(negedge sclk); sdata=1; ob=23-22;
    @(negedge sclk); sdata=0; ob=23-21;
    @(negedge sclk); sdata=1; ob=23-20;

    @(negedge sclk); sdata=0; ob=23-19;
    @(negedge sclk); sdata=1; ob=23-18;
    @(negedge sclk); sdata=0; ob=23-17;
    @(negedge sclk); sdata=1; ob=23-16;

    @(negedge sclk); sdata=0; ob=23-15;
    @(negedge sclk); sdata=1; ob=23-14;
    @(negedge sclk); sdata=0; ob=23-13;
    @(negedge sclk); sdata=1; ob=23-12;

    @(negedge sclk); sdata=0; ob=23-11;
    @(negedge sclk); sdata=1; ob=23-10;
    @(negedge sclk); sdata=0; ob=23-9;
    @(negedge sclk); sdata=1; ob=23-8;

    @(negedge sclk); sdata=0; ob=23-7;
    @(negedge sclk); sdata=1; ob=23-6;
    @(negedge sclk); sdata=0; ob=23-5;
    @(negedge sclk); sdata=1; ob=23-4;

    @(negedge sclk); sdata=0; ob=23-3;
    @(negedge sclk); sdata=1; ob=23-2;
    @(negedge sclk); sdata=0; ob=23-1;
    @(negedge sclk); sdata=1; ob=23-0;

    //w1 l
    
    @(negedge sclk); sdata=1; ob=23-23;
    @(negedge sclk); sdata=0; ob=23-22;
    @(negedge sclk); sdata=1; ob=23-21;
    @(negedge sclk); sdata=0; ob=23-20;
                                   
    @(negedge sclk); sdata=1; ob=23-19;
    @(negedge sclk); sdata=0; ob=23-18;
    @(negedge sclk); sdata=1; ob=23-17;
    @(negedge sclk); sdata=0; ob=23-16;
                                   
    @(negedge sclk); sdata=1; ob=23-15;
    @(negedge sclk); sdata=0; ob=23-14;
    @(negedge sclk); sdata=1; ob=23-13;
    @(negedge sclk); sdata=0; ob=23-12;
                                   
    @(negedge sclk); sdata=1; ob=23-11;
    @(negedge sclk); sdata=0; ob=23-10;
    @(negedge sclk); sdata=1; ob=23-9;
    @(negedge sclk); sdata=0; ob=23-8;
                                   
    @(negedge sclk); sdata=1; ob=23-7;
    @(negedge sclk); sdata=0; ob=23-6;
    @(negedge sclk); sdata=1; ob=23-5;
    @(negedge sclk); sdata=0; ob=23-4;
                                   
    @(negedge sclk); sdata=1; ob=23-3;
    @(negedge sclk); sdata=0; ob=23-2;
    @(negedge sclk); sdata=1; ob=23-1;
    @(negedge sclk); sdata=0; ob=23-0;

    //w2 r
    
    @(negedge sclk); sdata=1; ob=23-23;
    @(negedge sclk); sdata=0; ob=23-22;
    @(negedge sclk); sdata=1; ob=23-21;
    @(negedge sclk); sdata=0; ob=23-20;
                                   
    @(negedge sclk); sdata=1; ob=23-19;
    @(negedge sclk); sdata=0; ob=23-18;
    @(negedge sclk); sdata=1; ob=23-17;
    @(negedge sclk); sdata=0; ob=23-16;
                                   
    @(negedge sclk); sdata=1; ob=23-15;
    @(negedge sclk); sdata=0; ob=23-14;
    @(negedge sclk); sdata=1; ob=23-13;
    @(negedge sclk); sdata=0; ob=23-12;
                                   
    @(negedge sclk); sdata=1; ob=23-11;
    @(negedge sclk); sdata=0; ob=23-10;
    @(negedge sclk); sdata=1; ob=23-9;
    @(negedge sclk); sdata=0; ob=23-8;
                                   
    @(negedge sclk); sdata=1; ob=23-7;
    @(negedge sclk); sdata=0; ob=23-6;
    @(negedge sclk); sdata=1; ob=23-5;
    @(negedge sclk); sdata=0; ob=23-4;
                                   
    @(negedge sclk); sdata=1; ob=23-3;
    @(negedge sclk); sdata=0; ob=23-2;
    @(negedge sclk); sdata=1; ob=23-1;
    @(negedge sclk); sdata=0; ob=23-0;

    //w2 l
    @(negedge sclk); sdata=0; ob=23-23;
    @(negedge sclk); sdata=1; ob=23-22;
    @(negedge sclk); sdata=0; ob=23-21;
    @(negedge sclk); sdata=1; ob=23-20;
                                   
    @(negedge sclk); sdata=0; ob=23-19;
    @(negedge sclk); sdata=1; ob=23-18;
    @(negedge sclk); sdata=0; ob=23-17;
    @(negedge sclk); sdata=1; ob=23-16;
                                   
    @(negedge sclk); sdata=0; ob=23-15;
    @(negedge sclk); sdata=1; ob=23-14;
    @(negedge sclk); sdata=0; ob=23-13;
    @(negedge sclk); sdata=1; ob=23-12;
                                   
    @(negedge sclk); sdata=0; ob=23-11;
    @(negedge sclk); sdata=1; ob=23-10;
    @(negedge sclk); sdata=0; ob=23-9;
    @(negedge sclk); sdata=1; ob=23-8;
                                   
    @(negedge sclk); sdata=0; ob=23-7;
    @(negedge sclk); sdata=1; ob=23-6;
    @(negedge sclk); sdata=0; ob=23-5;
    @(negedge sclk); sdata=1; ob=23-4;
                                   
    @(negedge sclk); sdata=0; ob=23-3;
    @(negedge sclk); sdata=1; ob=23-2;
    @(negedge sclk); sdata=0; ob=23-1;
    @(negedge sclk); sdata=1; ob=23-0;
    
    //w3 r
    
    @(negedge sclk); sdata=1; ob=23-23;
    @(negedge sclk); sdata=1; ob=23-22;
    @(negedge sclk); sdata=1; ob=23-21;
    @(negedge sclk); sdata=1; ob=23-20;
                                   
    @(negedge sclk); sdata=0; ob=23-19;
    @(negedge sclk); sdata=0; ob=23-18;
    @(negedge sclk); sdata=0; ob=23-17;
    @(negedge sclk); sdata=0; ob=23-16;
                                   
    @(negedge sclk); sdata=1; ob=23-15;
    @(negedge sclk); sdata=1; ob=23-14;
    @(negedge sclk); sdata=1; ob=23-13;
    @(negedge sclk); sdata=1; ob=23-12;
                                   
    @(negedge sclk); sdata=0; ob=23-11;
    @(negedge sclk); sdata=0; ob=23-10;
    @(negedge sclk); sdata=0; ob=23-9;
    @(negedge sclk); sdata=0; ob=23-8;
                                   
    @(negedge sclk); sdata=0; ob=23-7;
    @(negedge sclk); sdata=0; ob=23-6;
    @(negedge sclk); sdata=0; ob=23-5;
    @(negedge sclk); sdata=0; ob=23-4;
                                   
    @(negedge sclk); sdata=1; ob=23-3;
    @(negedge sclk); sdata=1; ob=23-2;
    @(negedge sclk); sdata=1; ob=23-1;
    @(negedge sclk); sdata=1; ob=23-0;

    //w3 l
    @(negedge sclk); sdata=1; ob=23-23;
    @(negedge sclk); sdata=1; ob=23-22;
    @(negedge sclk); sdata=1; ob=23-21;
    @(negedge sclk); sdata=1; ob=23-20;
                                   
    @(negedge sclk); sdata=1; ob=23-19;
    @(negedge sclk); sdata=1; ob=23-18;
    @(negedge sclk); sdata=1; ob=23-17;
    @(negedge sclk); sdata=1; ob=23-16;
                                   
    @(negedge sclk); sdata=0; ob=23-15;
    @(negedge sclk); sdata=0; ob=23-14;
    @(negedge sclk); sdata=0; ob=23-13;
    @(negedge sclk); sdata=0; ob=23-12;
                                   
    @(negedge sclk); sdata=1; ob=23-11;
    @(negedge sclk); sdata=1; ob=23-10;
    @(negedge sclk); sdata=1; ob=23-9;
    @(negedge sclk); sdata=1; ob=23-8;
                                   
    @(negedge sclk); sdata=0; ob=23-7;
    @(negedge sclk); sdata=0; ob=23-6;
    @(negedge sclk); sdata=0; ob=23-5;
    @(negedge sclk); sdata=0; ob=23-4;
                                   
    @(negedge sclk); sdata=1; ob=23-3;
    @(negedge sclk); sdata=1; ob=23-2;
    @(negedge sclk); sdata=1; ob=23-1;
    @(negedge sclk); sdata=1; ob=23-0;
    @(negedge sclk);

    sdata=0;ob=255;
    @(posedge lrclk);@(negedge sclk); 
    sdata=1;ob=255;
    @(negedge lrclk);@(negedge sclk); 
    sdata=0;ob=255;
    @(posedge lrclk);@(negedge sclk); 
    sdata=1;ob=255;
    @(negedge lrclk);@(negedge sclk); 
    sdata=0;ob=255;

    //left justified
    format=1;
    @(posedge lrclk);

    //w1 R
    sdata=0; ob=23-23;
    @(negedge sclk); sdata=1; ob=23-22;
    @(negedge sclk); sdata=0; ob=23-21;
    @(negedge sclk); sdata=1; ob=23-20;

    @(negedge sclk); sdata=0; ob=23-19;
    @(negedge sclk); sdata=1; ob=23-18;
    @(negedge sclk); sdata=0; ob=23-17;
    @(negedge sclk); sdata=1; ob=23-16;

    @(negedge sclk); sdata=0; ob=23-15;
    @(negedge sclk); sdata=1; ob=23-14;
    @(negedge sclk); sdata=0; ob=23-13;
    @(negedge sclk); sdata=1; ob=23-12;

    @(negedge sclk); sdata=0; ob=23-11;
    @(negedge sclk); sdata=1; ob=23-10;
    @(negedge sclk); sdata=0; ob=23-9;
    @(negedge sclk); sdata=1; ob=23-8;

    @(negedge sclk); sdata=0; ob=23-7;
    @(negedge sclk); sdata=1; ob=23-6;
    @(negedge sclk); sdata=0; ob=23-5;
    @(negedge sclk); sdata=1; ob=23-4;

    @(negedge sclk); sdata=0; ob=23-3;
    @(negedge sclk); sdata=1; ob=23-2;
    @(negedge sclk); sdata=0; ob=23-1;
    @(negedge sclk); sdata=1; ob=23-0;

    //w1 l
    
    @(negedge sclk); sdata=1; ob=23-23;
    @(negedge sclk); sdata=0; ob=23-22;
    @(negedge sclk); sdata=1; ob=23-21;
    @(negedge sclk); sdata=0; ob=23-20;
                                   
    @(negedge sclk); sdata=1; ob=23-19;
    @(negedge sclk); sdata=0; ob=23-18;
    @(negedge sclk); sdata=1; ob=23-17;
    @(negedge sclk); sdata=0; ob=23-16;
                                   
    @(negedge sclk); sdata=1; ob=23-15;
    @(negedge sclk); sdata=0; ob=23-14;
    @(negedge sclk); sdata=1; ob=23-13;
    @(negedge sclk); sdata=0; ob=23-12;
                                   
    @(negedge sclk); sdata=1; ob=23-11;
    @(negedge sclk); sdata=0; ob=23-10;
    @(negedge sclk); sdata=1; ob=23-9;
    @(negedge sclk); sdata=0; ob=23-8;
                                   
    @(negedge sclk); sdata=1; ob=23-7;
    @(negedge sclk); sdata=0; ob=23-6;
    @(negedge sclk); sdata=1; ob=23-5;
    @(negedge sclk); sdata=0; ob=23-4;
                                   
    @(negedge sclk); sdata=1; ob=23-3;
    @(negedge sclk); sdata=0; ob=23-2;
    @(negedge sclk); sdata=1; ob=23-1;
    @(negedge sclk); sdata=0; ob=23-0;

    //w2 r
    
    @(negedge sclk); sdata=1; ob=23-23;
    @(negedge sclk); sdata=0; ob=23-22;
    @(negedge sclk); sdata=1; ob=23-21;
    @(negedge sclk); sdata=0; ob=23-20;
                                   
    @(negedge sclk); sdata=1; ob=23-19;
    @(negedge sclk); sdata=0; ob=23-18;
    @(negedge sclk); sdata=1; ob=23-17;
    @(negedge sclk); sdata=0; ob=23-16;
                                   
    @(negedge sclk); sdata=1; ob=23-15;
    @(negedge sclk); sdata=0; ob=23-14;
    @(negedge sclk); sdata=1; ob=23-13;
    @(negedge sclk); sdata=0; ob=23-12;
                                   
    @(negedge sclk); sdata=1; ob=23-11;
    @(negedge sclk); sdata=0; ob=23-10;
    @(negedge sclk); sdata=1; ob=23-9;
    @(negedge sclk); sdata=0; ob=23-8;
                                   
    @(negedge sclk); sdata=1; ob=23-7;
    @(negedge sclk); sdata=0; ob=23-6;
    @(negedge sclk); sdata=1; ob=23-5;
    @(negedge sclk); sdata=0; ob=23-4;
                                   
    @(negedge sclk); sdata=1; ob=23-3;
    @(negedge sclk); sdata=0; ob=23-2;
    @(negedge sclk); sdata=1; ob=23-1;
    @(negedge sclk); sdata=0; ob=23-0;

    //w2 l
    @(negedge sclk); sdata=0; ob=23-23;
    @(negedge sclk); sdata=1; ob=23-22;
    @(negedge sclk); sdata=0; ob=23-21;
    @(negedge sclk); sdata=1; ob=23-20;
                                   
    @(negedge sclk); sdata=0; ob=23-19;
    @(negedge sclk); sdata=1; ob=23-18;
    @(negedge sclk); sdata=0; ob=23-17;
    @(negedge sclk); sdata=1; ob=23-16;
                                   
    @(negedge sclk); sdata=0; ob=23-15;
    @(negedge sclk); sdata=1; ob=23-14;
    @(negedge sclk); sdata=0; ob=23-13;
    @(negedge sclk); sdata=1; ob=23-12;
                                   
    @(negedge sclk); sdata=0; ob=23-11;
    @(negedge sclk); sdata=1; ob=23-10;
    @(negedge sclk); sdata=0; ob=23-9;
    @(negedge sclk); sdata=1; ob=23-8;
                                   
    @(negedge sclk); sdata=0; ob=23-7;
    @(negedge sclk); sdata=1; ob=23-6;
    @(negedge sclk); sdata=0; ob=23-5;
    @(negedge sclk); sdata=1; ob=23-4;
                                   
    @(negedge sclk); sdata=0; ob=23-3;
    @(negedge sclk); sdata=1; ob=23-2;
    @(negedge sclk); sdata=0; ob=23-1;
    @(negedge sclk); sdata=1; ob=23-0;
    
    //w3 r
    
    @(negedge sclk); sdata=1; ob=23-23;
    @(negedge sclk); sdata=1; ob=23-22;
    @(negedge sclk); sdata=1; ob=23-21;
    @(negedge sclk); sdata=1; ob=23-20;
                                   
    @(negedge sclk); sdata=0; ob=23-19;
    @(negedge sclk); sdata=0; ob=23-18;
    @(negedge sclk); sdata=0; ob=23-17;
    @(negedge sclk); sdata=0; ob=23-16;
                                   
    @(negedge sclk); sdata=1; ob=23-15;
    @(negedge sclk); sdata=1; ob=23-14;
    @(negedge sclk); sdata=1; ob=23-13;
    @(negedge sclk); sdata=1; ob=23-12;
                                   
    @(negedge sclk); sdata=0; ob=23-11;
    @(negedge sclk); sdata=0; ob=23-10;
    @(negedge sclk); sdata=0; ob=23-9;
    @(negedge sclk); sdata=0; ob=23-8;
                                   
    @(negedge sclk); sdata=0; ob=23-7;
    @(negedge sclk); sdata=0; ob=23-6;
    @(negedge sclk); sdata=0; ob=23-5;
    @(negedge sclk); sdata=0; ob=23-4;
                                   
    @(negedge sclk); sdata=1; ob=23-3;
    @(negedge sclk); sdata=1; ob=23-2;
    @(negedge sclk); sdata=1; ob=23-1;
    @(negedge sclk); sdata=1; ob=23-0;

    //w3 l
    @(negedge sclk); sdata=1; ob=23-23;
    @(negedge sclk); sdata=1; ob=23-22;
    @(negedge sclk); sdata=1; ob=23-21;
    @(negedge sclk); sdata=1; ob=23-20;
                                   
    @(negedge sclk); sdata=1; ob=23-19;
    @(negedge sclk); sdata=1; ob=23-18;
    @(negedge sclk); sdata=1; ob=23-17;
    @(negedge sclk); sdata=1; ob=23-16;
                                   
    @(negedge sclk); sdata=0; ob=23-15;
    @(negedge sclk); sdata=0; ob=23-14;
    @(negedge sclk); sdata=0; ob=23-13;
    @(negedge sclk); sdata=0; ob=23-12;
                                   
    @(negedge sclk); sdata=1; ob=23-11;
    @(negedge sclk); sdata=1; ob=23-10;
    @(negedge sclk); sdata=1; ob=23-9;
    @(negedge sclk); sdata=1; ob=23-8;
                                   
    @(negedge sclk); sdata=0; ob=23-7;
    @(negedge sclk); sdata=0; ob=23-6;
    @(negedge sclk); sdata=0; ob=23-5;
    @(negedge sclk); sdata=0; ob=23-4;
                                   
    @(negedge sclk); sdata=1; ob=23-3;
    @(negedge sclk); sdata=1; ob=23-2;
    @(negedge sclk); sdata=1; ob=23-1;
    @(negedge sclk); sdata=1; ob=23-0;

    @(negedge sclk);

    sdata=0;ob=255;
    @(posedge lrclk);
    sdata=1;ob=255;
    @(negedge lrclk);
    sdata=0;ob=255;
    @(posedge lrclk);
    sdata=1;ob=255;
    @(negedge lrclk);
    sdata=0;ob=255;
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
