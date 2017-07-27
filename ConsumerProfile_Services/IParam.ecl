import risk_indicators, FCRA;
EXPORT IParam := MODULE
	export options := interface (FCRA.iRules)
		export boolean is_california   := false;
		export string2 state_law_exception := '';//no ECL code to support this for now
		export string intended_purpose := ''; //corresponds to FCRA permissible purpose
		export boolean test_data_enabled := false;
		export string test_data_table_name := '';
		export integer1 BS_version := 41;
		export string5 industry_class := '';
		export unsigned1 dob_mask := 0; //requires translation at top level for backward compatibility (used to be a string6)
		export string6 SSNMask := '';
		export string50 datarestrictionmask := risk_indicators.iid_constants.default_DataRestriction;
		export boolean isECHRestricted := true;
		export boolean isEQCHRestricted := false;
	end;
END;