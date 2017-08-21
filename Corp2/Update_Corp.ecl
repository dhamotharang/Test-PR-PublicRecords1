import ut, Business_Header, Business_Header_SS, address, did_add, _validate, corp,mdr, aid, idl_header;

export Update_Corp(
										 dataset(Layout_Corporate_Direct_Corp_In		) pCorpInputFiles = files().input.corp.using
										,dataset(Layout_Corporate_Direct_Corp_AID		) pCorpBaseFile		= files().AID.Corp.QA
										,dataset(Layout_Corporate_Direct_Event_Base	) pUpdate_Event		= Update_Event()
										,dataset(Layout_Tx_Ftact										)	pTxFtact				= files().input.txbus.root
										,string																				pPersistname		= persistnames.UpdateCorp
									) :=	function

// Project Update to Base Format
Layout_Corporate_Direct_Corp_AID InitUpdate(Layout_Corporate_Direct_Corp_In l) :=
transform
	self.corp_legal_name 								:= Stringlib.StringToUpperCase(l.corp_legal_name);
	self.corp_address1_type_cd					:= Stringlib.StringToUpperCase(l.corp_address1_type_cd);
	self.corp_address1_type_desc				:= Stringlib.StringToUpperCase(l.corp_address1_type_desc);
	self.corp_address1_line1						:= Stringlib.StringToUpperCase(l.corp_address1_line1);
	self.corp_address1_line2						:= Stringlib.StringToUpperCase(l.corp_address1_line2);
	self.corp_address1_line3						:= Stringlib.StringToUpperCase(l.corp_address1_line3);
	self.corp_address1_line4						:= Stringlib.StringToUpperCase(l.corp_address1_line4);
	self.corp_address1_line5						:= Stringlib.StringToUpperCase(l.corp_address1_line5);
	self.corp_address1_line6						:= Stringlib.StringToUpperCase(l.corp_address1_line6);
	self.corp_address2_type_cd					:= Stringlib.StringToUpperCase(l.corp_address2_type_cd);
	self.corp_address2_type_desc				:= Stringlib.StringToUpperCase(l.corp_address2_type_desc);
	self.corp_address2_line1						:= Stringlib.StringToUpperCase(l.corp_address2_line1);
	self.corp_address2_line2						:= Stringlib.StringToUpperCase(l.corp_address2_line2);
	self.corp_address2_line3						:= Stringlib.StringToUpperCase(l.corp_address2_line3);
	self.corp_address2_line4						:= Stringlib.StringToUpperCase(l.corp_address2_line4);
	self.corp_address2_line5						:= Stringlib.StringToUpperCase(l.corp_address2_line5);
	self.corp_address2_line6						:= Stringlib.StringToUpperCase(l.corp_address2_line6);
	self.corp_phone_number_type_cd			:= Stringlib.StringToUpperCase(l.corp_phone_number_type_cd);
	self.corp_phone_number_type_desc 		:= Stringlib.StringToUpperCase(l.corp_phone_number_type_desc);
	self.corp_filing_cd 								:= Stringlib.StringToUpperCase(l.corp_filing_cd);
	self.corp_filing_desc								:= Stringlib.StringToUpperCase(l.corp_filing_desc);
	self.corp_status_cd									:= Stringlib.StringToUpperCase(l.corp_status_cd);
	self.corp_status_desc								:= Stringlib.StringToUpperCase(l.corp_status_desc);
	self.corp_term_exist_cd							:= Stringlib.StringToUpperCase(l.corp_term_exist_cd);
	self.corp_term_exist_exp						:= Stringlib.StringToUpperCase(l.corp_term_exist_exp);
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
	self.corp_foreign_domestic_ind			:= Stringlib.StringToUpperCase(l.corp_foreign_domestic_ind);
	self.corp_forgn_state_cd						:= Stringlib.StringToUpperCase(l.corp_forgn_state_cd);
	self.corp_forgn_state_desc					:= Stringlib.StringToUpperCase(l.corp_forgn_state_desc);
	self.corp_forgn_term_exist_cd				:= Stringlib.StringToUpperCase(l.corp_forgn_term_exist_cd);
	self.corp_forgn_term_exist_exp			:= Stringlib.StringToUpperCase(l.corp_forgn_term_exist_exp);
	self.corp_forgn_term_exist_desc			:= Stringlib.StringToUpperCase(l.corp_forgn_term_exist_desc);
	self.corp_orig_org_structure_cd			:= Stringlib.StringToUpperCase(l.corp_orig_org_structure_cd);
	self.corp_orig_org_structure_desc		:= Stringlib.StringToUpperCase(l.corp_orig_org_structure_desc);
	self.corp_for_profit_ind						:= Stringlib.StringToUpperCase(l.corp_for_profit_ind);
	self.corp_orig_bus_type_cd					:= Stringlib.StringToUpperCase(l.corp_orig_bus_type_cd);
	self.corp_orig_bus_type_desc				:= Stringlib.StringToUpperCase(l.corp_orig_bus_type_desc);
	self.corp_ra_name										:= Stringlib.StringToUpperCase(l.corp_ra_name);
	self.corp_ra_title_cd								:= Stringlib.StringToUpperCase(l.corp_ra_title_cd);
	self.corp_ra_title_desc							:= Stringlib.StringToUpperCase(l.corp_ra_title_desc);
	self.corp_ra_address_type_cd				:= Stringlib.StringToUpperCase(l.corp_ra_address_type_cd);
	self.corp_ra_address_type_desc			:= Stringlib.StringToUpperCase(l.corp_ra_address_type_desc);
	self.corp_ra_address_line1					:= Stringlib.StringToUpperCase(l.corp_ra_address_line1);
	self.corp_ra_address_line2					:= Stringlib.StringToUpperCase(l.corp_ra_address_line2);
	self.corp_ra_address_line3					:= Stringlib.StringToUpperCase(l.corp_ra_address_line3);
	self.corp_ra_address_line4					:= Stringlib.StringToUpperCase(l.corp_ra_address_line4);
	self.corp_ra_address_line5					:= Stringlib.StringToUpperCase(l.corp_ra_address_line5);
	self.corp_ra_address_line6					:= Stringlib.StringToUpperCase(l.corp_ra_address_line6);
	self.corp_ra_phone_number_type_cd		:= Stringlib.StringToUpperCase(l.corp_ra_phone_number_type_cd);
	self.corp_ra_phone_number_type_desc := Stringlib.StringToUpperCase(l.corp_ra_phone_number_type_desc);
	// Fix problem with MS dates
	self.corp_ra_effective_date 				:= if(l.corp_state_origin = 'MS' and (integer)l.corp_process_date < 20040321,
																						l.corp_ra_effective_date[5..8] + l.corp_ra_effective_date[1..2] + l.corp_ra_effective_date[3..4],
																						l.corp_ra_effective_date);
	self.dt_first_seen									:= (unsigned4)fCheckDate(l.dt_first_seen);
	self.dt_last_seen										:= (unsigned4)fCheckDate(l.dt_last_seen);
	self.dt_vendor_first_reported				:= (unsigned4)fCheckDate(l.dt_vendor_first_reported);
	self.dt_vendor_last_reported				:= (unsigned4)fCheckDate(l.dt_vendor_last_reported);
	self.corp_ra_dt_first_seen					:= (unsigned4)fCheckDate(l.corp_ra_dt_first_seen);
	self.corp_ra_dt_last_seen						:= (unsigned4)fCheckDate(l.corp_ra_dt_last_seen);

	self.corp_phone10										:= address.CleanPhone(l.corp_phone_number);
	self.corp_ra_phone10								:= address.CleanPhone(l.corp_ra_phone_number);
	self.record_type										:= 'H';
	self.corp_sos_charter_nbr						:= fMapCharterNumber(l.corp_vendor,l.corp_state_origin,l.corp_orig_sos_charter_nbr);
	// -- New fields for new corp2 layouts
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
	self.Append_Addr1_RawAID						:= 0;
	self.Append_Addr1_ACEAID						:= 0;
	self.Append_Addr2_RawAID						:= 0;
	self.Append_Addr2_ACEAID						:= 0;
	self.Append_RA_RawAID								:= 0;
	self.Append_RA_ACEAID								:= 0;
	self																:= l; 

