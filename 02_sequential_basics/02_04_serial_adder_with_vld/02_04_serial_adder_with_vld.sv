//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module serial_adder_with_vld
(
  input  clk,
  input  rst,
  input  vld,
  input  a,
  input  b,
  input  last,
  output sum
);

  logic carry;  

  assign sum = a ^ b ^ carry;

  wire carry_next = (a & b) | (a & carry) | (b & carry);

  always_ff @ (posedge clk)
    if (rst)
      carry <= '0;
    else if (vld) begin
      if (last)
        carry <= '0;        
      else
        carry <= carry_next;  
    end

endmodule
