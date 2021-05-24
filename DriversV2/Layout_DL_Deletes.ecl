EXPORT	Layout_DL_Deletes := record
  string2      orig_state;
	qstring24    dl_number;  
	string       filedate;
	string       processdate;
	qstring52    name;
	qstring40    addr1;   
	qstring20    city;
	qstring2     state;
	qstring5     zip;
	unsigned4    dob := 0;
	unsigned4    lic_issue_date := 0;
END;
			