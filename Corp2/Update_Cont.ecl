/*2013-04-04T16:30:57Z (Julie Franzer)
Modified for BIP2 project - time for code review.
*/
import ut, Business_Header, Business_Header_SS, address, Header, Header_Slimsort, didville, ut, DID_Add,mdr, AID,idl_header;

export Update_Cont(

	 dataset(Layout_Corporate_Direct_Cont_In		) pContUsing				= files().input.Cont.using
	,dataset(Layout_Corporate_Direct_Cont_AID		) pContBase					= files().AID.Cont.QA
	,dataset(Layout_Corporate_Direct_Event_Base	) pUpdate_Event			= Update_Event()
	,string																				pPersistnameBdid	= persistnames.UpdateContBDID
	,string																				pPersistname			= persistnames.UpdateCont

) := 
function

// Project Update to Temp Format
Layout_Corporate_Direct_Cont_AID InitUpdate(Layout_Corporate_Direct_Cont_In l, unsigned1 cnt) := transform
// Uppercase fields
self.corp_legal_name := Stringlib.StringToUpperCase(l.corp_legal_name);
self.corp_address1_type_cd := Stringlib.StringToUpperCase(l.corp_address1_type_cd);
self.corp_address1_type_desc := Stringlib.StringToUpperCase(l.corp_address1_type_desc);
self.corp_address1_line1 := Stringlib.StringToUpperCase(l.corp_address1_line1);
self.corp_address1_line2 := Stringlib.StringToUpperCase(l.corp_address1_line2);
self.corp_address1_line3 := Stringlib.StringToUpperCase(l.corp_address1_line3);
self.corp_address1_line4 := Stringlib.StringToUpperCase(l.corp_address1_line4);
self.corp_address1_line5 := Stringlib.StringToUpperCase(l.corp_address1_line5);
self.corp_address1_line6 := Stringlib.StringToUpperCase(l.corp_address1_line6);
self.corp_phone_number_type_cd := Stringlib.StringToUpperCase(l.corp_phone_number_type_cd);
self.corp_phone_number_type_desc := Stringlib.StringToUpperCase(l.corp_phone_number_type_desc);
self.cont_filing_cd := Stringlib.StringToUpperCase(l.cont_filing_cd);
self.cont_filing_desc := Stringlib.StringToUpperCase(l.cont_filing_desc);
self.cont_type_cd := Stringlib.StringToUpperCase(l.cont_type_cd);
self.cont_type_desc := Stringlib.StringToUpperCase(l.cont_type_desc);
self.cont_name := Stringlib.StringToUpperCase(l.cont_name);
self.cont_title_desc := choose(cnt, Stringlib.StringToUpperCase(l.cont_title1_desc),
                                    Stringlib.StringToUpperCase(l.cont_title2_desc),
                                    Stringlib.StringToUpperCase(l.cont_title3_desc),
                                    Stringlib.StringToUpperCase(l.cont_title4_desc),
                                    Stringlib.StringToUpperCase(l.cont_title5_desc),
																		Stringlib.StringToUpperCase(l.cont_title1_desc), 
																		Stringlib.StringToUpperCase(l.cont_title2_desc) 
);               
self.cont_address_type_cd := Stringlib.StringToUpperCase(l.cont_address_type_cd);
self.cont_address_type_desc := Stringlib.StringToUpperCase(l.cont_address_type_desc);
self.cont_address_line1 := Stringlib.StringToUpperCase(l.cont_address_line1);
self.cont_address_line2 := Stringlib.StringToUpperCase(l.cont_address_line2);
self.cont_address_line3 := Stringlib.StringToUpperCase(l.cont_address_line3);
self.cont_address_line4 := Stringlib.StringToUpperCase(l.cont_address_line4);
self.cont_address_line5 := Stringlib.StringToUpperCase(l.cont_address_line5);
self.cont_address_line6 := Stringlib.StringToUpperCase(l.cont_address_line6);
self.cont_phone_number_type_cd := Stringlib.StringToUpperCase(l.cont_phone_number_type_cd);
self.cont_phone_number_type_desc := Stringlib.StringToUpperCase(l.cont_phone_number_type_desc);
self.cont_title := choose(cnt, l.cont_title1,
                               l.cont_title2,
							   l.cont_title3,
                               l.cont_title4,
                               l.cont_title5,
							   '',
							   '');
