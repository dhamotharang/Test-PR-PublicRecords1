import ut, Business_Header, Business_Header_SS, address, did_add;

// Project Update to Base Format
Corp.Layout_Corp_Supp_Temp InitUpdate(Corp.Layout_Corporate_Direct_Supp_In l) := transform
// Upperecase fields
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
self.supp_filing_cd := Stringlib.StringToUpperCase(l.supp_filing_cd);
self.supp_filing_desc := Stringlib.StringToUpperCase(l.supp_filing_desc);
self.supp_name := Stringlib.StringToUpperCase(l.supp_name);
self.supp_type_cd := Stringlib.StringToUpperCase(l.supp_type_cd);
self.supp_type_desc := Stringlib.StringToUpperCase(l.supp_type_desc);
self.supp_location_cd := Stringlib.StringToUpperCase(l.supp_location_cd);
self.supp_location_desc := Stringlib.StringToUpperCase(l.supp_location_desc);
self.supp_cont_name := Stringlib.StringToUpperCase(l.supp_cont_name);
self.supp_cont_title_cd := Stringlib.StringToUpperCase(l.supp_cont_title_cd);
self.supp_cont_title_desc := Stringlib.StringToUpperCase(l.supp_cont_title_desc);
self.supp_address_type_cd := Stringlib.StringToUpperCase(l.supp_address_type_cd);
self.supp_address_type_desc := Stringlib.StringToUpperCase(l.supp_address_type_desc);
self.supp_address_line1 := Stringlib.StringToUpperCase(l.supp_address_line1);
self.supp_address_line2 := Stringlib.StringToUpperCase(l.supp_address_line2);
self.supp_address_line3 := Stringlib.StringToUpperCase(l.supp_address_line3);
self.supp_address_line4 := Stringlib.StringToUpperCase(l.supp_address_line4);
self.supp_address_line5 := Stringlib.StringToUpperCase(l.supp_address_line5);
self.supp_address_line6 := Stringlib.StringToUpperCase(l.supp_address_line6);
self.supp_phone_number_type_cd := Stringlib.StringToUpperCase(l.supp_phone_number_type_cd);
self.supp_phone_number_type_desc := Stringlib.StringToUpperCase(l.supp_phone_number_type_desc);
// Set dates
self.dt_first_seen :=
  ut.EarliestDate((unsigned4)CheckDate(l.supp_filing_date), 
  ut.EarliestDate((unsigned4)CheckDate(l.supp_cont_effective_date), 
  ut.EarliestDate((unsigned4)CheckDate(l.supp_address_effective_date),
  ut.EarliestDate((unsigned4)CheckDate(l.corp_address1_effective_date),(unsigned4)CheckDate(l.corp_process_date)))));
self.dt_last_seen := if(
  ut.LatestDate((unsigned4)CheckDate(l.supp_filing_date), 
  ut.LatestDate((unsigned4)CheckDate(l.supp_cont_effective_date),
  ut.LatestDate((unsigned4)CheckDate(l.supp_address_effective_date), (unsigned4)CheckDate(l.corp_address1_effective_date)))) <> 0,
  ut.LatestDate((unsigned4)CheckDate(l.supp_filing_date), 
  ut.LatestDate((unsigned4)CheckDate(l.supp_cont_effective_date),
  ut.LatestDate((unsigned4)CheckDate(l.supp_address_effective_date), (unsigned4)CheckDate(l.corp_address1_effective_date)))),
  (unsigned4)CheckDate(l.corp_process_date));
self.dt_vendor_first_reported := 
  ut.EarliestDate((unsigned4)CheckDate(l.supp_filing_date), 
  ut.EarliestDate((unsigned4)CheckDate(l.supp_cont_effective_date), 
  ut.EarliestDate((unsigned4)CheckDate(l.supp_address_effective_date),
  ut.EarliestDate((unsigned4)CheckDate(l.corp_address1_effective_date),(unsigned4)CheckDate(l.corp_process_date)))));
self.dt_vendor_last_reported := (unsigned4)CheckDate(l.corp_process_date);
self.corp_phone10 := address.CleanPhone(l.corp_phone_number);
self.supp_phone10 := address.CleanPhone(l.supp_phone_number);
self.record_type := 'H';
self := l;
end;

