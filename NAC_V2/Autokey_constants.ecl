IMPORT ut, Data_Services;
export Autokey_constants(string filedate='dummy') := module

	shared Prefix := '~';	// Data_Services.Data_location.Prefix('DEFAULT')

	export str_autokeyname := Prefix+'thor::NAC2::key::autokey::';
	export ak_keyname	:= Prefix+'thor::NAC2::key::autokey::@version@::';
	export ak_logical	:= Prefix+'thor::NAC2::key::'+filedate+'::autokey::';
	export ak_dataset	:= nac_v2.Files.PayloadBadAddressRemoved;
	export ak_skipSet	:= ['P','Q','F','B'];
	export ak_typeStr	:= 'AK';

end;
