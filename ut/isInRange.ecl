// This function checks if tested value is in range for boundary values provided (if any)
// Blank value is considered to be in range if AllowBlank is true
EXPORT isInRange(STRING8 TestVal, STRING8 FirstVal='', STRING8 LastVal='', BOOLEAN AllowBlank = TRUE) := FUNCTION
		iswithinRange := (AllowBlank AND (UNSIGNED)TestVal=0) OR (((UNSIGNED)FirstVal=0 OR TestVal >= FirstVal) AND ((UNSIGNED)LastVal=0 OR TestVal <= LastVal));
		RETURN iswithinRange;
END;