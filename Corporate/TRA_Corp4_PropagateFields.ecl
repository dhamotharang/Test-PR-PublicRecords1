EXPORT Layout_Corp4_Temp TRA_Corp4_PropagateFields(Layout_Corp4_Temp L, Layout_Corp4_Temp R) := TRANSFORM
SELF.vendor_nbr := IF(R.vendor_nbr <> '', R.vendor_nbr, L.vendor_nbr);
SELF.abbrev_legal_name := IF(R.abbrev_legal_name <> '', R.abbrev_legal_name, L.abbrev_legal_name);
SELF.orig_address_ind := IF(R.orig_address_ind <> '', R.orig_address_ind, L.orig_address_ind);
SELF.street := IF(R.street <> '', R.street, L.street);
SELF.orig_city := IF(R.orig_city <> '', R.orig_city, L.orig_city);
SELF.orig_state := IF(R.orig_state <> '', R.orig_state, L.orig_state);
SELF.zip := IF(R.zip <> '', R.zip, L.zip);
SELF.prior_name := IF(R.prior_name <> '', R.prior_name, L.prior_name);
SELF.prior_street := IF(R.prior_street <> '', R.prior_street, L.prior_street);
SELF.orig_prior_city := IF(R.orig_prior_city <> '', R.orig_prior_city, L.orig_prior_city);
SELF.orig_prior_state := IF(R.orig_prior_state <> '', R.orig_prior_state, L.orig_prior_state);
SELF.prior_zip := IF(R.prior_zip <> '', R.prior_zip, L.prior_zip);
SELF.incorp_state := IF(R.incorp_state <> '', R.incorp_state, L.incorp_state);
SELF.orig_filing_state := IF(R.orig_filing_state <> '', R.orig_filing_state, L.orig_filing_state);
SELF.foreign_domestic_flag := IF(R.foreign_domestic_flag <> '', R.foreign_domestic_flag, L.foreign_domestic_flag);
SELF.incorp_flag := IF(R.incorp_flag <> '', R.incorp_flag, L.incorp_flag);
SELF.partner_proprietor_flag := IF(R.partner_proprietor_flag <> '', R.partner_proprietor_flag, L.partner_proprietor_flag);
// Corporate Officers
MAC_POF(officer1_name)
MAC_POF(officer1_title)
MAC_POF(officer1_street)
MAC_POF(officer1_city)
MAC_POF(officer1_state)
MAC_POF(officer1_zip)
MAC_POF(officer2_name)
MAC_POF(officer2_title)
MAC_POF(officer2_street)
MAC_POF(officer2_city)
MAC_POF(officer2_state)
MAC_POF(officer2_zip)
MAC_POF(officer3_name)
MAC_POF(officer3_title)
MAC_POF(officer3_street)
MAC_POF(officer3_city)
MAC_POF(officer3_state)
MAC_POF(officer3_zip)
MAC_POF(officer4_name)
MAC_POF(officer4_title)
MAC_POF(officer4_street)
MAC_POF(officer4_city)
MAC_POF(officer4_state)
MAC_POF(officer4_zip)
MAC_POF(officer5_name)
MAC_POF(officer5_title)
MAC_POF(officer5_street)
MAC_POF(officer5_city)
MAC_POF(officer5_state)
MAC_POF(officer5_zip)
// Corporate Registered Agent
SELF.orig_reg_agent_name := IF(R.orig_reg_agent_name <> '' OR R.orig_reg_agent_street <>'' OR
                               R.orig_reg_agent_city <> '' OR R.orig_reg_agent_state <> '' OR
                               R.orig_reg_agent_zip5 <> '', R.orig_reg_agent_name, L.orig_reg_agent_name);
SELF.orig_reg_agent_street := IF(R.orig_reg_agent_name <> '' OR R.orig_reg_agent_street <>'' OR
                               R.orig_reg_agent_city <> '' OR R.orig_reg_agent_state <> '' OR
                               R.orig_reg_agent_zip5 <> '', R.orig_reg_agent_street, L.orig_reg_agent_street);
