import header, ut, avm_v2, fcra, header_quick, doxie_build, mdr,PRTE2_Header,Risk_Indicators, prte2_gong,PRTE2_Bankruptcy, Address;

EXPORT files := module

		
	shared h_full(Boolean IsFCRA) := if (	IsFCRA, 
									PRTE2_Header.files.File_FCRA_header_building, 
									PRTE2_Header.files.file_header_building(~Risk_Indicators.iid_constants.filtered_source(src, st)));
	export header_base(Boolean IsFCRA) := ungroup(h_full(IsFCRA));

	headerprod_building := ungroup(h_full(false)(	trim(prim_name)<>'' and 
									length(trim(zip))=5 and 
									(integer)zip<>0 ) 
							);
																	
	combo := Risk_Indicators.Address_Table_Function(headerprod_building);	
			
	eq := Risk_Indicators.Address_Table_Function(headerprod_building(src not in 
										[mdr.sourceTools.src_Experian_Credit_Header, mdr.sourceTools.src_TU_CreditHeader]));	
	en := Risk_Indicators.Address_Table_Function(headerprod_building(src not in 
										[mdr.sourceTools.src_Equifax, mdr.sourceTools.src_TU_CreditHeader]));	
	tn := Risk_Indicators.Address_Table_Function(headerprod_building(src not in 
										[mdr.sourceTools.src_Equifax, mdr.sourceTools.src_Experian_Credit_Header]));	

	addr_table_eq := join(	combo, 
						eq, 
						left.zip=right.zip and 
						left.prim_range=right.prim_range and 
						left.predir=right.predir and
						left.prim_name=right.prim_name and left.
						suffix=right.suffix and 
						left.postdir=right.postdir and 
						left.sec_range=right.sec_range,
						transform(Layouts.layout_addr_risk, 
							use_right := left.zip='';
							self.prim_range := if(use_right, right.prim_range, left.prim_range),
							self.predir := if(use_right, right.predir , left.predir ),
							self.prim_name  := if(use_right, right.prim_name , left.prim_name ),
							self.suffix := if(use_right, right.suffix , left.suffix ),
							self.postdir := if(use_right, right.postdir , left.postdir ),
							self.sec_range := if(use_right, right.sec_range , left.sec_range ),
							self.zip := if(use_right, right.zip , left.zip ),
							self.combo.ssn_ct := left.ssn_ct,
							self.combo.ssn_ct_c6 := left.ssn_ct_c6,
							self.combo.did_ct := left.did_ct,
							self.combo.did_ct_c6 := left.did_ct_c6,
							self.eq.ssn_ct := right.ssn_ct,
							self.eq.ssn_ct_c6 := right.ssn_ct_c6,
							self.eq.did_ct := right.did_ct,
							self.eq.did_ct_c6 := right.did_ct_c6,
							self := []), 
						left outer);

	addr_table_eqen := join(	addr_table_eq, 
						en, 
						left.zip=right.zip and 
						left.prim_range=right.prim_range and 
						left.predir=right.predir and
						left.prim_name=right.prim_name and 
						left.suffix=right.suffix and 
						left.postdir=right.postdir and 
						left.sec_range=right.sec_range,
						transform(Layouts.layout_addr_risk, 
							use_right := left.zip='';
							self.prim_range := if(use_right, right.prim_range, left.prim_range),
							self.predir := if(use_right, right.predir , left.predir ),
							self.prim_name  := if(use_right, right.prim_name , left.prim_name ),
							self.suffix := if(use_right, right.suffix , left.suffix ),
							self.postdir := if(use_right, right.postdir , left.postdir ),
							self.sec_range := if(use_right, right.sec_range , left.sec_range ),
							self.zip := if(use_right, right.zip , left.zip ),
							self.en.ssn_ct := right.ssn_ct,
							self.en.ssn_ct_c6 := right.ssn_ct_c6,
							self.en.did_ct := right.did_ct,
							self.en.did_ct_c6 := right.did_ct_c6,
							self := left), 
						full outer);
	EXPORT Address_Table_v4 := join(	addr_table_eqen, 
								tn, 
								left.zip=right.zip and 
								left.prim_range=right.prim_range and 
								left.predir=right.predir and
								left.prim_name=right.prim_name and 
								left.suffix=right.suffix and 
								left.postdir=right.postdir and 
								left.sec_range=right.sec_range,
								transform(Layouts.layout_addr_risk, 
									use_right := left.zip='';
									self.prim_range := if(use_right, right.prim_range, left.prim_range),
									self.predir := if(use_right, right.predir , left.predir ),
									self.prim_name  := if(use_right, right.prim_name , left.prim_name ),
									self.suffix := if(use_right, right.suffix , left.suffix ),
									self.postdir := if(use_right, right.postdir , left.postdir ),
									self.sec_range := if(use_right, right.sec_range , left.sec_range ),
									self.zip := if(use_right, right.zip , left.zip ),
									self.tn.ssn_ct := right.ssn_ct,
									self.tn.ssn_ct_c6 := right.ssn_ct_c6,
									self.tn.did_ct := right.did_ct,
									self.tn.did_ct_c6 := right.did_ct_c6,
									self := left), 
								full outer);
				
	////////////////////////////////////////////////////
	/////////////SSN_Table_v4_2/////////////////////////
	Export SSN_Table_v4_2(Boolean IsFCRA = false):= Function
		todays_date := (string) risk_indicators.iid_constants.todaydate;

		ssn_table_header := header_base(IsFCRA)(LENGTH(TRIM(ssn))=9);

		combined_bureau_table := SSN_Table(ssn_table_header, 'ALL');

		equifax_table := SSN_Table(ssn_table_header(src not in [mdr.sourceTools.src_Experian_Credit_Header,mdr.sourceTools.src_TU_CreditHeader]), 
							  mdr.sourceTools.src_Equifax);
																								
		experian_table := SSN_Table(	ssn_table_header(src not in [mdr.sourceTools.src_Equifax, mdr.sourceTools.src_TU_CreditHeader]), 
								mdr.sourceTools.src_Experian_Credit_Header);
																								
		transunion_table := SSN_Table(ssn_table_header(src not in [mdr.sourceTools.src_Equifax,mdr.sourceTools.src_Experian_Credit_Header]), 
								mdr.sourceTools.src_TU_CreditHeader);

		j1 := join(	combined_bureau_table, 
					equifax_table, 
					left.ssn=right.ssn,
					transform(Layouts.final_rec, 
							self.ssn := left.ssn, 
							self.combo := left, 
							self.eq := right, 
							self := []),
					left outer);

		combined_snapshots := join(	j1, 
								experian_table, 
								left.ssn=right.ssn,
								transform(Layouts.final_rec, 
										self.en := right, 
										self := left),
								left outer);
												
		combined_snapshots2 := join(	combined_snapshots, 
								transunion_table, 
								left.ssn=right.ssn,
								transform(Layouts.final_rec, 
										self.tn := right, 
										self := left),
								left outer);
		rec_temp := record
			Layouts.final_rec;
			unsigned6 bansDid := 0;
		end;

		rec_temp getBk(Layouts.final_rec le, PRTE2_Bankruptcy.Files.Search_Base ri) := TRANSFORM
		    SELF.isBankrupt := ri.ssn<>'';
		    SELF.bansdid := (unsigned)ri.did;
		    SELF.dt_first_bankrupt := (unsigned)ri.date_filed;
		    SELF := le;
		END;

		rec_temp transformBk(Layouts.final_rec le) := TRANSFORM
		    SELF := le;
		END;

		bk_search := PRTE2_Bankruptcy.Files.Search_Base(name_type='D' and LENGTH(TRIM(ssn))=9);
		with_bk := JOIN(	combined_snapshots2,
						bk_search, 
						LEFT.ssn=RIGHT.ssn, 
						getBk(LEFT,RIGHT), 
						LEFT OUTER);
		all_again := with_bk;

		rec_temp get_ssa(rec_temp le, header.Layout_SSN_Map ri) := TRANSFORM
			SELF.issue_state := Address.Map_State_Name_To_Abbrev(Stringlib.StringToUpperCase(ri.state));
			SELF.official_first_seen := (unsigned3) (ri.start_date[1..6]); 
			r_end := IF (Ri.end_date='20990101', '', Ri.end_date[1..6]);
			SELF.official_last_seen  := (unsigned3) r_end; //YYYYMM
			SELF.isSequenceValid := true;
			
			vssn := Risk_indicators.Validate_SSN(le.ssn,'');
			
			SELF.isValidFormat := ~(vssn.invalid OR vssn.begin_invalid OR
							  vssn.middle_invalid OR vssn.last_invalid OR vssn.invalid_666s);			
			SELF := le;
		END;

		with_ssa := JOIN(all_again, header.File_SSN_Map, 
					  (LEFT.ssn[1..5]=RIGHT.ssn5) AND
					  (Left.ssn[6..9] between Right.start_serial and Right.end_serial),
					  get_ssa(LEFT,RIGHT), 
					  LEFT OUTER, LOOKUP);

		rec_temp pickdates(rec_temp le, rec_temp ri) := TRANSFORM
			SELF.dt_first_bankrupt := ut.Min2(le.dt_first_bankrupt,ri.dt_first_bankrupt);
			SELF := le;
		END;

		deduped_base_file := ROLLUP(SORT(with_ssa,ssn,-bansdid),pickdates(LEFT,RIGHT),ssn);

		pull_file := dataset([],Layouts.inRec);//doxie.File_pullSSN;

		rec_temp pull_data(rec_temp le, pull_file rt) := transform
			self.ssn := le.ssn;
			vssn := Risk_Indicators.Validate_SSN(le.ssn,'');
			socsvalflag_temp := MAP( (le.ssn<>'' and ~le.isValidFormat) or 
								vssn.begin_invalid or vssn.middle_invalid or vssn.last_invalid or 
								vssn.invalid_666s or vssn.pocketbook_ssn => '1',
								'0');
			randomizedSocial := Risk_Indicators.rcSet.isCodeRS(le.ssn, socsvalflag_temp, TRIM((STRING)le.official_first_seen), '0');
			ssnLowIssue := IF(randomizedSocial, '20110625', TRIM((STRING)le.official_first_seen));
			ssnHighIssue := IF(randomizedSocial, todays_date, TRIM((STRING)le.official_last_seen));
			self.official_first_seen := (INTEGER)(ssnLowIssue[1..6]);
			self.official_last_seen := (INTEGER)(ssnHighIssue[1..6]);
			self.isValidFormat := le.isValidFormat;
			self.isSequenceValid := le.isSequenceValid;
			self.issue_state := le.issue_state;
			self := if(rt.ssn='', le);// blank out all of the other fields if we get a hit on pullid file
		END;

		pull_j1 := join(deduped_base_file, pull_file, left.ssn=right.ssn,
					pull_data(left, right), left outer, lookup);

		pull_j2 := join(pull_j1, pull_file, 
					left.combo.bestdid!=0 and
						intformat(left.combo.bestdid,12,1)=right.ssn,
						pull_data(left, right), left outer, lookup);

		pull_j3 := join(pull_j2, pull_file, 
					left.combo.deathdid!=0 and
						intformat(left.combo.deathdid,12,1)=right.ssn,
						pull_data(left, right), left outer, lookup);

		pull_j4 := join(pull_j3, pull_file, 
					left.bansdid!=0 and
						intformat(left.bansdid,12,1)=right.ssn,
						pull_data(left, right), left outer, lookup);				
		return  project(pull_j4, Layouts.final_rec) ;	
	End;		
	shared ssn_name_hdr := header_base(false)(trim(ssn)<>'' and trim(lname)<>'' and trim(fname)<>'');
	ssn_name_src := table(ssn_name_hdr, {ssn, lname, fname, src, total := count(group)}, ssn, lname, fname, src);
	export ssn_name_counts := table(ssn_name_src, {ssn, lname, fname, source_count := count(group)}, ssn, lname, fname);

	shared ssn_addr_hdr := header_base(false)(trim(ssn)<>'' and trim(prim_name)<>'' and trim(zip)<>'');
	ssn_addr_src := table(ssn_addr_hdr, {ssn, prim_name, prim_range, zip, src, total := count(group)}, ssn, prim_name, prim_range, zip, src);
	export ssn_addr_counts := table(ssn_addr_src, {ssn, prim_name, prim_range, zip, source_count := count(group)}, ssn, prim_name, prim_range, zip);


	shared addr_name_hdr := distribute(header_base(false)(trim(prim_name)<>'' and trim(zip)<>'' and trim(lname)<>'' and trim(fname)<>''), hash(prim_name, zip, lname));
	addr_name_src := table(	addr_name_hdr,{prim_name, prim_range, zip, lname, fname, src, total := count(group)}, 
													prim_name, prim_range, zip, lname, fname, src);
	export addr_name_counts := table(	addr_name_src, 
								{prim_name, prim_range, zip, lname, fname, source_count := count(group)}, 
								prim_name, prim_range, zip, lname, fname);
	
	shared gh := prte2_gong.files.File_History_Full_Prepped_for_Keys;
	
	export phones_base := project(gh(phone10<>''), transform(Layouts.phones_base_layout, 
																														self.src := 'GH', 
																														self.zip := left.z5, 
																														self := left)); 	
		
	phone_addr_base := phones_base(trim(phone10)<>'' and trim(prim_name)<>'' and trim(zip)<>'');
	phone_addr_src := table(	phone_addr_base, {phone10, prim_name, prim_range, zip, src, total := count(group)}, 
														phone10, prim_name, prim_range, zip, src);
	export phone_addr_counts := table(	phone_addr_src, {phone10, prim_name, prim_range, zip, source_count := count(group)}, 
																			phone10, prim_name, prim_range, zip);

	shared phone_lname_base := phones_base(trim(phone10)<>'' and trim(name_last)<>'');
	phone_lname_src := table(phone_lname_base,
						{phone10, name_last, src, total := count(group)}, 
						phone10, name_last, src);
	export phone_lname_counts := table(phone_lname_src, {phone10, lname := name_last, source_count := count(group)}, phone10, name_last);


	today := risk_indicators.iid_constants.todaydate DIV 100;

	hf1 := h_full(false)(did!=0 );

	headerprod_building := UNGROUP(hf1);

	base_hf := PROJECT(headerprod_building(dt_last_seen<>0),TRANSFORM(Header.Layout_Header, SELF := LEFT));

	did_slim := RECORD
		base_hf.did;
		total_records := count(group);
		bureau_records := count(group, base_hf.src in Risk_Indicators.iid_constants.bureau_sources);
		dt_first_seen := MIN(GROUP,IF(base_hf.dt_first_seen=0,999999,base_hf.dt_first_seen));
		dt_last_seen := MAX(GROUP,base_hf.dt_last_seen);
	END;

	header_stats := TABLE(base_hf, did_slim, did);

	suspicious_header := header_stats(
								(dt_first_seen<>999999 and dt_first_seen >= (today-100)	)		or	
								(bureau_records=total_records) or
								(bureau_records>0 and total_records>0 and dt_last_seen < (today-100))		
								);

	did_ssn_dob := table(base_hf(trim(ssn)<>''), {did, ssn, dob}, did, ssn, dob);

	temprec := record
		recordof(did_ssn_dob);
		unsigned recentcount;
		boolean isvalidformat;
		unsigned official_last_seen;
	end;

	suspicious_ssns := join(	did_ssn_dob,
						SSN_Table_v4_2(false), 
						left.ssn=right.ssn	and
						(	
							right.combo.recentcount >= 3 or 
							right.isvalidformat=false or 
							( 
								(unsigned)((string8)left.dob)[1..4] >  (unsigned)((string8)right.official_last_seen)[1..4] and 
								right.official_last_seen<>0
							)
						),
						transform(temprec,	
							self.recentcount := right.combo.recentcount;
							self.isvalidformat := right.isvalidformat;
							self.official_last_seen := right.official_last_seen;
							self := left));

	dids_with_suspicious_ssns := dedup(sort(suspicious_ssns, did, ssn), did);

	EXPORT Suspicious_Identities_Base :=  join(	suspicious_header,
										dids_with_suspicious_ssns, 
										left.did=right.did,
										transform(
											risk_indicators.Boca_Shell_Fraud.layout_identities_output - historydate, 
											self.did := if(left.did=0, right.did, left.did);
											self.bureau_only := left.did<>0 and left.bureau_records=left.total_records;
											firstseen31 := ((string)left.dt_first_seen)[1..6]+'31';
											self.bureau_only_last_1month := 	left.did<>0 and 
																		left.bureau_records=left.total_records and 
												risk_indicators.iid_constants.checkdays(risk_indicators.iid_constants.full_history_date(today),firstseen31,30, today);
											self.bureau_only_last_6months := 	left.did<>0 and 
																		left.bureau_records=left.total_records and 
																		risk_indicators.iid_constants.checkdays(risk_indicators.iid_constants.full_history_date(today),firstseen31, risk_indicators.iid_constants.sixmonths, today);
											self.suspicious_ssn := right.did<>0;
											self.ssn := if(right.did<>0, right.ssn, '');
											self.global_sid := 0;
											self.record_sid := 0;
											), 
										full outer);

	  export SSN_Table_v4(Boolean IsFCRA) := project(ssn_table_v4_2(IsFCRA), 
								 transform(Layouts.final_rec_v4,
									self.isDeceased := left.eq.isDeceased;
									self.dt_first_deceased := left.eq.dt_first_deceased;
									self.decs_dob := left.eq.decs_dob;
									self.decs_zip_lastres := left.eq.decs_zip_lastres;
									self.decs_zip_lastpayment := left.eq.decs_zip_lastpayment;
									self.decs_last := left.eq.decs_last;
									self.decs_first := left.eq.decs_first;
									self.combo.didcount_s18 := 0;
									self.eq.didcount_s18 := 0;
									self.en.didcount_s18 := 0;
									self.tn.didcount_s18 := 0;
									self := left));	



