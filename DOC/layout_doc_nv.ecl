export layout_doc_nv := module

export alias := 
record
string offender_id;
string alias_last_name;
string alias_first_name;
string alias_middle_name;
end;
/////////////////////////////////
export booking := 
record
string offender_id;
string offender_book_id;
string charge_seq;
string offense_code;
string offense_desc;
string sent_seq;
string sent_status;
string sent_min_yrs;
string sent_min_mths;
string sent_min_days;
string sent_max_yrs;
string sent_max_mths;
string sent_max_days;
string sent_ped;
string sent_mpr;
string sent_county;
string sent_pexd;
string sent_type;
string sent_rrd;
string sent_start_date;
end;
/////////////////////////////////
export demographic := 
record
string offender_id;
string last_name;
string first_name;
string middle_name;
string agy_loc_id;
string sec_level;
string pri_fel_flag;
string birth_date;
string gender;
string height_feet;
string height_inches;
string weight_pounds;
string _build;
string complexion;
string hair;
string eyes;
string ethnic;
end;
/////////////////////////////////
export release := 
record
string offender_id;	
string offender_book_id;
string release_date;	
string release_desc;
end;

export cmbndFile := 
record
string offender_id;
string alias_last_name;
string alias_first_name;
string alias_middle_name;
string offender_book_id;
string charge_seq;
string offense_code;
string offense_desc;
string sent_seq;
string sent_status;
string sent_min_yrs;
string sent_min_mths;
string sent_min_days;
string sent_max_yrs;
string sent_max_mths;
string sent_max_days;
string sent_ped;
string sent_mpr;
string sent_county;
string sent_pexd;
string sent_type;
string sent_rrd;
string sent_start_date;
string last_name;
string first_name;
string middle_name;
string agy_loc_id;
string sec_level;
string pri_fel_flag;
string birth_date;
string gender;
string height_feet;
string height_inches;
string weight_pounds;
string _build;
string complexion;
string hair;
string eyes;
string ethnic;
string release_date;	
string release_desc;
end;

end;

	
	