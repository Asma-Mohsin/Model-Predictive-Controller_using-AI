module user_project_wrapper (user_clock2,
    vccd1,
    vccd2,
    vdda1,
    vdda2,
    vssa1,
    vssa2,
    vssd1,
    vssd2,
    wb_clk_i,
    wb_rst_i,
    wbs_ack_o,
    wbs_cyc_i,
    wbs_stb_i,
    wbs_we_i,
    analog_io,
    io_in,
    io_oeb,
    io_out,
    la_data_in,
    la_data_out,
    la_oenb,
    user_irq,
    wbs_adr_i,
    wbs_dat_i,
    wbs_dat_o,
    wbs_sel_i);
 input user_clock2;
 input vccd1;
 input vccd2;
 input vdda1;
 input vdda2;
 input vssa1;
 input vssa2;
 input vssd1;
 input vssd2;
 input wb_clk_i;
 input wb_rst_i;
 output wbs_ack_o;
 input wbs_cyc_i;
 input wbs_stb_i;
 input wbs_we_i;
 inout [28:0] analog_io;
 input [37:0] io_in;
 output [37:0] io_oeb;
 output [37:0] io_out;
 input [127:0] la_data_in;
 output [127:0] la_data_out;
 input [127:0] la_oenb;
 output [2:0] user_irq;
 input [31:0] wbs_adr_i;
 input [31:0] wbs_dat_i;
 output [31:0] wbs_dat_o;
 input [3:0] wbs_sel_i;


 FCS_MPC FCS_MPC (.io_oeb(io_oeb[8]),
    .u(io_out[8]),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .iL({io_in[16],
    io_in[15],
    io_in[14],
    io_in[13],
    io_in[12],
    io_in[11],
    io_in[10],
    io_in[9]}),
    .vc({io_in[7],
    io_in[6],
    io_in[5],
    io_in[4],
    io_in[3],
    io_in[2],
    io_in[1],
    io_in[0]}),
    .vg({io_in[24],
    io_in[23],
    io_in[22],
    io_in[21],
    io_in[20],
    io_in[19],
    io_in[18],
    io_in[17]}));
endmodule
