import ut, address, _validate, corp2, Corp2_Mapping, mdr, Business_Header_SS, Business_Header;

EXPORT MapCorpBase(
										dataset(Corp2_Mapping.LayoutsCommon.Temporary)	inCorpBase
									 ,dataset(Corp2_Mapping.LayoutsCommon.Temporary) 	inCorpMain
									 ,dataset(Corp2_Mapping.LayoutsCommon.Temporary)	inUniqueContNames
									 ,dataset(Corp2.Layout_Corp_EventDate)						inEvents
									 )	:= function;

	Corp2.Layout_Corporate_Direct_Corp_Base_expanded InitUpdate(Corp2_Mapping.LayoutsCommon.Temporary l) := transform
		self.corp_legal_name 								:= l.corp_legal_name;
		self.corp_address1_type_cd					:= l.corp_address1_type_cd;
		self.corp_address1_type_desc				:= l.corp_address1_type_desc;
		self.corp_address1_line1						:= l.corp_address1_line1;
		self.corp_address1_line2						:= l.corp_address1_line2;
		self.corp_address1_line3						:= l.corp_address1_line3;
		self.corp_address1_line4						:= l.corp_address1_line4;
		self.corp_address1_line5						:= l.corp_address1_line5;
		self.corp_address1_line6						:= l.corp_address1_line6;
		self.corp_address2_type_cd					:= l.corp_address2_type_cd;
		self.corp_address2_type_desc				:= l.corp_address2_type_desc;
		self.corp_address2_line1						:= l.corp_address2_line1;
		self.corp_address2_line2						:= l.corp_address2_line2;
		self.corp_address2_line3						:= l.corp_address2_line3;
		self.corp_address2_line4						:= l.corp_address2_line4;
		self.corp_address2_line5						:= l.corp_address2_line5;
		self.corp_address2_line6						:= l.corp_address2_line6;
		self.corp_phone_number_type_cd			:= l.corp_phone_number_type_cd;
		self.corp_phone_number_type_desc 		:= l.corp_phone_number_type_desc;
		self.corp_filing_cd 								:= l.corp_filing_cd;
		self.corp_filing_desc								:= l.corp_filing_desc;
		self.corp_status_cd									:= l.corp_status_cd;
		self.corp_status_desc								:= l.corp_status_desc;
		self.corp_term_exist_cd							:= l.corp_term_exist_cd;
		self.corp_term_exist_exp						:= l.corp_term_exist_exp;
		self.corp_term_exist_desc						:= if(trim(l.corp_term_exist_exp,left,right) in ['','0'] and
																						trim(l.corp_term_exist_desc,left,right) = 'NUMBER OF YEARS',
																						'',
																						case(l.corp_term_exist_cd,
																								'D' => 'DATE OF EXPIRATION',
																								'N' => if(_validate.date.fIsValid(l.corp_term_exist_exp),
																													'DATE OF EXPIRATION',
																													'NUMBER OF YEARS'),
																								'P' => 'PERPETUAL',
																								'U' => 'UNKNOWN',
																								l.corp_term_exist_desc)
																					);
		self.corp_foreign_domestic_ind			:= l.corp_foreign_domestic_ind;
		self.corp_forgn_state_cd						:= l.corp_forgn_state_cd;
		self.corp_forgn_state_desc					:= l.corp_forgn_state_desc;
		self.corp_forgn_term_exist_cd				:= l.corp_forgn_term_exist_cd;
		self.corp_forgn_term_exist_exp			:= l.corp_forgn_term_exist_exp;
		self.corp_forgn_term_exist_desc			:= l.corp_forgn_term_exist_desc;
		self.corp_orig_org_structure_cd			:= l.corp_orig_org_structure_cd;
		self.corp_orig_org_structure_desc		:= l.corp_orig_org_structure_desc;
		self.corp_for_profit_ind						:= l.corp_for_profit_ind;
		self.corp_orig_bus_type_cd					:= l.corp_orig_bus_type_cd;
		self.corp_orig_bus_type_desc				:= l.corp_orig_bus_type_desc;
		self.corp_ra_name										:= l.corp_ra_full_name;
		self.corp_ra_title_cd								:= l.corp_ra_title_cd;
		self.corp_ra_title_desc							:= l.corp_ra_title_desc;
		self.corp_ra_address_type_cd				:= l.corp_ra_address_type_cd;
		self.corp_ra_address_type_desc			:= l.corp_ra_address_type_desc;
		self.corp_ra_address_line1					:= l.corp_ra_address_line1;
		self.corp_ra_address_line2					:= l.corp_ra_address_line2;
		self.corp_ra_address_line3					:= l.corp_ra_address_line3;
		self.corp_ra_address_line4					:= l.corp_ra_address_line4;
		self.corp_ra_address_line5					:= l.corp_ra_address_line5;
		self.corp_ra_address_line6					:= l.corp_ra_address_line6;
		self.corp_ra_phone_number_type_cd		:= l.corp_ra_phone_number_type_cd;
		self.corp_ra_phone_number_type_desc := l.corp_ra_phone_number_type_desc;
	// Fix problem with MS dates
		self.corp_ra_effective_date 				:= if(l.corp_state_origin = 'MS' and (integer)l.corp_process_date < 20040321,
																						l.corp_ra_effective_date[5..8] + l.corp_ra_effective_date[1..2] + l.corp_ra_effective_date[3..4],
																						l.corp_ra_effective_date);
		self.dt_first_seen									:= l.dt_first_seen;
		self.dt_last_seen										:= l.dt_last_seen;
		self.dt_vendor_first_reported				:= l.dt_vendor_first_reported;
		self.dt_vendor_last_reported				:= l.dt_vendor_last_reported;
		self.corp_ra_dt_first_seen					:= l.corp_ra_dt_first_seen;
		self.corp_ra_dt_last_seen						:= l.corp_ra_dt_last_seen;
		self.corp_phone10										:= address.CleanPhone(l.corp_phone_number);
		self.corp_ra_phone10								:= address.CleanPhone(l.corp_ra_phone_number);
		self.record_type										:= 'H';
		self.corp_sos_charter_nbr						:= l.corp_orig_sos_charter_nbr;
		self.corp_supp_key                  := l.corp_supp_key;
		self.corp_vendor_county             := l.corp_vendor_county;
		self.corp_vendor_subcode            := l.corp_vendor_subcode;
		self.corp_src_type                  := l.corp_src_type;
		self.corp_ln_name_type_cd           := l.corp_ln_name_type_cd;
		self.corp_ln_name_type_desc         := l.corp_ln_name_type_desc;
		self.corp_supp_nbr                  := l.corp_supp_nbr;
		self.corp_name_comment              := l.corp_name_comment;
		self.corp_fax_nbr                   := l.corp_fax_nbr;
		self.corp_standing                  := l.corp_standing;
		self.corp_status_comment            := l.corp_status_comment;
		self.corp_inc_county                := l.corp_inc_county;
		self.corp_anniversary_month         := l.corp_anniversary_month;
		self.corp_public_or_private_ind     := l.corp_public_or_private_ind;
		self.corp_naic_code                 := l.corp_naic_code;
		self.corp_entity_desc               := l.corp_entity_desc;
		self.corp_certificate_nbr           := l.corp_certificate_nbr;
		self.corp_internal_nbr              := l.corp_internal_nbr;
		self.corp_previous_nbr              := l.corp_previous_nbr;
		self.corp_microfilm_nbr             := l.corp_microfilm_nbr;
		self.corp_amendments_filed          := l.corp_amendments_filed;
		self.corp_acts                      := l.corp_acts;
		self.corp_partnership_ind           := l.corp_partnership_ind;
		self.corp_mfg_ind                   := l.corp_mfg_ind;
		self.corp_addl_info                 := l.corp_addl_info;
		self.corp_taxes                     := l.corp_taxes;
		self.corp_franchise_taxes           := l.corp_franchise_taxes;
		self.corp_tax_program_cd            := l.corp_tax_program_cd;
		self.corp_tax_program_desc          := l.corp_tax_program_desc;
		self.corp_ra_resign_date            := l.corp_ra_resign_date;
		self.corp_ra_no_comp                := l.corp_ra_no_comp;
		self.corp_ra_no_comp_igs            := l.corp_ra_no_comp_igs;
		self.corp_ra_addl_info              := l.corp_ra_addl_info;
		self.corp_ra_fax_nbr                := l.corp_ra_fax_nbr;
		self																:= l; 
	end;

	corp_update_dist 	:= distribute(inCorpMain, hash(corp_key));
	corp_update_sort 	:= sort(corp_update_dist, record, local);
	corp_update_dedup := dedup(corp_update_sort, record, local);

	corp_update_init 	:= project(corp_update_dedup, InitUpdate(left));

	Corp2.Layout_Corporate_Direct_Corp_Base_expanded InitCurrentBase(Corp2_Mapping.LayoutsCommon.Temporary l) := transform
		self.bdid 								:=  0;
		self.record_type 					:= 'H';
		self.corp_term_exist_desc := if(trim(l.corp_term_exist_exp,left,right) in ['','0'] and
																trim(l.corp_term_exist_desc,left,right) = 'NUMBER OF YEARS',
																'',
																case(l.corp_term_exist_cd,
																		'D' => 'DATE OF EXPIRATION',
																		'N' => if(_validate.date.fIsValid(l.corp_term_exist_exp),
																							'DATE OF EXPIRATION',
																							'NUMBER OF YEARS'),
																		'P' => 'PERPETUAL',
																		'U' => 'UNKNOWN',
																		l.corp_term_exist_desc)
																);
		self 											:= l;
		
	end;

	corp_current_init 			:= project(inCorpBase, InitCurrentBase(left));
	corp_current_init_dist	:= distribute(corp_current_init, hash(corp_key));

	corp_update_combined 		:= map(	corp2.Flags.update.main and corp2.flags.ExistMainV2CurrentSprayed =>
																		corp_current_init_dist + corp_update_init,
																	corp2.Flags.Update.main =>
																		corp_current_init_dist,
																	corp_update_init
																);
																
	corp_update_combined_dist	:= distribute(corp_update_combined, hash(corp_key));																
												
	corp_combined_sort 			:= sort(	corp_update_combined_dist, except bdid, dt_first_seen, dt_last_seen,
																		dt_vendor_first_reported, dt_vendor_last_reported, corp_ra_dt_first_seen,
																		corp_ra_dt_last_seen, corp_process_date, corp_status_date, record_type, 
																		corp_addr1_prim_range, corp_addr1_predir, corp_addr1_prim_name, corp_addr1_addr_suffix,
																		corp_addr1_postdir, corp_addr1_unit_desig, corp_addr1_sec_range, corp_addr1_p_city_name,
																		corp_addr1_v_city_name, corp_addr1_state, corp_addr1_zip5, corp_addr1_zip4, corp_addr1_cart,
																		corp_addr1_cr_sort_sz, corp_addr1_lot, corp_addr1_lot_order, corp_addr1_dpbc, corp_addr1_chk_digit,
																		corp_addr1_rec_type, corp_addr1_ace_fips_st, corp_addr1_county, corp_addr1_geo_lat, 
																		corp_addr1_geo_long, corp_addr1_msa, corp_addr1_geo_blk, corp_addr1_geo_match, corp_addr1_err_stat, 
																		corp_addr2_prim_range, corp_addr2_predir, corp_addr2_prim_name, corp_addr2_addr_suffix, 
																		corp_addr2_postdir, corp_addr2_unit_desig, corp_addr2_sec_range, corp_addr2_p_city_name,
																		corp_addr2_v_city_name, corp_addr2_state, corp_addr2_zip5, corp_addr2_zip4, corp_addr2_cart,
																		corp_addr2_cr_sort_sz, corp_addr2_lot, corp_addr2_lot_order, corp_addr2_dpbc, corp_addr2_chk_digit,
																		corp_addr2_rec_type, corp_addr2_ace_fips_st, corp_addr2_county, corp_addr2_geo_lat,
																		corp_addr2_geo_long, corp_addr2_msa, corp_addr2_geo_blk, corp_addr2_geo_match, corp_addr2_err_stat,
																		corp_ra_prim_range, corp_ra_predir, corp_ra_prim_name, corp_ra_addr_suffix, corp_ra_postdir,
																		corp_ra_unit_desig, corp_ra_sec_range, corp_ra_p_city_name, corp_ra_v_city_name, corp_ra_state,
																		corp_ra_zip5, corp_ra_zip4, corp_ra_cart, corp_ra_cr_sort_sz, corp_ra_lot, corp_ra_lot_order,
																		corp_ra_dpbc, corp_ra_chk_digit, corp_ra_rec_type, corp_ra_ace_fips_st, corp_ra_county,
																		corp_ra_geo_lat, corp_ra_geo_long, corp_ra_msa, corp_ra_geo_blk, corp_ra_geo_match,
																		corp_ra_err_stat, corp_orig_sos_charter_nbr, local);															 
													
	Corp2.Layout_Corporate_Direct_Corp_Base_expanded RollupUpdate(Corp2.Layout_Corporate_Direct_Corp_Base_expanded l, Corp2.Layout_Corporate_Direct_Corp_Base_expanded r) := transform
		self.dt_first_seen						:= ut.EarliestDate(	ut.EarliestDate(l.dt_first_seen,r.dt_first_seen),
																											ut.EarliestDate(l.dt_last_seen,r.dt_last_seen)
																										 );
		self.dt_last_seen							:= Max(l.dt_last_seen,r.dt_last_seen);
		self.dt_vendor_last_reported	:= Max(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
		self.dt_vendor_first_reported	:= ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
		self.corp_ra_dt_first_seen		:= ut.EarliestDate(l.corp_ra_dt_first_seen, r.corp_ra_dt_first_seen);
		self.corp_ra_dt_last_seen			:= Max(l.corp_ra_dt_last_seen, r.corp_ra_dt_last_seen);
		self.corp_status_date					:= (string)Max((integer)l.corp_status_date,(integer)r.corp_status_date);
		self.corp_process_date				:= if(l.corp_process_date > r.corp_process_date, l.corp_process_date, r.corp_process_date);
		self.source_rec_id						:= if(l.source_rec_id = 0, r.source_rec_id, l.source_rec_id);
		self := l;
	end;

	corp_combined_rollup := rollup(	corp_combined_sort, RollupUpdate(left, right), except bdid, dt_first_seen, dt_last_seen,
																	dt_vendor_first_reported, dt_vendor_last_reported, corp_ra_dt_first_seen,
																	corp_ra_dt_last_seen, corp_process_date, corp_status_date, record_type, 
																	corp_addr1_prim_range, corp_addr1_predir, corp_addr1_prim_name, corp_addr1_addr_suffix,
																	corp_addr1_postdir, corp_addr1_unit_desig, corp_addr1_sec_range, corp_addr1_p_city_name,
																	corp_addr1_v_city_name, corp_addr1_state, corp_addr1_zip5, corp_addr1_zip4, corp_addr1_cart,
																	corp_addr1_cr_sort_sz, corp_addr1_lot, corp_addr1_lot_order, corp_addr1_dpbc, corp_addr1_chk_digit,
																	corp_addr1_rec_type, corp_addr1_ace_fips_st, corp_addr1_county, corp_addr1_geo_lat, 
																	corp_addr1_geo_long, corp_addr1_msa, corp_addr1_geo_blk, corp_addr1_geo_match, corp_addr1_err_stat, 
																	corp_addr2_prim_range, corp_addr2_predir, corp_addr2_prim_name, corp_addr2_addr_suffix, 
																	corp_addr2_postdir, corp_addr2_unit_desig, corp_addr2_sec_range, corp_addr2_p_city_name,
																	corp_addr2_v_city_name, corp_addr2_state, corp_addr2_zip5, corp_addr2_zip4, corp_addr2_cart,
																	corp_addr2_cr_sort_sz, corp_addr2_lot, corp_addr2_lot_order, corp_addr2_dpbc, corp_addr2_chk_digit,
																	corp_addr2_rec_type, corp_addr2_ace_fips_st, corp_addr2_county, corp_addr2_geo_lat,
																	corp_addr2_geo_long, corp_addr2_msa, corp_addr2_geo_blk, corp_addr2_geo_match, corp_addr2_err_stat,
																	corp_ra_prim_range, corp_ra_predir, corp_ra_prim_name, corp_ra_addr_suffix, corp_ra_postdir,
																	corp_ra_unit_desig, corp_ra_sec_range, corp_ra_p_city_name, corp_ra_v_city_name, corp_ra_state,
																	corp_ra_zip5, corp_ra_zip4, corp_ra_cart, corp_ra_cr_sort_sz, corp_ra_lot, corp_ra_lot_order,
																	corp_ra_dpbc, corp_ra_chk_digit, corp_ra_rec_type, corp_ra_ace_fips_st, corp_ra_county,
																	corp_ra_geo_lat, corp_ra_geo_long, corp_ra_msa, corp_ra_geo_blk, corp_ra_geo_match,
																	corp_ra_err_stat, corp_orig_sos_charter_nbr, local);	
												
	// Set Current - Historical Indicator
	corp_combined_rollup_sort := sort(corp_combined_rollup, corp_key, -dt_vendor_last_reported, -dt_last_seen, local);
	corp_combined_rollup_grpd := group(corp_combined_rollup_sort, corp_key, local):independent;

	corp2.Layout_Corporate_Direct_Corp_Base_expanded SetRecordType(corp2.Layout_Corporate_Direct_Corp_Base_expanded L, corp2.Layout_Corporate_Direct_Corp_Base_expanded R) := transform

		isdatethesame 					:= if(l.dt_vendor_last_reported != 0 and l.dt_vendor_last_reported = r.dt_vendor_last_reported, true,false);
		ispreviousrecordcurrent := if(l.record_type = 'C',true, false);
		isfirstrecord 					:= if(l.record_type = '',true, false);
		decision 								:= if(isfirstrecord or (isdatethesame and ispreviousrecordcurrent), 'C', r.record_type);

		self.record_type				:= decision;
		self										:= r;

	end;

	corp_update := group(iterate(corp_combined_rollup_grpd, SetRecordType(left, right)));	
	
	layout_corp_srcCode	:=	record
		corp2.Layout_Corporate_Direct_Corp_Base_expanded;
		string2 source_code;
	end;
	
	layout_corp_srcCode tPopulateSourceCode(Corp2.Layout_Corporate_Direct_Corp_Base_Expanded l) := transform
		self.source_code			:= 	MDR.sourceTools.fCorpV2(l.corp_key, l.corp_state_origin);
		self.corp_status_date	:=	if((integer)l.corp_status_date=0,'',l.corp_status_date);	
		self 		:= l;
	end;

	corp_to_bdid	:= project(corp_update,	tPopulateSourceCode(left));
	
	CorpWithContacts	:=	record
		layout_corp_srcCode;
		string20 cont_fname;
		string20 cont_mname;
		string20 cont_lname;
	end;
	
	CorpWithContacts joinForContacts(	layout_corp_srcCode l, Corp2_Mapping.LayoutsCommon.Temporary r) := transform
		self.cont_lname	:=	r.cont_lname;
		self.cont_mname	:=	r.cont_mname;
		self.cont_fname	:=	r.cont_fname;	
		self						:=	l;
	end;
	
	joinedWithContacts	:=	join(	
															corp_to_bdid,
															inUniqueContNames,
															left.corp_key=right.corp_key,
															joinForContacts(left,right),
															left outer,
															local
														 );
														 
	corp_to_bdid_dist	:= distribute(joinedWithContacts, RANDOM() % 50);

	
	//Do a standard BDID match for the records 
	BDID_Matchset := ['A'];

	Business_Header_SS.MAC_Add_BDID_Flex(	corp_to_bdid_dist,
																				BDID_Matchset,
																				corp_legal_name,
																				corp_addr1_prim_range, corp_addr1_prim_name, corp_addr1_zip5,
																				corp_addr1_sec_range, corp_addr1_state,
																				corp_phone10, corp_fed_tax_id,
																				bdid, CorpWithContacts,
																				FALSE, BDID_score_field,
																				corp_bdid_corp_addr,,,,
																				BIPV2.xlink_version_set,,,,
																				cont_fname,
																				cont_mname,
																				cont_lname,,source_code,source_rec_id,false);

	corp_bdid_withBDID 			:= corp_bdid_corp_addr(bdid!=0);	
	corp_bdid_withOutBDID 	:= corp_bdid_corp_addr(bdid=0);																				
					  
	// BDID Corporate records (source matching) 2nd pass
	Business_Header.MAC_Source_Match(	corp_bdid_withOutBDID, corp_bdid_source,
																		FALSE, bdid,
																		true, source_code,
																		TRUE, corp_key,
																		corp_legal_name,
																		corp_addr1_prim_range, corp_addr1_prim_name, corp_addr1_sec_range, corp_addr1_zip5,
																		TRUE, corp_phone10,
																		TRUE, corp_fed_tax_id,
																		TRUE, corp_key) ;
								 
	corp_bdid_all	:=	distribute(project((corp_bdid_withBDID + corp_bdid_source),transform(Corp2.Layout_Corporate_Direct_Corp_Base_Expanded,self:=left;)),hash(corp_key));
	
	deDupCorp		:=	dedup(sort(corp_bdid_all,record,local),record,local);

	Layout_Add_EventDate := record
		corp2.Layout_Corporate_Direct_Corp_Base_expanded;
		unsigned4 event_filing_date;
	end;
		
	Layout_Add_EventDate AddEvent(corp2.Layout_Corporate_Direct_Corp_Base_expanded l, inEvents r) := transform
				self.event_filing_date	:=	if(_validate.date.fIsValid((string)r.event_filing_date),r.event_filing_date,0);
				self 										:= 	l;
		end;			
		
	ds_combined1 := join(	deDupCorp,
												inEvents,
												left.corp_key = right.corp_key and
												(
                              (     left.dt_vendor_first_reported = right.dt_vendor_first_reported
                                and left.dt_vendor_last_reported  = right.dt_vendor_last_reported
                              )
                        )
                        ,
												AddEvent(left,right),
												left outer, local,keep(1));
												
  ds_combined1_nomatch := project(ds_combined1(event_filing_date = 0) ,corp2.Layout_Corporate_Direct_Corp_Base_expanded);
    
	ds_combined2 := join(ds_combined1_nomatch,
												inEvents,
												left.corp_key = right.corp_key and
												(
                              ut.date_overlap(left.dt_vendor_first_reported , left.dt_vendor_last_reported
                                             ,right.dt_vendor_first_reported, right.dt_vendor_last_reported) > 0
                  
                        )
                        ,
												AddEvent(left,right),
												left outer, local,keep(1));

	ds_combined := ds_combined1(event_filing_date != 0) + ds_combined2;
    
	corp2.Layout_Corporate_Direct_Corp_Base_expanded CheckDates(Layout_Add_EventDate L) := transform
		unsigned4 dt_first_seen := 
													ut.EarliestDate((unsigned4)corp2.fCheckDate(l.corp_filing_date), 
													ut.EarliestDate((unsigned4)corp2.fCheckDate(l.corp_address1_effective_date), 
													ut.EarliestDate((unsigned4)corp2.fCheckDate(l.corp_address2_effective_date), 
													ut.EarliestDate((unsigned4)corp2.fCheckDate(l.corp_status_date),
													ut.EarliestDate((unsigned4)corp2.fCheckDate((string)l.event_filing_date),
																					(unsigned4)corp2.fCheckDate(l.corp_process_date))))));
		unsigned4 dt_last_seen := 
													max((unsigned4)corp2.fCheckDate(l.corp_filing_date), 
													max((unsigned4)corp2.fCheckDate(l.corp_address1_effective_date), 
													max((unsigned4)corp2.fCheckDate(l.corp_address2_effective_date), 
													max((unsigned4)corp2.fCheckDate(l.corp_status_date),
													max((unsigned4)corp2.fCheckDate((string)l.event_filing_date),
															(unsigned4)corp2.fCheckDate(l.corp_process_date))))));
		self.dt_first_seen	:=	dt_first_seen;
		self.dt_last_seen		:=	dt_last_seen;
		self := L;
	end;

	company_dates	:= 	distribute(PROJECT(ds_combined, CheckDates(LEFT)),hash(corp_key));
										
	srtBDIDAll		:=	sort(company_dates,RECORD, except dt_first_seen, dt_last_seen, dt_vendor_first_reported, 
													dt_vendor_last_reported, corp_ra_dt_first_seen, corp_ra_dt_last_seen, corp_process_Date, 
													record_type, source_rec_id, DotID, DotScore,	DotWeight, EmpID,	EmpScore,	EmpWeight,	
													POWID,	POWScore, POWWeight,	ProxID, ProxScore, ProxWeight, SELEID, SELEScore,
													SELEWeight,OrgID,orgScore,OrgWeight,UltID,UltScore,UltWeight,local);											
												
	Corp2.Layout_Corporate_Direct_Corp_Base_Expanded rolluprecs(Corp2.Layout_Corporate_Direct_Corp_Base_Expanded l, Corp2.Layout_Corporate_Direct_Corp_Base_Expanded r) := transform
		self.dt_first_seen 						:= ut.min2(l.dt_first_seen, r.dt_first_seen);
  	self.dt_last_seen  						:= Max(l.dt_last_seen, r.dt_last_seen);
  	self.dt_vendor_first_reported := ut.min2(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
  	self.dt_vendor_last_reported  := Max(l.dt_vendor_last_reported, r.dt_vendor_last_reported);	
		SELF.corp_ra_dt_first_seen		:= ut.EarliestDate(l.corp_ra_dt_first_seen, r.corp_ra_dt_first_seen);
		SELF.corp_ra_dt_last_seen			:= Max(l.corp_ra_dt_last_seen, r.corp_ra_dt_last_seen);			
		self.source_rec_id            := if(l.source_rec_id<>0, l.source_rec_id, r.source_rec_id);
		self.corp_process_Date				:= if(l.corp_process_Date>r.corp_process_Date, l.corp_process_Date, r.corp_process_Date);	
		self.dotid				            := if(l.proxScore>r.proxScore, l.dotid, r.dotid);			
		self.DotScore				          := if(l.proxScore>r.proxScore, l.DotScore, r.DotScore);	
		self.DotWeight				        := if(l.proxScore>r.proxScore, l.DotWeight, r.DotWeight);	
		self.EmpID				            := if(l.proxScore>r.proxScore, l.EmpID, r.EmpID);							
		self.EmpScore				          := if(l.proxScore>r.proxScore, l.EmpScore, r.EmpScore);	
		self.EmpWeight				        := if(l.proxScore>r.proxScore, l.EmpWeight, r.EmpWeight);	
		self.POWID				            := if(l.proxScore>r.proxScore, l.POWID, r.POWID);	
		self.POWScore				          := if(l.proxScore>r.proxScore, l.POWScore, r.POWScore);	
		self.POWWeight				        := if(l.proxScore>r.proxScore, l.POWWeight, r.POWWeight);	
		self.ProxID				            := if(l.proxScore>r.proxScore, l.ProxID, r.ProxID);	
		self.ProxScore				        := if(l.proxScore>r.proxScore, l.ProxScore, r.ProxScore);	
		self.ProxWeight				        := if(l.proxScore>r.proxScore, l.ProxWeight, r.ProxWeight);	
		self.SELEID				            := if(l.proxScore>r.proxScore, l.SELEID, r.SELEID);	
		self.SELEScore				       	:= if(l.proxScore>r.proxScore, l.SELEScore, r.SELEScore);	
		self.SELEWeight				        := if(l.proxScore>r.proxScore, l.SELEWeight, r.SELEWeight);	
		self.OrgID				            := if(l.proxScore>r.proxScore, l.OrgID, r.OrgID);	
		self.orgScore				          := if(l.proxScore>r.proxScore, l.orgScore, r.orgScore);	
		self.OrgWeight				        := if(l.proxScore>r.proxScore, l.OrgWeight, r.OrgWeight);	
		self.UltID				            := if(l.proxScore>r.proxScore, l.UltID, r.UltID);	
		self.UltScore				          := if(l.proxScore>r.proxScore, l.UltScore, r.UltScore);	
		self.UltWeight				        := if(l.proxScore>r.proxScore, l.UltWeight, r.UltWeight);	
		self.record_type							:= if(l.corp_process_Date>r.corp_process_Date, l.record_type, r.record_type);	
		self 													:= l;
	end;

	rolledup_recs := rollup(srtBDIDAll, rolluprecs(left,right),
                       		RECORD, except dt_first_seen, dt_last_seen, dt_vendor_first_reported, dt_vendor_last_reported, corp_ra_dt_first_seen, corp_ra_dt_last_seen, corp_process_Date, record_type, source_rec_id, DotID, 
													DotScore,	DotWeight, EmpID,	EmpScore,	EmpWeight,	POWID,	POWScore, POWWeight,	ProxID, ProxScore, 
													ProxWeight,	SELEID,	SELEScore,SELEWeight,OrgID,orgScore,OrgWeight,UltID,UltScore,UltWeight,local);												

	/////////////////////////////////////////////////////////////////////////////////////////////////
	// -- Code to fix the NY data issue with the corp_inc_date being changed each update. So patching
	//    the code to have the lowest inc date to all its records for that (Corp_key) group.
	/////////////////////////////////////////////////////////////////////////////////////////////////
	// Filter NY records for fixing the Corp_inc_date.
	corp_ny_srt := sort(distribute(rolledup_recs(trim(corp_state_origin) = 'NY'), hash64(corp_vendor, corp_key)),
                   		corp_key, corp_inc_date, local);

	Corp2.Layout_Corporate_Direct_Corp_Base_Expanded patchIncDate(corp_ny_srt l, corp_ny_srt r) := transform
  	same_group         := if(trim(r.corp_state_origin) = 'NY' and trim(l.corp_key) = trim(r.corp_key), true, false);
  	self.Corp_inc_date := if(	same_group and
															trim(l.Corp_inc_date,left,right) <> '' and  
															trim(l.Corp_inc_date,left,right) < trim(r.corp_inc_date,left,right),
	                          	trim(l.corp_inc_date,left,right), trim(r.corp_inc_date,left,right));
   	self := r;
	end;

	corp_ny := iterate(corp_ny_srt, patchIncDate(left,right),local);
 
	corp_recs := rolledup_recs(trim(corp_state_origin) <> 'NY') + corp_ny;

	/////////////////////////////////////////////////////////////////////////////////////////////////
	// -- Mark the current standing status for all Texas corp records using the txbus FTACT file.
	/////////////////////////////////////////////////////////////////////////////////////////////////
	pTxFtact	:= 	corp2.files().input.txbus.root;	
	
	corp_w_marked_standing_tx_recs := corp2.Mac_Mark_TX_Standing(pTxFtact, corp_recs);

	corp_w_marked_standing_tx_recs_Dist 	:= distribute(corp_w_marked_standing_tx_recs, hash(corp_key));
	corp_w_marked_standing_tx_recs_Sort 	:= sort(corp_w_marked_standing_tx_recs_Dist,record,local);	
	corp_w_marked_standing_tx_recs_dedup 	:= dedup(corp_w_marked_standing_tx_recs_Sort,record,local);

	ut.MAC_Append_Rcid(corp_w_marked_standing_tx_recs_dedup,Source_rec_id,out_file);

	returndataset	:=	out_file;

	return returndataset;

end;