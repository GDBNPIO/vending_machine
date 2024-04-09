// Test pattern trial-1
`timescale 1ns / 10ps
module t_act_vending;
  reg clk, rst, input10, input50, inputa0, selectcan1, selectcan2, selectcan3;
  wire can1,can2,can3;
  wire [4:0] chng;


  // Clock
  initial clk = 0;
  always
    #5 clk = ~clk;

  initial
    begin
      $dumpfile("act_vending.vcd");
      $dumpvars(0,t_act_vending);
      $monitor("%t input10=%b, input50=%b, inputa0=%b,selectcan1=%b,selectcan2=%b,selectcan3=%b, state = %b", 
               $time, input10, input50,inputa0,selectcan1,selectcan2,selectcan3,act_vending1.state);
      
      rst <= 0; input10 <=0; input50 <=0; inputa0 <=0; selectcan1 <=0; selectcan2<=0; selectcan3<=0;
      
      #10 

      #10 inputa0 = 1;
      #10 inputa0 = 0;
      #20 inputa0 = 1; 
      #10 inputa0 = 0;
      #20 input50 = 0; 
      #10 input50 = 0;
      #40 selectcan2 = 1; 
      #40 selectcan2 = 0;

      #100
      $finish;
    end

   act_vending act_vending1(clk,rst,input10,input50,inputa0,selectcan1,selectcan2,selectcan3,can1,can2,can3,chng);
endmodule