export GetUpdateRecordLength(string updatetype) := 
	map(updatetype = 'CONT' => sizeof(Layout_Corporate_Direct_Cont_in),
		updatetype = 'EVENT' => sizeof(Layout_Corporate_Direct_Event_In),
		updatetype = 'SUPP' => sizeof(Layout_Corporate_Direct_Supp_In),
		updatetype = 'CORP' => sizeof(Layout_Corporate_Direct_Corp_In), 0);