import address;
 
export Layout_InstantID_Logs_Base := 

record
  string8 process_date;
	string8 date_first_seen;
	string8 date_last_seen;
	string60 ptrack; //testing only
	instantid_logs.Layout_InstantID_Logs;
	string cname := '';	
	string8 dob := '';
	string9 ssn := '';
	Address.Layout_Clean_Name;
	address.Layout_Clean182;
	string company_id_extended := '';
	string dateadded_extended := '';
	string10 PHONE := '';
	integer6 DID := 0;
	integer DID_SCORE := 0;
end;