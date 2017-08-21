import gong, did_add, didville, ut, gong_v2, lib_thorlib, RoxieKeyBuild,idl_header,_control;
import header_quick, header;

#workunit('priority','high');
#workunit('priority',09);
#workunit('name','Yogurt:Gong History Key Build');

export proc_tempGongHistoryBuild(string dkc_volume, string weekday = ut.Weekday((integer)ut.GetDate)) := function

lstUpdateNo   := fileservices.GetSuperFileSubCount(Gong_v2.thor_cluster+'base::gongv2_daily_additions_building2') : global; 
lstUpdateName := fileservices.GetSuperFileSubName(Gong_v2.thor_cluster+'base::gongv2_daily_additions_building2',lstUpdateNo) : global;
update_date   := stringlib.stringfilter(lstUpdateName,'0123456789')[4..11] : global;

//this macro is to merge the gong update file with the base file, set the history fields
//update_date's first 6 character should be 'YYYYMM'

history_base0 := dataset('~thor_data400::base::gong_history', gong.layout_historyaid, flat, __compressed__);
ut.mac_flipnames(history_base0,name_first,name_middle,name_last,history_base);
gong_update := distribute(Gong.File_Gong_Dirty, hash(phone10,prim_range,prim_name,z5,listed_name));

//clear current_record_flag in the old history file
typeof(history_base) clear_curr_flag(history_base l) := transform
	self.current_record_flag := '';
	self.deletion_date := update_date;
	self := l;
end;

history_curr := distribute(project(history_base(current_record_flag = 'Y'), clear_curr_flag(left)),
                             hash(phone10,prim_range,prim_name,z5,listed_name));

//mark the total dup record and set dt_last_seen
typeof(history_curr) update_history_curr(history_curr l, gong_update r) := transform
	self.current_record_flag := if(r.bell_id != '', 'Y', '');
	self.deletion_date := if(r.bell_id != '', '', l.deletion_date);
  self.dt_last_seen := MAP(update_date < l.dt_last_seen => ERROR('Old date is newer than new date'),
																				r.bell_id != ''	=> update_date,
																				l.dt_last_seen);
  /* fields are no longer populated in new records and need to be populated for history */
	self.v_predir := l.predir ;
	self.v_prim_name := l.prim_name ;
	self.v_suffix := l.suffix ;
	self.v_postdir := l.postdir ;	
   self := l;
end; 

history_curr_marked := join(history_curr, gong_update,
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
                         /* fields are no longer populated in new records */
												 // left.v_predir = right.v_predir and
                         // left.v_prim_name = right.v_prim_name and
                         // left.v_suffix = right.v_suffix and
                         // left.v_postdir = right.v_postdir and
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
                         stringlib.stringtouppercase(left.listed_name) = stringlib.stringtouppercase(right.listed_name) and
                         stringlib.stringtouppercase(left.caption_text) = stringlib.stringtouppercase(right.caption_text) and
                     	left.omit_address = right.omit_address and
                         left.omit_phone = right.omit_phone and
                         left.omit_locality = right.omit_locality and
                         stringlib.stringtouppercase(left.see_also_text) = stringlib.stringtouppercase(right.see_also_text),
                         update_history_curr(left, right),left outer, local, keep(1));

typeof(history_curr) get_new_recs(gong_update r) := transform
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
  /* fields are no longer populated in new records and need to be populated for history */
	self.v_predir := r.predir ;
	self.v_prim_name := r.prim_name ;
	self.v_suffix := r.suffix ;
	self.v_postdir := r.postdir ;	
	self.pclean := r.prim_range +
							r.predir +
							r.prim_name +
							r.suffix +
							r.postdir +
							r.unit_desig +
							r.sec_range +
							r.p_city_name +
							r.v_predir +
							r.v_prim_name +
							r.v_suffix +
							r.v_postdir +
							r.v_city_name +
							r.st +
							r.z5 +
							r.z4 +
							r.cart +
							r.cr_sort_sz +
							r.lot +
							r.lot_order +
							r.dpbc +
							r.chk_digit +
							r.rec_type +
							r.county_code +
							r.geo_lat +
							r.geo_long +
							r.msa +
							r.geo_blk +
							r.geo_match +
							r.err_stat;	
	self := r;
end; 

gong_new_raw := join(history_curr, gong_update,
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
                   /* fields are no longer populated in new records */
				   // left.v_predir = right.v_predir and
                   // left.v_prim_name = right.v_prim_name and
                   // left.v_suffix = right.v_suffix and
                   // left.v_postdir = right.v_postdir and
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
                   stringlib.stringtouppercase(left.listed_name) = stringlib.stringtouppercase(right.listed_name) and
                   stringlib.stringtouppercase(left.caption_text) = stringlib.stringtouppercase(right.caption_text) and
			    left.omit_address = right.omit_address and
                   left.omit_phone = right.omit_phone and
                   left.omit_locality = right.omit_locality and
                   stringlib.stringtouppercase(left.see_also_text) = stringlib.stringtouppercase(right.see_also_text),
                   get_new_recs(right),right only, local);
			
