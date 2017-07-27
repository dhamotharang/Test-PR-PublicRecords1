IMPORT BIPV2, ut, mdr, _Validate;

EXPORT Fl_Non_Profit_As_Business_Linking_Contact (DATASET(govdata.Layout_FL_Non_Profit_Corp_base) pBase = govdata.File_FL_NonProfit_Corp) := FUNCTION

		DDMMYYYY_2_YYYYMMDD(STRING8 s) := (INTEGER)(s[5..8] + s[3..4] + s[1..2]);
		firstDate(govdata.Layout_FL_Non_Profit_Corp_base l) := ut.Min2(
																	ut.Min2(DDMMYYYY_2_YYYYMMDD(l.annual_report_date_1), 
																	DDMMYYYY_2_YYYYMMDD(l.annual_report_date_2)),
																	ut.Min2(DDMMYYYY_2_YYYYMMDD(l.annual_report_date_3),
																	DDMMYYYY_2_YYYYMMDD(l.annual_cor_file_date)));
		lastDate(govdata.Layout_FL_Non_Profit_Corp_base l)  := ut.Max2(
																	ut.Max2(DDMMYYYY_2_YYYYMMDD(l.annual_report_date_1), 
																	DDMMYYYY_2_YYYYMMDD(l.annual_report_date_2)),
																	ut.Max2(DDMMYYYY_2_YYYYMMDD(l.annual_report_date_3),
																	DDMMYYYY_2_YYYYMMDD(l.annual_last_trx_date))); 

	  //CONTACT MAPPING
		BIPV2.Layout_Business_Linking_Full trfMAPBLInterface(govdata.Layout_FL_Non_Profit_Corp_base l, INTEGER C) := TRANSFORM
        SELF.source                      	:= mdr.sourceTools.src_FL_Non_Profit; 
				SELF.dt_first_seen              	:= firstDate(L);
				SELF.dt_last_seen               	:= lastDate(L);
				SELF.company_bdid			   	       	:= l.bdid;
				SELF.company_name 			         	:= l.ANNUAL_COR_NAME;
				SELF.company_address.prim_range 	:= CHOOSE(C, L.princ1_prim_range, L.princ2_prim_range, L.princ3_prim_range, 
																								L.princ4_prim_range, L.princ5_prim_range, L.princ6_prim_range);
				SELF.company_address.predir 			:= CHOOSE(C, L.princ1_predir, L.princ2_predir, L.princ3_predir, 
																								L.princ4_predir, L.princ5_predir, L.princ6_predir);
				SELF.company_address.prim_name 		:= CHOOSE(C, L.princ1_prim_name, L.princ2_prim_name, L.princ3_prim_name,
																								L.princ4_prim_name, L.princ5_prim_name, L.princ6_prim_name);
				SELF.company_address.addr_suffix 	:= CHOOSE(C, L.princ1_addr_suffix, L.princ2_addr_suffix, L.princ3_addr_suffix, 
																								L.princ4_addr_suffix, L.princ5_addr_suffix, L.princ6_addr_suffix);
				SELF.company_address.postdir 			:= CHOOSE(C, L.princ1_postdir, L.princ2_postdir, L.princ3_postdir,
																								L.princ4_postdir, L.princ5_postdir, L.princ6_postdir);
				SELF.company_address.unit_desig 	:= CHOOSE(C, L.princ1_unit_desig, L.princ2_unit_desig, L.princ3_unit_desig, 
																								L.princ4_unit_desig, L.princ5_unit_desig, L.princ6_unit_desig);
				SELF.company_address.sec_range 		:= CHOOSE(C, L.princ1_sec_range, L.princ2_sec_range, L.princ3_sec_range, 
																								L.princ4_sec_range, L.princ5_sec_range, L.princ6_sec_range);
				SELF.company_address.p_city_name	:= CHOOSE(C, L.princ1_p_city_name, L.princ2_p_city_name, L.princ3_p_city_name, 
																								L.princ4_p_city_name, L.princ5_p_city_name, L.princ6_p_city_name);											
				SELF.company_address.v_city_name	:= CHOOSE(C, L.princ1_v_city_name, L.princ2_v_city_name, L.princ3_v_city_name, 
																								L.princ4_v_city_name, L.princ5_v_city_name, L.princ6_v_city_name);
				SELF.company_address.st 					:= CHOOSE(C, L.princ1_st, L.princ2_st, L.princ3_st, 
																								L.princ4_st, L.princ5_st, L.princ6_st);
				SELF.company_address.zip 					:= CHOOSE(C, L.princ1_zip, L.princ2_zip, L.princ3_zip, 
																								L.princ4_zip, L.princ5_zip, L.princ6_zip);
				SELF.company_address.zip4 				:= CHOOSE(C, L.princ1_zip4, L.princ2_zip4, L.princ3_zip4, 
																								L.princ4_zip4, L.princ5_zip4, L.princ6_zip4);				
				SELF.company_phone              	:= '';
				SELF.phone_type                 	:= '';
				SELF.contact_name.title 					:= CHOOSE(C, L.princ1_title, L.princ2_title, L.princ3_title, 
																								L.princ4_title, L.princ5_title, L.princ6_title);
				SELF.contact_name.fname 					:= CHOOSE(C, L.princ1_fname, L.princ2_fname, L.princ3_fname, 
																								L.princ4_fname, L.princ5_fname, L.princ6_fname);
				SELF.contact_name.mname 					:= CHOOSE(C, L.princ1_mname, L.princ2_mname, L.princ3_mname, 
																								L.princ4_mname, L.princ5_mname, L.princ6_mname);
				SELF.contact_name.lname 					:= CHOOSE(C, L.princ1_lname, L.princ2_lname, L.princ3_lname, 
																								L.princ4_lname, L.princ5_lname, L.princ6_lname);
				SELF.contact_name.name_suffix 		:= CHOOSE(C, L.princ1_name_suffix, L.princ2_name_suffix, L.princ3_name_suffix, 
																								L.princ4_name_suffix, L.princ5_name_suffix, L.princ6_name_suffix);
				SELF.contact_email              	:= '';
				SELF.contact_phone              	:= '';
				SELF 							   							:= l;
				SELF 							   							:= [];
		end;																										
		from_MH_norm	:= NORMALIZE(pBase, 6, trfMAPBLInterface(LEFT,COUNTER));

	  BIPV2.Layout_Business_Linking_Full RollupMH(BIPV2.Layout_Business_Linking_Full L, 
                                                BIPV2.Layout_Business_Linking_Full R) := TRANSFORM
		  SELF.dt_first_seen               := ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
					                                ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
		  SELF.dt_last_seen                := ut.LatestDate(L.dt_last_seen,R.dt_last_seen);
		  SELF.dt_vendor_first_reported    := ut.EarliestDate(ut.EarliestDate(L.dt_vendor_first_reported,R.dt_vendor_first_reported),
					                                ut.EarliestDate(L.dt_vendor_last_reported,R.dt_vendor_last_reported));
		  SELF.dt_vendor_last_reported     := ut.LatestDate(L.dt_vendor_last_reported,R.dt_vendor_last_reported);
		  SELF.company_address.prim_range  := IF(L.company_address.prim_range  <> '', L.company_address.prim_range,  R.company_address.prim_range);
			SELF.company_address.predir      := IF(L.company_address.predir      <> '', L.company_address.predir,      R.company_address.predir);
			SELF.company_address.prim_name   := IF(L.company_address.prim_name   <> '', L.company_address.prim_name,   R.company_address.prim_name);
			SELF.company_address.addr_suffix := IF(L.company_address.addr_suffix <> '', L.company_address.addr_suffix, R.company_address.addr_suffix);
			SELF.company_address.postdir     := IF(L.company_address.postdir     <> '', L.company_address.postdir,     R.company_address.postdir);
			SELF.company_address.unit_desig  := IF(L.company_address.unit_desig  <> '', L.company_address.unit_desig,  R.company_address.unit_desig);
			SELF.company_address.sec_range   := IF(L.company_address.sec_range   <> '', L.company_address.sec_range,   R.company_address.sec_range);
			SELF.company_address.p_city_name := IF(L.company_address.p_city_name <> '', L.company_address.p_city_name, R.company_address.p_city_name);
			SELF.company_address.v_city_name := IF(L.company_address.v_city_name <> '', L.company_address.v_city_name, R.company_address.v_city_name);
			SELF.company_address.st          := IF(L.company_address.st          <> '', L.company_address.st,          R.company_address.st);
			SELF.company_address.zip	       := IF(L.company_address.zip         <> '', L.company_address.zip,         R.company_address.zip);
			SELF.company_address.zip4        := IF(L.company_address.zip4        <> '', L.company_address.zip4,        R.company_address.zip4);
		  SELF                             := L;
	  END;
		
    from_MH_dist   := DISTRIBUTE(from_MH_norm,HASH(company_bdid,company_name));
    from_MH_sort   := SORT(from_MH_dist, company_bdid, company_name, company_address.st, 
                           company_address.p_city_name, company_address.zip, company_address.prim_range,
                           company_address.predir, company_address.prim_name, company_address.addr_suffix,
                           company_address.postdir, company_address.unit_desig, contact_name.lname, 
                           contact_name.fname, contact_name.mname, contact_name.name_suffix, 
                           contact_name.title, -dt_last_seen,
                           LOCAL);
		from_MH_rollup := ROLLUP(from_MH_sort, 
                             LEFT.company_bdid									= RIGHT.company_bdid AND
                             LEFT.company_name                	= RIGHT.company_name AND
                             (LEFT.company_address.st 					= '' OR 	
														  RIGHT.company_address.st 					= '' OR
                              LEFT.company_address.st 					= RIGHT.company_address.st) AND
                             (LEFT.company_address.p_city_name 	= '' OR 
															RIGHT.company_address.p_city_name = '' OR
                              LEFT.company_address.p_city_name 	= RIGHT.company_address.p_city_name) AND
                             (LEFT.company_address.v_city_name 	= '' OR 
															RIGHT.company_address.v_city_name = '' OR
                              LEFT.company_address.v_city_name 	= RIGHT.company_address.v_city_name) AND
                             (LEFT.company_address.zip 					= '' OR 
															RIGHT.company_address.zip 				= '' OR
                              LEFT.company_address.zip 					= RIGHT.company_address.zip) AND
                             (LEFT.company_address.prim_range 	= '' OR 
															RIGHT.company_address.prim_range 	= '' OR
                              LEFT.company_address.prim_range 	= RIGHT.company_address.prim_range) AND
                             (LEFT.company_address.predir 			= '' OR 
															RIGHT.company_address.predir 			= '' OR
                              LEFT.company_address.predir 			= RIGHT.company_address.predir) AND
                             (LEFT.company_address.prim_name 		= '' OR 
															RIGHT.company_address.prim_name 	= '' OR
                              LEFT.company_address.prim_name 		= RIGHT.company_address.prim_name) AND
                             (LEFT.company_address.addr_suffix 	= '' OR 
															RIGHT.company_address.addr_suffix = '' OR
                              LEFT.company_address.addr_suffix 	= RIGHT.company_address.addr_suffix) AND
                             (LEFT.company_address.postdir			= '' OR 
															RIGHT.company_address.postdir 		= '' OR
                              LEFT.company_address.postdir 			= RIGHT.company_address.postdir) AND
                             (LEFT.company_address.unit_desig 	= '' OR 
															RIGHT.company_address.unit_desig 	= '' OR
                              LEFT.company_address.unit_desig 	= RIGHT.company_address.unit_desig) AND
															LEFT.contact_name.lname          	= RIGHT.contact_name.lname AND
															LEFT.contact_name.fname          	= RIGHT.contact_name.fname AND
															LEFT.contact_name.mname          	= RIGHT.contact_name.mname AND
															LEFT.contact_name.name_suffix    	= RIGHT.contact_name.name_suffix,
                             RollupMH(LEFT, RIGHT),
                             LOCAL);
    
    //Returning records that have a company name and either an address or phone
		RETURN from_MH_rollup(company_name != '' AND ((company_address.prim_name != '' OR company_address.p_city_name != '' OR
                                                  company_address.v_city_name != '' OR company_address.st != '' OR company_address.zip != '')
							            )
                          );
END;