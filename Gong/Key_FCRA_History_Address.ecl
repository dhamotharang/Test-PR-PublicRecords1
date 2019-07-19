﻿//gong key based on some address fields
Import Data_Services, doxie, gong, data_services, mdr, vault, _control;

hist_in := Gong.File_History_Full_Prepped_for_FCRA_Keys(trim(prim_name)<>'', trim(z5)<>'');
gong.mac_hist_full_slim_fcra(hist_in, ghhist_out);

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
										
										/* The disc_cnt# fields are used in our ADL Risk Table, but thats from the base file, not the Address History key.  - Adam Shirey*/
										self.disc_cnt6 := if(left.disc_cnt6 > right.disc_cnt6, left.disc_cnt6, right.disc_cnt6),
										self.disc_cnt12 := if(left.disc_cnt12 > right.disc_cnt12, left.disc_cnt12, right.disc_cnt12),
										self.disc_cnt18 := if(left.disc_cnt18 > right.disc_cnt18, left.disc_cnt18, right.disc_cnt18),
										self.persistent_record_id := if(left.persistent_record_id < right.persistent_record_id,
																								left.persistent_record_id, right.persistent_record_id),

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
														disc_cnt18,persistent_record_id);
														


#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export Key_FCRA_History_Address := vault.Gong.Key_FCRA_History_Address;

#ELSE
export Key_FCRA_History_Address := 
       index(hist_out,
             {prim_name,
		    st,
		    z5, 
		    prim_range, 
		    sec_range,
		    boolean current_flag := if(current_record_flag='Y',true,false),
		    boolean business_flag := if(listing_type_bus='B',true,false)},
		    {hist_out},
					  Data_Services.Data_location.Prefix('Gong_History') + 'thor_data400::key::gong_history::fcra::'+doxie.Version_SuperKey + '::address');

#END;

