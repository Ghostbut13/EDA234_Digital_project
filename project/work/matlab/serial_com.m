clear;
clc;
close;


sp_list = serialportlist
sp = serialport(sp_list,9600)
str = "hello world"
write(sp,str,'STRING')
