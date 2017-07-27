l :=
RECORD
	STRING12 did;
	STRING10 phone10;
	STRING16 date;
END;


export File_pullPhone := dataset('~thor_data400::in::blackphonelist',l,flat)((unsigned)did > 0,
													 		  (unsigned)phone10 > 0);