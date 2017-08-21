Import Address, watercraft_infutor, BIPV2, watercraft;

EXPORT layouts := MODULE

	EXPORT watercraft_infutor_in := RECORD
		STRING15 uid;
		STRING25 pid;
		STRING20 fname;
		STRING1 mname;
		STRING75 lname;
		STRING10 suffix;
		STRING1 gender;
		STRING10 house_nbr;
		STRING2 predir;
		STRING28 street;
		STRING4 street_type;
		STRING2 postdir;
		STRING4 apt_type;
		STRING8 apt_nbr;
		STRING28 city;
		STRING2 state;
		STRING5 zip;
		STRING4 zip4;
		STRING3 dpc;
		STRING4 crte;
		STRING3 cnty;
		STRING1 zip4_type;
		STRING1 dpv;
		STRING1 vacant;
		STRING10 phone;
		STRING1 dnc;
		STRING30 fips_county;
		STRING4 msa;
		STRING5 cbsa;
		STRING8 first_seen_date;
		STRING8 last_seen_date;
		STRING20 internal1;
		STRING10 internal2;
		STRING10 internal3;
		STRING1 est_house_income;
		STRING1 child;
		STRING1 homeowner;
		STRING1 pctw;
		STRING1 pctb;
		STRING1 pcta;
		STRING1 pcth;
		STRING1 pctspe;
		STRING1 pctsps;
		STRING1 pctspa;
		STRING1 median_house_value;
		STRING1 mor;
		STRING1 pctoccw;
		STRING1 pctoccb;
		STRING1 pctocco;
		STRING3 length_of_residence;
		STRING1 sfdu;
		STRING1 mfdu;
		STRING30 make;
		STRING30 model;
		STRING4 year;
		STRING10 boat_length;
		STRING1 boat_size;
		STRING1 boat_type;
		STRING1 boat_use;
		STRING1 boat_fuel;
		STRING1 boat_hull_material;
		STRING1 boat_hull_shape;
		STRING1 boat_propulsion;
	END;
	
	EXPORT	Watercraft_Main_Base := RECORD
		Watercraft.Layout_Watercraft_Main_Base;
		STRING1 hull_shape;
		STRING20 hull_shape_description;
  END;
	
	EXPORT Layout_search_add_ons := RECORD
		STRING1 delivery_point_valid;
		STRING100 delivery_point_desc;
		STRING1 vacant;
		STRING45 vacant_desc;
		STRING1 do_not_call;
		STRING50 do_not_call_desc;
		STRING30 fips_county;
		STRING4 msa;
		STRING5 cbsa;
		STRING20 internal1;
		STRING10 internal2;
		STRING10 internal3;
		STRING1 est_house_income;
		STRING20 est_house_income_desc;
		STRING1 child;
		STRING1 homeowner;
		STRING1 pct_range_white;
		STRING1 pct_range_black;
		STRING1 pct_range_asian;
		STRING1 pct_range_hispanic;
		STRING1 pct_range_speak_english;
		STRING1 pct_range_speak_spanish;
		STRING1 pct_range_speak_asian;
		STRING1 median_house_value;
		STRING20 median_house_value_desc;
		STRING1 pct_range_mail_order;
		STRING1 pct_range_white_collar;
		STRING1 pct_range_blue_collar;
		STRING1 pct_range_other_occupation;
		STRING3 length_of_residence;
		STRING1 pct_range_sfdu;
		STRING1 pct_range_mfdu;
	END;
	
	EXPORT Base_Search	:= RECORD
		Watercraft.Layout_Watercraft_Search_Base;
		Layout_search_add_ons;
	END;
	
	EXPORT layout_CleanFields := RECORD
		string8 filedate := '';
		watercraft_infutor_in;
		STRING100 Clean_Name := '';
		STRING60 ADDRESS1 := '';
		STRING60 ADDRESS2 := '';
		string73 pname1 := '';
		string60 cname1 := '';
		string182	Clean_Address;
	END;
END;