//this macro is to merge the gong update file with the base file, set the history fields
//update_date's first 6 character should be 'YYYYMM'
import gong, did_add, didville;

export mac_merge_current(update_date,seqname,update_file='Gong.File_Gong_Dirty',update_all='\'\'') := macro

#uniquename(history_base)
#uniquename(gong_update)
%history_base% := gong.file_history;
%gong_update% := distribute(update_file, hash(phone10,prim_range,prim_name,z5,listed_name));

//clear current_record_flag in the old history file
#uniquename(clear_curr_flag)
typeof(%history_base%) %clear_curr_flag%(%history_base% l) := transform
	self.current_record_flag := '';
	self.deletion_date := update_date;
	self := l;
end;

#uniquename(history_curr)
%history_curr% := distribute(project(%history_base%(current_record_flag = 'Y'), %clear_curr_flag%(left)),
                             hash(phone10,prim_range,prim_name,z5,listed_name));

//mark the total dup record and set dt_last_seen
#uniquename(update_history_curr)
typeof(%history_curr%) %update_history_curr%(%history_curr% l, %gong_update% r) := transform
	self.current_record_flag := if(r.bell_id != '', 'Y', '');
	self.deletion_date := if(r.bell_id != '', '', l.deletion_date);
     self.dt_last_seen := MAP(update_date < l.dt_last_seen => ERROR('Old date is newer than new date'),
						r.bell_id != '' 				=> update_date, 
													   l.dt_last_seen);
     self := l;
end; 

#uniquename(history_curr_marked)
%history_curr_marked% := join(%history_curr%, %gong_update%,
                         left.dual_name_flag = right.dual_name_flag and
					left.listing_type_bus = right.listing_type_bus and
					left.listing_type_res = right.listing_type_res and
					left.listing_type_gov = right.listing_type_gov and
					left.publish_code = right.publish_code and
					left.style_code = right.style_code and
					left.indent_code = right.indent_code and
					left.prior_area_code = right.prior_area_code and
					left.phone10 = right.phone10 and
					left.prim_range = right.prim_range and
                         left.predir = right.predir and
                         left.prim_name = right.prim_name and
                         left.suffix = right.suffix and
                         left.postdir = right.postdir and
                         left.sec_range = right.sec_range and
                         left.p_city_name = right.p_city_name and
                         left.v_predir = right.v_predir and
                         left.v_prim_name = right.v_prim_name and
                         left.v_suffix = right.v_suffix and
                         left.v_postdir = right.v_postdir and
                         left.v_city_name = right.v_city_name and
                         left.st = right.st and
                         left.z5 = right.z5 and
                         left.county_code = right.county_code and
                         left.designation = right.designation and
                         left.name_prefix = right.name_prefix and
                         left.name_first = right.name_first and
                         left.name_middle = right.name_middle and
                         left.name_last = right.name_last and
                         left.name_suffix = right.name_suffix and
                         left.listed_name = right.listed_name and
                         left.caption_text = right.caption_text and
                     	left.omit_address = right.omit_address and
                         left.omit_phone = right.omit_phone and
                         left.omit_locality = right.omit_locality and
                         left.see_also_text = right.see_also_text,
                         %update_history_curr%(left, right),left outer, local, keep(1));

#uniquename(get_new_recs)
typeof(%history_curr%) %get_new_recs%(%gong_update% r) := transform
	self.current_record_flag := 'Y';
	self.deletion_date := '';
	self.dt_first_seen := update_date;
     self.dt_last_seen := update_date;
	self.did := 0;
	self.hhid := 0;
	self.bdid := 0;
	self.disc_cnt6 := 0;
	self.disc_cnt12 := 0;
	self.disc_cnt18 := 0;
     self := r;
end; 

