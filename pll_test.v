`timescale 1ns / 1ps
module pll_framer;

reg mclk;
reg rst;
reg wc;

dpll dpll_inst(
    mclk, rst,
    wc,
    bclk,
    error
    );

always
  #2267.572 wc = ~wc;

always
  #1 mclk = ~mclk;

initial
begin
    rst = 1;
    mclk = 0;
    wc = 0;
    #16;
    rst = 0;
    #128;
    rst = 1;
end

initial
begin
  #25000 $finish;
end

//создаем файл VCD для последующего анализа сигналов
initial
begin
  $dumpfile("out.vcd");
  $dumpvars(0,pll_framer);
end

//наблюдаем на некоторыми сигналами системы
initial
$monitor($stime,, mclk,, wc,, rst,, bclk, error);

endmodule

