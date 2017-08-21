EXPORT layout_ALS0635 := MODULE 

EXPORT Mortgage_License := 	RECORD, MAXLENGTH(3000)
		STRING  license_nbr;
		STRING  license_type;
		STRING  name_full;
		STRING  addr_addr1;
		STRING  addr_city;
		STRING  addr_st;
		STRING  addr_zip;
		STRING  curr_iss_dte;   //fmt MM/DD/YY
	END;
	
	
	
EXPORT Mortgage_License_src	:= RECORD
	Mortgage_License;
	STRING8		LN_FILEDATE 			// internal
END;	

END;