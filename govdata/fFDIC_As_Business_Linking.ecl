IMPORT Business_Header, ut, mdr, _validate;

EXPORT fFDIC_As_Business_Linking(DATASET(Layouts_FDIC.Base_AID) pBasefile) := FUNCTION

  FDIC_In := pBasefile;
	
  rNewBusinessLayout := RECORD
		Business_Header.Layout_Business_Linking.Linking_Interface;
	END;

  rNewBusinessLayout Translate_FDIC_To_BLF(Layouts_FDIC.Base_AID l) := TRANSFORM
    SELF.source                      := MDR.sourceTools.src_FDIC; // Source file type
    SELF.dt_first_seen               := IF(_validate.date.fIsValid(l.effdate[1..4] + l.effdate[6..7] + l.effdate[9..10]),
                                           (UNSIGNED4)(l.effdate[1..4] + l.effdate[6..7] + l.effdate[9..10]), 0);
    SELF.dt_last_seen                := IF(l.endefymd[1..4] = '9999' or l.active = '1',
                                           IF(_validate.date.fIsValid(l.repdte[1..4] + l.repdte[6..7] + l.repdte[9..10]),
                                              (UNSIGNED4)(l.repdte[1..4] + l.repdte[6..7] + l.repdte[9..10]), 0),
                                           IF(_validate.date.fIsValid(l.endefymd[1..4] + l.endefymd[6..7] + l.endefymd[9..10]),
                                              (UNSIGNED4)(l.endefymd[1..4] + l.endefymd[6..7] + l.endefymd[9..10]), 0));
    SELF.dt_vendor_first_reported    := (UNSIGNED4)l.process_date;
    SELF.dt_vendor_last_reported     := (UNSIGNED4)l.process_date;
 		SELF.company_bdid                :=	l.bdid;
		SELF.company_name				         :=	ut.CleanSpacesAndUpper(l.name);  
		SELF.company_rawaid              := l.append_rawaid;   
		SELF.company_address.prim_range  :=	l.prim_range;
		SELF.company_address.predir      :=	l.predir;
		SELF.company_address.prim_name	 :=	l.prim_name;
		SELF.company_address.addr_suffix :=	l.addr_suffix;
		SELF.company_address.postdir	   :=	l.postdir;
		SELF.company_address.unit_desig	 :=	l.unit_desig;
		SELF.company_address.sec_range   :=	l.sec_range;    
    SELF.company_address.p_city_name := l.p_city_name;
    SELF.company_address.v_city_name := l.v_city_name;
		SELF.company_address.st					 :=	l.st;
		SELF.company_address.zip         :=	l.zip5;
		SELF.company_address.zip4	       :=	l.zip4;
		SELF.company_address.cart        := l.cart;
		SELF.company_address.cr_sort_sz  := l.cr_sort_sz;
		SELF.company_address.lot         := l.lot;
		SELF.company_address.lot_order   := l.lot_order;
		SELF.company_address.dbpc        := l.dpbc;
		SELF.company_address.chk_digit   := l.chk_digit;
		SELF.company_address.rec_type    := l.record_type;
		SELF.company_address.fips_state  := l.ace_fips_st;
		SELF.company_address.fips_county := l.fipscounty;
		SELF.company_address.geo_lat     := l.geo_lat;
		SELF.company_address.geo_long    := l.geo_long;
		SELF.company_address.msa         := l.msa_code;
		SELF.company_address.geo_blk     := l.geo_blk;
		SELF.company_address.geo_match   := l.geo_match;
		SELF.company_address.err_stat    := l.err_stat; 
 		SELF.company_url                 := l.webaddr;
 		SELF.vl_id                       := l.fed_rssd; // A unique number assigned by the Federal Reserve Board
                                                    //(FRB) used to identify as the entity's unique identifier.
		SELF.source_record_id						 := l.source_rec_id;
		SELF.current                     := IF(l.active = '1', TRUE, FALSE);   // Current/Historical indicator
    SELF                             := l;
    SELF                             := [];
  END;

  FDIC_Init := PROJECT(FDIC_In, Translate_FDIC_To_BLF(LEFT));

  // Rollup
	rNewBusinessLayout RollupFDIC(rNewBusinessLayout l, rNewBusinessLayout r) := TRANSFORM
	  SELF.dt_first_seen               := ut.EarliestDate(ut.EarliestDate(l.dt_first_seen,r.dt_first_seen),
				                                                ut.EarliestDate(l.dt_last_seen,r.dt_last_seen));
	  SELF.dt_last_seen                := max(l.dt_last_seen,r.dt_last_seen);
	  SELF.dt_vendor_last_reported     := max(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
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
		SELF.source_record_id					   := if(l.dt_vendor_first_reported < r.dt_vendor_first_reported, l.source_record_id, r.source_record_id);
    SELF                             := L;
	END;

	FDIC_Init_Dist   := DISTRIBUTE(FDIC_Init, HASH(vl_id));
	FDIC_Init_Sort   := SORT(FDIC_Init_Dist, company_address.zip, company_address.prim_range, 
                           company_address.prim_name, company_name, vl_id,
						               IF(company_address.sec_range <> '', 0, 1), company_address.sec_range,
						               dt_vendor_first_reported, LOCAL);
	FDIC_Init_Rollup := ROLLUP(FDIC_Init_Sort,
						            LEFT.company_address.zip = RIGHT.company_address.zip AND
						            LEFT.company_address.prim_name = RIGHT.company_address.prim_name AND
						            LEFT.company_address.prim_range = RIGHT.company_address.prim_range AND
						            LEFT.company_address.p_city_name = RIGHT.company_address.p_city_name AND
						            ut.CleanCompany(LEFT.company_name) = ut.CleanCompany(RIGHT.company_name) AND
						            LEFT.vl_id = RIGHT.vl_id AND
						            (RIGHT.company_address.sec_range = '' OR
                        LEFT.company_address.sec_range = RIGHT.company_address.sec_range),
						            RollupFDIC(LEFT, RIGHT), LOCAL);

	RETURN FDIC_Init_Rollup;

END;