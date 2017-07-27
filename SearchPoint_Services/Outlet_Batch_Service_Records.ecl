import SearchPoint_Services, ut, autostandardi, batchservices, CNLD_Facilities, 
       NCPDP, BankruptcyV2, LiensV2, dea, Codes;

SearchPoint_services.Layouts.Outlet.batchService.layout_in file_inSearchPointBatchMaster(BOOLEAN forceSeq = FALSE) := function 

	rec := SearchPoint_services.Layouts.outlet.batchService.layout_in;
	raw1 := DATASET([], rec) : STORED('batch_in', FEW);
	raw0 := raw1 : GLOBAL;
	
	rec tra(rec l) := TRANSFORM
		SELF.max_results := if( (UNSIGNED8) l.max_results > 0, l.max_results, '500');
		SELF := l;
	end;
	raw := PROJECT(raw0, tra(LEFT));
	
	ut.MAC_Sequence_Records(raw, seq, raw_seq)
		dea_file := IF(NOT forceSeq AND EXISTS(raw(seq > 0)), raw, raw_seq);				
	 return dea_file;
	
end;		

	SearchPoint_Services.Layouts.Outlet.batchService.layout_out_batch
	          outlet_make_flat(SearchPoint_services.Layouts.Outlet.batchService.layout_out_matchcodes le,
								                        DATASET(SearchPoint_services.Layouts.Outlet.batchService.layout_out_matchcodes) allRows) :=
		TRANSFORM
	    self.acctno := le.acctno;
	     
      self.MatchType        := allrows[1].MatchType;			 
			self.IMS_ID           := allrows[1].gennum;// IMS outlet ID	
			self.IMS_DEA       := allrows[1].dea_number;
		  self.IMS_NCPDP     := allrows[1].ncpdp_number;
						 				 			 				  				 
		 	
			// the pharmacyID needs to be able to be used as input for the Outlet Detailed report service.  
      // here we are overloading the field and returning the ncpdp provider id if it's available and
      // if it's not, we are returning the cnld id.  (the cnld id has an alpha character in the first
      // position of the field. The ncpdp ID does not.
      self.PharmacyId       := IF( allrows[1].ncpdp_PharmacyID = '', 
                                   allrows[1].cnld_PharmacyID,
                                   allrows[1].ncpdp_PharmacyID
                                 );
	end; // transform

