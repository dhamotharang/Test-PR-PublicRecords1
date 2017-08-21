IMPORT business_header,dea,mdr, ut, _Validate;

EXPORT fDEA_As_Business_Linking(

	DATASET(DEA.layout_dea_out_basev2) pDEA = DEA.File_DEAv2
	
)
 :=
  FUNCTION
	
	  inf    := pDEA;
	  outrec := Business_Header.Layout_Business_Linking.Linking_Interface;
		
		outrec Translate_DEA_to_BLF(inf L)  := TRANSFORM
		  SELF.source                       := MDR.sourceTools.src_Dea;      
	  	SELF.dt_first_seen 	              := IF(_Validate.Date.fIsValid(l.date_first_reported), (UNSIGNED4)l.date_first_reported,0);
      SELF.dt_last_seen                 := IF(_Validate.Date.fIsValid(l.date_last_reported),  (UNSIGNED4)l.date_last_reported, 0);				
      SELF.dt_vendor_first_reported     := IF(_Validate.Date.fIsValid(l.date_first_reported), (UNSIGNED4)l.date_first_reported,0);
      SELF.dt_vendor_last_reported      := IF(_Validate.Date.fIsValid(l.date_last_reported),  (UNSIGNED4)l.date_last_reported, 0);    	
      SELF.company_bdid                 := (INTEGER)L.bdid;
      SELF.company_name                 := Stringlib.StringToUpperCase(L.cname);
			SELF.company_address_type_raw     := 'CC';
      SELF.company_address.prim_range	  := L.prim_range;
	    SELF.company_address.predir			  := L.predir;
	    SELF.company_address.prim_name    := L.prim_name;
	    SELF.company_address.addr_suffix  := L.addr_suffix;
	    SELF.company_address.postdir		  := L.postdir;
	    SELF.company_address.unit_desig   := L.unit_desig;
	    SELF.company_address.sec_range    := L.sec_range;
	    SELF.company_address.p_city_name  := L.p_city_name;	
	    SELF.company_address.v_city_name  := L.v_city_name;
	    SELF.company_address.st					  := L.st;
	    SELF.company_address.zip		 		  := L.zip;
	    SELF.company_address.zip4				  := L.zip4;
	    SELF.company_address.cart				  := L.cart;
	    SELF.company_address.cr_sort_sz	  := L.cr_sort_sz;
	    SELF.company_address.lot				  := L.lot;
	    SELF.company_address.lot_order	  := L.lot_order;
	    SELF.company_address.dbpc				  := L.dbpc;
	    SELF.company_address.chk_digit		:= L.chk_digit;
	    SELF.company_address.rec_type			:= L.rec_type;
	    SELF.company_address.fips_state		:= L.county[1..2];
	    SELF.company_address.fips_county	:= L.county[3..5];
	    SELF.company_address.geo_lat			:= L.geo_lat;
	    SELF.company_address.geo_long			:= L.geo_long;
	    SELF.company_address.msa					:= L.msa;
	    SELF.company_address.geo_blk			:= L.geo_blk;
	    SELF.company_address.geo_match		:= L.geo_match;
	    SELF.company_address.err_stat			:= L.err_stat;
      SELF.vl_id                        := L.dea_registration_number;
			SELF.source_record_id							:= L.source_rec_id;
      SELF.current                      := TRUE;
 			SELF.contact_name.title		    		:= L.title;
	    SELF.contact_name.fname			    	:= L.fname;
	    SELF.contact_name.mname			    	:= L.mname;
	    SELF.contact_name.lname			    	:= L.lname;
	    SELF.contact_name.name_suffix   	:= L.name_suffix;
	    SELF.contact_name.name_score	    := L.name_score;
      SELF                              := [];
		END;
				
		Business_Header.Layout_Business_Linking.Linking_Interface RollupDEA(Business_Header.Layout_Business_Linking.Linking_Interface L, business_header.Layout_Business_Linking.Linking_Interface R) := TRANSFORM
	    SELF.dt_first_seen                := ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
			                                     ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
	    SELF.dt_last_seen                 := ut.LatestDate(L.dt_last_seen,R.dt_last_seen);
		  SELF.dt_vendor_first_reported     := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
	    SELF.dt_vendor_last_reported      := ut.LatestDate(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
	    SELF.company_name                 := IF(L.company_name = '', R.company_name, L.company_name);
	    SELF.company_address.prim_range   := IF(l.company_address.prim_range = '' AND (INTEGER)l.company_address.zip4 = 0, r.company_address.prim_range, l.company_address.prim_range);
	    SELF.company_address.predir       := IF(l.company_address.predir = '' AND (INTEGER)l.company_address.zip4 = 0, r.company_address.predir, l.company_address.predir);
	    SELF.company_address.prim_name    := IF(l.company_address.prim_name = '' AND (INTEGER)l.company_address.zip4 = 0, r.company_address.prim_name, l.company_address.prim_name);
	    SELF.company_address.addr_suffix  := IF(l.company_address.addr_suffix = '' AND (INTEGER)l.company_address.zip4 = 0, r.company_address.addr_suffix, l.company_address.addr_suffix);
	    SELF.company_address.postdir      := IF(l.company_address.postdir = '' AND (INTEGER)l.company_address.zip4 = 0, r.company_address.postdir, l.company_address.postdir);
	    SELF.company_address.unit_desig   := IF(l.company_address.unit_desig = ''AND (INTEGER)l.company_address.zip4 = 0, r.company_address.unit_desig, l.company_address.unit_desig);
	    SELF.company_address.sec_range    := IF(l.company_address.sec_range = '' AND (INTEGER)l.company_address.zip4 = 0, r.company_address.sec_range, l.company_address.sec_range);
	    SELF.company_address.p_city_name  := IF(l.company_address.p_city_name = '' AND (INTEGER)l.company_address.zip4 = 0, r.company_address.p_city_name, l.company_address.p_city_name);
		  SELF.company_address.v_city_name  := IF(l.company_address.v_city_name = '' AND (INTEGER)l.company_address.zip4 = 0, r.company_address.v_city_name, l.company_address.v_city_name);
	    SELF.company_address.st           := IF(l.company_address.st = '' AND (INTEGER)l.company_address.zip4 = 0, r.company_address.st, l.company_address.st);
	    SELF.company_address.zip          := IF((INTEGER)l.company_address.zip = 0 AND (INTEGER)l.company_address.zip4 = 0, r.company_address.zip, l.company_address.zip);
	    SELF.company_address.zip4         := IF((INTEGER)l.company_address.zip4 = 0, r.company_address.zip4, l.company_address.zip4);
		  SELF.company_address.fips_state   := IF(l.company_address.fips_state = '' AND (INTEGER)l.company_address.zip4 = 0, r.company_address.fips_state, l.company_address.fips_state);
	    SELF.company_address.fips_county  := IF(l.company_address.fips_county = '' AND (INTEGER)l.company_address.zip4 = 0, r.company_address.fips_county, l.company_address.fips_county);
		  SELF.company_address.geo_lat      := IF(l.company_address.geo_lat = '' AND (INTEGER)l.company_address.zip4 = 0, r.company_address.geo_lat, l.company_address.geo_lat);
	    SELF.company_address.geo_long     := IF(l.company_address.geo_long = '' AND (INTEGER)l.company_address.zip4 = 0, r.company_address.geo_long, l.company_address.geo_long);
	    SELF.company_address.msa          := IF(l.company_address.msa = '' AND (INTEGER)l.company_address.zip4 = 0, r.company_address.msa, l.company_address.msa);
	    SELF                              := L;
	  END;
		
	  outf        := PROJECT(inf(cname <> ''), Translate_DEA_to_BLF(LEFT));
		outf_dist   := DISTRIBUTE(outf, HASH(vl_id));
		outf_sort   := SORT(outf_dist,vl_id,company_name,company_address.st,company_address.zip,company_address.prim_name,LOCAL);
		
		outf_Rollup := ROLLUP(outf_sort,
	                        LEFT.vl_id = RIGHT.vl_id AND
												  LEFT.company_address.zip = RIGHT.company_address.zip AND
												  LEFT.company_address.prim_range = RIGHT.company_address.prim_range AND
												  LEFT.company_address.prim_name = RIGHT.company_address.prim_name AND
												  LEFT.company_name = RIGHT.company_name AND
												  (RIGHT.company_address.sec_range = '' OR LEFT.company_address.sec_range = RIGHT.company_address.sec_range) AND
													LEFT.company_address.geo_lat = RIGHT.company_address.geo_lat AND
													LEFT.company_address.geo_long = RIGHT.company_address.geo_long AND
													LEFT.company_address.lot = RIGHT.company_address.lot,
												  RollupDEA(LEFT, RIGHT), 					                              	
												  LOCAL);

	  RETURN outf_Rollup;
	END;