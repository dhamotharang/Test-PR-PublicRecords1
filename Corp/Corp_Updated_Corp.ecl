import ut, Business_Header, Business_Header_SS, address, did_add;

// Project Update to Base Format
Layout_Corp_Temp InitUpdate(Layout_Corporate_Direct_Corp_In l) := transform
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
self.corp_address2_type_cd := Stringlib.StringToUpperCase(l.corp_address2_type_cd);
self.corp_address2_type_desc := Stringlib.StringToUpperCase(l.corp_address2_type_desc);
self.corp_address2_line1 := Stringlib.StringToUpperCase(l.corp_address2_line1);
self.corp_address2_line2 := Stringlib.StringToUpperCase(l.corp_address2_line2);
self.corp_address2_line3 := Stringlib.StringToUpperCase(l.corp_address2_line3);
self.corp_address2_line4 := Stringlib.StringToUpperCase(l.corp_address2_line4);
self.corp_address2_line5 := Stringlib.StringToUpperCase(l.corp_address2_line5);
self.corp_address2_line6 := Stringlib.StringToUpperCase(l.corp_address2_line6);
self.corp_phone_number_type_cd := Stringlib.StringToUpperCase(l.corp_phone_number_type_cd);
self.corp_phone_number_type_desc := Stringlib.StringToUpperCase(l.corp_phone_number_type_desc);
self.corp_filing_cd := Stringlib.StringToUpperCase(l.corp_filing_cd);
self.corp_filing_desc := Stringlib.StringToUpperCase(l.corp_filing_desc);
self.corp_status_cd := Stringlib.StringToUpperCase(l.corp_status_cd);
self.corp_status_desc := Stringlib.StringToUpperCase(l.corp_status_desc);
self.corp_term_exist_cd := Stringlib.StringToUpperCase(l.corp_term_exist_cd);
self.corp_term_exist_exp := Stringlib.StringToUpperCase(l.corp_term_exist_exp);
self.corp_term_exist_desc := Stringlib.StringToUpperCase(l.corp_term_exist_desc);
self.corp_foreign_domestic_ind := Stringlib.StringToUpperCase(l.corp_foreign_domestic_ind);
self.corp_forgn_state_cd := Stringlib.StringToUpperCase(l.corp_forgn_state_cd);
self.corp_forgn_state_desc := Stringlib.StringToUpperCase(l.corp_forgn_state_desc);
self.corp_forgn_term_exist_cd := Stringlib.StringToUpperCase(l.corp_forgn_term_exist_cd);
self.corp_forgn_term_exist_exp := Stringlib.StringToUpperCase(l.corp_forgn_term_exist_exp);
self.corp_forgn_term_exist_desc := Stringlib.StringToUpperCase(l.corp_forgn_term_exist_desc);
self.corp_orig_org_structure_cd := Stringlib.StringToUpperCase(l.corp_orig_org_structure_cd);
self.corp_orig_org_structure_desc := Stringlib.StringToUpperCase(l.corp_orig_org_structure_desc);
self.corp_for_profit_ind := Stringlib.StringToUpperCase(l.corp_for_profit_ind);
self.corp_orig_bus_type_cd := Stringlib.StringToUpperCase(l.corp_orig_bus_type_cd);
self.corp_orig_bus_type_desc := Stringlib.StringToUpperCase(l.corp_orig_bus_type_desc);
self.corp_ra_name := Stringlib.StringToUpperCase(l.corp_ra_name);
self.corp_ra_title_cd := Stringlib.StringToUpperCase(l.corp_ra_title_cd);
self.corp_ra_title_desc := Stringlib.StringToUpperCase(l.corp_ra_title_desc);
self.corp_ra_address_type_cd := Stringlib.StringToUpperCase(l.corp_ra_address_type_cd);
self.corp_ra_address_type_desc := Stringlib.StringToUpperCase(l.corp_ra_address_type_desc);
self.corp_ra_address_line1 := Stringlib.StringToUpperCase(l.corp_ra_address_line1);
self.corp_ra_address_line2 := Stringlib.StringToUpperCase(l.corp_ra_address_line2);
self.corp_ra_address_line3 := Stringlib.StringToUpperCase(l.corp_ra_address_line3);
self.corp_ra_address_line4 := Stringlib.StringToUpperCase(l.corp_ra_address_line4);
self.corp_ra_address_line5 := Stringlib.StringToUpperCase(l.corp_ra_address_line5);
self.corp_ra_address_line6 := Stringlib.StringToUpperCase(l.corp_ra_address_line6);
self.corp_ra_phone_number_type_cd := Stringlib.StringToUpperCase(l.corp_ra_phone_number_type_cd);
self.corp_ra_phone_number_type_desc := Stringlib.StringToUpperCase(l.corp_ra_phone_number_type_desc);
// Fix problem with MS dates
self.corp_ra_effective_date := if(l.corp_state_origin = 'MS' and (integer)l.corp_process_date < 20040321,
                                   l.corp_ra_effective_date[5..8] + l.corp_ra_effective_date[1..2] + l.corp_ra_effective_date[3..4],
								   l.corp_ra_effective_date);