self.cont_fname := choose(cnt, l.cont_fname1,
                               l.cont_fname2,
							   l.cont_fname3,
                               l.cont_fname4,
                               l.cont_fname5,
							   '',
							   '');
self.cont_mname := choose(cnt, l.cont_mname1,
                               l.cont_mname2,
							   l.cont_mname3,
                               l.cont_mname4,
                               l.cont_mname5,
							   '',
							   '');
self.cont_lname := choose(cnt, l.cont_lname1,
                               l.cont_lname2,
							   l.cont_lname3,
                               l.cont_lname4,
                               l.cont_lname5,
							   '',
							   '');
self.cont_name_suffix := choose(cnt, l.cont_name_suffix1,
                               l.cont_name_suffix2,
							   l.cont_name_suffix3,
                               l.cont_name_suffix4,
                               l.cont_name_suffix5,
							   '',
							   '');
self.cont_score := choose(cnt, l.cont_score1,
                               l.cont_score2,
							   l.cont_score3,
                               l.cont_score4,
                               l.cont_score5,
							   '',
							   '');
self.cont_cname := choose(cnt, '',
                               '',
							   '',
                               '',
                               '',
							   l.cont_cname1,
							   l.cont_cname2);
self.cont_cname_score := choose(cnt, '',
                               '',
							   '',
                               '',
                               '',
							   l.cont_cname1_score,
							   l.cont_cname2_score);
// Set dates
self.dt_first_seen :=
  ut.EarliestDate((unsigned4)fCheckdate(l.cont_filing_date), 
  ut.EarliestDate((unsigned4)fCheckdate(l.cont_effective_date), 
  ut.EarliestDate((unsigned4)fCheckdate(l.cont_address_effective_date), (unsigned4)fCheckdate(l.corp_process_date))));
self.dt_last_seen := (unsigned4)fCheckdate(l.dt_last_seen);
self.dt_vendor_first_reported := 
  ut.EarliestDate((unsigned4)fCheckdate(l.cont_filing_date), 
  ut.EarliestDate((unsigned4)fCheckdate(l.cont_effective_date), 
  ut.EarliestDate((unsigned4)fCheckdate(l.cont_address_effective_date), (unsigned4)fCheckdate(l.corp_process_date))));
self.dt_vendor_last_reported := (unsigned4)fCheckdate(l.corp_process_date);
self.corp_phone10 := address.CleanPhone(l.corp_phone_number);
self.cont_phone10 := address.CleanPhone(l.cont_phone_number);
self.record_type := 'H';
self.corp_sos_charter_nbr := fMapCharterNumber(l.corp_vendor,l.corp_state_origin,l.corp_orig_sos_charter_nbr);
self.Append_Corp_Addr_RawAID	:=	0;
self.Append_Corp_Addr_ACEAID	:=	0;
self.Append_Cont_Addr_RawAID	:=	0;	
self.Append_Cont_Addr_ACEAID	:=	0;	
self := l;
end;

corp_cont_file :=  if(flags.IsUsingV1Inputs = true, 
								map(flags.UseV1CurrentSprayed = true and flags.ExistcontV1CurrentSprayed	=> pContUsing,
										flags.UseV1CurrentSprayed = false and flags.ExistcontV1FatherSprayed		=> pContUsing,
										pContUsing
										)
								, pContUsing
								);

cont_update_dist := distribute(corp_cont_file, hash(corp_key));
cont_update_sort := sort(cont_update_dist, record, local);
cont_update_dedup := dedup(cont_update_sort, record, local);

cont_update_norm := normalize(cont_update_dedup, 7, InitUpdate(left, counter));

// Filter out blank contact names
cont_update_init := cont_update_norm(cont_lname <> '' or cont_cname <> '');

// Fix any dates necessary
cont_update_init_fix := fFixContDates(cont_update_init(corp_state_origin in Corp2.SetsofStates.setStatesNeedDatesFixed));
cont_update_init_combined := cont_update_init(corp_state_origin not in Corp2.SetsofStates.setStatesNeedDatesFixed) + cont_update_init_fix;


