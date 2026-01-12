quit -sim

vlib work

vcom ../encodeur.vhd
vcom encodeur_tb.vhd

vsim -c work.encodeur_tb

# INPUTS
add wave -divider Inputs:
add wave -color yellow uut/i_clk
add wave -color yellow uut/i_rst_n
add wave -color yellow uut/i_ch_a
add wave -color yellow uut/i_ch_b
add wave -color yellow uut/i_pb


# OUTPUTS
add wave -divider Outputs:
add wave uut/o_compteur

run -all