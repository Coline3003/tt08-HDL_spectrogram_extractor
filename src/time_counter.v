/*
purspose : when the counter reaches 59:59 => send of the counter values
clk : RTC clock (1Hz for a send each hour)
reset : when '1' reset the counter
rst_ovf : when '1' force ovf signal to 0 (signal coming from FSM to report sending is over)
sec : second counter (from 0 to 59)
min : minutes counter (from 0 to 59)
ovf : hight when counter reaches 59:59
*/

module time_counter(input clk, input reset, input rst_ovf, output reg [5:0] sec,
               output reg [5:0] min, output reg ovf);

    
wire clear_ovf;
assign clear_ovf = rst_ovf || reset;

always @(posedge clk or posedge clear_ovf) begin

        if(clear_ovf == 1) begin
		ovf <= 0;
    	end
	else begin
		if(sec == 59 & min == 59) begin
			ovf <= 1;
		end
	end
end
	
  always @(posedge clk or posedge reset) begin
	  
    if(reset == 1) begin
	sec <= 6'b0;
	min <= 6'b0;
    end

    else begin
    sec <= sec + 1;
    if(sec == 59) begin
    sec <= 0;
      min <= min + 1;
    end
    if(sec == 59 & min == 59) begin
      sec <= 6'b0;
  	min <= 6'b0;
      
    end
  end
  end
  
  
endmodule
