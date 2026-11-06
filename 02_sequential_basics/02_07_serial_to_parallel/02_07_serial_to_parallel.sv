//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module serial_to_parallel
# (
    parameter width = 8
)
(
    input                      clk,
    input                      rst,

    input                      serial_valid,
    input                      serial_data,

    output logic               parallel_valid,
    output logic [width - 1:0] parallel_data
);

  logic [width - 1:0]            shift_reg;  
  logic [$clog2(width + 1) - 1:0] cnt;       

  
  wire [width:0]     ext     = {serial_data, shift_reg};
  wire [width - 1:0] shifted = ext [width:1];

  
  wire last_bit = serial_valid & (cnt == width - 1);

  assign parallel_valid = last_bit;
  assign parallel_data  = shifted;   

  always_ff @ (posedge clk)
    if (rst) begin
      shift_reg <= '0;
      cnt       <= '0;
    end
    else if (serial_valid) begin
      shift_reg <= shifted;
      cnt       <= last_bit ? '0 : cnt + 1'b1;
    end

endmodule