end;

// corp_file := if(flags.IsUsingV1Inputs = true, 
								// map(flags.UseV1CurrentSprayed = true and flags.ExistcorpV1CurrentSprayed	=> pCorpInputFiles,
										// flags.UseV1CurrentSprayed = false and flags.ExistcorpV1FatherSprayed		=> pCorpInputFiles,
										// pCorpInputFiles
										// )
								// , pCorpInputFiles
								// );

corp_update_dist := distribute(pCorpInputFiles, hash(corp_key));
corp_update_sort := sort(corp_update_dist, record, local);
corp_update_dedup := dedup(corp_update_sort, record, local);

corp_update_init := project(corp_update_dedup, InitUpdate(left));

// Fix any dates necessary
corp_update_init_fix := fFixCorpDates(corp_update_init(corp_state_origin in Corp2.SetsofStates.setStatesNeedDatesFixed));
corp_update_init_combined := corp_update_init(corp_state_origin not in Corp2.SetsofStates.setStatesNeedDatesFixed) + corp_update_init_fix;

corp_update_init_dist := distribute(corp_update_init_combined, hash(corp_key));
corp_update_init_sort := sort(corp_update_init_dist, except bdid, dt_first_seen, dt_last_seen,
                               dt_vendor_first_reported, dt_vendor_last_reported, corp_ra_dt_first_seen,
															 corp_ra_dt_last_seen, corp_process_date, record_type, local);

Layout_Corporate_Direct_Corp_AID RollupUpdate(Layout_Corporate_Direct_Corp_AID l, Layout_Corporate_Direct_Corp_AID r) := transform
SELF.dt_first_seen						:= ut.EarliestDate(ut.EarliestDate(l.dt_first_seen,r.dt_first_seen),
																			ut.EarliestDate(l.dt_last_seen,r.dt_last_seen));