SELF.orig_reg_agent_city := IF(R.orig_reg_agent_name <> '' OR R.orig_reg_agent_street <>'' OR
                               R.orig_reg_agent_city <> '' OR R.orig_reg_agent_state <> '' OR
                               R.orig_reg_agent_zip5 <> '', R.orig_reg_agent_city, L.orig_reg_agent_city);
SELF.orig_reg_agent_state := IF(R.orig_reg_agent_name <> '' OR R.orig_reg_agent_street <>'' OR
                               R.orig_reg_agent_city <> '' OR R.orig_reg_agent_state <> '' OR
                               R.orig_reg_agent_zip5 <> '', R.orig_reg_agent_state, L.orig_reg_agent_state);
SELF.orig_reg_agent_zip5 := IF(R.orig_reg_agent_name <> '' OR R.orig_reg_agent_street <>'' OR
                               R.orig_reg_agent_city <> '' OR R.orig_reg_agent_state <> '' OR
                               R.orig_reg_agent_zip5 <> '', R.orig_reg_agent_zip5, L.orig_reg_agent_zip5);
SELF.reg_agent_name := IF(R.reg_agent_name <> '' OR R.reg_agent_street <>'' OR
                               R.reg_agent_city <> '' OR R.reg_agent_state <> '' OR
                               R.reg_agent_zip5 <> '', R.reg_agent_name, L.reg_agent_name);
SELF.reg_agent_street := IF(R.reg_agent_name <> '' OR R.reg_agent_street <>'' OR
                               R.reg_agent_city <> '' OR R.reg_agent_state <> '' OR
                               R.reg_agent_zip5 <> '', R.reg_agent_street, L.reg_agent_street);
SELF.reg_agent_city := IF(R.reg_agent_name <> '' OR R.reg_agent_street <>'' OR
                               R.reg_agent_city <> '' OR R.reg_agent_state <> '' OR
                               R.reg_agent_zip5 <> '', R.reg_agent_city, L.reg_agent_city);
SELF.reg_agent_state := IF(R.reg_agent_name <> '' OR R.reg_agent_street <>'' OR
                               R.reg_agent_city <> '' OR R.reg_agent_state <> '' OR
                               R.reg_agent_zip5 <> '', R.reg_agent_state, L.reg_agent_state);
SELF.reg_agent_zip5 := IF(R.reg_agent_name <> '' OR R.reg_agent_street <>'' OR
                               R.reg_agent_city <> '' OR R.reg_agent_state <> '' OR
                               R.reg_agent_zip5 <> '', R.reg_agent_zip5, L.reg_agent_zip5);
// Corporate Information
SELF.fed_tax_id_9 := IF(R.fed_tax_id_9 <> '', R.fed_tax_id_9, L.fed_tax_id_9);
SELF.state_tax_id := IF(R.state_tax_id <> '', R.state_tax_id, L.state_tax_id);
SELF.sic_code := IF(R.sic_code <> '', R.sic_code, L.sic_code);
SELF.date_incorp := IF(R.date_incorp <> '', R.date_incorp, L.date_incorp);
SELF.date_orig_filing := IF(R.date_orig_filing <> '', R.date_orig_filing, L.date_orig_filing);
SELF.rcnt_filing := IF(R.rcnt_filing <> '', R.rcnt_filing, L.rcnt_filing);
SELF.term_of_existence_flag := IF(R.term_of_existence_flag <> '', R.term_of_existence_flag, L.term_of_existence_flag);
SELF.term_exist := IF(R.term_exist <> '', R.term_exist, L.term_exist);
SELF.profit_code := IF(R.profit_code <> '', R.profit_code, L.profit_code);
SELF.status := IF(R.status <> '', R.status, L.status);
SELF.status_descp := IF(R.status_descp <> '', R.status_descp, L.status_descp);
SELF.file_type := IF(R.file_type <> '', R.file_type, L.file_type);
// Corporate Cleaned Address
SELF.addr_suffix_flag := IF(R.street <> '' OR R.orig_city <> '' OR
                            R.orig_state <> '' OR R.zip <> '', R.addr_suffix_flag, L.addr_suffix_flag);
SELF.prim_range := IF(R.street <> '' OR R.orig_city <> '' OR
                      R.orig_state <> '' OR R.zip <> '', R.prim_range, L.prim_range);
