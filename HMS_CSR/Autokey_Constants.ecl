IMPORT ut, Data_Services;

EXPORT Autokey_constants(string filedate='dummy') := MODULE

	export Autokey_csr_constants := module

		export str_autokeyname := Data_Services.Data_location.Prefix('CsrCredential')+'thor400_data::key::hms_csr::hms_csrcredential::autokey::';
		export ak_keyname			:= Data_Services.Data_location.Prefix('CsrCredential')+'thor_data400::key::hms_csr::hms_csrcredential::autokey::@version@::';
		export ak_logical			:= Data_Services.Data_location.Prefix('CsrCredential')+'thor_data400::key::hms_csr::hms_csrcredential::'+filedate+'::autokey::';
		export ak_skipSet			:= ['P','Q','F','B'];
		export ak_typeStr			:= 'CSR';

	end;
	
end;