SELF.dt_last_seen							:= ut.LatestDate(l.dt_last_seen,r.dt_last_seen);
SELF.dt_vendor_last_reported	:= ut.LatestDate(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
SELF.dt_vendor_first_reported	:= ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
SELF.corp_ra_dt_first_seen		:= ut.EarliestDate(l.corp_ra_dt_first_seen, r.corp_ra_dt_first_seen);
SELF.corp_ra_dt_last_seen			:= ut.LatestDate(l.corp_ra_dt_last_seen, r.corp_ra_dt_last_seen);
SELF.corp_status_date					:= (string)ut.LatestDate((integer)l.corp_status_date,(integer)r.corp_status_date);
SELF.corp_process_date				:= if(l.corp_process_date > r.corp_process_date, l.corp_process_date, r.corp_process_date);
self.source_rec_id						:=	if(l.source_rec_id = 0, r.source_rec_id, l.source_rec_id);
self := l;
end;

corp_update_init_rollup := rollup(corp_update_init_sort, RollupUpdate(left, right), except bdid, dt_first_seen, dt_last_seen,
																	dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date,
																	corp_ra_dt_first_seen, corp_ra_dt_last_seen,record_type, corp_status_date,local);

							   
// Initialize Current base file
Layout_Corporate_Direct_Corp_AID InitCurrentBase(Layout_Corporate_Direct_Corp_AID l) := transform
self.bdid 								:= 0;
self.DotID								:=	0;
self.DotScore							:=	0;
self.DotWeight						:=	0;
self.EmpID								:=	0;
self.EmpScore							:=	0;
self.EmpWeight						:=	0;
self.POWID								:=	0;
self.POWScore							:=	0;
self.POWWeight						:=	0;
self.ProxID								:=	0;
self.ProxScore						:=	0;
self.ProxWeight						:=	0;
self.SELEID								:=	0;
self.SELEScore						:=	0;
self.SELEWeight						:=	0;
self.OrgID								:=	0;
self.orgScore							:=	0;
self.OrgWeight						:=	0;
self.UltID								:=	0;
self.UltScore							:=	0;
self.UltWeight						:=	0;
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

corp_current_init := project(Filters.Base.Corp(pCorpBaseFile), InitCurrentBase(left));
corp_current_init_dist := distribute(corp_current_init, hash(corp_key));


// Combine current base with update
corp_update_combined := map(Flags.Update.Corp and flags.ExistCorpV2CurrentSprayed =>
															corp_current_init_dist + corp_update_init_rollup,
														Flags.Update.Corp =>
															corp_current_init_dist,
															corp_update_init_rollup
													);
						   
// Combine new base with Experian Full States and Experian History
// corp_update_combined_history := 
	// if(flags.IsUsingExperianCorp4 = true
		// ,Corp4AsCorp2(corp_state_origin in setCorp4AddStates) + fCombineCorpHistory(corp_update_combined)
		// ,corp_update_combined
	// );
	
corp_update_combined_history_dist := distribute(corp_update_combined, hash(corp_key));

Layout_Temp_Corp	:=	record
		unsigned8		unique_id;
		Layout_Corporate_Direct_Corp_AID;
end;

Layout_Temp_Corp tPreProcess(Layout_Corporate_Direct_Corp_AID l, unsigned4 cnt) :=	transform
		self.unique_id								:=	cnt;
		self													:=	l;
		self													:=	[];
end;
	
dPreProcess := project(corp_update_combined_history_dist, tPreProcess(left,counter)): Persist('~thor_data400::persist::corp2::update_corp::dPreProcess');

addresslayout :=	record
		unsigned8					unique_id			;	//to tie back to original record
		unsigned4					address_type	;	// contact or mailing
		string100					Append_Prep_Address1;
		string50					Append_Prep_AddressLast;
		AID.Common.xAID		Append_RawAID;		
		AID.Common.xAID		Append_AceAID;			
end;

addresslayout tNormalizeAddress(Layout_Temp_Corp l, unsigned4 cnt) := transform
		self.unique_id								:= 	l.unique_id;
		self.address_type							:= 	cnt;
		self.Append_Prep_Address1			:= 	choose(cnt	,l.corp_prep_addr1_line1
																									,l.corp_prep_addr2_line1
																									,l.RA_prep_addr_line1
																						);              
		self.Append_Prep_AddressLast	:= 	choose(cnt	,l.corp_prep_addr1_last_line
																									,l.corp_prep_addr2_last_line
																									,l.RA_prep_addr_last_line
																						);  
		self.Append_RawAID						:=	choose(cnt 	,l.Append_Addr1_RawAID
																									,l.Append_Addr2_RawAID
																									,l.Append_RA_RawAID
																						);
		self.Append_ACEAID						:=	choose(cnt 	,l.Append_Addr1_ACEAID
																									,l.Append_Addr2_ACEAID
																									,l.Append_RA_ACEAID
																						);	
end;
				
dAddressPrep			:= 	normalize(dPreProcess, 3, tNormalizeAddress(left,counter),local);

HasAddress				:= 	trim(dAddressPrep.Append_Prep_Address1, left,right) != ''	and 
											trim(dAddressPrep.Append_Prep_AddressLast, left,right) != '';
												
dWith_address			:= 	dAddressPrep(HasAddress);
dWithout_address	:= 	dAddressPrep(not(HasAddress));
										
dStandardizeInput_dist 	:= distribute(dPreProcess	,unique_id);

cleanedAddrLayout :=	record
		addresslayout;
		address.Layout_Clean182		Clean_Address;
end;
						
unsigned4		lAIDAppendFlags	:=	AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
				
AID.MacAppendFromRaw_2Line(dWith_address, Append_Prep_Address1, Append_Prep_AddressLast, Append_RawAID, dAddressCleaned, lAIDAppendFlags);
		
cleanedAddrLayout	tCleanAddressAppended(dAddressCleaned pInput)	:=	transform
		self.Append_RawAID			:=	pInput.AIDWork_RawAID;
		self.Append_ACEAID			:=	pInput.aidwork_acecache.aid;		
		self.clean_address.zip	:=	pInput.AIDWork_ACECache.zip5;
		self.clean_address			:=	pInput.AIDWork_ACECache;
		self										:=	pInput;
end;
					
dCleanAddressAppended				:=	project(dAddressCleaned,tCleanAddressAppended(left)) : INDEPENDENT;
				
dCleanAddressAppended_dist		:= distribute(dCleanAddressAppended	,unique_id);
		
Layout_Temp_Corp tGetStandardizedAddress(Layout_Temp_Corp l	,cleanedAddrLayout r) :=	transform
		self.Append_Addr1_RawAID		:= if(r.address_type = 1	,r.Append_RawAID							,l.Append_Addr1_RawAID);
		self.Append_Addr1_ACEAID		:= if(r.address_type = 1	,r.Append_ACEAID							,l.Append_Addr1_ACEAID);
		self.corp_addr1_prim_range	:= if(r.address_type = 1	,r.Clean_address.prim_range		,l.corp_addr1_prim_range);
		self.corp_addr1_predir			:= if(r.address_type = 1	,r.Clean_address.predir				,l.corp_addr1_predir);
		self.corp_addr1_prim_name		:= if(r.address_type = 1	,r.Clean_address.prim_name		,l.corp_addr1_prim_name);
		self.corp_addr1_addr_suffix	:= if(r.address_type = 1	,r.Clean_address.addr_suffix	,l.corp_addr1_addr_suffix);
		self.corp_addr1_postdir			:= if(r.address_type = 1	,r.Clean_address.postdir			,l.corp_addr1_postdir);
		self.corp_addr1_unit_desig	:= if(r.address_type = 1	,r.Clean_address.unit_desig		,l.corp_addr1_unit_desig);
		self.corp_addr1_sec_range		:= if(r.address_type = 1	,r.Clean_address.sec_range		,l.corp_addr1_sec_range);
		self.corp_addr1_p_city_name	:= if(r.address_type = 1	,r.Clean_address.p_city_name	,l.corp_addr1_p_city_name);
		self.corp_addr1_v_city_name	:= if(r.address_type = 1	,r.Clean_address.v_city_name	,l.corp_addr1_v_city_name);
		self.corp_addr1_state				:= if(r.address_type = 1	,r.Clean_address.st						,l.corp_addr1_state);
		self.corp_addr1_zip5				:= if(r.address_type = 1	,r.Clean_address.zip					,l.corp_addr1_zip5);
		self.corp_addr1_zip4				:= if(r.address_type = 1	,r.Clean_address.zip4					,l.corp_addr1_zip4);		
		self.corp_addr1_cart				:= if(r.address_type = 1	,r.Clean_address.cart					,l.corp_addr1_cart);
		self.corp_addr1_cr_sort_sz	:= if(r.address_type = 1	,r.Clean_address.cr_sort_sz		,l.corp_addr1_cr_sort_sz);
		self.corp_addr1_lot					:= if(r.address_type = 1	,r.Clean_address.lot					,l.corp_addr1_lot);
		self.corp_addr1_lot_order		:= if(r.address_type = 1	,r.Clean_address.lot_order		,l.corp_addr1_lot_order);
		self.corp_addr1_dpbc				:= if(r.address_type = 1	,r.Clean_address.dbpc					,l.corp_addr1_dpbc);
		self.corp_addr1_chk_digit		:= if(r.address_type = 1	,r.Clean_address.chk_digit		,l.corp_addr1_chk_digit);
		self.corp_addr1_rec_type		:= if(r.address_type = 1	,r.Clean_address.rec_type			,l.corp_addr1_rec_type);
		self.corp_addr1_ace_fips_st	:= if(r.address_type = 1	,r.Clean_address.county[1..2]	,l.corp_addr1_ace_fips_st);
		self.corp_addr1_county			:= if(r.address_type = 1	,r.Clean_address.county[3..5]	,l.corp_addr1_county);
		self.corp_addr1_geo_lat			:= if(r.address_type = 1	,r.Clean_address.geo_lat			,l.corp_addr1_geo_lat);
		self.corp_addr1_geo_long		:= if(r.address_type = 1	,r.Clean_address.geo_long			,l.corp_addr1_geo_long);
		self.corp_addr1_msa					:= if(r.address_type = 1	,r.Clean_address.msa					,l.corp_addr1_msa);
		self.corp_addr1_geo_blk			:= if(r.address_type = 1	,r.Clean_address.geo_blk			,l.corp_addr1_geo_blk);
		self.corp_addr1_geo_match		:= if(r.address_type = 1	,r.Clean_address.geo_match		,l.corp_addr1_geo_match);
		self.corp_addr1_err_stat		:= if(r.address_type = 1	,r.Clean_address.err_stat			,l.corp_addr1_err_stat);
		
		self.Append_Addr2_RawAID		:= if(r.address_type = 2	,r.Append_RawAID							,l.Append_Addr2_RawAID);
		self.Append_Addr2_ACEAID		:= if(r.address_type = 2	,r.Append_ACEAID							,l.Append_Addr2_ACEAID);
		self.corp_Addr2_prim_range	:= if(r.address_type = 2	,r.Clean_address.prim_range		,l.corp_Addr2_prim_range);
		self.corp_Addr2_predir			:= if(r.address_type = 2	,r.Clean_address.predir				,l.corp_Addr2_predir);
		self.corp_Addr2_prim_name		:= if(r.address_type = 2	,r.Clean_address.prim_name		,l.corp_Addr2_prim_name);
		self.corp_Addr2_addr_suffix	:= if(r.address_type = 2	,r.Clean_address.addr_suffix	,l.corp_Addr2_addr_suffix);
		self.corp_Addr2_postdir			:= if(r.address_type = 2	,r.Clean_address.postdir			,l.corp_Addr2_postdir);
		self.corp_Addr2_unit_desig	:= if(r.address_type = 2	,r.Clean_address.unit_desig		,l.corp_Addr2_unit_desig);
		self.corp_Addr2_sec_range		:= if(r.address_type = 2	,r.Clean_address.sec_range		,l.corp_Addr2_sec_range);
		self.corp_Addr2_p_city_name	:= if(r.address_type = 2	,r.Clean_address.p_city_name	,l.corp_Addr2_p_city_name);
		self.corp_Addr2_v_city_name	:= if(r.address_type = 2	,r.Clean_address.v_city_name	,l.corp_Addr2_v_city_name);
		self.corp_Addr2_state				:= if(r.address_type = 2	,r.Clean_address.st						,l.corp_Addr2_state);
		self.corp_Addr2_zip5				:= if(r.address_type = 2	,r.Clean_address.zip					,l.corp_Addr2_zip5);
		self.corp_Addr2_zip4				:= if(r.address_type = 2	,r.Clean_address.zip4					,l.corp_Addr2_zip4);		
		self.corp_Addr2_cart				:= if(r.address_type = 2	,r.Clean_address.cart					,l.corp_Addr2_cart);
		self.corp_Addr2_cr_sort_sz	:= if(r.address_type = 2	,r.Clean_address.cr_sort_sz		,l.corp_Addr2_cr_sort_sz);
		self.corp_Addr2_lot					:= if(r.address_type = 2	,r.Clean_address.lot					,l.corp_Addr2_lot);
		self.corp_Addr2_lot_order		:= if(r.address_type = 2	,r.Clean_address.lot_order		,l.corp_Addr2_lot_order);
		self.corp_Addr2_dpbc				:= if(r.address_type = 2	,r.Clean_address.dbpc					,l.corp_Addr2_dpbc);
		self.corp_Addr2_chk_digit		:= if(r.address_type = 2	,r.Clean_address.chk_digit		,l.corp_Addr2_chk_digit);
		self.corp_Addr2_rec_type		:= if(r.address_type = 2	,r.Clean_address.rec_type			,l.corp_Addr2_rec_type);
		self.corp_Addr2_ace_fips_st	:= if(r.address_type = 2	,r.Clean_address.county[1..2]	,l.corp_Addr2_ace_fips_st);
		self.corp_Addr2_county			:= if(r.address_type = 2	,r.Clean_address.county[3..5]	,l.corp_Addr2_county);
		self.corp_Addr2_geo_lat			:= if(r.address_type = 2	,r.Clean_address.geo_lat			,l.corp_Addr2_geo_lat);
		self.corp_Addr2_geo_long		:= if(r.address_type = 2	,r.Clean_address.geo_long			,l.corp_Addr2_geo_long);
		self.corp_Addr2_msa					:= if(r.address_type = 2	,r.Clean_address.msa					,l.corp_Addr2_msa);
		self.corp_Addr2_geo_blk			:= if(r.address_type = 2	,r.Clean_address.geo_blk			,l.corp_Addr2_geo_blk);
		self.corp_Addr2_geo_match		:= if(r.address_type = 2	,r.Clean_address.geo_match		,l.corp_Addr2_geo_match);
		self.corp_Addr2_err_stat		:= if(r.address_type = 2	,r.Clean_address.err_stat			,l.corp_Addr2_err_stat);
		
		self.Append_RA_RawAID				:= if(r.address_type = 3	,r.Append_RawAID							,l.Append_RA_RawAID);
		self.Append_RA_ACEAID				:= if(r.address_type = 3	,r.Append_ACEAID							,l.Append_RA_ACEAID);
		self.corp_RA_prim_range			:= if(r.address_type = 3	,r.Clean_address.prim_range		,l.corp_RA_prim_range);
		self.corp_RA_predir					:= if(r.address_type = 3	,r.Clean_address.predir				,l.corp_RA_predir);
		self.corp_RA_prim_name			:= if(r.address_type = 3	,r.Clean_address.prim_name		,l.corp_RA_prim_name);
		self.corp_RA_addr_suffix		:= if(r.address_type = 3	,r.Clean_address.addr_suffix	,l.corp_RA_addr_suffix);
		self.corp_RA_postdir				:= if(r.address_type = 3	,r.Clean_address.postdir			,l.corp_RA_postdir);
		self.corp_RA_unit_desig			:= if(r.address_type = 3	,r.Clean_address.unit_desig		,l.corp_RA_unit_desig);
		self.corp_RA_sec_range			:= if(r.address_type = 3	,r.Clean_address.sec_range		,l.corp_RA_sec_range);
		self.corp_RA_p_city_name		:= if(r.address_type = 3	,r.Clean_address.p_city_name	,l.corp_RA_p_city_name);
		self.corp_RA_v_city_name		:= if(r.address_type = 3	,r.Clean_address.v_city_name	,l.corp_RA_v_city_name);
		self.corp_RA_state					:= if(r.address_type = 3	,r.Clean_address.st						,l.corp_RA_state);
		self.corp_RA_zip5						:= if(r.address_type = 3	,r.Clean_address.zip					,l.corp_RA_zip5);
		self.corp_RA_zip4						:= if(r.address_type = 3	,r.Clean_address.zip4					,l.corp_RA_zip4);		
		self.corp_RA_cart						:= if(r.address_type = 3	,r.Clean_address.cart					,l.corp_RA_cart);
		self.corp_RA_cr_sort_sz			:= if(r.address_type = 3	,r.Clean_address.cr_sort_sz		,l.corp_RA_cr_sort_sz);
		self.corp_RA_lot						:= if(r.address_type = 3	,r.Clean_address.lot					,l.corp_RA_lot);
		self.corp_RA_lot_order			:= if(r.address_type = 3	,r.Clean_address.lot_order		,l.corp_RA_lot_order);
		self.corp_RA_dpbc						:= if(r.address_type = 3	,r.Clean_address.dbpc					,l.corp_RA_dpbc);
		self.corp_RA_chk_digit			:= if(r.address_type = 3	,r.Clean_address.chk_digit		,l.corp_RA_chk_digit);
		self.corp_RA_rec_type				:= if(r.address_type = 3	,r.Clean_address.rec_type			,l.corp_RA_rec_type);
		self.corp_RA_ace_fips_st		:= if(r.address_type = 3	,r.Clean_address.county[1..2]	,l.corp_RA_ace_fips_st);
		self.corp_RA_county					:= if(r.address_type = 3	,r.Clean_address.county[3..5]	,l.corp_RA_county);
		self.corp_RA_geo_lat				:= if(r.address_type = 3	,r.Clean_address.geo_lat			,l.corp_RA_geo_lat);
		self.corp_RA_geo_long				:= if(r.address_type = 3	,r.Clean_address.geo_long			,l.corp_RA_geo_long);
		self.corp_RA_msa						:= if(r.address_type = 3	,r.Clean_address.msa					,l.corp_RA_msa);
		self.corp_RA_geo_blk				:= if(r.address_type = 3	,r.Clean_address.geo_blk			,l.corp_RA_geo_blk);
		self.corp_RA_geo_match			:= if(r.address_type = 3	,r.Clean_address.geo_match		,l.corp_RA_geo_match);
		self.corp_RA_err_stat				:= if(r.address_type = 3	,r.Clean_address.err_stat			,l.corp_RA_err_stat);
		self												:= l;
		self												:= [];
	end;
				
	dCleanCorpAddress1Appended	:= join(
																			dStandardizeInput_dist
																			,dCleanAddressAppended_dist(address_type = 1)
																			,left.unique_id = right.unique_id
																			,tGetStandardizedAddress(left,right)
																			,local
																			,left outer
																			);
		
	dCleanCorpAddress2Appended	:= join(
																			dCleanCorpAddress1Appended
																			,dCleanAddressAppended_dist(address_type = 2)
																			,left.unique_id = right.unique_id
																			,tGetStandardizedAddress(left,right)
																			,local
																			,left outer
																			);
																				
	dCleanRAAddressAppended			:= join(
																			dCleanCorpAddress2Appended
																			,dCleanAddressAppended_dist(address_type = 3)
																			,left.unique_id = right.unique_id
																			,tGetStandardizedAddress(left,right)
																			,local
																			,left outer
																			);
																			
	corp_update_combined_AID		:=	project(dCleanRAAddressAppended,TRANSFORM(Layout_Corporate_Direct_Corp_AID,SELF := LEFT;)): Persist('~thor_data400::persist::corp2::update_corp::AIDProcess');
	
	Address.Mac_Is_Business( corp_update_combined_AID(corp_ra_name != '') ,corp_ra_name,Clean_RA_Name,name_flag,false,true );

	cln_layout := RECORD
			recordof(corp_update_combined_AID);
			string1         name_flag;
			string5         cln_title;
			string20        cln_fname;
			string20        cln_mname;
			string20        cln_lname;
			string5         cln_suffix;
			string5         cln_title2;
			string20        cln_fname2;
			string20        cln_mname2;
			string20        cln_lname2;
			string5         cln_suffix2;
	END;
	
	dCorpRaNameBlank        :=      project(corp_update_combined_AID(corp_ra_name = ''),transform(cln_layout,self	:=	left; self	:=	[]));
	dCorpRaCleanName        :=      Clean_RA_Name   +  dCorpRaNameBlank;

	Layout_Corporate_Direct_Corp_AID  CleanCorpRANameAddr( dCorpRaCleanName  l) := transform
			self.corp_ra_title1	:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_title,
																	l.name_flag = 'U' => l.corp_ra_title1, '');
			self.corp_ra_fname1	:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_fname,
																	l.name_flag = 'U' => l.corp_ra_fname1, '');
			self.corp_ra_mname1	:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_mname,
																	l.name_flag = 'U' => l.corp_ra_mname1, '');
			self.corp_ra_lname1	:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_lname,
																	l.name_flag = 'U' => l.corp_ra_lname1, '');
			self.corp_ra_name_suffix1	:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_suffix,
																				l.name_flag = 'U' => l.corp_ra_name_suffix1, '');
			self.corp_ra_cname1	:= if(l.name_flag = 'B',l.corp_ra_name,'');	
			
			self								:=	l;
			self								:=	[];
	end;		
				
	cleanRACorps	:=project( dCorpRaCleanName ,CleanCorpRANameAddr(left));
				
	ut.mac_flipnames(cleanRACorps,corp_ra_fname1,corp_ra_mname1,corp_ra_lname1,cleanCorps_Nameflip);
	
	NameFlip_dist	:=	distribute(cleanCorps_Nameflip, hash(corp_key));	
																				
