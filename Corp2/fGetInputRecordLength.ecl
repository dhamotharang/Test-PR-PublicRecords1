export fGetInputRecordLength(string updatetype) := 
	map(updatetype = 'CORP'		=> sizeof(Layout_Corporate_Direct_Corp_In),
		updatetype = 'CONT'		=> sizeof(Layout_Corporate_Direct_Cont_In),
		updatetype = 'EVENT'	=> sizeof(Layout_Corporate_Direct_Event_In),
		updatetype = 'STOCK'	=> sizeof(Layout_Corporate_Direct_Stock_In), 
		updatetype = 'AR'		=> sizeof(Layout_Corporate_Direct_AR_In), 
		
		0);
