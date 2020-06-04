IMPORT SICCodes;

EXPORT fn_SIC_functions := MODULE

EXPORT integer fn_validate_SicCode(string code) := function

  pSicLookup := SICCodes.Files().SICLookup.qa;
	
//validates codes against DNB_DMI Sic Code Table
//valid lengths are 4,6, and 8
//sets zero codes to null
//null is valid	
  string trim_code := TRIM(code, LEFT, RIGHT);
	string filtered_code := Stringlib.StringFilterOut(trim_code, '0123456789');
	integer length_of_code := LENGTH(trim_code);
	string temp_code :=
					MAP(
					trim_code         = '0'                  => '',
					length_of_code = 4 AND filtered_code = ''=> trim_code +'0000',
					length_of_code = 6 AND filtered_code = ''=> trim_code +'00',
					trim_code);	
	setSics := if(temp_code != '' AND LENGTH(temp_code) = 8 AND filtered_code = '',set(pSicLookup, sic_code),[]);
	RETURN if(temp_code in setSics OR temp_code = '',1,0);	
END;

EXPORT dataset fn_validate_SICCode_Dataset(dataset(SICCodes.Layouts.SICLookup) SicDS) := function
  
	pSICLookup := SICCodes.Files().SICLookup.qa;
						
	SICCodes.Layouts.SICLookup codeXrf(SICCodes.Layouts.SICLookup	L) := transform
	  string trim_code := TRIM(L.sic_code, LEFT, RIGHT);
	  string filtered_code := Stringlib.StringFilterOut(trim_code, '0123456789');
	  integer length_of_code := LENGTH(trim_code);
	  string temp_code :=
					MAP(
					trim_code         = '0'                  => '',
					length_of_code = 4 AND filtered_code = ''=> trim_code +'0000',
					length_of_code = 6 AND filtered_code = ''=> trim_code +'00',
					trim_code);
	  setSIC := SET(pSicLookup,sic_code);
		SELF.sic_description := if(temp_code in setSIC, L.sic_description, '');
		SELF.sic_code := L.sic_code;
	END;
	
	finalSicDS := PROJECT(SicDS, codeXrf(LEFT));
						
  RETURN finalSicDS;	
	
END;

END;