gong_new := 	dedup(sort(gong_new_raw, 
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

history_disc := project(history_base(current_record_flag = ''), 
												transform(recordof(history_curr), 
																		self.v_predir 	 := left.predir ;
																		self.v_prim_name := left.prim_name ;
																		self.v_suffix 	 := left.suffix ;
																		self.v_postdir 	 := left.postdir ;	
																	  self := left));

roxieip := if (_Control.ThisEnvironment.Name = 'Dataland',
									_Control.RoxieEnv.certvip,
									_Control.RoxieEnv.prod_batch_neutral);

boolean_value := if ((ut.IsNewProdHeaderVersion('gong_history','header_build_version',roxieip) or 
											ut.IsNewProdHeaderVersion('gong_history','bheader_build_version',roxieip)) and 
											(weekday = 'SATURDAY' or weekday = 'SUNDAY'),
											true,false) : stored('boolean_value');
   
history_new := if (boolean_value, history_disc + history_curr_marked + gong_new, gong_new);
history_did_hhid_pre := gong.fn_did_bdid_hhid(history_new);

history_did_hhid := if (boolean_value, history_did_hhid_pre,  history_disc + history_curr_marked + history_did_hhid_pre) : persist('~thor::persist::gong_history::postdid');

gong.mac_add_disc_cnt(history_did_hhid,update_date,history_with_count);
/*** 55136 Add gong lift (cjs) history ***/
Macro_GongLift(history_with_count, history_with_lift);
history_with_pdid := gong.fnPropagateADLs(history_with_lift).history;
/*** end gong lift ***/
history_with_pid := gong.Mac_Assign_UniqueId(history_with_pdid, persistent_record_id);

outfile := 
	sequential(
		FileServices.SendEmail('christopher.brodeur@lexisnexis.com, cguyton@seisint.com', 'GONG - Notify Retrieved', thorlib.wuid()),

/* Check to see if History is already available. If not then build */

		if(fileservices.GetSuperFileSubName('~thor_data400::base::gong_history', 1) = 'thor_200::base::gong_history'+ update_date,
		/* EXISTS */		output(fileservices.GetSuperFileSubName('~thor_data400::base::gong_history', 1) + ' file created. Proceeding to keybuild.'),
		/* NOT EXIST */		sequential(
								output(history_with_pid,,'~thor_200::base::gong_history'+ update_date,__compressed__,overwrite),
								
								fileservices.addsuperfile('~thor_data400::base::gong_history_father','~thor_data400::base::gong_history',,true),
								fileservices.clearsuperfile('~thor_data400::base::gong_history'),
								fileservices.addsuperfile('~thor_data400::base::gong_history','~thor_200::base::gong_history'+ update_date),
								
								/* after previous base added to father, remove the oldest subfile from father if there is over 2 weeks of data */
								if(FileServices.GetSuperFileSubCount('~thor_data400::base::gong_history_father') > 12,
									FileServices.RemoveSuperFile('~thor_data400::base::gong_history_father', '~'+FileServices.GetSuperFileSubName('~thor_data400::base::gong_history_father', 1), true), 
									output('No Super Removed from Father')))),

/* Build Weekly (Current) and History Keys */

		parallel(
			//Gong.proc_build_full_keys_jtrost(update_date) // Build Current Roxie Keys
			Gong.proc_build_history_keys_jtrost(update_date) // Build History Roxie Keys
			)

/* Update DOPS for Package File Release */

		//,RoxieKeybuild.updateversion('GongKeys',update_date,'cbrodeur@seisint.com, cguyton@seisint.com')
		//,RoxieKeybuild.updateversion('FCRA_GongKeys',update_date,'cbrodeur@seisint.com, cguyton@seisint.com')

/* Create Brand New Neverseen Phone Number List for QA - per request */

		,gong_v2._fn_newphone_verification(update_date)
		,if (boolean_value,
				sequential(
						ut.PostDID_HeaderVer_Update('gong_history','header_build_version',roxieip),
						ut.PostDID_HeaderVer_Update('gong_history','bheader_build_version',roxieip),
						output('Full re-DID')),
						output('Daily DID')
						)
	)
	: SUCCESS(FileServices.SendEmail('QualityAssurance@seisint.com,christopher.brodeur@lexisnexis.com, cguyton@seisint.com, intel357@bellsouth.net', 'GONG - GongKeys Complete', thorlib.wuid() + ' Version: ' + update_date)),
	 Failure(FileServices.SendEmail('Afterhourssupport@seisint.com,christopher.brodeur@lexisnexis.com, cguyton@seisint.com, cnguyton@tmo.blackberry.net, intel357@bellsouth.net, chuck.salvo@gmail.com', 'GONG-EDA GongKeys Failure', thorlib.wuid() + '\n' + FAILMESSAGE));


return outfile;
end;	