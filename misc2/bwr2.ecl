vdate:= '20090612';
ignore_compare :=true;	

// if file exists with vdate and is in superfile skip the whole job

sequential(misc2.fn_do_both(vdate,ignore_compare), misc2.fn_build_roxie_key(vdate));



