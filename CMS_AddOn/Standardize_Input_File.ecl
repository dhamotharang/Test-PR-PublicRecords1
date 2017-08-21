IMPORT _Control, _Validate, CMS_AddOn, ut;

EXPORT Standardize_Input_File(STRING                           pversion,
                              STRING                           pFileEffectiveDate,
                              DATASET(CMS_AddOn.Layouts.Input) pInput) := FUNCTION

  // If the date isn't valid (in slash format and valid after translation), then it either gets
	//   replaced with the date found in the file name (effective date) or it gets left alone
	//   (termination date).  A blank date is totally valid at this point.
	STRING translate_date(STRING in_date, BOOLEAN is_effective_date) := FUNCTION

		in_date_trimmed   := TRIM(in_date);
		first_date_slash  := DataLib.StringFind(in_date_trimmed, '/', 1);
		second_date_slash := DataLib.StringFind(in_date_trimmed, '/', 2);
		invalid_format    := first_date_slash = 0 OR second_date_slash = 0;
		date_month        := IF(invalid_format, '', in_date_trimmed[1..first_date_slash - 1]);
		date_day          := IF(invalid_format, '', in_date_trimmed[first_date_slash + 1..second_date_slash - 1]);
		date_year         := IF(invalid_format, '', in_date_trimmed[second_date_slash + 1..]);
		final_month       := IF(LENGTH(date_month) = 1, '0' + date_month, date_month);
		final_day         := IF(LENGTH(date_day) = 1, '0' + date_day, date_day);
		final_date        := date_year + final_month + final_day;
		is_valid          := _Validate.Date.fIsValid(final_date) AND
		                        _Validate.Date.fIsValid(final_date, _Validate.Date.Rules.DateInPast);

		RETURN IF(in_date_trimmed != '' AND (invalid_format OR NOT(is_valid)),
		          IF(is_effective_date, pFileEffectiveDate, 'INVALID'),
							final_date);

	END;

	// All termination dates must be filled.  If they are blank, they get filled with 99999999.
	// The termination date is left alone when it's invalid.
  CMS_AddOn.Layouts.Input_Plus clean_input(CMS_AddOn.Layouts.Input L) := TRANSFORM
	  the_termination_date      := IF(L.Termination_Date = '',
		                                '99999999',
																		translate_date(L.Termination_Date, FALSE));

    SELF.AddOnCode            := ut.fnTrim2Upper(L.AddOnCode);
    SELF.PrimaryCode          := ut.fnTrim2Upper(L.PrimaryCode);
    SELF.Effective_Date       := translate_date(L.Effective_Date, TRUE);
		SELF.TerminationDateValid := the_termination_date = '' OR the_termination_date != 'INVALID';
    SELF.Termination_Date     := IF(the_termination_date = 'INVALID',
		                                L.Termination_Date,
															      the_termination_date);
		
	  SELF := [];
	END;
	
	RETURN PROJECT(pInput, clean_input(LEFT));
	
END;