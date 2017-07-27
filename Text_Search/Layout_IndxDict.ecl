export Layout_IndxDict := RECORD
	Layout_Dictionary; 
	UNSIGNED8 fpos{virtual(fileposition)} := 0;
END;
