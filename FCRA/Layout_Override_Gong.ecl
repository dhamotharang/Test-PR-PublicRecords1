export Layout_Override_Gong := RECORD
unsigned6 l_did;
boolean 	current_flag;
boolean		business_flag;
string1           listing_type_bus;
string1           listing_type_res;
string1           listing_type_gov;
string1           publish_code;
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
string2           v_predir;
string28          v_prim_name;
string4           v_suffix;
string2           v_postdir;
string25          v_city_name;
string2           st;
string5           z5;
string4           z4;
string5           county_code;
string10          geo_lat;
string11          geo_long;
string4           msa;
string32          designation;
string5           name_prefix;
string20          name_first;
string20          name_middle;
string20          name_last;
string5           name_suffix;
string120         listed_name;
string254         caption_text;
string1			  omit_address;
string1			  omit_phone;
string1			  omit_locality;
string64          see_also_text;
unsigned6 did;
unsigned6 hhid;
unsigned6	bdid;
string8 dt_first_seen;
string8 dt_last_seen;
string1 current_record_flag;  
string8 deletion_date;
unsigned2 disc_cnt6 := 0;
unsigned2 disc_cnt12 := 0;
unsigned2 disc_cnt18 := 0;
unsigned8	persistent_record_id := 0;
string20 flag_file_id;
string2 src;
end;