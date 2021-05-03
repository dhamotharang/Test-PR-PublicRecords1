IMPORT NAICSCodes, ut;

EXPORT fn_NAICS_functions := module

EXPORT integer fn_validate_NAICSCode(string code) := function
  
	pNAICSLookup := NAICSCodes.Files().NAICSLookup.qa;

//validates codes against NAICS Code Table
//valid lengths are 2,3 4,5, and 6
//sets zero codes to null
//null is valid	
  string trim_code := TRIM(code, LEFT, RIGHT);
	string filtered_code := Stringlib.StringFilterOut(trim_code, '0123456789');
	integer length_of_code := LENGTH(trim_code);
	string temp_code :=
					MAP(		
					trim_code = '0'                             => '',
					length_of_code = 2 AND filtered_code = ''=> trim_code,
					length_of_code = 3 AND filtered_code = ''=> trim_code,
					length_of_code = 4 AND filtered_code = ''=> trim_code,
					length_of_code = 5 AND filtered_code = ''=> trim_code,
					length_of_code = 6 AND filtered_code = ''=> trim_code,
					trim_code);
	setNAICS := if(temp_code != '' AND length_of_code >= 2 AND length_of_code <= 6 AND filtered_code = '',set(pNAICSLookup, naics_code),[]);
	RETURN if(temp_code in setNAICS OR temp_code = '',1,0);
END;

EXPORT dataset fn_validate_NAICSCode_Dataset(dataset(NAICSCodes.Layouts.naicsLookup) naicsDS) := function
  
	pNAICSLookup := NAICSCodes.Files().NAICSLookup.qa;
						
	NAICSCodes.Layouts.naicsLookup codeXrf(NAICSCodes.Layouts.naicsLookup	L) := transform
	  string trim_code := TRIM(L.naics_code, LEFT, RIGHT);
	  string filtered_code := Stringlib.StringFilterOut(trim_code, '0123456789');
	  integer length_of_code := LENGTH(trim_code);
	  string temp_code :=
					MAP(		
					trim_code = '0'                             => '',
					length_of_code = 2 AND filtered_code = ''=> trim_code,
					length_of_code = 3 AND filtered_code = ''=> trim_code,
					length_of_code = 4 AND filtered_code = ''=> trim_code,
					length_of_code = 5 AND filtered_code = ''=> trim_code,
					length_of_code = 6 AND filtered_code = ''=> trim_code,
					trim_code);
	  setNAICS := set(pNAICSLookup, naics_code);
		SELF.naics_description := if(temp_code in setNAICS AND (length_of_code >= 2 AND length_of_code <= 6), L.naics_description, '');
		SELF.naics_code := L.naics_code;
	END;
	
	finalNAICSds := PROJECT(naicsDS, codeXrf(LEFT));
						
  RETURN finalNAICSds;	
	
END;

END;
