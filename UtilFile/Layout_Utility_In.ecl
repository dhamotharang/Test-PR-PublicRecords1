import address;

export Layout_Utility_In := record
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
	address.Layout_Clean182;
	string12        did;
	string5         title;
	string20        fname;
	string20        mname;
	string20        lname;
	string5         name_suffix;
	string3         name_score;
end;