// New Files for Shell 5.3
//Logic for SSN_NAME_SUMMARY FILE
export phones_base_dte := project(gh(phone10<>''), transform(Layouts.phones_base_layout2, 
																																	self.src := 'GH', 
																																	self.zip := left.z5, 
																																	self.dt_first_seen  := (unsigned)(left.dt_first_seen[1..6]); 
																																	self.dt_last_seen		:= (unsigned)(left.dt_last_seen[1..6]); 
																																	self := left)); 	
export ssn_hdr := header_base(false)(trim(ssn)<>'');
export dob_hdr := header_base(false)(dob<>0);
export header_phone_base := header_base(false)(trim(phone)<>'');
																														
ssn_name_correlation_risk := table(ssn_name_hdr, {ssn, lname, fname, src, 
																			_dt_first_seen := MIN(GROUP,IF(dt_first_seen=0,constants.default_max_date,dt_first_seen)),  // get the real first seen date, avoid the records with dt_first_seen=0
																			_dt_last_seen := MAX(GROUP,dt_last_seen),
																			total := count(group)}, ssn, lname, fname, src, local);

ssn_name_summary_prep := project(ssn_name_correlation_risk, transform(layouts.ssn_name_summary, 
																 self.summary := dataset([{left.src, 
																													if(left._dt_first_seen=constants.default_max_date, 0, left._dt_first_seen),  // for any max dates, set them back to 0
																													left._dt_last_seen,
																													left.total}], layouts.common_layout);
																 self := left));

