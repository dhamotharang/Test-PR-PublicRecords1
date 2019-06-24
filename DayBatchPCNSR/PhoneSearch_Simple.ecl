import $, doxie;

export PhoneSearch_Simple( GROUPED DATASET($.Layout_PCNSR_Linked) indata_grouped,
                          doxie.IDataAccess mod_access) := FUNCTION

	regrp := GROUP(UNGROUP(indata_grouped),indata.acctno);													
	//EXACT MATCHES
	match137Z := $.PhoneSearch_137Z_Exact(regrp, mod_access);
	
	match13Z := $.PhoneSearch_13Z_Exact(match137Z, mod_access);
	
	matchZ3L := $.PhoneSearch_Z3L_Exact(match13Z, mod_access);
      
	RETURN matchZ3L;

END;