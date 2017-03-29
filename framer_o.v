module framer_o(
    input mclk, // The master clock for this module
    input wclk, 
    input [23:0] chan1,
    input [23:0] chan2,
    input [23:0] chan3,
    input [23:0] chan4,
    input [23:0] chan5,
    input [23:0] chan6,
    input [23:0] chan7,
    input [23:0] chan8,
    input [3:0] user,
    output reg adat=0
);

reg out=0;
reg [8:0] bclk;
reg [10:0] xbit;
reg plr;

always @( posedge mclk ) 
begin
    if (plr != wclk && wclk)
        bclk = 0; //reset bit counter
    else
        bclk ++;
    plr = wclk;
end

always @( negedge mclk ) 
begin
    case (bclk) 
        `include "adat_case.v"
    endcase
end

always @( posedge mclk )
begin
    if(out)
        adat <= ~adat;
end

endmodule

