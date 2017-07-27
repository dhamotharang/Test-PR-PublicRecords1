export Layout_bscurrent_raw := 
record
string18 		  seisintid:=''; //New
string3 		  bell_id:='';
string11 		  filedate:='';
string1 	      dual_name_flag:='';
unsigned integer8 sequence_number:=0;
string1           listing_type_bus;
string1           listing_type_res;
string1           listing_type_gov;
string1           publish_code;
string1           style_code;
string1           indent_code;
string20          book_neighborhood_code; // this will not be populated in v2 history.  LSSI does not provide this information.
string3           prior_area_code;
string10          phone10; 
string10          prim_range;
string2           predir;
string28          prim_name;
string4           suffix;
string2           postdir;
string10          unit_desig;
string8           sec_range;
string25          p_city_name;
string2           v_predir; // this will not be populated in v2 history.  Thor address cleaning utility does not provide vanity info other than vanity city.
string28          v_prim_name; // this will not be populated in v2 history.  Thor address cleaning utility does not provide vanity info other than vanity city.
string4           v_suffix; // this will not be populated in v2 history.  Thor address cleaning utility does not provide vanity info other than vanity city.
string2           v_postdir; // this will not be populated in v2 history.  Thor address cleaning utility does not provide vanity info other than vanity city.
string25          v_city_name;
string2           st;
string5           z5;
string4           z4;
string4           cart;
string1           cr_sort_sz;
string4           lot;
string1           lot_order;
string2           dpbc;
string1           chk_digit;
string2           rec_type;
string5           county_code;
string10          geo_lat;
string11          geo_long;
string4           msa;
string7           geo_blk;
string1           geo_match;
string4           err_stat;
string32          designation;
string5           name_prefix;
string20          name_first;
string20          name_middle;
string20          name_last;
string5           name_suffix;
string120         listed_name;
string254         caption_text;
string10          group_id;			//RT added 12/27/01
string10          group_seq;		//RT added 12/27/01
string1			  omit_address;
string1			  omit_phone;
string1			  omit_locality;
string1			  privacy_flag;
string64          see_also_text;	//RT added 12/27/01 same as special_listing_text
unsigned6 		  did;
unsigned6 		  hhid;
unsigned6		  bdid;
string8 		  dt_first_seen;
string8 		  dt_last_seen;
string1 		  current_record_flag;  
string8 		  deletion_date;
unsigned2 		  disc_cnt6 := 0;
unsigned2 		  disc_cnt12 := 0;
unsigned2 		  disc_cnt18 := 0;
end;