// additional title explosion values were received from the vendor.  The Ab-Initio title table has been changed, but in order
// to avoid re-processing all the ab-initio data, this code was put in place to fix unexploded codes in data already processed.
// The corps2.flags.IsExplodingTitles flag determines if the data needs to be re-evaluated.
Layout_Corporate_Direct_Cont_AID FixTitlesCurrentBase(Layout_Corporate_Direct_Cont_AID l) := transform
	self.cont_title_desc := if(trim(l.corp_state_origin,left,right) = 'FL',
								case(trim(l.cont_title_desc,left,right),
									'AS' =>	'ASSISTANT SECRETARY',
									'AV' => 'ASSISTANT VICE PRESIDENT',
									'AVP' => 'ASSISTANT VICE PRESIDENT',
									'C' => 'CHAIRMAN',
									'CEO' => 'CHIEF EXECUTIVE OFFICER',
									'CFO' => 'CHIEF FINANCIAL OFFICE',
									'COO' => 'CHIEF OPERATING OFFICER',
									'D' => 'DIRECTOR',
									'DIR' => 'DIRECTOR',
									'DT' => 'DIRECTOR',
									'G' => 'GENERAL PARTNER',
									'MGR' => 'MANAGER',
									'MGRM' => 'MEMBER MANAGER',
									'P' => 'PRESIDENT',
									'S' => 'SECRETARY',
									'T' => 'TREASURER',
									'V' => 'VICE PRESIDENT',
									'VPT' => 'VICE PRESIDENT',
									l.cont_title_desc),
								l.cont_title_desc);
	self := l;
end;

cont_update_init_fixed_codes := project(cont_update_init_combined, FixTitlesCurrentBase(left));


cont_update_init_dist := if(corp2.flags.IsExplodingTitles,
							distribute(cont_update_init_fixed_codes(corp_key <> ''), hash(corp_key)),
							distribute(cont_update_init_combined(corp_key <> ''), hash(corp_key)));
cont_update_init_sort := sort(cont_update_init_dist, except bdid, dt_first_seen, dt_last_seen,
                               dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, record_type, 
															 DotID, DotScore, DotWeight,
																EmpID, EmpScore, EmpWeight,
																POWID, POWScore, POWWeight,
																ProxID, ProxScore, ProxWeight,
																SELEID, SELEScore, SELEWeight,
																OrgID, OrgScore, OrgWeight,
																UltID, UltScore, UltWeight,local);

Layout_Corporate_Direct_Cont_AID RollupUpdate(Layout_Corporate_Direct_Cont_AID l, Layout_Corporate_Direct_Cont_AID r) := transform
SELF.dt_first_seen := 
            ut.EarliestDate(ut.EarliestDate(l.dt_first_seen,r.dt_first_seen),
		    ut.EarliestDate(l.dt_last_seen,r.dt_last_seen));
