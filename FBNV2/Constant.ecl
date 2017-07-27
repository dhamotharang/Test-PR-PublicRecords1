export Constant(string filedate) := module
	// autokey
	export ak_keyname := cluster.cluster_out + 'key::FbnV2::@version@::autokey::';
	export ak_QAname := cluster.cluster_out + 'key::FbnV2::qa::autokey::';
	export ak_logical := cluster.cluster_out + 'key::FbnV2::' + filedate + '::autokey::';
	export ak_typeStr := 'BC';

  // boolean search
	export string stem    := '~thor_data400::base';
	export string srcType := 'fbn';
	export string qual    := 'test';

end;
