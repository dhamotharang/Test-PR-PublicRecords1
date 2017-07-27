export Constant := module
	
	export str_autokeyname := cluster.cluster_out + 'key::mfind::autokey::';
	export str_AutokeyLogicalName(string filedate) := cluster.cluster_out + 'key::mfind::' +filedate+ '::autokey::';
	export autokey_typeStr := 'BC';

end;