// Propagate Information Forward to Blank Fields
corp_update_combined_sort := sort(NameFlip_dist, corp_key, corp_process_date, corp_filing_date, corp_status_date, local);
corp_update_combined_grpd := group(corp_update_combined_sort, corp_key, local):independent;
// corp_update_combined_grpd_sort := sort(corp_update_combined_grpd, corp_process_date, corp_filing_date, corp_status_date);

corp_update_combined_propagate := group(iterate(corp_update_combined_grpd, tPropagateCorpFields(left, right)));

// Rollup dates for identical records, keep most current status date
corp_update_combined_propagate_sort := sort(corp_update_combined_propagate, except bdid, dt_first_seen, dt_last_seen,
                                            dt_vendor_first_reported, dt_vendor_last_reported, corp_ra_dt_first_seen,
																						corp_ra_dt_last_seen,corp_process_date, corp_status_date, record_type,
// Exclude clean address fields
corp_addr1_prim_range,
corp_addr1_predir,
corp_addr1_prim_name,
corp_addr1_addr_suffix,
corp_addr1_postdir,
corp_addr1_unit_desig,
corp_addr1_sec_range,
corp_addr1_p_city_name,
corp_addr1_v_city_name,
corp_addr1_state,
corp_addr1_zip5,
corp_addr1_zip4,
corp_addr1_cart,
corp_addr1_cr_sort_sz,
corp_addr1_lot,
corp_addr1_lot_order,
corp_addr1_dpbc,
corp_addr1_chk_digit,
corp_addr1_rec_type,
corp_addr1_ace_fips_st,
corp_addr1_county,
corp_addr1_geo_lat,
corp_addr1_geo_long,
corp_addr1_msa,
corp_addr1_geo_blk,
corp_addr1_geo_match,
corp_addr1_err_stat,
corp_addr2_prim_range,
corp_addr2_predir,
corp_addr2_prim_name,
corp_addr2_addr_suffix,
corp_addr2_postdir,
corp_addr2_unit_desig,
corp_addr2_sec_range,
corp_addr2_p_city_name,
corp_addr2_v_city_name,
corp_addr2_state,
corp_addr2_zip5,
corp_addr2_zip4,
corp_addr2_cart,
corp_addr2_cr_sort_sz,
corp_addr2_lot,
corp_addr2_lot_order,
corp_addr2_dpbc,
corp_addr2_chk_digit,
corp_addr2_rec_type,
corp_addr2_ace_fips_st,
corp_addr2_county,
corp_addr2_geo_lat,
corp_addr2_geo_long,
corp_addr2_msa,
corp_addr2_geo_blk,
corp_addr2_geo_match,
corp_addr2_err_stat,
corp_ra_prim_range,
corp_ra_predir,
corp_ra_prim_name,
corp_ra_addr_suffix,
corp_ra_postdir,
corp_ra_unit_desig,
corp_ra_sec_range,
corp_ra_p_city_name,
corp_ra_v_city_name,
corp_ra_state,
corp_ra_zip5,
corp_ra_zip4,
corp_ra_cart,
corp_ra_cr_sort_sz,
corp_ra_lot,
corp_ra_lot_order,
corp_ra_dpbc,
corp_ra_chk_digit,
corp_ra_rec_type,
corp_ra_ace_fips_st,
corp_ra_county,
corp_ra_geo_lat,
corp_ra_geo_long,
corp_ra_msa,
corp_ra_geo_blk,
corp_ra_geo_match,
corp_ra_err_stat,
corp_orig_sos_charter_nbr,
local);
											
