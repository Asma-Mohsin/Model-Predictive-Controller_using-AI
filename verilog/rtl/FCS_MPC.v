`default_nettype none

module FCS_MPC (
`ifdef USE_POWER_PINS
inout vccd1,
inout vssd1,
`endif

  input wire [7:0] iL,
  input wire [7:0] vc,
  input wire [7:0] vg,
  output reg u,
  output wire io_oeb
);

  reg [39:0] temp;  // Adjusted bit width for temp variable

assign io_oeb=1'b0;

`ifdef COCOTB_SIM
     initial begin
         $dumpfile("FCS_MPC.vcd");
         $dumpvars(0, FCS_MPC);
         #1;
         end
 `endif
  function [39:0] abs(input [39:0] x);
    if (x >= 0) begin
      abs = x;
    end else begin
      abs = -x;
    end
  endfunction

  always @(iL or vc or vg) begin
    temp = (40'b000000000000000000000000000000000000 + (40'b0000000111100111010101111010011001 * iL) + (40'b0000000111100001111010110101111110 * vc) - (40'b001010000000000000000000000000000));
    u = (abs(temp + (40'b000000000000000000000000000000000000 + (40'b00000000000000000000000001110000000111 * vg))) <= abs(temp)) ? 1'b1 : 1'b0;
  end

endmodule