export ssn_name_summary := rollup(ssn_name_summary_prep, 
																	left.ssn=right.ssn and 
																	left.lname=right.lname and 
																	left.fname=right.fname,
																		transform(layouts.ssn_name_summary, 
																					self.summary := choosen( (left.summary + right.summary), constants.max_source_summary);
																					self := left) );


//Logic for SSN_ADDR_SUMMARY File
ssn_addr_correlation_risk := table(ssn_addr_hdr, {ssn, prim_name, prim_range, zip, src, 
																			_dt_first_seen := MIN(GROUP,IF(dt_first_seen=0,constants.default_max_date,dt_first_seen)),  // get the real first seen date, avoid the records with dt_first_seen=0
																			_dt_last_seen := MAX(GROUP,dt_last_seen),
																			total := count(group)}, ssn, prim_name, prim_range, zip, src, local);
																			
ssn_addr_summary_prep := project(ssn_addr_correlation_risk, transform(Layouts.ssn_addr_summary, 
																	self.summary := dataset([{left.src, 
																													if(left._dt_first_seen=constants.default_max_date, 0, left._dt_first_seen),  // for any max dates, set them back to 0
																													left._dt_last_seen,
																													left.total}], layouts.common_layout);
																	self := left));

export ssn_addr_summary := rollup(ssn_addr_summary_prep, 
																	left.ssn=right.ssn and 
																	left.prim_name=right.prim_name and 
																	left.prim_range=right.prim_range and 
																	left.zip=right.zip,
																	transform(layouts.ssn_addr_summary, 
																						self.summary := choosen( (left.summary + right.summary), constants.max_source_summary);
																						self := left) );