// Set dates
self.dt_first_seen :=
  ut.EarliestDate((unsigned4)CheckDate(l.corp_filing_date), 
  ut.EarliestDate((unsigned4)CheckDate(l.corp_address1_effective_date), 
  ut.EarliestDate((unsigned4)CheckDate(l.corp_address2_effective_date), 
  ut.EarliestDate((unsigned4)CheckDate(l.corp_status_date), 
  ut.EarliestDate((unsigned4)CheckDate(self.corp_ra_effective_date), (unsigned4)CheckDate(l.corp_process_date))))));
self.dt_last_seen := if(
  ut.LatestDate((unsigned4)CheckDate(l.corp_filing_date), 
  ut.LatestDate((unsigned4)CheckDate(l.corp_address1_effective_date), 
  ut.LatestDate((unsigned4)CheckDate(l.corp_address2_effective_date), 
  ut.LatestDate((unsigned4)CheckDate(l.corp_status_date), (unsigned4)CheckDate(self.corp_ra_effective_date))))) <> 0,
  ut.LatestDate((unsigned4)CheckDate(l.corp_filing_date), 
  ut.LatestDate((unsigned4)CheckDate(l.corp_address1_effective_date), 
  ut.LatestDate((unsigned4)CheckDate(l.corp_address2_effective_date), 
  ut.LatestDate((unsigned4)CheckDate(l.corp_status_date), (unsigned4)CheckDate(self.corp_ra_effective_date))))),
  (unsigned4)l.corp_process_date);
self.dt_vendor_first_reported := 
  ut.EarliestDate((unsigned4)CheckDate(l.corp_filing_date), 
  ut.EarliestDate((unsigned4)CheckDate(l.corp_address1_effective_date), 
  ut.EarliestDate((unsigned4)CheckDate(l.corp_address2_effective_date), 
  ut.EarliestDate((unsigned4)CheckDate(l.corp_status_date), 
  ut.EarliestDate((unsigned4)CheckDate(self.corp_ra_effective_date), (unsigned4)CheckDate(l.corp_process_date))))));
self.dt_vendor_last_reported := (unsigned4)CheckDate(l.corp_process_date);
self.corp_phone10 := address.CleanPhone(l.corp_phone_number);
self.corp_ra_phone10 := address.CleanPhone(l.corp_ra_phone_number);
self.record_type := 'H';
self.corp_sos_charter_nbr := map_charter_number(l.corp_vendor,l.corp_state_origin,l.corp_orig_sos_charter_nbr);
self := l;
end;

corp_file := if(Corp_Update_Flag
								,if(Flags.IsUsingV2Inputs
									,if(Flags.UseV2CurrentSprayed
										,File_Corporate_Direct_Corp_Update + Corp.Files.V2.corp
										,File_Corporate_Direct_Corp_Update + Corp.Files.V2.corp_father
									)
									,File_Corporate_Direct_Corp_Update
								)
						,File_Corporate_Direct_Corp_In);

