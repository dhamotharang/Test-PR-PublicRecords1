IMPORT ut;

export Corp_Combined_History_Function(DATASET(Layout_Corp_Temp) corp_base) :=
FUNCTION

corp_all := corp_base + Corp4_As_Corp_History_Function(corp_base);
corp_all_dist := distribute(corp_all, hash(corp_key));

// Reset Current Historical indicators
corp_all_sort := sort(corp_all_dist, corp_key, local);
corp_all_grpd := group(corp_all_sort, corp_key, local);
corp_all_grpd_sort := sort(corp_all_grpd, if(corp_vendor = 'EX', 1, 0), -dt_vendor_last_reported, -dt_last_seen);

Corp.Layout_Corp_Temp SetRecordType(Corp.Layout_Corp_Temp l, Corp.Layout_Corp_Temp r) := transform
self.record_type := if(l.record_type = '', 'C', 'H');
self := r;
end;

corp_all_final := group(iterate(corp_all_grpd_sort, SetRecordType(left, right)));

// Should only rollup groups where both EX and direct state records exist
// Perform a rollup on the sample

layout_corp_key := record
corp_all_final.corp_key;
end;

corp_all_final_direct := dedup(sort(table(corp_all_final(corp_vendor <> 'EX'), layout_corp_key),corp_key,local),corp_key,local);
corp_all_final_ex := dedup(sort(table(corp_all_final(corp_vendor = 'EX'), layout_corp_key),corp_key,local),corp_key,local);

layout_corp_key SelectCorpKeysForRollup(layout_corp_key l, layout_corp_key r) := transform
self := l;
end;

corp_all_final_list := join(corp_all_final_direct,
                              corp_all_final_ex,
						left.corp_key = right.corp_key,
						SelectCorpKeysForRollup(left, right),
						local);

Corp.Layout_Corp_Temp SelectCorpKeys(Corp.Layout_Corp_Temp l, layout_corp_key r) := transform
self := l;
end;

corp_all_final_both := join(corp_all_final,
                            corp_all_final_list,
						    left.corp_key = right.corp_key,
						    SelectCorpKeys(left, right),
						    local);

corp_all_final_only := join(corp_all_final,
                            corp_all_final_list,
						    left.corp_key = right.corp_key,
						    SelectCorpKeys(left, right),
						    left only,
						    local);

// Sort and rollup on key fields, keep any non-Experian records
corp_all_final_sort := sort(corp_all_final_both,
corp_key,
corp_legal_name,
corp_fed_tax_id,
corp_addr1_prim_range,
corp_addr1_prim_name,
corp_addr1_predir,
corp_addr1_addr_suffix,
corp_addr1_unit_desig,
corp_addr1_sec_range,
corp_addr1_p_city_name,
corp_addr1_v_city_name,
corp_addr1_state,
corp_addr1_zip5,
corp_addr1_zip4,
corp_ra_fname1,
corp_ra_mname1,
corp_ra_lname1,
corp_ra_name_suffix1,
corp_ra_prim_range,
corp_ra_prim_name,
corp_ra_predir,
corp_ra_addr_suffix,
corp_ra_unit_desig,
corp_ra_sec_range,
corp_ra_p_city_name,
corp_ra_v_city_name,
corp_ra_state,
corp_ra_zip5,
corp_ra_zip4,
corp_phone10,
corp_ra_phone10,
if(corp_vendor = 'EX', 1, 0), local);

corp_all_final_grp := group(corp_all_final_sort,
corp_key,
corp_legal_name,
corp_fed_tax_id,
corp_addr1_prim_range,
corp_addr1_prim_name,
corp_addr1_predir,
corp_addr1_addr_suffix,
corp_addr1_unit_desig,
corp_addr1_sec_range,
corp_addr1_p_city_name,
corp_addr1_v_city_name,
corp_addr1_state,
corp_addr1_zip5,
corp_addr1_zip4,
corp_ra_fname1,
corp_ra_mname1,
corp_ra_lname1,
corp_ra_name_suffix1,
corp_ra_prim_range,
corp_ra_prim_name,
corp_ra_predir,
corp_ra_addr_suffix,
corp_ra_unit_desig,
corp_ra_sec_range,
corp_ra_p_city_name,
corp_ra_v_city_name,
corp_ra_state,
corp_ra_zip5,
corp_ra_zip4,
corp_phone10,
corp_ra_phone10,
local);

Corp.Layout_Corp_Temp RollupExperian(Corp.Layout_Corp_Temp l, Corp.Layout_Corp_Temp r) := transform
SELF.dt_first_seen :=
            ut.EarliestDate(ut.EarliestDate(l.dt_first_seen,r.dt_first_seen),
		    ut.EarliestDate(l.dt_last_seen,r.dt_last_seen));
SELF.dt_last_seen := ut.LatestDate(l.dt_last_seen,r.dt_last_seen);
SELF.dt_vendor_last_reported := ut.LatestDate(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
SELF.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
self := l;
end;

corp_all_final_rollup := group(rollup(corp_all_final_grp, left.corp_vendor <> 'EX' and right.corp_vendor = 'EX', RollupExperian(left, right)));

corp_all_combined := sort(corp_all_final_only + corp_all_final_rollup, corp_key, if(corp_vendor = 'EX', 1, 0), -dt_vendor_last_reported, -dt_last_seen, local);

RETURN corp_all_combined;

END;