corp_update_combined_propagate_group := group(corp_update_combined_propagate_sort, except bdid, dt_first_seen, dt_last_seen,
																							dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date,
																							corp_ra_dt_first_seen, corp_ra_dt_last_seen, corp_status_date, record_type,
// Exclude clean address fields
corp_addr1_prim_range,
corp_addr1_predir,
corp_addr1_prim_name,
corp_addr1_addr_suffix,
corp_addr1_postdir,
corp_addr1_unit_desig,
corp_addr1_sec_range,
corp_addr1_p_city_name,
corp_addr1_v_city_name,
corp_addr1_state,
corp_addr1_zip5,
corp_addr1_zip4,
corp_addr1_cart,
corp_addr1_cr_sort_sz,
corp_addr1_lot,
corp_addr1_lot_order,
corp_addr1_dpbc,
corp_addr1_chk_digit,
corp_addr1_rec_type,
corp_addr1_ace_fips_st,
corp_addr1_county,
corp_addr1_geo_lat,
corp_addr1_geo_long,
corp_addr1_msa,
corp_addr1_geo_blk,
corp_addr1_geo_match,
corp_addr1_err_stat,
corp_addr2_prim_range,
corp_addr2_predir,
corp_addr2_prim_name,
corp_addr2_addr_suffix,
corp_addr2_postdir,
corp_addr2_unit_desig,
corp_addr2_sec_range,
corp_addr2_p_city_name,
corp_addr2_v_city_name,
corp_addr2_state,
corp_addr2_zip5,
corp_addr2_zip4,
corp_addr2_cart,
corp_addr2_cr_sort_sz,
corp_addr2_lot,
corp_addr2_lot_order,
corp_addr2_dpbc,
corp_addr2_chk_digit,
corp_addr2_rec_type,
corp_addr2_ace_fips_st,
corp_addr2_county,
corp_addr2_geo_lat,
corp_addr2_geo_long,
corp_addr2_msa,
corp_addr2_geo_blk,
corp_addr2_geo_match,
corp_addr2_err_stat,
corp_ra_prim_range,
corp_ra_predir,
corp_ra_prim_name,
corp_ra_addr_suffix,
corp_ra_postdir,
corp_ra_unit_desig,
corp_ra_sec_range,
corp_ra_p_city_name,
corp_ra_v_city_name,
corp_ra_state,
corp_ra_zip5,
corp_ra_zip4,
corp_ra_cart,
corp_ra_cr_sort_sz,
corp_ra_lot,
corp_ra_lot_order,
corp_ra_dpbc,
corp_ra_chk_digit,
corp_ra_rec_type,
corp_ra_ace_fips_st,
corp_ra_county,
corp_ra_geo_lat,
corp_ra_geo_long,
corp_ra_msa,
corp_ra_geo_blk,
corp_ra_geo_match,
corp_ra_err_stat,
corp_orig_sos_charter_nbr,
local):independent;

