//

EXPORT layout_federal_bureau_base := record 
  integer8  rcid;
	string100 persistent_record_id;	
  string80 offender_key; 	
	string2  src;
	string8	 process_date;
	string8 date_first_seen;
  string8 date_last_seen;
  string8 date_vendor_first_reported;
  string8 date_vendor_last_reported;
	string8 Record_Upload_Date;
	string40 category;
	string100 source;
	string115	orig_name;
	string50	orig_lastName;
	string50	orig_firstName;
	string40	orig_middleName;
	string15	orig_suffix;
	string8	 DOB;
	string10 sex;
	string50 race;
	string3 age;
	string20	Registery_Number; 
	string100	Defendant_Status;
	string100 offense_description;
	string150 disposition;
	string8 Scheduled_Release_Date;
	string1 nametype;  	
	unsigned8 nid;  
  string5 title;
  string50 fname;
  string50 mname;
  string50 lname;
  string50 suffix;
  unsigned2 name_ind;
	unsigned1 rec_type;
	string1		history_flag:='';
	unsigned4 global_sid;
  unsigned8 record_sid; 
end;

  
