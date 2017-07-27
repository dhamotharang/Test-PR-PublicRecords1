IMPORT SALT28;

export boolean WithinEditX(string leftField,string rightField, unsigned sLength = 5) := FUNCTION
	lLength := LENGTH(TRIM(leftField));
	rLength := LENGTH(TRIM(rightField));
	edit1 := SALT28.WithinEditN(leftField, rightField, 1);
	edit2 := SALT28.WithinEditN(leftField, rightField, 2);
	RETURN IF (lLength > sLength and rLength > sLength, edit2, edit1);
END;
