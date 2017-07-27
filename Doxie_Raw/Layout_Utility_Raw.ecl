import UtilFile;
export Layout_Utility_Raw :=
RECORD
	utilfile.Layout_Utility_In;
	unsigned6 fdid;
	string18 county_name;
	boolean includedByHHID := false;	
END;