IMPORT Address, AID;

EXPORT Layout_WY_Raw := MODULE

  EXPORT Input := RECORD
	  STRING5   dart_id;
		STRING8   date_added;
		STRING8   date_updated;
		STRING50  website;
		STRING2   state;
		STRING100 business_name;
		STRING100 dba;
		STRING20  name_first;
		STRING20  name_middle;
		STRING20  name_last;
		STRING5   name_suffix;
		STRING80  address_line_1;
		STRING80  address_line_2;
		STRING40  address_city;
		STRING2   address_st;
		STRING5   address_zip;
		STRING4   address_z4;
		STRING50  email;
		STRING20  license_number;
		STRING60  license_type;
		STRING8   license_date_from;
		STRING8   license_date_to;
		STRING45  license_status;
  END;

END;