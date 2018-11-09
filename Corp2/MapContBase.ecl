import ut, address, _validate, corp2, Corp2_Mapping, mdr, Business_Header, Business_Header_SS;

EXPORT MapContBase (
										dataset(Corp2_Mapping.LayoutsCommon.Temporary) inContBase
									 ,dataset(Corp2_Mapping.LayoutsCommon.Temporary) inContMain
									 )	:= function;

	corp2.Layout_Corporate_Direct_Cont_Base_Expanded InitUpdate(Corp2_Mapping.LayoutsCommon.Temporary l) := transform
		self.dt_vendor_first_reported			:= (integer)l.corp_process_date;
		self.dt_vendor_last_reported			:= (integer)l.corp_process_date;
		self.corp_legal_name 							:= l.corp_legal_name;
		self.corp_address1_type_cd 				:= l.corp_address1_type_cd;
		self.corp_address1_type_desc			:= l.corp_address1_type_desc;
		self.corp_address1_line1 					:= l.corp_address1_line1;
		self.corp_address1_line2 					:= l.corp_address1_line2;
		self.corp_address1_line3 					:= l.corp_address1_line3;
		self.corp_address1_line4 					:= l.corp_address1_line4;
		self.corp_address1_line5 					:= l.corp_address1_line5;
		self.corp_address1_line6 					:= l.corp_address1_line6;
		self.corp_phone_number_type_cd		:= l.corp_phone_number_type_cd;
		self.corp_phone_number_type_desc	:= l.corp_phone_number_type_desc;
		self.cont_filing_cd 							:= l.cont_filing_cd;
		self.cont_filing_desc 						:= l.cont_filing_desc;
		self.cont_type_cd 								:= l.cont_type_cd;
		self.cont_type_desc 							:= l.cont_type_desc;
		self.cont_name 										:= l.cont_name;
		self.cont_title_desc 							:= l.cont_title_desc;
		self.cont_address_type_cd 				:= l.cont_address_type_cd;
		self.cont_address_type_desc 			:= l.cont_address_type_desc;
		self.cont_address_line1 					:= l.cont_address_line1;
		self.cont_address_line2 					:= l.cont_address_line2;
		self.cont_address_line3 					:= l.cont_address_line3;
		self.cont_address_line4 					:= l.cont_address_line4;
		self.cont_address_line5 					:= l.cont_address_line5;
		self.cont_address_line6 					:= l.cont_address_line6;
		self.cont_phone_number_type_cd 		:= l.cont_phone_number_type_cd;
		self.cont_phone_number_type_desc 	:= l.cont_phone_number_type_desc;
		self.dt_first_seen 								:= l.dt_first_seen;
		self.dt_last_seen 								:= l.dt_last_seen;
		self.corp_phone10 								:= address.CleanPhone(l.corp_phone_number);
		self.cont_phone10 								:= address.CleanPhone(l.cont_phone_number);
		self.record_type 									:= 'H';
		self.corp_sos_charter_nbr 				:= l.corp_orig_sos_charter_nbr;
		self 															:= l;
		self															:= [];
	end;
					
	cont_update_dist 			:= distribute(inContMain, hash(corp_key));
	cont_update_sort 			:= sort(cont_update_dist, record, local);
	cont_update_dedup	 		:= dedup(cont_update_sort, record, local);

	cont_update_mapped		:= project(cont_update_dedup, InitUpdate(left));

	// Filter out blank contact names
	cont_update_init_filter	:= cont_update_mapped((cont_lname <> '' or cont_cname <> '') and corp_key<> '');
				   
	// Initialize Current base file
	corp2.Layout_Corporate_Direct_Cont_base_Expanded InitCurrentBase(Corp2_Mapping.LayoutsCommon.Temporary l) := transform
		self.bdid							:= 0;
		self.record_type			:= 'H';
		self 									:= l;
		self									:= [];
	end;

	cont_current_init 			:= project(inContBase, InitCurrentBase(left));

	cont_current_init_dedup := dedup(sort(distribute(cont_current_init, hash(corp_key)), record, local), record, local);

	// Combine current base with update
	cont_update_combined := map(corp2.Flags.Update.main and corp2.flags.ExistMainV2CurrentSprayed =>
																cont_current_init_dedup + cont_update_init_filter,
															corp2.Flags.Update.main =>
																cont_current_init_dedup,
																cont_update_init_filter
														);
														
	corp2.Layout_Corporate_Direct_Cont_base_Expanded InitDates(Layout_Corporate_Direct_Cont_base_Expanded l) := transform
		dt_first_seen := 	ut.EarliestDate((unsigned4)fCheckDate(l.cont_filing_date), 
											ut.EarliestDate((unsigned4)fCheckDate(l.cont_effective_date), 
											ut.EarliestDate((unsigned4)fCheckDate(l.cont_address_effective_date), (unsigned4)fCheckDate(l.corp_process_date))));
		dt_last_seen 	:= 	if(
											MAX((unsigned4)fCheckDate(l.cont_filing_date), 
											MAX((unsigned4)fCheckDate(l.cont_effective_date), (unsigned4)fCheckDate(l.cont_address_effective_date))) <> 0,
											MAX((unsigned4)fCheckDate(l.cont_filing_date), 
											MAX((unsigned4)fCheckDate(l.cont_effective_date), (unsigned4)fCheckDate(l.cont_address_effective_date))),
											(unsigned4)fCheckDate(l.corp_process_date));
		dt_vendor_first_reported := 
											ut.EarliestDate((unsigned4)fCheckDate(l.cont_filing_date), 
											ut.EarliestDate((unsigned4)fCheckDate(l.cont_effective_date), 
											ut.EarliestDate((unsigned4)fCheckDate(l.cont_address_effective_date), (unsigned4)fCheckDate(l.corp_process_date))));

		self.dt_first_seen:= if(dt_first_seen < l.dt_first_seen, dt_first_seen, l.dt_first_seen);
		self.dt_last_seen	:= if(l.dt_last_seen = (unsigned4)l.corp_process_date or
															fCheckDate((string8)intformat(l.dt_last_seen, 8, 1)) = '' or
															(dt_last_seen < l.dt_last_seen), dt_last_seen, l.dt_last_seen);
		self.dt_vendor_first_reported := if(dt_vendor_first_reported < l.dt_vendor_first_reported, dt_vendor_first_reported, l.dt_vendor_first_reported);
		self := l;
	end;

	corp_cont_init := project(cont_update_combined, InitDates(left));
			   
	cont_update_combined_dist := distribute(corp_cont_init, hash(corp_key));
	
	corp2.Layout_Corporate_Direct_Cont_base_Expanded RollupUpdate(corp2.Layout_Corporate_Direct_Cont_base_Expanded l, corp2.Layout_Corporate_Direct_Cont_base_Expanded r) := transform
		SELF.dt_first_seen 						:= ut.EarliestDate(	ut.EarliestDate(l.dt_first_seen,r.dt_first_seen),
																											ut.EarliestDate(l.dt_last_seen,r.dt_last_seen)
																										);
		SELF.dt_last_seen 						:= Max(l.dt_last_seen,r.dt_last_seen);
		SELF.dt_vendor_last_reported	:= Max(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
		SELF.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
		SELF.corp_process_date 				:= if(l.corp_process_date > r.corp_process_date, l.corp_process_date, r.corp_process_date);
		self := l;
	end;

	// Rollup dates for identical records
	cont_update_combined_sort := sort(cont_update_combined_dist, except bdid, did, dt_first_seen, dt_last_seen,
																		dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, record_type,
																		// Exclude clean address fields
																		corp_addr1_prim_range, corp_addr1_predir, corp_addr1_prim_name, corp_addr1_addr_suffix,
																		corp_addr1_postdir, corp_addr1_unit_desig, corp_addr1_sec_range, corp_addr1_p_city_name,
																		corp_addr1_v_city_name, corp_addr1_state, corp_addr1_zip5, corp_addr1_zip4,
																		corp_addr1_cart, corp_addr1_cr_sort_sz, corp_addr1_lot, corp_addr1_lot_order,
																		corp_addr1_dpbc, corp_addr1_chk_digit, corp_addr1_rec_type, corp_addr1_ace_fips_st,
																		corp_addr1_county, corp_addr1_geo_lat, corp_addr1_geo_long, corp_addr1_msa,
																		corp_addr1_geo_blk, corp_addr1_geo_match, corp_addr1_err_stat, cont_prim_range,
																		cont_predir, cont_prim_name, cont_addr_suffix, cont_postdir, cont_unit_desig,
																		cont_sec_range, cont_p_city_name, cont_v_city_name, cont_state, cont_zip5,
																		cont_zip4, cont_cart, cont_cr_sort_sz, cont_lot, cont_lot_order, cont_dpbc,
																		cont_chk_digit, cont_rec_type, cont_ace_fips_st, cont_county, cont_geo_lat,
																		cont_geo_long, cont_msa, cont_geo_blk, cont_geo_match, cont_err_stat,
																		corp_orig_sos_charter_nbr, 
																		//except linkids
																		DotID, DotScore, DotWeight, EmpID, EmpScore, EmpWeight, POWID, POWScore, POWWeight, 
																		ProxID, ProxScore, ProxWeight, SELEID, SELEScore, SELEWeight, OrgID, OrgScore, OrgWeight,
																		UltID, UltScore, UltWeight, local);

cont_update_combined_rollup := rollup(cont_update_combined_sort, RollupUpdate(left, right), except bdid, did, dt_first_seen, 
																			dt_last_seen, dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, record_type,
																			// Exclude clean address fields
																			corp_addr1_prim_range, corp_addr1_predir, corp_addr1_prim_name, corp_addr1_addr_suffix,
																			corp_addr1_postdir, corp_addr1_unit_desig, corp_addr1_sec_range, corp_addr1_p_city_name,
																			corp_addr1_v_city_name, corp_addr1_state, corp_addr1_zip5, corp_addr1_zip4, corp_addr1_cart,
																			corp_addr1_cr_sort_sz, corp_addr1_lot, corp_addr1_lot_order, corp_addr1_dpbc,
																			corp_addr1_chk_digit, corp_addr1_rec_type, corp_addr1_ace_fips_st, corp_addr1_county,
																			corp_addr1_geo_lat, corp_addr1_geo_long, corp_addr1_msa, corp_addr1_geo_blk,
																			corp_addr1_geo_match, corp_addr1_err_stat, cont_prim_range, cont_predir,
																			cont_prim_name, cont_addr_suffix, cont_postdir, cont_unit_desig, cont_sec_range,
																			cont_p_city_name, cont_v_city_name, cont_state, cont_zip5, cont_zip4, cont_cart,
																			cont_cr_sort_sz, cont_lot, cont_lot_order, cont_dpbc, cont_chk_digit, cont_rec_type,
																			cont_ace_fips_st, cont_county, cont_geo_lat, cont_geo_long, cont_msa, cont_geo_blk,
																			cont_geo_match, cont_err_stat, corp_orig_sos_charter_nbr, 
																			//except linkids
																			DotID, DotScore, DotWeight, EmpID, EmpScore, EmpWeight, POWID, POWScore, POWWeight,
																			proxID, ProxScore, ProxWeight, SELEID, SELEScore, SELEWeight, OrgID, OrgScore, OrgWeight,
																			UltID, UltScore, UltWeight, local);

	// Set Current - Historical Indicator
	cont_combined_rollup_sort	:= sort(cont_update_combined_rollup, corp_key, -dt_vendor_last_reported, -dt_last_seen, local);
	cont_combined_rollup_grpd := group(cont_combined_rollup_sort, corp_key, local):independent;

	corp2.Layout_Corporate_Direct_Cont_base_Expanded SetRecordType(corp2.Layout_Corporate_Direct_Cont_base_Expanded L, corp2.Layout_Corporate_Direct_Cont_base_Expanded R) := transform
		isdatethesame 					:= if(l.dt_vendor_last_reported != 0 and l.dt_vendor_last_reported = r.dt_vendor_last_reported, true,false);
		ispreviousrecordcurrent := if(l.record_type = 'C',true, false);
		isfirstrecord 					:= if(l.record_type = '',true, false);
		decision 								:= if(isfirstrecord or (isdatethesame and ispreviousrecordcurrent), 'C', r.record_type);

		self.record_type				:= decision;
		self := r;
	end;

	cont_update := group(iterate(cont_combined_rollup_grpd, SetRecordType(left, right)));

	temp_source_lay := record
		corp2.Layout_Corporate_Direct_Cont_Base_Expanded;
		string2 source_code;
	end;

	temp_source_lay AddSourceCode(corp2.Layout_Corporate_Direct_Cont_base_Expanded l) := transform
		self.source_code							:= MDR.sourceTools.fCorpV2(l.corp_key, l.corp_state_origin);
		self := l;
	end;

	// BDID Corporate records
	cont_to_bdid := project(cont_update, AddSourceCode(left));

	Business_Header.MAC_Source_Match(	cont_to_bdid, cont_bdid_init, FALSE, bdid,
																		true, source_code, TRUE, corp_key,
																		corp_legal_name, corp_addr1_prim_range, 
																		corp_addr1_prim_name, corp_addr1_sec_range, 
																		corp_addr1_zip5, TRUE, corp_phone10,
																		FALSE, corp_fed_tax_id, TRUE, corp_key);

	cont_to_bdid_dist	:= distribute(cont_bdid_init, RANDOM() % 50);


	// Then do a standard BDID match for the records which did not BDID,
	// since the Corporate file may be newer than the Business Headers
	BDID_Matchset := ['A'];

	Business_Header_SS.MAC_Add_BDID_Flex(	cont_to_bdid_dist, BDID_Matchset, corp_legal_name,
																				corp_addr1_prim_range, corp_addr1_prim_name, 
																				corp_addr1_zip5, corp_addr1_sec_range, 
																				corp_addr1_state, corp_phone10, corp_fed_tax_id,
																				bdid, temp_source_lay, FALSE, BDID_score_field,
																				cont_bdid_rematch,,,,BIPV2.xlink_version_set,,,,
																				cont_fname, cont_mname, cont_lname,cont_ssn);

	cont_bdid_all := cont_bdid_rematch : independent;

	Layout_Corporate_Direct_Cont_Base_DID := record
		unsigned6 uid := 0;
		corp2.Layout_Corporate_Direct_Cont_base_Expanded;
		unsigned6 adl := 0;
		unsigned1 adl_score := 0;
	end;

	cont_did_init := project(cont_bdid_all, transform(Layout_Corporate_Direct_Cont_Base_DID, self := left));

	ut.MAC_Sequence_Records(cont_did_init, uid, cont_did_seq);

	layout_corp_cont_slim := record
		unsigned6 uid;
		unsigned6 adl;
		unsigned1 adl_score;
		string20  cont_fname;
		string20  cont_mname;
		string20  cont_lname;
		string5   cont_name_suffix;
		string9   cont_ssn;
		string8   cont_dob;
		string10  cont_prim_range;
		string28  cont_prim_name;
		string8   cont_sec_range;
		string2   cont_state;
		string5   cont_zip5;
		string10  cont_phone10;
	end;

	// Normalize to use both contact and corporate address and phone information
	layout_corp_cont_slim NormCorpCont(Layout_Corporate_Direct_Cont_Base_DID l, unsigned1 cnt) := transform,
			skip(	cnt = 1 and corp2.t2u(l.cont_prim_range+l.cont_prim_name+l.cont_sec_range+l.cont_state+l.cont_zip5+l.cont_phone10) = '' or
						cnt = 2 and corp2.t2u(l.corp_addr1_prim_range+l.corp_addr1_prim_name+l.corp_addr1_sec_range+l.corp_addr1_state+l.corp_addr1_zip5+l.corp_phone10) = '')
		self.cont_prim_range	:= choose(cnt, l.cont_prim_range, l.corp_addr1_prim_range);
		self.cont_prim_name 	:= choose(cnt, l.cont_prim_name, l.corp_addr1_prim_name);
		self.cont_sec_range		:= choose(cnt, l.cont_sec_range, l.corp_addr1_sec_range);
		self.cont_state				:= choose(cnt, l.cont_state, l.corp_addr1_state);
		self.cont_zip5				:= choose(cnt, l.cont_zip5, l.corp_addr1_zip5);
		self.cont_phone10			:= choose(cnt, l.cont_phone10, l.corp_phone10);
		self									:= l;
	end;

	cont_to_did 			:= normalize(cont_did_seq, 2, NormCorpCont(left, counter));
	cont_to_did_dedup := dedup(cont_to_did, all);
	cont_to_did_dist	:= distribute(cont_to_did_dedup, RANDOM() % 50);

	// Match to Headers by Contact Name and Address
	Cont_Matchset := ['A','D','S','P'];

	DID_Add.MAC_Match_Flex(	cont_to_did_dist, Cont_Matchset, cont_ssn, cont_dob, 
													cont_fname, cont_mname, cont_lname, cont_name_suffix, 
													cont_prim_range, cont_prim_name, cont_sec_range, 
													cont_zip5, cont_state, cont_phone10, adl,
													layout_corp_cont_slim, 
													TRUE, adl_score,
													75,
													cont_did_all);

	// dedup, keep highest score	 
	cont_did_dist		:= distribute(cont_did_all, hash(uid));
	cont_did_sort		:= sort(cont_did_dist, uid, if(adl <> 0, 0, 1), -adl_score, local);
	cont_did_dedup	:= dedup(cont_did_sort, uid, local);

	// Assign dids to original records
	cont_did_seq_dist := distribute(cont_did_seq, hash(uid));
		 
	corp2.Layout_Corporate_Direct_Cont_base_Expanded AssignDIDs(Layout_Corporate_Direct_Cont_Base_DID l, layout_corp_cont_slim r) := transform
		self.did := if(r.adl <> 0, r.adl, 0);
		self := l;
	end;

	cont_did_append := join(cont_did_seq_dist,
													cont_did_dedup,
													left.uid = right.uid,
													AssignDIDs(left, right),
													left outer,
													local);
													
	corp2.Layout_Corporate_Direct_Cont_base_Expanded 	trfSuppress(corp2.Layout_Corporate_Direct_Cont_base_Expanded pinput)	:=	transform
		self.did	:=	if(pInput.did=2282107993 and pInput.corp_key='36-4078164',
												0,
												pInput.did);
		self			:=	pInput;
	end;
													
	SuppressLexid	:=	project (cont_did_append, trfSuppress(left));
							
	cont_did_append_Sort := sort(SuppressLexid,record,local);	
							
	returndataset := cont_did_append_Sort;

	return returndataset;

end;