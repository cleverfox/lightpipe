/*
 * Copyright (c) 2017, Vladimir Goncharov <hwdev@viruzzz.org>
 * Copyright (c) 2013, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
 * All rights reserved.
 *
 * Redistribution and use in source and non-source forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in non-source form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *
 * THIS WORK IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * WORK, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

//this implementations have serious issue: AUDIO_DW must match actual word on channel

module i2s_rx #(
	parameter AUDIO_DW		= 24
)(
	input				rst,    //0 - reset, 1 - normal
        input                           format, //0 - I2S, 1 - LJ

	input				sclk,   //rising edge sense
	input				lrclk,
	input				sdata,

	// Parallel datastreams
	output reg [AUDIO_DW-1:0]	left_chan,
	output reg [AUDIO_DW-1:0]	right_chan
);

reg [AUDIO_DW-1:0]left;
reg [AUDIO_DW-1:0]right;
reg [AUDIO_DW-1:0]zero;
reg [7:0]       cbit;
reg		lrclk_d;
reg		lrclk_dd;
reg		lrclk_ddd;
wire		lrclk_nedge;
wire		lrclk_eof;
wire            sof;
wire            lchan;
//reg [7:0]debug;

assign lrclk_eof = (format==lrclk) && (lrclk ^ lrclk_d);
assign sof = (format && (lrclk_dd != lrclk)) ||
            (!format && (lrclk_dd != lrclk_ddd));
assign lrclk_nedge = (format && !lrclk_dd && lrclk) || 
            (!format && !lrclk_dd && lrclk_ddd );


always @(posedge sclk)
	lrclk_d <= lrclk;
always @(negedge sclk)
	lrclk_dd <= lrclk_d;
always @(negedge sclk)
	lrclk_ddd <= lrclk_dd;
    
// i2s sdata msb is valid one clock cycle after lrclk switches
// LJ  sdata msd is valid right after lrclk switches
/*
always @(posedge sclk)
    if(~format) begin //I2S
        if (lrclk_d)
            right <= {right[AUDIO_DW-2:0], sdata};
        else
            left <= {left[AUDIO_DW-2:0], sdata};
    end else begin //LJ
        if (lrclk) begin
            if(lrclk != lrclk_d)
                left <= sdata;
            else
                left <= {left[AUDIO_DW-2:0], sdata};
        end else begin
            if(lrclk != lrclk_d)
                right <= sdata;
            else
                right <= {right[AUDIO_DW-2:0], sdata};
        end
    end
*/

always @(posedge sclk)
    if(~format) begin //I2S
        if (lrclk_d && sof) //right sof
            right <= {sdata, zero[AUDIO_DW-2:0]};
        else if (lrclk_d && ~sof && cbit<AUDIO_DW)  //right
            right[AUDIO_DW-2-cbit] <= sdata;
        else if(~lrclk_d && sof) //left sof
            left <= {sdata, zero[AUDIO_DW-2:0]};
        else if(~lrclk_d && ~sof && cbit<AUDIO_DW) //left
            left[AUDIO_DW-2-cbit] <= sdata;
    end else begin //LJ
        if (lrclk) begin
            if(lrclk != lrclk_d)
                left <= {sdata, zero[AUDIO_DW-2:0]};
            else if(cbit<AUDIO_DW)
                left[AUDIO_DW-2-cbit] <= sdata;
        end else begin
            if(lrclk != lrclk_d)
                right <= {sdata, zero[AUDIO_DW-2:0]};
            else if(cbit<AUDIO_DW)
                right[AUDIO_DW-2-cbit] <= sdata;
        end
    end

    /*
always @(posedge sclk)
    if(sof)
        word1 <= {sdata, zero[AUDIO_DW-2:0]};
    else
        if(cbit<AUDIO_DW)
            word1[AUDIO_DW-2-cbit] <= sdata;
        */



always @(posedge sclk)
    if(!rst)
        zero <= 0;


always @(posedge sclk)
    if(!rst || sof)
        cbit <= 0;
    else 
        cbit <= cbit+1;
 
always @(posedge sclk)
	if (~rst) begin
		left_chan <= 0;
		right_chan <= 0;
	end else if (lrclk_eof && ~format) begin //I2S
		left_chan <= left;
		right_chan <= {right[AUDIO_DW-2:0], sdata};
	end else if (lrclk_nedge && format) begin //LJ
		right_chan <= right;
		left_chan <= left;
	end

endmodule
