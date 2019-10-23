export Fn_SwitchSpec(real swt,unsigned num) := IF( num < 2, 0, -LOG(POWER(swt,num-1))/LOG(2));
