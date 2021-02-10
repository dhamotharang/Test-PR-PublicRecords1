IMPORT ut;

export Corp_Cont_Combined_History_Function(DATASET(Layout_Corp_Cont_Temp) cont_base) :=
FUNCTION

cont_all := cont_base + Corp4_As_Corp_Cont_History_Function(cont_base);
cont_all_dist := distribute(cont_all, hash(corp_key));

// Reset Current Historical indicators
cont_all_sort := sort(cont_all_dist, corp_key, local);
cont_all_grpd := group(cont_all_sort, corp_key, local);
cont_all_grpd_sort := sort(cont_all_grpd, if(corp_vendor = 'EX', 1, 0), -dt_vendor_last_reported, -dt_last_seen);

Layout_Corp_Cont_Temp SetRecordType(Layout_Corp_Cont_Temp l, Layout_Corp_Cont_Temp r) := transform
self.record_type := if(l.record_type = '', 'C', 'H');
self := r;
end;

cont_all_final := group(iterate(cont_all_grpd_sort, SetRecordType(left, right)));

// Should only rollup groups where both EX and direct state records exist
// Perform a rollup on the sample

layout_corp_key := record
cont_all_final.corp_key;
end;

cont_all_final_direct := dedup(sort(table(cont_all_final(corp_vendor <> 'EX'), layout_corp_key),corp_key,local),corp_key,local);
cont_all_final_ex := dedup(sort(table(cont_all_final(corp_vendor = 'EX'), layout_corp_key),corp_key,local),corp_key,local);

layout_corp_key SelectCorpKeysForRollup(layout_corp_key l, layout_corp_key r) := transform
self := l;
end;

cont_all_final_list := join(cont_all_final_direct,
                            cont_all_final_ex,
						    left.corp_key = right.corp_key,
						    SelectCorpKeysForRollup(left, right),
						    local);

Corp.Layout_Corp_Cont_Temp SelectCorpKeys(Corp.Layout_Corp_Cont_Temp l, layout_corp_key r) := transform
self := l;
end;

cont_all_final_both := join(cont_all_final,
                            cont_all_final_list,
						    left.corp_key = right.corp_key,
						    SelectCorpKeys(left, right),
						    local);

cont_all_final_only := join(cont_all_final,
                            cont_all_final_list,
						    left.corp_key = right.corp_key,
						    SelectCorpKeys(left, right),
						    left only,
						    local);

// Sort and rollup on key fields, keep any non-Experian records
cont_all_final_sort := sort(cont_all_final_both,
corp_key,
corp_legal_name,
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
cont_fname,
cont_mname,
cont_lname,
cont_name_suffix,
cont_cname,
cont_prim_range,
cont_prim_name,
cont_predir,
cont_addr_suffix,
cont_unit_desig,
cont_sec_range,
cont_p_city_name,
cont_v_city_name,
cont_state,
cont_zip5,
cont_zip4,
corp_phone10,
cont_phone10,
if(corp_vendor = 'EX', 1, 0), local);

cont_all_final_grp := group(cont_all_final_sort,
corp_key,
corp_legal_name,
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
cont_fname,
cont_mname,
cont_lname,
cont_name_suffix,
cont_cname,
cont_prim_range,
cont_prim_name,
cont_predir,
cont_addr_suffix,
cont_unit_desig,
cont_sec_range,
cont_p_city_name,
cont_v_city_name,
cont_state,
cont_zip5,
cont_zip4,
corp_phone10,
cont_phone10,
local);

Corp.Layout_Corp_Cont_Temp RollupExperian(Corp.Layout_Corp_Cont_Temp l, Corp.Layout_Corp_Cont_Temp r) := transform
SELF.dt_first_seen :=
            ut.EarliestDate(ut.EarliestDate(l.dt_first_seen,r.dt_first_seen),
		    ut.EarliestDate(l.dt_last_seen,r.dt_last_seen));
SELF.dt_last_seen := ut.LatestDate(l.dt_last_seen,r.dt_last_seen);
SELF.dt_vendor_last_reported := ut.LatestDate(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
SELF.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
self := l;
end;

cont_all_final_rollup := group(rollup(cont_all_final_grp, left.corp_vendor <> 'EX' and right.corp_vendor = 'EX', RollupExperian(left, right)));

cont_all_combined := sort(cont_all_final_only + cont_all_final_rollup, corp_key, if(corp_vendor = 'EX', 1, 0), -dt_vendor_last_reported, -dt_last_seen, local);

RETURN cont_all_combined;

END;
