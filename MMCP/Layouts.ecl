IMPORT Address;

EXPORT Layouts := MODULE

  EXPORT Input := MODULE

		EXPORT License_Status := RECORD
			STRING10 license_number;
			STRING2  bull_license_type;
			STRING3  sec_license_status;
			STRING8  license_status_date;
			STRING8  expiration_date;
			STRING7  audit_number;
			STRING2  filler1;
			STRING20 bull_specialty;
			STRING10 filler2;
			STRING10 filler3;
			STRING1  carriage_return;
		END;

		EXPORT Licensee := RECORD
			STRING10 license_number;
			STRING3  name_prefix;
			STRING20 name_first_middle;
			STRING40 name_last;
			STRING3  name_suffix;
			STRING25 address1;
			STRING25 address2;
			STRING25 address3;
			STRING23 city;
			STRING2  state;
			STRING10 full_zip;
			STRING8  dob;
			STRING2  license_mask;
			STRING2  county_code;
			STRING11 ssn;
			STRING40 full_name;
			STRING11 dea_number;
			STRING8  issue_date;
			STRING1  carriage_return;
		END;

		EXPORT IL_License := RECORD
			STRING9   license_number;
			STRING20  first_name;
			STRING20  middle_name;
			STRING40  last_name;
			STRING65  corp_name;
			STRING3   prefix;             // always blank
			STRING3   suffix;
			STRING20  specialty;          // always blank
			STRING15  license_status;
			STRING2   license_type;       // vendor defaults to R
			STRING20  city;
			STRING2   state;
			STRING2   county_code;        // always blank
			STRING10  zip;
			STRING40  addr_atten_line;
			STRING40  addr_ln_1;
			STRING40  addr_ln_2;
			STRING40  addr_ln_3;          // always blank
			STRING1   discipline_ind;
			STRING9   ssn_fein;           // only last 4 will be sent
			STRING8   issue_date;         // in MMDDYYYY format
			STRING8   dob;                // in MMDDYYYY format
			STRING8   last_update_date;   // in MMDDYYYY format
			STRING8   expiration_date;    // in MMDDYYYY format
			STRING8   status_change_date; // in MMDDYYYY format
			STRING100 filler1;
			STRING100 filler2;
			STRING100 filler3;
			STRING100 filler4;
			STRING100 filler5;
			STRING1   carriage_return;
		END;

	END;

	EXPORT Base := RECORD
		STRING10  license_number;
	  UNSIGNED4 customer_id;
		STRING2   bull_license_type;
		STRING3   sec_license_status;
		STRING15  license_status;     // added
		STRING8   license_status_date;
		STRING8   expiration_date;
		STRING7   audit_number;
		STRING20  bull_specialty;
		STRING2   license_mask;
		STRING8   issue_date;
		STRING9   dea_number;
		STRING1   discipline_ind;     // added
		STRING8   last_update_date;   // added
		STRING8   status_change_date; // added
		STRING3   name_prefix;
		STRING40  name_first_middle;  // adjusted for IL use
		STRING20  name_first;
		STRING20  name_middle;
		STRING40  name_last;
		STRING5   name_suffix;
		STRING83  full_name;          // adjusted for IL use
		STRING8   dob;
		STRING9   ssn;
		STRING65  company_name;       // adjusted for IL use
		STRING40  address1;           // adjusted for IL use
		STRING40  address2;           // adjusted for IL use
		STRING40  address3;           // adjusted for IL use
		STRING23  city;
		STRING2   state;
		STRING9   full_zip;
		STRING2   county_code;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		STRING1   record_type;
		UNSIGNED8 raw_aid;
		UNSIGNED8 ace_aid;
		UNSIGNED6 did;
		UNSIGNED6 bdid;
		UNSIGNED1 bdid_score;
		Address.Layout_Clean182_fips clean_company_address;
    Address.Layout_Clean_Name    clean_name;
		STRING    license_board_code_desc;
		STRING    bull_lic_type_desc;
		STRING    license_status_desc;
  END;

END;
