IMPORT Address, BIPV2;

EXPORT Layouts := MODULE

  EXPORT Input := MODULE

		EXPORT Accountants := RECORD
		  STRING25  fname;
		  STRING35  lname;
		  STRING40  title;
		  STRING60  company;
		  STRING40  address1;
		  STRING40  address2;
		  STRING25  city;
		  STRING2   state;
		  STRING5   zip;
		  STRING4   zip4;
		  STRING4   cart;
		  STRING3   bar;
		  STRING1   gender;
		  STRING22  country;
		  STRING20  postal_cd;
		  STRING1   dpv;
		  STRING15  addr_type;
		  STRING15  county_cd;
		  STRING50  job_code;
		  STRING1   nielsen_county_cd;
		  STRING7   number_of_employees;
		  STRING4   msa;
		  STRING100 source_code;
		  STRING4   company_type;
		  STRING20  phone;
		  STRING132 email;
		  STRING10  list_id;
		  STRING10  scno;
		  STRING35  keycode;
		  STRING16  custno;
		  STRING20  license_no;
		  STRING20  dob;
		  STRING20  orig_date;
		  STRING20  exp_date;
		  STRING20  degree;
		  STRING20  specialty;
		END;

		EXPORT Dental_Professionals := RECORD
		  STRING25  fname;
		  STRING35  lname;
		  STRING40  title;
		  STRING60  company;
		  STRING40  address1;
		  STRING40  address2;
		  STRING25  city;
		  STRING2   state;
		  STRING5   zip;
		  STRING4   zip4;
		  STRING4   cart;
		  STRING3   bar;
		  STRING1   gender;
		  STRING22  country;
		  STRING20  postal_cd;
		  STRING1   dpv;
		  STRING15  addr_type;
		  STRING4   age;
		  STRING15  county_cd;
		  STRING15  orig_date;
		  STRING30  exp_date;
		  STRING50  license_state;
		  STRING254 license_type;
		  STRING4   msa;
		  STRING1   nielsen_county_cd;
		  STRING30  specialty_code;
		  STRING20  phone;
		  STRING132 email;
		  STRING10  list_id;
		  STRING10  scno;
		  STRING35  keycode;
		  STRING16  custno;
		  STRING20  license_no;
		  STRING20  dob;
		  STRING20  specialty;
		  STRING20  degree;
		END;

		EXPORT Insurance_Agents := RECORD
		  STRING25 fname;
		  STRING35 lname;
		  STRING40 title;
		  STRING60 company;
		  STRING40 address1;
		  STRING40 address2;
		  STRING25 city;
		  STRING2  state;
		  STRING5  zip;
		  STRING4  zip4;
		  STRING4  cart;
		  STRING3  bar;
		  STRING1  gender;
		  STRING22 country;
		  STRING20 postal_cd;
		  STRING1  dpv;
		  STRING15 addr_type;
		  STRING15 county_cd;
			STRING50 insurance_type;
			STRING4  license_type;
		  STRING4  msa;
		  STRING1  nielsen_county_cd;
		  STRING10 list_id;
		  STRING10 scno;
		  STRING35 keycode;
		  STRING16 custno;
		END;

		EXPORT Lawyers := RECORD
		  STRING25  fname;
		  STRING35  lname;
		  STRING40  title;
		  STRING60  company;
		  STRING40  address1;
		  STRING40  address2;
		  STRING25  city;
		  STRING2   state;
		  STRING5   zip;
		  STRING4   zip4;
		  STRING4   cart;
		  STRING3   bar;
		  STRING1   gender;
		  STRING22  country;
		  STRING20  postal_cd;
		  STRING1   dpv;
		  STRING15  addr_type;
			// 7/1 took this out
			// STRING4   age;
			STRING15  business_ind;
		  STRING15  county_cd;
		  STRING4   msa;
		  STRING1   nielsen_county_cd;
		  STRING10  number_of_lawyers_range;
		  STRING254 practice_area;
		  STRING50  title_cd;
		  STRING20  phone;
		  STRING10  list_id;
		  STRING10  scno;
		  STRING35  keycode;
		  STRING16  custno;
		END;

		EXPORT Nurses := RECORD
		  STRING25  fname;
		  STRING35  lname;
		  STRING40  title;
		  STRING60  company;
		  STRING40  address1;
		  STRING40  address2;
		  STRING25  city;
		  STRING2   state;
		  STRING5   zip;
		  STRING4   zip4;
		  STRING4   cart;
		  STRING3   bar;
		  STRING1   gender;
		  STRING22  country;
		  STRING20  postal_cd;
		  STRING1   dpv;
		  STRING15  addr_type;
		  STRING4   age;
		  STRING15  county_cd;
		  STRING1   household_income;
		  STRING1   marital_status;
		  STRING4   msa;
		  STRING1   nielsen_county_cd;
		  STRING80  nurse_type;
		  STRING120 reg_state;
		  STRING50  specialty;
		  STRING132 email;
		  STRING20  phone;
		  STRING10  list_id;
		  STRING10  scno;
		  STRING35  keycode;
		  STRING16  custno;
		  STRING20  license_no;
		  STRING20  dob;
		  STRING20  orig_date;
		  STRING20  exp_date;
		  STRING20  degree;
		END;


		
		EXPORT Nurses4 := RECORD
			STRING25 		fname;
			STRING35 		lname;
			STRING40		title;
			STRING60		company;
			STRING40		address;
			STRING40		address2;
			STRING25		city;
			STRING2			state;
			STRING5			zip;
			STRING4			zip4;
			STRING4			cart;
			STRING3			bar;
			STRING1			flag;  
			STRING22		country;
			STRING20		postal_cd;
			STRING1			dpv;
			STRING15		addrtype;
			STRING4			age;
			STRING15		county_cd;
			STRING1			income;
			STRING1			marital;
			STRING4			msa;
			STRING1			nielsen;
			STRING80		nursetype;
			STRING10		licstate;
			STRING50		nursespec;
			STRING132		email;
			STRING20		phone;
			STRING10		listid;
			STRING10		scno;
			STRING35		keycode;
			STRING16		custno;
			STRING20		lic_no;
			STRING20		dob;
			STRING20		origdate;
			STRING20		expdate;
			STRING20		degree;
		END;

		EXPORT Pharmacists := RECORD
		  STRING25  fname;
		  STRING35  lname;
		  STRING40  title;
		  STRING60  company;
		  STRING40  address1;
		  STRING40  address2;
		  STRING25  city;
		  STRING2   state;
		  STRING5   zip;
		  STRING4   zip4;
		  STRING4   cart;
		  STRING3   bar;
		  STRING1   gender;
		  STRING22  country;
		  STRING20  postal_cd;
		  STRING1   dpv;
		  STRING15  addr_type;
		  STRING4   age;
		  STRING15  county_cd;
		  STRING15  orig_date;
		  STRING30  exp_date;
		  STRING1   fax;
		  STRING50  license_state;
		  STRING30  license_type;
		  STRING4   msa;
		  STRING1   nielsen_county_cd;
		  STRING132 email;
		  STRING10  list_id;
		  STRING10  scno;
		  STRING35  keycode;
		  STRING16  custno;
		  STRING20  license_no;
		  STRING20  dob;
		  STRING20  degree;
		  STRING20  specialty;
		  STRING20  phone;
		END;

		EXPORT Pilots := RECORD
		  STRING25  fname;
		  STRING35  lname;
		  STRING40  title;
		  STRING60  company;
		  STRING40  address1;
		  STRING40  address2;
		  STRING25  city;
		  STRING2   state;
		  STRING5   zip;
		  STRING4   zip4;
		  STRING4   cart;
		  STRING3   bar;
		  STRING1   gender;
		  STRING22  country;
		  STRING20  postal_cd;
		  STRING1   dpv;
		  STRING15  addr_type;
		  STRING254 cert_lvl;
		  STRING50  cert_type;
		  STRING1   nielsen_county_cd;
		  STRING80  rating;
		  STRING4   msa;
		  STRING20  phone;
		  STRING120 cert_type_secondary;
		  STRING15  county_cd;
		  STRING10  list_id;
		  STRING10  scno;
		  STRING35  keycode;
		  STRING16  custno;
		END;

		EXPORT Professionals := RECORD
		  STRING25  fname;
		  STRING35  lname;
		  STRING40  title;
		  STRING60  company;
		  STRING40  address1;
		  STRING40  address2;
		  STRING25  city;
		  STRING2   state;
		  STRING5   zip;
		  STRING4   zip4;
		  STRING4   cart;
		  STRING3   bar;
		  STRING1   gender;
		  STRING22  country;
		  STRING20  postal_cd;
		  STRING1   dpv;
		  STRING15  addr_type;
		  STRING15  county_cd;
		  STRING15  license_class;
		  STRING50  license_state;
		  STRING254 license_type;
		  STRING4   msa;
		  STRING1   nielsen_county_cd;
		  STRING20  phone;
		  STRING132 email;
		  STRING10  list_id;
		  STRING10  scno;
		  STRING35  keycode;
		  STRING16  custno;
		  STRING20  license_no;
		  STRING20  dob;
		  STRING20  orig_date;
		  STRING20  exp_date;
		  STRING20  degree;
		  STRING20  specialty;
		END;

	END;

  EXPORT Base := RECORD
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		UNSIGNED4 dt_first_seen;
		UNSIGNED4 dt_last_seen;
		STRING25  fname;
		STRING35  lname;
		STRING40  title;
		STRING60  company;
		STRING40  address1;
		STRING40  address2;
		STRING25  city;
		STRING2   state;
		STRING5   zip;
		STRING4   zip4;
		STRING4   cart;
		STRING3   bar;
		STRING1   gender;
		STRING22  country;
		STRING20  postal_cd;
		STRING1   dpv;
		STRING15  addr_type;
		STRING15  county_cd;
		STRING1   nielsen_county_cd;
		STRING4   msa;
		STRING10  list_id;
		STRING10  scno;
		STRING35  keycode;
		STRING16  custno;
		STRING10  phone;
		STRING10  fax;
		STRING60  email;

		STRING20  license_no;
		STRING20  dob;
		STRING4   age;
		STRING20  orig_date;
		STRING20  exp_date;
		STRING20  degree;
		// Nurses specialty contains 1->M codes, unlike everyone else.
		STRING50  specialty;
		STRING50  license_state;
		STRING255 license_type;

		// accountants
		STRING50  job_code;
		STRING7   number_of_employees;
		STRING100 source_code;
		STRING4   company_type;

		// dental professionals
		STRING30  specialty_code;

		// insurance agents
		STRING50  insurance_type;

		// lawyers
		STRING15  business_ind;
		STRING10  number_of_lawyers_range;
		STRING255 practice_area;
		STRING25  title_cd;

		// nurses
		STRING1   household_income;
		STRING1   marital_status;
		STRING80  nurse_type; // this field is basically license_type for nurses
		STRING120 reg_state;

		// pilots
		STRING255 cert_lvl;
		STRING50  cert_type;
		STRING120 cert_type_secondary;
		STRING80  rating;

		// professionals
		STRING15  license_class;

		// clean/description fields
		STRING1   clean_gender;
		STRING10  clean_phone;
		STRING10  clean_fax;
		STRING8   clean_dob;
		STRING8   clean_orig_date;
		STRING8   clean_exp_date;
		STRING25  alc_prof_type;                     // Tells you if the record is a NURSE, PILOT, etc.
		STRING50  job_code_desc;                     // accountants only
		STRING150 specialty_code_desc;               // dental professionals only
		STRING5   specialty_code_singular;           // dental professionals only
		STRING50  specialty_code_singular_desc;      // dental professionals only
		STRING200 insurance_type_desc;               // insurance agents only
		STRING5   insurance_type_singular;           // insurance agents only
		STRING50  insurance_type_singular_desc;      // insurance agents only
		STRING150 practice_area_desc;                // lawyers only
		STRING5   practice_area_singular;            // lawyers only
		STRING50  practice_area_singular_desc;       // lawyers only
		STRING100 title_cd_desc;                     // lawyers only
		STRING150 cert_lvl_desc;                     // pilots only
		STRING5   cert_lvl_singular;                 // pilots only
		STRING50  cert_lvl_singular_desc;            // pilots only
		STRING150 cert_type_desc;                    // pilots only
		STRING5   cert_type_singular;                // pilots only
		STRING50  cert_type_singular_desc;           // pilots only
		STRING510 cert_type_secondary_desc;          // pilots only
		STRING5   cert_type_secondary_singular;      // pilots only
		STRING50  cert_type_secondary_singular_desc; // pilots only
		STRING500 rating_desc;                       // pilots only
		STRING5   rating_singular;                   // pilots only
		STRING50  rating_singular_desc;              // pilots only
		STRING50  license_class_desc;                // professionals only
		STRING50  license_class_singular;            // professionals only
		STRING50  license_class_singular_desc;       // professionals only
		STRING200 license_type_desc;
		STRING5   license_type_singular;
		STRING50  license_type_singular_desc;
		STRING200 specialty_desc;
		STRING5   specialty_singular;                // nurses only
		STRING50  specialty_singular_desc;           // nurses only
		STRING2   reg_state_singular;                // nurses only
		
		UNSIGNED8 raw_aid;
		UNSIGNED8 ace_aid;
		UNSIGNED6 did;
		UNSIGNED6 bdid;
		UNSIGNED8 lnpid;
		Address.Layout_Clean182_fips clean_address;
		Address.Layout_Clean_Name    clean_name;
		BIPV2.IDlayouts.l_xlink_ids;
		STRING    src;
		UNSIGNED8 source_rec_id;
  END;

  EXPORT Base_Plus := RECORD
	  Base;
		UNSIGNED1 license_type_count;
		UNSIGNED1 license_class_count;
		UNSIGNED1 specialty_code_count;
		UNSIGNED1 specialty_count;
		UNSIGNED1 reg_state_count;
		UNSIGNED1 practice_area_count;
		UNSIGNED1 cert_lvl_count;
		UNSIGNED1 cert_type_count;
		UNSIGNED1 cert_type_secondary_count;
		UNSIGNED1 rating_count;
		UNSIGNED1 insurance_type_count;
	END;

END;
