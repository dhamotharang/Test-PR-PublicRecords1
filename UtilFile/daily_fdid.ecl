import data_services;
utilfile.Layout_DID_Out t(utilfile.Layout_DID_Out le, unsigned6 i) :=
TRANSFORM
	SELF.fdid := i;
	SELF := le;
	
END;
p := PROJECT(UtilFile.file_util_daily, t(LEFT, COUNTER));

//clean up phone 
utilfile.Mac_clean_phone(p, p_cleanphone)
//cleanup driver license
UtilFile.mac_cleandates(p_cleanphone,p_clean_out)
utilfile.mac_convert_util_type(p_clean_out, p_out)

export daily_fdid := p_out : persist('~thor_data400::persist::utility_daily_fdid');