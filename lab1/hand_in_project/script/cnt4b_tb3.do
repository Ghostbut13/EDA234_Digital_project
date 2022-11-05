restart -f -nowave
view signals wave
add wave rstn_tb3_signal clk_tb3_signal 
add wave ce_tb3_signal 
add wave count_H_tb3_signal count_L_tb3_signal
add wave ec_tb3_signal
run 100000ns