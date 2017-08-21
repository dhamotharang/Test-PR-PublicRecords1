IMPORT Business_Header, ut, MDR, _Validate;

rLayout_Plus :=  RECORD
	faa.layout_aircraft_registration_out;
	UNSIGNED8 __fpos { VIRTUAL (fileposition)};
END;

EXPORT fFAA_aircraft_reg_as_business_linking(DATASET(rLayout_Plus) pFAA_Aircraft_Reg) := FUNCTION 

  df := pFAA_Aircraft_Reg;
	 
	Business_Header.Layout_Business_Linking.Linking_Interface  Translate_FAA_To_BLF(rLayout_Plus L) := TRANSFORM,
	           SKIP (L.compname = '' OR L.compname = 'SALE REPORTED')
	  SELF.source 					              := MDR.sourceTools.src_Aircrafts;
		SELF.source_record_id								:= L.source_rec_id;
		SELF.dt_first_seen 				          := IF(_Validate.Date.fIsValid(L.date_first_seen),(INTEGER)L.date_first_seen,0);
		SELF.dt_last_seen 				          := IF(_Validate.Date.fIsValid(L.date_last_seen),(INTEGER)L.date_last_seen,0);
		SELF.company_bdid 						      := (INTEGER)L.bdid_out;
		SELF.company_name 			      	    := Stringlib.StringToUpperCase(L.compname);
		SELF.company_address_type_raw       := 'CC';
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
		SELF.company_address.zip            := L.zip;
		SELF.company_address.zip4           := L.z4;
		SELF.company_address.cart           := L.cart;
		SELF.company_address.cr_sort_sz     := L.cr_sort_sz;
		SELF.company_address.lot            := L.lot;
		SELF.company_address.lot_order      := L.lot_order;
		SELF.company_address.dbpc           := L.dpbc;
		SELF.company_address.chk_digit      := L.chk_digit;
		SELF.company_address.fips_state     := L.ace_fips_st;
		SELF.company_address.fips_county    := L.county;
		SELF.company_address.geo_lat        := L.geo_lat;
		SELF.company_address.geo_long       := L.geo_long;
		SELF.company_address.msa            := L.msa;
		SELF.company_address.geo_blk        := L.geo_blk;
		SELF.company_address.geo_match      := L.geo_match;
		SELF.company_address.err_stat       := L.err_stat;
	  SELF.vl_id 			            		    := L.name[1..6] + L.zip_code[1..5] + L.type_registrant + L.n_number;	
		SELF.current                     		:= IF (L.current_flag = 'H', FALSE, TRUE);
		SELF.contact_name.title             := L.title; 	
		SELF.contact_name.fname             := L.fname; 		
		SELF.contact_name.mname             := L.mname; 		
		SELF.contact_name.lname             := L.lname; 		
		SELF.contact_name.name_suffix       := L.name_suffix; 		
		SELF.contact_name.name_score        := Business_Header.CleanName(L.fname, L.mname, L.lname, L.name_suffix)[142]; 
		SELF 																:= L;
		SELF 																:= [];
	END;

  dsAcft      := PROJECT(df,Translate_FAA_To_BLF(LEFT));
	dsAcft_dist := DISTRIBUTE(dsAcft, HASH(vl_id));
	dsAcft_srt  := SORT(dsAcft_dist,
	                    vl_id,company_name,company_address.zip,company_address.prim_range,
											company_address.prim_name,company_address.p_city_name,company_address.st,company_address.sec_range,
											LOCAL);
	
	Business_Header.Layout_Business_Linking.Linking_Interface RollupAcft(Business_Header.Layout_Business_Linking.Linking_Interface L, Business_Header.Layout_Business_Linking.Linking_Interface R) := TRANSFORM
	  SELF.dt_first_seen                := ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
			                                   ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
	  SELF.dt_last_seen                 := ut.LatestDate(L.dt_last_seen,R.dt_last_seen);
		SELF.company_name                 := IF(L.company_name = '', R.company_name, L.company_name);
	  SELF.company_address.prim_range   := IF(L.company_address.prim_range = '' AND (INTEGER)L.company_address.zip4 = 0, R.company_address.prim_range, L.company_address.prim_range);
	  SELF.company_address.predir       := IF(L.company_address.predir = '' AND (INTEGER)L.company_address.zip4 = 0, R.company_address.predir, L.company_address.predir);
	  SELF.company_address.prim_name    := IF(L.company_address.prim_name = '' AND (INTEGER)L.company_address.zip4 = 0, R.company_address.prim_name, L.company_address.prim_name);
	  SELF.company_address.addr_suffix  := IF(L.company_address.addr_suffix = '' AND (INTEGER)L.company_address.zip4 = 0, R.company_address.addr_suffix, L.company_address.addr_suffix);
	  SELF.company_address.postdir      := IF(L.company_address.postdir = '' AND (INTEGER)L.company_address.zip4 = 0, R.company_address.postdir, L.company_address.postdir);
	  SELF.company_address.unit_desig   := IF(L.company_address.unit_desig = ''AND (INTEGER)L.company_address.zip4 = 0, R.company_address.unit_desig, L.company_address.unit_desig);
	  SELF.company_address.sec_range    := IF(L.company_address.sec_range = '' AND (INTEGER)L.company_address.zip4 = 0, R.company_address.sec_range, L.company_address.sec_range);
	  SELF.company_address.p_city_name  := IF(L.company_address.p_city_name = '' AND (INTEGER)L.company_address.zip4 = 0, R.company_address.p_city_name, L.company_address.p_city_name);
		SELF.company_address.v_city_name  := IF(L.company_address.v_city_name = '' AND (INTEGER)L.company_address.zip4 = 0, R.company_address.v_city_name, L.company_address.v_city_name);
	  SELF.company_address.st           := IF(L.company_address.st = '' AND (INTEGER)L.company_address.zip4 = 0, R.company_address.st, L.company_address.st);
	  SELF.company_address.zip          := IF((INTEGER)L.company_address.zip = 0 AND (INTEGER)L.company_address.zip4 = 0, R.company_address.zip, L.company_address.zip);
	  SELF.company_address.zip4         := IF((INTEGER)L.company_address.zip4 = 0, R.company_address.zip4, L.company_address.zip4);
		SELF.company_address.fips_state   := IF(L.company_address.fips_state = '' AND (INTEGER)L.company_address.zip4 = 0, R.company_address.fips_state, L.company_address.fips_state);
	  SELF.company_address.fips_county  := IF(L.company_address.fips_county = '' AND (INTEGER)L.company_address.zip4 = 0, R.company_address.fips_county, L.company_address.fips_county);
		SELF.company_address.geo_lat      := IF(L.company_address.geo_lat = '' AND (INTEGER)L.company_address.zip4 = 0, R.company_address.geo_lat, L.company_address.geo_lat);
	  SELF.company_address.geo_long     := IF(L.company_address.geo_long = '' AND (INTEGER)L.company_address.zip4 = 0, R.company_address.geo_long, L.company_address.geo_long);
	  SELF.company_address.msa          := IF(L.company_address.msa = '' AND (INTEGER)L.company_address.zip4 = 0, R.company_address.msa, L.company_address.msa);
	  SELF.company_address.geo_blk      := IF(L.company_address.geo_blk = '' AND (INTEGER)L.company_address.zip4 = 0, R.company_address.geo_blk, L.company_address.geo_blk);
		SELF.company_address.geo_match    := IF(L.company_address.geo_match = '' AND (INTEGER)L.company_address.zip4 = 0, R.company_address.geo_match, L.company_address.geo_match);
		SELF.company_address.err_stat     := IF(L.company_address.err_stat = '' AND (INTEGER)L.company_address.zip4 = 0, R.company_address.err_stat, L.company_address.err_stat);
		SELF := L;
	END;
   	
	dsAcft_rollup := ROLLUP(dsAcft_srt,
	                       LEFT.vl_id                          = RIGHT.vl_id AND
												 LEFT.company_name                   = RIGHT.company_name AND
												 LEFT.company_address.zip            = RIGHT.company_address.zip AND
												 LEFT.company_address.prim_range     = RIGHT.company_address.prim_range AND
												 LEFT.company_address.prim_name      = RIGHT.company_address.prim_name AND
												 LEFT.company_address.p_city_name    = RIGHT.company_address.p_city_name AND
												 LEFT.company_address.st             = RIGHT.company_address.st AND
												 (RIGHT.company_address.sec_range = '' OR LEFT.company_address.sec_range = RIGHT.company_address.sec_range),
												 RollupAcft(LEFT, RIGHT), LOCAL);
	
	dsAcft_dedup := DEDUP(SORT(dsAcft_rollup,RECORD,LOCAL),RECORD,LOCAL);
	
  RETURN dsAcft_dedup(~ut.isNumeric(TRIM(company_name,ALL)));
END;