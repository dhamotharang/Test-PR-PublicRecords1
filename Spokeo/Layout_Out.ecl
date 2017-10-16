EXPORT Layout_Out := RECORD
		Layout_In;
		unsigned6			LexId;
		string3				Lexid_Score;
		string70			cln_addr1;
		string40			cln_addr2;
		string10			latitude;
		string11			longitude;
		string1				address_source;		// S=Spokeo, L=LexId
		string2				address_type;
		string4				address_status;
		integer				dt_first_seen;
		integer				dt_last_seen;
		string1				current_address_flag;
		unsigned8			address_id;
		unsigned8			hhid;
		string1				deceased_flag;
		string1				better_address_flag;
		string1				confirmed_address_flag;
		// name
		string20			Best_First_Name;
		string20			Best_Middle_Name;
		string20			Best_Last_Name;
		string5				Best_Name_Suffix;
		string6				Best_Birth_YearMonth;
		// flags
		string1				judgments := '';
		string1				civilCourtRecords := '';
		string1				crimCourtRecords := '';
		string1				curr_incar_flag := '';
		string1				foreclosures := '';
		string1				bankruptcy := '';
END;