SELF.predir := IF(R.street <> '' OR R.orig_city <> '' OR
                  R.orig_state <> '' OR R.zip <> '', R.predir, L.predir);
SELF.prim_name := IF(R.street <> '' OR R.orig_city <> '' OR
                     R.orig_state <> '' OR R.zip <> '', R.prim_name, L.prim_name);
SELF.addr_suffix := IF(R.street <> '' OR R.orig_city <> '' OR
                       R.orig_state <> '' OR R.zip <> '', R.addr_suffix, L.addr_suffix);
SELF.postdir := IF(R.street <> '' OR R.orig_city <> '' OR
                   R.orig_state <> '' OR R.zip <> '', R.postdir, L.postdir);
SELF.unit_desig := IF(R.street <> '' OR R.orig_city <> '' OR
                      R.orig_state <> '' OR R.zip <> '', R.unit_desig, L.unit_desig);
SELF.sec_range := IF(R.street <> '' OR R.orig_city <> '' OR
                     R.orig_state <> '' OR R.zip <> '', R.sec_range, L.sec_range);
SELF.p_city_name := IF(R.street <> '' OR R.orig_city <> '' OR
                       R.orig_state <> '' OR R.zip <> '', R.p_city_name, L.p_city_name);
SELF.v_city_name := IF(R.street <> '' OR R.orig_city <> '' OR
                       R.orig_state <> '' OR R.zip <> '', R.v_city_name, L.v_city_name);
SELF.state := IF(R.street <> '' OR R.orig_city <> '' OR
                 R.orig_state <> '' OR R.zip <> '', R.state, L.state);
SELF.zip5 := IF(R.street <> '' OR R.orig_city <> '' OR
                R.orig_state <> '' OR R.zip <> '', R.zip5, L.zip5);
SELF.zip4 := IF(R.street <> '' OR R.orig_city <> '' OR
                R.orig_state <> '' OR R.zip <> '', R.zip4, L.zip4);
SELF.cart := IF(R.street <> '' OR R.orig_city <> '' OR
                R.orig_state <> '' OR R.zip <> '', R.cart, L.cart);
SELF.cr_sort_sz := IF(R.street <> '' OR R.orig_city <> '' OR
                      R.orig_state <> '' OR R.zip <> '', R.cr_sort_sz, L.cr_sort_sz);
SELF.lot := IF(R.street <> '' OR R.orig_city <> '' OR
               R.orig_state <> '' OR R.zip <> '', R.lot, L.lot);
SELF.lot_order := IF(R.street <> '' OR R.orig_city <> '' OR
                     R.orig_state <> '' OR R.zip <> '', R.lot_order, L.lot_order);
SELF.dpbc := IF(R.street <> '' OR R.orig_city <> '' OR
                R.orig_state <> '' OR R.zip <> '', R.dpbc, L.dpbc);
SELF.chk_digit := IF(R.street <> '' OR R.orig_city <> '' OR
                     R.orig_state <> '' OR R.zip <> '', R.chk_digit, L.chk_digit);
SELF.rec_type := IF(R.street <> '' OR R.orig_city <> '' OR
                    R.orig_state <> '' OR R.zip <> '', R.rec_type, L.rec_type);
SELF.ace_fips_st := IF(R.street <> '' OR R.orig_city <> '' OR
                       R.orig_state <> '' OR R.zip <> '', R.ace_fips_st, L.ace_fips_st);
SELF.county := IF(R.street <> '' OR R.orig_city <> '' OR
                  R.orig_state <> '' OR R.zip <> '', R.county, L.county);
SELF.geo_lat := IF(R.street <> '' OR R.orig_city <> '' OR
                   R.orig_state <> '' OR R.zip <> '', R.geo_lat, L.geo_lat);
SELF.geo_long := IF(R.street <> '' OR R.orig_city <> '' OR
                    R.orig_state <> '' OR R.zip <> '', R.geo_long, L.geo_long);
SELF.msa := IF(R.street <> '' OR R.orig_city <> '' OR
               R.orig_state <> '' OR R.zip <> '', R.msa, L.msa);
