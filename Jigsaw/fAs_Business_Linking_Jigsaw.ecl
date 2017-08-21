IMPORT Business_Header, ut, Gong_v2, MDR, _Validate, Email_Data;

EXPORT fAs_Business_Linking_Jigsaw(

	 DATASET(Layouts.Base 								) pInput							= Files().base.qa
	,DATASET(Gong_v2.layout_gongMasterAid	) pGongMasterBase			= DATASET(gong_v2.thor_cluster+'base::gongv2_master',
					                                                            	Gong_v2.layout_gongMasterAid,THOR)
	,BOOLEAN																pShouldVerifyPhones = TRUE
	
) := FUNCTION
 	
	Layouts.Temporary.Jigsaw_AddTwoPhones AddPhone(Layouts.Base L) := TRANSFORM
		SELF                := L;
		SELF.business_phone := 0;
		SELF.person_phone   := 0;
	END;
	
	Jigsaw_Init := PROJECT(pInput, AddPhone(LEFT));
	
	Jigsaw_Init_Global := Jigsaw_Init : GLOBAL;

  //verify phones since they are unreliable
	bJigsaw_base	:= Verify_Phone2(Jigsaw_Init_Global,pGongMasterBase,'B');
	pJigsaw_base	:= Verify_Phone2(Jigsaw_Init_Global,pGongMasterBase,'P');
	
  bJigsaw_base_dedup := DEDUP(SORT(bJigsaw_base,RECORD,LOCAL));
  pJigsaw_base_dedup := DEDUP(SORT(pJigsaw_base,RECORD,LOCAL));
	
	jPutPhonesTogether := JOIN(
		 bJigsaw_base_dedup
		,pJigsaw_base_dedup
		,LEFT.rawfields.companyid = RIGHT.rawfields.companyid AND
	   LEFT.rawfields.contactid = RIGHT.rawfields.contactid
		,TRANSFORM(
			Layouts.Temporary.Jigsaw_AddTwoPhones,
			SELF.business_phone	:= (UNSIGNED6)LEFT.rawfields.Phone;
			SELF.person_phone		:= (UNSIGNED6)RIGHT.rawfields.Phone;
			SELF								:= LEFT;)
	);
	
	Jigsaw_Init_Global_Proj := PROJECT(Jigsaw_Init_Global
	   ,TRANSFORM(
		 Layouts.Temporary.Jigsaw_AddTwoPhones, 
	   SELF.business_phone := (UNSIGNED6)LEFT.rawfields.Phone;
		 SELF.person_phone   := (UNSIGNED6)LEFT.rawfields.Phone;
		 SELF                := LEFT));
	
	dJigsaw_Verify := IF(pShouldVerifyPhones = TRUE	,jPutPhonesTogether	,Jigsaw_Init_Global_Proj);
	
	Business_Header.Layout_Business_Linking.Linking_Interface	Translate_Jigsaw_To_BLF(Layouts.Temporary.Jigsaw_AddTwoPhones L) := TRANSFORM
			SELF.source											 := MDR.sourceTools.src_Jigsaw;
			SELF.dt_first_seen  				     := IF(_validate.date.fIsValid((STRING)L.dt_first_seen),
			                                      (UNSIGNED4)L.dt_first_seen,	0);
			SELF.dt_last_seen  					     := IF(_validate.date.fIsValid((STRING)L.dt_last_seen), 
																						(UNSIGNED4)L.dt_last_seen, 0);
		  SELF.dt_vendor_first_reported    := IF(_validate.date.fIsValid((STRING)L.dt_vendor_first_reported),
																						(UNSIGNED4)L.dt_vendor_first_reported, 0);
		  SELF.dt_vendor_last_reported     := IF(_validate.date.fIsValid((STRING)L.dt_vendor_last_reported),
																						(UNSIGNED4)L.dt_vendor_last_reported, 0);
			SELF.source_record_id            := L.source_rec_id;																			
			SELF.company_bdid                := (UNSIGNED6)L.bdid;	
			SELF.company_name							   := Stringlib.StringToUpperCase(L.rawfields.CompanyName);
			SELF.company_rawaid						   := L.raw_aid; 
		  SELF.company_address.prim_range  := L.clean_address.prim_range;
		  SELF.company_address.predir      := L.clean_address.predir;
		  SELF.company_address.prim_name   := L.clean_address.prim_name;
		  SELF.company_address.addr_suffix := L.clean_address.addr_suffix;
		  SELF.company_address.postdir     := L.clean_address.postdir;
		  SELF.company_address.unit_desig  := L.clean_address.unit_desig;
		  SELF.company_address.sec_range   := L.clean_address.sec_range;
		  SELF.company_address.p_city_name := L.clean_address.p_city_name; 
		  SELF.company_address.v_city_name := L.clean_address.v_city_name;
		  SELF.company_address.st          := L.clean_address.st;
		  SELF.company_address.zip         := L.clean_address.zip;
		  SELF.company_address.zip4        := L.clean_address.zip4;
		  SELF.company_address.cart        := L.clean_address.cart; 
		  SELF.company_address.cr_sort_sz  := L.clean_address.cr_sort_sz;
		  SELF.company_address.lot         := L.clean_address.lot; 
		  SELF.company_address.lot_order   := L.clean_address.lot_order; 		
		  SELF.company_address.dbpc        := L.clean_address.dbpc; 
		  SELF.company_address.chk_digit   := L.clean_address.chk_digit;
		  SELF.company_address.rec_type    := L.clean_address.rec_type; 			
		  SELF.company_address.fips_county := L.clean_address.fips_county;
			SELF.company_address.fips_state  := L.clean_address.fips_state;
			SELF.company_address.geo_lat     := L.clean_address.geo_lat;
		  SELF.company_address.geo_long    := L.clean_address.geo_long;
			SELF.company_address.msa         := L.clean_address.msa; 
		  SELF.company_address.geo_blk     := L.clean_address.geo_blk;
		  SELF.company_address.geo_match   := L.clean_address.geo_match;
		  SELF.company_address.err_stat    := L.clean_address.err_stat;
			SELF.company_phone               := Business_Header.CleanPhone((STRING)L.business_phone); 
			SELF.phone_type     						 := IF((INTEGER)SELF.company_phone = 0, '', 'T');
			SELF.company_url                 := TRIM(Stringlib.StringToUpperCase(L.rawfields.companyurl));	
		  SELF.vl_id                       := TRIM(L.rawfields.CompanyId) + '-' + TRIM(L.rawfields.ContactId); 
			SELF.current										 := IF(L.record_type = 'C', TRUE, FALSE);
			SELF.glb												 := FALSE;
		  SELF.dppa										     := FALSE;
		  SELF.is_contact                  := FALSE; //Will be set during linking
			SELF.contact_name.title          := L.clean_name.title; 	
		  SELF.contact_name.fname          := L.clean_name.fname; 		
		  SELF.contact_name.mname          := L.clean_name.mname; 		
		  SELF.contact_name.lname          := L.clean_name.lname; 		
		  SELF.contact_name.name_suffix    := L.clean_name.name_suffix; 		
		  SELF.contact_name.name_score     := L.clean_name.name_score; 
			SELF.contact_job_title_raw       := TRIM(Stringlib.StringToUpperCase(L.rawfields.title));
		  SELF.contact_phone               := (STRING)L.person_phone; 
			SELF.contact_email               := TRIM(Stringlib.StringToUpperCase(L.rawfields.email)); 
			SELF.contact_email_username      := Email_Data.fn_clean_email_username(SELF.contact_email);
      SELF.contact_email_domain        := Email_Data.fn_clean_email_domain(SELF.contact_email);
		  SELF 														 := L;
		  SELF 														 := [];
	END;
	
	Jigsaw_proj   := PROJECT(dJigsaw_Verify,Translate_Jigsaw_To_BLF(LEFT));
	
	Business_Header.Layout_Business_Linking.Linking_Interface RollupJigsaw(Business_Header.Layout_Business_Linking.Linking_Interface L, Business_Header.Layout_Business_Linking.Linking_Interface R) := TRANSFORM
		SELF.dt_first_seen                := ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
			                                   ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
	  SELF.dt_last_seen                 := max(L.dt_last_seen,R.dt_last_seen);
		SELF.dt_vendor_first_reported     := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
	  SELF.dt_vendor_last_reported      := max(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
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
		SELF.contact_phone                := IF((INTEGER)L.contact_phone = 0, R.contact_phone, L.contact_phone);
		SELF := L;
	END;
   	
	Jigsaw_rollup := ROLLUP(Jigsaw_proj,
	                       LEFT.vl_id                          = RIGHT.vl_id AND
												 LEFT.company_name                   = RIGHT.company_name AND
												 LEFT.company_address.zip            = RIGHT.company_address.zip AND
												 LEFT.company_address.prim_range     = RIGHT.company_address.prim_range AND
												 LEFT.company_address.prim_name      = RIGHT.company_address.prim_name AND
												 LEFT.company_address.p_city_name    = RIGHT.company_address.p_city_name AND
												 LEFT.company_address.st             = RIGHT.company_address.st AND
												 (RIGHT.company_address.sec_range = '' OR LEFT.company_address.sec_range = RIGHT.company_address.sec_range) AND
												 LEFT.contact_name.fname             = RIGHT.contact_name.fname AND 		
		                     LEFT.contact_name.mname             = RIGHT.contact_name.mname AND 		
		                     LEFT.contact_name.lname             = RIGHT.contact_name.lname, 
												 RollupJigsaw(LEFT, RIGHT), LOCAL);
  	
	Jigsaw_dedup  := DEDUP(SORT(Jigsaw_rollup,RECORD,LOCAL),RECORD,LOCAL);
	
	RETURN Jigsaw_dedup(company_name <> '');
END;