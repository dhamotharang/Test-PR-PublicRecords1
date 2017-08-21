export Layout_Util_canadian_base := record
	string15        id;
	string10        exchange_serial_number;
	string8         date_added_to_exchange;
	string8         connect_date;
	string8         date_first_seen;
	string8         record_date;
	string10        util_type;
	string25        orig_lname;
	string20        orig_fname;
	string20        orig_mname;
	string5         orig_name_suffix;
	string1         addr_type;
	string1         addr_dual;
	string10        address_street;
	string100       address_street_Name;
	string5         address_street_Type;
	string2         address_street_direction;
	string10        address_apartment;
	string20        address_city;
	string2         address_state;
	string10        address_zip;
	string9         ssn;
	string10        work_phone;
	string10        phone;
	string8         dob;
	string2         drivers_license_state_code;
	string22        drivers_license;
	string1					csa_indicator := '';
string10        prim_range; 	// [1..10]
string2         predir;		// [11..12]
string28        prim_name;	// [13..40]
string4         addr_suffix;  // [41..44]
string10        unit_desig;	// [45..54]
string8         sec_range;	// [55..62]
string25        p_city_name;	// [63..92]
string2         st;			// [93..94]
string6         zip;		// [95..100]
string2         rec_type;	// [101..102]
string1         language;		// [103]
string4         err_stat;	// [104..109]
string12        did;
	string5         title;
	string20        fname;
	string20        mname;
	string20        lname;
	string5         name_suffix;
	string3         name_score;
end;