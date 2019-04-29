IMPORT Business_Header, ut, address, mdr, _Validate;

EXPORT fSKA_As_Business_Linking(

	 DATASET(Layout_SKA_Verified_bdid	) pSka_Verified_Base	= File_SKA_Verified_Base
	,DATASET(Layout_SKA_Nixie_bdid		) pSka_Nixie_base			= File_SKA_Nixie_Base		

) :=
FUNCTION

	// Layout_SKA_Verified_Local := RECORD
	  // UNSIGNED6 record_id := 0;
	  // Layout_SKA_Verified_Bdid;
	// END;

	Layout_BLF_Local := RECORD
	  Business_Header.Layout_Business_Linking.Linking_Interface;
	  // UNSIGNED6 orig_id;
	  // UNSIGNED6 split_id := 0;
	END;

	// Add unique RECORD id to SKA Verified file
	// Layout_SKA_Verified_Local AddRecordID(Layout_SKA_Verified_bdid l) := TRANSFORM
	  // SELF := l;
	// END;

	// SKA_Verified_Init := PROJECT(pSka_Verified_Base, AddRecordID(LEFT));

	// ut.MAC_Sequence_Records(SKA_Verified_Init, record_id, SKA_Verified_Seq)

	Layout_BLF_Local  Translate_SKA_Verified_to_BLF(Layout_SKA_Verified_bdid l, INTEGER CTR) := TRANSFORM
	  // SELF.orig_id := l.record_id;
	  SELF.source := MDR.sourceTools.src_SKA;
		SELF.source_record_id := l.source_rec_id;
	  SELF.dt_first_seen := (UNSIGNED4)Stringlib.GetDateYYYYMMDD();
	  SELF.dt_last_seen := (UNSIGNED4)Stringlib.GetDateYYYYMMDD();
	  SELF.dt_vendor_first_reported := (UNSIGNED4)Stringlib.GetDateYYYYMMDD();
	  SELF.dt_vendor_last_reported := (UNSIGNED4)Stringlib.GetDateYYYYMMDD();
	  SELF.company_bdid := (UNSIGNED6)l.bdid;
	  // SELF.company_name := Stringlib.StringToUpperCase(l.company_name);
	  SELF.company_name := Stringlib.StringToUpperCase(l.COMPANY1);
 	  SELF.company_address.prim_range := CHOOSE(CTR, l.mail_prim_range, l.alt_prim_range);
	  SELF.company_address.predir := CHOOSE(CTR, l.mail_predir, l.alt_predir);
	  SELF.company_address.prim_name := CHOOSE(CTR, l.mail_prim_name, l.alt_prim_name);
	  SELF.company_address.addr_suffix := CHOOSE(CTR, l.mail_addr_suffix, l.alt_addr_suffix);
	  SELF.company_address.postdir := CHOOSE(CTR, l.mail_postdir, l.alt_postdir);
	  SELF.company_address.unit_desig := CHOOSE(CTR, l.mail_unit_desig, l.alt_unit_desig);
	  SELF.company_address.sec_range := CHOOSE(CTR, l.mail_sec_range, l.alt_sec_range);
	  SELF.company_address.p_city_name := CHOOSE(CTR, l.mail_p_city_name, l.alt_p_city_name);
	  SELF.company_address.v_city_name := CHOOSE(CTR, l.mail_v_city_name, l.alt_v_city_name);
	  SELF.company_address.st := CHOOSE(CTR, l.mail_st, l.alt_st);
	  SELF.company_address.zip := CHOOSE(CTR, l.mail_zip, l.alt_zip);
	  SELF.company_address.zip4 := CHOOSE(CTR, l.mail_zip4, l.alt_zip4);
	  SELF.company_address.cart := CHOOSE(CTR, l.mail_cart, l.alt_cart);
	  SELF.company_address.cr_sort_sz := CHOOSE(CTR, l.mail_cr_sort_sz, l.alt_cr_sort_sz);
	  SELF.company_address.lot := CHOOSE(CTR, l.mail_lot, l.alt_lot);
	  SELF.company_address.lot_order := CHOOSE(CTR, l.mail_lot_order, l.alt_lot_order);
	  SELF.company_address.dbpc := CHOOSE(CTR, l.mail_dbpc, l.alt_dbpc);
	  SELF.company_address.chk_digit := CHOOSE(CTR, l.mail_chk_digit, l.alt_chk_digit);
	  SELF.company_address.rec_type := CHOOSE(CTR, l.mail_rec_type, l.alt_rec_type);
	  SELF.company_address.fips_state := CHOOSE(CTR, l.mail_ace_fips_state, l.alt_ace_fips_state);
	  SELF.company_address.fips_county := CHOOSE(CTR, l.mail_county, l.alt_county);
	  SELF.company_address.geo_lat := CHOOSE(CTR, l.mail_geo_lat, l.alt_geo_lat);
	  SELF.company_address.geo_long := CHOOSE(CTR, l.mail_geo_long, l.alt_geo_long);
	  SELF.company_address.msa := CHOOSE(CTR, l.mail_msa, l.alt_msa);
	  SELF.company_address.geo_blk := CHOOSE(CTR, l.mail_geo_blk, l.alt_geo_blk);
	  SELF.company_address.geo_match := CHOOSE(CTR, l.mail_geo_match, l.alt_geo_match);
	  SELF.company_address.err_stat := CHOOSE(CTR, l.mail_err_stat, l.alt_err_stat);
	  SELF.company_phone := address.CleanPhone(l.phone);
	  SELF.vl_id := 'SKAV' + l.id;
    SELF.current := TRUE;
	  SELF.phone_score := IF((INTEGER)l.phone = 0, 0, 1);
	  SELF.contact_name.title := l.title;
 	  SELF.contact_name.fname := l.fname;
 	  SELF.contact_name.mname := l.mname;
 	  SELF.contact_name.lname := l.lname;
 	  SELF.contact_name.name_suffix := l.name_suffix;
 	  SELF.contact_name.name_score := l.name_score;
	  SELF.contact_phone := address.CleanPhone(l.phone);
	  SELF.cid := (UNSIGNED8)l.persid;
    SELF.contact_score := IF(l.persid = '', 0, 1);
    SELF := l;
    SELF := [];
	END;

	from_ska_verified_norm := normalize(pSka_Verified_Base, 2, Translate_SKA_Verified_To_BLF(LEFT, COUNTER));
	from_ska_verified_norm_dist := DISTRIBUTE(from_ska_verified_norm, HASH(vl_id, company_name));
	from_ska_verified_norm_sort := SORT(from_ska_verified_norm_dist, vl_id, company_name,
                                      -company_address.zip, -company_address.st, 
                                      -company_address.p_city_name, contact_name.lname,
                                      contact_name.fname, contact_name.mname, 
                                      contact_name.name_suffix, LOCAL);

	Layout_BLF_Local RollupSKAVerifiedNorm(Layout_BLF_Local l, Layout_BLF_Local r) := TRANSFORM
	  SELF := l;
	END;

	from_ska_verified_norm_rollup := ROLLUP(from_ska_verified_norm_sort,
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
								                          RollupSKAVerifiedNorm(LEFT, RIGHT),
								                          LOCAL);
								  
	// Group by vl_id
	// from_ska_verified_dist := DISTRIBUTE(from_ska_verified_norm_rollup, HASH(vl_id));
	// from_ska_verified_sort := SORT(from_ska_verified_dist, vl_id, LOCAL);
	// from_ska_verified_grpd := GROUP(from_ska_verified_sort, vl_id, LOCAL);
	// from_ska_verified_grpd_sort := SORT(from_ska_verified_grpd, split_id);

	// Layout_BLF_Local SetGroupId(Layout_BLF_Local l, Layout_BLF_Local r) := TRANSFORM
	  // SELF.group1_id := IF(l.group1_id <> 0, l.group1_id, r.split_id);
	  // SELF := r;
	// END;

	// Set GROUP id
	// from_ska_verified_iter := GROUP(iterate(from_ska_verified_grpd_sort, SetGroupId(LEFT, RIGHT)));

	// Calculate stat to determine COUNT by group_id
	// Layout_Group_List := RECORD
	  // from_ska_verified_iter.group1_id;
	// END;

	// ska_verified_group_list := TABLE(from_ska_verified_iter, Layout_Group_List);

	// Layout_Group_Stat := RECORD
	  // ska_verified_group_list.group1_id;
	  // cnt := COUNT(GROUP);
	// END;

	// ska_verified_group_stat := TABLE(ska_verified_group_list, Layout_Group_Stat, group1_id);

	// Clean single GROUP ids AND format
	// Business_Header.Layout_Business_Header_New FormatToBLF(Layout_BLF_Local l, Layout_Group_Stat r) := TRANSFORM
	  // SELF.group1_id := r.group1_id;
	  // SELF := l;
	// END;

	// ska_verified_group_clean := JOIN(from_ska_verified_iter,
							                     // ska_verified_group_stat(cnt > 1),
							                     // LEFT.group1_id = RIGHT.group1_id,
							                     // FormatToBLF(LEFT, RIGHT),
							                     // LEFT OUTER,
							                     // LOOKUP);

	Layout_BLF_Local  Translate_SKA_Nixie_to_BLF(Layout_SKA_Nixie_bdid l) := TRANSFORM
	  SELF.source := MDR.sourceTools.src_SKA;
		SELF.source_record_id := l.source_rec_id;
	  SELF.dt_first_seen := (UNSIGNED4)Stringlib.GetDateYYYYMMDD();
	  SELF.dt_last_seen := (UNSIGNED4)Stringlib.GetDateYYYYMMDD();
	  SELF.dt_vendor_first_reported  := IF((INTEGER)l.NIXIE_DATE <> 0, (UNSIGNED4)l.NIXIE_DATE,
									                       (UNSIGNED4)Stringlib.GetDateYYYYMMDD());
	  SELF.dt_vendor_last_reported := IF((INTEGER)l.NIXIE_DATE <> 0, (UNSIGNED4)l.NIXIE_DATE,
									                     (UNSIGNED4)Stringlib.GetDateYYYYMMDD());
	  SELF.company_bdid := (UNSIGNED6)l.bdid;
	  // SELF.company_name := Stringlib.StringToUpperCase(l.company_name);
	  SELF.company_name := Stringlib.StringToUpperCase(l.COMPANY1);
 	  SELF.company_address.prim_range := l.mail_prim_range;
	  SELF.company_address.predir := l.mail_predir;
	  SELF.company_address.prim_name := l.mail_prim_name;
	  SELF.company_address.addr_suffix := l.mail_addr_suffix;
	  SELF.company_address.postdir := l.mail_postdir;
	  SELF.company_address.unit_desig := l.mail_unit_desig;
	  SELF.company_address.sec_range := l.mail_sec_range;
	  SELF.company_address.p_city_name := l.mail_p_city_name;
	  SELF.company_address.v_city_name := l.mail_v_city_name;
	  SELF.company_address.st := l.mail_st;
	  SELF.company_address.zip := l.mail_zip;
	  SELF.company_address.zip4 := l.mail_zip4;
	  SELF.company_address.cart := l.mail_cart;
	  SELF.company_address.cr_sort_sz := l.mail_cr_sort_sz;
	  SELF.company_address.lot := l.mail_lot;
	  SELF.company_address.lot_order := l.mail_lot_order;
	  SELF.company_address.dbpc := l.mail_dbpc;
	  SELF.company_address.chk_digit := l.mail_chk_digit;
	  SELF.company_address.rec_type := l.mail_rec_type;
	  SELF.company_address.fips_state := l.mail_ace_fips_state;
	  SELF.company_address.fips_county := l.mail_county;
	  SELF.company_address.geo_lat := l.mail_geo_lat;
	  SELF.company_address.geo_long := l.mail_geo_long;
	  SELF.company_address.msa := l.mail_msa;
	  SELF.company_address.geo_blk := l.mail_geo_blk;
	  SELF.company_address.geo_match := l.mail_geo_match;
	  SELF.company_address.err_stat := l.mail_err_stat;
	  // SELF.company_phone := address.CleanPhone(IF(l.area_code <> '', l.area_code, '000') + l.phone);
	  SELF.company_phone := address.CleanPhone(IF(l.area_code <> '', l.area_code, '000') + l.NUMBER);
	  SELF.vl_id := 'SKAN' + l.id;
    SELF.current := TRUE;
	  // SELF.phone_score := IF((INTEGER)l.phone = 0, 0, 1);
	  SELF.phone_score := IF((INTEGER)l.NUMBER = 0, 0, 1);
	  SELF.contact_name.title := l.title;
 	  SELF.contact_name.fname := l.fname;
 	  SELF.contact_name.mname := l.mname;
 	  SELF.contact_name.lname := l.lname;
 	  SELF.contact_name.name_suffix := l.name_suffix;
 	  SELF.contact_name.name_score := l.name_score;
	  // SELF.contact_phone := address.CleanPhone(IF(l.area_code <> '', l.area_code, '000') + l.phone);
	  SELF.contact_phone := address.CleanPhone(IF(l.area_code <> '', l.area_code, '000') + l.NUMBER);
	  SELF.cid := (UNSIGNED8)l.persid;
    SELF.contact_score := IF(l.persid = '', 0, 1);
    SELF.company_department := l.dept_code;
    SELF := l;
    SELF := [];
	END;

	// Business Registration Owner Information
	ska_nixie_init := PROJECT(pSka_Nixie_base, Translate_SKA_Nixie_to_BLF(LEFT));

	// Rollup
	Layout_BLF_Local RollupBR(Layout_BLF_Local l, Layout_BLF_Local r) := TRANSFORM
	  SELF.dt_first_seen := ut.EarliestDate(ut.EarliestDate(l.dt_first_seen,r.dt_first_seen),
				                                  ut.EarliestDate(l.dt_last_seen,r.dt_last_seen));
	  // SELF.dt_last_seen := ut.LatestDate(l.dt_last_seen,r.dt_last_seen);
	  SELF.dt_last_seen := MAX(l.dt_last_seen,r.dt_last_seen);
	  // SELF.dt_vendor_last_reported := ut.LatestDate(l.dt_vendor_last_reported, 
	  SELF.dt_vendor_last_reported := MAX(l.dt_vendor_last_reported, 
                                        r.dt_vendor_last_reported);
	  SELF.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported,
                                                     r.dt_vendor_first_reported);
	  SELF.company_name := IF(l.company_name = '', r.company_name, l.company_name);
	  SELF.vl_id := IF(l.vl_id = '', r.vl_id, l.vl_id);
	  SELF.company_phone := IF(l.company_phone = '', r.company_phone, l.company_phone);
	  SELF.phone_score := IF(l.company_phone = '', r.phone_score, l.phone_score);
	  SELF.company_address.prim_range := IF(l.company_address.prim_range = '' AND l.company_address.zip4 = '', 
                                          r.company_address.prim_range, l.company_address.prim_range);
	  SELF.company_address.predir := IF(l.company_address.predir = '' AND l.company_address.zip4 = '',
                                      r.company_address.predir, l.company_address.predir);
	  SELF.company_address.prim_name := IF(l.company_address.prim_name = '' AND l.company_address.zip4 = '',
                                         r.company_address.prim_name, l.company_address.prim_name);
	  SELF.company_address.addr_suffix := IF(l.company_address.addr_suffix = '' AND l.company_address.zip4 = '',
                                           r.company_address.addr_suffix, l.company_address.addr_suffix);
	  SELF.company_address.postdir := IF(l.company_address.postdir = '' AND l.company_address.zip4 = '',
                                       r.company_address.postdir, l.company_address.postdir);
	  SELF.company_address.unit_desig := IF(l.company_address.unit_desig = ''AND l.company_address.zip4 = '',
                                          r.company_address.unit_desig, l.company_address.unit_desig);
	  SELF.company_address.sec_range := IF(l.company_address.sec_range = '' AND l.company_address.zip4 = '',
                                         r.company_address.sec_range, l.company_address.sec_range);
	  SELF.company_address.p_city_name := IF(l.company_address.p_city_name = '' AND l.company_address.zip4 = '',
                                           r.company_address.p_city_name, l.company_address.p_city_name);
	  SELF.company_address.v_city_name := IF(l.company_address.v_city_name = '' AND l.company_address.zip4 = '',
                                           r.company_address.v_city_name, l.company_address.v_city_name);
	  SELF.company_address.st := IF(l.company_address.st = '' AND l.company_address.zip4 = '',
                                  r.company_address.st, l.company_address.st);
	  SELF.company_address.zip := IF(l.company_address.zip = '' AND l.company_address.zip4 = '',
                                   r.company_address.zip, l.company_address.zip);
	  SELF.company_address.zip4 := IF(l.company_address.zip4 = '', r.company_address.zip4, l.company_address.zip4);
	  SELF.company_address.cart := IF(l.company_address.cart = '' AND l.company_address.zip4 = '',
                                    r.company_address.cart, l.company_address.cart);
	  SELF.company_address.cr_sort_sz := IF(l.company_address.cr_sort_sz = '' AND l.company_address.zip4 = '',
                                          r.company_address.cr_sort_sz, l.company_address.cr_sort_sz);
	  SELF.company_address.lot := IF(l.company_address.lot = '' AND l.company_address.zip4 = '',
                                   r.company_address.lot, l.company_address.lot);
	  SELF.company_address.lot_order := IF(l.company_address.lot_order = '' AND l.company_address.zip4 = '',
                                         r.company_address.lot_order, l.company_address.lot_order);
	  SELF.company_address.dbpc := IF(l.company_address.dbpc = '' AND l.company_address.zip4 = '',
                                    r.company_address.dbpc, l.company_address.dbpc);
	  SELF.company_address.chk_digit := IF(l.company_address.chk_digit = '' AND l.company_address.zip4 = '',
                                         r.company_address.chk_digit, l.company_address.chk_digit);
	  SELF.company_address.rec_type := IF(l.company_address.rec_type = '' AND l.company_address.zip4 = '',
                                        r.company_address.rec_type, l.company_address.rec_type);
	  SELF.company_address.fips_state := IF(l.company_address.fips_state = '' AND l.company_address.zip4 = '',
                                          r.company_address.fips_state, l.company_address.fips_state);
	  SELF.company_address.fips_county := IF(l.company_address.fips_county = '' AND l.company_address.zip4 = '',
                                           r.company_address.fips_county, l.company_address.fips_county);
	  SELF.company_address.geo_lat := IF(l.company_address.geo_lat = '' AND l.company_address.zip4 = '',
                                       r.company_address.geo_lat, l.company_address.geo_lat);
	  SELF.company_address.geo_long := IF(l.company_address.geo_long = '' AND l.company_address.zip4 = '',
                                        r.company_address.geo_long, l.company_address.geo_long);
	  SELF.company_address.msa := IF(l.company_address.msa = '' AND l.company_address.zip4 = '',
                                   r.company_address.msa, l.company_address.msa);
	  SELF.company_address.geo_blk := IF(l.company_address.geo_blk = '' AND l.company_address.zip4 = '',
                                       r.company_address.geo_blk, l.company_address.geo_blk);
	  SELF.company_address.geo_match := IF(l.company_address.geo_match = '' AND l.company_address.zip4 = '',
                                        r.company_address.geo_match, l.company_address.geo_match);
	  SELF.company_address.err_stat := IF(l.company_address.err_stat = '' AND l.company_address.zip4 = '',
                                        r.company_address.err_stat, l.company_address.err_stat);
    SELF := L;
	END;

	// ska_clean_dist := DISTRIBUTE(ska_verified_group_clean + ska_nixie_init,
	ska_clean_dist := DISTRIBUTE(from_ska_verified_norm_rollup + ska_nixie_init,
						        HASH(company_address.zip, TRIM(company_address.prim_name), TRIM(company_address.prim_range),
                    TRIM(company_name)));
	ska_clean_sort := SORT(ska_clean_dist, company_address.zip, company_address.prim_range, 
                         company_address.prim_name, company_name,
						             IF(company_address.sec_range <> '', 0, 1), company_address.sec_range,
						             IF(company_phone <> '', 0, 1), company_phone,
						             dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen,
                         contact_name.lname, contact_name.fname, contact_name.mname,
                         contact_name.name_suffix, LOCAL);
	ska_clean_rollup := ROLLUP(ska_clean_sort,
						          LEFT.company_address.zip = RIGHT.company_address.zip AND
						          LEFT.company_address.prim_name = RIGHT.company_address.prim_name AND
						          LEFT.company_address.prim_range = RIGHT.company_address.prim_range AND
						          LEFT.company_name = RIGHT.company_name AND
						          (RIGHT.company_address.sec_range = '' OR
                       LEFT.company_address.sec_range = RIGHT.company_address.sec_range) AND
						          (RIGHT.company_phone = '' OR LEFT.company_phone = RIGHT.company_phone) AND
                      LEFT.contact_name.fname = RIGHT.contact_name.fname AND
                      LEFT.contact_name.mname = RIGHT.contact_name.mname AND
                      LEFT.contact_name.lname = RIGHT.contact_name.lname AND
                      LEFT.contact_name.name_suffix = RIGHT.contact_name.name_suffix and
											LEFT.source_record_id = RIGHT.source_record_id,
						          RollupBR(LEFT, RIGHT),
						          LOCAL);

	RETURN ska_clean_rollup;

END;