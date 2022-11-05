restart -f -nowave
add wave clk reset CE Cnt EC


force clk 0 0, 1 50ns -repeat 100ns
force CE 1
force reset 0 0, 1 120ns
run 1000ns
force CE 0
force reset 0 0, 1 120ns
run 200ns
force CE 1
run 1000ns