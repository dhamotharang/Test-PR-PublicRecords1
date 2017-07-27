import ut, Business_Header, Business_Header_SS, address, Header, Header_Slimsort, didville, ut, DID_Add, corp;

Layout_Corp_Cont_Base_Old := record
unsigned6 bdid := 0;       // Seisint Business Identifier
unsigned4 dt_first_seen;
unsigned4 dt_last_seen;
unsigned4 dt_vendor_first_reported;
unsigned4 dt_vendor_last_reported;
Corp.Layout_Corporate_Direct_Cont_In;
string10  corp_phone10;
string10  cont_phone10;
STRING1   record_type;           // 'C' Current
                                 // 'H' Historical
end;

cont_base_old := dataset('~thor_data400::base::corp_cont_basew20050601-152451', Layout_Corp_Cont_Base_Old, flat);

// Project Update to Temp Format
Corp.Layout_Corp_Cont_Temp ConvertBase(Layout_Corp_Cont_Base_Old l, unsigned1 cnt) := transform
self.cont_title_desc := choose(cnt, Stringlib.StringToUpperCase(l.cont_title1_desc),
                                    Stringlib.StringToUpperCase(l.cont_title2_desc),
                                    Stringlib.StringToUpperCase(l.cont_title3_desc),
                                    Stringlib.StringToUpperCase(l.cont_title4_desc),
                                    Stringlib.StringToUpperCase(l.cont_title5_desc),
									'',
									'');
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
self := l;
end;


cont_base_convert_init := normalize(cont_base_old, 7, ConvertBase(left, counter));

cont_base_convert := cont_base_convert_init(cont_lname <> '' or cont_cname <> '');
cont_base_convert_dist := distribute(cont_base_convert, hash(corp_key));

// Add in Registered Agents
corp_base_old := dataset('~thor_data400::base::corp_basew20050601-152451', Corp.Layout_Corp_Base, flat);

