module mux_16to1(input wire [11:0] data0, data1, data2, data3, data4, data5, data6, data7, data8, data9, data10, data11, data12, data13, data14, data15,
                input wire [3:0] select,
           output reg [11:0] data_out
          );


  always @(*) begin
    casez (select)  
      4'b0000 : data_out = data0; 
      4'b0001 : data_out = data1; 
      4'b0010 : data_out = data2;
      4'b0011 : data_out = data3;
      4'b0100 : data_out = data4;
      4'b0101 : data_out = data5;
      4'b0110 : data_out = data6;
      4'b0111 : data_out = data7;
      4'b1000 : data_out = data8;
      4'b1001 : data_out = data9;
      4'b1010 : data_out = data10;
      4'b1011 : data_out = data11;
      4'b1100 : data_out = data12;
      4'b1101 : data_out = data13;
      4'b1110 : data_out = data14;
      4'b1111 : data_out = data15;
      default :  data_out = 12'b0;
     endcase  
   end  
  
endmodule
