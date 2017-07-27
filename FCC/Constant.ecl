export Constant(string filedate) := module
	// autokey
	export ak_keyname := '~thor_data400::key::fcc::@version@::autokey::';
	export ak_QAname := '~thor_data400::key::fcc::qa::autokey::';
	export ak_logical := '~thor_data400::key::fcc::' + filedate + '::autokey::';
	export ak_skip_set := ['S','F'];
	export ak_typeStr := 'AK';
end;