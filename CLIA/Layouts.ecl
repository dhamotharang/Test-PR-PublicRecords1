IMPORT Address, BIPV2;

EXPORT Layouts := MODULE

	EXPORT Input := RECORD
		STRING10 CLIA_number;
		STRING50 lab_type;
		STRING75 facility_name;
		STRING75 facility_name2;
		STRING55 address1;
		STRING55 address2;
		STRING30 city;
		STRING2  state;
		STRING5  zip;
		STRING4  zip4;
		STRING10 facility_phone;
	END;

  // For a couple of builds, they made the lab type a number and gave us the description in another
	// field... instead of putting the description in the lab type field.
	EXPORT Input_Alt := RECORD
		STRING10  CLIA_number;
		UNSIGNED1 lab_type;
		STRING50  lab_type_description;
		STRING75  facility_name;
		STRING75  facility_name2;
		STRING55  address1;
		STRING55  address2;
		STRING30  city;
		STRING2   state;
		STRING5   zip;
		STRING4   zip4;
		STRING10  facility_phone;
	END;

  // For Nov 2012 build onward, the information is coming from a physical source vs. an electronic one
	// and has a different layout to boot.  Getting codes vs. description text for a couple attributes.
	EXPORT Input_From_CD := RECORD
		STRING10 CLIA_number;
		STRING1  certificate_type_code;
		STRING50 facility_name;
		STRING50 facility_name2;
		STRING50 address1;
		STRING50 address2;
		STRING28 city;
		STRING2  state;
		STRING5  zip;
		STRING4  zip4;
		STRING10 facility_phone;
		STRING8  expiration_date;
		STRING2  lab_type_code;
		STRING2	 lab_term_code;			// added Aug 2013
		STRING2  carriage_return;
	END;
	
	EXPORT Miscellaneous := MODULE
	
		EXPORT Cleaned_Phones := RECORD
			STRING10 Phone;
		END;
		
	END;

	EXPORT Base := RECORD
		BIPV2.IDlayouts.l_xlink_ids;
		Input_From_CD - [carriage_return];
		STRING50  lab_type := '';
		STRING50  certificate_type := '';
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		STRING1   record_type;
		UNSIGNED8 raw_aid;
		UNSIGNED8 ace_aid;
		UNSIGNED6 did;
		UNSIGNED6 bdid;
		UNSIGNED1 bdid_score;
		Address.Layout_Clean182_fips clean_company_address;
		Miscellaneous.Cleaned_Phones clean_phones;
  END;

	// EXPORT KeyBuild := Base;

  // Since there's a Roxie Release freeze, I have to get the key layouts (including autokey payload) to
	// match the old way, until we figure out what's happening.
	EXPORT Temp_Old_Base := RECORD
		Input;
		STRING2		lab_term_code;			// added Aug 2013
		STRING50  certificate_type := '';
		STRING8   expiration_date := '';
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		STRING1   record_type;
		UNSIGNED8 raw_aid;
		UNSIGNED8 ace_aid;
		UNSIGNED6 did;
		UNSIGNED6 bdid;
		UNSIGNED1 bdid_score;
		Address.Layout_Clean182_fips clean_company_address;
		Miscellaneous.Cleaned_Phones clean_phones;
  END;

	EXPORT KeyBuild := RECORD
	  Temp_Old_Base;
	END;

END;
