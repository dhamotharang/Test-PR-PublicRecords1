IMPORT Risk_Indicators;

EXPORT integer fn_valid_SicCode(string code) := function
  
	pSicLookup := Risk_Indicators.Files().SicLookup.built;
	
//validates codes against DNB_DMI Sic Code Table
//valid lengths are 4,6, and 8
//sets zero codes to null
//null is valid	
	string trim_code :=
					MAP(
					TRIM(code, LEFT, RIGHT)         = '0'                                                     => '',
					LENGTH(TRIM(code, LEFT, RIGHT)) = 4 AND Stringlib.StringFilterOut(code, '0123456789') = ''=> TRIM(code, LEFT, RIGHT) +'0000',
					LENGTH(TRIM(code, LEFT, RIGHT)) = 6 AND Stringlib.StringFilterOut(code, '0123456789') = ''=> TRIM(code, LEFT, RIGHT) +'00',
					TRIM(code, LEFT, RIGHT));
	setSics := if(trim_code != '' AND LENGTH(trim_code) = 8 AND Stringlib.StringFilterOut(trim_code, '0123456789') = '',set(pSicLookup, sic_code),[]);
	boolean isValidSicCode := if(trim_code != '' AND LENGTH(trim_code) = 8 AND Stringlib.StringFilterOut(trim_code, '0123456789') = '',trim_code IN setSics,FALSE);
	RETURN if(isValidSicCode OR trim_code = '',1,0);

END;