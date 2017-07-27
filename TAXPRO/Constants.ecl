export Constants(string filedate) := module
	// autokey
	export ak_keyname := cluster.cluster_out + 'key::Taxpro::@version@::autokey::';
	export ak_QAname := cluster.cluster_out + 'key::Taxpro::qa::autokey::';
	export ak_logical := cluster.cluster_out + 'key::Taxpro::' + filedate + '::autokey::';
	export ak_skip_set := ['P','Q','F'];
	export ak_typeStr := 'AK';
end;