SELF.dt_last_seen := ut.LatestDate(l.dt_last_seen,r.dt_last_seen);
SELF.dt_vendor_last_reported := ut.LatestDate(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
SELF.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
SELF.corp_process_date := if(l.corp_process_date > r.corp_process_date, l.corp_process_date, r.corp_process_date);
self := l;
end;

cont_update_init_rollup := rollup(cont_update_init_sort, RollupUpdate(left, right), except bdid, dt_first_seen, dt_last_seen,
                               dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, record_type, 
															 DotID, DotScore, DotWeight,
																EmpID, EmpScore, EmpWeight,
																POWID, POWScore, POWWeight,
																ProxID, ProxScore, ProxWeight,
																SELEID, SELEScore, SELEWeight,
																OrgID, OrgScore, OrgWeight,
																UltID, UltScore, UltWeight,local);
							   
// Initialize Current base file
Layout_Corporate_Direct_Cont_AID InitCurrentBase(Layout_Corporate_Direct_Cont_AID l) := transform
self.bdid := 0;
self.record_type := 'H';
self.cont_title_desc := if(trim(l.corp_state_origin,left,right) = 'FL',
							case(trim(l.cont_title_desc,left,right),
								'AS' =>	'ASSISTANT SECRETARY',
								'AV' => 'ASSISTANT VICE PRESIDENT',
								'AVP' => 'ASSISTANT VICE PRESIDENT',
								'C' => 'CHAIRMAN',
								'CEO' => 'CHIEF EXECUTIVE OFFICER',
								'CFO' => 'CHIEF FINANCIAL OFFICE',
								'COO' => 'CHIEF OPERATING OFFICER',
								'D' => 'DIRECTOR',
								'DIR' => 'DIRECTOR',
								'DT' => 'DIRECTOR',
								'G' => 'GENERAL PARTNER',
								'MGR' => 'MANAGER',
								'MGRM' => 'MEMBER MANAGER',
								'P' => 'PRESIDENT',
								'S' => 'SECRETARY',
								'T' => 'TREASURER',
								'V' => 'VICE PRESIDENT',
								'VPT' => 'VICE PRESIDENT',
								l.cont_title_desc),
							l.cont_title_desc);
self := l;
end;

cont_current_init := project(Filters.Base.Cont(pContBase), InitCurrentBase(left));

cont_current_init_dedup := dedup(sort(distribute(cont_current_init, hash(corp_key)), record, local), record, local);
cont_current_init_dist := distribute(cont_current_init_dedup, hash(corp_key));

// Combine current base with update
cont_update_combined := map(Flags.Update.Cont and flags.ExistContV2CurrentSprayed =>
															cont_current_init_dist + cont_update_init_rollup,
														Flags.Update.Cont =>
															cont_current_init_dist,
															cont_update_init_rollup
													);
			   
// Combine new base with Experian Full States and Experian History
cont_update_combined_history := 
	if(flags.IsUsingExperianCorp4 = true
		,Corp4AsCorp2Contacts(corp_state_origin in setCorp4AddStates) + fCombineContHistory(cont_update_combined)
		,cont_update_combined
	);

cont_update_combined_history_dist := distribute(cont_update_combined_history, hash(corp_key));

Layout_Temp_Cont	:=	record
		unsigned8		unique_id;
		Layout_Corporate_Direct_Cont_AID;
end;

Layout_Temp_Cont tPreProcess(Layout_Corporate_Direct_Cont_AID l, unsigned4 cnt) :=	transform
		self.unique_id								:=	cnt;
		self													:=	l;
		self													:=	[];
end;
	
dPreProcess := project(cont_update_combined_history_dist, tPreProcess(left,counter)): Persist('~thor_data400::persist::corp2::update_cont::dPreProcess');

addresslayout :=	record
		unsigned8					unique_id;				//to tie back to original record
		unsigned4					address_type;			// contact or mailing
		string100					Append_Prep_Address1;
		string50					Append_Prep_AddressLast;
		AID.Common.xAID		Append_RawAID;		
		AID.Common.xAID		Append_AceAID;			
end;

addresslayout tNormalizeAddress(Layout_Temp_Cont l, unsigned4 cnt) := transform
		self.unique_id								:= 	l.unique_id;
		self.address_type							:= 	cnt;
		self.Append_Prep_Address1			:= 	choose(cnt	,l.corp_prep_addr_line1
																									,l.cont_prep_addr_line1
																						);              
		self.Append_Prep_AddressLast	:= 	choose(cnt	,l.corp_prep_addr_last_line
																									,l.cont_prep_addr_last_line
																						);  
		self.Append_RawAID						:=	choose(cnt 	,l.Append_Corp_Addr_RawAID
																									,l.Append_Cont_Addr_RawAID
																						);
		self.Append_ACEAID						:=	choose(cnt 	,l.Append_Corp_Addr_ACEAID
																									,l.Append_Cont_Addr_ACEAID
																						);	
end;
				
dAddressPrep			:= 	normalize(dPreProcess, 2, tNormalizeAddress(left,counter),local);

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
					
dCleanAddressAppended				:=	project(dAddressCleaned,tCleanAddressAppended(left))  : INDEPENDENT;	
				
dCleanAddressAppended_dist		:= distribute(dCleanAddressAppended	,unique_id);
		
Layout_Temp_Cont tGetStandardizedAddress(Layout_Temp_Cont l	,cleanedAddrLayout r) :=	transform
		self.Append_Corp_Addr_RawAID:= if(r.address_type = 1	,r.Append_RawAID							,l.Append_Corp_Addr_RawAID);
		self.Append_Corp_Addr_ACEAID:= if(r.address_type = 1	,r.Append_ACEAID							,l.Append_Corp_Addr_ACEAID);
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
		
		self.Append_Cont_Addr_RawAID:= if(r.address_type = 2	,r.Append_RawAID							,l.Append_Cont_Addr_RawAID);
		self.Append_Cont_Addr_ACEAID:= if(r.address_type = 2	,r.Append_ACEAID							,l.Append_Cont_Addr_ACEAID);
		self.cont_prim_range				:= if(r.address_type = 2	,r.Clean_address.prim_range		,l.cont_prim_range);
		self.cont_predir						:= if(r.address_type = 2	,r.Clean_address.predir				,l.cont_predir);
		self.cont_prim_name					:= if(r.address_type = 2	,r.Clean_address.prim_name		,l.cont_prim_name);
		self.cont_addr_suffix				:= if(r.address_type = 2	,r.Clean_address.addr_suffix	,l.cont_addr_suffix);
		self.cont_postdir						:= if(r.address_type = 2	,r.Clean_address.postdir			,l.cont_postdir);
		self.cont_unit_desig				:= if(r.address_type = 2	,r.Clean_address.unit_desig		,l.cont_unit_desig);
		self.cont_sec_range					:= if(r.address_type = 2	,r.Clean_address.sec_range		,l.cont_sec_range);
		self.cont_p_city_name				:= if(r.address_type = 2	,r.Clean_address.p_city_name	,l.cont_p_city_name);
		self.cont_v_city_name				:= if(r.address_type = 2	,r.Clean_address.v_city_name	,l.cont_v_city_name);
		self.cont_state							:= if(r.address_type = 2	,r.Clean_address.st						,l.cont_state);
		self.cont_zip5							:= if(r.address_type = 2	,r.Clean_address.zip					,l.cont_zip5);
		self.cont_zip4							:= if(r.address_type = 2	,r.Clean_address.zip4					,l.cont_zip4);		
		self.cont_cart							:= if(r.address_type = 2	,r.Clean_address.cart					,l.cont_cart);
		self.cont_cr_sort_sz				:= if(r.address_type = 2	,r.Clean_address.cr_sort_sz		,l.cont_cr_sort_sz);
		self.cont_lot								:= if(r.address_type = 2	,r.Clean_address.lot					,l.cont_lot);
		self.cont_lot_order					:= if(r.address_type = 2	,r.Clean_address.lot_order		,l.cont_lot_order);
		self.cont_dpbc							:= if(r.address_type = 2	,r.Clean_address.dbpc					,l.cont_dpbc);
		self.cont_chk_digit					:= if(r.address_type = 2	,r.Clean_address.chk_digit		,l.cont_chk_digit);
		self.cont_rec_type					:= if(r.address_type = 2	,r.Clean_address.rec_type			,l.cont_rec_type);
		self.cont_ace_fips_st				:= if(r.address_type = 2	,r.Clean_address.county[1..2]	,l.cont_ace_fips_st);
		self.cont_county						:= if(r.address_type = 2	,r.Clean_address.county[3..5]	,l.cont_county);
		self.cont_geo_lat						:= if(r.address_type = 2	,r.Clean_address.geo_lat			,l.cont_geo_lat);
		self.cont_geo_long					:= if(r.address_type = 2	,r.Clean_address.geo_long			,l.cont_geo_long);
		self.cont_msa								:= if(r.address_type = 2	,r.Clean_address.msa					,l.cont_msa);
		self.cont_geo_blk						:= if(r.address_type = 2	,r.Clean_address.geo_blk			,l.cont_geo_blk);
		self.cont_geo_match					:= if(r.address_type = 2	,r.Clean_address.geo_match		,l.cont_geo_match);
		self.cont_err_stat					:= if(r.address_type = 2	,r.Clean_address.err_stat			,l.cont_err_stat);
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
		
	dCleanContAddress2Appended	:= join(
																			dCleanCorpAddress1Appended
																			,dCleanAddressAppended_dist(address_type = 2)
																			,left.unique_id = right.unique_id
																			,tGetStandardizedAddress(left,right)
																			,local
																			,left outer
																			);
														
	cont_update_combined_AID		:=	project(dCleanContAddress2Appended,TRANSFORM(Layout_Corporate_Direct_Cont_AID,SELF := LEFT;)): Persist('~thor_data400::persist::corp2::update_cont::AIDProcess');;
	
	Address.Mac_Is_Business( cont_update_combined_AID(cont_name != '') ,cont_name,Clean_Cont_Name,name_flag,false,true );

	cln_layout := RECORD
			recordof(cont_update_combined_AID);
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
	
	dContNameBlank        :=      project(cont_update_combined_AID(cont_name = ''),transform(cln_layout,self	:=	left; self	:=	[]));
	dContCleanName        :=      Clean_Cont_Name   +  dContNameBlank;

	Layout_Corporate_Direct_Cont_AID  CleanContNameAddr( dContCleanName  l) := transform
			self.cont_title			:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_title,
																	l.name_flag = 'U' => l.cont_title, '');
			self.cont_fname			:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_fname,
																	l.name_flag = 'U' => l.cont_fname, '');
			self.cont_mname			:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_mname,
																	l.name_flag = 'U' => l.cont_mname, '');
			self.cont_lname			:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_lname,
																	l.name_flag = 'U' => l.cont_lname, '');
			self.cont_name_suffix	:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_suffix,
																				l.name_flag = 'U' => l.cont_name_suffix, '');
			self.cont_cname			:= if(l.name_flag = 'B',l.cont_name,'');	
			
			self								:=	l;
			self								:=	[];
	end;		
				
	cleanConts	:=project( dContCleanName ,CleanContNameAddr(left));
				
	ut.mac_flipnames(cleanConts,cont_fname,cont_mname,cont_lname,cleanConts_Nameflip);
	
	NameFlip_dist	:=	distribute(cleanConts_Nameflip, hash(corp_key));	

