export Layout_Watercraft_Search_Group
 :=
  record
	string8		date_first_seen;
	string8		date_last_seen;
	string8		date_vendor_first_reported;
	string8		date_vendor_last_reported;
	string30	watercraft_key;
	string30	sequence_key;
	string2		state_origin;
	string2		source_code;
	string1		dppa_flag;
	string100	orig_name;
	string1		orig_name_type_code;
	string20	orig_name_type_description;
	string25	orig_name_first;
	string25	orig_name_middle;
	string25	orig_name_last;
	string10	orig_name_suffix;
	string60	orig_address_1;
	string60	orig_address_2;
	string25	orig_city;
	string2		orig_state;
	string10	orig_zip;
	string5		orig_fips;
	string30    orig_province :='';
	string30    orig_country  :='';
	string8		dob;
	string9		orig_ssn;
	string9		orig_fein;
	string1		gender;
	string10	phone_1;
	string10	phone_2;
	string73	clean_pname;
	string60	company_name;
	string182	Clean_address;
	string12	bdid;
	string9		fein;
	string12	did;
	string3		did_score;
	string9		ssn;
	string1		history_flag;
	string100 orig_Reg_Owner_Name_2:=''; 
  end
 ;