//Logic for ADDR_NAME_SUMMARY file
addr_name_correlation_risk := table(addr_name_hdr,{prim_name, prim_range, zip, lname, fname, src, 
																			_dt_first_seen := MIN(GROUP,IF(dt_first_seen=0,constants.default_max_date,dt_first_seen)),  // get the real first seen date, avoid the records with dt_first_seen=0
																			_dt_last_seen  := MAX(GROUP,dt_last_seen),
																			total := count(group)}, prim_name, prim_range, zip, lname, fname, src, local);

addr_name_summary_prep := project(addr_name_correlation_risk, transform(layouts.addr_name_summary, 
																	self.summary := dataset([{left.src, 
																													if(left._dt_first_seen=constants.default_max_date, 0, left._dt_first_seen),  // for any max dates, set them back to 0
																													left._dt_last_seen,
																													left.total}], layouts.common_layout);
																	self := left));

export addr_name_summary := rollup(addr_name_summary_prep, 
																		left.prim_name=right.prim_name and 
																		left.prim_range=right.prim_range and 
																		left.zip=right.zip and 
																		left.lname=right.lname and 
																		left.fname=right.fname,
																			transform(layouts.addr_name_summary, 
																								self.summary := choosen( (left.summary + right.summary), constants.max_source_summary);
																								self := left) );
