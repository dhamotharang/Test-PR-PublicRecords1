export Constant(string filedate) := module
	// autokey
	export ak_keyname := cluster.cluster_out + 'key::PAW::@version@::autokey::';
	export ak_QAname  := cluster.cluster_out + 'key::PAW::qa::autokey::';
	export ak_logical := cluster.cluster_out + 'key::PAW::' + filedate + '::autokey::';
	export ak_typeStr := 'PAW';

  // boolean search
	export string stem    := '~thor_data400::base';
	export string srcType := 'PAW';
	export string qual    := 'test';

end;
