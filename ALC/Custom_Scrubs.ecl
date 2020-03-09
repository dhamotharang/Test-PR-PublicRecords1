IMPORT ALC;

EXPORT Custom_Scrubs := MODULE

  // Want to make sure the vendor doesn't send us a bad license number for a nurse in TX.  Those
	//   license numbers will start with AP and are supposed to have 6 numbers afterwards.  A 1
	//   signifies an error.
  EXPORT fn_valid_tx_nurse_license_no(STRING license_no, STRING reg_state) := FUNCTION
	  is_in_tx         := IF( (TRIM(reg_state) = 'TX#'), TRUE , FALSE);
		starts_with_ap   := license_no[1..2] = 'AP';
		is_proper_length := LENGTH(TRIM(license_no)) = 8;

    RETURN MAP(NOT(is_in_tx) OR NOT(starts_with_ap)             => 0,
		           is_in_tx AND starts_with_ap AND is_proper_length => 0,
							 1);
	END;

  // Want to make sure the vendor doesn't truncate license number for a professional in MT.  Those
	//   license numbers will have a specific pattern and only be 15 characters long.  A 1 signifies
	//   an error.
  EXPORT fn_valid_mt_prof_license_no(STRING license_no, STRING state) := FUNCTION
	  is_in_mt         := TRIM(state) = 'MT';
		has_pattern      := license_no[1..12] = 'SWP-LCPC-LIC';
		is_proper_length := LENGTH(TRIM(license_no)) > 15;

    RETURN MAP(NOT(is_in_mt) OR NOT(has_pattern)             => 0,
		           is_in_mt AND has_pattern AND is_proper_length => 0,
							 1);
	END;

  // Want to make sure the vendor doesn't truncate license number for an accountant in MT.  Those
	//   license numbers will have a specific pattern and only be 15 characters long.  A 1 signifies
	//   an error.
  EXPORT fn_valid_mt_acct_license_no(STRING license_no, STRING state) := FUNCTION
	  is_in_mt         := TRIM(state) = 'MT';
		has_pattern      := license_no[1..12] = 'PAC-CPAP-LIC';
		is_proper_length := LENGTH(TRIM(license_no)) > 15;

    RETURN MAP(NOT(is_in_mt) OR NOT(has_pattern)             => 0,
		           is_in_mt AND has_pattern AND is_proper_length => 0,
							 1);
	END;

END;
