import VehLic;

export Layout_slimvin :=
RECORD
	unsigned4 seq_no;
	STRING1 history;
	// unsigned6 vrid;
	File_SavedVina;			// no longer slim 						
							// because we use most fields
END;