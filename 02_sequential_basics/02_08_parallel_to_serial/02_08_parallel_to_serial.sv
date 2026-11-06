//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module parallel_to_serial
# (
    parameter width = 8
)
(
    input                      clk,
    input                      rst,

    input                      parallel_valid,
    input        [width - 1:0] parallel_data,

    output                     busy,
    output logic               serial_valid,
    output logic               serial_data
);

    logic [width - 1:0]             data_r;  
    logic [$clog2(width + 1) - 1:0] cnt;     

    
    assign busy = (cnt != 0);

   
    always_comb begin
        if (busy) begin
            serial_valid = '1;
            serial_data  = data_r [0];
        end
        else if (parallel_valid) begin
            serial_valid = '1;
            serial_data  = parallel_data [0];  
        end
        else begin
            serial_valid = '0;
            serial_data  = '0;
        end
    end

   
    always_ff @ (posedge clk)
        if (rst) begin
            data_r <= '0;
            cnt    <= '0;
        end
        else if (busy) begin
            data_r <= data_r >> 1;
            cnt    <= cnt - 1'b1;
        end
        else if (parallel_valid) begin
            data_r <= parallel_data >> 1; 
            cnt    <= width - 1;
        end

endmodule