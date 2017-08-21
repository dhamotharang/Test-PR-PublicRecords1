EXPORT Layout_In_raw :=
	RECORD
		string orig_LexID := '';		//As of January 2014. If this is populated then is the only search criteria considered.
		string TimeStamp := '';
		string Time := '';
		string Data_Src := '';
		string Action := '';
		string DPPA := '';
		string GLBA := '';
		string REFERENCE := '';
		string IP_Address := '';
		string IP_Location := '';
		string Billgroup := '';
		string WebID := '';
		string LexisID := '';
		string Password := '';
		string lib := '';
		string file := '';
		string Document_Num := '';
		string Database := '';
		string Ansr_Count := '';
		string permission_5A := '';
		string Orig_Search_Terms := '';		//"searchstr" in original spreadsheet. Have to change the name because "searchstr" is used later.
		string Edited_Search_Terms := '';	//This may be original data, but usually have to calculate. Using an Excel formula for now; have to write ECL for it some time.
	END;