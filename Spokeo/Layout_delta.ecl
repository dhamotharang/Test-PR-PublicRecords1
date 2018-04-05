EXPORT Layout_delta := RECORD
		string64		SpokeoID;
		unsigned6			LexId;
		string3				Lexid_Score;
		// name
		string20			Best_First_Name;
		string20			Best_Middle_Name;
		string20			Best_Last_Name;
		string5				Best_Name_Suffix;
		string6				Best_Birth_YearMonth;
		// address
		string70			BestAddressStreet;
		string40			BestAddressCityStateZip;
		string10			BestAddressLatitude;
		string11			BestAddressLongitude;
		string2				BestAddressAddressType;
		integer				best_first_seen;
		integer				best_last_seen;
		unsigned8			BestAddressId;
		unsigned8			hhid;
		string1				deceased_flag;
		
		string1				judgments := '';
		string1				civilCourtRecords := '';
		string1				crimCourtRecords := '';
		string1				curr_incar_flag := '';
		string1				foreclosures := '';
		string1				bankruptcy := '';
		
		string1				LexIdChanged;
		string1				Best_First_Name_Changed;
		string1				Best_Middle_Name_Changed;
		string1				Best_Last_Name_Changed;
		string1				Best_Name_Suffix_Changed;
		string1				Best_Birth_YearMonth_Changed;
		string1				BestAddressChanged;
		string1				HhidChanged;
		string1				deceasedFlagChanged;
		// flags
		string1				judgmentsChanged := '';
		string1				civilCourtRecordsChanged := '';
		string1				crimCourtRecordsChanged := '';
		string1				curr_incar_flagChanged := '';
		string1				foreclosuresChanged := '';
		string1				bankruptcyChanged := '';
		
END;