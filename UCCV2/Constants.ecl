export Constants(string filedate) := module
	// autokey
	export ak_keyname 		:= cluster.cluster_out + 'key::ucc::autokey::';
	EXPORT ak_keynamebid	:= cluster.cluster_out + 'key::ucc::autokey::BID::';
	
	export ak_logical 		:= cluster.cluster_out + 'key::ucc::' + filedate + '::autokey::';
	export ak_typeStr 		:= 'BC';

  // boolean search
	export STRING stem		        := '~thor_data400::base';
	export STRING srcType 			  := 'uccv2';
	export STRING qual					  := 'test';
	export STRING dateSegName			:= 'process-date';
	export UNSIGNED2 alertSWDays	:= 31;

end;
