IMPORT _Validate, ut;

EXPORT Standardize_Input(DATASET(Layouts.Base)             pInputMI,
                         DATASET(Layouts.Input.IL_License) pInputIL,
												 STRING                            pversion) := MODULE

  SHARED Layouts.Base clean_input(Layouts.Base L) := TRANSFORM
		clean_first_middle_name  := ut.fnTrim2Upper(L.name_first_middle);
		clean_last_name          := ut.fnTrim2Upper(L.name_last);

	  SELF.name_prefix         := ut.fnTrim2Upper(L.name_prefix);
	  SELF.name_first_middle   := clean_first_middle_name;

		// If there is no first or middle name, then the last name contains the company name.
	  SELF.name_last           := IF(clean_first_middle_name != '', clean_last_name, '');
		SELF.company_name        := IF(clean_first_middle_name = '', clean_last_name, '');

    // So, full_name will either contain someone's first, middle, and last name or a business name
		SELF.full_name           := ut.fnTrim2Upper(L.name_first_middle + ' ' + L.name_last);
	  SELF.name_suffix         := ut.fnTrim2Upper(L.name_suffix);
		SELF.audit_number        := IF(L.audit_number = '0000000', '', L.audit_number);
	  SELF.address1            := ut.fnTrim2Upper(L.address1);
	  SELF.address2            := ut.fnTrim2Upper(L.address2);
	  SELF.address3            := ut.fnTrim2Upper(L.address3);
	  SELF.city                := ut.fnTrim2Upper(L.city);
	  SELF.state               := ut.fnTrim2Upper(L.state);
	  SELF.full_zip            := StringLib.StringFindReplace(TRIM(L.full_zip, LEFT, RIGHT), '-', '');
	  SELF.ssn                 := StringLib.StringFindReplace(TRIM(L.ssn, LEFT, RIGHT), '-', '');

		// The dob is coming in the format MMDDYYYY, need to translate it to our standard, YYYYMMDD.
		the_dob                  := L.dob[5..8] + L.dob[1..4];
		SELF.dob                 := IF(_Validate.Date.fIsValid(the_dob) AND
		                                  _Validate.Date.fIsValid(the_dob, _Validate.Date.Rules.DateInPast),
									                 the_dob,
									                 '');
		SELF.issue_date          := IF(_Validate.Date.fIsValid(L.issue_date) AND
		                                  _Validate.Date.fIsValid(L.issue_date, _Validate.Date.Rules.DateInPast),
													         L.issue_date,
													         '');
		SELF.license_status_date := IF(_Validate.Date.fIsValid(L.license_status_date) AND
		                                  _Validate.Date.fIsValid(L.license_status_date, _Validate.Date.Rules.DateInPast),
																	 L.license_status_date,
																	 '');
		SELF.expiration_date     := IF(_Validate.Date.fIsValid(L.expiration_date), L.expiration_date, '');

	  SELF := L;
	END;

  SHARED Layouts.Base clean_il_input(Layouts.Input.IL_License L) := TRANSFORM
	  // All dates are coming in as MMDDYYYY and need to be translated.
	  the_dob                 := L.dob[5..8] + L.dob[1..4];
	  the_issue_date          := L.issue_date[5..8] + L.issue_date[1..4];
	  the_last_update_date    := L.last_update_date[5..8] + L.last_update_date[1..4];
	  the_status_change_date  := L.status_change_date[5..8] + L.status_change_date[1..4];
	  the_expiration_date     := L.expiration_date[5..8] + L.expiration_date[1..4];

		clean_first_middle_name := ut.fnTrim2Upper(L.first_name + ' ' + L.middle_name);
		clean_last_name         := ut.fnTrim2Upper(L.last_name);

		// If there is no first or middle name, then the last name contains the company name.
	  SELF.name_last          := IF(clean_first_middle_name != '', clean_last_name, '');
		SELF.company_name       := IF(clean_first_middle_name = '', clean_last_name, '');

		SELF.license_status     := ut.fnTrim2Upper(L.license_status);
		SELF.bull_license_type  := ut.fnTrim2Upper(L.license_type);
		SELF.bull_specialty     := ut.fnTrim2Upper(L.specialty);
		SELF.discipline_ind     := StringLib.StringToUpperCase(L.discipline_ind);
		SELF.full_name          := ut.fnTrim2Upper(L.first_name + ' ' + L.middle_name + ' ' + L.last_name);
	  SELF.name_first_middle  := clean_first_middle_name;
	  SELF.name_first         := ut.fnTrim2Upper(L.first_name);
	  SELF.name_middle        := ut.fnTrim2Upper(L.middle_name);
	  SELF.name_suffix        := ut.fnTrim2Upper(L.suffix);
		SELF.ssn                := TRIM(L.ssn_fein, LEFT, RIGHT); // They only send in last 4 digits
	  SELF.address1           := ut.fnTrim2Upper(L.addr_atten_line);
	  SELF.address2           := ut.fnTrim2Upper(L.addr_ln_1);
	  SELF.address3           := ut.fnTrim2Upper(L.addr_ln_2);
	  SELF.city               := ut.fnTrim2Upper(L.city);
	  SELF.state              := ut.fnTrim2Upper(L.state);
		// They only send the 5 digits, but this is in case
	  SELF.full_zip           := TRIM(L.zip, LEFT, RIGHT)[1..5];

		SELF.dob                := IF(_Validate.Date.fIsValid(the_dob) AND
		                                 _Validate.Date.fIsValid(the_dob, _Validate.Date.Rules.DateInPast),
									                the_dob,
									                '');
		SELF.issue_date         := IF(_Validate.Date.fIsValid(the_issue_date) AND
		                                 _Validate.Date.fIsValid(the_issue_date, _Validate.Date.Rules.DateInPast),
													        the_issue_date,
													        '');
		SELF.last_update_date   := IF(_Validate.Date.fIsValid(the_last_update_date) AND
		                                 _Validate.Date.fIsValid(the_last_update_date, _Validate.Date.Rules.DateInPast),
																  the_last_update_date,
																  '');
		SELF.status_change_date := IF(_Validate.Date.fIsValid(the_status_change_date) AND
		                                 _Validate.Date.fIsValid(the_status_change_date, _Validate.Date.Rules.DateInPast),
																  the_status_change_date,
																  '');
		SELF.expiration_date    := IF(_Validate.Date.fIsValid(the_expiration_date), the_expiration_date, '');

    SELF.dt_vendor_first_reported := (UNSIGNED4)pversion;
    SELF.dt_vendor_last_reported  := (UNSIGNED4)pversion;
		SELF.customer_id              := _Constants().il_cust_id;
		SELF.record_type              := 'C';

	  SELF := L;
	  SELF := [];
	END;

	MI := PROJECT(pInputMI, clean_input(LEFT));
	IL := PROJECT(pInputIL(license_number[1..3] IN _Constants().valid_license_numbers), clean_il_input(LEFT));

  EXPORT All := MI + IL;

END;