module PISO_register(
  input wire clk,
  input wire [11:0] parallel_in,
  input wire SL, 
  output reg serial_out,
  output reg [11:0] register
);
  
  //reg [12:0] register;

always @(posedge clk) begin
    if(SL==1) begin
	
	register[11:0] = parallel_in[11:0];
	serial_out <= register[0];
	register = register >>> 1;


	       
    end
    else if (SL==0) begin
	serial_out <= register[0];
        register = register >>> 1;
	 // Output the least significant bit
    end
  end

endmodule
