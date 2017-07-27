export layout_phonesplus_reverse_batch_out := record
		string20   acctno;
    unsigned2  penalt;
    string1    typeFlag;  // N, D or G
    string15   did;
	  string120  listed_name;
    string10   phone;
    string30   Carrier_Name;  //Original Carrier Name?  e.g. Sprint	
    string3    COCType;
	  string20   COCDescription;	
	  string4    SSC;
	  string20   SSCDescription;		
		string5    title;
		string20   fname;
		string20   mname;
		string20   lname;
		string5    name_suffix;
		string10   prim_range;
		string2    predir;
		string28   prim_name;
		string4    suffix;
		string2    postdir;
		string10   unit_desig;
		string8    sec_range;
		string25   city_name;
		string2    st;
		string5    zip;
		string4    zip4;
		string1    listing_type_bus;
		string1    listing_type_res;
		string1    listing_type_gov;	
		string254  caption_text;
		string1    dial_indicator;     
		string50   phone_region_city;  
		string2    phone_region_st;    
		string1    telcordia_only;
		string2    vendor_id;
		string25	  append_phone_type:= '';
		string1    activeflag;
		STRING2    TargusType := '';
		boolean    confirmed_flag := false;
	  unsigned2  ConfidenceScore;
    unsigned4  cell_type := 1; 
    string30   new_type := '';
    string120  listed_name_targus; 
   	string4    timezone;
    string8    dt_first_seen;
    string8    dt_last_seen;
    boolean    vendor_dt_last_seen_used;
end;