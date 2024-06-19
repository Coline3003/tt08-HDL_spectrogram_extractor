module time_counter(input clk, input reset, input rst_ovf, output reg [5:0] sec,
               output reg [5:0] min, output reg ovf);

    
//-- Output is 26-bit bus, initialized at 0
initial begin
  sec = 6'b0;
  min = 6'b0;
end

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
	

//-- Sensitive to rising edge
  always @(posedge clk or posedge reset) begin
  //-- Incrementar el registro
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
