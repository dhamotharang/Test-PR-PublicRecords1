IMPORT SexOffender, PRTE2_SexOffender;

EXPORT Layouts := MODULE

	EXPORT Offender_in := RECORD //same layout for input and base file output
		SexOffender.Layout_Out_Main;
		INTEGER4 	lat;
		INTEGER4 	long;
		STRING20	cust_name;
		STRING10	bug_num;
		STRING9		link_ssn;
		STRING8		link_dob;
	END;
	
	EXPORT Offense_in	:= RECORD //same layout for input and base file output
		SexOffender.Layout_common_offense_new;
		STRING20	cust_name;
		STRING10	bug_num;
	END;
	
	EXPORT SexOffender_out := RECORD //lat/long used in FDID key
		SexOffender.Layout_Out_Main;
		INTEGER4 lat;
		INTEGER4 long;
	END;
	
	 //Base layouts used for Keys minus bug_num, cust_name
	EXPORT SexOffender_base := RECORD
		SexOffender.Layout_Out_Main;
	END;
	
	EXPORT SexOffense_base	:= RECORD 
		SexOffender.Layout_common_offense_new;
	END;
	
	EXPORT lOffenseKey	:= RECORD
		string60 sspk;
		string60 seisint_primary_key;
		string80 conviction_jurisdiction;
		string8 conviction_date;
		string30 court;
		string25 court_case_number;
		string8 offense_date;
		string20 offense_code_or_statute;
		string320 offense_description;
		string180 offense_description_2;
		unsigned8 offense_category; //New field for above layout
		string1 victim_minor;
		string3 victim_age;
		string10 victim_gender;
		string30 victim_relationship;
		string180 sentence_description;
		string180 sentence_description_2;
		string8 arrest_date;
		string250 arrest_warrant;
		string1 fcra_conviction_flag;
		string1 fcra_traffic_flag;
		string8 fcra_date;
		string1 fcra_date_type;
		string8 conviction_override_date;
		string1 conviction_override_date_type;
		string2 offense_score;
		unsigned8 offense_persistent_id;
	END;

	//Using existing ENH input file for historical records
	EXPORT lENHPublic := RECORD 
		STRING60 sspk;
		STRING60 seisint_primary_key;
		STRING1 alt_type;
		STRING10 alt_prim_range;
		STRING2 alt_predir;
		STRING28 alt_prim_name;
		STRING4 alt_suffix;
		STRING2 alt_postdir;
		STRING10 alt_unit_desig;
		STRING8 alt_sec_range;
		STRING25 alt_city_name;
		STRING2 alt_st;
		STRING5 alt_zip;
		STRING4 alt_zip4;
		UNSIGNED3 alt_addr_dt_first_seen;
		UNSIGNED3 alt_addr_dt_last_seen;
		UNSIGNED1 alt_glb;
		UNSIGNED1 alt_dppa;
		STRING2 src;
		BOOLEAN ismismatched;
		UNSIGNED8 __internal_fpos__;
	END;
	
	//Layout used for the ENH key and ENH Autokeys
	EXPORT AltLayout := RECORD
			UNSIGNED6 alt_did;
			sexoffender.layout_out_main;
			sexoffender.layout_in_alt;
		END;

	// A record with all the fields needed to build the autokeys
	EXPORT ak_rec := RECORD
    STRING60  seisint_primary_key;
		UNSIGNED8 did;
		STRING9	  ssn;
		STRING30  lname;
		STRING30  fname;
		STRING20  mname;
		STRING8   dob;
    STRING10  prim_range;
    STRING28  prim_name;
    STRING8   sec_range;
    STRING25  city_name;
    STRING2   st;
		STRING2   orig_state_code;
    STRING5   zip5;
		QSTRING10 geo_lat;
		QSTRING11 geo_long;
		QSTRING1  geo_match;
		UNSIGNED1 zero  := 0;
		STRING1   blank := '';
	END;
	
END;