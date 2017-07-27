/******************************************************************************
		This function checks if left field lenght is too small for edit2 and apply
		edit1 instead in the comparison of leftField and rightField.
******************************************************************************/

IMPORT SALT29;

export boolean WithinEditX(string leftField,string rightField, unsigned sLength = 5) := FUNCTION
	lLength := LENGTH(TRIM(leftField));
	rLength := LENGTH(TRIM(rightField));
	edit1 := SALT29.WithinEditN(leftField, rightField, 1);
	edit2 := SALT29.WithinEditN(leftField, rightField, 2);
	RETURN IF (lLength > sLength and rLength > sLength, edit2, edit1);
END;