// Add registered agents from Corp Base
Corp.Layout_Corp_Cont_Temp NormRegAgents(Corp.Layout_Corp_Base l, unsigned1 cnt) := transform
self.cont_title := choose(cnt, l.corp_ra_title1, l.corp_ra_title2);
self.cont_fname := choose(cnt, l.corp_ra_fname1, l.corp_ra_fname2);
self.cont_mname := choose(cnt, l.corp_ra_mname1, l.corp_ra_mname2);
self.cont_lname := choose(cnt, l.corp_ra_lname1, l.corp_ra_lname2);
self.cont_name_suffix := choose(cnt, l.corp_ra_name_suffix1, l.corp_ra_name_suffix2);
self.cont_score := choose(cnt, l.corp_ra_score1, l.corp_ra_score2);
self.cont_filing_reference_nbr := l.corp_filing_reference_nbr;
self.cont_filing_date := l.corp_filing_date;
self.cont_filing_cd := l.corp_filing_cd;
self.cont_filing_desc := l.corp_filing_desc;
self.cont_type_cd := if(l.corp_ra_title_cd <> '' and l.corp_ra_title_desc <> '', l.corp_ra_title_cd, 'RA');
self.cont_type_desc := if(l.corp_ra_title_cd <> '' and l.corp_ra_title_desc <> '', l.corp_ra_title_desc, 'REGISTERED AGENT');
self.cont_name := l.corp_ra_name;
self.cont_title_desc := if(l.corp_ra_title_cd <> '' and l.corp_ra_title_desc <> '', l.corp_ra_title_desc, 'REGISTERED AGENT');
self.cont_fein := l.corp_ra_fein;
self.cont_ssn := l.corp_ra_ssn;
self.cont_dob := l.corp_ra_dob;
self.cont_effective_date := l.corp_ra_effective_date;
self.cont_address_type_cd := l.corp_ra_address_type_cd;
self.cont_address_type_desc := l.corp_ra_address_type_desc;
self.cont_address_line1 := l.corp_ra_address_line1;
self.cont_address_line2 := l.corp_ra_address_line2;
self.cont_address_line3 := l.corp_ra_address_line3;
self.cont_address_line4 := l.corp_ra_address_line4;
self.cont_address_line5 := l.corp_ra_address_line5;
self.cont_address_line6 := l.corp_ra_address_line6;
self.cont_address_effective_date := l.corp_ra_effective_date;
self.cont_phone_number := l.corp_ra_phone_number;
self.cont_phone_number_type_cd := l.corp_ra_phone_number_type_cd;
self.cont_phone_number_type_desc := l.corp_ra_phone_number_type_desc;
self.cont_email_address := l.corp_ra_email_address;
self.cont_web_address := l.corp_ra_web_address;
self.cont_prim_range := if(l.corp_ra_prim_name = '' and l.corp_ra_p_city_name = '', l.corp_addr1_prim_range, l.corp_ra_prim_range);
self.cont_predir := if(l.corp_ra_prim_name = '' and l.corp_ra_p_city_name = '', l.corp_addr1_predir, l.corp_ra_predir);
self.cont_prim_name := if(l.corp_ra_prim_name = '' and l.corp_ra_p_city_name = '', l.corp_addr1_prim_name, l.corp_ra_prim_name);
self.cont_addr_suffix := if(l.corp_ra_prim_name = '' and l.corp_ra_p_city_name = '', l.corp_addr1_addr_suffix, l.corp_ra_addr_suffix);
self.cont_postdir := if(l.corp_ra_prim_name = '' and l.corp_ra_p_city_name = '', l.corp_addr1_postdir, l.corp_ra_postdir);
self.cont_unit_desig := if(l.corp_ra_prim_name = '' and l.corp_ra_p_city_name = '', l.corp_addr1_unit_desig, l.corp_ra_unit_desig);
self.cont_sec_range := if(l.corp_ra_prim_name = '' and l.corp_ra_p_city_name = '', l.corp_addr1_sec_range, l.corp_ra_sec_range);
self.cont_p_city_name := if(l.corp_ra_prim_name = '' and l.corp_ra_p_city_name = '', l.corp_addr1_p_city_name, l.corp_ra_p_city_name);
self.cont_v_city_name := if(l.corp_ra_prim_name = '' and l.corp_ra_p_city_name = '', l.corp_addr1_v_city_name, l.corp_ra_v_city_name);
self.cont_state := if(l.corp_ra_prim_name = '' and l.corp_ra_p_city_name = '', l.corp_addr1_state, l.corp_ra_state);
self.cont_zip5 := if(l.corp_ra_prim_name = '' and l.corp_ra_p_city_name = '', l.corp_addr1_zip5, l.corp_ra_zip5);
self.cont_zip4 := if(l.corp_ra_prim_name = '' and l.corp_ra_p_city_name = '', l.corp_addr1_zip4, l.corp_ra_zip4);
self.cont_cart := if(l.corp_ra_prim_name = '' and l.corp_ra_p_city_name = '', l.corp_addr1_cart, l.corp_ra_cart);
self.cont_cr_sort_sz := if(l.corp_ra_prim_name = '' and l.corp_ra_p_city_name = '', l.corp_addr1_cr_sort_sz, l.corp_ra_cr_sort_sz);
self.cont_lot := if(l.corp_ra_prim_name = '' and l.corp_ra_p_city_name = '', l.corp_addr1_lot, l.corp_ra_lot);
self.cont_lot_order := if(l.corp_ra_prim_name = '' and l.corp_ra_p_city_name = '', l.corp_addr1_lot_order, l.corp_ra_lot_order);
self.cont_dpbc := if(l.corp_ra_prim_name = '' and l.corp_ra_p_city_name = '', l.corp_addr1_dpbc, l.corp_ra_dpbc);
self.cont_chk_digit := if(l.corp_ra_prim_name = '' and l.corp_ra_p_city_name = '', l.corp_addr1_chk_digit, l.corp_ra_chk_digit);
self.cont_rec_type := if(l.corp_ra_prim_name = '' and l.corp_ra_p_city_name = '', l.corp_addr1_rec_type, l.corp_ra_rec_type);
self.cont_ace_fips_st := if(l.corp_ra_prim_name = '' and l.corp_ra_p_city_name = '', l.corp_addr1_ace_fips_st, l.corp_ra_ace_fips_st);
self.cont_county := if(l.corp_ra_prim_name = '' and l.corp_ra_p_city_name = '', l.corp_addr1_county, l.corp_ra_county);
self.cont_geo_lat := if(l.corp_ra_prim_name = '' and l.corp_ra_p_city_name = '', l.corp_addr1_geo_lat, l.corp_ra_geo_lat);
self.cont_geo_long := if(l.corp_ra_prim_name = '' and l.corp_ra_p_city_name = '', l.corp_addr1_geo_long, l.corp_ra_geo_long);
self.cont_msa := if(l.corp_ra_prim_name = '' and l.corp_ra_p_city_name = '', l.corp_addr1_msa, l.corp_ra_msa);
self.cont_geo_blk := if(l.corp_ra_prim_name = '' and l.corp_ra_p_city_name = '', l.corp_addr1_geo_blk, l.corp_ra_geo_blk);
self.cont_geo_match := if(l.corp_ra_prim_name = '' and l.corp_ra_p_city_name = '', l.corp_addr1_geo_match, l.corp_ra_geo_match);
self.cont_err_stat := if(l.corp_ra_prim_name = '' and l.corp_ra_p_city_name = '', l.corp_addr1_err_stat, l.corp_ra_err_stat);
self.cont_phone10 := l.corp_ra_phone10;
self.cont_cname := '';
self.cont_cname_score := '';
self := l;
end;

