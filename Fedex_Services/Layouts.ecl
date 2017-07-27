import standard;

export Layouts := 
MODULE

export lname_rec := {string25 lname};

export out := record
	unsigned6 did;
	unsigned6 bdid;
	unsigned2 penalt := 0;
	string5 internal_src;
	boolean isFedexRecord := false;
	boolean isDeliverableAddress := true;
	string12 address_type;
	unsigned2 resident_confidence := 0; //?? do we want ??
	unsigned4 dt_last_seen;
	boolean exact_lname_match;
	boolean leading_lname_match;
	string10 phone;
	string25 fname;
	string25 mname;
	string25 lname;
	string120 company_name;
	standard.Addr - [addr_rec_type,fips_state,fips_county,geo_lat,geo_long,cbsa,geo_blk,geo_match,zip5];
	string6 zip5;
	string6 PostalCode;
	string20 st_decode := '';
	unsigned3 st_result_count := 0;
	string2 country;
	boolean address_college_ind := false;
	boolean address_mail_drop_ind := false;
	string1 address_location_type := '';
	string3 address_dwelling_type := '';
	string20 record_id := '';
end;


END;