import Targus;

// using the slim version (which contains only the cleaned fields)
export Layout_Targus_raw := RECORD
	Targus.Layout_Consumer_slim;
	string18  county_name := '';
END;
