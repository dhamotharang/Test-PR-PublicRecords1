export fedex_autokey_constants := module
	export str_autokeyname := '~thor_data400::key::fedex::autokey::@version@::';
	export str_autokeyname2 := '~thor_data400::key::fedex2::autokey::@version@::';
	export str_AutokeyLogicalName(string version_date) := '~thor_data400::key::fedex::' + version_date + '::autokey::';
	export str_AutokeyLogicalName2(string version_date) := '~thor_data400::key::fedex2::' + version_date + '::autokey::';
	export autokey_qa_Keyname := '~thor_data400::key::fedex::autokey::qa::';
	export autokey_qa_Keyname2 := '~thor_data400::key::fedex2::autokey::qa::';
	export autokey_dataset	:= fedex.file_fedex_autokey;
	export autokey_dataset2	:= fedex.file_fedex_autokey2;
	export autokey_typeStr	:= 'BC';
	export autokey_skip_set	:= ['B','-','S'];
end;
