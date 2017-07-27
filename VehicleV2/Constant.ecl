export Constant := module

	export str_autokeyname := cluster.cluster_out + 'key::vehiclev2::autokey::';
	export str_AutokeyLogicalName(string filedate) := cluster.cluster_out + 'key::vehiclev2::' +filedate+ '::autokey::';
	export str_linkid_keyname  :=  cluster.cluster_out + 'key::vehiclev2::'+ 'linkids_';
	export autokey_typeStr := 'BC';
	export autokey_skip_set := ['P','Q'];
end;