corp_cont_norm_ra := normalize(corp_base_old, 2, NormRegAgents(left, counter));

corp_cont_norm_ra_dedup := dedup(corp_cont_norm_ra(cont_name <> '', cont_lname <> ''), all);
corp_cont_norm_ra_dist := distribute(corp_cont_norm_ra_dedup, hash(corp_key));

						   
// Propagate Information Forward to Blank Fields
cont_update_combined_sort := sort(cont_base_convert_dist + corp_cont_norm_ra_dist, corp_key, local);
cont_update_combined_grpd := group(cont_update_combined_sort, corp_key, local);
cont_update_combined_grpd_sort := sort(cont_update_combined_grpd, corp_process_date, cont_filing_date, cont_effective_date);

cont_update_combined_propagate := group(iterate(cont_update_combined_grpd_sort, Corp.TRA_Cont_Propagate_Fields(left, right)));

// Rollup dates for identical records
Corp.Layout_Corp_Cont_Temp RollupUpdate(Corp.Layout_Corp_Cont_Temp l, Corp.Layout_Corp_Cont_Temp r) := transform
SELF.dt_first_seen := 
            ut.EarliestDate(ut.EarliestDate(l.dt_first_seen,r.dt_first_seen),
		    ut.EarliestDate(l.dt_last_seen,r.dt_last_seen));
