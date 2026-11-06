//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module round_robin_arbiter_with_2_requests
(
    input        clk,
    input        rst,
    input  logic [1:0] requests,
    output logic [1:0] grants
);

logic prior;

always_comb  begin
    if(requests == 2'b11)
        grants = prior ? 2'b10 : 2'b01;
    else
        grants = requests;
end

always_ff @(posedge clk)
    if (rst)
        prior <= '0;
    else if (grants[0]) 
        prior <= '1;
    else
        prior <= '0;

endmodule
