IMPORT _Validate, Infogroup, MDR, ut;

EXPORT Standardize_Input(STRING pversion, BOOLEAN pUseProd = FALSE) := FUNCTION

	Infogroup.Layouts.Base clean_input(Infogroup.Layouts.Input L):= TRANSFORM
		the_license_number := ut.CleanSpacesAndUpper(L.license_number);
		bad_license_number := ['PENDING', '0', '$$$$$$$$$', 'TEMPORARY', 'N/A', 'TEMP', 'NA', 'NONE',
		                       'UNLICENSED'];
		current_year       := (UNSIGNED)thorlib.wuid()[2..5];

		SELF.first_name               := ut.CleanSpacesAndUpper(L.first_name);
		SELF.middle_name              := ut.CleanSpacesAndUpper(L.middle_name);
		SELF.last_name                := ut.CleanSpacesAndUpper(L.last_name);
		SELF.suffix                   := ut.CleanSpacesAndUpper(L.suffix);
		SELF.address                  := ut.CleanSpacesAndUpper(L.address);
		SELF.prim_range               := ut.CleanSpacesAndUpper(L.prim_range);
		SELF.predir                   := ut.CleanSpacesAndUpper(L.predir);
		SELF.prim_name                := ut.CleanSpacesAndUpper(L.prim_name);
		SELF.addr_suffix              := ut.CleanSpacesAndUpper(L.addr_suffix);
		SELF.postdir                  := ut.CleanSpacesAndUpper(L.postdir);
		SELF.unit_type                := ut.CleanSpacesAndUpper(L.unit_type);
		SELF.unit_number              := ut.CleanSpacesAndUpper(L.unit_number);
		SELF.city                     := ut.CleanSpacesAndUpper(L.city);
		SELF.state                    := ut.CleanSpacesAndUpper(L.state);
		SELF.ace_rec_type             := ut.CleanSpacesAndUpper(L.ace_rec_type);
		SELF.cart                     := ut.CleanSpacesAndUpper(L.cart);
		SELF.match_code               := ut.CleanSpacesAndUpper(L.match_code);
		SELF.mail_score               := ut.CleanSpacesAndUpper(L.mail_score);
		SELF.residential_business_ind := ut.CleanSpacesAndUpper(L.residential_business_ind);
		SELF.employer_name            := ut.CleanSpacesAndUpper(L.employer_name);
		SELF.industry_title           := ut.CleanSpacesAndUpper(L.industry_title);
		SELF.occupation_title         := ut.CleanSpacesAndUpper(L.occupation_title);
		SELF.specialty_title          := ut.CleanSpacesAndUpper(L.specialty_title);
		SELF.license_state            := ut.CleanSpacesAndUpper(L.license_state);
		SELF.license_number           := IF(the_license_number IN bad_license_number,
		                                    '',
																				the_license_number);
		SELF.status_code              := ut.CleanSpacesAndUpper(L.status_code);
		SELF.clean_exp_date           := IF(_Validate.Date.fIsValid(L.exp_date),
																	      L.exp_date,
																	      '');
		SELF.clean_effective_date     := IF(_Validate.Date.fIsValid(L.effective_date) AND
																           _Validate.Date.fIsValid(L.effective_date, _Validate.Date.Rules.DateInPast),
															          L.effective_date,
															          '');
		SELF.clean_add_date           := IF(_Validate.Date.fIsValid(L.add_date) AND
																           _Validate.Date.fIsValid(L.add_date, _Validate.Date.Rules.DateInPast),
															          L.add_date,
															          '');
		SELF.clean_change_date        := IF(_Validate.Date.fIsValid(L.change_date) AND
																           _Validate.Date.fIsValid(L.change_date, _Validate.Date.Rules.DateInPast),
															          L.change_date,
															          '');
		SELF.clean_year_licensed      := IF((UNSIGNED)L.year_licensed > current_year, '', L.year_licensed);
		SELF.status_code_desc         := CASE(SELF.status_code, 'A' => 'AGED OFF',
		                                                        'C' => 'CURRENT',
																												    'O' => 'OUT OF STATE',
																												    'P' => 'EXPIRED IN LAST YEAR',
																												    'R' => 'REPLACED',
																												    'X' => 'EXPIRED',
																												           '');
		SELF.src                      := MDR.sourceTools.src_Infogroup;
		SELF.dt_first_seen            := IF(SELF.clean_add_date != '',
			                                  (UNSIGNED)SELF.clean_add_date,
																        (UNSIGNED)pversion);
		SELF.dt_last_seen             := IF(SELF.clean_change_date != '',
			                                  (UNSIGNED)SELF.clean_change_date,
																        (UNSIGNED)pversion);
		SELF.dt_vendor_first_reported := (UNSIGNED)pversion;
		SELF.dt_vendor_last_reported  := (UNSIGNED)pversion;

		SELF := L;
		SELF := [];
	END;

  input := Infogroup.Files(, pUseProd).Input;

	RETURN PROJECT(input, clean_input(LEFT));

END;
