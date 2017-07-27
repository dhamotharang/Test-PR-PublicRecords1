import ut;

export lookup_setter(integer i, string10 s) := ut.bit_set(0,IF(i>0,lookup_bit(s),0));