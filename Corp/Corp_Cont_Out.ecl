IMPORT corp;

// Referential integrity - Contacts must have corresponding corporate record
cout := Corp.Corp_Out;

layout_corpkeys := record
cout.corp_key;
end;

corpkeys_list := table(cout, layout_corpkeys);
corpkeys_list_dedup := dedup(corpkeys_list, all);
corpkeys_list_dist := distribute(corpkeys_list_dedup, hash(corp_key));

cont_base := Corp.File_Corp_Cont_Base(cont_name not in Corp.Set_Bad_Contact_Names);
cont_base_dist := distribute(cont_base, hash(corp_key));

Corp.Layout_Corp_Cont_Base SelectContacts(Corp.Layout_Corp_Cont_Base l, corpkeys_list_dedup r) := transform
self := l;
end;

cont_base_select := join(cont_base_dist,
                         corpkeys_list_dist,
						 left.corp_key = right.corp_key,
						 SelectContacts(left, right),
						 local);

Layout_Corp_Cont_Out FormatCorpContOut(Corp.Layout_Corp_Cont_Base l) := transform
self.bdid := if(l.bdid <> 0, intformat(l.bdid, 12, 1), '');
self.did := if(l.did <> 0, intformat(l.did, 12, 1), '');
self.dt_first_seen := Corp.FormatDateOut(l.dt_first_seen);
self.dt_last_seen := Corp.FormatDateOut(l.dt_last_seen);
self.corp_sos_charter_nbr := MapOutputCharterNumber(l.corp_state_origin,l.corp_sos_charter_nbr);
self := l;
end;

corp_cont_out_init := project(cont_base_select, FormatCorpContOut(left));

// Populate Blank Contact Address from Corporate Address
Layout_Corp_Cont_Out Cont_MoveCorptoContAddress(Layout_Corp_Cont_Out l) := transform
self.cont_prim_range := l.corp_addr1_prim_range;
self.cont_predir := l.corp_addr1_predir;
self.cont_prim_name := l.corp_addr1_prim_name;
self.cont_addr_suffix := l.corp_addr1_addr_suffix;
self.cont_postdir := l.corp_addr1_postdir;
self.cont_unit_desig := l.corp_addr1_unit_desig;
self.cont_sec_range := l.corp_addr1_sec_range;
self.cont_p_city_name := l.corp_addr1_p_city_name;
self.cont_v_city_name := l.corp_addr1_v_city_name;
self.cont_state := l.corp_addr1_state;
self.cont_zip5 := l.corp_addr1_zip5;
self.cont_zip4 := l.corp_addr1_zip4;
self.cont_cart := l.corp_addr1_cart;
self.cont_cr_sort_sz := l.corp_addr1_cr_sort_sz;
self.cont_lot := l.corp_addr1_lot;
self.cont_lot_order := l.corp_addr1_lot_order;
self.cont_dpbc := l.corp_addr1_dpbc;
self.cont_chk_digit := l.corp_addr1_chk_digit;
self.cont_rec_type := l.corp_addr1_rec_type;
self.cont_ace_fips_st := l.corp_addr1_ace_fips_st;
self.cont_county := l.corp_addr1_county;
self.cont_geo_lat := l.corp_addr1_geo_lat;
self.cont_geo_long := l.corp_addr1_geo_long;
self.cont_msa := l.corp_addr1_msa;
self.cont_geo_blk := l.corp_addr1_geo_blk;
self.cont_geo_match := l.corp_addr1_geo_match;
self.cont_err_stat := l.corp_addr1_err_stat;
self.address_ind := 'C';
self := l;
END;

corp_cont_out_corp_addr := project(corp_cont_out_init(cont_prim_name = '' AND cont_p_city_name = ''), Cont_MoveCorptoContAddress(left));

corp_cont_out_all := corp_cont_out_init(not(cont_prim_name = '' AND cont_p_city_name = '')) +
                corp_cont_out_corp_addr;

export Corp_Cont_Out := corp_cont_out_all : persist('TEMP::Corp_Cont_Out');
