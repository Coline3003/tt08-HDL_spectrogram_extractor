module channel_counter(input impulse, input reset, input enable, output reg [11:0] data, output reg ovf
                       );

    

//-- Sensitive to rising edge
  always @(posedge reset or posedge impulse) begin
  //-- Incrementar el registro
    if(reset == 1) begin
	data <= 12'b0;
	ovf <= 0;	
    end
    else if(impulse == 1 && enable == 0) begin
      data <= data + 1;
      if(data == 4095) begin
	ovf <= 1;
	end
    end
  
  end
  
endmodule