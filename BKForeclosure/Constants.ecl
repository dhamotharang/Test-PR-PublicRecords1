IMPORT BKForeclosure;
export Constants(string filedate='') := module
	export str_reo_autokeyname := '~thor_data400::key::bkforeclosure_reo::autokey::qa::';
	export ak_reo_keyname	     := '~thor_data400::key::bkforeclosure_reo::autokey::@version@::';
	export ak_reo_logical	     := '~thor_data400::key::bkforeclosure_reo::' + filedate + '::autokey::';
	export ak_reo_dataset      :=  BKForeclosure.File_Reo_Autokey;
	export ak_reo_skipSet      := ['P','Q','F','S'];
	export ak_reo_typeStr      := 'AK';

	export str_nod_autokeyname	:= '~thor_data400::key::bkforeclosure_nod::autokey::qa::';
	export ak_nod_keyname				:= '~thor_data400::key::bkforeclosure_nod::autokey::@version@::';
	export ak_nod_logical				:= '~thor_data400::key::bkforeclosure_nod::' + filedate + '::autokey::';
	export ak_nod_dataset				:=  BKForeclosure.File_NOD_Autokey;
	export ak_nod_skipSet				:= ['P','Q','F','S'];
	export ak_nod_typeStr				:= 'AK';

end;

//P in this set to skip personal phones
//Q in this set to skip business phones
//S in this set to skip SSN
//F in this set to skip FEIN
//C in this set to skip ALL personal (Contact) data
//B in this set to skip ALL Business data