SELF.geo_blk := IF(R.street <> '' OR R.orig_city <> '' OR
                   R.orig_state <> '' OR R.zip <> '', R.geo_blk, L.geo_blk);
SELF.geo_match := IF(R.street <> '' OR R.orig_city <> '' OR
                     R.orig_state <> '' OR R.zip <> '', R.geo_match, L.geo_match);
SELF.err_stat := IF(R.street <> '' OR R.orig_city <> '' OR
                    R.orig_state <> '' OR R.zip <> '', R.err_stat, L.err_stat);
// Corporate Prior Cleaned Address
SELF.prior_addr_suffix_flag := IF(R.prior_street <> '' OR R.orig_prior_city <> '' OR
                                  R.orig_prior_state <> '' OR R.prior_zip <> '', R.prior_addr_suffix_flag, L.prior_addr_suffix_flag);
SELF.prior_prim_range := IF(R.prior_street <> '' OR R.orig_prior_city <> '' OR
                            R.orig_prior_state <> '' OR R.prior_zip <> '', R.prior_prim_range, L.prior_prim_range);
SELF.prior_predir := IF(R.prior_street <> '' OR R.orig_prior_city <> '' OR
                        R.orig_prior_state <> '' OR R.prior_zip <> '', R.prior_predir, L.prior_predir);
SELF.prior_prim_name := IF(R.prior_street <> '' OR R.orig_prior_city <> '' OR
                           R.orig_prior_state <> '' OR R.prior_zip <> '', R.prior_prim_name, L.prior_prim_name);
SELF.prior_addr_suffix := IF(R.prior_street <> '' OR R.orig_prior_city <> '' OR
                             R.orig_prior_state <> '' OR R.prior_zip <> '', R.prior_addr_suffix, L.prior_addr_suffix);
SELF.prior_postdir := IF(R.prior_street <> '' OR R.orig_prior_city <> '' OR
                         R.orig_prior_state <> '' OR R.prior_zip <> '', R.prior_postdir, L.prior_postdir);
SELF.prior_unit_desig := IF(R.prior_street <> '' OR R.orig_prior_city <> '' OR
                            R.orig_prior_state <> '' OR R.prior_zip <> '', R.prior_unit_desig, L.prior_unit_desig);
SELF.prior_sec_range := IF(R.prior_street <> '' OR R.orig_prior_city <> '' OR
                           R.orig_prior_state <> '' OR R.prior_zip <> '', R.prior_sec_range, L.prior_sec_range);
SELF.prior_p_city_name := IF(R.prior_street <> '' OR R.orig_prior_city <> '' OR
                             R.orig_prior_state <> '' OR R.prior_zip <> '', R.prior_p_city_name, L.prior_p_city_name);
SELF.prior_v_city_name := IF(R.prior_street <> '' OR R.orig_prior_city <> '' OR
                             R.orig_prior_state <> '' OR R.prior_zip <> '', R.prior_v_city_name, L.prior_v_city_name);
SELF.prior_state := IF(R.prior_street <> '' OR R.orig_prior_city <> '' OR
                       R.orig_prior_state <> '' OR R.prior_zip <> '', R.prior_state, L.prior_state);
SELF.prior_zip5 := IF(R.prior_street <> '' OR R.orig_prior_city <> '' OR
                      R.orig_prior_state <> '' OR R.prior_zip <> '', R.prior_zip5, L.prior_zip5);
SELF.prior_zip4 := IF(R.prior_street <> '' OR R.orig_prior_city <> '' OR
                      R.orig_prior_state <> '' OR R.prior_zip <> '', R.prior_zip4, L.prior_zip4);
SELF.prior_cart := IF(R.prior_street <> '' OR R.orig_prior_city <> '' OR
                      R.orig_prior_state <> '' OR R.prior_zip <> '', R.prior_cart, L.prior_cart);
SELF.prior_cr_sort_sz := IF(R.prior_street <> '' OR R.orig_prior_city <> '' OR
                            R.orig_prior_state <> '' OR R.prior_zip <> '', R.prior_cr_sort_sz, L.prior_cr_sort_sz);
SELF.prior_lot := IF(R.prior_street <> '' OR R.orig_prior_city <> '' OR
                     R.orig_prior_state <> '' OR R.prior_zip <> '', R.prior_lot, L.prior_lot);
