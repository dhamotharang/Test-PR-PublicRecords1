IMPORT OneKey, Business_Header, ut, address, mdr, _Validate;

EXPORT fOneKey_As_Business_Linking(DATASET(OneKey.Layouts.base) pBaseFile = OneKey.Files().Base.qa) := FUNCTION

  Layout_BLF_Local := RECORD
    Business_Header.Layout_Business_Linking.Linking_Interface;
  END;

  Layout_BLF_Local  Translate_OneKey_To_BLF(OneKey.Layouts.base l) := TRANSFORM
    SELF.source                              := l.source;
    SELF.source_record_id                    := l.source_rec_id;
    SELF.dt_first_seen                       := (UNSIGNED4)Stringlib.GetDateYYYYMMDD();
    SELF.dt_last_seen                        := (UNSIGNED4)Stringlib.GetDateYYYYMMDD();
    SELF.dt_vendor_first_reported            := l.dt_vendor_first_reported;
    SELF.dt_vendor_last_reported             := l.dt_vendor_last_reported;
    SELF.company_bdid                        := (UNSIGNED6)l.bdid;
    SELF.company_name                        := Stringlib.StringToUpperCase(l.bus_nm);
    SELF.company_address.prim_range          := l.prim_range;
    SELF.company_address.predir              := l.predir;
    SELF.company_address.prim_name           := l.prim_name;
    SELF.company_address.addr_suffix         := l.addr_suffix;
    SELF.company_address.postdir             := l.postdir;
    SELF.company_address.unit_desig          := l.unit_desig;
    SELF.company_address.sec_range           := l.sec_range;
    SELF.company_address.p_city_name         := l.p_city_name;
    SELF.company_address.v_city_name         := l.v_city_name;
    SELF.company_address.st                  := l.st;
    SELF.company_address.zip                 := l.zip;
    SELF.company_address.zip4                := l.zip4;
    SELF.company_address.cart                := l.cart;
    SELF.company_address.cr_sort_sz          := l.cr_sort_sz;
    SELF.company_address.lot                 := l.lot;
    SELF.company_address.lot_order           := l.lot_order;
    SELF.company_address.dbpc                := l.dbpc;
    SELF.company_address.chk_digit           := l.chk_digit;
    SELF.company_address.rec_type            := l.rec_type;
    SELF.company_address.fips_state          := l.fips_state;
    SELF.company_address.fips_county         := l.fips_county;
    SELF.company_address.geo_lat             := l.geo_lat;
    SELF.company_address.geo_long            := l.geo_long;
    SELF.company_address.msa                 := l.msa;
    SELF.company_address.geo_blk             := l.geo_blk;
    SELF.company_address.geo_match           := l.geo_match;
    SELF.company_address.err_stat            := l.err_stat;
    SELF.company_phone                       := Address.CleanPhone(l.telephn_nbr);
    SELF.vl_id                               := 'ONEK' + TRIM(l.hcp_hce_id) + '_' + TRIM(l.hco_hce_id);  // Vendor linking Identifier
    SELF.current                             := TRUE;
    SELF.phone_score                         := IF((INTEGER)l.telephn_nbr = 0, 0, 1);
    SELF.contact_name.title                  := l.title;
    SELF.contact_name.fname                  := l.fname;
    SELF.contact_name.mname                  := l.mname;
    SELF.contact_name.lname                  := l.lname;
    SELF.contact_name.name_suffix            := l.name_suffix;
    SELF.contact_name.name_score             := l.name_score;
    SELF.contact_phone                       := Address.CleanPhone(l.telephn_nbr);
    SELF.cid                                 := (UNSIGNED8)l.hco_hce_id;
    SELF.contact_score                       := IF(l.hco_hce_id = '0', 0, 1);
    SELF                                     := l;
    SELF                                     := [];
  END;

  from_OneKey_norm       := PROJECT(pBaseFile, Translate_OneKey_To_BLF(LEFT));
  from_OneKey_norm_dist  := DISTRIBUTE(from_OneKey_norm, HASH(vl_id, company_name));
  from_OneKey_norm_sort  := SORT(from_OneKey_norm_dist, vl_id, company_name, -company_address.zip, -company_address.st, 
                                -company_address.p_city_name, contact_name.lname, contact_name.fname, contact_name.mname, 
                                 contact_name.name_suffix, LOCAL);

  Layout_BLF_Local RollupOneKeyNorm(Layout_BLF_Local l, Layout_BLF_Local r) := TRANSFORM
    SELF := l;
  END;

  from_OneKey_norm_rollup := ROLLUP(from_OneKey_norm_sort,
                                    LEFT.vl_id = RIGHT.vl_id AND
                                    LEFT.company_name = RIGHT.company_name AND
                                    LEFT.source_record_id = RIGHT.source_record_id AND
                                    ((LEFT.company_address.zip = RIGHT.company_address.zip AND
                                      LEFT.company_address.prim_name = RIGHT.company_address.prim_name AND
                                      LEFT.company_address.prim_range = RIGHT.company_address.prim_range AND
                                      LEFT.company_address.p_city_name = RIGHT.company_address.p_city_name AND
                                      LEFT.company_address.v_city_name = RIGHT.company_address.v_city_name AND
                                      LEFT.company_address.st = RIGHT.company_address.st)
                                     OR
                                     (RIGHT.company_address.zip = '' AND
                                      RIGHT.company_address.prim_name = '' AND
                                      RIGHT.company_address.prim_range = '' AND
                                      RIGHT.company_address.p_city_name = '' AND
                                      RIGHT.company_address.v_city_name = '' AND
                                      RIGHT.company_address.st = '')
                                    ) AND
                                    LEFT.contact_name.fname = RIGHT.contact_name.fname AND
                                    LEFT.contact_name.mname = RIGHT.contact_name.mname AND
                                    LEFT.contact_name.lname = RIGHT.contact_name.lname AND
                                    LEFT.contact_name.name_suffix = RIGHT.contact_name.name_suffix,
                                    RollupOneKeyNorm(LEFT, RIGHT),
                                    LOCAL);

	// Rollup
  Layout_BLF_Local RollupBR(Layout_BLF_Local l, Layout_BLF_Local r) := TRANSFORM
    SELF.dt_first_seen                := ut.EarliestDate(ut.EarliestDate(l.dt_first_seen,r.dt_first_seen),
                                                         ut.EarliestDate(l.dt_last_seen,r.dt_last_seen));
    SELF.dt_last_seen                 := MAX(l.dt_last_seen,r.dt_last_seen);
    SELF.dt_vendor_last_reported      := MAX(l.dt_vendor_last_reported, 
                                             r.dt_vendor_last_reported);
    SELF.dt_vendor_first_reported     := ut.EarliestDate(l.dt_vendor_first_reported,
                                                         r.dt_vendor_first_reported);
    SELF.company_name                 := IF(l.company_name = '', r.company_name, l.company_name);
    SELF.vl_id                        := IF(l.vl_id = '', r.vl_id, l.vl_id);
    SELF.company_phone                := IF(l.company_phone = '', r.company_phone, l.company_phone);
    SELF.phone_score                  := IF(l.company_phone = '', r.phone_score, l.phone_score);
    SELF.company_address.prim_range   := IF(l.company_address.prim_range = '' AND l.company_address.zip4 = '', 
                                            r.company_address.prim_range, l.company_address.prim_range);
    SELF.company_address.predir       := IF(l.company_address.predir = '' AND l.company_address.zip4 = '',
                                            r.company_address.predir, l.company_address.predir);
    SELF.company_address.prim_name    := IF(l.company_address.prim_name = '' AND l.company_address.zip4 = '',
                                            r.company_address.prim_name, l.company_address.prim_name);
    SELF.company_address.addr_suffix  := IF(l.company_address.addr_suffix = '' AND l.company_address.zip4 = '',
                                            r.company_address.addr_suffix, l.company_address.addr_suffix);
    SELF.company_address.postdir      := IF(l.company_address.postdir = '' AND l.company_address.zip4 = '',
                                            r.company_address.postdir, l.company_address.postdir);
    SELF.company_address.unit_desig   := IF(l.company_address.unit_desig = ''AND l.company_address.zip4 = '',
                                            r.company_address.unit_desig, l.company_address.unit_desig);
    SELF.company_address.sec_range    := IF(l.company_address.sec_range = '' AND l.company_address.zip4 = '',
                                            r.company_address.sec_range, l.company_address.sec_range);
    SELF.company_address.p_city_name  := IF(l.company_address.p_city_name = '' AND l.company_address.zip4 = '',
                                            r.company_address.p_city_name, l.company_address.p_city_name);
    SELF.company_address.v_city_name  := IF(l.company_address.v_city_name = '' AND l.company_address.zip4 = '',
                                            r.company_address.v_city_name, l.company_address.v_city_name);
    SELF.company_address.st           := IF(l.company_address.st = '' AND l.company_address.zip4 = '',
                                            r.company_address.st, l.company_address.st);
    SELF.company_address.zip          := IF(l.company_address.zip = '' AND l.company_address.zip4 = '',
                                            r.company_address.zip, l.company_address.zip);
    SELF.company_address.zip4         := IF(l.company_address.zip4 = '', r.company_address.zip4, l.company_address.zip4);
    SELF.company_address.cart         := IF(l.company_address.cart = '' AND l.company_address.zip4 = '',
                                            r.company_address.cart, l.company_address.cart);
    SELF.company_address.cr_sort_sz   := IF(l.company_address.cr_sort_sz = '' AND l.company_address.zip4 = '',
                                            r.company_address.cr_sort_sz, l.company_address.cr_sort_sz);
    SELF.company_address.lot          := IF(l.company_address.lot = '' AND l.company_address.zip4 = '',
                                            r.company_address.lot, l.company_address.lot);
    SELF.company_address.lot_order    := IF(l.company_address.lot_order = '' AND l.company_address.zip4 = '',
                                            r.company_address.lot_order, l.company_address.lot_order);
    SELF.company_address.dbpc         := IF(l.company_address.dbpc = '' AND l.company_address.zip4 = '',
                                            r.company_address.dbpc, l.company_address.dbpc);
    SELF.company_address.chk_digit    := IF(l.company_address.chk_digit = '' AND l.company_address.zip4 = '',
                                            r.company_address.chk_digit, l.company_address.chk_digit);
    SELF.company_address.rec_type     := IF(l.company_address.rec_type = '' AND l.company_address.zip4 = '',
                                            r.company_address.rec_type, l.company_address.rec_type);
    SELF.company_address.fips_state   := IF(l.company_address.fips_state = '' AND l.company_address.zip4 = '',
                                            r.company_address.fips_state, l.company_address.fips_state);
    SELF.company_address.fips_county  := IF(l.company_address.fips_county = '' AND l.company_address.zip4 = '',
                                            r.company_address.fips_county, l.company_address.fips_county);
    SELF.company_address.geo_lat      := IF(l.company_address.geo_lat = '' AND l.company_address.zip4 = '',
                                            r.company_address.geo_lat, l.company_address.geo_lat);
    SELF.company_address.geo_long     := IF(l.company_address.geo_long = '' AND l.company_address.zip4 = '',
                                            r.company_address.geo_long, l.company_address.geo_long);
    SELF.company_address.msa          := IF(l.company_address.msa = '' AND l.company_address.zip4 = '',
                                            r.company_address.msa, l.company_address.msa);
    SELF.company_address.geo_blk      := IF(l.company_address.geo_blk = '' AND l.company_address.zip4 = '',
                                            r.company_address.geo_blk, l.company_address.geo_blk);
    SELF.company_address.geo_match    := IF(l.company_address.geo_match = '' AND l.company_address.zip4 = '',
                                            r.company_address.geo_match, l.company_address.geo_match);
    SELF.company_address.err_stat     := IF(l.company_address.err_stat = '' AND l.company_address.zip4 = '',
                                            r.company_address.err_stat, l.company_address.err_stat);
    SELF                              := l;
  END;

  OneKey_clean_dist   := DISTRIBUTE(from_OneKey_norm_rollup, HASH(company_address.zip, TRIM(company_address.prim_name), TRIM(company_address.prim_range), TRIM(company_name)));
  OneKey_clean_sort   := SORT(OneKey_clean_dist, company_address.zip, company_address.prim_range, company_address.prim_name, company_name,
                              IF(company_address.sec_range <> '', 0, 1), company_address.sec_range, IF(company_phone <> '', 0, 1), company_phone,
                              dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, contact_name.lname, contact_name.fname,
                              contact_name.mname, contact_name.name_suffix, LOCAL);
  OneKey_clean_rollup := ROLLUP(OneKey_clean_sort,
                                LEFT.company_address.zip = RIGHT.company_address.zip AND
                                LEFT.company_address.prim_name = RIGHT.company_address.prim_name AND
                                LEFT.company_address.prim_range = RIGHT.company_address.prim_range AND
                                LEFT.company_name = RIGHT.company_name AND
                                (RIGHT.company_address.sec_range = '' OR LEFT.company_address.sec_range = RIGHT.company_address.sec_range) AND
                                (RIGHT.company_phone = '' OR LEFT.company_phone = RIGHT.company_phone) AND
                                LEFT.contact_name.fname = RIGHT.contact_name.fname AND
                                LEFT.contact_name.mname = RIGHT.contact_name.mname AND
                                LEFT.contact_name.lname = RIGHT.contact_name.lname AND
                                LEFT.contact_name.name_suffix = RIGHT.contact_name.name_suffix and
                                LEFT.source_record_id = RIGHT.source_record_id,
                                RollupBR(LEFT, RIGHT),
                                LOCAL);

	RETURN OneKey_clean_rollup;

END;