
Export layouts := Module 

// layout for aka_File  /////////////////////////////////////
Export aka_file_layout := RECORD
	unsigned6 LexID;
	string    first;
	string    middle;
	string    last;
	string    suffix;
END;


// layouts for hist_address_file
Export hist_address_layout := Record 
	unsigned6 LexID;
	string    prim_range;
    string    predir;
    string    prim_name;
    string    address_suffix;
    string    postdir;
    string    unit_desig;
    string    sec_range;
    string    city; 
    string    state;
    string    zip;
	unsigned3 date_first_seen;
	unsigned3 date_last_seen;
	unsigned3 dt_vendor_first_reported;
	unsigned3 dt_vendor_last_reported;
End;

Export address_output_layout := Record 
	unsigned6 LexID;
	string    line1;
	string    line2;
	unsigned3 date_first_seen;
	unsigned3 date_last_seen;
	unsigned3 dt_vendor_first_reported;
	unsigned3 dt_vendor_last_reported;
End;

// layouts for best_file
Export layout_infutor_best := Record 
	unsigned6 LexID;
	string    first;
	string    middle;
	string    last;
	string    suffix;
	string    prim_range;
    string    predir;
    string    prim_name;
    string    address_suffix;
    string    postdir;
    string    unit_desig;
    string    sec_range;
    string    city; 
    string    state;
    string    zip;
	unsigned3 date_first_seen;
	unsigned3 date_last_seen;
	unsigned4 dob;
	string    phone;
End;

Export best_file_output := Record 
	unsigned6 LexID;
	string    first;
	string    middle;
	string    last;
	string    suffix;
	string    line1;
	string    line2;
	unsigned3 date_first_seen;
	unsigned3 date_last_seen;
	unsigned4 dob;
	string    phone;
End;

Export layout_watchdog := Record 
	unsigned6 LexID;
	string    first;
	string    middle;
	string    last;
	string    suffix;
	string    prim_range;
    string    predir;
    string    prim_name;
    string    address_suffix;
    string    postdir;
    string    unit_desig;
    string    sec_range;
    string    city; 
    string    state;
    string    zip;
	unsigned4 dob;
	string    phone;
	string    lexid_class;
End;

// layouts for stat file
Export layout_watchdogvsbest := RECORD
	unsigned6 LexID;
	string    first;
	string    middle;
	string    last;
	string    suffix;
	string    line1;
	string    line2;
	string    city; 
    string    state;
    string    zip;
	unsigned4 dob;
	string    phone;
	string    lexid_class;
END;

Export matching_wd_layout := Record
    unsigned6 lexid;
    string1   first_match;
	string1   middle_match;
    string1   last_match;
	string1   suffix_match;
    string1   line1_match;
	string1   line2_match;
	string1   city_match;
	string1   state_match;
	string1   zip_match;	
	string1   dob_match;
    string1   phone_match;
End;


End;