SELF.prior_lot_order := IF(R.prior_street <> '' OR R.orig_prior_city <> '' OR
                           R.orig_prior_state <> '' OR R.prior_zip <> '', R.prior_lot_order, L.prior_lot_order);
SELF.prior_dpbc := IF(R.prior_street <> '' OR R.orig_prior_city <> '' OR
                      R.orig_prior_state <> '' OR R.prior_zip <> '', R.prior_dpbc, L.prior_dpbc);
SELF.prior_chk_digit := IF(R.prior_street <> '' OR R.orig_prior_city <> '' OR
                           R.orig_prior_state <> '' OR R.prior_zip <> '', R.prior_chk_digit, L.prior_chk_digit);
SELF.prior_rec_type := IF(R.prior_street <> '' OR R.orig_prior_city <> '' OR
                          R.orig_prior_state <> '' OR R.prior_zip <> '', R.prior_rec_type, L.prior_rec_type);
SELF.prior_ace_fips_st := IF(R.prior_street <> '' OR R.orig_prior_city <> '' OR
                             R.orig_prior_state <> '' OR R.prior_zip <> '', R.prior_ace_fips_st, L.prior_ace_fips_st);
SELF.prior_county := IF(R.prior_street <> '' OR R.orig_prior_city <> '' OR
                        R.orig_prior_state <> '' OR R.prior_zip <> '', R.prior_county, L.prior_county);
SELF.prior_geo_lat := IF(R.prior_street <> '' OR R.orig_prior_city <> '' OR
                         R.orig_prior_state <> '' OR R.prior_zip <> '', R.prior_geo_lat, L.prior_geo_lat);
SELF.prior_geo_long := IF(R.prior_street <> '' OR R.orig_prior_city <> '' OR
                          R.orig_prior_state <> '' OR R.prior_zip <> '', R.prior_geo_long, L.prior_geo_long);
SELF.prior_msa := IF(R.prior_street <> '' OR R.orig_prior_city <> '' OR
                     R.orig_prior_state <> '' OR R.prior_zip <> '', R.prior_msa, L.prior_msa);
SELF.prior_geo_blk := IF(R.prior_street <> '' OR R.orig_prior_city <> '' OR
                         R.orig_prior_state <> '' OR R.prior_zip <> '', R.prior_geo_blk, L.prior_geo_blk);
SELF.prior_geo_match := IF(R.prior_street <> '' OR R.orig_prior_city <> '' OR
                           R.orig_prior_state <> '' OR R.prior_zip <> '', R.prior_geo_match, L.prior_geo_match);
SELF.prior_err_stat := IF(R.prior_street <> '' OR R.orig_prior_city <> '' OR
                          R.orig_prior_state <> '' OR R.prior_zip <> '', R.prior_err_stat, L.prior_err_stat);