// Propagate Information Forward to Blank Fields
cont_update_combined_sort := sort(NameFlip_dist, corp_key, local);
cont_update_combined_grpd := group(cont_update_combined_sort, corp_key, local);
cont_update_combined_grpd_sort := sort(cont_update_combined_grpd, corp_process_date, cont_filing_date, cont_effective_date);

cont_update_combined_propagate := group(iterate(cont_update_combined_grpd_sort, tPropagateContFields(left, right,counter)));

// Rollup dates for identical records
cont_update_combined_propagate_sort := sort(cont_update_combined_propagate, except bdid, did, dt_first_seen, dt_last_seen,
                                            dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, record_type,
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
corp_addr1_rec_type;
corp_addr1_ace_fips_st,
corp_addr1_county,
corp_addr1_geo_lat,
corp_addr1_geo_long,
corp_addr1_msa,
corp_addr1_geo_blk,
corp_addr1_geo_match,
corp_addr1_err_stat,
cont_prim_range,
cont_predir,
cont_prim_name,
cont_addr_suffix,
cont_postdir,
cont_unit_desig,
cont_sec_range,
cont_p_city_name,
cont_v_city_name,
cont_state,
cont_zip5,
cont_zip4,
cont_cart,
cont_cr_sort_sz,
cont_lot,
cont_lot_order,
cont_dpbc,
cont_chk_digit,
cont_rec_type,
cont_ace_fips_st,
cont_county,
cont_geo_lat,
cont_geo_long,
cont_msa,
cont_geo_blk,
cont_geo_match,
cont_err_stat,
corp_orig_sos_charter_nbr,
//except linkids
DotID, DotScore, DotWeight,
EmpID, EmpScore, EmpWeight,
POWID, POWScore, POWWeight,
ProxID, ProxScore, ProxWeight,
SELEID, SELEScore, SELEWeight,
OrgID, OrgScore, OrgWeight,
UltID, UltScore, UltWeight,
// Append_Corp_Addr_RawAID,
// corp_prep_addr_line1,
// corp_prep_addr_last_line,
// Append_Cont_Addr_RawAID,
// cont_prep_addr_line1,
// cont_prep_addr_last_line,
local);