// corp_update_combined_propagate_group_sort := sort(corp_update_combined_propagate_group, -corp_status_date, -corp_process_date);

corp_update_combined_propagate_rollup := group(rollup(corp_update_combined_propagate_group, true, RollupUpdate(left, right)));

// Set Current - Historical Indicator
corp_update_combined_propagate_rollup_sort := sort(corp_update_combined_propagate_rollup, corp_key,-dt_vendor_last_reported, -dt_last_seen, local);
corp_update_combined_propagate_rollup_grpd := group(corp_update_combined_propagate_rollup_sort, corp_key, local):independent;
// corp_update_combined_propagate_rollup_grpd_sort := sort(corp_update_combined_propagate_rollup_grpd, -dt_vendor_last_reported, -dt_last_seen);

Layout_Corporate_Direct_Corp_AID SetRecordType(Layout_Corporate_Direct_Corp_AID L, Layout_Corporate_Direct_Corp_AID R) :=
transform

	isdatethesame := if(l.dt_vendor_last_reported != 0 and l.dt_vendor_last_reported = r.dt_vendor_last_reported, true,false);
	ispreviousrecordcurrent := if(l.record_type = 'C',true, false);
	isfirstrecord := if(l.record_type = '',true, false);
	decision := if(isfirstrecord or (isdatethesame and ispreviousrecordcurrent), 'C', r.record_type);

	self.record_type	:= decision;
	self							:= r;

