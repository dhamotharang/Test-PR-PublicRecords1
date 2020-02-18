IMPORT NAICSCodes;

EXPORT integer fn_valid_NAICSCode(string code) := function

  pNAICSLookup := NAICSCodes.Files().NAICSLookup.qa;

//validates codes against NAICS Code Table
//valid lengths are 3 4,5, and 6
//sets zero codes to null
//null is valid	
	string trim_code :=
					MAP(		
					TRIM(code, LEFT, RIGHT) = '0'                                                             => '',
					LENGTH(TRIM(code, LEFT, RIGHT)) = 3 AND Stringlib.StringFilterOut(code, '0123456789') = ''=> TRIM(code, LEFT, RIGHT),
					LENGTH(TRIM(code, LEFT, RIGHT)) = 4 AND Stringlib.StringFilterOut(code, '0123456789') = ''=> TRIM(code, LEFT, RIGHT),
					LENGTH(TRIM(code, LEFT, RIGHT)) = 5 AND Stringlib.StringFilterOut(code, '0123456789') = ''=> TRIM(code, LEFT, RIGHT),
					LENGTH(TRIM(code, LEFT, RIGHT)) = 6 AND Stringlib.StringFilterOut(code, '0123456789') = ''=> TRIM(code, LEFT, RIGHT),
					TRIM(code, LEFT, RIGHT));
	setNAICS := if(trim_code != '' AND LENGTH(trim_code) >= 3 AND LENGTH(trim_code) <= 6 AND Stringlib.StringFilterOut(trim_code, '0123456789') = '',set(pNAICSLookup, naics_code),[]);
	boolean isValidNAICS := if(trim_code != '' AND LENGTH(trim_code) >= 3 AND LENGTH(trim_code) <= 6 AND Stringlib.StringFilterOut(trim_code, '0123456789') = '',trim_code IN setNAICS,FALSE);
	RETURN if(isValidNAICS OR trim_code = '',1,0);

END;
