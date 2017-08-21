EXPORT Layout_raw := 
	RECORD
		string orig_LexID := '';		// as of January 2014
		
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
		string searchstr := '';	
		
		string Edited_Search_Terms := '';		//setup and run in Excel - see "workbook"
		integer8  orig_rid := 0;								//in Excel: added Sept 2014, to keep track of original rows, given some rows now have multiple orig_LexID, which is now the main seacrch criteria
		
	END;
	