cont_update_combined_propagate_group := group(cont_update_combined_propagate_sort, except bdid, did, dt_first_seen, dt_last_seen,
																							dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, record_type,
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
corp_addr1_rec_type;
corp_addr1_ace_fips_st,
corp_addr1_county,
corp_addr1_geo_lat,
corp_addr1_geo_long,
corp_addr1_msa,
corp_addr1_geo_blk,
corp_addr1_geo_match,
corp_addr1_err_stat,
cont_prim_range,
cont_predir,
cont_prim_name,
cont_addr_suffix,
cont_postdir,
cont_unit_desig,
cont_sec_range,
cont_p_city_name,
cont_v_city_name,
cont_state,
cont_zip5,
cont_zip4,
cont_cart,
cont_cr_sort_sz,
cont_lot,
cont_lot_order,
cont_dpbc,
cont_chk_digit,
cont_rec_type,
cont_ace_fips_st,
cont_county,
cont_geo_lat,
cont_geo_long,
cont_msa,
cont_geo_blk,
cont_geo_match,
cont_err_stat,
corp_orig_sos_charter_nbr,
//except linkids
DotID, DotScore, DotWeight,
EmpID, EmpScore, EmpWeight,
POWID, POWScore, POWWeight,
ProxID, ProxScore, ProxWeight,
SELEID, SELEScore, SELEWeight,
OrgID, OrgScore, OrgWeight,
UltID, UltScore, UltWeight,
// Append_Corp_Addr_RawAID,
// corp_prep_addr_line1,
// corp_prep_addr_last_line,
// Append_Cont_Addr_RawAID,
// cont_prep_addr_line1,
// cont_prep_addr_last_line,
local);

