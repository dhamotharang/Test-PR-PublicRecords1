export aid_layouts := module

export cardholder:= record	,maxLength(589824)
string Clientkey;
string ssn;
string Firstname;
string LastName;
string Address1;
string Address2;
string City;
string State;
string Zip;
string Country;
end;

export cardholder_fixed:= record	
string13 Clientkey;
string9 ssn;
string40 Firstname;
string40 LastName;
string40 Address1;
string40 Address2;
string40 City;
string2 State;
string10 Zip;
string3 Country;
end;

export cardholder_clean:= record
//string8 process_date;
//string2 vendor;
//string5 item_id;
//string20  source_file;
//string8 Date_vendor_first_reported;
//string8 Date_vendor_last_reported;
//string8 Date_first_seen;
//string8 Date_last_seen;
cardholder_fixed;
	string10  prim_range := '',
	string2   predir:= '',
	string28  prim_name:= '',
	string4   addr_suffix:= '',
	string2   postdir:= '',
	string10  unit_desig:= '',
	string8   sec_range:= '',
	string25  p_city_name:= '',
	string25  v_city_name:= '',
	string2   st:= '',
	string5   zip5:= '',
	string4   zip4:= '',
	string4   cart:= '',
	string1   cr_sort_sz:= '',
	string4   lot:= '',
	string1   lot_order:= '',
	string2   dpbc:= '',
	string1   chk_digit:= '',
	string2   rec_type:= '',
	string2   ace_fips_st:= '',
	string3   county:= '',
	string10  geo_lat:= '',
	string11  geo_long:= '',
	string4   msa:= '',
	string7   geo_blk:= '',
	string1   geo_match:= '',
	string4   err_stat:= '',
	string5   title:= '',
	string20  fname:= '',
	string20  mname:= '',
	string20  lname:= '',
	string5   suffix:= '',
unsigned8 rawaid := 0;
end;

export transactions_fixed := record 	
string13 Clientkey;
string9 SSN;
string40 Firstname;
String40 LastName;
String40 Address1;	
String40 Address2;
String40 City;
string2 State;
string10 Zip;
String3 Country;
String50 MerchantID;
String500 Description;
Integer4 MCC;	
Integer8 TransactionID;
string14 TransactionTime;
Integer8 Amount;
end;

export transaction := record 	,maxLength(589824)
string Clientkey;
string SSN;
string Firstname;
String LastName;
String Address1;	
String Address2;
String City;
string State;
string Zip;
String Country;
String MerchantID;
String Description;
String MCC;	
String TransactionID;
string TransactionTime;
String Amount;
string TransTypeID := '';
string EntryModeType := '';
end;

export transaction_clean := record
//string8 process_date;
//string2 vendor;
//string5 item_id;
//string20  source_file;
//string8 Date_vendor_first_reported;
//string8 Date_vendor_last_reported;
//string8 Date_first_seen;
//string8 Date_last_seen;
transactions_fixed;
//  string8   clean_transaction_date;
//  string6   clean_transaction_time;	
	string10  prim_range := '',
	string2   predir:= '',
	string28  prim_name:= '',
	string4   addr_suffix:= '',
	string2   postdir:= '',
	string10  unit_desig:= '',
	string8   sec_range:= '',
	string25  p_city_name:= '',
	string25  v_city_name:= '',
	string2   st:= '',
	string5   zip5:= '',
	string4   zip4:= '',
	string4   cart:= '',
	string1   cr_sort_sz:= '',
	string4   lot:= '',
	string1   lot_order:= '',
	string2   dpbc:= '',
	string1   chk_digit:= '',
	string2   rec_type:= '',
	string2   ace_fips_st:= '',
	string3   county:= '',
	string10  geo_lat:= '',
	string11  geo_long:= '',
	string4   msa:= '',
	string7   geo_blk:= '',
	string1   geo_match:= '',
	string4   err_stat:= '',
	string5   title:= '',
	string20  fname:= '',
	string20  mname:= '',
	string20  lname:= '',
	string5   suffix:= '',
unsigned8 rawaid := 0;
end;

export did_rec1 := record
	unsigned6	did := 0;
	unsigned1	did_score := 0;
  cardholder_clean;
	string8		dob_better := '';
end;


export did_rec2 := record
	unsigned6	did := 0;
	unsigned1	did_score := 0;
  transaction_clean;
	string8		dob_better := '';
end;


end;


