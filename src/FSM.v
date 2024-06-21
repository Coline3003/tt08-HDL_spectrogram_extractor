/* 
 clk : clock for the internal counter and the state change process
 reset : when '1', reset the counter and return to state S0
 ovf : when '1', allows to go from state s0 to s1 (starts the state machine and sending data)
 selection_bits : output of the state machine, controls the multiplexer according to the output to send
 SL : controls the PISO_regiter. When '1' Load, '0' shift
 rst : reset all channel counters when the sending is over 
*/

module FSM(input clk, input reset, input wire ovf, output reg [3:0] selection_bits, output reg SL, output reg rst);

  reg counter_increment;
	reg [3:0] counter_register;
  
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

	reg[4:0] state_reg, state_next;

 
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
		//The counter reset when richs 11
		if(counter_register == 4'b1011) begin
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

// State Machine
  always @(*) begin
 
// default state_next and outputs
    state_next = state_reg; 
	rst = 0;
	SL = 0;
	counter_increment = 0;
	selection_bits = 4'b0000;

    case (state_reg)
        s0 : begin
		rst = 0;
		SL = 0;
		counter_increment = 0;
		selection_bits = 4'b0000;
		
          	if (ovf == 1) begin  
                	state_next = s1; 
            	end
            	else begin
                	state_next = s0; 
            	end
        end

        s1 : begin //RTC 
		
		selection_bits = 4'b0000;
		counter_increment = 1;
			
		if (counter_register == 4'b0000) begin
			SL = 1;
		end
		else begin
			SL = 0;
			
		end
		
          	if (counter_register == 4'b1011) begin  
                	state_next = s2; 
            	end
            	else begin // remain in current state
                	state_next = s1; 
            	end
        end

        s2 : begin //CH1 

		selection_bits = 4'b0001;
		counter_increment = 1;
			
		if (counter_register == 4'b0000) begin
			SL = 1;
		end
		else begin
			SL = 0;
		end
		
          	if (counter_register == 4'b1011) begin  
                	state_next = s3; 
            	end
            	else begin // remain in current state
                	state_next = s2; 
            	end
        end
      s3 : begin //CH2 

		selection_bits = 4'b0010;
		//SL = 1;
		counter_increment = 1;
		if (counter_register == 4'b0000) begin
			SL = 1;
		end
		else begin
			SL = 0;
		end

          	if (counter_register == 4'b1011) begin  
                	state_next = s4; 
            	end
            	else begin // remain in current state
                	state_next = s3; 
            	end
        end
      s4 : begin //CH3 
		
		selection_bits = 4'b0011;
		//SL = 0;
		counter_increment = 1;
		if (counter_register == 4'b0000) begin
			SL = 1;
		end
		else begin
			SL = 0;
		end
	
          	if (counter_register == 4'b1011) begin  
                	state_next = s5; 
            	end
            	else begin // remain in current state
                	state_next = s4; 
            	end
        end
      s5 : begin //CH4 
		selection_bits = 4'b0100;
		//SL = 1;
		counter_increment = 1;
		if (counter_register == 4'b0000) begin
			SL = 1;
		end
		else begin
			SL = 0;
		end
	
          	if (counter_register == 4'b1011) begin  
                	state_next = s6; 
            	end
            	else begin // remain in current state
                	state_next = s5; 
            	end
        end

      s6 : begin //CH5 
		selection_bits = 4'b0101;
		counter_increment = 1;
		if (counter_register == 4'b0000) begin
			SL = 1;
		end
		else begin
			SL = 0;
		end
	
          	if (counter_register == 4'b1011) begin  
                	state_next = s7; 
            	end
            	else begin // remain in current state
                	state_next = s6; 
            	end
        end

      s7 : begin //CH6 

		selection_bits = 4'b0110;
		counter_increment = 1;
		if (counter_register == 4'b0000) begin
			SL = 1;
		end

		else begin
			SL = 0;
		end
	
          	if (counter_register == 4'b1011) begin  
                	state_next = s8; 
            	end
            	else begin // remain in current state
                	state_next = s7; 
            	end
        end

      s8 : begin //CH7 

		selection_bits = 4'b0111;
		counter_increment = 1;
		if (counter_register == 4'b0000) begin
			SL = 1;
		end
		else begin
			SL = 0;
		end
	
          	if (counter_register == 4'b1011) begin  
                	state_next = s9; 
            	end
            	else begin // remain in current state
                	state_next = s8; 
            	end
        end

      s9 : begin //CH8 
		selection_bits = 4'b1000;
		//SL = 1;
		counter_increment = 1;
		if (counter_register == 4'b0000) begin
			SL = 1;
		end
		else begin
			SL = 0;
		end
	
          	if (counter_register == 4'b1011) begin  
                	state_next = s10; 
            	end
            	else begin // remain in current state
                	state_next = s9; 
            	end
        end

      s10 : begin //CH9 
		selection_bits = 4'b1001;
		//SL = 1;
		counter_increment = 1;
		if (counter_register == 4'b0000) begin
			SL = 1;
		end
		else begin
			SL = 0;

		end		

          	if (counter_register == 4'b1011) begin  
                	state_next = s11; 
            	end
            	else begin // remain in current state
                	state_next = s10; 
            	end
        end

      s11 : begin //CH10 
		selection_bits = 4'b1010;

		counter_increment = 1;
		if (counter_register == 4'b0000) begin
			SL = 1;
		end

		else begin
			SL = 0;
		end
	
          	if (counter_register == 4'b1011) begin  
                	state_next = s12; 
            	end
            	else begin // remain in current state
                	state_next = s11; 
            	end
        end

      s12 : begin //CH11 

		selection_bits = 4'b1011;
		counter_increment = 1;
		if (counter_register == 4'b0000) begin
			SL = 1;
		end
		else begin
			SL = 0;
		end
	
          	if (counter_register == 4'b1011) begin  
                	state_next = s13; 
            	end
            	else begin // remain in current state
                	state_next = s12; 
            	end
        end

      s13 : begin //CH12 
		selection_bits = 4'b1100;
		counter_increment = 1;
		if (counter_register == 4'b0000) begin
			SL = 1;
		end
		else begin
			SL = 0;
		end

	
          	if (counter_register == 4'b1011) begin  
                	state_next = s14; 
            	end
            	else begin // remain in current state
                	state_next = s13; 
            	end
        end

      s14 : begin //CH13 
		selection_bits = 4'b1101;
		//SL = 1;
		counter_increment = 1;
		if (counter_register == 4'b0000) begin
			SL = 1;
		end
		else begin
			SL = 0;
		end

	
          	if (counter_register == 4'b1011) begin  
                	state_next = s15; 
            	end
            	else begin // remain in current state
                	state_next = s14; 
            	end
        end

      s15 : begin //CH14 
		selection_bits = 4'b1110;
		//SL = 1;
		counter_increment = 1;
		if (counter_register == 4'b0000) begin
			SL = 1;
		end
		else begin
			SL = 0;
		end
		
          	if (counter_register == 4'b1011) begin  
                	state_next = s16; 
            	end
            	else begin // remain in current state
                	state_next = s15; 
            	end
        end

      s16 : begin //CH15 
		selection_bits = 4'b1111;
		counter_increment = 1;
		if (counter_register == 4'b0000) begin
			SL = 1;
		end
		else begin
			SL = 0;
		end
		
          	if (counter_register == 4'b1011) begin  
                	state_next = s17; 
            	end
            	else begin // remain in current state
                	state_next = s16; 
            	end
        end

      s17 : begin 
		rst = 1;
		counter_increment = 0;
 		SL = 0;
               state_next = s0; 

        end

      default : begin
        state_next = s0;
      end
    endcase
end 
  
endmodule


