IMPORT mdr,business_header, _Validate, ut;

laybus := business_header.Layout_Business_Linking.Linking_Interface;

EXPORT as_business_linking(

	 BOOLEAN 								pUsingInBizHdr		= TRUE
	,BOOLEAN 								pUseOtherEnviron	= _Constants().IsDataland
	,DATASET(layouts.Base)	pDataset					= IF(pUsingInBizHdr
																								,files(,pUseOtherEnviron).base.BusinessHeader
																								,files(,pUseOtherEnviron).base.qa
																							)
	,STRING									pPersistname			= persistnames(									).AsBusinessLinking
	,DATASET(laybus				) pPersist 					= persists		(pUseOtherEnviron	).AsBusinessLinking
	,BOOLEAN                isPRCT            = FALSE
) :=
FUNCTION

	dasbh := PROJECT(pDataset,TRANSFORM(
		laybus,
	   	SELF.source                      := MDR.sourceTools.src_Credit_Unions;
			SELF.source_record_id						 := LEFT.source_rec_id;
	  	SELF.dt_first_seen               := IF(_Validate.Date.fIsValid((STRING)LEFT.dt_vendor_first_reported),LEFT.dt_vendor_first_reported,0);	
      SELF.dt_last_seen                := IF(_Validate.Date.fIsValid((STRING)LEFT.dt_vendor_last_reported), LEFT.dt_vendor_last_reported,0);					
      SELF.dt_vendor_first_reported    := IF(_Validate.Date.fIsValid((STRING)LEFT.dt_vendor_first_reported),LEFT.dt_vendor_first_reported,0);	
      SELF.dt_vendor_last_reported     := IF(_Validate.Date.fIsValid((STRING)LEFT.dt_vendor_last_reported), LEFT.dt_vendor_last_reported,0);
      SELF.company_bdid                := LEFT.bdid;
      SELF.company_name                := IF(REGEXFIND('(CREDIT UNION|CREDIT UN|C U | C U|C[.]U[.]|C[.] U[.])',LEFT.cu_name,nocase)
																			    ,Stringlib.StringToUpperCase(LEFT.CU_NAME)
																			    ,TRIM(Stringlib.StringToUpperCase(LEFT.CU_NAME)) + ' CREDIT UNION'); 
      SELF.company_rawaid              := LEFT.raw_aid;
     	SELF.company_address.prim_range	 := LEFT.prim_range;
	    SELF.company_address.predir			 := LEFT.predir;
	    SELF.company_address.prim_name   := LEFT.prim_name;
	    SELF.company_address.addr_suffix := LEFT.addr_suffix;
	    SELF.company_address.postdir     := LEFT.postdir;
	    SELF.company_address.unit_desig	 := LEFT.unit_desig;
	    SELF.company_address.sec_range	 := LEFT.sec_range;
	    SELF.company_address.p_city_name := LEFT.p_city_name;
	    SELF.company_address.v_city_name := LEFT.v_city_name;
	    SELF.company_address.st					 := LEFT.st;
	    SELF.company_address.zip				 := LEFT.zip;
	    SELF.company_address.zip4				 := LEFT.zip4;
	    SELF.company_address.cart				 := LEFT.cart;
	    SELF.company_address.cr_sort_sz	 := LEFT.cr_sort_sz;
	    SELF.company_address.lot			   := LEFT.lot;
	    SELF.company_address.lot_order	 := LEFT.lot_order;
	    SELF.company_address.dbpc				 := LEFT.dbpc;
	    SELF.company_address.chk_digit   := LEFT.chk_digit;
	    SELF.company_address.rec_type		 := LEFT.rec_type;
	    SELF.company_address.fips_state	 := LEFT.fips_state;
	    SELF.company_address.fips_county := LEFT.fips_county;
	    SELF.company_address.geo_lat		 := LEFT.geo_lat;
	    SELF.company_address.geo_long		 := LEFT.geo_long;
	    SELF.company_address.msa				 := LEFT.msa;
	    SELF.company_address.geo_blk		 := LEFT.geo_blk;
	    SELF.company_address.geo_match	 := LEFT.geo_match;
	    SELF.company_address.err_stat		 := LEFT.err_stat;
      SELF.company_phone               := Business_Header.CleanPhone(LEFT.phone);
      SELF.phone_type                  := IF((INTEGER)SELF.company_phone = 0, '','T');
	    SELF.company_charter_number      := LEFT.charter;
      SELF.vl_id                       := TRIM(LEFT.state) + LEFT.charter;
      SELF.current                     := IF(LEFT.record_type = 'C',TRUE,FALSE);
			SELF.phone_score                 := IF((INTEGER)SELF.company_phone = 0, 0, 1);
			SELF.contact_name.title		  	   := LEFT.title;
	    SELF.contact_name.fname		  	   := LEFT.fname;		
	    SELF.contact_name.mname		       := LEFT.mname;		
	    SELF.contact_name.lname		       := LEFT.lname;		
	    SELF.contact_name.name_suffix	   := LEFT.name_suffix;
	    SELF.contact_name.name_score     := LEFT.name_score;	
		  SELF                             := [];
		));

  Business_Header.Layout_Business_Linking.Linking_Interface RollupCU(Business_Header.Layout_Business_Linking.Linking_Interface L, business_header.Layout_Business_Linking.Linking_Interface R) := TRANSFORM
	  SELF.dt_first_seen                := min(min(L.dt_first_seen,R.dt_first_seen),
			                                   min(L.dt_last_seen,R.dt_last_seen));
	  SELF.dt_last_seen                 := max(L.dt_last_seen,R.dt_last_seen);
		SELF.dt_vendor_first_reported     := min(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
	  SELF.dt_vendor_last_reported      := max(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
	  SELF.company_name                 := IF(L.company_name = '', R.company_name, L.company_name);
		SELF.source_record_id             := ut.Min2(l.source_record_id, r.source_record_id);
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
		SELF.contact_name.title		  	    := IF(l.contact_name.title = '',r.contact_name.title,l.contact_name.title);
	  SELF.contact_name.fname		  	    := IF(l.contact_name.fname = '', r.contact_name.fname, l.contact_name.fname);		
	  SELF.contact_name.mname		        := IF(l.contact_name.mname = '', r.contact_name.mname, l.contact_name.mname);		
	  SELF.contact_name.lname		        := IF(l.contact_name.lname = '', r.contact_name.lname, l.contact_name.lname);		
	  SELF.contact_name.name_suffix	    := IF(l.contact_name.name_suffix = '', r.contact_name.name_suffix, l.contact_name.name_suffix);
	  SELF := L;
	END;

  dasbh_dist := DISTRIBUTE(dasbh, HASH32(vl_id,company_name, company_address.zip, company_address.prim_range, company_address.prim_name));

	dasbh_sort := SORT(dasbh_dist, vl_id, company_name, company_address.zip, company_address.prim_range, 
	                                   company_address.prim_name, IF(company_address.sec_range <> '', 0, 1), company_address.sec_range,
																		 contact_name.lname, contact_name.fname, contact_name.mname,source_record_id,LOCAL);

	dasbh_Rollup := ROLLUP(dasbh_sort,
	                       LEFT.vl_id = RIGHT.vl_id AND
												 LEFT.company_address.zip = RIGHT.company_address.zip AND
												 LEFT.company_address.prim_range = RIGHT.company_address.prim_range AND
												 LEFT.company_address.prim_name = RIGHT.company_address.prim_name AND
												 LEFT.company_name = RIGHT.company_name AND
												 (RIGHT.company_address.sec_range = '' OR LEFT.company_address.sec_range = RIGHT.company_address.sec_range) AND
												 LEFT.contact_name.fname = RIGHT.contact_name.fname AND
												 LEFT.contact_name.mname = RIGHT.contact_name.mname AND
												 LEFT.contact_name.lname = RIGHT.contact_name.lname,
												 RollupCU(LEFT, RIGHT), 					                              	
												 LOCAL);
												 
  dasbh_Rollup_persist := ROLLUP(dasbh_sort,
	                       LEFT.vl_id = RIGHT.vl_id AND
												 LEFT.company_address.zip = RIGHT.company_address.zip AND
												 LEFT.company_address.prim_range = RIGHT.company_address.prim_range AND
												 LEFT.company_address.prim_name = RIGHT.company_address.prim_name AND
												 LEFT.company_name = RIGHT.company_name AND
												 (RIGHT.company_address.sec_range = '' OR LEFT.company_address.sec_range = RIGHT.company_address.sec_range) AND
												 LEFT.contact_name.fname = RIGHT.contact_name.fname AND
												 LEFT.contact_name.mname = RIGHT.contact_name.mname AND
												 LEFT.contact_name.lname = RIGHT.contact_name.lname,
												 RollupCU(LEFT, RIGHT), 					                              	
												 LOCAL) : PERSIST(pPersistname);

	dasbh_persisted := if(isPRCT,dasbh_Rollup_persist,dasbh_Rollup);
	
	RETURN dasbh_persisted;
END;