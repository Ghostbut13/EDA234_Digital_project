restart -f -nowave
view signals wave
add wave reset_n_tb_signal clk_tb_signal count_tb_signal ce_tb_signal ec_tb_signal
run 2550ns