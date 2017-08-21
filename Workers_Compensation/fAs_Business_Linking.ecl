IMPORT Business_Header, ut, MDR, _validate, dnb_feinv2;
EXPORT fAs_Business_Linking(DATASET(layouts.Keybuild) pDataset) := FUNCTION
     			
  // -- Map to New Business Header format
  bl_layout := Business_Header.Layout_Business_Linking.Linking_Interface;
      
  bl_layout tAsBusinessLinking(layouts.Keybuild L) := TRANSFORM
 
    SELF.source_record_id						 := L.source_rec_id;    
		SELF.source 					           :=	MDR.sourceTools.src_Workers_Compensation;
	  SELF.dt_first_seen               := if(_validate.date.fIsValid((STRING)L.Date_FirstSeen),
																					 (UNSIGNED4)L.Date_FirstSeen, 0);
		SELF.dt_last_seen  					     := if(_validate.date.fIsValid((STRING)L.Date_LastSeen), 
																					 (UNSIGNED4)L.Date_LastSeen, SELF.dt_first_seen);
		SELF.dt_vendor_first_reported    := SELF.dt_first_seen;
		SELF.dt_vendor_last_reported     := SELF.dt_last_seen;
 		SELF.company_bdid                :=	(UNSIGNED)L.bdid;
    
		// Business Data
		SELF.company_name				         :=	L.description;   
		SELF.company_rawaid              := L.append_mailrawaid;   
		SELF.company_address.prim_range  :=	L.m_prim_range;
		SELF.company_address.predir      :=	L.m_predir;
		SELF.company_address.prim_name	 :=	L.m_prim_name;
		SELF.company_address.addr_suffix :=	L.m_addr_suffix;
		SELF.company_address.postdir	   :=	L.m_postdir;
		SELF.company_address.unit_desig	 :=	L.m_unit_desig;
		SELF.company_address.sec_range   :=	L.m_sec_range;    
    SELF.company_address.p_city_name := L.m_p_city_name;
    SELF.company_address.v_city_name := L.m_v_city_name;
		SELF.company_address.st					 :=	L.m_st;
		SELF.company_address.zip         :=	L.m_zip;
		SELF.company_address.zip4	       :=	L.m_zip4;
		SELF.company_address.cart        := L.m_cart;
		SELF.company_address.cr_sort_sz  := L.m_cr_sort_sz;
		SELF.company_address.lot         := L.m_lot;
		SELF.company_address.lot_order   := L.m_lot_order;
		SELF.company_address.dbpc        := L.m_dbpc;
		SELF.company_address.chk_digit   := L.m_chk_digit;
		SELF.company_address.rec_type    := L.m_rec_type;
		SELF.company_address.fips_state  := L.m_fips_state;
		SELF.company_address.fips_county := L.m_fips_county;
		SELF.company_address.geo_lat     := L.m_geo_lat;
		SELF.company_address.geo_long    := L.m_geo_long;
		SELF.company_address.msa         := L.m_msa;
		SELF.company_address.geo_blk     := L.m_geo_blk;
		SELF.company_address.geo_match   := L.m_geo_match;
		SELF.company_address.err_stat    := L.m_err_stat; 
		SELF.company_fein                :=	IF(LENGTH(TRIM(stringlib.stringfilter(L.fein, '0123456789'),LEFT,RIGHT)) = 9,L.fein,'');

		// More General Data
		SELF.vl_id                       :=	TRIM(L.Master_UID);
		SELF.current                     := TRUE;

    SELF                             := L;
    SELF                             := [];
  END;
     		
	dAsBusinessLinking := PROJECT( pDataset(description <> ''), tAsBusinessLinking(LEFT) );

  //Validate the FEIN with DNB
  // dDNB := dnb_feinv2.File_DNB_Fein_base_main_new;
 
  // bl_layout tValidateFEIN(bl_layout L, dnb_feinv2.layout_DNB_fein_base_main_new R) := TRANSFORM
	  // SELF.company_fein := IF(R.fein != '', L.company_fein, '');
	  // SELF := L;
  // END;

  // dAsBusLinkValid := JOIN(dAsBusinessLinking, dDNB,
										      // LEFT.company_fein = RIGHT.fein,
											    // tValidateFEIN(LEFT,RIGHT),LOOKUP, LEFT OUTER );

  // Rollup
	bl_layout RollupWorkComp(bl_layout l, bl_layout r) := TRANSFORM
	  SELF.source_record_id						 := IF(l.source_record_id < r.source_record_id, l.source_record_id, r.source_record_id);
	  SELF.dt_first_seen               := ut.EarliestDate(ut.EarliestDate(l.dt_first_seen,r.dt_first_seen),
				                                                ut.EarliestDate(l.dt_last_seen,r.dt_last_seen));
	  SELF.dt_last_seen                := Max(l.dt_last_seen,r.dt_last_seen);
	  SELF.dt_vendor_last_reported     := Max(l.dt_vendor_last_reported,r.dt_vendor_last_reported);
	  SELF.dt_vendor_first_reported    := ut.EarliestDate(l.dt_vendor_first_reported,
                                                        r.dt_vendor_first_reported);
	  SELF.company_name                := IF(l.company_name = '', r.company_name, l.company_name);
	  SELF.vl_id                       := IF(l.vl_id = '', r.vl_id, l.vl_id);
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
    SELF                             := L;
	END;

	dBus_Link_Dist   := DISTRIBUTE(dAsBusinessLinking, HASH(vl_id));
	dBus_Link_Sort   := SORT(dBus_Link_Dist, company_address.zip, company_address.prim_range, 
                           company_address.prim_name, company_name, vl_id,
						               IF(company_address.sec_range <> '', 0, 1), company_address.sec_range,
						               dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, LOCAL);
	dBus_Link_Rollup := ROLLUP(dBus_Link_Sort,
						                 LEFT.company_address.zip = RIGHT.company_address.zip AND
						                 LEFT.company_address.prim_name = RIGHT.company_address.prim_name AND
						                 LEFT.company_address.prim_range = RIGHT.company_address.prim_range AND
						                 LEFT.company_address.p_city_name = RIGHT.company_address.p_city_name AND
						                 LEFT.company_name = RIGHT.company_name AND
						                 LEFT.vl_id = RIGHT.vl_id AND
						                 (RIGHT.company_address.sec_range = '' OR
                             LEFT.company_address.sec_range = RIGHT.company_address.sec_range),
						                 RollupWorkComp(LEFT, RIGHT), LOCAL);

	RETURN dBus_Link_Rollup;

END;
