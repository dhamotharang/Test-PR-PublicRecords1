import _Validate;

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