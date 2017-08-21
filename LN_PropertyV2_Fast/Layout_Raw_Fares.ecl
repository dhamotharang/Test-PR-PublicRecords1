IMPORT LN_PropertyV2;
EXPORT Layout_Raw_Fares := MODULE

	EXPORT Assessment := RECORD
			LN_PropertyV2.Layout_Raw_Fares.Input_Assessor;
			string3 update_type;
			string100 raw_file_name;
	END;
	EXPORT Deed := RECORD
		  LN_PropertyV2.Layout_Raw_Fares.Input_Deed;
			string100 raw_file_name { virtual(logicalfilename)};
	END;
END;