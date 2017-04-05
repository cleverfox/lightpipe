`timescale 1us / 10ns
module test_framer;

reg mclk;
reg fs256;
reg rst;
reg [23:0]word0;
reg [23:0]word1;
reg [23:0]word2;
reg [23:0]word3;
reg [23:0]word4;
reg [23:0]word5;
reg [23:0]word6;
reg [23:0]word7;
reg [7:0]bitclock;
reg [3:0]user;
wire wordclock;
assign wordclock = (bitclock[7]);
wire const0;
wire const1;
wire [8:0]mathed;
assign matched = { 
    rwu == twu,
    rw7 == tw7,
    rw6 == tw6,
    rw5 == tw5,
    rw4 == tw4,
    rw3 == tw3,
    rw2 == tw2,
    rw1 == tw1,
    rw0 == tw0
    };
assign const0 = 0;
assign const1 = 1;
wire ligtpipe;
wire [3:0]rx_usr;
wire [23:0]rxword0;
wire [23:0]rxword1;
wire [23:0]rxword2;
wire [23:0]rxword3;
wire [23:0]rxword4;
wire [23:0]rxword5;
wire [23:0]rxword6;
wire [23:0]rxword7;

wire [3:0] rwu;
wire [23:0]rw0;
wire [23:0]rw1;
wire [23:0]rw2;
wire [23:0]rw3;
wire [23:0]rw4;
wire [23:0]rw5;
wire [23:0]rw6;
wire [23:0]rw7;

wire [3:0] twu;
wire [23:0]tw0;
wire [23:0]tw1;
wire [23:0]tw2;
wire [23:0]tw3;
wire [23:0]tw4;
wire [23:0]tw5;
wire [23:0]tw6;
wire [23:0]tw7;

framer_o framer_o_inst(fs256, wordclock, 
    word0, 
    word1, 
    word2, 
    word3, 
    word4, 
    word5, 
    word6, 
    word7, 
    user, lightpipe);

lightpipe_recv recv(
    mclk, rst, lightpipe, 
    rxwordclock, 
    rxword0, 
    rxword1, 
    rxword2, 
    rxword3, 
    rxword4, 
    rxword5, 
    rxword6, 
    rxword7, 
    rx_usr);

recv_sync syncer1(
    mclk,
    rst, 
    const1,
    wordclock, 
    word0, 
    word1, 
    word2, 
    word3, 
    word4, 
    word5, 
    word6, 
    word7, 
    user,
    wordclock,
    tw0,
    tw1,
    tw2,
    tw3,
    tw4,
    tw5,
    tw6,
    tw7,
    twu
);


recv_sync syncer2(
    mclk,
    rst, 
    const0,
    rxwordclock, 
    rxword0, 
    rxword1, 
    rxword2, 
    rxword3, 
    rxword4, 
    rxword5, 
    rxword6, 
    rxword7, 
    rx_usr,
    wordclock,
    rw0,
    rw1,
    rw2,
    rw3,
    rw4,
    rw5,
    rw6,
    rw7,
    rwu
);

dpll pll_inst1 (
    mclk,
    rst,
    wordclock,
    pllbitclock,
    plllocked
);
 

//#.000 010 41666666666666

always
  #0.01 mclk = ~mclk;

always 
// .000 000 17715419501133 for 44100
  #0.044288 fs256 = ~fs256;

always @(posedge fs256)
    bitclock = bitclock+1;

always @(posedge wordclock)
begin
    user <= user+1;
    word0 = {word0[22:0], word0[23]};
    word1 = {word1[22:0], word1[23]};
    word2 = {word2[22:0], word2[23]};
    word3 = {word3[22:0], word3[23]};
    word4 = {word4[22:0], word4[23]};
    word5 = {word5[22:0], word5[23]};
    word6 = {word6[22:0], word6[23]};
    word7 = {word7[22:0], word7[23]};
end

        
//от начала времени...

/*
always
  @(posedge wordclock)
  begin
      word0 = word0 - 1;
      word1 = word1 + 1;
      word2 = word2 - 1;
      word3 = word3 + 1;
      word4 = word4 - 1;
      word5 = word5 + 1;
      word6 = word6 - 1;
      word7 = word7 + 1;
  end
*/

initial
begin
    rst = 0;
    mclk = 0;
    fs256 = 0;
    bitclock = 0;

    user=4'h0;
    word0 = 1;
    word1 = 2;
    word2 = 4;
    word3 = 8;
    word4 = 16;
    word5 = 32;
    word6 = 64;
    word7 = 128;

    #20;
    rst = 1;
    #10;
    
  /*
  #50;
  @(posedge wordclock)
     reset = 0;

  #25;

//ждем фронта тактовой частоты и сразу после нее подаем сигнал записи
  @(posedge clk)
    begin
      wdatap = 8'h02;
      wdata = 8'h55;
      wr = 1'b1;
    end

//по следующему фронту снимаем сигнал записи
  @(posedge clk)
      wr = 1'b0;
    
//ждем фронта тактовой частоты и сразу после нее подаем сигнал записи
  @(posedge clk)
    begin
      wdatap = 8'h01;
      wdata = 8'h33;
      wr = 1'b1;
    end

  @(posedge clk)
      wr = 1'b0;
    
   
  @(posedge clk)
    begin
      wdatap = 8'h20;
      wdata = 8'hA3;
      wr = 1'b1;
    end

  @(posedge clk)
    wr = 1'b0;
    */

end

initial
begin
  #500 $finish;
end

//создаем файл VCD для последующего анализа сигналов
initial
begin
  $dumpfile("out.vcd");
  $dumpvars(0,test_framer);
end

//наблюдаем на некоторыми сигналами системы
initial
$monitor($stime,, mclk,, wordclock,, word0,, word1,, word2,, lightpipe);

endmodule

