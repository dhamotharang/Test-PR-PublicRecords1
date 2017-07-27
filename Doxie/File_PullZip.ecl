inRec :=
RECORD
	STRING5 zip;
	STRING1 lf;
END;

export File_pullzip := dataset('~thor_data400::base::pull_zip', inRec, flat);