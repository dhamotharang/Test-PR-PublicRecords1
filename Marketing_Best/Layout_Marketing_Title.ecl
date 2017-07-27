export Layout_Marketing_Title := record
	unsigned6  bdid;
	unsigned6  did;
	unsigned4  dt_last_seen;   // From contact infor if available
	string35   company_title;  // Title of Contact at Company if available
	string5    title;
	string20   fname;
	string20   mname;
	string20   lname;
	string5    name_suffix;
	string2	   source;
	string1    decision_maker_flag := '';
end;