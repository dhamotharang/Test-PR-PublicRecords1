IMPORT Business_Header, mdr, ut, _Validate;

EXPORT fCleaned_OSHAIR_Inspection_As_Business_Linking(DATASET(layout_OSHAIR_inspection_clean_BIP) pIspBase)
 := FUNCTION

	Cleaned_OSHAIR_Inspection_Base := pIspBase;

	Business_Header.Layout_Business_Linking.Linking_Interface  Translate_Cleaned_OSHAIR_Inspection_To_BLF(layout_OSHAIR_inspection_clean_BIP L, INTEGER c) := TRANSFORM,
                                             SKIP(L.prim_name = '' AND L.p_city_name = '' AND L.st  = '' AND L.zip5 = '')  	  
		SELF.source 					              := MDR.sourceTools.src_OSHAIR;  
		SELF.dt_first_seen 				          := IF(_Validate.Date.fIsValid((STRING)L.last_activity_date),L.last_activity_date,0);
		SELF.dt_last_seen 				          := IF(_Validate.Date.fIsValid((STRING)L.last_activity_date),L.last_activity_date,0);
		SELF.company_bdid 						      := L.bdid;
		SELF.company_name 			      	    := Stringlib.StringToUpperCase(IF(TRIM(L.inspected_site_name) = '',
	                                                         CHOOSE(c, L.inspected_site_name, L.cname),L.inspected_site_name));
		SELF.company_address.prim_range     := L.prim_range;
		SELF.company_address.predir         := L.predir;
		SELF.company_address.prim_name      := L.prim_name;
		SELF.company_address.addr_suffix    := L.addr_suffix;
		SELF.company_address.postdir        := L.postdir;
		SELF.company_address.unit_desig     := L.unit_desig;
		SELF.company_address.sec_range      := L.sec_range;
		SELF.company_address.p_city_name    := L.p_city_name;
		SELF.company_address.v_city_name    := L.v_city_name;
		SELF.company_address.st             := L.st;
		SELF.company_address.zip            := L.zip5;
		SELF.company_address.zip4           := L.zip4;
		SELF.company_address.cart           := L.cart;
		SELF.company_address.cr_sort_sz     := L.cr_sort_sz;
		SELF.company_address.lot            := L.lot;
		SELF.company_address.lot_order      := L.lot_order;
		SELF.company_address.dbpc           := L.dpbc;
		SELF.company_address.chk_digit      := L.chk_digit;
		SELF.company_address.rec_type       := L.addr_rec_type;
		SELF.company_address.fips_state     := L.fips_state;
		SELF.company_address.fips_county    := L.fips_county;
		SELF.company_address.geo_lat        := L.geo_lat;
		SELF.company_address.geo_long       := L.geo_long;
		SELF.company_address.msa            := L.cbsa;
		SELF.company_address.geo_blk        := L.geo_blk;
		SELF.company_address.geo_match      := L.geo_match;
		SELF.company_address.err_stat       := L.err_stat;
		SELF.company_org_structure_raw      := L.own_type_desc;
		SELF.company_sic_code1              := (STRING)L.sic_code;
		SELF.company_naics_code1            := L.naics_code;
		SELF.company_naics_code2            := L.naics_secondary_code;
    SELF.vl_id 			            		    := (STRING)L.activity_number;		
		SELF.source_record_id               := L.source_rec_id;
		SELF.current                     		:= TRUE;
		SELF.duns_number                 		:= '';
		SELF 																:= L;
		SELF 																:= [];
	END;
	
	From_Cleaned_OSHAIR_Inspection_Norm        := NORMALIZE(Cleaned_OSHAIR_Inspection_Base, 2,
										                            Translate_Cleaned_OSHAIR_Inspection_to_BLF(LEFT, COUNTER));
																					 
	From_Cleaned_OSHAIR_Inspection_Norm_Filter := From_Cleaned_OSHAIR_Inspection_Norm(company_name <> '');

	From_Cleaned_OSHAIR_Inspection_Norm_Dist   := DISTRIBUTE(From_Cleaned_OSHAIR_Inspection_Norm_Filter,
									 	                            HASH(company_address.zip, company_name));
	
	From_Cleaned_OSHAIR_Inspection_Norm_Sort   := SORT(From_Cleaned_OSHAIR_Inspection_Norm_Dist,
																								company_name,
																								-company_address.zip,
										                            -company_address.st,
										                            -company_address.p_city_name,
																								LOCAL);

   Business_Header.Layout_Business_Linking.Linking_Interface RollupCleanedOSHAIR_Inspection(Business_Header.Layout_Business_Linking.Linking_Interface L, Business_Header.Layout_Business_Linking.Linking_Interface R) := TRANSFORM
	    SELF.dt_first_seen                 := ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
												                    ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
	    SELF.dt_last_seen                  := ut.LatestDate(L.dt_last_seen,R.dt_last_seen);
		  SELF.company_name                  := IF(L.company_name = '',                                                  R.company_name,                 L.company_name);
	    SELF.company_address.prim_range    := IF(L.company_address.prim_range = ''     AND (INTEGER)L.company_address.zip4 = 0, R.company_address.prim_range,   L.company_address.prim_range);
	    SELF.company_address.predir        := IF(L.company_address.predir = ''         AND (INTEGER)L.company_address.zip4 = 0, R.company_address.predir,       L.company_address.predir);
	    SELF.company_address.prim_name     := IF(L.company_address.prim_name = ''      AND (INTEGER)L.company_address.zip4 = 0, R.company_address.prim_name,    L.company_address.prim_name);
	    SELF.company_address.addr_suffix   := IF(L.company_address.addr_suffix = ''    AND (INTEGER)L.company_address.zip4 = 0, R.company_address.addr_suffix,  L.company_address.addr_suffix);
	    SELF.company_address.postdir       := IF(L.company_address.postdir = ''        AND (INTEGER)L.company_address.zip4 = 0, R.company_address.postdir,      L.company_address.postdir);
	    SELF.company_address.unit_desig    := IF(L.company_address.unit_desig = ''     AND (INTEGER)L.company_address.zip4 = 0, R.company_address.unit_desig,   L.company_address.unit_desig);
	    SELF.company_address.sec_range     := IF(L.company_address.sec_range = ''      AND (INTEGER)L.company_address.zip4 = 0, R.company_address.sec_range,    L.company_address.sec_range);
	    SELF.company_address.p_city_name   := IF(L.company_address.p_city_name = ''    AND (INTEGER)L.company_address.zip4 = 0, R.company_address.p_city_name,  L.company_address.p_city_name);
		  SELF.company_address.v_city_name   := IF(L.company_address.v_city_name = ''    AND (INTEGER)L.company_address.zip4 = 0, R.company_address.v_city_name,  L.company_address.v_city_name);
	    SELF.company_address.st            := IF(L.company_address.st = ''             AND (INTEGER)L.company_address.zip4 = 0, R.company_address.st,           L.company_address.st);
	    SELF.company_address.zip           := IF((INTEGER)L.company_address.zip = 0    AND (INTEGER)L.company_address.zip4 = 0, R.company_address.zip,          L.company_address.zip);
	    SELF.company_address.zip4          := IF((INTEGER)L.company_address.zip4 = 0,                                           R.company_address.zip4,         L.company_address.zip4);
			SELF.company_address.cart          := IF(L.company_address.cart = ''           AND (INTEGER)L.company_address.zip4 = 0, R.company_address.cart,         L.company_address.cart);
			SELF.company_address.cr_sort_sz    := IF(L.company_address.cr_sort_sz = ''     AND (INTEGER)L.company_address.zip4 = 0, R.company_address.cr_sort_sz,   L.company_address.cr_sort_sz);
			SELF.company_address.lot           := IF(L.company_address.lot = ''            AND (INTEGER)L.company_address.zip4 = 0, R.company_address.lot,          L.company_address.lot);
			SELF.company_address.lot_order     := IF(L.company_address.lot_order = ''      AND (INTEGER)L.company_address.zip4 = 0, R.company_address.lot_order,    L.company_address.lot_order);
			SELF.company_address.dbpc          := IF(L.company_address.dbpc = ''           AND (INTEGER)L.company_address.zip4 = 0, R.company_address.dbpc,         L.company_address.dbpc);
			SELF.company_address.chk_digit     := IF(L.company_address.chk_digit = ''      AND (INTEGER)L.company_address.zip4 = 0, R.company_address.chk_digit,    L.company_address.chk_digit);
			SELF.company_address.rec_type      := IF(L.company_address.rec_type = ''       AND (INTEGER)L.company_address.zip4 = 0, R.company_address.rec_type,     L.company_address.rec_type);
			SELF.company_address.fips_state    := IF(L.company_address.fips_state = ''     AND (INTEGER)L.company_address.zip4 = 0, R.company_address.fips_state,   L.company_address.fips_state);
	    SELF.company_address.fips_county   := IF(L.company_address.fips_county = ''    AND (INTEGER)L.company_address.zip4 = 0, R.company_address.fips_county,  L.company_address.fips_county);
	    SELF.company_address.geo_lat       := IF(L.company_address.geo_lat = ''        AND (INTEGER)L.company_address.zip4 = 0, R.company_address.geo_lat,      L.company_address.geo_lat);
	    SELF.company_address.geo_long      := IF(L.company_address.geo_long = ''       AND (INTEGER)L.company_address.zip4 = 0, R.company_address.geo_long,     L.company_address.geo_long);
			SELF.company_address.msa           := IF(L.company_address.msa = ''            AND (INTEGER)L.company_address.zip4 = 0, R.company_address.msa,          L.company_address.msa);
			SELF.company_address.geo_blk       := IF(L.company_address.geo_blk = ''        AND (INTEGER)L.company_address.zip4 = 0, R.company_address.geo_blk,      L.company_address.geo_blk);
			SELF.company_address.geo_match     := IF(L.company_address.geo_match = ''      AND (INTEGER)L.company_address.zip4 = 0, R.company_address.geo_match,    L.company_address.geo_match);
			SELF.company_address.err_stat      := IF(L.company_address.err_stat = ''       AND (INTEGER)L.company_address.zip4 = 0, R.company_address.err_stat,     L.company_address.err_stat);
			SELF.company_org_structure_raw     := IF(L.company_org_structure_raw = '',                                     R.company_org_structure_raw,    L.company_org_structure_raw);
			SELF.company_sic_code1             := IF(L.company_sic_code1 = '',                                             R.company_sic_code1,            L.company_sic_code1);
			SELF.company_naics_code1           := IF(L.company_naics_code1 = '',                                           R.company_naics_code1,          L.company_naics_code1);
      SELF.company_naics_code2           := IF(L.company_naics_code2 = '',                                           R.company_naics_code2,          L.company_naics_code2);	
			SELF.source_record_id              := IF(L.source_record_id <> 0, L.source_record_id, R.source_record_id);
	    SELF                               := L;
	 END;

	Cleaned_OSHAIR_Inspection_Clean_Rollup := ROLLUP(From_Cleaned_OSHAIR_Inspection_Norm_Sort,
										 LEFT.company_address.zip          = RIGHT.company_address.zip          AND
										 LEFT.company_address.prim_name    = RIGHT.company_address.prim_name    AND
										 LEFT.company_address.prim_range   = RIGHT.company_address.prim_range   AND
									 	 LEFT.company_name                 = RIGHT.company_name AND
									   (RIGHT.company_address.sec_range  = '' OR LEFT.company_address.sec_range = RIGHT.company_address.sec_range),
									   RollupCleanedOSHAIR_Inspection(LEFT, RIGHT),LOCAL);
					 
	OSHAIR_dedup := DEDUP(Cleaned_OSHAIR_Inspection_Clean_Rollup, LOCAL);																		 
	
	RETURN OSHAIR_dedup;  

END;