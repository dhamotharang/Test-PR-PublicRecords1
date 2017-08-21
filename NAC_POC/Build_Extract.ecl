import Nac, did_add;

matchset := ['A','Z','D','S'];

EXPORT Build_Extract(string month) := FUNCTION		// month=CCYYMM

	dsNac := Nac.Files().Base(case_benefit_month=month);
	
	dsInterim := MapNacToInterim(dsNac);			// build intermediate file

	dsCleanAddresses := fn_CleanAddress(dsInterim);
	
	// link records
	did_add.MAC_Match_Flex
		(dsCleanAddresses , matchset,
			clean_ssn,clean_dob, fname, mname, lname, name_suffix,
			prim_range, prim_name, sec_range, zip, st,'',
			LexId, Layout_Interim, true, Lexid_score,
			0, ds_LexId);
			
	dsExtract := MapInterimToExtract(ds_Lexid);
	
	return dsExtract;
	
END;