//Logic for SSN_DOB_SUMAARY File
ssn_dob_src := table(ssn_hdr(dob<>0), {ssn, dob, src, 
																			_dt_first_seen := MIN(GROUP,IF(dt_first_seen=0,constants.default_max_date,dt_first_seen)),  // get the real first seen date, avoid the records with dt_first_seen=0
																			_dt_last_seen := MAX(GROUP,dt_last_seen),
																			total := count(group)}, 
																			ssn, dob, src, local);
																		
ssn_dob_summary_prep := project(ssn_dob_src , transform(layouts.ssn_dob_summary, 
																											 self.summary := dataset([{left.src, 
																																								if(left._dt_first_seen=constants.default_max_date, 0, left._dt_first_seen),  // for any max dates, set them back to 0
																																									left._dt_last_seen,
																																									left.total}], layouts.common_layout);
																												self := left));

export ssn_dob_summary := rollup(ssn_dob_summary_prep, 
																	left.ssn=right.ssn and 
																	left.dob=right.dob,
																		transform(layouts.ssn_dob_summary, 
																							self.summary := choosen( (left.summary + right.summary), constants.max_source_summary);
																							self := left) );
																							


// Logic for SSN_PHONE_SUMARRY File
ssn_phone_src := table(ssn_hdr(trim(phone)<>''), {ssn, phone, src, 
											 _dt_first_seen := MIN(GROUP,IF(dt_first_seen=0,constants.default_max_date,dt_first_seen)),  // get the real first seen date, avoid the records with dt_first_seen=0
											 _dt_last_seen := MAX(GROUP,dt_last_seen),
											 total := count(group)}, 
											 ssn, phone, src, local);

