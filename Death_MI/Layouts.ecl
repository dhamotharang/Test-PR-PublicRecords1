IMPORT Address;

EXPORT Layouts := MODULE

  EXPORT Input := MODULE

		EXPORT Death := RECORD
			STRING6  fileno;
			STRING2  occurrence_state;
			STRING2  occurrence_county;
			STRING4  occurrence_civil_division;
			STRING2  residence_state;
			STRING2  residence_county;
			STRING4  residence_civil_division;
			STRING15 lname;
			STRING10 fname;
			STRING10 mname;
			STRING1  alias_code;
			STRING4  dod_year;
			STRING2  dod_month;
			STRING2  dod_day;
			STRING4  dob_year;
			STRING2  dob_month;
			STRING2  dob_day;
			STRING1  decedent_sex;
			STRING9  ssn; // Even though declared as a full ssn, they are only ever sending us the last 4.
			STRING25 address;
			STRING15 city;
			STRING2  state;
			STRING15 father_surname;
			STRING1  lf;
		END;

		EXPORT Death_IL := RECORD
			STRING6  fileno;
			STRING2  occurrence_state;
			STRING2  occurrence_county;
			STRING4  occurrence_civil_division;
			STRING2  residence_state;
			STRING2  residence_county;
			STRING4  residence_civil_division;
			STRING30 lname;
			STRING30 fname;
			STRING10 mname;
			STRING1  alias_code;
			STRING4  dod_year;
			STRING2  dod_month;
			STRING2  dod_day;
			STRING4  dob_year;
			STRING2  dob_month;
			STRING2  dob_day;
			STRING1  decedent_sex;
			STRING9  ssn; // Even though declared as a full ssn, they are only ever sending us the last 4.
			STRING25 address;
			STRING15 city;
			STRING2  state;
			STRING15 father_surname;
			STRING1  lf;
		END;

	END;

  // (1/8/15 - Because IL has bigger name fields, the base and keys change in size (RR situation))
	EXPORT Base := RECORD
	  UNSIGNED4 customer_id;
		// Taking the 2-digit county codes and translating it.
		Input.Death_IL - [occurrence_county, residence_county, lf];
		STRING15  occurrence_county;
		STRING15  residence_county;
		STRING8   dob;
		STRING8   dod;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		UNSIGNED8 raw_aid;
		UNSIGNED8 ace_aid;
		UNSIGNED6 did;
		UNSIGNED6 bdid;
		Address.Layout_Clean182_fips clean_address;
   Address.Layout_Clean_Name    clean_name;
		//DF-24493 Add 2 new fields for CCPA
		unsigned4 global_sid;
		unsigned8 record_sid;
  END;

END;
