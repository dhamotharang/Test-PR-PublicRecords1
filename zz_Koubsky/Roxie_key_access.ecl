//gong key based on some address fields
Import Data_Services, doxie, gong, data_services;
import insurview_salt_project as inSaltProj;

hist_in := Gong.File_History_Full_Prepped_for_Keys(trim(prim_name)<>'', trim(z5)<>'');
gong.mac_hist_full_slim_dep(hist_in, ghhist_out, true);	// uncomment for PID
//gong.mac_hist_full_slim_dep(hist_in, ghhist_out, false);

srtHistOut := sort(ghhist_out, prim_name, st, z5, prim_range, sec_range, record, except dt_first_seen,
														dt_last_seen,
														deletion_date
														,v_predir
														,v_prim_name
														,v_suffix
														,v_postdir
														,v_city_name
														,county_code
														,geo_lat
														,geo_long
														,msa
														,disc_cnt6,
														disc_cnt12,
														disc_cnt18);

hist_out := rollup(srtHistOut, transform(recordof(ghhist_out),
										self.dt_first_seen := if(left.dt_first_seen < right.dt_first_seen, left.dt_first_seen, right.dt_first_seen),
										self.dt_last_seen := if(left.dt_last_seen > right.dt_last_seen, left.dt_last_seen, right.dt_last_seen),
										self.deletion_date := if(left.deletion_date > right.deletion_date, left.deletion_date, right.deletion_date),
										
										/* The disc_cnt# fields are used in our ADL Risk Table, but thats from the base file, not the Address History key.  - Adam Shirey*/
										self.disc_cnt6 := if(left.disc_cnt6 > right.disc_cnt6, left.disc_cnt6, right.disc_cnt6),
										self.disc_cnt12 := if(left.disc_cnt12 > right.disc_cnt12, left.disc_cnt12, right.disc_cnt12),
										self.disc_cnt18 := if(left.disc_cnt18 > right.disc_cnt18, left.disc_cnt18, right.disc_cnt18),
										
										self := right),
						record, except dt_first_seen,
														dt_last_seen,
														deletion_date
														,v_predir
														,v_prim_name
														,v_suffix
														,v_postdir
														,v_city_name
														,county_code
														,geo_lat
														,geo_long
														,msa
														,disc_cnt6,
														disc_cnt12,
														disc_cnt18);


Key_History_Address := 
       index(hist_out,
             {prim_name,
		    st,
		    z5, 
		    prim_range, 
		    sec_range,
		    boolean current_flag := if(current_record_flag='Y',true,false),
		    boolean business_flag := if(listing_type_bus='B',true,false)},
		    {hist_out},
//	(pid)							'~thor_data400::key::gong_history::20121003::address');
		    '~foreign::10.239.196.104::dataoqa196_roxie::thor_data400::key::gong_history::20140701::address');
	/*			
				gongLayout := RECORD
  string28 prim_name;
  string2 st;
  string5 z5;
  string10 prim_range;
  string8 sec_range;
  boolean current_flag;
  boolean business_flag;
  string1 listing_type_bus;
  string1 listing_type_res;
  string1 listing_type_gov;
  string1 publish_code;
  string3 prior_area_code;
  string10 phone10;
  string2 predir;
  string4 suffix;
  string2 postdir;
  string10 unit_desig;
  string25 p_city_name;
  string2 v_predir;
  string28 v_prim_name;
  string4 v_suffix;
  string2 v_postdir;
  string25 v_city_name;
  string4 z4;
  string5 county_code;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string32 designation;
  string5 name_prefix;
  string20 name_first;
  string20 name_middle;
  string20 name_last;
  string5 name_suffix;
  string120 listed_name;
  string254 caption_text;
  string1 omit_address;
  string1 omit_phone;
  string1 omit_locality;
  string64 see_also_text;
  unsigned6 did;
  unsigned6 hhid;
  unsigned6 bdid;
  string8 dt_first_seen;
  string8 dt_last_seen;
  string1 current_record_flag;
  string8 deletion_date;
  unsigned2 disc_cnt6;
  unsigned2 disc_cnt12;
  unsigned2 disc_cnt18;
  unsigned8 persistent_record_id;
 END;
*/ 

 // profile := inSaltProj.mac_profile(Key_History_Address);
 
ds := Key_History_Address;
output(ds);

r1 := record
 string6 add_dt_ym;
end;

r1 xform1(ds le) := transform
 self.add_dt_ym := le.dt_first_seen[1..6];
end;

p1 := project(ds,xform1(left));

r2 := record
 p1.add_dt_ym;
 count_ := count(group);
end;

ta1 := table(p1,r2,add_dt_ym,few);
output(sort(ta1,-add_dt_ym),all);

