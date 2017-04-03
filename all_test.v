`timescale 1us / 1ns
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
    rwordclock, 
    rxword0, 
    rxword1, 
    rxword2, 
    rxword3, 
    rxword4, 
    rxword5, 
    rxword6, 
    rxword7, 
    rx_usr);


//#.000 010 41666666666666

always
  #0.01 mclk = ~mclk;

always 
// .000 000 17715419501133 for 44100
  #0.044288 fs256 = ~fs256;

always @(posedge fs256)
    bitclock = bitclock+1;

always @(posedge wordclock)
	user <= user+1;

        
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
    word0 = 24'h0;
    word1 = 0;
    word2 = 24'h0;
    word3 = 0;
    word4 = 24'h0;
    word5 = 0;
    word6 = 24'h0;
    word7 = 0;

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

