IMPORT data_services;

EXPORT key_OptOutSrc(boolean isFCRA = false) :=  FUNCTION

	//CCPA-120
	rec := Suppress.Layout_CCPA_Opt_Out;
	key := INDEX({rec.lexid}, rec, data_services.Data_location.Prefix()+'thor_data400::key::new_suppression::qa::ccpa_opt_out');
	RETURN key;
	
END;	
