export Layout_VehicleContacts := 
RECORD
	// record info
	unsigned4 seq_no;
	string5 rec_source;
	string2 orig_state;
	string1 record_type;
	
	// vehicle-specific data
	qstring8		LH_lein_date;
	qstring1        customer_type;
	qstring10       customer_number;
		
	qstring1        sex;
	qstring1        sexual_predator_flag;
	qstring1        mail_suppresion_flag;
	qstring1        addr_non_disclosure_flag;
	qstring1        law_enforcement_flag;
	
	// raw name, address, ssn
	qstring68       orig_name;
	qstring10       address_number;
	qstring1        foreign_address_flag;
	qstring61       orig_street_address;
	qstring5        orig_apartment_number;
	qstring34       orig_addr_city;
	qstring2        orig_addr_state;
	qstring11       zip5_zip4_foreign_postal;
	qstring3        orig_residence_county;
	qstring9 		feid_ssn;
	
	qstring13 		drivers_license_number;
	qstring12       dealer_license_number;
	// date info
	unsigned3 		dt_first_seen;
	unsigned3 		dt_last_seen;
	STRING8 		registration_expiration_date;
	STRING8 		title_issue_date;
	// header-type info
	unsigned6 		DID;
	unsigned6			bdid;
	string9 		ssn;
	string8 		dob;
	string8			best_dob := '';
	// name info
	qstring5  		title;
	qstring20 		fname;
	qstring20 		mname;
	qstring20 		lname;
	qstring5 		name_suffix;
	qstring53		company_name;
	// address
	qstring10 		prim_range;
	qstring2 		predir;
	qstring28 		prim_name;
	qstring4 		addr_suffix;
	qstring2 		postdir;
	qstring10 		unit_desig;
	qstring8 		sec_range;
	qstring25 		p_city_name;
	qstring25 		v_city_name;
    qstring2 		st;
	qstring5 		zip5;
	qstring4 		zip4;
	qstring3		county;
	string18		county_name := '';
	qstring10		geo_lat;
	qstring11		geo_long;
end;