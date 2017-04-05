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

reg out;
reg [8:0] bclk;
reg [10:0] xbit;
reg plr;

always @( posedge mclk ) 
begin
    if (plr != wclk && wclk)
        bclk <= 0; //reset bit counter
    else
        bclk = bclk + 1;
    plr <= wclk;
end

always @( negedge mclk ) 
begin
    case (bclk) 
8'h00: out <= 1;
8'h01: out <= chan1[0];
8'h02: out <= chan1[1];
8'h03: out <= chan1[2];
8'h04: out <= chan1[3];
8'h05: out <= 1;
8'h06: out <= chan1[4];
8'h07: out <= chan1[5];
8'h08: out <= chan1[6];
8'h09: out <= chan1[7];
8'h0a: out <= 1;
8'h0b: out <= chan1[8];
8'h0c: out <= chan1[9];
8'h0d: out <= chan1[10];
8'h0e: out <= chan1[11];
8'h0f: out <= 1;
8'h10: out <= chan1[12];
8'h11: out <= chan1[13];
8'h12: out <= chan1[14];
8'h13: out <= chan1[15];
8'h14: out <= 1;
8'h15: out <= chan1[16];
8'h16: out <= chan1[17];
8'h17: out <= chan1[18];
8'h18: out <= chan1[19];
8'h19: out <= 1;
8'h1a: out <= chan1[20];
8'h1b: out <= chan1[21];
8'h1c: out <= chan1[22];
8'h1d: out <= chan1[23];
8'h1e: out <= 1;
8'h1f: out <= chan2[0];
8'h20: out <= chan2[1];
8'h21: out <= chan2[2];
8'h22: out <= chan2[3];
8'h23: out <= 1;
8'h24: out <= chan2[4];
8'h25: out <= chan2[5];
8'h26: out <= chan2[6];
8'h27: out <= chan2[7];
8'h28: out <= 1;
8'h29: out <= chan2[8];
8'h2a: out <= chan2[9];
8'h2b: out <= chan2[10];
8'h2c: out <= chan2[11];
8'h2d: out <= 1;
8'h2e: out <= chan2[12];
8'h2f: out <= chan2[13];
8'h30: out <= chan2[14];
8'h31: out <= chan2[15];
8'h32: out <= 1;
8'h33: out <= chan2[16];
8'h34: out <= chan2[17];
8'h35: out <= chan2[18];
8'h36: out <= chan2[19];
8'h37: out <= 1;
8'h38: out <= chan2[20];
8'h39: out <= chan2[21];
8'h3a: out <= chan2[22];
8'h3b: out <= chan2[23];
8'h3c: out <= 1;
8'h3d: out <= chan3[0];
8'h3e: out <= chan3[1];
8'h3f: out <= chan3[2];
8'h40: out <= chan3[3];
8'h41: out <= 1;
8'h42: out <= chan3[4];
8'h43: out <= chan3[5];
8'h44: out <= chan3[6];
8'h45: out <= chan3[7];
8'h46: out <= 1;
8'h47: out <= chan3[8];
8'h48: out <= chan3[9];
8'h49: out <= chan3[10];
8'h4a: out <= chan3[11];
8'h4b: out <= 1;
8'h4c: out <= chan3[12];
8'h4d: out <= chan3[13];
8'h4e: out <= chan3[14];
8'h4f: out <= chan3[15];
8'h50: out <= 1;
8'h51: out <= chan3[16];
8'h52: out <= chan3[17];
8'h53: out <= chan3[18];
8'h54: out <= chan3[19];
8'h55: out <= 1;
8'h56: out <= chan3[20];
8'h57: out <= chan3[21];
8'h58: out <= chan3[22];
8'h59: out <= chan3[23];
8'h5a: out <= 1;
8'h5b: out <= chan4[0];
8'h5c: out <= chan4[1];
8'h5d: out <= chan4[2];
8'h5e: out <= chan4[3];
8'h5f: out <= 1;
8'h60: out <= chan4[4];
8'h61: out <= chan4[5];
8'h62: out <= chan4[6];
8'h63: out <= chan4[7];
8'h64: out <= 1;
8'h65: out <= chan4[8];
8'h66: out <= chan4[9];
8'h67: out <= chan4[10];
8'h68: out <= chan4[11];
8'h69: out <= 1;
8'h6a: out <= chan4[12];
8'h6b: out <= chan4[13];
8'h6c: out <= chan4[14];
8'h6d: out <= chan4[15];
8'h6e: out <= 1;
8'h6f: out <= chan4[16];
8'h70: out <= chan4[17];
8'h71: out <= chan4[18];
8'h72: out <= chan4[19];
8'h73: out <= 1;
8'h74: out <= chan4[20];
8'h75: out <= chan4[21];
8'h76: out <= chan4[22];
8'h77: out <= chan4[23];
8'h78: out <= 1;
8'h79: out <= chan5[0];
8'h7a: out <= chan5[1];
8'h7b: out <= chan5[2];
8'h7c: out <= chan5[3];
8'h7d: out <= 1;
8'h7e: out <= chan5[4];
8'h7f: out <= chan5[5];
8'h80: out <= chan5[6];
8'h81: out <= chan5[7];
8'h82: out <= 1;
8'h83: out <= chan5[8];
8'h84: out <= chan5[9];
8'h85: out <= chan5[10];
8'h86: out <= chan5[11];
8'h87: out <= 1;
8'h88: out <= chan5[12];
8'h89: out <= chan5[13];
8'h8a: out <= chan5[14];
8'h8b: out <= chan5[15];
8'h8c: out <= 1;
8'h8d: out <= chan5[16];
8'h8e: out <= chan5[17];
8'h8f: out <= chan5[18];
8'h90: out <= chan5[19];
8'h91: out <= 1;
8'h92: out <= chan5[20];
8'h93: out <= chan5[21];
8'h94: out <= chan5[22];
8'h95: out <= chan5[23];
8'h96: out <= 1;
8'h97: out <= chan6[0];
8'h98: out <= chan6[1];
8'h99: out <= chan6[2];
8'h9a: out <= chan6[3];
8'h9b: out <= 1;
8'h9c: out <= chan6[4];
8'h9d: out <= chan6[5];
8'h9e: out <= chan6[6];
8'h9f: out <= chan6[7];
8'ha0: out <= 1;
8'ha1: out <= chan6[8];
8'ha2: out <= chan6[9];
8'ha3: out <= chan6[10];
8'ha4: out <= chan6[11];
8'ha5: out <= 1;
8'ha6: out <= chan6[12];
8'ha7: out <= chan6[13];
8'ha8: out <= chan6[14];
8'ha9: out <= chan6[15];
8'haa: out <= 1;
8'hab: out <= chan6[16];
8'hac: out <= chan6[17];
8'had: out <= chan6[18];
8'hae: out <= chan6[19];
8'haf: out <= 1;
8'hb0: out <= chan6[20];
8'hb1: out <= chan6[21];
8'hb2: out <= chan6[22];
8'hb3: out <= chan6[23];
8'hb4: out <= 1;
8'hb5: out <= chan7[0];
8'hb6: out <= chan7[1];
8'hb7: out <= chan7[2];
8'hb8: out <= chan7[3];
8'hb9: out <= 1;
8'hba: out <= chan7[4];
8'hbb: out <= chan7[5];
8'hbc: out <= chan7[6];
8'hbd: out <= chan7[7];
8'hbe: out <= 1;
8'hbf: out <= chan7[8];
8'hc0: out <= chan7[9];
8'hc1: out <= chan7[10];
8'hc2: out <= chan7[11];
8'hc3: out <= 1;
8'hc4: out <= chan7[12];
8'hc5: out <= chan7[13];
8'hc6: out <= chan7[14];
8'hc7: out <= chan7[15];
8'hc8: out <= 1;
8'hc9: out <= chan7[16];
8'hca: out <= chan7[17];
8'hcb: out <= chan7[18];
8'hcc: out <= chan7[19];
8'hcd: out <= 1;
8'hce: out <= chan7[20];
8'hcf: out <= chan7[21];
8'hd0: out <= chan7[22];
8'hd1: out <= chan7[23];
8'hd2: out <= 1;
8'hd3: out <= chan8[0];
8'hd4: out <= chan8[1];
8'hd5: out <= chan8[2];
8'hd6: out <= chan8[3];
8'hd7: out <= 1;
8'hd8: out <= chan8[4];
8'hd9: out <= chan8[5];
8'hda: out <= chan8[6];
8'hdb: out <= chan8[7];
8'hdc: out <= 1;
8'hdd: out <= chan8[8];
8'hde: out <= chan8[9];
8'hdf: out <= chan8[10];
8'he0: out <= chan8[11];
8'he1: out <= 1;
8'he2: out <= chan8[12];
8'he3: out <= chan8[13];
8'he4: out <= chan8[14];
8'he5: out <= chan8[15];
8'he6: out <= 1;
8'he7: out <= chan8[16];
8'he8: out <= chan8[17];
8'he9: out <= chan8[18];
8'hea: out <= chan8[19];
8'heb: out <= 1;
8'hec: out <= chan8[20];
8'hed: out <= chan8[21];
8'hee: out <= chan8[22];
8'hef: out <= chan8[23];
8'hf0: out <= 1;
8'hf1: out <= 0;
8'hf2: out <= 0;
8'hf3: out <= 0;
8'hf4: out <= 0;
8'hf5: out <= 0;
8'hf6: out <= 0;
8'hf7: out <= 0;
8'hf8: out <= 0;
8'hf9: out <= 0;
8'hfa: out <= 0;
8'hfb: out <= 1;
8'hfc: out <= user[0];
8'hfd: out <= user[1];
8'hfe: out <= user[2];
8'hff: out <= user[3];
    endcase
end

always @( posedge mclk )
begin
    if(out)
        adat <= ~adat;
end

endmodule