ssn_phone_summary_prep := project(ssn_phone_src, transform(layouts.ssn_phone_summary, 
																														self.summary := dataset([{left.src, 
																																										if(left._dt_first_seen=constants.default_max_date, 0, left._dt_first_seen),  // for any max dates, set them back to 0
																																										left._dt_last_seen,
																																										left.total}], layouts.common_layout);
																														self := left));

export ssn_phone_summary := rollup(ssn_phone_summary_prep, 
																	left.ssn=right.ssn and 
																	left.phone=right.phone,
																			transform(layouts.ssn_phone_summary, 
																								self.summary := choosen( (left.summary + right.summary), constants.max_source_summary);
																								self := left) );

											 

//Logic for PHONE_DOB_SUMMARY File
phone_dob_src := table(dob_hdr(trim(phone)<>''), {phone, dob, src, 
												_dt_first_seen := MIN(GROUP,IF(dt_first_seen=0,constants.default_max_date,dt_first_seen)),  // get the real first seen date, avoid the records with dt_first_seen=0
												_dt_last_seen  := MAX(GROUP,dt_last_seen),
												total := count(group)}, 
												phone, dob, src, local);

phone_dob_summary_prep := project(phone_dob_src, transform(layouts.phone_dob_summary, 
																													self.summary := dataset([{left.src, 
																																									if(left._dt_first_seen=constants.default_max_date, 0, left._dt_first_seen),  // for any max dates, set them back to 0
																																											left._dt_last_seen,
																																										left.total}], layouts.common_layout);
																													self := left));