corp_update_dist := distribute(corp_file, hash(corp_key));
corp_update_sort := sort(corp_update_dist, record, local);
corp_update_dedup := dedup(corp_update_sort, record, local);

corp_update_init := project(corp_update_dedup, InitUpdate(left));

/*
corp_update_init := if(Corp_Update_Flag,
                       project(dedup(File_Corporate_Direct_Corp_Update, all), InitUpdate(left)),
					   project(dedup(File_Corporate_Direct_Corp_In, all), InitUpdate(left)));
*/
// Fix any dates necessary
corp_update_init_fix := corp_fix_dates_function(corp_update_init(corp_state_origin in Corp_State_Fix_Dates_List));
corp_update_init_combined := corp_update_init(corp_state_origin not in Corp_State_Fix_Dates_List) + corp_update_init_fix;

corp_update_init_dist := distribute(corp_update_init_combined, hash(corp_key));
corp_update_init_sort := sort(corp_update_init_dist, except bdid, dt_first_seen, dt_last_seen,
                               dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, record_type, local);

Layout_Corp_Temp RollupUpdate(Layout_Corp_Temp l, Layout_Corp_Temp r) := transform
SELF.dt_first_seen := 
            ut.EarliestDate(ut.EarliestDate(l.dt_first_seen,r.dt_first_seen),
		    ut.EarliestDate(l.dt_last_seen,r.dt_last_seen));
