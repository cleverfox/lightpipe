module lightpipe_recv(
    input mclk, // The master clock for this module
    input rst,
    input adat,
    output reg wclk, 
    output reg [23:0] word0,
    output reg [23:0] word1,
    output reg [23:0] word2,
    output reg [23:0] word3,
    output reg [23:0] word4,
    output reg [23:0] word5,
    output reg [23:0] word6,
    output reg [23:0] word7,
    output reg [3:0] user
);

reg [7:0]framebit;
reg [4:0]chan;
reg [7:0]chstart;
reg [29:0]word;
wire [23:0]oword;
wire bitclock = oe;
wire nloss = ~nrzi_loss;
reg nloss_d;

assign oword = {
	word[28], word[27], word[26], word[21],
	word[24], word[23], word[22], word[21],
	word[19], word[18], word[17], word[16],
	word[14], word[13], word[12], word[11],
	word[9],  word[8],  word[7],  word[6],
	word[4],  word[3],  word[2],  word[1]
};

wire oe, data;
nrzi_decoder nrzi_inst (
    mclk,
    ~rst,
    adat,
    oe,
    in,
    nrzi_loss
);

always @(posedge mclk)
    if(!rst)
        user <= 0;
    else if(bitclock && framebit == 0) 
        user[3:0]<=word[29:26];

always @(posedge mclk)
    if(!rst)
       wclk <= 0;
    else if(bitclock && framebit == 0) 
        wclk <= 1;
    else if(bitclock && framebit == 128) 
        wclk <= 0;
 
always @(posedge mclk)
    if(!rst)
        nloss_d <= 1;
    else if(bitclock)
        nloss_d <= nloss;

always @(posedge mclk)
    if(!rst)
        word <= 0;
    else if(bitclock)
        word <= {in, word[29:1]};

always @(posedge mclk)
begin
    if(!rst)
    begin
        chstart <= 0;
        chan <= 0;
        framebit <= 0;
        word0 <= 0;
        word1 <= 'hff;
        word2 <= 0;
        word3 <= 'hff;
        word4 <= 0;
        word5 <= 'hff;
        word6 <= 0;
        word7 <= 'hff;
    end else 
        if(bitclock)
            begin
                if(nloss && !nloss_d)
                begin
                    framebit <= 252;
                    chstart = 252;
                    chan <= 8;
                end
                else
                begin
                    if(framebit == 255) begin
                        chstart <= framebit+1;
                        chan <= 0;
                    end else if(framebit == 30)begin
                        chstart = framebit+1;
                        chan <= 1;
                        word0<=oword;
                    end else if(framebit == 60)begin
                        chstart = framebit+1;
                        chan <= 2;
                        word1<=oword;
                    end else if(framebit == 90)begin
                        chstart = framebit+1;
                        chan <= 3;
                        word2<=oword;
                    end else if(framebit == 120)begin
                        chstart = framebit+1;
                        chan <= 4;
                        word3<=oword;
                    end else if(framebit == 150)begin
                        chstart = framebit+1;
                        chan <= 5;
                        word4<=oword;
                    end else if(framebit == 180)begin
                        chstart = framebit+1;
                        chan <= 6;
                        word5<=oword;
                    end else if(framebit == 210)begin
                        chstart = framebit+1;
                        chan <= 7;
                        word6<=oword;
                    end else if(framebit == 240)begin
                        chstart = framebit+1;
                        chan <= 8;
                        word7<=oword;
                    end
                    framebit <= framebit + 1;
                end
            end
end

endmodule

