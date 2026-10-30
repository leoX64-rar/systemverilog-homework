//----------------------------------------------------------------------------
// Example
//----------------------------------------------------------------------------

module mux_2_1
(
  input  [3:0] d0, d1,
  input        sel,
  output [3:0] y
);

  assign y = sel ? d1 : d0;

endmodule

//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------
// Task:
// Implement mux_4_1 using three instances of mux_2_1
module mux_4_1
(
  input  [3:0] d0, d1, d2, d3,
  input  [1:0] sel,
  output [3:0] y
);

//  assign y = sel[1] ? (sel[0] ? d3 : d2) : (sel[0] ? d1 : d0);

  logic [3:0] low, high;
  
  mux_2_1 mux_h 
  (
      .d0(d0), 
      .d1(d1), 
      .sel(sel[0]), 
      .y(high)
  );
  mux_2_1 mux_l 
  (  
      .d0(d2), 
      .d1(d3), 
      .sel(sel[0]), 
      .y(low)
  );
  mux_2_1 mux_final 
  (  
      .d0(high), 
      .d1(low), 
      .sel(sel[1]), 
      .y(y)
  );
  
endmodule
