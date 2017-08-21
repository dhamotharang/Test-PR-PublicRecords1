// Functions currently created follow the logic that 0 is good, and 1 or greater is an error.
EXPORT valid_text := MODULE

  // This function checks the string for any non-printable characters.  Any found is an error.
  EXPORT fn_nonprintable_chars(STRING input_text) := FUNCTION
    RETURN IF(REGEXFIND('[^[:print:]]', input_text), 1, 0);
	END;

	// This function allows a subset of non-printable characters that contain latin letters.  It's mainly
	//   to capture enya and a few other special characters/letters.  So, if it's printable, it's not an
	//   an error.  It's only an error if it's not a printable character that's not part of this subset.
  EXPORT fn_latin_nonprintable_chars(STRING input_text) := FUNCTION
    RETURN IF(REGEXFIND('[^[:print:]]', input_text) AND REGEXFIND('[^\\xC0-\\xFF]', input_text), 1, 0);
	END;

END;
