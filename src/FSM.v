/*
A clock divider in Verilog, using the cascading
flip-flop method.
*/

module FSM(input clk, input reset, input wire ovf, output wire [3:0] selection, output SL_out, output reg rst , output reg [3:0] counter_register/* synthesis syn_preserve=1 */);

 
  reg counter_increment;
  reg counter_reset;
initial begin
  counter_register = 4'b0;
end

  reg [3:0] selection_bits;
  assign selection[3:0] = selection_bits[3:0];
  reg SL;
  assign SL_out = SL;

  
  localparam [4:0]
  s0 = 0,
  s1 = 1,
  s2 = 2,
  s3 = 3,
  s4 = 4,
  s5 = 5,
  s6 = 6,
  s7 = 7,
  s8 = 8,
  s9 = 9,
  s10 = 10,
  s11 = 11,
  s12 = 12,
  s13 = 13,
  s14 = 14,
  s15 = 15,
  s16 = 16,
  s17 = 17; 

	reg[4:0] state_reg, state_next/* synthesis syn_preserve=1 */;

 
// Internal counter process
  always @(posedge clk or posedge reset) begin

	if(reset==1) begin
		counter_register <= 4'b0;
	end

	else if (clk == 1) begin

		//The counter increment if the signal counter_increment is high
		if (counter_increment == 1) begin
			counter_register <= counter_register + 1;
		end
		//The counter reset when richs 12
		if(counter_register == 4'b1011 || counter_reset == 1) begin
      			counter_register <= 4'b0;
    		end
	end
  end


// State change process 
  always @(posedge clk or posedge reset) begin
  
	if(reset == 1) begin
		state_reg <= s0;
	end
    	
	else if (clk == 1) begin
		state_reg <= state_next;
	end
  end

  always @(*) begin
	if(counter_register == 4'b0000 && ovf == 1) begin
		SL = 1;
	end
	else begin
		SL = 0;
	end
  end


// State Machine
  always @(*) begin 
		rst = 0;
		counter_increment = 0;
		counter_reset = 0;
		selection_bits = 4'b0000;
    case (state_reg)
        s0 : begin
		rst = 0;
		counter_increment = 0;
		counter_reset = 0;
		selection_bits = 4'b0000;

        end

        s1 : begin //RTC 			
	
		selection_bits = 4'b0000;
		counter_increment = 1;

        end

        s2 : begin //CH1 

		selection_bits = 4'b0001;
		counter_increment = 1;
		

        end
      s3 : begin //CH2 

		selection_bits = 4'b0010;
		counter_increment = 1;

        end
      s4 : begin //CH3 

		selection_bits = 4'b0011;
		counter_increment = 1;


        end
      s5 : begin //CH4 

		selection_bits = 4'b0100;
		counter_increment = 1;

        end

      s6 : begin //CH5 

		selection_bits = 4'b0101;
		counter_increment = 1;

        end

      s7 : begin //CH6 

		selection_bits = 4'b0110;
		counter_increment = 1;
	

        end

      s8 : begin //CH7 

		selection_bits = 4'b0111;
		counter_increment = 1;

        end

      s9 : begin //CH8 

		selection_bits = 4'b1000;
		counter_increment = 1;
        end

      s10 : begin //CH9 

		selection_bits = 4'b1001;
		counter_increment = 1;

        end

      s11 : begin //CH10 

		selection_bits = 4'b1010;
		counter_increment = 1;

        end

      s12 : begin //CH11 

		selection_bits = 4'b1011;
		counter_increment = 1;

	
        end

      s13 : begin //CH12 

		selection_bits = 4'b1100;
		counter_increment = 1;


        end

      s14 : begin //CH13 

		selection_bits = 4'b1101;
		counter_increment = 1;


        end

      s15 : begin //CH14 

		selection_bits = 4'b1110;
		counter_increment = 1;


        end

      s16 : begin //CH15 

		selection_bits = 4'b1111;
		counter_increment = 1;
		

        end

      s17 : begin 
		selection_bits = 4'b0000;
		rst = 1;
		counter_reset = 1;
		counter_increment = 0; 

        end

      default : begin
		rst = 0;
		counter_reset = 0;
		counter_increment = 0; 
      end
    endcase
end 
  
// State Machine
  always @(*) begin 
    state_next = state_reg; // default state_next
    case (state_reg)
        s0 : begin	
          	if (ovf == 1) begin  
                	state_next = s1; 
            	end
            	else begin 
                	state_next = s0; 
            	end
        end

        s1 : begin //RTC 
		
          	if (counter_register == 4'b1011) begin  
                	state_next = s2; 
            	end
            	else begin // remain in current state
                	state_next = s1; 
            	end
        end

        s2 : begin //CH1 
		
          	if (counter_register == 4'b1011) begin  
                	state_next = s3; 
            	end
            	else begin // remain in current state
                	state_next = s2; 
            	end
        end
      s3 : begin //CH2 

          	if (counter_register == 4'b1011) begin  
                	state_next = s4; 
            	end
            	else begin // remain in current state
                	state_next = s3; 
            	end
        end
      s4 : begin //CH3 
		
          	if (counter_register == 4'b1011) begin  
                	state_next = s5; 
            	end
            	else begin // remain in current state
                	state_next = s4; 
            	end
        end
      s5 : begin //CH4 
	
          	if (counter_register == 4'b1011) begin  
                	state_next = s6; 
            	end
            	else begin // remain in current state
                	state_next = s5; 
            	end
        end

      s6 : begin //CH5 

          	if (counter_register == 4'b1011) begin  
                	state_next = s7; 
            	end
            	else begin // remain in current state
                	state_next = s6; 
            	end
        end

      s7 : begin //CH6 
	
          	if (counter_register == 4'b1011) begin  
                	state_next = s8; 
            	end
            	else begin // remain in current state
                	state_next = s7; 
            	end
        end

      s8 : begin //CH7 

          	if (counter_register == 4'b1011) begin  
                	state_next = s9; 
            	end
            	else begin // remain in current state
                	state_next = s8; 
            	end
        end

      s9 : begin //CH8 

          	if (counter_register == 4'b1011) begin  
                	state_next = s10; 
            	end
            	else begin // remain in current state
                	state_next = s9; 
            	end
        end

      s10 : begin //CH9 

          	if (counter_register == 4'b1011) begin  
                	state_next = s11; 
            	end
            	else begin // remain in current state
                	state_next = s10; 
            	end
        end

      s11 : begin //CH10 

          	if (counter_register == 4'b1011) begin  
                	state_next = s12; 
            	end
            	else begin // remain in current state
                	state_next = s11; 
            	end
        end

      s12 : begin //CH11 

          	if (counter_register == 4'b1011) begin  
                	state_next = s13; 
            	end
            	else begin // remain in current state
                	state_next = s12; 
            	end
        end

      s13 : begin //CH12 
	
          	if (counter_register == 4'b1011) begin  
                	state_next = s14; 
            	end
            	else begin // remain in current state
                	state_next = s13; 
            	end
        end

      s14 : begin //CH13 

          	if (counter_register == 4'b1011) begin  
                	state_next = s15; 
            	end
            	else begin // remain in current state
                	state_next = s14; 
            	end
        end

      s15 : begin //CH14 

          	if (counter_register == 4'b1011) begin  
                	state_next = s16; 
            	end
            	else begin // remain in current state
                	state_next = s15; 
            	end
        end

      s16 : begin //CH15 

          	if (counter_register == 4'b1011) begin  
                	state_next = s17; 
            	end
            	else begin // remain in current state
                	state_next = s16; 
            	end
        end

      s17 : begin 
 		state_next = s0; 

        end

      default : begin
        state_next = s0;
      end
    endcase
end 
  
endmodule