// Registered Agent Cleaned Address
SELF.ra_addr_suffix_flag := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                               R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '', R.ra_addr_suffix_flag, L.ra_addr_suffix_flag);
SELF.ra_prim_range := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                         R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '', R.ra_prim_range, L.ra_prim_range);
SELF.ra_predir := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                     R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '', R.ra_predir, L.ra_predir);
SELF.ra_prim_name := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                        R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '', R.ra_prim_name, L.ra_prim_name);
SELF.ra_addr_suffix := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                          R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '', R.ra_addr_suffix, L.ra_addr_suffix);
SELF.ra_postdir := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                      R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '', R.ra_postdir, L.ra_postdir);
SELF.ra_unit_desig := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                         R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '', R.ra_unit_desig, L.ra_unit_desig);
SELF.ra_sec_range := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                        R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '', R.ra_sec_range, L.ra_sec_range);
SELF.ra_p_city_name := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                          R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '', R.ra_p_city_name, L.ra_p_city_name);
SELF.ra_v_city_name := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                          R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '', R.ra_v_city_name, L.ra_v_city_name);
SELF.ra_state := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                    R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '', R.ra_state, L.ra_state);
SELF.ra_zip5 := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                   R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '', R.ra_zip5, L.ra_zip5);
SELF.ra_zip4 := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                   R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '', R.ra_zip4 , L.ra_zip4 );
SELF.ra_cart := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                   R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '', R.ra_cart, L.ra_cart);
SELF.ra_cr_sort_sz := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                         R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '', R.ra_cr_sort_sz, L.ra_cr_sort_sz);
SELF.ra_lot := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                  R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '', R.ra_lot, L.ra_lot);
SELF.ra_lot_order := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                        R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '', R.ra_lot_order, L.ra_lot_order);
SELF.ra_dpbc := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                   R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '', R.ra_dpbc, L.ra_dpbc);
SELF.ra_chk_digit := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                        R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '', R.ra_chk_digit, L.ra_chk_digit);
SELF.ra_rec_type := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                       R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '', R.ra_rec_type, L.ra_rec_type);
SELF.ra_ace_fips_st := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                          R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '', R.ra_ace_fips_st, L.ra_ace_fips_st);
SELF.ra_county := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                     R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '', R.ra_county, L.ra_county);
SELF.ra_geo_lat := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                      R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '', R.ra_geo_lat, L.ra_geo_lat);
SELF.ra_geo_long := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                       R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '', R.ra_geo_long, L.ra_geo_long);
SELF.ra_msa := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                  R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '', R.ra_msa, L.ra_msa);
SELF.ra_geo_blk := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                      R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '', R.ra_geo_blk, L.ra_geo_blk);
SELF.ra_geo_match := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                        R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '', R.ra_geo_match, L.ra_geo_match);
SELF.ra_err_stat := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                       R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '', R.ra_err_stat, L.ra_err_stat);
// Corporate Officers Cleaned Name and Addresses
MAC_POF(o1_title)
MAC_POF(o1_fname)
MAC_POF(o1_mname)
MAC_POF(o1_lname)
MAC_POF(o1_name_suffix)
MAC_POF(o1_score)
MAC_POF(o1_addr_suffix_flag)
MAC_POF(o1_prim_range)
MAC_POF(o1_predir)
MAC_POF(o1_prim_name)
MAC_POF(o1_addr_suffix)
MAC_POF(o1_postdir)
MAC_POF(o1_unit_desig)
MAC_POF(o1_sec_range)
MAC_POF(o1_p_city_name)
MAC_POF(o1_v_city_name)
MAC_POF(o1_state)
MAC_POF(o1_zip5)
MAC_POF(o1_zip4)
MAC_POF(o1_cart)
MAC_POF(o1_cr_sort_sz)
MAC_POF(o1_lot)
MAC_POF(o1_lot_order)
MAC_POF(o1_dpbc)
MAC_POF(o1_chk_digit)
MAC_POF(o1_rec_type)
MAC_POF(o1_ace_fips_st)
MAC_POF(o1_county)
MAC_POF(o1_geo_lat)
MAC_POF(o1_geo_long)
MAC_POF(o1_msa)
MAC_POF(o1_geo_blk)
MAC_POF(o1_geo_match)
MAC_POF(o1_err_stat)
MAC_POF(o2_title)
MAC_POF(o2_fname)
MAC_POF(o2_mname)
MAC_POF(o2_lname)
MAC_POF(o2_name_suffix)
MAC_POF(o2_score)
MAC_POF(o2_addr_suffix_flag)
MAC_POF(o2_prim_range)
MAC_POF(o2_predir)
MAC_POF(o2_prim_name)
MAC_POF(o2_addr_suffix)
MAC_POF(o2_postdir)
MAC_POF(o2_unit_desig)
MAC_POF(o2_sec_range)
MAC_POF(o2_p_city_name)
MAC_POF(o2_v_city_name)
MAC_POF(o2_state)
MAC_POF(o2_zip5)
MAC_POF(o2_zip4)
MAC_POF(o2_cart)
MAC_POF(o2_cr_sort_sz)
MAC_POF(o2_lot)
MAC_POF(o2_lot_order)
MAC_POF(o2_dpbc)
MAC_POF(o2_chk_digit)
MAC_POF(o2_rec_type)
MAC_POF(o2_ace_fips_st)
MAC_POF(o2_county)
MAC_POF(o2_geo_lat)
MAC_POF(o2_geo_long)
MAC_POF(o2_msa)
MAC_POF(o2_geo_blk)
MAC_POF(o2_geo_match)
MAC_POF(o2_err_stat)
MAC_POF(o3_title)
MAC_POF(o3_fname)
MAC_POF(o3_mname)
MAC_POF(o3_lname)
MAC_POF(o3_name_suffix)
MAC_POF(o3_score)
MAC_POF(o3_addr_suffix_flag)
MAC_POF(o3_prim_range)
MAC_POF(o3_predir)
MAC_POF(o3_prim_name)
MAC_POF(o3_addr_suffix)
MAC_POF(o3_postdir)
MAC_POF(o3_unit_desig)
MAC_POF(o3_sec_range)
MAC_POF(o3_p_city_name)
MAC_POF(o3_v_city_name)
MAC_POF(o3_state)
MAC_POF(o3_zip5)
MAC_POF(o3_zip4)
MAC_POF(o3_cart)
MAC_POF(o3_cr_sort_sz)
MAC_POF(o3_lot)
MAC_POF(o3_lot_order)
MAC_POF(o3_dpbc)
MAC_POF(o3_chk_digit)
MAC_POF(o3_rec_type)
MAC_POF(o3_ace_fips_st)
MAC_POF(o3_county)
MAC_POF(o3_geo_lat)
MAC_POF(o3_geo_long)
MAC_POF(o3_msa)
MAC_POF(o3_geo_blk)
MAC_POF(o3_geo_match)
MAC_POF(o3_err_stat)
MAC_POF(o4_title)
MAC_POF(o4_fname)
MAC_POF(o4_mname)
MAC_POF(o4_lname)
MAC_POF(o4_name_suffix)
MAC_POF(o4_score)
MAC_POF(o4_addr_suffix_flag)
MAC_POF(o4_prim_range)
MAC_POF(o4_predir)
MAC_POF(o4_prim_name)
MAC_POF(o4_addr_suffix)
MAC_POF(o4_postdir)
MAC_POF(o4_unit_desig)
MAC_POF(o4_sec_range)
MAC_POF(o4_p_city_name)
MAC_POF(o4_v_city_name)
MAC_POF(o4_state)
MAC_POF(o4_zip5)
MAC_POF(o4_zip4)
MAC_POF(o4_cart)
MAC_POF(o4_cr_sort_sz)
MAC_POF(o4_lot)
MAC_POF(o4_lot_order)
MAC_POF(o4_dpbc)
MAC_POF(o4_chk_digit)
MAC_POF(o4_rec_type)
MAC_POF(o4_ace_fips_st)
MAC_POF(o4_county)
MAC_POF(o4_geo_lat)
MAC_POF(o4_geo_long)
MAC_POF(o4_msa)
MAC_POF(o4_geo_blk)
MAC_POF(o4_geo_match)
MAC_POF(o4_err_stat)
MAC_POF(o5_title)
MAC_POF(o5_fname)
MAC_POF(o5_mname)
MAC_POF(o5_lname)
MAC_POF(o5_name_suffix)
MAC_POF(o5_score)
MAC_POF(o5_addr_suffix_flag)
MAC_POF(o5_prim_range)
MAC_POF(o5_predir)
MAC_POF(o5_prim_name)
MAC_POF(o5_addr_suffix)
MAC_POF(o5_postdir)
MAC_POF(o5_unit_desig)
MAC_POF(o5_sec_range)
MAC_POF(o5_p_city_name)
MAC_POF(o5_v_city_name)
MAC_POF(o5_state)
MAC_POF(o5_zip5)
MAC_POF(o5_zip4)
MAC_POF(o5_cart)
MAC_POF(o5_cr_sort_sz)
MAC_POF(o5_lot)
MAC_POF(o5_lot_order)
MAC_POF(o5_dpbc)
MAC_POF(o5_chk_digit)
MAC_POF(o5_rec_type)
MAC_POF(o5_ace_fips_st)
MAC_POF(o5_county)
MAC_POF(o5_geo_lat)
MAC_POF(o5_geo_long)
MAC_POF(o5_msa)
MAC_POF(o5_geo_blk)
MAC_POF(o5_geo_match)
MAC_POF(o5_err_stat)
// Registered Agent Cleaned Name and Address
SELF.o6_title := IF(R.orig_reg_agent_name <> '', R.o6_title, L.o6_title);
SELF.o6_fname := IF(R.orig_reg_agent_name <> '', R.o6_fname, L.o6_fname);
SELF.o6_mname := IF(R.orig_reg_agent_name <> '', R.o6_mname, L.o6_mname);
SELF.o6_lname := IF(R.orig_reg_agent_name <> '', R.o6_lname, L.o6_lname);
SELF.o6_name_suffix := IF(R.orig_reg_agent_name <> '', R.o6_name_suffix, L.o6_name_suffix);
SELF.o6_score := IF(R.orig_reg_agent_name <> '', R.o6_score, L.o6_score);
SELF.o6_addr_suffix_flag := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                               R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '',
                               R.o6_addr_suffix_flag, L.o6_addr_suffix_flag);