export phone_dob_summary := rollup(phone_dob_summary_prep, 
																	left.phone=right.phone and 
																	left.dob=right.dob,
																			transform(layouts.phone_dob_summary, 
																								self.summary := choosen( (left.summary + right.summary), constants.max_source_summary);
																								self := left) );



//Logic for ADDR_DOB_SUMMARY File
addr_dob_src := table(dob_hdr(trim(prim_name)<>'' and trim(zip)<>''), {prim_name, prim_range, zip, dob, src, 
											_dt_first_seen := MIN(GROUP,IF(dt_first_seen=0, constants.default_max_date, dt_first_seen)),  // get the real first seen date, avoid the records with dt_first_seen=0
											_dt_last_seen  := MAX(GROUP,dt_last_seen),
											total := count(group)}, prim_name, prim_range, zip, dob, src, local);

addr_dob_summary_prep := project(addr_dob_src, transform(layouts.addr_dob_summary, 
																												 self.summary := dataset([{left.src, 
																																									if(left._dt_first_seen=constants.default_max_date, 0, left._dt_first_seen),  // for any max dates, set them back to 0
																																											left._dt_last_seen,
																																											left.total}], layouts.common_layout);
																													self := left));

export addr_dob_summary := rollup(addr_dob_summary_prep, 
																	left.prim_name=right.prim_name and 
																	left.prim_range=right.prim_range and 
																	left.zip=right.zip and 
																	left.dob=right.dob,
																		transform(layouts.addr_dob_summary, 
																							self.summary := choosen( (left.summary + right.summary), constants.max_source_summary);
																							self := left) );
											

//Logic for NAME_DBO_SUMMARY File
name_dob_src := table(dob_hdr(trim(lname)<>'' and trim(fname)<>''), 	{lname, fname, dob, src, 
											_dt_first_seen := MIN(GROUP,IF(dt_first_seen=0,constants.default_max_date,dt_first_seen)),  // get the real first seen date, avoid the records with dt_first_seen=0
											_dt_last_seen := MAX(GROUP,dt_last_seen),
											total := count(group)}, lname, fname, dob, src, local);


name_dob_summary_prep := project(name_dob_src, transform(layouts.name_dob_summary, 
																													self.summary := dataset([{left.src, 
																																										if(left._dt_first_seen=constants.default_max_date, 0, left._dt_first_seen),  // for any max dates, set them back to 0
																																										left._dt_last_seen,
																																										left.total}], layouts.common_layout);
																													self := left));

export name_dob_summary := rollup(name_dob_summary_prep, 
																	left.lname=right.lname and 
																	left.fname=right.fname and 
																	left.dob=right.dob,
																		transform(layouts.name_dob_summary, 
																							self.summary := choosen( (left.summary + right.summary), constants.max_source_summary);
																							self := left) );


//Logic PHONE_ADDR_SUMMARY file
phone_addr_correlation_risk := table(phones_base_dte, {phone10, prim_name, prim_range, zip, src, 
																			_dt_first_seen := MIN(GROUP,IF(dt_first_seen=0,constants.default_max_date,dt_first_seen)),  // get the real first seen date, avoid the records with dt_first_seen=0
																			_dt_last_seen  := MAX(GROUP,dt_last_seen),
																			total := count(group)}, 
																			phone10, prim_name, prim_range, zip, src, local);

phone_addr_summary_prep 			:= project(phone_addr_correlation_risk, transform(layouts.phone_addr_summary, 
																																	 self.summary := dataset([{left.src, 
																																														if(left._dt_first_seen=constants.default_max_date, 0, left._dt_first_seen),  // for any max dates, set them back to 0
																																															left._dt_last_seen,
																																															left.total}], layouts.common_layout);
																																		self := left));