EXPORT Outlet_Batch_Service_Records(BOOLEAN useCannedRecs = FALSE) := FUNCTION
		
		UNSIGNED4 tmp_max_results_per_acct := 100 : STORED('max_results_per_acct');
		
		UNSIGNED4 max_results_per_acct :=  IF ( tmp_max_results_per_acct > 1000, 1000, 
				                                    tmp_max_results_per_acct);
																						
    unsigned4 joinLimit := 5000;																									
				                                 
		appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
		
		sample_SearchPoint_set := BatchServices._Sample_inBatchMaster('SEARCHPOINT_OUTLET');
		
	  test_SearchPoint_recs := PROJECT(sample_SearchPoint_set, TRANSFORM(
		                           SearchPoint_services.Layouts.outlet.batchservice.layout_in,
		                            SELF.dea_number := (string10) LEFT.filing_number;
																self.ncpdp_number := (string10) left.sic_code; // may not be filled in
		                            SELF := LEFT;
																self := [];
															));

		// Grab the input XML and throw into a dataset.	
		// the final output should contain the same ncpdp_number, dea_number and ims_id
		// that was in the input.  So preserve these two fields all the way thru.
		// gennum field is used in the final results to output the value of the ims_id that was in the input.
	ds_batch_in_Searchpoint := project(IF (NOT useCannedRecs, 		                 
													       file_inSearchPointBatchMaster(forceSeq := FALSE),
													       test_SearchPoint_recs),
																 transform(SearchPoint_services.Layouts.Outlet.batchservice.layout_in,
																	 self.acctno := left.acctno;									
																	 self.dea_number := left.dea_number,
													         self.ncpdp_number := left.ncpdp_number; // not required as input
																	 self.ims_id := left.IMS_ID;
													       ));
													 
   dea_direct := dedup(join(ds_batch_in_searchPoint, dea.Key_dea_reg_num,
		              keyed(left.dea_number = right.dea_registration_number),																	
									  transform(SearchPoint_services.Layouts.Outlet.batchservice.layout_out_matchcodes,
										  self.acctno := left.acctno;
											self.dea_number := left.dea_number;
											self.bdidDea := (unsigned6) right.bdid;											
											self.deaMatch := true;					
											self.ExpirationDate := right.Expiration_Date;
											self.gennum := left.ims_id;
											self := [];
											), limit(joinLimit)), all);
   																					
    // get the CNLD data here											
   dea_cnldGenNum := dedup(join(ds_batch_in_searchPoint, CNLD_Facilities.key_dea,  														
				                  keyed(left.dea_number = right.deanbr),																										
													transform({string10 gennum; string10 dea_Number; string30 acctno; string10 ims_id;},
													  self.gennum :=  right.gennum;
														self.dea_number := left.dea_number;
														self.acctno := left.acctno;
														self.ims_id := left.ims_id;
													 ), limit(joinLimit)), all);
    												 
   dea_cnldRaw := join( dea_cnldGenNum , CNLD_Facilities.key_gennum,
							         keyed(left.gennum = right.gennum),											     
												 transform(SearchPoint_services.Layouts.outlet.batchservice.layout_out_matchcodes,
												   self.acctno := left.acctno;
												   self.dea_number := right.deanbr;																					
                           self.deaMatch := true;												
												   self.bdiddea := right.bdid;
													 self.ExpirationDate := right.deanbr_exp;
													 self.gennum := left.ims_id; // set gennum -- with input gennum
                           self.CNLD_PharmacyId := left.gennum; // pharmacy ID # -- set the gennum_out with the gennum found in the dea key match
          							   self := [];
												 ), limit(joinLimit));
												 
	 // ***** use the input if by ncpdp_number against the CNLD keys.
		 
		 ncpdp_cnldGenNum := join(ds_batch_in_searchPoint, CNLD_Facilities.key_ncpdp,
		                         keyed(left.ncpdp_number = right.ncpdpnbr),
														 transform({string10 gennum; string10 ncpdp_number; string30 acctno; string10 ims_id;},
														 self.acctno := left.acctno;
														 self.ncpdp_number := left.ncpdp_number;
														 self.ims_id := left.ims_id;
														 self.gennum := right.gennum;	//this this one alone for intermediate
														                        // data to be used in the join in following statement
														 ), limit(joinLimit));
	   		 
		 ncpdp_cnldRaw := join(ncpdp_cnldGenNum, CNLD_Facilities.key_gennum,
		                     keyed(left.gennum = right.gennum),
												 transform(SearchPoint_services.Layouts.Outlet.batchservice.layout_out_matchcodes,
												   self.acctno := left.acctno;
													 self.bdidncpdp := right.bdid;
													 self.ncpdpMatch := true;
													 self.ncpdp_number := right.ncpdpnbr;
													 self.dea_number := right.deanbr;
													 self.expirationDate := right.deanbr_exp;
													 self.gennum := left.ims_id;														
													 self.CNLD_PharmacyID := right.gennum; // pharmacy ID # -- set the gennum_out with the gennum found in the dea key match
          							   self := [];
													 ), limit(joinLimit));
													 
   dea_cnldCombined := dedup(sort(dea_cnldRaw + ncpdp_cnldRaw, acctno, dea_number, bdiddea, record),
		                                 acctno, dea_number, bdiddea);    												
																											                      
   dea_ncpdp := join(ds_batch_in_searchPoint, NCPDP.key_DEA,
		               keyed(left.dea_number  = right.DEA_registration_id),											
									 transform({string10 ncpdp_provider_id; string10 dea_number; 
											        boolean ncpdpMatch; string30 acctno; string10 gennum;
															string10 ncpdp_number;},
										 self.ncpdp_provider_id := right.ncpdp_provider_id,
										 self.dea_number := left.dea_number;
										 self.ncpdpMatch := true;
										 self.acctno := left.acctno;
										 self.ncpdp_number := left.ncpdp_number;
										 self.gennum := left.ims_id), limit(joinLimit));										 																									
												     											 												 
   dea_ncpdpproviderInfo := join(dea_ncpdp, NCPDP.key_ProviderID,
		                           keyed(left.ncpdp_provider_id = right.ncpdp_provider_id),															   
															 transform(SearchPoint_services.Layouts.Outlet.batchservice.layout_out_matchcodes,
															   self.dea_number := left.dea_number;
															   self.acctno     := left.acctno;
																 self.bdidncpdp  := right.bdid;																				 
																 self.gennum := left.gennum; // this orginial input ims_id
																 self.ncpdp_number := left.ncpdp_number;
                                 self.NCPDP_PharmacyID := right.ncpdp_provider_id;
																 self := left; // sets ncpdpMatch = true
																 
															   self := [];
                                ), limit(joinLimit)); 
																
    ncpdp_direct := join(ds_batch_in_searchPoint, NCPDP.key_ProviderID,
		                      keyed(left.ncpdp_number = right.NCPDP_provider_id),
													transform(SearchPoint_services.Layouts.Outlet.batchservice.layout_out_matchcodes,
													self.acctno := left.acctno;
													self.dea_number := right.dea_registration_id;
													self.ncpdp_number := left.ncpdp_number;
													self.bdidncpdp := right.bdid;
													self.ncpdpMatch := true;
													self.gennum := left.ims_id;
												  self.NCPDP_PharmacyID := right.ncpdp_provider_id;
												  self := []
													), limit(joinLimit));    

     dea_ncpdpCombinedInfo := dedup(sort(ncpdp_direct + dea_ncpdpproviderInfo, acctno, -dea_number, -ncpdp_Number ),
		                                     acctno, dea_number, ncpdp_number );
																				 
												  														 
		 // join against each other in order to populate the unset BDID values for each side
		 // this sets us up for later filtering in order to provide the correct match code
		 postjoin := join(dea_cnldCombined, dea_ncpdpCombinedInfo,
		               left.acctno = right.acctno and
									 left.ncpdp_number = right.ncpdp_number,
										 // transform(recordof(left),
                     transform(SearchPoint_services.Layouts.Outlet.batchservice.layout_out_matchcodes,
											 self.bdidncpdp := if (right.bdidncpdp = 0, left.bdiddea, right.bdidncpdp);
											 self.bdiddea   := if (left.bdiddea = 0, right.bdidncpdp, left.bdiddea);
                       SELF.dea_number := IF(LEFT.dea_number = '', RIGHT.dea_number, LEFT.dea_number);
											 self.ncpdpmatch := right.ncpdpmatch;
											 self.deamatch   := left.deaMatch;
											 self.gennum := left.gennum;
                       self.ncpdp_PharmacyId := right.ncpdp_PharmacyId;
											 self := left;						
											 self := right;
										),limit(joinLimit));

     // get entries that have matched.
		 // and do have a valid DeaNumber but may not have a bdid in them
		 // so they did have a deaNumber match but right side key (payload) 
		 // has a blank/zero bdid value so still want to keep those recs
		 // and not filter them out
		 dea_postJoin := join(dea_direct, postjoin,
		                      left.acctno = right.acctno,
													transform(left), left only);

     ncpdp_postJoin := join(dea_ncpdpCombinedInfo, postjoin,
		                      left.acctno = right.acctno,
													transform(left), left only);																									

     // Get the CNLD records by the ims_id
		 cndl_ims_id_data := join(ds_batch_in_searchPoint, CNLD_Facilities.key_gennum,
							                keyed(left.ims_id = right.gennum),											     
												      transform(SearchPoint_services.Layouts.outlet.batchservice.layout_out_matchcodes,
                                         self.acctno := left.acctno;
                                         self.dea_number := right.deanbr;																					
                                         self.cnlfacilityMatch := true;												
                                         self.bdiddea := right.bdid;
                                         self.ExpirationDate := right.deanbr_exp;
                                         self.gennum := left.ims_id; // set gennum -- with input gennum
                                         self.CNLD_PharmacyId := right.gennum; // pharmacy ID # -- set the gennum_out with the gennum found in the dea key match
                                         self := [];
                                       ), limit(joinLimit));
		 cnld_imdId_deduped := dedup(sort(cndl_ims_id_data, acctno, gennum, RECORD ),
		                                  acctno, gennum, dea_number, expirationdate  );										 											
     // add in the main recs plus the one which did not have a dea_number match
		 // based on the two left only joins above.
	   postJoinAllDeaNum := sort(postjoin + dea_postJoin + ncpdp_postJoin + cnld_imdId_deduped, acctno, dea_number,record);
														 
		 dea_denorm:=SET(DEDUP(SORT(dea_direct,dea_number),dea_number),dea_number);
		 fac_denorm:=SET(DEDUP(SORT(dea_cnldGenNum,dea_number),dea_number),dea_number);

	   ds_final := project(postJoinAllDeaNum, transform(SearchPoint_services.Layouts.outlet.batchservice.layout_out_matchcodes,
		                               // only way any bdids are set to non zero value
																	 // is if there is a dea_num match		                               
		               matchType :=  //both  deaNum equal and bdid equal    
								     if (left.bdiddea = left.bdidncpdp and left.bdiddea <> 0 and left.bdidncpdp <> 0, SearchPoint_Services.Layouts.outlet.batchservice.MATCHTYPES[1], 
												 // both deaNum different and bdid's non zero
												if (left.bdiddea <> left.bdidncpdp and left.bdiddea <> 0 and left.bdidncpdp <> 0, SearchPoint_Services.Layouts.outlet.batchservice.MATCHTYPES[2], 
													  // if no match from DEA side but only ncpdp match
														if ( ~left.deamatch  and left.ncpdpmatch, if(left.dea_number in dea_denorm,SearchPoint_Services.Layouts.outlet.batchservice.MATCHTYPES[6],SearchPoint_Services.Layouts.outlet.batchservice.MATCHTYPES[3]), 
														   // if no match from ncpdp side but dea only match
															 if ( left.deamatch and ~left.ncpdpmatch, if(left.dea_number not in fac_denorm,SearchPoint_Services.Layouts.outlet.batchservice.MATCHTYPES[7],SearchPoint_Services.Layouts.outlet.batchservice.MATCHTYPES[4]), 
															                                           SearchPoint_Services.Layouts.outlet.batchservice.MATCHTYPES[5])))); 
																	// won't ever get a 5 here cause case 5 value taken care of below
																	// but set it anyway here
                    self.bdid :=  if (left.bdiddea = left.bdidncpdp, left.bdiddea, 
										                  if (left.bdiddea <> 0, left.bdiddea, 
																			    if (left.bdidncpdp <> 0, left.bdidncpdp, 0)
																					)
																			); // go with dea bdid if bdid's the same
										                   // ncpdp bdid if different no particular reason here.																				
										self.matchType := matchType;
										// blank pharmacy ID for match type 5
										isMatchType5 := matchType=SearchPoint_Services.Layouts.outlet.batchservice.MATCHTYPES[5];
										self.cnld_pharmacyid := if(isMatchType5,'',left.cnld_pharmacyid),
										self.ncpdp_pharmacyid := if(isMatchType5,'',left.ncpdp_pharmacyid),
										self := left));
														
    // add back in any acct entries with no matches and set match code since they contain no dea_matches at all.
		// first need to project to correct layout and set match code in the process.
	  ds_final_withNoMatches := join(project(ds_batch_in_SearchPoint,
		                            transform(SearchPoint_services.Layouts.Outlet.batchservice.layout_out_matchcodes,
		                              self.matchType := SearchPoint_Services.Layouts.outlet.batchservice.MATCHTYPES[5]; // no matches found at all.
																	self.genNum := left.ims_id; // carry thru the gennum from the initial input.
		                              self := left,
																  self := [])),
		                              ds_final,
	                                left.acctno = right.acctno,														
																  transform(left), left only);
																
    ds_final_result := ds_final_withNoMatches + ds_final;

    ds_final_result_deduped := dedup(ds_final_result, all);  
		
		ds_results_grouped := group(sort(ds_final_result_deduped, acctno, dea_number, matchtype, record), acctno);
			
    ds_results_grouped_TOPX := TOPN(ds_results_grouped, max_results_per_acct, acctno);			
    // At this point, 'flatten' the resultant records into the specified output layout 															
		ds_results_rolled_flat := ROLLUP(ds_results_grouped_TOPX, GROUP, outlet_make_flat(LEFT, ROWS(LEFT)));		
		
    return(ds_results_rolled_flat);					
end;
