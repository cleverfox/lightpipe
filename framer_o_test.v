`timescale 1ns / 1ps
module test_framer;

reg mclk;
reg pllclk;
reg hclk;
reg rst;
reg [7:0][23:0]words;
reg [7:0]bitclock;
reg [3:0]user;
wire wordclock;
assign wordclock = (bitclock[7]);
wire ligtpipe;
wire [23:0]ch1;
wire [23:0]ch2;
wire [23:0]ch3;
wire [23:0]ch4;
wire [23:0]ch5;
wire [23:0]ch6;
wire [23:0]ch7;
wire [23:0]ch8;
wire [3:0]rx_usr;
framer_o framer_o_inst(mclk, wordclock, 
    words[0], 
    words[1], 
    words[2], 
    words[3], 
    words[4], 
    words[5], 
    words[6], 
    words[7], 
    user, lightpipe);

lightpipe_recv recv(
    hclk, wclk, rst, wordclock, 
    ch1, ch2, ch3, ch4, ch5, ch6, ch7, ch8,
    rx_usr,
    lightpipe);


always
  #17.7154 pllclk = ~pllclk;

always
  #16 mclk = ~mclk;

always
  #2 hclk = ~hclk;

always @(posedge mclk)
begin
    bitclock ++;
end


        
//от начала времени...

always
  @(posedge wordclock)
  begin
      words[0] = words[0] - 1;
      words[1] = words[1] + 1;
      words[2] = words[2] - 1;
      words[3] = words[3] + 1;
      words[4] = words[4] - 1;
      words[5] = words[5] + 1;
      words[6] = words[6] - 1;
      words[7] = words[7] + 1;
  end

initial
begin
    rst = 0;
    mclk = 0;
    hclk = 0;
    pllclk = 0;
    bitclock = 0;
    #50;
    rst = 1;
    #10;
    user=4'h3;
    words[0] = 24'hffffff;
    words[1] = 0;
    words[2] = 24'hffffff;
    words[3] = 0;
    words[4] = 24'hffffff;
  words[5] = 0;
  words[6] = 24'hffffff;
  words[7] = 0;

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
  #50000 $finish;
end

//создаем файл VCD для последующего анализа сигналов
initial
begin
  $dumpfile("out.vcd");
  $dumpvars(0,test_framer);
end

//наблюдаем на некоторыми сигналами системы
initial
$monitor($stime,, mclk,, wordclock,, words[0],, words[1],, words[2],, lightpipe);

endmodule

