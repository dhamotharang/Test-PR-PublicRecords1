export Constants(string filedate='') := module

	shared root := '~thor_data400::key::internetservices::';
	
	export str_autokeyname								:= root + 'autokey::';
	export ak_keyname											:= root + '@version@::autokey::'; //used to build autokeys
	export ak_logicalname               	:= root + filedate + '::autokey::';
	export ak_QAname                      := root + 'qa::autokey::';
	export ak_skipSet											:= ['P','Q','F','S'];
	export ak_typeStr											:= 'BC';
	
end;