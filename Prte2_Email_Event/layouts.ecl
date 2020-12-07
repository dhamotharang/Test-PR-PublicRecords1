Import Prte2;
EXPORT Layouts := MODULE

Export Event_Layout:=Record
string transaction_id;
string email_address;
string account;
string domain;
string status;
string disposable;
string role_address;
string error_code;
string error_desc;
string source;
string date_added;
string processed_date;
string source_cd;
string cust_name;
string bug_num;
end;

Export Base_Event_Layout:=RECORD
  string200 email_address;
  string8 date_added;
  string2 source;
  string16 transaction_id;
  string100 account;
  string100 domain;
  string10 status;
  string10 disposable;
  string10 role_address;
  string40 error_code;
  string100 error_desc;
  string8 process_date;
  string2 source_cd;
	PRTE2.LAYOUTS.DEFLT_CPA;
 END;

Export Domain_Layout:=Record
string domain_name;
string create_date;
string expire_date;
string date_first_seen;
string date_last_seen;
string date_first_verified;
string date_last_verified;
string domain_status;
string verifies_account;
string process_date;
unsigned8 email_rec_key;
string cust_name;
string bug_num;
string2 source;
end;

Export Base_Domain_Layout:=RECORD
  string100 domain_name;
  string8 create_date;
  string8 expire_date;
  string8 date_first_seen;
  string8 date_last_seen;
  string8 date_first_verified;
  string8 date_last_verified;
  string50 domain_status;
	string2 source;
  string10 verifies_account;
  string8 process_date;
  unsigned8 email_rec_key;
 END;

End;