export phone_addr_summary := rollup(phone_addr_summary_prep, 
																		left.phone10=right.phone10 and 
																		left.prim_name=right.prim_name and 
																		left.prim_range=right.prim_range and 
																		left.zip=right.zip,
																				transform(layouts.phone_addr_summary, 
																									self.summary := choosen( (left.summary + right.summary), constants.max_source_summary);
																									self := left) );


//Logic PHONE_ADDR_HEADER file
phone_addr_header_correlation_risk := table(header_phone_base(trim(prim_name)<>'' and trim(zip)<>''), 
																						{phone10 := phone, prim_name, prim_range, zip, src, 
																						_dt_first_seen := MIN(GROUP,IF(dt_first_seen=0,constants.default_max_date,dt_first_seen)),  // get the real first seen date, avoid the records with dt_first_seen=0
																						_dt_last_seen := MAX(GROUP,dt_last_seen),
																						total := count(group)}, 
																						phone, prim_name, prim_range, zip, src, local);

phone_addr_header_summary_prep := project(phone_addr_header_correlation_risk, transform(layouts.phone_addr_summary, 
																																												self.summary := dataset([{left.src, 
																																																								if(left._dt_first_seen=constants.default_max_date, 0, left._dt_first_seen),  // for any max dates, set them back to 0
																																																								left._dt_last_seen,
																																																								left.total}], layouts.common_layout);
																																												self := left));

export phone_addr_header_summary := rollup(phone_addr_header_summary_prep, 
																					left.phone10=right.phone10 and 
																					left.prim_name=right.prim_name and 
																					left.prim_range=right.prim_range and 
																					left.zip=right.zip,
																					transform(layouts.phone_addr_summary, 
																										self.summary := choosen( (left.summary + right.summary), constants.max_source_summary);
																										self := left) );

// Logic PHONE_LNAME_HEADER file
phone_lname_header_correlation_risk := table( header_phone_base(trim(lname)<>''), 	{phone10 := phone, name_last := lname, src, 
																							_dt_first_seen := MIN(GROUP,IF(dt_first_seen=0,constants.default_max_date,dt_first_seen)),  // get the real first seen date, avoid the records with dt_first_seen=0
																							_dt_last_seen := MAX(GROUP,dt_last_seen),
																							total := count(group)}, phone, lname, src, local);

phone_lname_header_summary_prep := project(phone_lname_header_correlation_risk, transform(layouts.phone_lname_summary, 
																																													self.summary := dataset([{left.src, 
																																																										if(left._dt_first_seen=constants.default_max_date, 0, left._dt_first_seen),  // for any max dates, set them back to 0
																																																										left._dt_last_seen,
																																																										left.total}], layouts.common_layout);
																																													self := left));
	
export phone_lname_header_summary := rollup(phone_lname_header_summary_prep, 
																		left.phone10=right.phone10 and 
																		left.name_last=right.name_last,
																		transform(layouts.phone_lname_summary, 
																							self.summary := choosen( (left.summary + right.summary), constants.max_source_summary);
																							self := left) );

//Logic PHONE_LNAME_SUMMARY file
phone_lname_correlation_risk := table( phones_base_dte(phone10 <> '' and name_last <> ''),	{phone10, name_last, src, 
																			_dt_first_seen := MIN(GROUP,IF(dt_first_seen=0,constants.default_max_date,dt_first_seen)),  // get the real first seen date, avoid the records with dt_first_seen=0
																			_dt_last_seen := MAX(GROUP,dt_last_seen),
																			total := count(group)}, phone10, name_last, src, local);
																			
phone_lname_summary_prep := project(phone_lname_correlation_risk, transform(layouts.phone_lname_summary, 
																																						self.summary := dataset([{left.src, 
																																																			if(left._dt_first_seen=constants.default_max_date, 0, left._dt_first_seen),  // for any max dates, set them back to 0
																																																				left._dt_last_seen,
																																																				left.total}], layouts.common_layout);
																																						self := left));

export phone_lname_summary := rollup(phone_lname_summary_prep, 
															left.phone10=right.phone10 and 
															left.name_last=right.name_last,
																	transform(layouts.phone_lname_summary, 
																						self.summary := choosen( (left.summary + right.summary), constants.max_source_summary);
																						self := left) );


END;