// cont_update_combined_propagate_group_sort := sort(cont_update_combined_propagate_group, -corp_process_date);

cont_update_combined_propagate_rollup := group(rollup(cont_update_combined_propagate_group, true, RollupUpdate(left, right)));

// Set Current - Historical Indicator
cont_update_combined_propagate_rollup_sort := sort(cont_update_combined_propagate_rollup, corp_key, local);
cont_update_combined_propagate_rollup_grpd := group(cont_update_combined_propagate_rollup_sort, corp_key, local);
cont_update_combined_propagate_rollup_grpd_sort := sort(cont_update_combined_propagate_rollup_grpd, -dt_vendor_last_reported, -dt_last_seen);

Layout_Corporate_Direct_Cont_AID SetRecordType(Layout_Corporate_Direct_Cont_AID L, Layout_Corporate_Direct_Cont_AID R) := transform
	isdatethesame 					:= if(l.dt_vendor_last_reported != 0 and l.dt_vendor_last_reported = r.dt_vendor_last_reported, true,false);
	ispreviousrecordcurrent := if(l.record_type = 'C',true, false);
	isfirstrecord 					:= if(l.record_type = '',true, false);
	decision 								:= if(isfirstrecord or (isdatethesame and ispreviousrecordcurrent), 'C', r.record_type);

	self.record_type				:= decision;
	// self.record_type := if(l.record_type = ''or
                       // (l.record_type = 'C' and l.dt_last_seen = r.dt_last_seen), 'C', r.record_type);
	self := r;
end;

cont_update := group(iterate(cont_update_combined_propagate_rollup_grpd_sort, SetRecordType(left, right)));

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

temp_source_lay := 
record
	Layout_Corporate_Direct_Cont_AID;
	string2 source_code;
end;

