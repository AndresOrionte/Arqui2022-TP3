set_property -dict { PACKAGE_PIN W5   IOSTANDARD LVCMOS33 } [get_ports i_clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports i_clk]

set_property -dict {PACKAGE_PIN U18   IOSTANDARD LVCMOS33} [get_ports i_reset]
set_property -dict {PACKAGE_PIN B18   IOSTANDARD LVCMOS33} [get_ports i_rx]
set_property -dict {PACKAGE_PIN A18   IOSTANDARD LVCMOS33} [get_ports o_tx]

set_property CFGBVS VCCO [current_design]

set_property CONFIG_VOLTAGE 3.3 [current_design]