IMPORT dx_Cortera;

EXPORT Layout_Header := RECORD
	dx_Cortera.Layouts.Input.Layout_Header;
	unsigned4   FIRST_SEEN;  // NEW FIELD - Need to be excluded from the keys
END;