temp_source_lay UpdateDates(Layout_Corporate_Direct_Cont_AID l, layout_event_slim r) :=
transform
	self.dt_vendor_last_reported	:= ut.LatestDate(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
	self.dt_last_seen							:= if(fCheckdate(r.event_filing_date) <> '', ut.LatestDate(l.dt_last_seen, r.dt_last_seen), l.dt_last_seen);
	self.source_code							:= MDR.sourceTools.fCorpV2(l.corp_key, l.corp_state_origin);
	self := l;
end;

cont_update_event := join(cont_update,
                    events_slim_dedup,
					left.corp_key = right.corp_key and
					left.record_type = 'C',
					UpdateDates(left, right),
					left outer,
					local);
					
// BDID Corporate records
cont_to_bdid := cont_update_event;

Business_Header.MAC_Source_Match(cont_to_bdid, cont_bdid_init,
                        FALSE, bdid,
                        true, source_code,
                        TRUE, corp_key,
                        corp_legal_name,
                        corp_addr1_prim_range, corp_addr1_prim_name, corp_addr1_sec_range, corp_addr1_zip5,
                        TRUE, corp_phone10,
                        FALSE, corp_fed_tax_id,
												TRUE, corp_key);

// Then do a standard BDID match for the records which did not BDID,
// since the Corporate file may be newer than the Business Headers
BDID_Matchset := ['A'];

Business_Header_SS.MAC_Add_BDID_Flex(cont_bdid_init,
                                  BDID_Matchset,
                                  corp_legal_name,
                                  corp_addr1_prim_range, corp_addr1_prim_name, corp_addr1_zip5,
                                  corp_addr1_sec_range, corp_addr1_state,
                                  corp_phone10, corp_fed_tax_id,
                                  bdid, temp_source_lay,
                                  FALSE, BDID_score_field,
                                  cont_bdid_rematch,,,,
																	BIPV2.xlink_version_set,,,,
																	cont_fname,
																	cont_mname,
																	cont_lname);

cont_bdid_all := cont_bdid_rematch : persist(pPersistnameBdid);

Layout_Corporate_Direct_Cont_Base_DID := record
unsigned6 uid := 0;
Layout_Corporate_Direct_Cont_AID;
unsigned6 adl := 0;
unsigned1 adl_score := 0;
end;

cont_did_init := project(cont_bdid_all, transform(Layout_Corporate_Direct_Cont_Base_DID, self := left));

ut.MAC_Sequence_Records(cont_did_init, uid, cont_did_seq);

cont_update_did_seq	:=	cont_did_seq :  Persist('~thor_data400::persist::corp2::update_cont::cont_did_seq');

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
layout_corp_cont_slim NormCorpCont(Layout_Corporate_Direct_Cont_Base_DID l, unsigned1 cnt) := transform
self.cont_prim_range := choose(cnt, l.cont_prim_range, l.corp_addr1_prim_range);
self.cont_prim_name := choose(cnt, l.cont_prim_name, l.corp_addr1_prim_name);
self.cont_sec_range := choose(cnt, l.cont_sec_range, l.corp_addr1_sec_range);
self.cont_state := choose(cnt, l.cont_state, l.corp_addr1_state);
self.cont_zip5 := choose(cnt, l.cont_zip5, l.corp_addr1_zip5);
self.cont_phone10 := choose(cnt, l.cont_phone10, l.corp_phone10);
self := l;
end;

cont_to_did := normalize(cont_did_seq, 2, NormCorpCont(left, counter));
cont_to_did_dedup := dedup(cont_to_did, all);

// Match to Headers by Contact Name and Address
Cont_Matchset := ['A','D','S','P'];

DID_Add.MAC_Match_Flex(cont_to_did_dedup, Cont_Matchset,
	 cont_ssn, cont_dob, cont_fname, cont_mname, cont_lname, cont_name_suffix, 
	 cont_prim_range, cont_prim_name, cont_sec_range, cont_zip5, cont_state, cont_phone10,
	 adl,
	 layout_corp_cont_slim, 
	 TRUE, adl_score,
	 75,
	 cont_did_all)

// dedup, keep highest score	 
cont_did_dist := distribute(cont_did_all, hash(uid));
cont_did_sort := sort(cont_did_dist, uid, if(adl <> 0, 0, 1), -adl_score, local);
cont_did_dedup := dedup(cont_did_sort, uid, local);

// Assign dids to original records
cont_did_seq_dist := distribute(cont_did_seq, hash(uid));

	 
Layout_Corporate_Direct_Cont_AID AssignDIDs(Layout_Corporate_Direct_Cont_Base_DID l, layout_corp_cont_slim r) := transform
self.did := if(r.adl <> 0, r.adl, 0);
self := l;
end;

cont_did_append := join(cont_did_seq_dist,
                        cont_did_dedup,
						left.uid = right.uid,
						AssignDIDs(left, right),
						left outer,
						local);
						
cont_did_append_Sort := sort(cont_did_append,record,local);

// Code for Bug#157300 - Romove Angela Farole from Avante Abstract Inc.
ContFilter	:=	cont_did_append_Sort(stringlib.StringFind(corp_legal_name, 'AVANTE\' ABSTRACT',1) = 0 or (stringlib.StringFind(corp_legal_name, 'AVANTE\' ABSTRACT',1) > 0 and did!= 68482046));	
						
// code added for CA issue bug # 136834						
setKeys	:=	['06-200803810290','06-201216610151']; 

returndataset := dedup(ContFilter(corp_key not in setKeys or (corp_key in setKeys and cont_name = 'ROBERT KIMINECZ')),record,local) : persist(pPersistname);

return returndataset;

end;