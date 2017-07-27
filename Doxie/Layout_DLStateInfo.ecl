export Layout_DLStateInfo := RECORD
	String24 dl_num;
	String2 dl_st;
	unsigned4 earliest_lic_issue_date := 0;
	unsigned4 latest_expiration_date := 0;
END;
