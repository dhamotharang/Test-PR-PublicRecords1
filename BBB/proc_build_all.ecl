build_base := bbb.Make_BBB_Base :  success(output('BBB base file completed'));
build_key  := bbb.proc_build_BBB_keys : success(output('BBB keys completed'));


export proc_build_all := sequential(build_base, build_key);