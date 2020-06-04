Import ut, Gong, NID,didville, mdr,Gong_Neustar,Std;
EXPORT files := module
	
	// EXPORT file_Gong_History := DATASET('~PRTE::BASE::Gong_History', Layouts.Layout_base, FLAT );
	// EXPORT file_Gong_Weekly := DATASET('~PRTE::BASE::Gong_Weekly', Layouts.Layout_base, FLAT );
	
	EXPORT file_Gong_History := DATASET('~prte::base::gong_history_20190814', Layouts.Layout_base, FLAT );
	EXPORT file_Gong_Weekly := DATASET('~PRTE::BASE::Gong_Weekly_20190814', Layouts.Layout_base, FLAT );
	
	EXPORT DS_Gong_History_IN := DATASET('~PRTE::IN::Gong_History', Layouts.Layout_gong_in, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
	EXPORT DS_Gong_Weekly_IN := DATASET('~PRTE::IN::Gong_Weekly', Layouts.Layout_gong_in, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
	EXPORT DS_Gong_Santander_IN :=  DATASET('~PRTE::IN::Gong_Santander', Layouts.Layout_gong_in, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );

	//Phone10
	Export Gong_Raw := project(file_Gong_History, Layouts.Layout_bscurrent_raw);
	EXPORT Gong_Raw_Weekly := dedup(project(file_Gong_Weekly, Layouts.Layout_bscurrent_raw), record,all);
	//Address_Current
		Layouts.rec_address addcn(Gong_Raw_Weekly l) := transform
			self.date_first_seen := L.filedate[1..8];
			self.fname := L.name_first;
			self.mname := L.name_middle;
			self.lname := L.name_last;
			Self.listing_type := 	if (L.listing_type_bus='B', Gong.Constants.PTYPE.BUSINESS, 0) +
								if (L.listing_type_res='R', Gong.Constants.PTYPE.RESIDENTIAL, 0) +
								if (L.listing_type_gov='G', Gong.Constants.PTYPE.GOVERNMENT, 0);
			self := l;
		end;
	export File_Address_Current := dedup (sort (project (Gong_Raw_Weekly, addcn(left)), record), record) ;
	//File_Npa_Zip
		gong_zip_npanxx_tbl := table (File_Address_Current(phone10<>'' and z5 <> '00000'),{zip := z5, phone := phone10}, z5, phone10, few);
		gong_zip_npanxx_t := project(gong_zip_npanxx_tbl, Layouts.AreaCodeSummary);
		ut.getTimeZone(gong_zip_npanxx_t,phone,timezone,gong_zip_npanxx_out);
		npanxx_tbl := table(File_Address_Current(phone10<>''),{zip := z5,areacode := phone10 [..3],cnt := count(group)},z5,phone10 [..3],few);
	export File_Npa_Zip := join(dedup(sort(gong_zip_npanxx_out(timezone <> ''),zip, phone [..3],timezone), zip, phone [..3],timezone),
					 npanxx_tbl,
					 left.zip = right.zip and
					 left.phone [..3] = right.areacode,
					 transform(Layouts.AreaCodeFinal,
							 self.occurs := right.cnt,
							 self.areacode := left.phone[..3],
							 self := left));
	//gong_cn

	f_cn := project(
					file_Gong_Weekly(current_record_flag<>'', listing_type_bus !='' or listing_type_gov != ''), 
					transform(Layouts.cn_layout, 
						self.cn_all   := if(left.listing_type_bus !='' or left.listing_type_gov != '',
										keyLib.GongDacName(Left.listed_name+' '+Left.caption_text),''),
						self := left))(cn_all<>'');
	Layouts.cn_layout normCN(Layouts.cn_layout l,integer c) :=TRANSFORM
		self.cn := l.cn_all[((c-1)*10)+1..c*10];
		self := l;
	END;
	f_cn_norm := normalize(f_cn,length(left.cn_all)/10,normCN(left,counter));
	EXPORT f_cn_norm_dep := dedup(sort(f_cn_norm, record), record);
	export File_History_Full_Prepped_for_Keys := Project(file_Gong_History, Layouts.layout_historyaid_clean);
	export File_Weekly_Full_Prepped_for_Keys := Project(file_Gong_Weekly, Layouts.layout_historyaid_clean);
	//DS_gong_cn_to_company
		hist_in := File_Weekly_Full_Prepped_for_Keys((unsigned)phone10<>0, listing_type_bus<>'', listed_name<>'', current_record_flag<>'');
		gong.mac_hist_full_slim_dep(hist_in, hist_out);
	EXPORT DS_gong_cn_to_company := hist_out;
	EXPORT DS_gong_did := Project(file_Gong_Weekly, Layouts.Layout_Gong_DID);
	EXPORT DS_gong_eda_npa_nxx_line := dedup(PROJECT(File_Weekly_Full_Prepped_for_Keys(TRIM(phone10)<>''), 
									Layouts.Layout_Gong_DID), record, all);
	/////DS_gong_eda_st_bizword_city////
		layouts.Layout_extra addOrig(recordof(DS_gong_did) l) := TRANSFORM
			SELF.word := '';
			SELF.city := l.p_city_name;
			SELF := l;
		END;
		eda_st_bizword_city_orig_cities := PROJECT(DS_gong_did((listing_type_bus = 'B') AND (TRIM(listed_name)<>'')), addOrig(LEFT));
		Layouts.Layout_extra addExtra(recordof(DS_gong_did) l, integer c) := TRANSFORM
			SELF.word := '';
			SELF.city := StringLib.StringExtract(ZipLib.ZipToCities(l.z5),c+1);
			SELF := l;
		END;
		eda_st_bizword_city_extra_cities := NORMALIZE(DS_gong_did((listing_type_bus = 'B') AND (TRIM(z5)<>'') and (TRIM(listed_name)<>'')),
								(INTEGER)StringLib.StringExtract(ZipLib.ZipToCities(LEFT.z5),1),
								 addExtra(LEFT, COUNTER));
		eda_st_bizword_city_all_cities := DEDUP(SORT(eda_st_bizword_city_orig_cities + 
									eda_st_bizword_city_extra_cities(TRIM(city)<>''), RECORD), RECORD);
		Layouts.Layout_extra addWords(Layouts.Layout_extra l, integer c) := TRANSFORM
			SELF.word := Stringlib.StringExtract(Stringlib.StringFindReplace(TRIM(l.listed_name),' ',','), c);
			SELF := l;
		END;
		eda_st_bizword_city_with_words := NORMALIZE(eda_st_bizword_city_all_cities,
									 LENGTH(Stringlib.StringFilter(TRIM(LEFT.listed_name),' '))+1,
								 addWords(LEFT, COUNTER));					 
	EXPORT DS_gong_eda_st_bizword_city := DEDUP(SORT(eda_st_bizword_city_with_words(TRIM(word)<>''), RECORD), RECORD);
	//DS_gong_eda_st_city_prim_name_prim_range
		
		Layouts.Layout_extra_city addOrig(recordof(DS_gong_did) l) := TRANSFORM
			SELF.city := l.p_city_name;
			SELF := l;
		END;
		orig_cities := PROJECT(DS_gong_did(TRIM(st)<>'' AND TRIM(p_city_name)<>'' AND TRIM(prim_name)<>''), addOrig(LEFT));
		Layouts.Layout_extra_city addExtra(recordof(DS_gong_did) l, integer c) := TRANSFORM
			SELF.city := StringLib.StringExtract(ZipLib.ZipToCities(l.z5),c+1);
			SELF := l;
		END;
		extra_cities := NORMALIZE(DS_gong_did(TRIM(st)<>'' AND TRIM(p_city_name)<>'' AND TRIM(prim_name)<>'' and TRIM(z5)<>''),
									 (INTEGER)StringLib.StringExtract(ZipLib.ZipToCities(LEFT.z5),1),
								 addExtra(LEFT, COUNTER));
	EXPORT DS_gong_eda_st_city_prim_name_prim_range := DEDUP(SORT(orig_cities + extra_cities(TRIM(city)<>''), RECORD), RECORD);
	//////////DS_gong_eda_st_lname_city////////
		
		Layouts.Layout_extra_city addOrig2(recordof(DS_gong_did) l) := TRANSFORM
			SELF.city := l.p_city_name;
			SELF := l;
		END;
		orig_cities2 := PROJECT(DS_gong_did((listing_type_res = 'R') AND (TRIM(name_last)<>'')), addOrig2(LEFT));
		Layouts.Layout_extra_city addExtra2(recordof(DS_gong_did) l, integer c) := TRANSFORM
			SELF.city := StringLib.StringExtract(ZipLib.ZipToCities(l.z5),c+1);
			SELF := l;
		END;

		extra_cities2 := NORMALIZE(DS_gong_did((listing_type_res = 'R') AND (TRIM(name_last)<>'') and TRIM(z5)<>''),
									 (INTEGER)StringLib.StringExtract(ZipLib.ZipToCities(LEFT.z5),1),
								 addExtra2(LEFT, COUNTER));
	EXPORT DS_gong_eda_st_lname_city := DEDUP(SORT(orig_cities2 + extra_cities2(TRIM(city)<>''), RECORD), RECORD);
	//////////DS_gong_eda_st_lname_fname_city///////////
		
		Layouts.Layout_extra_fname_city addOrig3(recordof(DS_gong_did) l) := TRANSFORM
			SELF.fname := '';
			SELF.city := l.p_city_name;
			SELF := l;
		END;
		orig_cities3 := PROJECT(DS_gong_did((listing_type_res = 'R') AND (TRIM(name_last)<>'') AND (TRIM(name_first)<>'')), addOrig3(LEFT));
		Layouts.Layout_extra_fname_city addExtra3(recordof(DS_gong_did) l, integer c) := TRANSFORM
			SELF.fname := '';
			SELF.city := StringLib.StringExtract(ZipLib.ZipToCities(l.z5),c+1);
			SELF := l;
		END;
		extra_cities3 := NORMALIZE(DS_gong_did((listing_type_res = 'R') AND (TRIM(name_last)<>'') AND (TRIM(name_first)<>'') and TRIM(z5)<>''),
									 (INTEGER)StringLib.StringExtract(ZipLib.ZipToCities(LEFT.z5),1),
								 addExtra3(LEFT, COUNTER));
		all_cities3 := DEDUP(SORT(orig_cities3 + extra_cities3(TRIM(city)<>''), RECORD), RECORD);
		Layouts.Layout_extra_fname_city addNames3(Layouts.Layout_extra_fname_city l, integer c) := TRANSFORM
			SELF.fname := IF(c=1,l.name_first,NID.PreferredFirstNew(l.name_first));
			SELF := l;
		END;
	EXPORT DS_gong_eda_st_lname_fname_city := NORMALIZE(all_cities3,
								 IF(NID.PreferredFirstNew(LEFT.name_first)<>LEFT.name_first,2,1),
								 addNames3(LEFT, COUNTER));
	//HHID
		Layouts.layout_gng_hhid_temp AddMissingName(DS_gong_did l) := TRANSFORM
			SELF.name_last := IF(l.name_last != '', l.name_last, ut.Word(l.listed_name, 1));
			SELF := l;
		END;
		g_withname := PROJECT(DS_gong_did(listing_type_res != ''), AddMissingName(LEFT));
		g_hhid := g_withname(name_last != '');
		didville.MAC_HHID_Append_By_Address(
			g_hhid, hhid_outf, hhid, name_last,
			prim_range, prim_name, sec_range, st, z5)
	export DS_gong_hhid := project(hhid_outf, Layouts.layout_gng_hhid);
	
	///////history_address
	export DS_gong_history_address(boolean IsFCRA) := function
		hist_in := if(	IsFCRA,
					File_History_Full_Prepped_for_Keys(trim(prim_name)<>'', trim(z5)<>'',bell_id in Constants.allowedBellIdForFCRA),
					File_History_Full_Prepped_for_Keys(trim(prim_name)<>'', trim(z5)<>''));		
		gong.mac_hist_full_slim_fcra(hist_in, ghhist_out);
		srtHistOut := sort(ghhist_out, prim_name, st, z5, prim_range, sec_range, record, except dt_first_seen,
				dt_last_seen,deletion_date,v_predir,v_prim_name,v_suffix,v_postdir,v_city_name,county_code
				,geo_lat,geo_long,msa,disc_cnt6,disc_cnt12,disc_cnt18	);													
		gong_history_address := rollup(srtHistOut, transform(recordof(ghhist_out),
						self.dt_first_seen := if(left.dt_first_seen < right.dt_first_seen, left.dt_first_seen, right.dt_first_seen),
						self.dt_last_seen := if(left.dt_last_seen > right.dt_last_seen, left.dt_last_seen, right.dt_last_seen),
						self.deletion_date := if(left.deletion_date > right.deletion_date, left.deletion_date, right.deletion_date),
						self.disc_cnt6 := if(left.disc_cnt6 > right.disc_cnt6, left.disc_cnt6, right.disc_cnt6),
						self.disc_cnt12 := if(left.disc_cnt12 > right.disc_cnt12, left.disc_cnt12, right.disc_cnt12),
						self.disc_cnt18 := if(left.disc_cnt18 > right.disc_cnt18, left.disc_cnt18, right.disc_cnt18),
						self.persistent_record_id := if(left.persistent_record_id < right.persistent_record_id,
							left.persistent_record_id, right.persistent_record_id),
						self := right),
						record, except dt_first_seen,
							dt_last_seen,deletion_date,v_predir,v_prim_name,v_suffix,v_postdir,v_city_name
							,county_code,geo_lat,geo_long,msa,disc_cnt6,disc_cnt12,disc_cnt18,persistent_record_id);
		return gong_history_address;
	end;
	/////history_city_st_name///
		history_city_st_name_in := File_History_Full_Prepped_for_Keys(trim(p_city_name)<>'', name_last<>'');
		gong.mac_hist_full_slim_dep(history_city_st_name_in, history_city_st_name_hist_out)
		hist_out_new_rec := record
				history_city_st_name_hist_out;
				string25 city_name;
		end;
	EXPORT DS_gong_history_city_st_name := project(history_city_st_name_hist_out, 
					transform(hist_out_new_rec, 
						self.city_name:=left.p_city_name, 
						self:=left)) + 
									project(history_city_st_name_hist_out(p_city_name<>v_city_name), 
					transform(hist_out_new_rec, 
						self.city_name:=left.v_city_name, 
						self:=left));
	////////////history_cleanname
		cleanname_hist_in_gong := File_History_Full_Prepped_for_Keys(trim(name_last)<>'');
		gong.mac_hist_full_slim_dep(cleanname_hist_in_gong, cleanname_hist_out)
	Export DS_gong_history_cleanname := cleanname_hist_out;
	/////////history_companyname///////
		companyname_hist_in := File_History_Full_Prepped_for_Keys((unsigned)phone10<>0, listing_type_bus<>'', listed_name<>'');
		gong.mac_hist_full_slim_dep(companyname_hist_in, companyname_hist_out)
		hist_out_new_rec := record
			companyname_hist_out;
			string120 listed_name_new;
		end;
	export DS_gong_history_companyname  := project(	companyname_hist_out, 
											transform(hist_out_new_rec, 
													self.listed_name_new := StringLib.StringCleanSpaces(StringLib.StringSubstituteOut(left.listed_name,'~`!@#$%^&*()-_+={[}]|\\;:"\'<,>.?/',' ')), 
													self:=left));
	////////history_did/////////
	export DS_gong_history_did(Boolean IsFCRA) := function
		did_hist_in := if (	IsFCRA,
						File_History_Full_Prepped_for_Keys(did<>0, bell_id in Constants.allowedBellIdForFCRA),
						File_History_Full_Prepped_for_Keys(did<>0));
		gong.mac_hist_full_slim_fcra(did_hist_in, did_hist_out);
		return did_hist_out;
	end;
	///////history_hhid///////
		history_hhid_hist_in := File_History_Full_Prepped_for_Keys(hhid<>0);
		gong.mac_hist_full_slim_dep(history_hhid_hist_in, history_hhid_hist_out)
	EXPORT DS_gong_history_hhid := history_hhid_hist_out;
	/////////history_name////////
		history_name_hist_in := File_History_Full_Prepped_for_Keys(trim(name_last)<>'');
		gong.mac_hist_full_slim_dep(history_name_hist_in, history_name_hist_out)
	export DS_gong_history_name := history_name_hist_out;
	///////history_npa_nxx_line/////
	EXPORT DS_gong_history_npa_nxx_line := PROJECT(File_History_Full_Prepped_for_Keys, {Layouts.Layout_history and not [cust_name,bug_num,address1,city,state,zip,link_ssn,link_dob,link_fein,link_inc_date,powid,proxid,seleid, orgid,ultid]});
	
	////////////DS_gong_history_wdtg/////////////////////////////////////////////////

		gong_raw_wdtg := File_History_Full_Prepped_for_Keys;
		//layout_span
		// make sure we have all the fields we need
		gong_decent_wdtg := gong_raw_wdtg(z5<>'',name_last<>'',name_first<>'',dt_last_seen<>'',dt_first_seen<>'',dt_first_seen<>'Signat');
		// define narrowed layout with date-spanning fields
		gong_slim_wdtg := project(gong_decent_wdtg, Layouts.layout_narrow);
		// add date-spanning fields, grouped by phone/location/surname
		gong_srt_wdtg := sort(gong_slim_wdtg, phone10,z5,prim_name,prim_range,name_last);
		gong_grp_wdtg := group(gong_srt_wdtg, phone10,z5,prim_name,prim_range,name_last);
		gong_grp_f_wdtg := dedup(sort(gong_grp_wdtg,dt_first_seen));
		gong_grp_l_wdtg := dedup(sort(gong_grp_wdtg,-dt_last_seen));
		gong_span_f_wdtg := join(
			gong_grp_wdtg, gong_grp_f_wdtg,
			left.phone10=right.phone10
				and left.z5=right.z5
				and left.prim_name=right.prim_name
				and left.prim_range=right.prim_range
				and left.name_last=right.name_last,
			transform(Layouts.layout_span, 
								self.global_sid := 0,
								self.record_sid := 0,
								self.span_first_seen:=right.dt_first_seen, 
								self:=left),
			keep(1), left outer, hash
		);
		gong_span_fl_wdtg := join(
			gong_span_f_wdtg, gong_grp_l_wdtg,
			left.phone10=right.phone10
				and left.z5=right.z5
				and left.prim_name=right.prim_name
				and left.prim_range=right.prim_range
				and left.name_last=right.name_last,
			transform(Layouts.layout_span, self.span_last_seen:=right.dt_last_seen, self:=left),
			keep(1), left outer, skew(0.2), hash
		);
		gong_span_wdtg := ungroup(gong_span_fl_wdtg);
	export DS_gong_history_wdtg := sort( gong_span_wdtg, phone10,z5,prim_name,prim_range,name_last, -dt_last_seen );
	/////////////wild_name_zip////////////
		wild_name_zip_hist_in := File_History_Full_Prepped_for_Keys(name_last<>'');
		gong.mac_hist_full_slim_dep(wild_name_zip_hist_in, wild_name_zip_hist_out)
	export DS_gong_history_wild_name_zip := wild_name_zip_hist_out;
	/////////DS_gong_history_zip_name//////
		zip_name_hist_in := File_History_Full_Prepped_for_Keys(z5<>'');
		gong.mac_hist_full_slim_dep(zip_name_hist_in, zip_name_hist_out)
	Export DS_gong_history_zip_name := zip_name_hist_out;
	/////////hist_bdid//////
		hist_bdid_hist_in := File_History_Full_Prepped_for_Keys(bdid != 0);
		gong.mac_hist_full_slim_dep(hist_bdid_hist_in, hist_bdid_hist_out)
	export DS_gong_hist_bdid := hist_bdid_hist_out;
	//////////DS_gong_phone/////////
		valid_gong_full := DS_gong_did(trim(phone10) <> '');
		Layouts.new_gong_record split_phone_areacode(valid_gong_full l) := transform
			self.phone7    := if(l.phone10[8..10] ='', l.phone10[1..7], l.phone10[4..10]);
			self.area_code := if(l.phone10[8..10] ='', '', l.phone10[1..3]);	
			self := l;
		end;
	export DS_gong_phone := dedup(project(valid_gong_full, split_phone_areacode(left)), record, all);
	////////////////gong_scoring//////////////
	EXPORT DS_gong_scoring := Dataset([], Layouts.ScoringRecord);
	///////DS_gong_surnamecnt//////
	EXPORT DS_gong_surnamecnt := dataset([], Layouts.surnames_slim_rec);
	
END;