SELF.o6_prim_range := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                               R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '',
                               R.o6_prim_range, L.o6_prim_range);
SELF.o6_predir := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                               R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '',
                               R.o6_predir, L.o6_predir);
SELF.o6_prim_name := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                               R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '',
                               R.o6_prim_name, L.o6_prim_name);
SELF.o6_addr_suffix := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                               R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '',
                               R.o6_addr_suffix, L.o6_addr_suffix);
SELF.o6_postdir := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                               R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '',
                               R.o6_postdir, L.o6_postdir);
SELF.o6_unit_desig := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                               R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '',
                               R.o6_unit_desig, L.o6_unit_desig);
SELF.o6_sec_range := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                               R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '',
                               R.o6_sec_range, L.o6_sec_range);
SELF.o6_p_city_name := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                               R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '',
                               R.o6_p_city_name, L.o6_p_city_name);
SELF.o6_v_city_name := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                               R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '',
                               R.o6_v_city_name, L.o6_v_city_name);
SELF.o6_state := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                               R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '',
                               R.o6_state, L.o6_state);
SELF.o6_zip5 := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                               R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '',
                               R.o6_zip5, L.o6_zip5);
SELF.o6_zip4 := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                               R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '',
                               R.o6_zip4, L.o6_zip4);
