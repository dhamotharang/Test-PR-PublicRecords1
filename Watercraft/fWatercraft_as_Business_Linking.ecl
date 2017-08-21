IMPORT Business_Header, Business_Header_SS, ut, MDR, Address;

EXPORT fWatercraft_as_Business_Linking(
       DATASET(Layout_Watercraft_Search_Base) pWatercraft_Search	= File_Base_Search_Prod) := FUNCTION

	dWatercraftSearch	:=	pWatercraft_Search;

	rNewBusinessLayout := RECORD
		Business_Header.Layout_Business_Linking.Linking_Interface;
	END;
   
	rNewBusinessLayout tWatercraftAsBusinessLinking(Layout_Watercraft_Search_Base pInput, INTEGER CTR) := TRANSFORM,
    SKIP(CTR = 2 AND ut.CleanPhone(pInput.phone_2) = '')
    
		// General Data
 		SELF.source 					           :=	MDR.sourceTools.fWatercraft(pInput.source_code, pInput.state_origin);
		SELF.dt_first_seen 				       :=	IF((UNSIGNED)pInput.date_first_seen < 300000,
                                           (UNSIGNED)pInput.date_first_seen * 100,
                                           (UNSIGNED)pInput.date_first_seen);
		SELF.dt_last_seen 				       :=	IF((UNSIGNED)pInput.date_last_seen < 300000,
                                           (UNSIGNED)pInput.date_last_seen * 100,
                                           (UNSIGNED)pInput.date_last_seen);
		SELF.dt_vendor_last_reported	   :=	IF((UNSIGNED)pInput.date_vendor_last_reported < 300000,
                                           (UNSIGNED)pInput.date_vendor_last_reported * 100,
                                           (UNSIGNED)pInput.date_vendor_last_reported);
		SELF.dt_vendor_first_reported	   :=	IF((UNSIGNED)pInput.date_vendor_first_reported < 300000,
                                           (UNSIGNED)pInput.date_vendor_first_reported * 100,
                                           (UNSIGNED)pInput.date_vendor_first_reported);
 		SELF.company_bdid                :=	(UNSIGNED)pInput.bdid;
    
		// Business Data
		SELF.company_name				         :=	pInput.company_name;   
		SELF.company_rawaid              := pInput.rawaid;   
		SELF.company_address.prim_range  :=	pInput.prim_range;
		SELF.company_address.predir      :=	pInput.predir;
		SELF.company_address.prim_name	 :=	pInput.prim_name;
		SELF.company_address.addr_suffix :=	pInput.suffix;
		SELF.company_address.postdir	   :=	pInput.postdir;
		SELF.company_address.unit_desig	 :=	pInput.unit_desig;
		SELF.company_address.sec_range   :=	pInput.sec_range;    
    SELF.company_address.p_city_name := pInput.p_city_name;
    SELF.company_address.v_city_name := pInput.v_city_name;
		SELF.company_address.st					 :=	pInput.st;
		SELF.company_address.zip         :=	pInput.zip5;
		SELF.company_address.zip4	       :=	pInput.zip4;
		SELF.company_address.cart        := pInput.cart;
		SELF.company_address.cr_sort_sz  := pInput.cr_sort_sz;
		SELF.company_address.lot         := pInput.lot;
		SELF.company_address.lot_order   := pInput.lot_order;
		SELF.company_address.dbpc        := pInput.dpbc;
		SELF.company_address.chk_digit   := pInput.chk_digit;
		SELF.company_address.rec_type    := pInput.rec_type;
		SELF.company_address.fips_state  := pInput.ace_fips_st;
		SELF.company_address.fips_county := pInput.ace_fips_county;
		SELF.company_address.geo_lat     := pInput.geo_lat;
		SELF.company_address.geo_long    := pInput.geo_long;
		SELF.company_address.msa         := pInput.msa;
		SELF.company_address.geo_blk     := pInput.geo_blk;
		SELF.company_address.geo_match   := pInput.geo_match;
		SELF.company_address.err_stat    := pInput.err_stat; 
		SELF.company_fein                :=	IF(pInput.fein <> '', pInput.fein, pInput.orig_fein);
	  SELF.company_phone               := CHOOSE(CTR, ut.CleanPhone(pInput.phone_1), ut.CleanPhone(pInput.phone_2));

		// More General Data
		SELF.vl_id                       :=	pInput.state_origin + TRIM(pInput.watercraft_key,LEFT,RIGHT) +
                                        TRIM(pInput.sequence_key,LEFT,RIGHT);
		SELF.current                     := IF(pInput.history_flag = '',TRUE,FALSE);
		SELF.source_record_id            :=	pInput.source_rec_id;
		SELF.dppa                        :=	pInput.state_origin IN Watercraft.sDPPA_Restricted_Watercraft_States;
	  SELF.phone_score                 := IF(SELF.company_phone = '', 0, 1);

    // Contact Data
		SELF.contact_name.title          := pInput.title;
		SELF.contact_name.fname          := pInput.fname;
		SELF.contact_name.mname          := pInput.mname;
		SELF.contact_name.lname          := pInput.lname;
		SELF.contact_name.name_suffix    := pInput.name_suffix;
		SELF.contact_name.name_score     := Business_Header.CleanName(SELF.contact_name.fname,
                                                                  SELF.contact_name.mname,
                                                                  SELF.contact_name.lname,
                                                                  SELF.contact_name.name_suffix)[142];
		SELF.contact_ssn                 := IF(pInput.ssn <> '', pInput.ssn, pInput.orig_ssn);
		SELF.contact_dob                 := (UNSIGNED)pInput.dob;
	  SELF.contact_phone               := CHOOSE(CTR, ut.CleanPhone(pInput.phone_1), ut.CleanPhone(pInput.phone_2));
    SELF                             := pInput;
    SELF                             := [];
	END;

	dWatercraftAsBusLnk	:= NORMALIZE(dWatercraftSearch(company_name <> ''), 2, 
                                   tWatercraftAsBusinessLinking(LEFT, COUNTER));

	// -- figure out if it is a business, person, or both
	Address.Mac_Is_Business(dWatercraftAsBusLnk, company_name, 
                          dWtrcrft_with_nametype, dodedup := FALSE);

	Layout_Wtrcrft_entity := RECORDOF(dWtrcrft_with_nametype);

	dWtrcrft_Entity := dWtrcrft_with_nametype(company_name != '');

	// ----------------------------------------
	// -- Back to bus link layout
	// ----------------------------------------
	rNewBusinessLayout Translate_Entity_to_BLF(Layout_Wtrcrft_entity L) := TRANSFORM
		SELF := L;
	END;
  
	dWtrcrft_bus := PROJECT(dWtrcrft_Entity(nameType = 'B'), Translate_Entity_to_BLF(LEFT));

	// Rollup
	rNewBusinessLayout RollupBL(rNewBusinessLayout l, rNewBusinessLayout r) := TRANSFORM
	  SELF.dt_first_seen               := ut.EarliestDate(ut.EarliestDate(l.dt_first_seen,r.dt_first_seen),
				                                                ut.EarliestDate(l.dt_last_seen,r.dt_last_seen));
	  SELF.dt_last_seen                := ut.LatestDate(l.dt_last_seen,r.dt_last_seen);
	  SELF.dt_vendor_last_reported     := ut.LatestDate(l.dt_vendor_last_reported, 
                                                      r.dt_vendor_last_reported);
	  SELF.dt_vendor_first_reported    := ut.EarliestDate(l.dt_vendor_first_reported,
                                                        r.dt_vendor_first_reported);
	  SELF.company_name                := IF(l.company_name = '', r.company_name, l.company_name);
	  SELF.vl_id                       := IF(l.vl_id = '', r.vl_id, l.vl_id);
	  SELF.company_phone               := IF(l.company_phone = '', r.company_phone, l.company_phone);
	  SELF.phone_score                 := IF(l.company_phone = '', r.phone_score, l.phone_score);
	  SELF.company_address.prim_range  := IF(l.company_address.prim_range = '' AND l.company_address.zip4 = '', 
                                           r.company_address.prim_range, l.company_address.prim_range);
	  SELF.company_address.predir      := IF(l.company_address.predir = '' AND l.company_address.zip4 = '',
                                           r.company_address.predir, l.company_address.predir);
	  SELF.company_address.prim_name   := IF(l.company_address.prim_name = '' AND l.company_address.zip4 = '',
                                           r.company_address.prim_name, l.company_address.prim_name);
	  SELF.company_address.addr_suffix := IF(l.company_address.addr_suffix = '' AND l.company_address.zip4 = '',
                                           r.company_address.addr_suffix, l.company_address.addr_suffix);
	  SELF.company_address.postdir     := IF(l.company_address.postdir = '' AND l.company_address.zip4 = '',
                                           r.company_address.postdir, l.company_address.postdir);
	  SELF.company_address.unit_desig  := IF(l.company_address.unit_desig = ''AND l.company_address.zip4 = '',
                                           r.company_address.unit_desig, l.company_address.unit_desig);
	  SELF.company_address.sec_range   := IF(l.company_address.sec_range = '' AND l.company_address.zip4 = '',
                                           r.company_address.sec_range, l.company_address.sec_range);
	  SELF.company_address.p_city_name := IF(l.company_address.p_city_name = '' AND l.company_address.zip4 = '',
                                           r.company_address.p_city_name, l.company_address.p_city_name);
	  SELF.company_address.v_city_name := IF(l.company_address.v_city_name = '' AND l.company_address.zip4 = '',
                                           r.company_address.v_city_name, l.company_address.v_city_name);
	  SELF.company_address.st          := IF(l.company_address.st = '' AND l.company_address.zip4 = '',
                                           r.company_address.st, l.company_address.st);
	  SELF.company_address.zip         := IF(l.company_address.zip = '' AND l.company_address.zip4 = '',
                                           r.company_address.zip, l.company_address.zip);
	  SELF.company_address.zip4        := IF(l.company_address.zip4 = '', r.company_address.zip4, l.company_address.zip4);
	  SELF.company_address.cart        := IF(l.company_address.cart = '' AND l.company_address.zip4 = '',
                                           r.company_address.cart, l.company_address.cart);
	  SELF.company_address.cr_sort_sz  := IF(l.company_address.cr_sort_sz = '' AND l.company_address.zip4 = '',
                                           r.company_address.cr_sort_sz, l.company_address.cr_sort_sz);
	  SELF.company_address.lot         := IF(l.company_address.lot = '' AND l.company_address.zip4 = '',
                                           r.company_address.lot, l.company_address.lot);
	  SELF.company_address.lot_order   := IF(l.company_address.lot_order = '' AND l.company_address.zip4 = '',
                                           r.company_address.lot_order, l.company_address.lot_order);
	  SELF.company_address.dbpc        := IF(l.company_address.dbpc = '' AND l.company_address.zip4 = '',
                                           r.company_address.dbpc, l.company_address.dbpc);
	  SELF.company_address.chk_digit   := IF(l.company_address.chk_digit = '' AND l.company_address.zip4 = '',
                                           r.company_address.chk_digit, l.company_address.chk_digit);
	  SELF.company_address.rec_type    := IF(l.company_address.rec_type = '' AND l.company_address.zip4 = '',
                                           r.company_address.rec_type, l.company_address.rec_type);
	  SELF.company_address.fips_state  := IF(l.company_address.fips_state = '' AND l.company_address.zip4 = '',
                                           r.company_address.fips_state, l.company_address.fips_state);
	  SELF.company_address.fips_county := IF(l.company_address.fips_county = '' AND l.company_address.zip4 = '',
                                           r.company_address.fips_county, l.company_address.fips_county);
	  SELF.company_address.geo_lat     := IF(l.company_address.geo_lat = '' AND l.company_address.zip4 = '',
                                           r.company_address.geo_lat, l.company_address.geo_lat);
	  SELF.company_address.geo_long    := IF(l.company_address.geo_long = '' AND l.company_address.zip4 = '',
                                           r.company_address.geo_long, l.company_address.geo_long);
	  SELF.company_address.msa         := IF(l.company_address.msa = '' AND l.company_address.zip4 = '',
                                           r.company_address.msa, l.company_address.msa);
	  SELF.company_address.geo_blk     := IF(l.company_address.geo_blk = '' AND l.company_address.zip4 = '',
                                           r.company_address.geo_blk, l.company_address.geo_blk);
	  SELF.company_address.geo_match   := IF(l.company_address.geo_match = '' AND l.company_address.zip4 = '',
                                           r.company_address.geo_match, l.company_address.geo_match);
	  SELF.company_address.err_stat    := IF(l.company_address.err_stat = '' AND l.company_address.zip4 = '',
                                           r.company_address.err_stat, l.company_address.err_stat);
	  SELF.contact_ssn                 := IF(l.contact_ssn = '', r.contact_ssn, l.contact_ssn);
	  SELF.contact_dob                 := IF(l.contact_dob = 0, r.contact_dob, l.contact_dob);
	  SELF.company_fein                := IF(l.company_fein = '', r.company_fein, l.company_fein);
    SELF                             := L;
	END;

	dWatercraft_dist := DISTRIBUTE(dWtrcrft_bus, HASH(company_address.zip, TRIM(company_address.prim_name),
                                                    TRIM(company_address.prim_range), TRIM(company_name),
                                                    TRIM(contact_name.lname)));
	dWatercraft_sort := SORT(dWatercraft_dist, company_address.zip, company_address.prim_range, 
                           company_address.prim_name, company_name,
						               IF(company_address.sec_range <> '', 0, 1), company_address.sec_range,
						               IF(company_phone <> '', 0, 1), company_phone,
						               dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen,
                           contact_name.lname, contact_name.fname, contact_name.mname,
                           contact_name.name_suffix, LOCAL);
	dWatercraft_rollup := ROLLUP(dWatercraft_sort,
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
                        LEFT.contact_name.name_suffix = RIGHT.contact_name.name_suffix,
						            RollupBL(LEFT, RIGHT),
						            LOCAL);

	RETURN dWatercraft_rollup;
  
END;