SELF.dt_last_seen := ut.LatestDate(l.dt_last_seen,r.dt_last_seen);
SELF.dt_vendor_last_reported := ut.LatestDate(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
SELF.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
SELF.corp_process_date := if(l.corp_process_date > r.corp_process_date, l.corp_process_date, r.corp_process_date);
self := l;
end;

cont_update_combined_propagate_sort := sort(cont_update_combined_propagate, except bdid, dt_first_seen, dt_last_seen,
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
local);

cont_update_combined_propagate_group := group(cont_update_combined_propagate_sort, except bdid, dt_first_seen, dt_last_seen,
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
local);

cont_update_combined_propagate_group_sort := sort(cont_update_combined_propagate_group, -corp_process_date);

cont_update_combined_propagate_rollup := group(rollup(cont_update_combined_propagate_group_sort, true, RollupUpdate(left, right)));

// Set Current - Historical Indicator
cont_update_combined_propagate_rollup_sort := sort(cont_update_combined_propagate_rollup, corp_key, local);
cont_update_combined_propagate_rollup_grpd := group(cont_update_combined_propagate_rollup_sort, corp_key, local);
cont_update_combined_propagate_rollup_grpd_sort := sort(cont_update_combined_propagate_rollup_grpd, -dt_vendor_last_reported, -dt_last_seen);

Corp.Layout_Corp_Cont_Temp SetRecordType(Corp.Layout_Corp_Cont_Temp L, Corp.Layout_Corp_Cont_Temp R) := transform
self.record_type := if(l.record_type = '', 'C', r.record_type);
self := r;
end;

cont_update := group(iterate(cont_update_combined_propagate_rollup_grpd_sort, SetRecordType(left, right)));

// Join with Corp Events to update date last seen
corp_event_base_old := dataset('~thor_data400::base::corp_event_basew20050601-152451', Corp.Layout_Corp_Event_Base, flat);

layout_event_slim := record
string30  corp_key;
unsigned4 dt_vendor_last_reported;
unsigned4 dt_last_seen;
string8   event_filing_date;
end;

layout_event_slim SlimEvents(Corp.Layout_Corp_Event_Base l) := transform
self := l;
end;

events_slim := project(corp_event_base_old(record_type = 'C'), SlimEvents(left));
events_slim_dist := distribute(events_slim, hash(corp_key));
events_slim_sort := sort(events_slim_dist, corp_key, -dt_vendor_last_reported, -dt_last_seen, local);
events_slim_dedup := dedup(events_slim_sort, corp_key, local);

Corp.Layout_Corp_Cont_Temp UpdateDates(Corp.Layout_Corp_Cont_Temp l, layout_event_slim r) := transform
self.dt_vendor_last_reported := ut.LatestDate(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
self.dt_last_seen := if(Corp.Checkdate(r.event_filing_date) <> '', ut.LatestDate(l.dt_last_seen, r.dt_last_seen), l.dt_last_seen);
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
                        FALSE, 'C',
                        TRUE, corp_key,
                        corp_legal_name,
                        corp_addr1_prim_range, corp_addr1_prim_name, corp_addr1_sec_range, corp_addr1_zip5,
                        TRUE, corp_phone10,
                        FALSE, corp_fed_tax_id,
						TRUE, corp_key);

// Then do a standard BDID match for the records which did not BDID,
// since the Corporate file may be newer than the Business Headers
BDID_Matchset := ['A'];

cont_bdid_match := cont_bdid_init(bdid <> 0);

cont_bdid_nomatch := cont_bdid_init(bdid = 0);

Business_Header_SS.MAC_Add_BDID_Flex(cont_bdid_nomatch,
                                  BDID_Matchset,
                                  corp_legal_name,
                                  corp_addr1_prim_range, corp_addr1_prim_name, corp_addr1_zip5,
                                  corp_addr1_sec_range, corp_addr1_state,
                                  corp_phone10, corp_fed_tax_id,
                                  bdid, Corp.Layout_Corp_Cont_Temp,
                                  FALSE, BDID_score_field,
                                  cont_bdid_rematch)

cont_bdid_all := cont_bdid_match + cont_bdid_rematch : persist('TEMP::Corp_Cont_BDID');

Layout_Corp_Cont_Temp_DID := record
unsigned6 uid := 0;
Corp.Layout_Corp_Cont_Temp;
unsigned6 adl := 0;
unsigned1 adl_score := 0;
end;

cont_did_init := project(cont_bdid_all, transform(Layout_Corp_Cont_Temp_DID, self := left));

ut.MAC_Sequence_Records(cont_did_init, uid, cont_did_seq)

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
layout_corp_cont_slim NormCorpCont(Layout_Corp_Cont_Temp_DID l, unsigned1 cnt) := transform
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

	 
Corp.Layout_Corp_Cont_Base AssignDIDs(Layout_Corp_Cont_Temp_DID l, layout_corp_cont_slim r) := transform
self.did := if(r.adl <> 0, r.adl, 0);
self := l;
end;

cont_did_append := join(cont_did_seq_dist,
                        cont_did_dedup,
						left.uid = right.uid,
						AssignDIDs(left, right),
						left outer,
						local);

output(cont_did_append,,'base::corp_cont_base_converted', overwrite);
