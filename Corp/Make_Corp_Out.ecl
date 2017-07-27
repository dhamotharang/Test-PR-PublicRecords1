#workunit('name', 'Corporate Output Files Creation ' + corp.Corp_Build_Date);
import ut;

// Format Corp Output	
corp_out_local := corp.Corp_Out;
corp_out_dist := distribute(corp_out_local, hash(corp_key));
corp_out_sort := sort(corp_out_dist, except corp_process_date, record_type, corp_address1_line1,
corp_address1_line2,
corp_address1_line3,
corp_address1_line4,
corp_address1_line5,
corp_address1_line6,
corp_address2_line1,
corp_address2_line2,
corp_address2_line3,
corp_address2_line4,
corp_address2_line5,
corp_address2_line6,
corp_ra_address_line1,
corp_ra_address_line2,
corp_ra_address_line3,
corp_ra_address_line4,
corp_ra_address_line5,
corp_ra_address_line6,
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
local);
corp_out_group := group(corp_out_sort, except corp_process_date, record_type,corp_address1_line1,
corp_address1_line2,
corp_address1_line3,
corp_address1_line4,
corp_address1_line5,
corp_address1_line6,
corp_address2_line1,
corp_address2_line2,
corp_address2_line3,
corp_address2_line4,
corp_address2_line5,
corp_address2_line6,
corp_ra_address_line1,
corp_ra_address_line2,
corp_ra_address_line3,
corp_ra_address_line4,
corp_ra_address_line5,
corp_ra_address_line6,
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
local);
corp_out_sort2 := sort(corp_out_group, record_type);
corp_out_dedup := dedup(corp_out_sort2, except corp_process_date, record_type, corp_address1_line1,
corp_address1_line2,
corp_address1_line3,
corp_address1_line4,
corp_address1_line5,
corp_address1_line6,
corp_address2_line1,
corp_address2_line2,
corp_address2_line3,
corp_address2_line4,
corp_address2_line5,
corp_address2_line6,
corp_ra_address_line1,
corp_ra_address_line2,
corp_ra_address_line3,
corp_ra_address_line4,
corp_ra_address_line5,
corp_ra_address_line6,
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
corp_ra_err_stat
);

						
output(corp_out_dedup,,'OUT::Corp_' + Corp.Corp_Build_Date, overwrite);
//ut.mac_sf_buildprocess(corp.corp_out,'~thor_data400::out::corp',do1,2);

// Format Corp Event Output
Corp.Layout_Corp_Event_Out FormatCorpEventOut(Corp.Layout_Corp_Event_Base l) := transform
self.bdid := if(l.bdid <> 0, intformat(l.bdid, 12, 1), '');
self.dt_first_seen := Corp.FormatDateOut(l.dt_first_seen);
self.dt_last_seen := Corp.FormatDateOut(l.dt_last_seen);
self := l;
end;

corp_event_out_init := project(Corp.File_Corp_Event_Base, FormatCorpEventOut(left));
corp_event_out_dist := distribute(corp_event_out_init, hash(corp_key));
corp_event_out_sort := sort(corp_event_out_dist, except bdid, local);
corp_event_out_dedup := dedup(corp_event_out_sort, except bdid, local);

output(corp_event_out_dedup,,'OUT::Corp_Event_' + Corp.Corp_Build_Date, overwrite);
//ut.MAC_SF_BuildProcess(corp_event_out_init,'~thor_data400::out::corp_event',do2,2);

// Format Corp Supplemental Output
Corp.Layout_Corp_Supp_Out FormatCorpSuppOut(Corp.Layout_Corp_Supp_Base l) := transform
self.bdid := if(l.bdid <> 0, intformat(l.bdid, 12, 1), '');
self.dt_first_seen := Corp.FormatDateOut(l.dt_first_seen);
self.dt_last_seen := Corp.FormatDateOut(l.dt_last_seen);
self := l;
end;

corp_supp_out_init := project(Corp.File_Corp_Supp_Base, FormatCorpSuppOut(left));
corp_supp_out_dist := distribute(corp_supp_out_init, hash(corp_key));
corp_supp_out_sort := sort(corp_supp_out_dist, except bdid, local);
corp_supp_out_dedup := dedup(corp_supp_out_sort, except bdid, local);

output(corp_supp_out_dedup,,'OUT::Corp_Supp_' + Corp.Corp_Build_Date, overwrite);
//ut.MAC_SF_BuildProcess(corp_supp_out_init,'~thor_data400::out::corp_supp',do3,2);

//sequential(do1,do2,do3);
