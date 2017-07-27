IMPORT ut, Data_Services;

EXPORT Autokey_constants(string filedate='dummy') := MODULE

	export Autokey_koptrgtharv_constants := module

		export str_autokeyname := Data_Services.Data_location.Prefix('StateLicense')+'thor400_data::key::' + _Dataset().name + '::autokey::';
		export ak_keyname			:= Data_Services.Data_location.Prefix('StateLicense')+'thor_data400::key::' + _Dataset().name + '::autokey::@version@::';
		export ak_logical			:= Data_Services.Data_location.Prefix('StateLicense')+'thor_data400::key::' + _Dataset().name + '::'+filedate+'::autokey::';
		export ak_skipSet			:= ['P','Q','F','B'];
		export ak_typeStr			:= 'STLICAUDIT';

	end;
	
end;