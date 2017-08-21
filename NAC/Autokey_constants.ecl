IMPORT ut, Data_Services;
export Autokey_constants(string filedate='dummy') := module

	export str_autokeyname := Data_Services.Data_location.Prefix('DEFAULT')+'thor::NAC::key::autokey::';
	export ak_keyname	:= Data_Services.Data_location.Prefix('DEFAULT')+'thor::NAC::key::autokey::@version@::';
	export ak_logical	:= Data_Services.Data_location.Prefix('DEFAULT')+'thor::NAC::key::'+filedate+'::autokey::';
	export ak_dataset	:=  NAC.Files().BaseBadAddressRemoved2;
	export ak_skipSet	:= ['P','Q','F','B'];
	export ak_typeStr	:= 'AK';

end;
