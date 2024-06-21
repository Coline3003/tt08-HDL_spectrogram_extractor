/*
purpose : count each emission when detect a rising edge
impulse : signal coming from analog design (resonance of one of the piezo sensors) 
reset : when ('1') reset the counter
enable : when ('0') allows the counter to increment
data : value of the counter (from 0 to 4095)
ovf : '1' when the counter overflows
*/

module channel_counter(input impulse, input reset, input enable, output reg [11:0] data, output reg ovf
                       );


  always @(posedge reset or posedge impulse) begin
	  
    if(reset == 1) begin
	data <= 12'b0;
	ovf <= 0;	
    end
    	else if(impulse == 1) begin
		if (enable == 0) begin
      			data <= data + 1;
		end
      		if(data == 4095) begin
			ovf <= 1;
		end
    		
	  end
  
  end
  
endmodule
