export HuntFish_Autokey_Constants (string filedate) := module
	export ak_keyname     			:= cluster.cluster_out + 'key::hunting_fishing::@version@::autokey::';
	export ak_logicalname 			:= cluster.cluster_out + 'key::hunting_fishing::' + filedate + '::autokey::';
	export ak_QAname      			:= cluster.cluster_out + 'key::hunting_fishing::qa::autokey::';
	export ak_typeStr     			:= 'BC';
	
	export ak_keyname_fcra 			:= cluster.cluster_out + 'key::hunting_fishing::fcra::@version@::autokey::';
	export ak_logicalname_fcra 	:= cluster.cluster_out + 'key::hunting_fishing::fcra::' + filedate + '::autokey::';
	export ak_QAname_fcra				:= cluster.cluster_out + 'key::hunting_fishing::fcra::qa::autokey::';	
	
	// skip P=Personal phone, B=Business data
	export ak_skip_set := ['P','B'];

	export string stem    := '~thor_data400::base';
	export string srcType := 'hunting_fishing';
	export string qual    := 'test';
	
end;
