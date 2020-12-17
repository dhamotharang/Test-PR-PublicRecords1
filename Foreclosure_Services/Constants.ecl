IMPORT dx_property;
export Constants(string filedate='') := module
	export str_autokeyname := '~thor_data400::key::foreclosure::autokey::qa::';
	export ak_keyname	:= '~thor_data400::key::foreclosure::autokey::@version@::';
	export ak_logical	:= '~thor_data400::key::foreclosure::' + filedate + '::autokey::';
	export ak_dataset	:=  dataset([],dx_property.Layouts.i_autokey);
	export ak_skipSet	:= ['P','Q','F'];
	export ak_typeStr	:= 'AK';

	export str_nod_autokeyname	:= '~thor_data400::key::nod::autokey::qa::';
	export ak_nod_keyname				:= '~thor_data400::key::nod::autokey::@version@::';
	export ak_nod_logical				:= '~thor_data400::key::nod::' + filedate + '::autokey::';
	export ak_nod_dataset				:=  dataset([],dx_property.Layouts.i_autokey);
	export ak_nod_skipSet				:= ['P','Q','F'];
	export ak_nod_typeStr				:= 'AK';
	
	export src_Fares := 'A';
	export src_BlackKnight := 'B';
end;

//P in this set to skip personal phones
//Q in this set to skip business phones
//S in this set to skip SSN
//F in this set to skip FEIN
//C in this set to skip ALL personal (Contact) data
//B in this set to skip ALL Business data
