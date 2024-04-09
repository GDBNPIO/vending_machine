// trial-1
module act_vending (clk,rst,input10,input50,inputa0,selectcan1,selectcan2,selectcan3,can1,can2,can3,chng);
   input clk, rst, input10,input50,inputa0,selectcan1,selectcan2,selectcan3;
   output can1,can2,can3;  // Signals indicating whether a drink can be purchased
   output [4:0] chng; // Change signal

   parameter s0 = 2'b00,
             s1 = 2'b01,
             s2 = 2'b10;

   reg can1,can2,can3;
   reg [4:0] chng;
   reg [1:0] state, next_state;
   reg [4:0] amount; // Amount register

   // Next state logic
   always @(state or input10 or input50 or inputa0 or rst or selectcan1 or selectcan2 or selectcan3)
      begin
        case (state)
            s0: 
              // if(input10 | input50 | inputa0)
                next_state <= s1;
              // else
              //   next_state <= s0;
             
            s1: 
            if(input10 | input50 | inputa0 | rst)
              next_state <= s1;
            else 
              state <= s2;

            s2:
              if(rst)
                next_state <= s0;
              else if((selectcan1 && (amount >= 12)) || (selectcan2 && (amount >= 13)) || (selectcan3 && (amount >= 14)))
                next_state <= s2;
              else
                next_state <= s1;

            default: next_state <= 2'b00;
        endcase

      end

   // Current state logic
   always @(posedge clk or negedge rst)
      begin
          state <= next_state;
      end

   // Output logic
   always @(state or selectcan1 or selectcan2 or selectcan3)
      begin
        case (state)
            s0: begin
                amount <= 0;
            end
            s1: begin
                if(input10)
                begin
                  amount <= amount + 1;
                end
                else if(input50)
                begin
                  amount <= amount + 5;
                end
                else if(inputa0)
                begin
                  amount <= amount + 10;
                end
            end
            s2: begin
                if(rst)begin
                  chng <= amount;
                  end
                else if(selectcan1 && (amount >= 12))
                  begin
                    can1 <= 1;
                    amount = amount - 12;
                    chng = amount;
                  end 
                else if(selectcan2 && (amount >= 13))
                  begin
                    can2 <= 1;
                    amount = amount - 13;
                    chng = amount;
                  end 
                else if(selectcan3 && (amount >= 14))
                  begin
                    can3 <= 1;
                    amount = amount - 14;
                    chng = amount;
                  end 
                else
                begin
                  can1 <= 0;
                  can2 <= 0;
                  can3 <= 0;
                  chng <= 0;
                end

            end
        endcase
      end

endmodule