supp_update_init := if(Corp_Update_Flag,
                       project(dedup(Corp.File_Corporate_Direct_Supp_Update(corp_key <> ''), all), InitUpdate(left)),
					   project(dedup(Corp.File_Corporate_Direct_Supp_In(corp_key <> ''), all), InitUpdate(left)));

// Fix any dates necessary
supp_update_init_fix := corp_supp_fix_dates_function(supp_update_init(corp_state_origin in Corp_State_Fix_Dates_List));
supp_update_init_combined := supp_update_init(corp_state_origin not in Corp_State_Fix_Dates_List) + supp_update_init_fix;

supp_update_init_dist := distribute(supp_update_init_combined, hash(corp_key));
supp_update_init_sort := sort(supp_update_init_dist, except bdid, dt_first_seen, dt_last_seen,
                               dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, record_type, local);

Corp.Layout_Corp_Supp_Temp RollupUpdate(Corp.Layout_Corp_Supp_Temp l, Corp.Layout_Corp_Supp_Temp r) := transform
SELF.dt_first_seen := 
            ut.EarliestDate(ut.EarliestDate(l.dt_first_seen,r.dt_first_seen),
		    ut.EarliestDate(l.dt_last_seen,r.dt_last_seen));
SELF.dt_last_seen := ut.LatestDate(l.dt_last_seen,r.dt_last_seen);
SELF.dt_vendor_last_reported := ut.LatestDate(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
SELF.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
SELF.corp_process_date := if(l.corp_process_date > r.corp_process_date, l.corp_process_date, r.corp_process_date);
self := l;
end;

supp_update_init_rollup := rollup(supp_update_init_sort, RollupUpdate(left, right), except bdid, dt_first_seen, dt_last_seen,
                               dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, record_type, local);
							   
// Initialize Current base file
Corp.Layout_Corp_Supp_Temp InitCurrentBase(Corp.Layout_Corp_Supp_Base l) := transform
self.bdid := 0;
self.record_type := 'H';
self := l;
end;

supp_current_init := project(Corp.File_Corp_Supp_Base(Corp.Corp_Supp_Base_Filter), InitCurrentBase(left));
supp_current_init_dedup := dedup(supp_current_init, all);
supp_current_init_dist := distribute(supp_current_init_dedup, hash(corp_key));

// Combine current base with update
supp_update_combined := if(Corp_Update_Flag,
                           supp_current_init_dist + supp_update_init_rollup,
						   supp_update_init_rollup);
						   
// Propagate Information Forward to Blank Fields
supp_update_combined_sort := sort(supp_update_combined, corp_key, local);
supp_update_combined_grpd := group(supp_update_combined_sort, corp_key, local);
supp_update_combined_grpd_sort := sort(supp_update_combined_grpd, corp_process_date, supp_filing_date);

supp_update_combined_propagate := group(iterate(supp_update_combined_grpd_sort, Corp.TRA_Supp_Propagate_Fields(left, right)));

// Rollup dates for identical records
supp_update_combined_propagate_sort := sort(supp_update_combined_propagate, except bdid, dt_first_seen, dt_last_seen,
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
supp_cont_prim_range,
supp_cont_predir,
supp_cont_prim_name,
supp_cont_addr_suffix,
supp_cont_postdir,
supp_cont_unit_desig,
supp_cont_sec_range,
supp_cont_p_city_name,
supp_cont_v_city_name,
supp_cont_state,
supp_cont_zip5,
supp_cont_zip4,
supp_cont_cart,
supp_cont_cr_sort_sz,
supp_cont_lot,
supp_cont_lot_order,
supp_cont_dpbc,
supp_cont_chk_digit,
supp_cont_rec_type,
supp_cont_ace_fips_st,
supp_cont_county,
supp_cont_geo_lat,
supp_cont_geo_long,
supp_cont_msa,
supp_cont_geo_blk,
supp_cont_geo_match,
supp_cont_err_stat,
local);

supp_update_combined_propagate_group := group(supp_update_combined_propagate_sort, except bdid, dt_first_seen, dt_last_seen,
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
supp_cont_prim_range,
supp_cont_predir,
supp_cont_prim_name,
supp_cont_addr_suffix,
supp_cont_postdir,
supp_cont_unit_desig,
supp_cont_sec_range,
supp_cont_p_city_name,
supp_cont_v_city_name,
supp_cont_state,
supp_cont_zip5,
supp_cont_zip4,
supp_cont_cart,
supp_cont_cr_sort_sz,
supp_cont_lot,
supp_cont_lot_order,
supp_cont_dpbc,
supp_cont_chk_digit,
supp_cont_rec_type,
supp_cont_ace_fips_st,
supp_cont_county,
supp_cont_geo_lat,
supp_cont_geo_long,
supp_cont_msa,
supp_cont_geo_blk,
supp_cont_geo_match,
supp_cont_err_stat,
local);

supp_update_combined_propagate_group_sort := sort(supp_update_combined_propagate_group, -corp_process_date);

supp_update_combined_propagate_rollup := group(rollup(supp_update_combined_propagate_group_sort, true, RollupUpdate(left, right)));

// Set Current - Historical Indicator
supp_update_combined_propagate_rollup_sort := sort(supp_update_combined_propagate_rollup, corp_key, local);
supp_update_combined_propagate_rollup_grpd := group(supp_update_combined_propagate_rollup_sort, corp_key, local);
supp_update_combined_propagate_rollup_grpd_sort := sort(supp_update_combined_propagate_rollup_grpd, -dt_vendor_last_reported, -dt_last_seen);

Corp.Layout_Corp_Supp_Temp SetRecordType(Corp.Layout_Corp_Supp_Temp L, Corp.Layout_Corp_Supp_Temp R) := transform
self.record_type := if(l.record_type = '', 'C', r.record_type);
self := r;
end;

supp_update := group(iterate(supp_update_combined_propagate_rollup_grpd_sort, SetRecordType(left, right)));

// Join with Corp Events to update date last seen
layout_event_slim := record
string30  corp_key;
unsigned4 dt_vendor_last_reported;
unsigned4 dt_last_seen;
string8   event_filing_date;
end;

layout_event_slim SlimEvents(Corp.Layout_Corp_Event_Temp l) := transform
self := l;
end;

events_slim := project(Corp.Corp_Updated_Event(record_type = 'C'), SlimEvents(left));
events_slim_dist := distribute(events_slim, hash(corp_key));
events_slim_sort := sort(events_slim_dist, corp_key, -dt_vendor_last_reported, -dt_last_seen, local);
events_slim_dedup := dedup(events_slim_sort, corp_key, local);

Corp.Layout_Corp_Supp_Temp UpdateDates(Corp.Layout_Corp_Supp_Temp l, layout_event_slim r) := transform
self.dt_vendor_last_reported := ut.LatestDate(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
self.dt_last_seen := if(Checkdate(r.event_filing_date) <> '', ut.LatestDate(l.dt_last_seen, r.dt_last_seen), l.dt_last_seen);
self := l;
end;

supp_update_event := join(supp_update,
                    events_slim_dedup,
					left.corp_key = right.corp_key and
					left.record_type = 'C',
					UpdateDates(left, right),
					left outer,
					local);
					
// BDID Corporate records
supp_to_bdid := supp_update_event;

Business_Header.MAC_Source_Match(supp_to_bdid, supp_bdid_init,
                        FALSE, bdid,
                        FALSE, 'C',
//                        TRUE, corp_key,
                        FALSE, corp_key,
                        corp_legal_name,
                        corp_addr1_prim_range, corp_addr1_prim_name, corp_addr1_sec_range, corp_addr1_zip5,
                        TRUE, corp_phone10,
                        FALSE, corp_fed_tax_id,
//						TRUE, corp_key)
                        FALSE, corp_key);

// Then do a standard BDID match for the records which did not BDID,
// since the Corporate file may be newer than the Business Headers
BDID_Matchset := ['A'];

supp_bdid_match := supp_bdid_init(bdid <> 0);

supp_bdid_nomatch := supp_bdid_init(bdid = 0);

Business_Header_SS.MAC_Add_BDID_Flex(supp_bdid_nomatch,
                                  BDID_Matchset,
                                  corp_legal_name,
                                  corp_addr1_prim_range, corp_addr1_prim_name, corp_addr1_zip5,
                                  corp_addr1_sec_range, corp_addr1_state,
                                  corp_phone10, corp_fed_tax_id,
                                  bdid, Corp.Layout_Corp_Supp_Temp,
                                  FALSE, BDID_score_field,
                                  supp_bdid_rematch)

supp_bdid_all := supp_bdid_match + supp_bdid_rematch;

export Corp_Updated_Supp := supp_bdid_all : persist('TEMP::Corp_Supp_Base');