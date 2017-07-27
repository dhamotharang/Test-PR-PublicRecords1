IMPORT FFD;
export layout_NameDID := RECORD
	doxie.layout_references;
	STRING20 fname;
	STRING20 mname;
	STRING20 lname;
	STRING5 name_suffix;
	unsigned1 name_occurences := 0;
	FFD.Layouts.CommonRawRecordElements;
END;