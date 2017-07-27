IMPORT ut, Data_Services;

EXPORT Autokey_constants(string filedate='dummy') := MODULE

	export Autokey_indiv_constants := module

		export str_autokeyname := Data_Services.Data_location.Prefix('Provider')+'thor_data400::key::enclarity::individual::autokey::';
		export ak_keyname			:= Data_Services.Data_location.Prefix('Provider')+'thor_data400::key::enclarity::individual::autokey::@version@::';
		export ak_logical			:= Data_Services.Data_location.Prefix('Provider')+'thor_data400::key::enclarity::individual::'+filedate+'::autokey::';
		export ak_skipSet			:= ['P','Q','F','B'];
		export ak_typeStr			:= 'PROV';

	end;
	
	export Autokey_sanc_constants := module

		export str_autokeyname := Data_Services.Data_location.Prefix('Provider')+'thor_data400::key::enclarity::sanction::autokey::';
		export ak_keyname			:= Data_Services.Data_location.Prefix('Provider')+'thor_data400::key::enclarity::sanction::autokey::@version@::';
		export ak_logical			:= Data_Services.Data_location.Prefix('Provider')+'thor_data400::key::enclarity::sanction::'+filedate+'::autokey::';
		export ak_skipSet			:= ['P','Q','F','B'];
		export ak_typeStr			:= 'SANC';

	end;

end;
