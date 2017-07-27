import Business_Header, Business_Header_SS;

// Format Corp Output
Corp.Layout_Corp_Out FormatCorpOut(Corp.Layout_Corp_Base l) := transform
self.bdid := if(l.bdid <> 0, intformat(l.bdid, 12, 1), '');
self.dt_first_seen := Corp.FormatDateOut(l.dt_first_seen);
self.dt_last_seen := Corp.FormatDateOut(l.dt_last_seen);
self.corp_sos_charter_nbr := MapOutputCharterNumber(l.corp_state_origin,l.corp_sos_charter_nbr);
self := l;
end;

corp_out_init := project(Corp.File_Corp_Base, FormatCorpOut(left));

// Propagate Status Information from current record for corp_key to all records
corp_out_init_dist := distribute(corp_out_init, hash(corp_key));
corp_out_init_sort := sort(corp_out_init_dist, corp_key, local);
corp_out_init_grpd := group(corp_out_init_sort, corp_key, local);
corp_out_init_grpd_sort := sort(corp_out_init_grpd, if(record_type = 'C', 0, 1), -dt_last_seen);

Corp.Layout_Corp_Out PropagateStatus(Corp.Layout_Corp_Out l, Corp.Layout_Corp_Out r) := transform
self.corp_status_cd := if(l.corp_status_cd = '' and l.corp_status_desc = '' and l.corp_status_date = '', r.corp_status_cd, l.corp_status_cd);
self.corp_status_desc := if(l.corp_status_cd = '' and l.corp_status_desc = '' and l.corp_status_date = '', r.corp_status_desc, l.corp_status_desc);
self.corp_status_date := if(l.corp_status_cd = '' and l.corp_status_desc = '' and l.corp_status_date = '', r.corp_status_date, l.corp_status_date);
self := r;
END;

corp_out_status := group(iterate(corp_out_init_grpd_sort, PropagateStatus(left, right)));

// Populate Blank Corporate Address from Registered Agent
Corp.Layout_Corp_Out Corp_MoveRAtoCorpAddress(Corp.Layout_Corp_Out l) := transform
self.corp_address1_type_cd := 'RA';
self.corp_address1_type_desc := 'REGISTERED AGENT ADDRESS';
self.corp_addr1_prim_range := l.corp_ra_prim_range;
self.corp_addr1_predir := l.corp_ra_predir;
self.corp_addr1_prim_name := l.corp_ra_prim_name;
self.corp_addr1_addr_suffix := l.corp_ra_addr_suffix;
self.corp_addr1_postdir := l.corp_ra_postdir;
self.corp_addr1_unit_desig := l.corp_ra_unit_desig;
self.corp_addr1_sec_range := l.corp_ra_sec_range;
self.corp_addr1_p_city_name := l.corp_ra_p_city_name;
self.corp_addr1_v_city_name := l.corp_ra_v_city_name;
self.corp_addr1_state := l.corp_ra_state;
self.corp_addr1_zip5 := l.corp_ra_zip5;
self.corp_addr1_zip4 := l.corp_ra_zip4;
self.corp_addr1_cart := l.corp_ra_cart;
self.corp_addr1_cr_sort_sz := l.corp_ra_cr_sort_sz;
self.corp_addr1_lot := l.corp_ra_lot;
self.corp_addr1_lot_order := l.corp_ra_lot_order;
self.corp_addr1_dpbc := l.corp_ra_dpbc;
self.corp_addr1_chk_digit := l.corp_ra_chk_digit;
self.corp_addr1_rec_type := l.corp_ra_rec_type;
self.corp_addr1_ace_fips_st := l.corp_ra_ace_fips_st;
self.corp_addr1_county := l.corp_ra_county;
self.corp_addr1_geo_lat := l.corp_ra_geo_lat;
self.corp_addr1_geo_long := l.corp_ra_geo_long;
self.corp_addr1_msa := l.corp_ra_msa;
self.corp_addr1_geo_blk := l.corp_ra_geo_blk;
self.corp_addr1_geo_match := l.corp_ra_geo_match;
self.corp_addr1_err_stat := l.corp_ra_err_stat;
self.address_ind := 'R';
self := l;
END;

corp_out_ra_addr := project(corp_out_status(corp_addr1_prim_name = '' AND corp_addr1_p_city_name = '' AND
                                          corp_ra_prim_name <> '' AND corp_ra_p_city_name <> '' AND
                                          corp_ra_name <> ''), Corp_MoveRAtoCorpAddress(left));

corp_out_all := corp_out_status(not(corp_addr1_prim_name = '' AND corp_addr1_p_city_name = '' AND
                                  corp_ra_prim_name <> '' AND corp_ra_p_city_name <> '' AND
								  corp_ra_name <> '')) +
                corp_out_ra_addr;
				
Business_Header_SS.MAC_Add_FEIN_By_BDID(corp_out_all, bdid, corp_fein, corp_out_add_fein)

// Check to use corp_fed_tax_id for corp_fein
Corp.Layout_Corp_Out CheckFEIN(Corp.Layout_Corp_Out l) := transform
self.corp_fein := if(l.corp_fein = '' and Business_Header.ValidFEIN((unsigned4)l.corp_fed_tax_id),
                     l.corp_fed_tax_id,
					 l.corp_fein);
self := l;
end;

corp_out_all_fein := project(corp_out_add_fein, CheckFEIN(left));
					 
export Corp_Out := corp_out_all_fein : persist('TEMP::Corp_Out');