end;

corp_update := group(iterate(corp_update_combined_propagate_rollup_grpd, SetRecordType(left, right)));

// Join with Corp Events to update date last seen
layout_event_slim := record
string30  corp_key;
unsigned4 dt_vendor_last_reported;
unsigned4 dt_last_seen;
string8   event_filing_date;
end;

layout_event_slim SlimEvents(Layout_Corporate_Direct_Event_Base l) := transform
self := l;
end;

events_slim := project(pUpdate_Event(record_type = 'C'), SlimEvents(left));
events_slim_dist := distribute(events_slim, hash(corp_key));
events_slim_sort := sort(events_slim_dist, corp_key, -dt_vendor_last_reported, -dt_last_seen, local);
events_slim_dedup := dedup(events_slim_sort, corp_key, local);

Layout_Corporate_Direct_Corp_AID UpdateDates(Layout_Corporate_Direct_Corp_AID l, layout_event_slim r) := transform
self.dt_vendor_last_reported := ut.LatestDate(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
self.dt_last_seen := if(fCheckDate(r.event_filing_date) <> '', ut.LatestDate(l.dt_last_seen, r.dt_last_seen), l.dt_last_seen);
self := l;
end;

corp_update_event := join(corp_update,
                          events_slim_dedup,
													left.corp_key = right.corp_key and
													left.record_type = 'C',
													UpdateDates(left, right),
													left outer,
													local);
					



/////////////////////////////////////////////////////////////////////////////////////////////////
// -- Sequence records using bdid field for now(since patch function uses Layout_Corporate_Direct_Corp_Base)
// -- so we can put fields back in their place after bdiding
/////////////////////////////////////////////////////////////////////////////////////////////////
ut.MAC_Sequence_Records(corp_update_event, bdid, corp_update_event_seq);

corp_update_bdid_seq	:=	corp_update_event_seq :  Persist('~thor_data400::persist::corp2::update_corp::BDIDSeq');

corp_to_bdid_patched := fPatchAddressWithRA(corp_update_bdid_seq);

/////////////////////////////////////////////////////////////////////////////////////////////////
// -- Add seq field, since now we can have another field(and need to use bdid field now)
/////////////////////////////////////////////////////////////////////////////////////////////////
layout_corp_seq :=
record
	Layout_Corporate_Direct_Corp_AID;
	unsigned6 seq := 0;
	string2 source_code;
end;

layout_corp_seq tPopulateSeqField(Layout_Corporate_Direct_Corp_AID l) :=
transform
	self.seq							:= l.bdid;
	self.bdid							:= 0;
	self.source_code			:= MDR.sourceTools.fCorpV2(l.corp_key, l.corp_state_origin);
	self.corp_status_date	:=	if((integer)l.corp_status_date=0,'',l.corp_status_date);	
	self 		:= l;
end;

corp_to_bdid_patched_seq	:= project(corp_to_bdid_patched,	tPopulateSeqField(left));
corp_to_bdid_nonpatched_seq	:= project(corp_update_bdid_seq,	tPopulateSeqField(left));

Dist_corp_to_bdid_patched_seq	:=	distribute(corp_to_bdid_patched_seq,hash(corp_key));

pContacts					:=	corp2.Grab_Contacts();

pContactsDeduped	:=	dedup(sort(distribute(pContacts, hash(corp_key)),corp_key,cont_lname,cont_fname,cont_mname,local),corp_key,cont_lname,cont_fname,cont_mname,local);

CorpWithContacts	:=	record
		layout_corp_seq;
		string20 fname;
		string20 mname;
		string20 lname;
end;

CorpWithContacts joinForContacts(	Dist_corp_to_bdid_patched_seq l, pContactsDeduped r) := transform
		self.lname	:=	r.cont_lname;
		self.mname	:=	r.cont_mname;
		self.fname	:=	r.cont_fname;	
		self				:=	l;
	end;	
	
joinedWithContacts	:=	join(	
															Dist_corp_to_bdid_patched_seq,
															pContactsDeduped,
															left.corp_key=right.corp_key,
															joinForContacts(left,right),
															left outer,
															local
														 );	
														 
// Do a standard BDID match for the records 
BDID_Matchset := ['A'];

Business_Header_SS.MAC_Add_BDID_Flex(	joinedWithContacts,
																			BDID_Matchset,
																			corp_legal_name,
																			corp_addr1_prim_range, corp_addr1_prim_name, corp_addr1_zip5,
																			corp_addr1_sec_range, corp_addr1_state,
																			corp_phone10, corp_fed_tax_id,
																			bdid, CorpWithContacts,
																			FALSE, BDID_score_field,
																			corp_bdid_corp_addr,,,,
																			BIPV2.xlink_version_set,,,,
																			fname,
																			mname,
																			lname,,source_code,source_rec_id,false);
																			
//special logic to determine if we should try with the RA Address. Can only use if corporate address is blank.
try := corp_bdid_corp_addr.bdid = 0; //could change, just a starting point

outfileTryRAXlink 	:= corp_bdid_corp_addr(try and trim(corp_addr1_prim_range,left,right)='' and trim(corp_addr1_prim_name,left,right)='' and 
							trim(corp_addr1_zip5,left,right)='' and trim(corp_addr1_sec_range ,left,right)='' and trim(corp_addr1_state,left,right)='');
							
outfileSkipRAXlink 	:= corp_bdid_corp_addr((not try) or trim(corp_addr1_prim_range,left,right)<>'' or trim(corp_addr1_prim_name,left,right)<>'' or 
							trim(corp_addr1_zip5,left,right)<>'' or trim(corp_addr1_sec_range,left,right) <>'' or trim(corp_addr1_state,left,right)<>'');																			
		
// Then do a rematch for the records which did not BDID and had blank corp addresses, using RA addresses. 
// Turning off BIP on this call so that we don't wipe out linkids already populated.
Business_Header_SS.MAC_Add_BDID_Flex(	outfileTryRAXlink,
																			BDID_Matchset,
																			corp_legal_name,
																			corp_ra_prim_range, corp_ra_prim_name, corp_ra_zip5,
																			corp_ra_sec_range, corp_ra_state,
																			corp_phone10, corp_fed_tax_id,
																			bdid, CorpWithContacts,
																			FALSE, BDID_score_field,
																			corp_bdid_ra_addr,,,,
																			[1],,,,
																			fname,
																			mname,
																			lname,,source_code,source_rec_id,false);
																			
corpAllFlex	:=	corp_bdid_ra_addr + outfileSkipRAXlink;
																		
corp_bdid_all_withBDID 			:= (corpAllFlex)(bdid!=0);	
corp_bdid_all_withOutBDID 	:= (corpAllFlex)(bdid=0);																				
					  
// BDID Corporate records (source matching) third pass
Business_Header.MAC_Source_Match(	corp_bdid_all_withOutBDID, corp_bdid_source,
																	FALSE, bdid,
																	true, source_code,
																	TRUE, corp_key,
																	corp_legal_name,
																	corp_addr1_prim_range, corp_addr1_prim_name, corp_addr1_sec_range, corp_addr1_zip5,
																	TRUE, corp_phone10,
																	TRUE, corp_fed_tax_id,
																	TRUE, corp_key) ;
								 
corp_bdid_all	:=	corp_bdid_all_withBDID + corp_bdid_source;

DedupAll			:=	dedup(sort(distribute(corp_bdid_all,seq),seq,-proxScore,-proxweight,local),seq,local);

/////////////////////////////////////////////////////////////////////////////////////////////////
// -- Match back to before the patch, getting original fields
/////////////////////////////////////////////////////////////////////////////////////////////////
Layout_Corporate_Direct_Corp_AID tbacktobaseformat(corp_to_bdid_nonpatched_seq l, corp_bdid_all r) :=
transform
	self.bdid	:= r.bdid;
	self.DotID			:=	r.DotID;
	self.DotScore		:=	r.DotScore;
	self.DotWeight	:=	r.DotWeight;
	self.EmpID			:=	r.EmpID;
	self.EmpScore		:=	r.EmpScore;
	self.EmpWeight	:=	r.EmpWeight;
	self.POWID			:=	r.POWID;
	self.POWScore		:=	r.POWScore;
	self.POWWeight	:=	r.POWWeight;
	self.ProxID			:=	r.ProxID;
	self.ProxScore	:=	r.ProxScore;
	self.ProxWeight	:=	r.ProxWeight;
	self.SELEID			:=	r.SELEID;
	self.SELEScore	:=	r.SELEScore;
	self.SELEWeight	:=	r.SELEWeight;
	self.OrgID			:=	r.OrgID;
	self.orgScore		:=	r.orgScore;
	self.OrgWeight	:=	r.OrgWeight;
	self.UltID			:=	r.UltID;
	self.UltScore		:=	r.UltScore;
	self.UltWeight	:=	r.UltWeight;	
	self 			:= l;
end;

corp_to_bdid_nonpatched_seq_sort	:= sort(distribute(corp_to_bdid_nonpatched_seq, seq), seq, local);
corp_bdid_all_sort								:= sort(distribute(DedupAll, seq), seq, local);

corp_match_back := join( corp_to_bdid_nonpatched_seq_sort
												,corp_bdid_all_sort
												,left.seq = right.seq
												,tbacktobaseformat(left,right)
												,local
												);
												
srtMatchBack	:=	sort(corp_match_back,RECORD, except dt_first_seen, dt_last_seen, dt_vendor_first_reported, 
												dt_vendor_last_reported, corp_ra_dt_first_seen, corp_ra_dt_last_seen, corp_process_Date, 
												record_type, source_rec_id, DotID, DotScore,	DotWeight, EmpID,	EmpScore,	EmpWeight,	
												POWID,	POWScore, POWWeight,	ProxID, ProxScore, ProxWeight, SELEID, SELEScore,
												SELEWeight,OrgID,orgScore,OrgWeight,UltID,UltScore,UltWeight,local);											
												
corp2.Layout_Corporate_Direct_Corp_AID rolluprecs(corp2.Layout_Corporate_Direct_Corp_AID l, corp2.Layout_Corporate_Direct_Corp_AID r) := transform
   		self.dt_first_seen 						:= ut.min2(l.dt_first_seen, r.dt_first_seen);
   		self.dt_last_seen  						:= ut.max2(l.dt_last_seen, r.dt_last_seen);
   		self.dt_vendor_first_reported := ut.min2(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
   		self.dt_vendor_last_reported  := ut.max2(l.dt_vendor_last_reported, r.dt_vendor_last_reported);	
			SELF.corp_ra_dt_first_seen		:= ut.EarliestDate(l.corp_ra_dt_first_seen, r.corp_ra_dt_first_seen);
			SELF.corp_ra_dt_last_seen			:= ut.LatestDate(l.corp_ra_dt_last_seen, r.corp_ra_dt_last_seen);			
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

rolledup_recs := rollup(srtMatchBack, rolluprecs(left,right),
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

Layout_Corporate_Direct_Corp_AID patchIncDate(corp_ny_srt l, corp_ny_srt r) := transform
   same_group         := if(trim(r.corp_state_origin) = 'NY' and trim(l.corp_key) = trim(r.corp_key), true, false);
   self.Corp_inc_date := if(same_group and
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
corp_w_marked_standing_tx_recs := Mac_Mark_TX_Standing(pTxFtact, corp_recs);

corp_w_marked_standing_tx_recs_Dist 	:= distribute(corp_w_marked_standing_tx_recs, hash(corp_key));
corp_w_marked_standing_tx_recs_Sort 	:= sort(corp_w_marked_standing_tx_recs_Dist,record,local);	
corp_w_marked_standing_tx_recs_dedup 	:= dedup(corp_w_marked_standing_tx_recs_Sort,record,local);

ut.MAC_Append_Rcid(corp_w_marked_standing_tx_recs_dedup,Source_rec_id,out_file);

returndataset	:=	out_file : persist(pPersistname);

return returndataset;
end;