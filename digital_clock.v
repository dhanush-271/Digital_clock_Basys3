`timescale 1ns / 1ps
module digital_clock(input clk,reset,edit,edit_shift,inc,dec,output [0:6] seg,output [3:0] digit,output reg shift_conf);

initial shift_conf=0;
reg edit_place;
reg [5:0] seconds,minutes;
reg [4:0] hours;

wire [3:0] ones,tens,hundreds,thousands;

digits digits_1(clk,reset,seconds,minutes,hours,ones,tens,hundreds,thousands);
seven_seg seven_seg_1(clk,reset,ones,tens,hundreds,thousands,seg,digit);

initial edit_place=1;

 //Slower Clock
 reg sclk=0;
 integer count=0;
 reg[31:0] scount=0;
 always @(posedge clk) begin
     if(count==49_999_999) begin
         count<=0;
         sclk<=~sclk;
     end 
     else count<=count+1;
 end

//Clock Run
always @(posedge(clk) or posedge(reset) ) begin
    if(reset == 1'b1) begin 
        seconds<=0;
        minutes<=0;
        hours<=0;  
	end
	else begin
		if(~edit) begin
			if(sclk==1'b1 && count==0) begin  
				seconds<=seconds + 1; 
				if(seconds==59) begin 
					seconds<=0;  
					minutes<=minutes + 1;
					if(minutes==59) begin 
						minutes<=0; 
						hours<=hours + 1; 
					   if(hours==24) begin  
							hours<=0; 
						end 
					end
				end     
			end
		end 
		
		else begin
			if(edit_shift) begin
				if(scount<50_000_000)
					scount<=scount+1;
				else begin
					if(edit_shift && scount==50_000_000) begin
						scount<=scount+1;
						shift_conf<=1;
						edit_place<=~edit_place;
					end
					else begin
						shift_conf<=1;
						edit_place<=edit_place;
						scount<=scount+1;
					end
				end
			end
			else if(inc) begin
				if(scount<25_000_000)
					scount<=scount+1;
				else begin
					if(inc && scount==25_000_000) begin
						scount<=scount+1;
						if(edit_place) begin
							if(hours<23)
								hours<=hours+1;
							else
								hours<=0;
						end 
						else begin
							if(minutes<59)
								minutes<=minutes+1;
							else
								minutes<=0;
						end
					end
					else begin
						scount<=scount+1;
						hours<=hours;
						minutes<=minutes;
					end
				end
			end
			else if(dec) begin
				if(scount<25_000_000)
					scount<=scount+1;
				else begin
					if(dec && scount==25_000_000) begin
						scount<=scount+1;
						if(edit_place) begin
							if(hours>0)
								hours<=hours-1;
							else
								hours<=5'd23;
						end 
						else begin
							if(minutes>0)
									minutes<=minutes-1;
							else
									minutes<=6'd59;
						end
					end
					else begin
						scount<=scount+1;
						hours<=hours;
						minutes<=minutes;
					end
				end
			end
			else begin
				scount<=0;
				shift_conf<=0;
			end
		end
	end 
end
      

endmodule