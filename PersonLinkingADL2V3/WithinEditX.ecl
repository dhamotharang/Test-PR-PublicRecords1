
/******************************************************************************
		This function checks if left field lenght is too small for edit2 and apply
		edit1 instead in the comparison of leftField and rightField.
******************************************************************************/

IMPORT ut;

export boolean WithinEditX(string leftField,string rightField, unsigned sLength = 5) := FUNCTION
	lLength := LENGTH(TRIM(leftField));
	rLength := LENGTH(TRIM(rightField));
	edit1 := ut.WithinEditN(leftField, rightField, 1);
	edit2 := ut.WithinEditN(leftField, rightField, 2);
	RETURN IF (lLength > sLength and rLength > sLength, edit2, edit1);
END;