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
      SELF.company_name                := IF(REGEXFIND('(CREDIT UNION|CREDIT UN|C U | C U|C[.]U[.]|C[.] U[.])',LEFT.rawfields.cu_name,nocase)
																			    ,Stringlib.StringToUpperCase(LEFT.rawfields.CU_NAME)
																			    ,TRIM(Stringlib.StringToUpperCase(LEFT.rawfields.CU_NAME)) + ' CREDIT UNION'); 
      SELF.company_rawaid              := LEFT.raw_aid;
     	SELF.company_address.prim_range	 := LEFT.clean_address.prim_range;
	    SELF.company_address.predir			 := LEFT.clean_address.predir;
	    SELF.company_address.prim_name   := LEFT.clean_address.prim_name;
	    SELF.company_address.addr_suffix := LEFT.clean_address.addr_suffix;
	    SELF.company_address.postdir     := LEFT.clean_address.postdir;
	    SELF.company_address.unit_desig	 := LEFT.clean_address.unit_desig;
	    SELF.company_address.sec_range	 := LEFT.clean_address.sec_range;
	    SELF.company_address.p_city_name := LEFT.clean_address.p_city_name;
	    SELF.company_address.v_city_name := LEFT.clean_address.v_city_name;
	    SELF.company_address.st					 := LEFT.clean_address.st;
	    SELF.company_address.zip				 := LEFT.clean_address.zip;
	    SELF.company_address.zip4				 := LEFT.clean_address.zip4;
	    SELF.company_address.cart				 := LEFT.clean_address.cart;
	    SELF.company_address.cr_sort_sz	 := LEFT.clean_address.cr_sort_sz;
	    SELF.company_address.lot			   := LEFT.clean_address.lot;
	    SELF.company_address.lot_order	 := LEFT.clean_address.lot_order;
	    SELF.company_address.dbpc				 := LEFT.clean_address.dbpc;
	    SELF.company_address.chk_digit   := LEFT.clean_address.chk_digit;
	    SELF.company_address.rec_type		 := LEFT.clean_address.rec_type;
	    SELF.company_address.fips_state	 := LEFT.clean_address.fips_state;
	    SELF.company_address.fips_county := LEFT.clean_address.fips_county;
	    SELF.company_address.geo_lat		 := LEFT.clean_address.geo_lat;
	    SELF.company_address.geo_long		 := LEFT.clean_address.geo_long;
	    SELF.company_address.msa				 := LEFT.clean_address.msa;
	    SELF.company_address.geo_blk		 := LEFT.clean_address.geo_blk;
	    SELF.company_address.geo_match	 := LEFT.clean_address.geo_match;
	    SELF.company_address.err_stat		 := LEFT.clean_address.err_stat;
      SELF.company_phone               := Business_Header.CleanPhone(LEFT.rawfields.phone);
      SELF.phone_type                  := IF((INTEGER)SELF.company_phone = 0, '','T');
	    SELF.company_charter_number      := LEFT.rawfields.charter;
      SELF.vl_id                       := TRIM(LEFT.rawfields.state) + LEFT.rawfields.charter;
      SELF.current                     := IF(LEFT.record_type = 'C',TRUE,FALSE);
			SELF.phone_score                 := IF((INTEGER)SELF.company_phone = 0, 0, 1);
			SELF.contact_name.title		  	   := LEFT.clean_contact_name.title;
	    SELF.contact_name.fname		  	   := LEFT.clean_contact_name.fname;		
	    SELF.contact_name.mname		       := LEFT.clean_contact_name.mname;		
	    SELF.contact_name.lname		       := LEFT.clean_contact_name.lname;		
	    SELF.contact_name.name_suffix	   := LEFT.clean_contact_name.name_suffix;
	    SELF.contact_name.name_score     := LEFT.clean_contact_name.name_score;	
		  SELF                             := [];
		));

  Business_Header.Layout_Business_Linking.Linking_Interface RollupCU(Business_Header.Layout_Business_Linking.Linking_Interface L, business_header.Layout_Business_Linking.Linking_Interface R) := TRANSFORM
	  SELF.dt_first_seen                := ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
			                                   ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
	  SELF.dt_last_seen                 := ut.LatestDate(L.dt_last_seen,R.dt_last_seen);
		SELF.dt_vendor_first_reported     := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
	  SELF.dt_vendor_last_reported      := ut.LatestDate(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
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
	  //SELF.contact_name.name_score      := IF((INTEGER)l.contact_name.name_score = 0, r.contact_name.name_score, l.contact_name.name_score);	
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

	dasbh_persisted := dasbh_rollup : PERSIST(pPersistname);
	
	RETURN dasbh_persisted;
END;