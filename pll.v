module dpll
#(
    parameter DIVW = 16
)(
    input clk,
    input reset,
    input wc,
    output reg bitclock,
    output reg locked
);

reg wc_d;

reg [DIVW:0]wordcnt;
reg [DIVW-8:0]cnh;
reg [7:0]cnl;
reg [DIVW-9:0]clockdownh;
reg [DIVW-8:0]clockdown;
reg [7:0]cbit;
reg [7:0]nbit;

always @(clk) begin
    wc_d <= wc;
end

always @(clk) begin
    if (!reset) 
        locked <= 0;
    else
    if (wc_d == 0 && wc == 1) 
        locked <= ~(cbit!=0 && cbit!=255 || wordcnt<256);
end

always @(clk) begin
    if (!reset) 
        bitclock <= 0;
end

always @(clk) begin
    if (!reset) 
    begin
        wordcnt <= 1;
        cnh<=0;
        cnl<=0;
    end
    else
        if(wc_d == 0 && wc == 1)
        begin
            cnh <= wordcnt[DIVW:8];
            cnl <= wordcnt[7:0];
            wordcnt <= 0;
        end
        else
            wordcnt <= wordcnt+1;
end

always @(clk) begin
    if (!reset) 
    begin
        bitclock <= 0;
        cbit <= 0;
        clockdown <= 0;
        clockdownh <= 0;
    end
    else
    begin
        if (wc_d == 0 && wc == 1) 
        begin
            cbit <= 0;
            nbit <= 1;
            clockdownh <= cnh[DIVW-8:1];
            clockdown <= cnh - 1 + (cnl[7]?1:0);
        end
        else
            if (clockdown == 0)
            begin
                cbit <= cbit+1;
                nbit <= cbit+2;
                clockdownh <= cnh[DIVW-8:1];
                clockdown <=  cnh - 1 + ((nbit[0]   ==   0 && cnl[7])?1:0 +
                    (nbit[1:0] ==   3 && cnl[6])?1:0 +
                    (nbit[2:0] ==   5 && cnl[5])?1:0 +
                    (nbit[3:0] ==  15 && cnl[4])?1:0 +
                    (nbit[4:0] ==  25 && cnl[3])?1:0 +
                    (nbit[5:0] ==  41 && cnl[2])?1:0 +
                    (nbit[6:0] == 113 && cnl[1])?1:0 +
                    (nbit[7:0] == 137 && cnl[0])?1:0);
            end
            else
            begin
                clockdown <= clockdown-1;
                bitclock <= (clockdownh > 1);
                if(clockdownh > 0)
                    clockdownh <= clockdownh-1;
            end
        end
    end

endmodule