SELF.o6_cart := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                               R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '',
                               R.o6_cart, L.o6_cart);
SELF.o6_cr_sort_sz := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                               R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '',
                               R.o6_cr_sort_sz, L.o6_cr_sort_sz);
SELF.o6_lot := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                               R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '',
                               R.o6_lot, L.o6_lot);
SELF.o6_lot_order := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                               R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '',
                               R.o6_lot_order, L.o6_lot_order);
SELF.o6_dpbc := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                               R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '',
                               R.o6_dpbc, L.o6_dpbc);
SELF.o6_chk_digit := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                               R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '',
                               R.o6_chk_digit, L.o6_chk_digit);
SELF.o6_rec_type := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                               R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '',
                               R.o6_rec_type, L.o6_rec_type);
SELF.o6_ace_fips_st := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                               R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '',
                               R.o6_ace_fips_st, L.o6_ace_fips_st);
SELF.o6_county := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                               R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '',
                               R.o6_county, L.o6_county);
SELF.o6_geo_lat := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                               R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '',
                               R.o6_geo_lat, L.o6_geo_lat);
SELF.o6_geo_long := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                               R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '',
                               R.o6_geo_long, L.o6_geo_long);
SELF.o6_msa := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                               R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '',
                               R.o6_msa, L.o6_msa);
SELF.o6_geo_blk := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                               R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '',
                               R.o6_geo_blk, L.o6_geo_blk);
SELF.o6_geo_match := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                               R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '',
                               R.o6_geo_match, L.o6_geo_match);
SELF.o6_err_stat := IF(R.orig_reg_agent_street <> '' OR R.orig_reg_agent_city <> '' OR
                               R.orig_reg_agent_state <> '' OR R.orig_reg_agent_zip5 <> '',
                               R.o6_err_stat, L.o6_err_stat);
SELF := R;
END;