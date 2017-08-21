import drivers;


extract_Layout_DL := record
//string12                     did:= 0 ;
//string12                     Preglb_did:= 0 ;
string8                     	dt_first_seen;
string8                    		 dt_last_seen;
string8                     	dt_vendor_first_reported;
string8                     	 dt_vendor_last_reported;
string2                       orig_state;
string2						  source_code	:=	'AD';
string1                       history :='';
string52                      name;
string40                      addr1;  // chgd, 30 to 40, 20030325,New Mexico, TK
string20                      city;
string2                       state;
string5                       zip;
string8                      dob;
string1                       race := '';
string1                       sex_flag := '';
string4                      license_type;	  // chgd, 2 to 4, 20030514, Wisconsin, TK
string14                      attention_flag := '';
string8                       dod := '';
string42                       restrictions := '';
string42						restrictions_delimited := '';
string8                      orig_expiration_date := '';
string8                      orig_issue_date := '';
string8                      lic_issue_date := '';
string8               	   expiration_date := '';
string8                      active_date := '';
string8                      inactive_date := '';
string10                       lic_endorsement := '';
string4                       motorcycle_code := '';
string14                      dl_number;  // chgd, 13 to 14, 20030325,New Mexico, TK
//string9                       ssn := '';
//string9                       ssn_safe := '';
string3                       age := '';
string1						  privacy_flag := '';
string1					      driver_edu_code := '';
string1                       dup_lic_count:= '';
string1                       rcd_stat_flag:= '';
string3                       height := '';
string3					  hair_color:= '';
string3					  eye_color:= '';
string3					  weight := '';
string25                      oos_previous_dl_number := '';
string2                       oos_previous_st := '';
string5                       title;
string20                      fname;
string20                      mname;
string20                      lname;
string5                       name_suffix;
string3                       cleaning_score;
//string1                       addr_fix_flag := '';
//string10                      prim_range;
//string2                       predir;
//string28                      prim_name;
//string4                       suffix;
//string2                       postdir;
//string10                      unit_desig;
//string8                       sec_range;
//string25                      p_city_name;
//string25                      v_city_name;
//string2                       st;
//string5                       zip5;
//string4                       zip4;
//string4                       cart;
//string1                       cr_sort_sz;
//string4                       lot;
//string1                       lot_order;
//string2                       dpbc := '';
//string1                       chk_digit;
//string2                       rec_type;
//string2                       ace_fips_st := '';
//string3                       county;
//string10                      geo_lat;
//string11                      geo_long;
//string4                       msa := '';
//string7                       geo_blk;
//string1                       geo_match;
//string4                       err_stat;
string1                status := '';
string2                issuance;
string8                address_change := '';
string1                name_change := '';
string1                dob_change := '';
string1                sex_change := '';
string14               old_dl_number := ''; // chgd, 13 to 14, 20030325,New Mexico, TK
string9				   dl_key_number:= '';
end;


previous_misc_dl_file_in  := dataset('~thor_data400::misc::dl_extract_20060719',extract_layout_dl,flat);
previous_misc_dl_file := distribute(previous_misc_dl_file_in(dl_number<>''),hash(dl_number));

new_raw_file_in := drivers.File_Dl(dl_number<>'');
new_raw_file := distribute(new_raw_file_in,hash((string) dl_number));

drivers.layout_dl join_to_refresh(new_raw_file l,previous_misc_dl_file r) := transform
self := l;
end;

refresh_data := join(new_raw_file,previous_misc_dl_file, left.dl_number=right.dl_number and left.orig_state=right.orig_state, join_to_refresh(left,right),local);

dl_extract := dedup(distribute(refresh_data, hash(dl_number)), all,local);

extract_layout_dl in_to_extract(dl_extract l) := transform
self.dt_first_seen := if(l.dt_first_seen<>0,(string8)l.dt_first_seen,'');
self.dt_last_seen := if(l.dt_last_seen<>0,(string8)l.dt_last_seen,'');
self.dt_vendor_first_reported := if(l.dt_vendor_first_reported<>0,(string8)l.dt_vendor_first_reported,'');
self.dt_vendor_last_reported := if(l.dt_vendor_last_reported<>0,(string8)l.dt_vendor_last_reported,'');
self.dob := if(l.dob<>0,(string8)l.dob,'');
self.orig_expiration_date := if(l.orig_expiration_date<>0,(string8)l.orig_expiration_date,'');
self.orig_issue_date := if(l.orig_issue_date<>0,(string8)l.orig_issue_date,'');
self.lic_issue_date := if(l.lic_issue_date<>0,(string8)l.lic_issue_date,'');
self.expiration_date := if(l.expiration_date<>0,(string8)l.expiration_date,'');
self.active_date := if(l.active_date<>0,(string8)l.active_date,'');
self.inactive_date := if(l.inactive_date<>0,(string8)l.inactive_date,'');
self := l;
end;

extract_ds_all := project(dl_extract, in_to_extract(left));

count(new_raw_file);
count(refresh_data);
count(extract_ds_all);

export dl_extract_query2 := output(extract_ds_all,,'~thor_data400::misc::dl_extract_20060928',overwrite);
