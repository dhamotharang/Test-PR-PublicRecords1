import ut;
inRec :=
RECORD
	STRING60 ssn;
	STRING1 lf;
END;

export File_pullSSN_LE := dataset('~thor_data400::in::pull_ssn', inRec, flat);

//need to change the file path and name. This is for testing purpose 20 records are selected from existing file