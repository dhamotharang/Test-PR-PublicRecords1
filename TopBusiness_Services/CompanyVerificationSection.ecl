import  TopBusiness_Services, BIPv2, iesp, AutoStandardI,
        doxie, BIPV2_Best;

export CompanyVerificationSection := MODULE
export fn_fullView (
	dataset(topBusiness_services.CompanyVerificationSection_Layouts.rec_input) ds_in_data,
	TopBusiness_Services.layouts.rec_input_options in_options,
	AutoStandardI.DataRestrictionI.params in_mod	
	) := function	  
	
	 ds_in_data_deduped := dedup(ds_in_data,all);

	 // empty test dataset
	 	//fetch_level := 'D';
	 // get information from the best key.
	 ds_in_unique_ids_only := project(ds_in_data, 
	                            transform(BIPV2.IDlayouts.l_xlink_ids, 	
															 self.dotid := 0;
                               self.powid := 0;															 
															 self.empid := 0;															
															 self.proxweight := 0;
															 self.proxscore := 0;
															 // self.seleweight := 0;
															 // self.selescore := 0;
															 self.ultscore := 0;
															 self.ultweight := 0;
															 self.dotscore := 0;
															 self.dotweight := 0;
															 self.orgscore := 0;
															 self.orgweight := 0;
															 self.powscore := 0;
															 self.powweight := 0;
															 self.empscore := 0;
															 self.empweight := 0;																														 													
															 self := left, 														
															 ));
   FETCH_LEVEL := in_options.BusinessReportFetchLevel;															 
	 ds_initial_best := BIPV2_Best.Key_LinkIds.KFetch(
              ds_in_unique_ids_only,FETCH_LEVEL)(proxid = 0);	

  
	 ds_address := dataset([{ds_initial_best.company_address[1].company_prim_range,
													ds_initial_best.company_address[1].company_predir,
	                         ds_initial_best.company_address[1].company_prim_name,														                        																										
													ds_initial_best.company_address[1].company_addr_suffix,
													ds_initial_best.company_address[1].company_postdir,
													ds_initial_best.company_address[1].company_unit_desig,
													ds_initial_best.company_address[1].company_sec_range,
													'','',
														ds_initial_best.company_address[1].address_v_city_name,
														ds_initial_best.company_address[1].company_st,
														ds_initial_best.company_address[1].company_zip5,
														ds_initial_best.company_address[1].company_zip4,
														ds_initial_best.company_address[1].county_name,
														'',''}
	                          ],iesp.share.t_address);
		
	#stored('CompanyName',ds_initial_best.company_name[1].company_name);
	#stored('FEIN',ds_initial_best.company_fein[1].company_fein);
	#stored('Phone',ds_initial_best.company_phone[1].company_phone);
  
	
	iesp.ECL2ESP.SetInputAddress(ds_address[1]);  // this sets #stored for prim_name, prim_range
	                                                 // city, state, zip5
    // this pulls from stored values so setting all the stored values in line above
		//
			
		
			company_verification_raw := 
			       project(ds_in_data, 
						    transform( topbusiness_Services.CompanyVerificationSection_Layouts.rec_CompanyVerification_recordWLinkids,																 
			                           self.ultid := left.ultid;
																 self.orgid := left.orgid;
																 self.seleid := left.seleid;
																 self.proxid := left.proxid;
																 self.powid := left.powid;
																 self.empid := left.empid;
																 self.dotid := left.dotid;
																
														self := []));
														
          
													         				 																								      
   topbusiness_Services.CompanyVerificationSection_Layouts.rec_linkids_plus_companyVerificationRecord  
	rollup_rptdetail(	 
		   topBusiness_services.CompanyVerificationSection_Layouts.rec_companyVerification_recordWLinkids l,
	  dataset( topBusiness_services.companyVerificationSection_Layouts.rec_companyVerification_recordWLinkids) allrows) := transform
		
    self.acctno  := '';			
		self.proxid  := l.proxid;
		self.dotid   := l.dotid;
		self.ultid   := l.ultid;
		self.orgid   := l.orgid;
		self.seleid  := l.seleid;
		self.powid   := l.powid;
		self.empid   := l.empid;
		
		self := l;
	end;
 
  ds_all_grouped := group(sort(company_verification_raw ,  #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																								 record), #expand(BIPV2.IDmacros.mac_ListTop3Linkids())
																								 ); 
  ds_all_rptdetail_rolled := rollup(ds_all_grouped,
																 group,
																 rollup_rptdetail(left,rows(left)));
 
   ds_raw_data_wAcctno := join(ds_in_data,ds_all_rptdetail_rolled, // in_data has acctno on it
	                         BIPV2.IDmacros.mac_JoinTop3Linkids(),
														transform(TopBusiness_Services.CompanyVerificationSection_Layouts.rec_linkids_plus_CompanyVerificationRecord,
														   self.acctno   := left.acctno,
															 self          := right),
												left outer); // 1 out rec for every left (in_data) rec 																			 																		
																		 
    ds_final_results := rollup(group(sort(ds_raw_data_wAcctno,acctno),acctno),group,
		  transform(TopBusiness_Services.CompanyVerificationSection_Layouts.rec_Final,				
		   self := left));			
			 
			 // debug outputs.
			 // output(ds_in_data_deduped, named('ds_in_data_deduped'));
			 // output(ds_biid, named('ds_biid'));
			 // output(tmpcompany_verification_raw, named('tmpcompany_verification_raw'));
		   // output(ds_all_grouped, named('all_grouped'));
		   // output(ds_all_rptdetail_rolled, named('all_rptdetail_rolled'));
			 
     return ds_final_results;						 
  end; // function
	end; // module

