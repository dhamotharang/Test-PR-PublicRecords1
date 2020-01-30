IMPORT ut, SICCodes;

EXPORT integer fn_valid_SicCode(string code
) := function

  // pSicLookup := DATASET('~thor_data400::base::siccodes::qa::lookup',SICCodes.Layouts.SICLookup,THOR);

//validates codes against DNB_DMI Sic Code Table
//valid lengths are 4,6, and 8
//sets zero codes to null
//null is valid	
	// string trim_code :=
					// MAP(
					// TRIM(code)         = '0'                                                     => '',
					// LENGTH(TRIM(code)) = 4 AND Stringlib.StringFilterOut(code, '0123456789') = ''=> TRIM(code) +'0000',
					// LENGTH(TRIM(code)) = 6 AND Stringlib.StringFilterOut(code, '0123456789') = ''=> TRIM(code) +'00',
					// TRIM(code));
	// setSics := if(trim_code != '' AND LENGTH(trim_code) = 8 AND Stringlib.StringFilterOut(trim_code, '0123456789') = '',set(pSicLookup, sic_code),[]);
	// boolean isValidSicCode := if(trim_code != '' AND LENGTH(trim_code) = 8 AND Stringlib.StringFilterOut(trim_code, '0123456789') = '',trim_code IN setSics,FALSE);
	// RETURN if(isValidSicCode OR trim_code = '',1,0);
	return ut.fn_valid_SicCode(code);

END;