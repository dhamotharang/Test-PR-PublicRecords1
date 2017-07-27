inRec :=
RECORD
	STRING60 ssn;
	STRING1 lf;
END;

export File_pullSSN := dataset('~thor_data400::in::pull_ssn', inRec, flat);