import TopBusiness_services, iesp, BIPv2, dx_Property, Census_Data, MDR, Foreclosure_Services, std;


export foreclosureNODSection := module

//situs1 is property address, situs2 is mailing addr		

export Fn_fullView(
      dataset(Topbusiness_services.ForeclosureNODSection_layouts.rec_Input) ds_in_data,		   				
			 string1 FETCH_LEVEL,
			 boolean IncludeVendorSourceB
			)  := function
			
		in_data_deduped := dedup(sort(ds_in_data,
		                         #expand(BIPV2.IDmacros.mac_ListTop3Linkids())
		                                   ),
										#expand(BIPV2.IDmacros.mac_ListTop3Linkids())
		);
     
     foreclosure_linkids_raw := TopBusiness_Services.Key_Fetches(
	                        project(in_data_deduped, 
	                        transform(BIPV2.IDlayouts.l_xlink_ids,
													self := left,
													self := [])),
													 FETCH_LEVEL,TopBusiness_Services.Constants.ForeclosureNODKfetchMaxLimit
													 ).ds_fc_linkidskey_recs;
     foreclosure_linkids_rawSlim := Dedup(sort(foreclosure_linkids_raw,foreclosure_id), foreclosure_id);												 
													 
     nod_linkids_raw := TopBusiness_Services.Key_Fetches(
	                          project(in_data_deduped, 
	                        transform(BIPV2.IDlayouts.l_xlink_ids,
													self := left,
													self := [])),
													 FETCH_LEVEL, TopBusiness_Services.Constants.ForeclosureNODKfetchMaxLimit).ds_nod_linkidskey_recs;		       
  
	    nod_linkids_rawSlim := Dedup(sort(nod_linkids_raw,foreclosure_id), foreclosure_id);												 
													 
			 
     foreclosure_linkids_payload := join(foreclosure_linkids_rawSlim,dx_Property.Key_Foreclosures_FID,		                                        
		                      keyed(left.foreclosure_id = right.fid) //AND RIGHT.source=MDR.sourceTools.src_Foreclosures,																										
																								AND right.source IN Foreclosure_Services.Functions.getCodes(IncludeVendorSourceB),
													transform({iesp.share.t_businessIdentity;recordof(right);},
													         self.ultid := left.ultid;
																	 self.orgid := left.orgid;
																	 self.seleid := left.seleid;
																	 self.proxid := left.proxid;
																	 self.powid := left.powid;
																	 self.empid := left.empid;
																	 self.dotid := left.dotid;
													self := right;
													),
													limit(0),keep(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_FORECLOSURE_NODS));
				
    nod_linkids_payload := join(nod_linkids_rawSlim, dx_Property.Key_NOD_FID,
		                        keyed(left.foreclosure_id = right.fid) //AND RIGHT.source=MDR.sourceTools.src_Foreclosures,
																										AND right.source IN Foreclosure_Services.Functions.getCodes(IncludeVendorSourceB),
															transform({iesp.share.t_businessIdentity;recordof(right);},
													         self.ultid := left.ultid;
																	 self.orgid := left.orgid;
																	 self.seleid := left.seleid;
																	 self.proxid := left.proxid;
																	 self.powid := left.powid;
																	 self.empid := left.empid;
																	 self.dotid := left.dotid;
													self := right;
													),
													limit(0),keep(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_FORECLOSURE_NODS));
				
    Foreclosure_raw := dedup(dedup(sort(foreclosure_linkids_payload(deed_category='U'), 
		               foreclosure_id), 
									   foreclosure_id),all, except foreclosure_id, fid, batch_date_and_seq_nbr, parcel_number_parcel_id,
										                     parcel_number_unmatched_id, zoning_code, lot_size, 
																				 current_land_value,current_improvement_value, lot_orig, expanded_legal);
										 
										 
    nod_raw := dedup(sort(nod_linkids_payload(deed_category='N'), foreclosure_id, recording_date,record),
		                          foreclosure_id,recording_date);

		foreclosure_partyDS := dedup(project(foreclosure_raw(deed_category='U'),		                        
																transform(
																   TopBusiness_Services.ForeclosureNODSection_layouts.linkids_plus_t_Biz_Foreclosure_rec,
																	self.ultid := left.ultid;
																	self.orgid := left.orgid;
																	self.seleid := left.seleid;
																	self.proxid := left.proxid;
																	self.powid := left.powid;
																	self.empid := left.empid;
																	self.dotid := left.dotid;				
																	self.ln_fares_id := '';
																	// set this from right
																	                                         																	
                                                                                           self.apn := trim(std.str.filter(left.parcel_number_unmatched_id,'0123456789'), left,right);																	
													                                                                                
																	self.recordingDate := iesp.ecl2esp.toDateString8(left.recording_date);
																					 
										 self.documentType := left.document_desc; // left.documentType;
															
                    self.deed_category := left.deed_category;
										// situs1 is property address, situs2 is mailing addr
										self.SiteAddress1 := iesp.ecl2esp.setAddress(left.situs1_prim_name,
																											left.situs1_prim_range,
																										left.situs1_predir,
																									   left.situs1_postdir,
																										left.situs1_addr_suffix,																									
																									left.situs1_unit_desig,
																										left.situs1_sec_range,
																								left.situs1_v_city_name,																									
																										left.situs1_st,
																										left.situs1_zip,'','');										 
										self.SiteAddress2 := iesp.ecl2esp.setAddress(left.situs2_prim_name,
																											left.situs2_prim_range,
																										left.situs2_predir,
																									   left.situs2_postdir,
																										left.situs2_addr_suffix,																									
																									left.situs2_unit_desig,
																										left.situs2_sec_range,
																								left.situs2_v_city_name,																									
																										left.situs2_st,
																										left.situs2_zip,'','');
																										
										self.AttorneyName := left.attorney_name;
										self.AttorneyPhoneNumber := left.attorney_phone_nbr;
										self.AuctionDate := iesp.ecl2esp.toDateString8(left.auction_date); // or is this Date on the mockup??
										
 									self.VendorSource := if(left.source=MDR.sourceTools.src_Foreclosures, Foreclosure_services.Constants('').src_Fares, 
																																																Foreclosure_services.Constants('').src_BlackKnight);
         	self.LenderType := left.lender_type;
         	self.LenderTypeDescription := left.lender_type_desc;
         	self.LoanAmount := left.loan_amount;
         	self.LoanType := left.loan_type;
         	self.LoanTypeDescription := left.loan_type_desc;

										self.LenderFirstName := left.lender_beneficiary_first_name;
										self.LenderLastName := left.lender_beneficiary_last_name;
										self.LenderCompanyName := left.lender_beneficiary_company_name;			
										self.PlaintiffName1 := if (trim(left.Plaintiff_1,left,right) <> 'OWNER_RECORD',
                                                   left.plaintiff_1, '');
										self.PlaintiffName2 := left.Plaintiff_2;									
										self.DefendantName1 :=  left.First_defendant_borrower_owner_last_name + ' ' + left.First_defendant_borrower_owner_first_name;						
										self.DefendantName2 :=  left.Second_defendant_borrower_owner_last_name + ' ' + left.Second_defendant_borrower_owner_first_name;
										self.DefendantName3 :=  left.Third_defendant_borrower_owner_last_name + ' ' + left.Third_defendant_borrower_owner_first_name;
									  self.DefendantName4 :=  left.Fourth_defendant_borrower_owner_last_name + ' ' + left.Fourth_defendant_borrower_owner_first_name;
										self.DefendantCompanyName1 := left.first_defendant_borrower_company_name;
										self.DefendantCompanyName2 := left.second_defendant_borrower_company_name;
										self.DefendantCompanyName3 := left.third_defendant_borrower_company_name;
										self.DefendantCompanyName4 := left.Fourth_defendant_borrower_company_name;																														
										self.address :=  iesp.ecl2esp.setAddress('','','','','','','','','','','','');
										self.isForeclosure := true;
										self.isNOD := false;
								
										
										self.FSourceDocs := dataset([transform(iesp.TopBusiness_share.t_TopBusinessSourceDocInfo,
						self.idType := 'foreclosure_id';
						self.IDvalue := left.foreclosure_id;
						self.Section := '';
						self.Name := [];
						self.Address := [];
					 self.businessIDs.ultid := left.ultid;
					 self.businessIDs.orgid := left.orgid;
					 self.businessIDs.seleid := left.seleid;
					 self.businessIDs.proxid := left.proxid;
					 self.businessIDs.powid := left.powid;
			     self.businessIDs.empid := left.empid;
					 self.businessIDs.dotid := left.dotid;			
				self.Source := MDR.sourceTools.Src_foreclosures;       //NJ****not being used in final layout of for/nod - used in FSourceDocs
				//self.SourceDocID := l.SourceDocID;  //foreclosureid
				  )]);			
										self := []; // TODO remove later
										//export src_Foreclosures              := 'FR';
											//export src_Foreclosures_Delinquent   := 'NT';
							)),all, record);	  

    nod_raw_slim := dedup(project(nod_raw, transform(	 TopBusiness_Services.ForeclosureNODSection_layouts.slim_NODForeRec,
		                self.ultid := left.ultid;
																	 self.orgid := left.orgid;
																	 self.seleid := left.seleid;
																	 self.proxid := left.proxid;
																	 self.powid := left.powid;
																	 self.empid := left.empid;
																	 self.dotid := left.dotid;			
																	 self.ln_fares_id := '';
																	 																		
																      self.apn := trim(std.str.filter(left.parcel_number_unmatched_id,'0123456789'), left,right);
										self.recordingDate := iesp.ecl2esp.toDateString8(left.recording_date);
										self.parcel_number_unmatched_id := left.parcel_number_unmatched_id;
										self.property_state_1 := left.property_state_1;								
										self.document_desc := left.document_desc;
										// this is DATE: on the mockup.
                               // self.Name := iesp.ecl2esp.setName(left.name_first, left.name_middle, left.name_last,
				                                 // left.name_suffix, left.name_title);															 
									self.documentType := left.document_desc; 
															//self.companyName := left.company_name;
                  self.deed_category := left.deed_category;
										//situs1 is property address, situs2 is mailing addr									
					 
										self.SiteAddress1 := iesp.ecl2esp.setAddress(left.situs1_prim_name,
																											left.situs1_prim_range,
																										left.situs1_predir,
																									   left.situs1_postdir,
																										left.situs1_addr_suffix,																									
																									left.situs1_unit_desig,
																										left.situs1_sec_range,
																								left.situs1_v_city_name,																									
																										left.situs1_st,
																										left.situs1_zip,'','');										 
										self.SiteAddress2 := iesp.ecl2esp.setAddress(left.situs2_prim_name,
																											left.situs2_prim_range,
																										left.situs2_predir,
																									   left.situs2_postdir,
																										left.situs2_addr_suffix,																									
																									left.situs2_unit_desig,
																										left.situs2_sec_range,
																								left.situs2_v_city_name,																									
																										left.situs2_st,
																										left.situs2_zip,'','');
										self.AttorneyName := left.attorney_name;
										self.AttorneyPhoneNumber := left.attorney_phone_nbr;
										self.AuctionDate := iesp.ecl2esp.toDateString8(left.auction_date);// or is this Date on the mockup??

										self.VendorSource := if(left.source=MDR.sourceTools.src_Foreclosures, Foreclosure_services.Constants('').src_Fares, 
																																																Foreclosure_services.Constants('').src_BlackKnight);
         	self.LenderType := left.lender_type;
         	self.LenderTypeDescription := left.lender_type_desc;
         	self.LoanAmount := left.loan_amount;
         	self.LoanType := left.loan_type;
         	self.LoanTypeDescription := left.loan_type_desc;
										
										self.LenderFirstName := left.lender_beneficiary_first_name;
										self.LenderLastName := left.lender_beneficiary_last_name;
										self.LenderCompanyName := left.lender_beneficiary_company_name;	
										self.PlaintiffName1 := if (trim(left.Plaintiff_1,left,right) <> 'OWNER_RECORD',
                                                   left.plaintiff_1, '');
                    self.PlaintiffName2 := left.Plaintiff_2;																									 
                    self.DefendantName1 :=  left.First_defendant_borrower_owner_last_name + ' ' + left.First_defendant_borrower_owner_first_name;						
										self.DefendantName2 :=  left.Second_defendant_borrower_owner_last_name + ' ' + left.Second_defendant_borrower_owner_first_name;
                    self.DefendantName3 :=  left.Third_defendant_borrower_owner_last_name + ' ' + left.Third_defendant_borrower_owner_first_name;
									  self.DefendantName4 :=  left.Fourth_defendant_borrower_owner_last_name + ' ' + left.Fourth_defendant_borrower_owner_first_name;
												
										self.DefendantCompanyName1 := left.first_defendant_borrower_company_name;																									 
										self.DefendantCompanyName2 := left.second_defendant_borrower_company_name;
										self.DefendantCompanyName3 := left.third_defendant_borrower_company_name;
										self.DefendantCompanyName4 := left.Fourth_defendant_borrower_company_name;																																													 																																											
										
										self.address :=  iesp.ecl2esp.setAddress('','','','','','','','','','','','');
										self.isForeclosure := false;
										self.isNOD := true;
										self.SourceDocId := left.foreclosure_id;
										self := [];
										)),all, except sourceDocId, apn, parcel_number_unmatched_id);

    NOD_partyDS := dedup(project(nod_raw_slim(deed_category='N'),		                        
																transform(
																   TopBusiness_Services.ForeclosureNODSection_layouts.linkids_plus_t_Biz_Foreclosure_rec,																
																	 self.ultid := left.ultid;
																	 self.orgid := left.orgid;
																	 self.seleid := left.seleid;
																	 self.proxid := left.proxid;
																	 self.powid := left.powid;
																	 self.empid := left.empid;
																	 self.dotid := left.dotid;			
																	 self.ln_fares_id := '';
																	 																		
																      self.apn := trim(std.str.filter(left.parcel_number_unmatched_id,'0123456789'), left,right);
										self.recordingDate := left.recordingDate; 
									
									self.documentType := left.document_desc; 
															//self.companyName := left.company_name;
                  self.deed_category := left.deed_category;
										//situs1 is property address, situs2 is mailing addr									
					 
										self.SiteAddress1 := left.SiteAddress1; // iesp.ecl2esp.setAddress(left.situs1_prim_name,
																											// left.situs1_prim_range,
																										// left.situs1_predir,
																									   // left.situs1_postdir,
																										// left.situs1_addr_suffix,																									
																									// left.situs1_unit_desig,
																										// left.situs1_sec_range,
																								// left.situs1_v_city_name,																									
																										// left.situs1_st,
																										// left.situs1_zip,'','');										 
										self.SiteAddress2 := left.SiteAddress2; //iesp.ecl2esp.setAddress(left.situs2_prim_name,
																											// left.situs2_prim_range,
																										// left.situs2_predir,
																									   // left.situs2_postdir,
																										// left.situs2_addr_suffix,																									
																									// left.situs2_unit_desig,
																										// left.situs2_sec_range,
																								// left.situs2_v_city_name,																									
																										// left.situs2_st,
																										// left.situs2_zip,'','');
										self.AttorneyName := left.AttorneyName; //left.attorney_name;
										self.AttorneyPhoneNumber := left.AttorneyPhoneNumber; //left.attorney_phone_nbr;
										self.AuctionDate := left.AuctionDate; //iesp.ecl2esp.toDateString8(left.auction_date);// or is this Date on the mockup??

										self.VendorSource := left.VendorSource; 
         	self.LenderType := left.LenderType;
         	self.LenderTypeDescription := left.LenderTypeDescription;
         	self.LoanAmount := left.LoanAmount;
         	self.LoanType := left.LoanType;
         	self.LoanTypeDescription := left.LoanTypeDescription;
										
										self.LenderFirstName := left.LenderFirstName;// left.lender_beneficiary_first_name;
										self.LenderLastName := left.LenderLastname; //left.lender_beneficiary_last_name;
										self.LenderCompanyName := left.LenderCompanyName; //left.lender_beneficiary_company_name;	
										self.PlaintiffName1 := left.PlainTiffName1;  //if (trim(left.Plaintiff_1,left,right) <> 'OWNER_RECORD',
                                                   //left.plaintiff_1, '');
                    self.PlaintiffName2 := left.PlainTiffName2; //left.Plaintiff_2;																									 
                    self.DefendantName1 := left.DefendantName1; //  left.First_defendant_borrower_owner_last_name + ' ' + left.First_defendant_borrower_owner_first_name;						
										self.DefendantName2 := left.DefendantName2;// left.Second_defendant_borrower_owner_last_name + ' ' + left.Second_defendant_borrower_owner_first_name;
                    self.DefendantName3 := left.DefendantName3;// left.Third_defendant_borrower_owner_last_name + ' ' + left.Third_defendant_borrower_owner_first_name;
									  self.DefendantName4 := left.DefendantName4; //left.Fourth_defendant_borrower_owner_last_name + ' ' + left.Fourth_defendant_borrower_owner_first_name;
												
										self.DefendantCompanyName1 := left.DefendantCompanyName1; //left.first_defendant_borrower_company_name;																									 
										self.DefendantCompanyName2 := left.DefendantCompanyName2; //left.second_defendant_borrower_company_name;
										self.DefendantCompanyName3 := left.DefendantCompanyName3; //left.third_defendant_borrower_company_name;
										self.DefendantCompanyName4 := left.DefendantCompanyName4; //left.Fourth_defendant_borrower_company_name;																																													 																																											
										
										self.address :=  left.address; //iesp.ecl2esp.setAddress('','','','','','','','','','','','');
										self.isForeclosure := false;
										self.isNOD := true;									
										self.FSourceDocs := dataset([transform(iesp.TopBusiness_share.t_TopBusinessSourceDocInfo,
						self.idType := 'foreclosure_id';
						//self.IDvalue := left.foreclosure_id;
						self.Idvalue := left.SourceDocID;
						self.Section := topBusiness_services.constants.ForeclosureNODSectionName;
						self.Name := [];
						self.Address := [];
					 self.businessIDs.ultid := left.ultid;
					 self.businessIDs.orgid := left.orgid;
					 self.businessIDs.seleid := left.seleid;
					 self.businessIDs.proxid := left.proxid;
					 self.businessIDs.powid := left.powid;
			     self.businessIDs.empid := left.empid;
					 self.businessIDs.dotid := left.dotid;			
				self.Source := MDR.sourceTools.src_Foreclosures_Delinquent;				
				  )]);			
										self := []; // TODO REMOVE later
											
							 )),all);
  
	                                 //?? in_data_deeds here?
																	 // now do the join to see if any recs from
																	 // assessor list have a matching county/APN on them
																	 //
	for_nod_partyDS := 	foreclosure_partyDS + NOD_partyDS;		
	 topLevel_struct_ForeclosureNOD_grouped := group(sort(dedup(for_nod_partyDS                                                                                                                         
                                                                                                                                            ,all), #expand(BIPV2.IDmacros.mac_ListTop3Linkids())
																										 ),
	                                             #expand(BIPV2.IDmacros.mac_ListTop3Linkids())
	                                              );
	 	 
		TopBusiness_Services.ForeclosureNODSection_layouts.t_Biz_foreclosureNOD_rec_plus_linkids 
	rollup_rptdetail(	 
		TopBusiness_Services.ForeclosureNODSection_layouts.linkids_plus_t_BIZ_Foreclosure_rec l,
	  dataset(TopBusiness_Services.ForeclosureNODSection_layouts.linkids_plus_t_BIZ_Foreclosure_rec) allrows) := transform								
          self.acctno := '';
					self.ln_Fares_id := '';
					 self.ultid := l.ultid;
			self.orgid := l.orgid;
			self.seleid := l.seleid;
			self.proxid := l.proxid;
			self.powid := l.powid;
			self.empid := l.empid;
			self.dotid := l.dotid;
			//self.deed_category := l.deed_category;
			self.Foreclosures := choosen(project(allrows(deed_category = 'U' and isForeclosure), transform(
		
			TopBusiness_Services.ForeclosureNODSection_layouts.t_biz_PropertyForeclosureExtra,
			      self := left;
						self := [];
						)),
							iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_FORECLOSURE_NODS);					
			self.noticeOfDefaults := choosen(project(allrows(deed_category ='N' and isNOD), transform(
		
			TopBusiness_Services.ForeclosureNODSection_layouts.t_biz_PropertyForeclosureExtra,
			self := left;
			self := [];
			 )),
					    iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_FORECLOSURE_NODS);
      
				self := [];
														
		end;
		
		 final_recs := rollup(topLevel_struct_ForeclosureNOD_grouped,
																 group,
																 rollup_rptdetail(left,rows(left)));							
	
				
			 
	// output(ds_assessor_recs_raw, named('ds_assessor_recs_raw'));
	// output(nod_linkids_raw, named('nod_linkids_raw'));	
	 // output(nod_linkids_payload, named('nod_linkids_payload'));
	  // output(nod_raw, named('nod_raw'));
		// output(nod_raw_slim, named('nod_raw_slim'));
		// output(NOD_partyDS, named('NOD_partyDS'));
	 // output(foreclosure_linkids_raw, named('foreclosure_linkids_raw'));	
	 // output(foreclosure_linkids_payload, named('foreclosure_linkids_payload'));
	// output(Foreclosure_raw, named('Foreclosure_raw'));
	 // output(foreclosure_partyDS, named('foreclosure_partyDS'));
	
	 // output(for_nod_partyDS, named('for_nod_partyDS'));  
   // output(topLevel_struct_ForeclosureNOD_grouped, named('topLevel_struct_ForeclosureNOD_grouped'));
			 			  																		
	//return final_results;
	return final_recs;

end; // function
end; // module