#uniquename(gong_new_raw)
%gong_new_raw% := join(%history_curr%, %gong_update%,
                   left.dual_name_flag = right.dual_name_flag and
			    left.listing_type_bus = right.listing_type_bus and
		         left.listing_type_res = right.listing_type_res and
			    left.listing_type_gov = right.listing_type_gov and
			    left.publish_code = right.publish_code and
			    left.style_code = right.style_code and
			    left.indent_code = right.indent_code and
			    left.prior_area_code = right.prior_area_code and
			    left.phone10 = right.phone10 and
			    left.prim_range = right.prim_range and
                   left.predir = right.predir and
                   left.prim_name = right.prim_name and
                   left.suffix = right.suffix and
                   left.postdir = right.postdir and
                   left.sec_range = right.sec_range and
                   left.p_city_name = right.p_city_name and
                   left.v_predir = right.v_predir and
                   left.v_prim_name = right.v_prim_name and
                   left.v_suffix = right.v_suffix and
                   left.v_postdir = right.v_postdir and
                   left.v_city_name = right.v_city_name and
                   left.st = right.st and
                   left.z5 = right.z5 and
                   left.county_code = right.county_code and
                   left.designation = right.designation and
                   left.name_prefix = right.name_prefix and
                   left.name_first = right.name_first and
                   left.name_middle = right.name_middle and
                   left.name_last = right.name_last and
                   left.name_suffix = right.name_suffix and
                   left.listed_name = right.listed_name and
                   left.caption_text = right.caption_text and
			    left.omit_address = right.omit_address and
                   left.omit_phone = right.omit_phone and
                   left.omit_locality = right.omit_locality and
                   left.see_also_text = right.see_also_text,
                   %get_new_recs%(right),right only, local);
			
#uniquename(gong_new)
%gong_new% := 	dedup(sort(%gong_new_raw%, 
                           dual_name_flag, listing_type_bus, listing_type_res, listing_type_gov,
				       publish_code, style_code, indent_code, prior_area_code, phone10, 
				       prim_range, predir, prim_name, suffix, postdir, sec_range,
			            p_city_name, v_predir, v_prim_name, v_suffix, v_postdir, v_city_name,
				       st, z5, county_code, designation, 
				       name_prefix, name_first, name_middle, name_last, name_suffix, listed_name, 
				       caption_text, omit_address, omit_phone, omit_locality, see_also_text, 
				       -filedate, -book_neighborhood_code, local), 
			      dual_name_flag, listing_type_bus, listing_type_res, listing_type_gov,
				 publish_code, style_code, indent_code, prior_area_code, phone10, 
				 prim_range, predir, prim_name, suffix, postdir, sec_range,
			      p_city_name, v_predir, v_prim_name, v_suffix, v_postdir, v_city_name,
				 st, z5, county_code, designation, 
				 name_prefix, name_first, name_middle, name_last, name_suffix, listed_name, 
				 caption_text, omit_address, omit_phone, omit_locality, see_also_text, local);

#uniquename(history_disc)
%history_disc% := %history_base%(current_record_flag = '');

#uniquename(history_did_hhid)
#if(update_all != '')
   #uniquename(history_new)   
   %history_new% := %history_disc% + %history_curr_marked% + %gong_new%;
   gong.MAC_Did_Hhid_Append(%history_new%, %history_did_hhid%)
#else
   #uniquename(update_new)
   gong.MAC_Did_Hhid_Append(%gong_new%, %update_new%)
   %history_did_hhid% := %history_disc% + %history_curr_marked% + %update_new%;
#end

#uniquename(history_with_count)
gong.mac_add_disc_cnt(%history_did_hhid%,update_date,%history_with_count%);

seqname := sequential(
		 output(%history_with_count%,,
		        //'~thor_data400::base::gong_history' + thorlib.WUID(),__compressed__,overwrite),
				'~thor_data400::base::gong_history' + update_date,__compressed__,overwrite),
			   FileServices.StartSuperFileTransaction(),
			   FileServices.AddSuperFile('~thor_data400::base::gong_history_delete',
			                             '~thor_data400::base::gong_history_father',, true),
			   FileServices.ClearSuperFile('~thor_data400::base::gong_history_father'),
			   FileServices.AddSuperFile('~thor_data400::base::gong_history_father', 
			                             '~thor_data400::base::gong_history',, true),
			   FileServices.ClearSuperFile('~thor_data400::base::gong_history'),
			   FileServices.AddSuperFile('~thor_data400::base::gong_history', 
			                             //'~thor_data400::base::gong_history' + thorlib.WUID()),
										 '~thor_data400::base::gong_history' + update_date), 
			   FileServices.FinishSuperFileTransaction(),
			   FileServices.ClearSuperFile('~thor_data400::base::gong_history_delete',true));
			   
endmacro;