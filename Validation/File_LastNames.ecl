layout_name :=
RECORD
	STRING20 name;
	unsigned cnt;
	boolean isaCompany;
END;

export File_LastNames := dataset('~thor_data400::maltemp::lastnames',layout_name,flat)(cnt>1000);