SELF.dt_last_seen := ut.LatestDate(l.dt_last_seen,r.dt_last_seen);
SELF.dt_vendor_last_reported := ut.LatestDate(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
SELF.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
SELF.corp_process_date := if(l.corp_process_date > r.corp_process_date, l.corp_process_date, r.corp_process_date);
self := l;
end;

corp_update_init_rollup := rollup(corp_update_init_sort, RollupUpdate(left, right), except bdid, dt_first_seen, dt_last_seen,
                               dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, record_type, local);
							   
// Initialize Current base file
Layout_Corp_Temp InitCurrentBase(Layout_Corp_Base l) := transform
self.bdid := 0;
self.record_type := 'H';
self := l;
end;

corp_current_init := project(File_Corp_Base(corp_vendor <> 'EX', Filters.Base.Corp_Base), InitCurrentBase(left));
corp_current_init_dist := distribute(corp_current_init, hash(corp_key));


// Combine current base with update
corp_update_combined := if(Corp_Update_Flag,
                           corp_current_init_dist + corp_update_init_rollup,
						   corp_update_init_rollup);
						   
// Combine new base with Experian Full States and Experian History
corp_update_combined_history := Corp4_As_Corp(corp_state_origin in Corp4_State_List) + Corp_Combined_History_Function(corp_update_combined);
corp_update_combined_history_dist := distribute(corp_update_combined_history, hash(corp_key));
						   
// Propagate Information Forward to Blank Fields
corp_update_combined_sort := sort(corp_update_combined_history_dist, corp_key, local);
corp_update_combined_grpd := group(corp_update_combined_sort, corp_key, local);
corp_update_combined_grpd_sort := sort(corp_update_combined_grpd, corp_process_date, corp_filing_date, corp_status_date);

corp_update_combined_propagate := group(iterate(corp_update_combined_grpd_sort, TRA_Corp_Propagate_Fields(left, right)));

// Rollup dates for identical records, keep most current status date
corp_update_combined_propagate_sort := sort(corp_update_combined_propagate, except bdid, dt_first_seen, dt_last_seen,
                                            dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, corp_status_date, record_type,
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
                                            dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, corp_status_date, record_type,
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

corp_update_combined_propagate_group_sort := sort(corp_update_combined_propagate_group, -corp_status_date, -corp_process_date);

corp_update_combined_propagate_rollup := group(rollup(corp_update_combined_propagate_group_sort, true, RollupUpdate(left, right)));




// Set Current - Historical Indicator
corp_update_combined_propagate_rollup_sort := sort(corp_update_combined_propagate_rollup, corp_key, local);
corp_update_combined_propagate_rollup_grpd := group(corp_update_combined_propagate_rollup_sort, corp_key, local);
corp_update_combined_propagate_rollup_grpd_sort := sort(corp_update_combined_propagate_rollup_grpd, -dt_vendor_last_reported, -dt_last_seen);

Layout_Corp_Temp SetRecordType(Layout_Corp_Temp L, Layout_Corp_Temp R) := transform
self.record_type := if(l.record_type = '', 'C', r.record_type);
self := r;
end;

corp_update := group(iterate(corp_update_combined_propagate_rollup_grpd_sort, SetRecordType(left, right)));

// Join with Corp Events to update date last seen
layout_event_slim := record
string30  corp_key;
unsigned4 dt_vendor_last_reported;
unsigned4 dt_last_seen;
string8   event_filing_date;
end;

layout_event_slim SlimEvents(Layout_Corp_Event_Temp l) := transform
self := l;
end;

events_slim := project(Corp_Updated_Event(record_type = 'C'), SlimEvents(left));
events_slim_dist := distribute(events_slim, hash(corp_key));
events_slim_sort := sort(events_slim_dist, corp_key, -dt_vendor_last_reported, -dt_last_seen, local);
events_slim_dedup := dedup(events_slim_sort, corp_key, local);

Corp.Layout_Corp_Temp UpdateDates(Layout_Corp_Temp l, layout_event_slim r) := transform
self.dt_vendor_last_reported := ut.LatestDate(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
self.dt_last_seen := if(Checkdate(r.event_filing_date) <> '', ut.LatestDate(l.dt_last_seen, r.dt_last_seen), l.dt_last_seen);
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
// -- Sequence records using bdid field for now(since patch function uses Corp.Layout_Corp_Base)
// -- so we can put fields back in their place after bdiding
/////////////////////////////////////////////////////////////////////////////////////////////////
ut.MAC_Sequence_Records(corp_update_event, bdid, corp_update_event_seq);

corp_to_bdid_patched := corp.fun_PatchAddrWithRA(corp_update_event_seq);

/////////////////////////////////////////////////////////////////////////////////////////////////
// -- Add seq field, since now we can have another field(and need to use bdid field now)
/////////////////////////////////////////////////////////////////////////////////////////////////
layout_corp_seq :=
record
	Corp.Layout_Corp_Base;
	unsigned4 seq := 0;
end;

layout_corp_seq tPopulateSeqField(Corp.Layout_Corp_Base l) :=
transform
	self.seq	:= l.bdid;
	self.bdid	:= 0;
	self 		:= l;
end;

corp_to_bdid_patched_seq	:= project(corp_to_bdid_patched,	tPopulateSeqField(left));
corp_to_bdid_nonpatched_seq	:= project(corp_update_event_seq,	tPopulateSeqField(left));


// BDID Corporate records first pass
Business_Header.MAC_Source_Match(corp_to_bdid_patched_seq, corp_bdid_patched_init,
                        FALSE, bdid,
                        FALSE, 'C',
                        TRUE, corp_key,
                        corp_legal_name,
                        corp_addr1_prim_range, corp_addr1_prim_name, corp_addr1_sec_range, corp_addr1_zip5,
                        TRUE, corp_phone10,
                        TRUE, corp_fed_tax_id,
						TRUE, corp_key);


// Then do a standard BDID match for the records which did not BDID,
// since the Corporate file may be newer than the Business Headers
BDID_Matchset := ['A'];

corp_bdid_match := corp_bdid_patched_init(bdid <> 0);

corp_bdid_nomatch := corp_bdid_patched_init(bdid = 0);

Business_Header_SS.MAC_Add_BDID_Flex(corp_bdid_nomatch,
                                  BDID_Matchset,
                                  corp_legal_name,
                                  corp_addr1_prim_range, corp_addr1_prim_name, corp_addr1_zip5,
                                  corp_addr1_sec_range, corp_addr1_state,
                                  corp_phone10, corp_fed_tax_id,
                                  bdid, layout_corp_seq,
                                  FALSE, BDID_score_field,
                                  corp_bdid_rematch)

corp_bdid_all := corp_bdid_match + corp_bdid_rematch;

/////////////////////////////////////////////////////////////////////////////////////////////////
// -- Match back to before the patch, getting original fields
/////////////////////////////////////////////////////////////////////////////////////////////////
Corp.Layout_Corp_Base tbacktobaseformat(corp_to_bdid_nonpatched_seq l, corp_bdid_all r) :=
transform
	self.bdid	:= r.bdid;
	self 		:= l;
end;

corp_to_bdid_nonpatched_seq_sort	:= sort(distribute(corp_to_bdid_nonpatched_seq, seq), seq, local);
corp_bdid_all_sort					:= sort(distribute(corp_bdid_all, seq), seq, local);

corp_match_back := join( corp_to_bdid_nonpatched_seq_sort
						,corp_bdid_all_sort
						,left.seq = right.seq
						,tbacktobaseformat(left,right)
						,local);

/////////////////////////////////////////////////////////////////////////////////////////////////
// -- Add Dummy data to corp base file
/////////////////////////////////////////////////////////////////////////////////////////////////
dummy_dataset := dataset(
[
	 {999999001001,20060627,0,20060627,0,'26-RVH9999999001001','26','MI','20060719','L9999999001001','MARSUPIAL MANOR III','','PRINCIPAL CORPORATE ADDRESS','12345 S. WAYNE RD.','','ROMULUS, MI 48174','','','','','','','','','','','','','','','','','','','','','','','CC','ACTIVE','20060627','','','MI','19740228','','','D','20221231','EXPIRATION DATE','','','','','','','','','','','','LIMITED PARTNERSHIP','','','','','UNITED STATES CORPORATION COMPANY','','REGISTERED AGENT','','','','','','REGISTERED AGENT ADDRESS','222 W. GENESEE ST.','','LANSING, MI 48933','','','','','','','','','12345','','WAYNE','RD','','','','ROMULUS','ROMULUS','MI','48174','1551','C076','D','136','A','0','4','S','26','163','42.23264','-83.385796','2160','5859001','1','S820','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','UNITED STATES CORPORATION COMPANY','','','','222','W','GENESEE','ST','','','','LANSING','LANSING','MI','48933','1224','C003','D','220','A','22','0','S','26','65','42.738637','-84.55463','4040','6001','1','S800','L9999999001001','','','C'}
	,{999999001001,20021124,20040902,20021124,20040902,'26-RVH9999999001001','26','MI','20040902','L9999999001001','MARSUPIAL MANOR III','','PRINCIPAL CORPORATE ADDRESS','999 S. WAYNE RD.','','ROMULUS, MI 48174','','','','','','','','','','','','','','','','','','','','','','','CC','ACTIVE','20060627','','','MI','19740228','','','D','20221231','EXPIRATION DATE','','','','','','','','','','','','LIMITED PARTNERSHIP','','','','','UNITED STATES CORPORATION COMPANY','','REGISTERED AGENT','','','','','','REGISTERED AGENT ADDRESS','222 W. GENESEE ST.','','LANSING, MI 48933','','','','','','','','','999','','WAYNE','RD','','','','ROMULUS','ROMULUS','MI','48174','1551','C076','D','133','A','0','4','S','26','163','42.23264','-83.385796','2160','5859001','1','S820','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','UNITED STATES CORPORATION COMPANY','','','','222','W','GENESEE','ST','','','','LANSING','LANSING','MI','48933','1224','C003','D','220','A','22','0','S','26','65','42.738637','-84.55463','4040','6001','1','S800','L9999999001001','','','H'}	

], Corp.Layout_Corp_Base);	

Corp.Layout_Corp_Base tAddBuildDates(Corp.Layout_Corp_Base l) :=
transform
	self.dt_last_seen				:= (unsigned4)Corp.Corp_Build_Date;
	self.dt_vendor_last_reported	:= (unsigned4)Corp.Corp_Build_Date;
	self							:= l;
end;

dummy_data_fix_dates := project(dummy_dataset, tAddBuildDates(left));

export Corp_Updated_Corp := corp_match_back + dummy_data_fix_dates : persist(Thor_Cluster + 'persist::Corp::Corp_Updated_Corp');