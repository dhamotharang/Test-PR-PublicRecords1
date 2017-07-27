IMPORT _Validate, Death_Master, ut;

EXPORT Standardize_Input(DATASET(Layouts.Base) pInput) := FUNCTION

  Layouts.Base clean_input(Layouts.Base L) := TRANSFORM
		clean_first_name      := ut.fnTrim2Upper(L.fname);
		clean_middle_name     := ut.fnTrim2Upper(L.mname);
		clean_last_name       := ut.fnTrim2Upper(L.lname);
		the_dob               := L.dob_year + L.dob_month + L.dob_day;
		the_dod               := L.dod_year + L.dod_month + L.dod_day;
		
		garbage               := ['N/A', '*UNKNOWN*', '(UNAVAILABLE)', 'UNKNOWN'];
		special_phrase        := clean_first_name + ' ' + clean_middle_name + ' ' + clean_last_name =
		                            '(NAME AT BIRTH IS UNKNOWN)';
		no_middle             := ['(NO MIDDLE'];
		first_has_no_letters  := NOT(REGEXFIND('[A-Z]+', clean_first_name));
		middle_has_no_letters := NOT(REGEXFIND('[A-Z]+', clean_middle_name));
		last_has_no_letters   := NOT(REGEXFIND('[A-Z]+', clean_last_name));

	  SELF.fname := MAP(special_phrase              => '',
		                  first_has_no_letters        => '',
											clean_first_name IN garbage => '',
											clean_first_name
		                 );
	  SELF.mname := MAP(special_phrase                 => '',
		                  middle_has_no_letters          => '',
											clean_middle_name IN no_middle => '',
											clean_middle_name IN garbage   => '',
											clean_middle_name
		                 );
	  SELF.lname := MAP(special_phrase             => '',
		                  last_has_no_letters        => '',
											clean_last_name IN garbage => '',
											clean_last_name
		                 );
		
		SELF.occurrence_state          := ut.fnTrim2Upper(L.occurrence_state);
		SELF.occurrence_county :=
		  ut.fnTrim2Upper(Death_Master.lkp_mi_county_codes(cty = L.occurrence_county)[1].countyname);
		SELF.occurrence_civil_division := ut.fnTrim2Upper(L.occurrence_civil_division);
		SELF.residence_state           := ut.fnTrim2Upper(L.residence_state);
		SELF.residence_county :=
		  ut.fnTrim2Upper(Death_Master.lkp_mi_county_codes(cty = L.residence_county)[1].countyname);
		SELF.residence_civil_division  := ut.fnTrim2Upper(L.residence_civil_division);
	  SELF.decedent_sex              := CASE(L.decedent_sex, '1' => 'M',
																													 '2' => 'F',
																													 '');
	  SELF.ssn            := TRIM(L.ssn, LEFT, RIGHT);
	  SELF.address        := ut.fnTrim2Upper(L.address);
	  SELF.city           := ut.fnTrim2Upper(L.city);
	  SELF.state          := ut.fnTrim2Upper(L.state);
		SELF.father_surname := ut.fnTrim2Upper(L.father_surname);
		SELF.dob            := IF(_Validate.Date.fIsValid(the_dob) AND
		                             _Validate.Date.fIsValid(the_dob, _Validate.Date.Rules.DateInPast),
									            the_dob,
									            '');
		SELF.dod            := IF(_Validate.Date.fIsValid(the_dod) AND
		                             _Validate.Date.fIsValid(the_dod, _Validate.Date.Rules.DateInPast),
									            the_dod,
									            '');
		
	  SELF := L;
	END;
	
	RETURN PROJECT(pInput, clean_input(LEFT));
	
END;