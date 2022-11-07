restart -f -nowave
view signals wave
--add wave CA_signal CB_signal CC_signal CD_signal CE_signal CF_signal CG_signal
add wave rstn_signal clk_signal top_1/clk_1s AN_signal
add wave top_1/digital_show_1/cnt_H top_1/digital_show_1/cnt_L top_1/digital_show_1/sel
add wave top_1/digital_show_1/digital top_1/digital_show_1/AN_TURN_ON
add wave top_1/count_1s
add wave top_1/clk_sw

run 1000000 ns

