export Constant(string filedate,string source) := module
	// autokey
	export ak_keyname := cluster.cluster_out + 'key::InfoUSA::'+source+'::@version@::autokey::';
	export ak_logical := cluster.cluster_out + 'key::INFOUSA::'+source+'::' + filedate + '::autokey::';
	export ak_typeStr := 'BC';
end;
