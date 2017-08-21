IMPORT _Validate;

EXPORT valid_date := MODULE

  // This function checks a date field (assumed to be in proper format of yyyymmdd, at its largest)
	//   to see if it's valid.  The date can either be 0, 4, 6, or 8 characters long and will be put
	//   through the _Validate.Date utility.  IF the field you are checking HAS to be 0 or a single
	//   exact number for its length (whether it be 8 or something else), then do not use this function.
  EXPORT fn_valid_0468date(STRING8 input_date, BOOLEAN zeroMonthOK = FALSE, BOOLEAN zeroDayOK = FALSE) := FUNCTION
	  input_date_trimmed := TRIM(input_date);
		input_length       := LENGTH(input_date_trimmed);

    is_empty   := (UNSIGNED)input_date_trimmed = 0;
		is_valid_4 := input_length = 4 AND
		                 _Validate.Date.fIsValid(input_date_trimmed, _Validate.Date.Rules.YearValid,
										                            ZeroMonthOK, ZeroDayOK);
		is_valid_6 := input_length = 6 AND
		                 _Validate.Date.fIsValid(input_date_trimmed, _Validate.Date.Rules.MonthValid,
										                            ZeroMonthOK, ZeroDayOK);
		is_valid_8 := input_length = 8 AND
		                 _Validate.Date.fIsValid(input_date_trimmed, _Validate.Date.Rules.DayValid,
										                            ZeroMonthOK, ZeroDayOK);
    is_valid   := is_empty OR is_valid_4 OR is_valid_6 OR is_valid_8;

    RETURN (UNSIGNED)is_valid;
	END;

  // This function is exactly like fn_valid_0468date, except it has an extra check that the date is
	//   in the past.
  EXPORT fn_valid_0468pastDate(STRING8 input_date, BOOLEAN zeroMonthOK = FALSE, BOOLEAN zeroDayOK = FALSE) := FUNCTION
	  input_date_trimmed := TRIM(input_date);
		input_length       := LENGTH(input_date_trimmed);

    is_empty   := (UNSIGNED)input_date_trimmed = 0;
		is_valid_4 := input_length = 4 AND
		                 _Validate.Date.fIsValid(input_date_trimmed, _Validate.Date.Rules.YearValid,
										                            ZeroMonthOK, ZeroDayOK) AND
		                 _Validate.Date.fIsValid(input_date_trimmed, _Validate.Date.Rules.DateInPast,
										                            ZeroMonthOK, ZeroDayOK);
		is_valid_6 := input_length = 6 AND
		                 _Validate.Date.fIsValid(input_date_trimmed, _Validate.Date.Rules.MonthValid,
										                            ZeroMonthOK, ZeroDayOK) AND
		                 _Validate.Date.fIsValid(input_date_trimmed, _Validate.Date.Rules.DateInPast,
										                            ZeroMonthOK, ZeroDayOK);
		is_valid_8 := input_length = 8 AND
		                 _Validate.Date.fIsValid(input_date_trimmed, _Validate.Date.Rules.DayValid,
										                            ZeroMonthOK, ZeroDayOK) AND
		                 _Validate.Date.fIsValid(input_date_trimmed, _Validate.Date.Rules.DateInPast,
										                            ZeroMonthOK, ZeroDayOK);
    is_valid   := is_empty OR is_valid_4 OR is_valid_6 OR is_valid_8;

    RETURN (UNSIGNED)is_valid;
	END;

END;
