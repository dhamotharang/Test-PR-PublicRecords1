IMPORT ut, Data_Services;

EXPORT Autokey_constants(string filedate='dummy') := MODULE

	export Autokey_stlic_constants := module

		export str_autokeyname := Data_Services.Data_location.Prefix('StateLicense')+'thor400_data::key::hms_stl::hms_statelicense::autokey::';
		export ak_keyname			:= Data_Services.Data_location.Prefix('StateLicense')+'thor_data400::key::hms_stl::hms_statelicense::autokey::@version@::';
		export ak_logical			:= Data_Services.Data_location.Prefix('StateLicense')+'thor_data400::key::hms_stl::hms_statelicense::'+filedate+'::autokey::';
		export ak_skipSet			:= ['P','Q','F','B'];
		export ak_typeStr			:= 'STLIC';

	end;
	
end;