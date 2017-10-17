IMPORT autostandardI, BIPV2, BIPV2_Best, BIPV2_Best_SBFE, 
			  BIPV2_WAF, BusinessCredit_Services, Census_Data, 
       gong, iesp, MDR, std, Suppress, TopBusiness_Services, ut;
      
EXPORT BusinessSearch_Records := MODULE

EXPORT Search( dataset(BIPV2.IDFunctions.rec_SearchInput) InputSearch, 
               TopBusiness_Services.BusinessSearch_Layouts.OptionsLayout In_Options,
							 AutoStandardI.DataRestrictionI.params in_mod ) := Module							

// used by ssn masking function 
 global_mod := AutoStandardI.GlobalModule();
 string6 ssn_mask_value := AutoStandardI.InterfaceTranslator.ssn_mask_val.val(project(global_mod,
 AutoStandardI.InterfaceTranslator.ssn_mask_val.params)); 		
 		
		string8 CurDate  := (STRING8) std.Date.Today();
		BOOLEAN useBusinessCreditSorting := BusinessCredit_Services.Functions.fn_useBusinessCredit( global_mod.dataPermissionMask, In_Options.IncludeBusinessCredit );
		
		// needed for project into userpermits for salt WAF (we also found) key.	
		in_mod_WAF_KEY := PROJECT(global_mod, BIPV2.mod_sources.iParams,OPT);   
		unsigned userpermits_SALT := BIPV2.mod_sources.in_mod_values(in_mod_WAF_KEY).my_bmap;	
		
		ds_linkIDsNonRestricted := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(InputSearch).Data2_;		
    
    // NOTE:  this export BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(InputSearch).Data2_
		// is referred to as Data2_ export below in the code.
		// 
		// filter out sources here with the macro call use optins passed in above.
		// assumes field to filter is named "source".
		//		
		TopBusiness_Services.functions.MAC_IsRestricted(ds_linkIDsNonRestricted,
															 ds_linkIDsRestricted, 															
	                             source,vl_id,in_mod, in_options.lnBranded, 
															 in_options.internal_testing, dt_first_seen);			
		
    ds_linkIDsRestricted_deduped := DEDUP(SORT(ds_linkIDsRestricted, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), -weight), #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
    ds_BipIdsWithWeight         := PROJECT(ds_linkIDsRestricted_deduped, TopBusiness_Services.BusinessSearch_Layouts.TopBizSearchBizIdsWithWeightRec);  
	  																							   
		// set this here used farther down below.
		possible_LAFN := exists(ds_linkIDsRestricted(keysfailed != 0));
		// set this here and used farther down to indicate of a search result set
		// could have more results but does not.															 															                 																						
		possible_Truncation := exists(ds_linkIDsRestricted(is_Truncated));
																 
    ResultSetSlim :=  ds_linkIDsRestricted(proxid <> 0); 
		
		NonSourceDSELEIDs := dedup(sort(ResultSetSlim(Source <> MDR.sourceTools.src_Dunn_Bradstreet),ultid, orgid, seleid), ultid, orgid,seleid);
		SourceDSELEIDs := dedup(sort(ResultSetSlim(Source = MDR.sourceTools.src_Dunn_Bradstreet),ultid,orgid,seleid),ultid,orgid,seleid);
		 // need to get list of SELEID's that only have source D contributing.
		 // so join left only against set of non source D seleid's returned and project to slim layout
		 // so to add this result to the set of  singleton source D SELEID's later.
		 ds_SourceDSELEIDs := project(join(sourceDSELEIDs, NonSourceDSELEIDs,
		                            left.seleid = right.seleid,
																transform(left), left only),
																transform({unsigned6 seleid;}, self.seleid := left.seleid));
		 ds_seleidMatch := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(InputSearch).SELEmatch;
		 // now get SELEBEst from salt call.
		 // The filter on company_name <>  null ensures that
		 // the restrictions for source = D recs are being done within the seleBest call
		 // SELEBEST export which ultimately calls the bipv2_best.key_linkids.kfetch call
		 // 
		
		 ds_seleidBest := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(InputSearch).SELEBest(company_name <> '');

		 ds_seleidBestPreWirelessIndicator := project(ds_seleidBest,transform({recordof(left);
		                                                                        string3 timeZone;
		                                                                        string1 wirelessIndicator;},
		                                          self.wirelessIndicator := '';
																							self.TimeZone := '';
		                                          self := left));
																							
    TopBusiness_Services.Macro_AppendWirelessIndicator(ds_seleidBestPreWirelessIndicator,
		                                                   ds_seleidBestWirelessIndicator,company_phone);	
																											 											  
    // figure out which rows from search results after restrictions here
	  // have only 1 row per SELEID -- cause that is what report is based on.
			
		SingleTonSELEIDsInSearchResults := project(table(resultsetSlim, 																		 														                
																			       {seleid, unsigned2 cnt:= count(group);},
	                                           seleid)(cnt = 1),transform({unsigned6 seleid;},self := left)
																						 );
		 
    // now figure out if the singleSELEID's determined above are source D recs ...cause we can't display those recs
		// in a source doc view so need a list of singleton SELEID source = D's in order to set DISPLAYREPORTLINK flag below.
		// and also add in the set of seleid from header recs whose only contributing source is source = D recs
    tmpSourceDNBDMISingleTonSELEIDsInSearchResults  :=  join( SingleTonSELEIDsInSearchResults, resultSetSlim(source = MDR.sourceTools.src_Dunn_Bradstreet),
		                                                        left.seleid = right.seleid,
		                                                        transform(left));     
		SourceDNBDMISingleTonSELEIDsInSearchResults := dedup(sort(ds_SourceDSELEIDs + 	
					                                          tmpSourceDNBDMISingleTonSELEIDsInSearchResults, seleid), seleid);
    // get rid of extra results witin a proxid group and bubble the results with phone and fein to the top
		// while pushing the invalid area codes of 1st num
		//of 0 and 1 and phone nums with 999 999 9999 to the bottom of
		// the proxid group so they are dedup'd out
    topResults := dedup(sort(resultSetSlim, ultid, orgid, seleid, proxid, -proxweight, -record_score, if (source <> MDR.sourceTools.src_Dunn_Bradstreet, 0,1),
		                       -dt_last_seen, // moved dt_last_seen up here in sort order to try and fix 148887
													                // and added sorting non source = D recs in front of -dt_last_seen for bug # : 168548
		                    if ((unsigned)trim(company_phone,left,right) != 0
		         and length(company_phone) = 10 and company_phone[1] <> '1' and company_phone[1] <> '0', 0, 1),						     
						     if (company_fein <> '', 0, 1),
						   if (company_phone <> '9999999999', 0, 1) ,record)
		                              ,ultid, orgid, seleid, proxid);
   																											        																				
    // sort by -proxweight to bubble top score within a proxid group to the top again.
		tmpTopResultsScored := sort(topResults,-proxweight, -record_score, 
		                                     -dt_last_seen, // // moved dt_last_seen up here in sort order to try and fix 148887
																				  if ((unsigned)trim(company_phone,left,right) != 0
																				and length(company_phone) = 10 and company_phone[1] <> '1' and company_phone[1] <> '0', 0, 1),																				   																				
																					 if (company_fein <> '', 0, 1),	 if (company_phone <> '9999999999', 0, 1),                                   
																				 record);  
  	 																				 
    TopResultsScored := 		project(tmpTopResultsScored, transform({recordof(left); string3 timezone;},
		                                   self.timezone := '';																	
																			 self := left));
																			 
		 // add in wireless indicator to to DS.
		 // topResultsScored_wirelessindicator is used later as main proxid based result set.
		 //
		 
		 TopBusiness_Services.Macro_AppendWirelessIndicator(topResultsScored,topResultsScored_WirelessIndicator,
																												company_phone);
		 
		 // filter the search results set to find any possible rows that may have parent information.
		 		 
		 TmpdsUltLinkIdInfo := project(ds_seleidBestWirelessIndicator(ParentAboveSELE = true),
																	 transform({unsigned6 SELEIDVALUE; string1 wirelessIndicator; BIPV2.IDlayouts.l_xlink_ids;},  		 		                    
		                         self.ultid := 0; //left.ultid;
														 self.orgid := 0; //left.ultid;
														 self.seleid := 0;
														 self.SELEIDVALUE := left.seleid; // need to save this to join back later
                             self.proxid := left.ultimate_proxid;
														 self.powid := 0;
														 self.empid := 0;
														 self.dotid := 0;
														 self.wirelessindicator := left.wirelessindicator;
														 self := [];
														 ));
														  // just the stuff that has parent information.
      ds_ultLinkIDInfo := project(TmpdsUltLinkIdInfo,		                  
		                  transform({recordof(tmpdsUltLinkIdInfo);iesp.TopBusinessSearch.t_TopBusinessUltimateRecord;},											
											    self.SELEIDVALUE := left.SELEIDVALUE;
											    tmpProxid := left.proxid;													
											   
												  BIPV2.IDlayouts.l_xlink_ids ParentDSXform() := TRANSFORM
													                   SELF.PROXID := tmpProxId;                         
																							SELF := [];
																							END;
                          ParentDS := dataset([ ParentDSXform() ]);																																			    
                         			
													// false param means to not add isActive/isDefunct to the payload.
													//
													// added false per bug # : 149989
												  tmpUltInfo := BIPV2_Best.Key_LinkIds.kfetch(ParentDS,BIPV2.IDconstants.Fetch_Level_PROXID,,,false);
												 
												 self.CompanyNameInfo.companyName := tmpUltInfo[1].company_name[1].company_name;
												 self.AddressInfo.address := 
												        iesp.ecl2esp.SetAddress(
															     tmpUltInfo[1].company_address[1].company_prim_name,
																	 tmpUltInfo[1].company_address[1].company_prim_range,
																	 tmpUltInfo[1].company_address[1].company_predir,
																	 tmpUltInfo[1].company_address[1].company_postdir,
																	 tmpUltInfo[1].Company_address[1].company_addr_suffix,
																	 tmpUltInfo[1].company_address[1].company_unit_desig,
																	 tmpUltInfo[1].company_address[1].company_sec_range,
																	 tmpUltInfo[1].company_address[1].address_v_city_name,
																	 tmpUltInfo[1].company_address[1].company_st,
																	 tmpUltInfo[1].company_address[1].company_zip5,
																	 tmpUltInfo[1].company_address[1].company_zip4,tmpultInfo[1].company_address[1].county_name); 
                        
                        
												 self.businessIDs.ultid := tmpUltInfo[1].ultid;
												 self.businessIDs.orgid := tmpUltInfo[1].orgid;
												 self.businessIDs.seleid :=  tmpUltInfo[1].seleid;
												 self.businessIDs.proxid := tmpUltInfo[1].proxid;
												 self.businessIDs.powid := tmpUltInfo[1].powid;
												 self.businessIDs.empid :=  tmpUltInfo[1].empid;
												 self.businessIDs.dotid := tmpUltInfo[1].dotid;												 
												 // set the bdid value.
												 self.BusinessID := (string12) tmpUltInfo[1].company_bdid;
												 //
												 // needed for accurint not used in portal.
												 self.AlsoFound.Incorporations := false;
												 self.AlsoFound.UCCs := false;
												 self.AlsoFound.properties := false;
												 self.AlsoFound.MVRs := false;
												 self.AlsoFound.Contacts := false;
											
												 self.AddressInfo.Location := [];
												
                         self := left;																	 
                         self := []; 
												 ));
																							 
		

      // now link go each row of the best seleid results and add in the parent information for that particular row
			// if it exists from the right side.
			//
			// **** layout of left side  ds_seleidBestWirelessIndicator is from 
			// **** ds_seleidBest export above..not within this Attr
			//
			// making sure we dont' lose any of the orginal seleidBest results  -- thus left outer join
		  ds_ultInfo := join(ds_seleidBestWirelessIndicator,  ds_UltlinkIdInfo,
		                   left.SELEID = right.SELEIDVALUE,
		                   transform({recordof(ds_seleidBestWirelessIndicator);iesp.TopBusinessSearch.t_TopBusinessUltimateRecord;},											
											   self.AddressInfo.address := right.addressInfo.Address;													
												 self.CompanyNameInfo.companyName := right.CompanyNameInfo.companyName;
												 self.businessIDs.ultid := right.businessIds.ultid;
												 self.businessIDs.orgid := right.BusinessIDs.orgid;
												 self.businessIDs.seleid :=  right.businessIDs.seleid;
												 self.businessIDs.proxid := right.BusinessIDs.proxid;
												 self.businessIDs.powid := right.BusinessIDS.powid;
												 self.businessIDs.empid :=  right.BusinessIDs.empid;
												 self.businessIDs.dotid := right.BusinessIDs.dotid;			
												 // bdid
												 self.BusinessID := right.businessID;
												 																								 
												 //needed for accurint not used in portal.
												 self.AlsoFound.Incorporations := false;
												 self.AlsoFound.UCCs := false;
												 self.AlsoFound.properties := false;
												 self.AlsoFound.MVRs := false;
												 self.AlsoFound.Contacts := false;											
												 self.AddressInfo.Location := [];												
                         self := left;																	                          
												  ), left outer); 
													//
													// need left outer here because not all of the results from SELEIDBEST export will 
													// have a parent so need to keep recs from the left side too.
													//
													
	 // record structure for the phone string used in both the SELEID level phone join and the proxid level phone join	 
   rec_tmp_Phone:=record
     string phone;
   end;					
		 		 													     																						
   //  *** UNIQUE PHONE SELEID
	 unique_phones_SELEID := table(ds_seleidBest,
		 {unsigned6 ultid := ultid, unsigned6 orgid := orgid, unsigned6 seleid := seleid; unsigned6 proxid := proxid, unsigned6 powid := powid,
		                  unsigned6 empid := empid, unsigned6 dotid := dotid ,string10 phone := company_phone});
		
	 deduped_unique_phones_SELEID := dedup(unique_phones_SELEID, all);
		 
		 // setup a record structure of the datasets.
		 //
	 rec_tmp_SELEID :=record
     recordof(deduped_unique_phones_SELEID);
     gong.Key_History_phone;
   end;
		
	 ds_tmp_SELEID :=dedup(sort(project(deduped_unique_phones_SELEID,  rec_tmp_Phone),phone),phone);
   //Look up unique phone#s on gong history to get meta-data
   unique_phones_wgongdata_0_SELEID := join(ds_tmp_SELEID, gong.Key_History_phone, 
		                                 keyed(left.phone[4..10] = right.p7) and 
					                           keyed(left.phone[1..3]  = right.p3),
																		 limit(TopBusiness_Services.Constants.defaultJoinLimit,skip)); // if there are more than this, just don't worry about it.
   unique_phones_wgongdata_1_SELEID := dedup(unique_phones_wgongdata_0_SELEID, all);
	 // now take the metadata DS with the linkids and join it to the phone metadata DS
	 // and then use that going forward.
	 unique_phones_wgongdata_SELEID_ALL := join(deduped_unique_phones_SELEID,unique_phones_wgongdata_1_SELEID,
          left.phone=right.phone,
          transform(rec_tmp_SELEID,self:=left,self:=right));
	
	 unique_phones_wgongdata_SELEID := rollup(
		sort(unique_phones_wgongdata_SELEID_ALL,		   			
			  #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
			 phone,if (current_flag, 0, 1),
			if(current_flag,listed_name,'')),
		transform(recordof(left),
			self.listing_type_gov := max(left.listing_type_gov,right.listing_type_gov),
			self.listing_type_bus := max(left.listing_type_bus,right.listing_type_bus),
			self.listing_type_res := max(left.listing_type_res,right.listing_type_res),
			self.listed_name := left.listed_name,
			self.dt_first_seen := min(left.dt_first_seen,right.dt_first_seen),
			self.dt_last_seen := max(left.dt_last_seen,right.dt_last_seen),
			self := left),				
		#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
		phone,if (current_flag, 0, 1),		
		if(current_flag,listed_name,''));
    
		// do a routine that adds in the namematch boolean value
		// to unique_phones_wgongdata
		
		 unique_phones_against_names_SELEID := denormalize(unique_phones_wgongdata_SELEID, ds_seleidBest,														
																						 BIPv2.IDmacros.mac_JoinTop3Linkids(),
          group,
		transform(recordof(left), 
			self := left),
		LIMIT(TopBusiness_Services.Constants.defaultJoinLimit),
		KEEP(TopBusiness_Services.Constants.defaultJoinLimit));																																																																				                               		
		
		unique_phones_gong_rolled_SELEID := rollup(
		group(sort(unique_phones_against_names_SELEID, 		                     																								
													#expand(BIPv2.IDmacros.mac_ListTop3Linkids()),
		              phone, if (current_flag, 0, 1)),									      												
												#expand(BIPv2.IDmacros.mac_ListTop3Linkids()),
									      phone),
		group,
		transform({
			unique_phones_SELEID;
			string1 listing_type;
			string1 active_EDA;
			string1 disconnected;
			string8 from_date;
			string8 to_date;
			string120 listed_name;},
			self.disconnected := if(not exists(rows(left)(current_flag)),'Y','N'),
			                                        
			self.active_EDA := if(exists(rows(left)(current_flag
			                                            )),'Y','N'),
			self.from_date := min(rows(left)(current_flag 			                            
																	  ),dt_first_seen),
			self.to_date := max(rows(left)(current_flag 
			                              ),dt_last_seen),
			self.listing_type := map(
				exists(rows(left)(current_flag and listing_type_gov != '')) => max(rows(left)(current_flag and listing_type_gov != ''),listing_type_gov),
				exists(rows(left)(current_flag and listing_type_bus != '')) => max(rows(left)(current_flag and listing_type_bus != ''),listing_type_bus),
				exists(rows(left)(current_flag and listing_type_res != '')) => max(rows(left)(current_flag and listing_type_res != ''),listing_type_res),
				''),
			self.listed_name := max(rows(left)(current_flag),listed_name),
			self := left,
			self := []));	
			// *** END UNIQUE PHONES SELEID
		/*(**/

//------------------------------------------------- proxid phone metadata	-------------	
  unique_phones := table(topResultsScored, // MATCH CHANGE
		 {unsigned6 ultid := ultid, unsigned6 orgid := orgid, unsigned6 seleid := seleid; unsigned6 proxid := proxid, unsigned6 powid := powid,
		                  unsigned6 empid := empid, unsigned6 dotid := dotid ,string10 phone := company_phone});
		
	deduped_unique_phones:= dedup(unique_phones, all);

  rec_tmp:=record
    recordof(deduped_unique_phones);
    gong.Key_History_phone;
  end;         
     
  ds_tmp:=dedup(sort(project(deduped_unique_phones,  rec_tmp_phone),phone),phone);   
     
	//Look up unique phone#s on gong history to get meta-data
  unique_phones_wgongdata_0_a := join(ds_tmp, gong.Key_History_phone, 
		                                 keyed(left.phone[4..10] = right.p7) and 
					                           keyed(left.phone[1..3]  = right.p3),
                                                      limit(TopBusiness_Services.Constants.defaultJoinLimit,skip)); // if there are more than this, just don't worry about it.
  
	unique_phones_wgongdata_0 := join(deduped_unique_phones,unique_phones_wgongdata_0_a,
          left.phone=right.phone,
          transform(rec_tmp,self:=left,self:=right));
		
  unique_phones_wgongdata_1 := dedup(unique_phones_wgongdata_0, all);
	
	unique_phones_wgongdata := rollup(
		sort(unique_phones_wgongdata_1,		   
			 #expand(BIPV2.IDmacros.mac_ListAllLinkids()),
			 phone,if (current_flag, 0, 1),
			if(current_flag,listed_name,'')),
		transform(recordof(left),
			self.listing_type_gov := max(left.listing_type_gov,right.listing_type_gov),
			self.listing_type_bus := max(left.listing_type_bus,right.listing_type_bus),
			self.listing_type_res := max(left.listing_type_res,right.listing_type_res),
			self.listed_name := left.listed_name,
			self.dt_first_seen := min(left.dt_first_seen,right.dt_first_seen),
			self.dt_last_seen := max(left.dt_last_seen,right.dt_last_seen),
			self := left),		
		#expand(BIPV2.IDmacros.mac_ListAllLinkids()),
		phone,if (current_flag, 0, 1),		
		if(current_flag,listed_name,''));
    
		// do a routine that adds in the namematch boolean value
		// to unique_phones_wgongdata
		
	unique_phones_against_names := denormalize(unique_phones_wgongdata, topResultsScored,
																			BIPV2.IDmacros.mac_JoinAllLinkids(),																																					
          group,
		transform(recordof(left),	
			self := left),
		LIMIT(TopBusiness_Services.Constants.defaultJoinLimit),
		KEEP(TopBusiness_Services.Constants.defaultJoinLimit));																																																																				                               		
		
	unique_phones_gong_rolled := rollup(
		group(sort(unique_phones_against_names, 		                     
													#expand(BIPV2.IDmacros.mac_ListAllLinkids()),																										
		              phone, if (current_flag, 0, 1)),									      
												#expand(BIPV2.IDmacros.mac_ListAllLinkids()),													
									      phone),
		group,
		transform({
			unique_phones;
			string1 listing_type;
			string1 active_EDA;
			string1 disconnected;
			string8 from_date;
			string8 to_date;
			string120 listed_name;},
			self.disconnected := if(not exists(rows(left)(current_flag)),'Y','N'),
			                                        
			self.active_EDA := if(exists(rows(left)(current_flag
			                                            )),'Y','N'),
			self.from_date := min(rows(left)(current_flag 
			                            
																	  ),dt_first_seen),
			self.to_date := max(rows(left)(current_flag 
			                              ),dt_last_seen),
			self.listing_type := map(
				exists(rows(left)(current_flag and listing_type_gov != '')) => max(rows(left)(current_flag and listing_type_gov != ''),listing_type_gov),
				exists(rows(left)(current_flag and listing_type_bus != '')) => max(rows(left)(current_flag and listing_type_bus != ''),listing_type_bus),
				exists(rows(left)(current_flag and listing_type_res != '')) => max(rows(left)(current_flag and listing_type_res != ''),listing_type_res),
				''),
			self.listed_name := max(rows(left)(current_flag),listed_name),
			self := left,
			self := []));									
			
			 // right side contains proxid level search results from data2_ export from SALT
		   //            source D restrictions for that are below
       // left side contains seleidBest and ultinformation for SELEIDBEST		                                                
		   // source D restrictions for that DS are implemented within the bipv2_best.key_linkids.kfetch call
		   //
       //added filter seleid <> 0 because some proxid's that are a non source = D then have a seleid
			// best source that is source D that we can't display so need to filter out those proxid's from the list
			// these rows show up as having SELEID = 0 because left side value from SELEIDBEST export is 0 value so filter them out.
			
			 tmp_return_results_NEW := join(ds_UltInfo(seleid <> 0), TopResultsScored_wirelessIndicator,
		                        left.seleid = right.seleid,														
                            transform(TopBusiness_Services.BusinessSearch_Layouts.tmp_output_layout_full,
    		
		   SourceDSingletonFlag := exists(SourceDNBDMISingleTonSELEIDsInSearchResults(seleid = left.SELEID));
		   DNBDMIrecordOnly := SourceDSingletonFlag;
			 // isDNBDMIROW is specific to this proxid row (i.e. right side from data2_ export)
			 // and has different meaning than 
			 // the boolean flag
			 // DNBDMIRecordOnly which pertains to the SELEID level.
			 isDNBDMIRow := MDR.sourceTools.SourceIsDunn_Bradstreet(right.source);
		  
			
				
       //set the boolean that says to display or not display the BIP report 
			 // instructional field for various GUI portal skins.
			 // if this is false then source docs are shown as long as source is not a DNB DMI (source = D) singleton.
			 //
       DisplayReportLink := (Not(EXISTS( SingleTonSELEIDsInSearchResults(seleid = left.seleid))))
			                           AND        
           								   (Not(SourceDSingletonFlag));		
														 
       self.IsTruncated := possible_Truncation;														
	   
		   parentIndicator := left.businessIDs.ultid <> 0 and left.CompanyNameInfo.companyName <> '';
			 self.Best.ParentCompanyIndicator := parentIndicator; // represents ultimate information being populated
			   
			 // is Defunct obtained from SELEIDBest export call.
			 self.best.IsDefunct :=  left.isDefunct;
					
       // isActive obtained from SELEIDBest export call. 														
       self.best.IsActive := left.isActive;											
			 self.Best.CompanyNameInfo.CompanyName := left.company_name;			             																					
       self.Best.PhoneInfo.Phone10 := left.company_phone;																				
			 self.Best.PhoneInfo.pubNonPub := '';
			 self.Best.Phoneinfo.listingName := '';
			 self.Best.PhoneInfo.listingphone10 := '';
			 self.Best.PhoneInfo.timezone := left.timezone;
			 self.Best.PhoneInfo.listingtimezone := '';			 	
			 self.Best.listingType := '';
			 self.Best.activeEDA := false;
			 self.Best.Disconnected := false;
			 self.Best.WirelessIndicator := left.wirelessIndicator;
			
			 self.Best.AddressToDate :=  iesp.ecl2esp.todate(left.dt_last_seen);
			
			 self.Best.AddressFromDate := iesp.ecl2esp.todate(left.dt_first_seen);
			 self.Best.AddressInfo.Address.StreetNumber := left.prim_range;
			 self.Best.AddressInfo.Address.StreetPreDirection := left.predir;
			 self.Best.AddressInfo.Address.StreetName := left.prim_name;
			 self.Best.AddressInfo.Address.StreetSuffix := left.addr_suffix;
			 self.Best.AddressInfo.Address.StreetPostdirection := left.postdir;
			 self.Best.AddressInfo.Address.UnitDesignation := left.unit_desig;
			 self.Best.AddressInfo.Address.UnitNumber := left.sec_range;
			 self.Best.AddressInfo.Address.City := left.city;
			 self.Best.AddressInfo.Address.State := left.st;
			 self.Best.AddressInfo.Address.Zip5 := left.zip; 
			 self.Best.AddressInfo.Address.zip4 := left.zip4; 
			 self.Best.AddressInfo.Address.County := left.county_name;	 
			 self.Best.AddressInfo.Address.streetAddress1 := [];
			 self.Best.AddressInfo.Address.streetAddress2 := [];
			 self.Best.AddressInfo.Address.postalcode := [];
			 self.Best.AddressInfo.Address.statecityzip := [];
			 self.Best.AddressInfo.location := [];
			 //self.best.alsofound.
			 //self.best.
			  
			 self.Best.SicInfo.Sic := ''; 
			 self.Best.TinInfo.Tin := left.company_fein;			 
			
			 self.Best.TinInfo.TinSource := left.Company_fein_sources[1].source;
			 self.Best.TinInfo.TinInfoMatch := left.match_company_fein = 2; // 		2 is from salt
			 
			 tmpUrl := trim(left.company_url,left,right);
			 SlashPosition := stringlib.stringfind(tmpurl,'/',1);				 				 												
       cleanedUrl := if (tmpurl <> '' and SlashPosition > 1,  tmpUrl[1..slashPosition-1],
			                                    tmpUrl);	
       self.Best.URLInfo.URL := cleanedUrl; 					
			 self.Best.UrlInfo.UrlInfoMatch := trim(InputSearch[1].url,left,right) <> '' and 
			                                   trim(InputSearch[1].url,left, right) = stringlib.stringtoUppercase(cleanedUrl); // 
																				   // uppercase it cause salt is not doing this now.
			                // salt calculation broken add this back in when fixed 
                                         // left.match_company_url = 2;						 
			  
			 self.Best.EmailInfo.Email :=  left.contact_email; // or contact_email? waiting on bug # : 117576
			 self.Best.EmailInfo.EmailInfoMatch := left.match_contact_email = 2; // 2 is from salt 
			 self.Best.ContactInfo.ContactInfoMatch := left.match_fname = 2 OR // left.match_mname = 2 and
			                                               left.match_lname = 2;
			                                            // using this above since match_contactname seem to always be 0
																									// linking team investigating.
																									// its broken linking team needs to fix this below
																									// so using brute force match until salt fix is done.
																									// left.match_contact_name = 2

			 self.Best.ContactInfo.Title := left.contact_job_title_derived;
			 self.Best.ContactInfo.UniqueID :=  (string12) left.contact_did;
			 self.Best.ContactInfo.Name.Prefix := left.title;
			 self.Best.ContactInfo.Name.First  :=  left.fname;
			 self.Best.ContactInfo.Name.Last   :=  left.lname;
			 self.Best.ContactInfo.Name.Middle :=  left.mname;
			 self.Best.ContactInfo.Name.Suffix :=  left.name_suffix;
			 self.Best.ContactInfo.Name.Full := '' ;                              
			 self.Best.FromDate :=  iesp.ECL2ESP.toDate((unsigned4)left.dt_first_seen);  
			 self.Best.ToDate := iesp.ECL2ESP.toDate((unsigned4)left.dt_last_seen),
			 // from proxid level search results.
			 MatchesVendorLastReported := if (not(isDNBDMIRow), iesp.ecl2esp.toDate((unsigned4)right.dt_vendor_last_reported));
			 self.Best.LastReported := iesp.ecl2esp.toDate((unsigned4)left.dt_vendor_last_reported);
			 self.ultimate.businessIDs.ultid := left.businessIDs.ultid; // from left side ultInfo
			 self.ultimate.businessIDs.orgid := left.businessIDs.orgid; // from left side ultInfo 
			 self.ultimate.businessIDs.proxid := left.businessIDs.proxid; // from  left side ultInfo
			 self.ultimate.businessIDs.seleid :=  left.businessIDs.seleid; // from left side ultInfo
			 self.ultimate.businessIDs.powid :=  left.businessIDs.powid; // from left side ultInfo 
			 self.ultimate.businessIDs.empid :=  left.businessIDs.empid; // from left side ultInfo
			 self.ultimate.businessIDs.dotid :=  left.businessIDs.dotid; // from left side ultInfo
			 self.ultimate.businessID :=  left.BusinessID; // PARENT BDID of BDID from BestSELEID from initial search results
			                                            
       // source = D restrictions already taken care of by selebest export call (left side of join) so no need to restrict them here.																									
			 self.ultimate.companyNameInfo.companyName := left.CompanyNameInfo.companyName;
			 self.ultimate.AddressInfo.Address.StreetNumber := left.AddressInfo.address.StreetNumber;
			 self.ultimate.AddressInfo.Address.StreetPreDirection := left.AddressInfo.address.StreetPreDirection;
			 self.ultimate.AddressInfo.Address.StreetName := left.addressInfo.Address.StreetName;
			 self.ultimate.AddressInfo.Address.StreetSuffix := left.AddressInfo.address.StreetSuffix;
			 self.ultimate.AddressInfo.Address.StreetPostdirection := left.addressInfo.address.StreetPostDirection;
			 self.ultimate.AddressInfo.Address.UnitDesignation := left.addressInfo.Address.UnitDesignation;
			 self.ultimate.AddressInfo.Address.UnitNumber := left.AddressInfo.Address.UnitNumber;
			 self.ultimate.AddressInfo.Address.City  :=  left.AddressInfo.Address.City;
			 self.ultimate.AddressInfo.Address.State :=  left.AddressInfo.Address.State;
			 self.ultimate.AddressInfo.Address.Zip5 := left.AddressInfo.Address.Zip5;
			 self.ultimate.AddressInfo.Address.Zip4 := left.addressInfo.Address.Zip4;
			 self.ultimate.AddressInfo.Address.County := left.addressInfo.address.County;
      // self.ultimate.AddressInfo.address.streetaddress1 := '';
			// self.ultimate.AddressInfo.address.streetAddress2 := '';
			 // self.ultimate.AddressInfo.Location := [];
					
		   twoYearsBack := (unsigned4) ut.date_math(CurDate, -730);
									                             // i.e 2 years. 
																						   //as per bug # :" 119312 suggest by BIP 2.0 architect.
			 tmpIsActiveUsingDateLastSeen := if ((unsigned4) right.dt_last_seen <> 0, 
																				if ((unsigned4) right.dt_last_seen <
																						twoYearsBack,																	
																							false,true),
																				true);  
			
       tmpIsActiveUsingCompanyStatusDerived := NOT( trim(right.company_Status_derived, left, right) in ['SUSPENDED','INACTIVE']);
			 tmpisActive := tmpIsActiveUsingDateLastSeen and tmpisActiveUsingCompanyStatusDerived and (not (isDNBDMIrow));
			 tmpIsDefunct := trim(right.company_status_derived, left, right) in ['FORFEITED','TERMINATED','DISSOLVED'] and not(isDNBDMIrow);
			 // THIS FIELD ISACTIVE  and IsDefunct (at the proxid level i.e. within the match section) IS NOT DISPLAYED  on the GUI side for BIP
			 // but will still filter them out if they are from source = D Recs.
       self.Match.IsActive  := tmpIsActive; // this field not displayed in GUI for Portal/Bip project 		      					
			 self.Match.IsDefunct := tmpisDefunct;  // this field not displayed in GUI for Portal/Bip project
			
			 MatchesAddressToDate := if (NOT(isDNBDMIRow), 
			                          iesp.ecl2esp.todate(right.dt_last_seen)); 
       MatchesAddressFromDate := if (NOT(isDNBDMIRow), 
			                                 iesp.ecl2esp.todate(right.dt_first_seen)); 			
			 tmpcname := right.company_name;
			 tmpmatchCleanedCompanyName := trim(right.cnp_name,left,right);
			 self.match.CompanyNameInfo.CompanyName := tmpcname;
			 tmpListingType := right.phone_type;
			 self.match.ListingType := tmpListingType;
			 
       tmpPhone := right.company_phone;			
			 tmptimeZone := right.timezone;
       								 
			 self.match.PhoneInfo.Phone10 := tmpPhone;	
       self.match.phoneInfo.timezone := tmptimezone;		
			 
			 tmpWirelessIndicator := right.wirelessIndicator;	
			 self.match.WirelessIndicator := tmpWirelessIndicator;
			 			
       tmpPrimRange := if(not isDNBDMIrow, right.prim_range,'');
			 tmpPrimRangeCompare := trim(right.prim_range, left,right);
			 self.match.AddressInfo.Address.StreetNumber := tmpPrimRange;																				
																									
       tmpPreDir :=  if(not isDNBDMIrow,right.predir,'');			
			 // tmpPreDirCompare := right.predir;
			 self.match.AddressInfo.Address.StreetPreDirection := tmpPreDir;
			 tmpPrimName := if(not isDNBDMIrow,right.prim_name,'');	
			 tmpPrimNameCompare := trim(right.prim_name,left,right);
			 self.match.AddressInfo.Address.StreetName :=   tmpPrimName;																								
																										
			 tmpAddrSuffix := if(not isDNBDMIrow,right.addr_Suffix,'');    
			 //tmpAddrSuffixCompare := trim(right.addr_suffix,left,right);
			 self.match.AddressInfo.Address.StreetSuffix := tmpAddrSuffix; 
			 tmppostDir := if(not isDNBDMIrow,right.postDir,'');
			 // tmpPostDirCompare := right.postDir;
			 self.match.AddressInfo.Address.StreetPostdirection := tmppostDir; 
			 tmpUnitDesig := if(not isDNBDMIrow,right.unit_desig,'');
			 tmpUnitDesigCompare := right.unit_desig;
			 self.match.AddressInfo.Address.UnitDesignation := tmpUnitDesig; 
       tmpUnitNumber := if(not isDNBDMIrow,right.sec_range,'');	
			 tmpUnitNumberCompare := right.sec_range;
			 self.match.AddressInfo.Address.UnitNumber :=  tmpUnitNumber; 
			 tmpvcity := trim(right.v_city_name,left,right);
			 self.match.AddressInfo.Address.City  :=  tmpvcity;	
       tmpst :=  trim(right.st,left,right);
			 self.match.AddressInfo.Address.State :=  tmpst;
       tmpZip := if(not isDNBDMIrow,right.zip,'');		
			 tmpZipCompare := trim(right.zip,left,right);
			 self.match.AddressInfo.Address.Zip5 := tmpZip;
			 tmpZip4 := if (not isDNBDMIrow, right.zip4,'');
			 tmpZip4Compare := right.zip4;
			 self.match.addressInfo.address.zip4 := tmpzip4;
			 countyName := project(Census_Data.Key_Fips2County(keyed(state_code=right.st) and 
			                                  keyed(county_fips = right.fips_county)), transform({string18 countyName;},
																				 self.countyName := left.county_name))[1].countyName;	
			 tmpcounty := if (not isDNBDMIrow, countyName,'');
			 self.match.AddressInfo.address.county := tmpCounty;
			 tmpTinInfoMatch := right.match_company_fein = 2 and (not(isDNBDMIrow));
			 self.match.TinInfo.TinInfoMatch := tmpTinInfoMatch;
			 tmpTin := if (not isDNBDMIrow, right.company_fein,'');
			 self.match.TinInfo.Tin :=  tmpTin;
			 tmpTinSource := right.source;
				
		   self.match.TinInfo.TinSource := tmpTinSource;
			 tmpEmailInfoMatch := right.match_contact_email = 2 and (not(isDNBDMIrow));
			 self.match.EmailINfo.emailInfoMatch := tmpEmailInfoMatch;
       tmpEmail := if (not isDNBDMIrow,stringlib.stringToUpperCase(trim(right.contact_email_domain, left, right)),
			                 '');
			                                  																									
			 self.match.EmailInfo.Email := tmpEmail;
       slimUrl :=  if (tmpurl <> '' and SlashPosition > 1,  tmpUrl[1..slashPosition-1],
			                                    tmpUrl);
																 //has to be an exact match here
       tmpUrl2 := 	if (not isDNBDMIrow,cleanedUrl,'');
			 self.match.URLInfo.URL := tmpUrl2;
			 TmpcontactInfoMatch := (right.match_fname = 2 OR 
			                          right.match_lname = 2 or right.match_contact_ssn = 2) and (not(isDNBDMIrow));
     	 self.match.contactInfo.contactInfoMatch := tmpcontactInfoMatch;
			 
       tmpFname := if (not isDNBDMIrow,right.fname,'');
       self.match.ContactInfo.Name.First :=  tmpFname;
			 
       tmpLname := if (not isDNBDMIrow,right.lname,'');
			 self.match.ContactInfo.Name.Last :=  tmpLname;

       tmpMname := if (not isDNBDMIrow,right.mname,'');
			 self.match.ContactInfo.Name.Middle := tmpMname;	
			 tmpSSN := if (not isDNBDMIRow, right.contact_ssn,'');
			 self.match.ContactInfo.SSN := tmpSSN;
			 tmpSicCode := if (right.match_company_sic_code1 = 2, right.company_sic_code1, '');
			 tmpMatchSiccode := right.match_company_sic_code1 = 2;
			 self.match.SicInfo.sic := if (tmpMatchSicCode, tmpSicCode, '');
			 tmpRecord_score := right.record_score;
			 self.record_score := tmpRecord_score;  // carry over this field from the orginal set
			                                         // in order to sort on it later on.
      																						
       tmpProxWeight := right.proxWeight;																								
       self.ProxWeight := tmpProxWeight;			 			 
            
       tmp_fein_source := right.Source; 		
			 // this field may no longer be needed since E5 feins masked at GUI level.
			 self.Best_fein_source := if ( count(left.company_fein_sources) = 1,			                                     
                                      left.company_fein_sources[1].source,''); 
			 			 
			 self.match.businessIds.dotid := right.dotid;
			 tmpdotid := right.dotid;
			 self.match.businessIds.powid := right.powid;
			 tmppowid := right.powid;
			 self.match.businessIds.empid := right.empid;
			 tmpempid := right.empid;
			 self.match.businessIds.proxid := right.proxid;
			 tmpproxid := right.proxid;
			 self.match.businessIds.seleid := right.seleid;
			 tmpseleid := right.seleid;
			 self.match.businessIds.orgid := right.orgid;
			 tmporgid := right.orgid;
			 self.match.businessIds.ultid := right.ultid;
			 tmpultid := right.ultid;
			 
			 TopBusiness_Services.BusinessSearch_Layouts.matchRecScored tmpMatchRecXform() := TRANSFORM
			 			
			                                              self.businessIds.dotid := tmpdotid;
																										self.businessIds.powid := tmppowid;
																										self.businessIds.empid := tmpempid;
																										self.businessIds.proxid := tmpproxid;
																										self.businessIds.seleid := tmpseleid;
																										self.businessIds.orgid := tmporgid;
																										self.businessIds.ultid := tmpultid;
																										self.LastReported := MatchesVendorLastReported;
																										self.AddressFromDate :=  MatchesAddressFromDate;
																										self.AddressToDate := MatchesAddressToDate;
																										self.cnp_name := tmpmatchCleanedCompanyName;
			                                              self.CompanyNameInfo.companyName := tmpcname;																														                                            	 																										
																										self.AddressInfo.Address.UnitDesignation := tmpUnitDesig; // N/A since its not in input																									
																									  self.addressInfo.address.UnitNumber := tmpUnitNumber;
																										self.addressInfo.address.streetNumber := tmpPrimRange;
																										self.addressInfo.address.StreetName := tmpPrimName;	
																										self.addressInfo.address.StreetPreDirection := tmppredir;
																										self.addressInfo.Address.StreetPostDirection := tmpPostdir;	
																										self.AddressInfo.Address.StreetSuffix := tmpAddrSuffix;
																										self.AddressInfo.address.city := tmpvcity;
																										self.addressInfo.address.state := tmpSt;
																										self.addressInfo.address.zip5 := tmpzip;
																										self.addressInfo.address.zip4 := tmpzip4;
																										self.addressInfo.address.county := tmpcounty;
																										self.ContactInfo.ContactInfoMatch :=  TmpcontactInfoMatch;
																										self.contactInfo.name.first := if (tmpcontactInfoMatch, tmpFname, '');
																										self.contactInfo.name.middle := if (tmpcontactInfoMatch, tmpMname, '');
																										self.contactInfo.name.last := if (tmpcontactInfoMatch, tmpLname, '');
																										self.contactInfo.ssn := if (tmpcontactInfoMatch, tmpSSN, '');
																										 
																										self.tinInfo.TinInfoMatch := tmpTinInfoMatch;
                                                    self.TinInfo.tin := if (tmpTinInfomatch, tmpTin, '');
																										
																										self.TinInfo.TinSource := if (tmpTinInfoMatch, tmpTinSource, '');
																										self.SicInfo.Sic := if (tmpMatchSiccode, tmpSicCode, '');
																										self.EmailInfo.emailInfoMatch := tmpEmailINfoMatch;
																										self.emailInfo.email := if (tmpEmailInfoMatch, tmpEmail, '');
																										self.PhoneInfo.Phone10 := tmpPhone;
																										self.PhoneInfo.timezone := tmptimeZone;
																										self.ListingType :=  tmpListingType;
																										self.wirelessIndicator := tmpwirelessindicator;
                                                    self.record_score := tmpRecord_score;
																										self.proxweight := tmpProxWeight;      
                                                    self.fein_source := tmp_fein_source;   
																										 // these two fields not displayed at the GUI level
                                                     //
																										self.IsActive := Not(tmpisDefunct) and tmpisActive;
																										self.IsDefunct := tmpIsDefunct;
																										 
																										self := [];
																										END;
       tmpMatchRec := dataset( [tmpMatchRecXform() ]);
																																	
			 
       // this is comparing left.* (SELEIDBEST values) with the tmp* fiels (which are from Data2_ export i.e. proxid level)
			 // and if any of these booleans are true then keep the particular match record in the matches child DS																										 
			 // because its different than the fields from the SELEIDBest for that particular SELEID.
       needMatch :=   //left.company_name <> 	tmpcname OR //
			                  trim(left.cnp_name,left,right) <> tmpmatchCleanedCompanyName OR // 151798 bug. commented out above line for this bug.
                        trim(left.st,left,right) <> tmpst OR
												trim(left.zip,left,right) <> tmpzipCompare OR
												trim(left.city,left,right) <> tmpvcity OR
												trim(left.prim_name,left,right) <> tmpPrimNameCompare OR
												trim(left.prim_range,left,right) <> tmpPrimRangeCompare OR												
												trim(left.unit_desig,left,right) <> tmpUnitDesigCompare OR
												trim(left.sec_range,left,right) <> tmpUnitNumberCompare  OR 
												tmpcontactInfoMatch OR
												(tmpTinInfoMatch AND (NOT(left.match_company_fein = 2))) OR
												tmpEmailINfoMatch  OR
												tmpMatchSiccode;
     												
						// this 2nd boolean is neeeded in the case 
						// of singletonSourceD recs since left side (SELEID level) comes from 
						// SELEBEST export and only cname/city/st/phone fields
						// are returned from source = D thus in comparsion
            // in deciding if right side (proxid level match)
						// should be kept or not need to slim down the list of
						// fields needed in the comparision.
						//
       needMatchSlim := trim(left.cnp_name,left,right) <> tmpmatchCleanedCompanyName OR 
                        trim(left.st,left,right) <> tmpst OR										
												trim(left.city,left,right) <> tmpvcity OR
												 tmpcontactInfoMatch OR
												(tmpTinInfoMatch AND (NOT(left.match_company_fein = 2))) OR // ensure it not match from seleid
												                                                            //   side (left) or from proxid (right)
												tmpEmailINfoMatch OR
												tmpMatchSicCode;
											
        // if SourceDSingletonFlag then only compare cname/city/state
				// otherwise compare all cname/address information
			 self.matches := if ( (not(SourceDSingletonFlag)) and needMatch,				                 
													 tmpMatchRec,
													 if (SourceDSingletonFlag and NeedMatchSlim,													  
														tmpMatchRec
														));				               			
			     
			 self.DisplayReportLink := DisplayReportLink;
			 self.DNBDMIrecordOnly := DNBDMIrecordOnly;
			 
			 self.BusinessIDs.ProxID :=    right.proxID; // from topResultsScored_WirelessIndicator
			 self.BusinessIDs.SeleID :=    left.seleID; // from SELEBEST
			 self.BusinessIDs.OrgID  :=    left.OrgID;  // from SELEBEST
			 self.BusinessIDs.UltID  :=    left.UltID;	 // from SELEBEST
			 
			 self.BusinessIDs.powid :=    0; // from SELEBEST
			 self.BusinessIDs.empid  :=    0;  // from SELEBEST
			 self.BusinessIDs.dotid  :=    0;	 // from SELEBEST
			 
			 self.BusinessID :=  (string12) left.company_bdid; //from SELEBEST
			 			 
        // populate sourceDocs if there is just one row in search results for a particular proxid
			  // explanation in bug # : 124167
			
				//
				// ************ 149224
				// DisplayReportLink := Not(count(SELEIDsThatHaveOneRowInSearchResults(seleid = right.seleid)) > 0);
				// SourceDNBDMI_DisplayReportLink := Not(count(
				//                               SourceDSELEIDsThatHaveOneRowInSearchResults(seleid = right.seleid)) > 0);
				// 1. have two separate self.SourceDocs - one for regular seleid's.
				// 2. an empty SourceDocs for any SELEID has just 1 row and that row is Source = D
			  // 3. based on SourceDNBDMI_DisplayReportLink display only certain fields at the
				//    proxid level from left side in tmp_return_results_new
				//                                              SourceD_SELEIDsThatHaveOneRowInSearchResults
			 self.SourceDocs := if (NOT(DisplayReportLink), // and NOT(SourceDNBDMI_DisplayReportLinkandNoSourceDocs),
			                        dataset([transform(iesp.TopBusiness_share.t_TopBusinessSourceDocInfo,
															OtherDirectoriesSource := 
															(not( right.source in TopBusiness_Services.SourceServiceInfo.SourceSectionSources));													
															// idtype TopBusiness_Services.Constants.sourcerecid
															// idvalue left.sourcerec_id;
															
															IdType :=  if (MDR.sourceTools.SourceIsWC(right.source),
															                    TopBusiness_Services.Constants.watercraftsrcrec,
																									if (MDR.sourceTools.SourceIsVehicle(right.source),
																									  TopBusiness_Services.Constants.vehiclesrcrec,
																										if (MDR.SourceTools.SourceIsLiens(right.source),
																										  TopBusiness_Services.Constants.liensrcrec,
																											if (OtherDirectoriesSource or MDR.sourcetools.SourceIsBusiness_Registration(right.source),
																												     TopBusiness_Services.Constants.sourcerecid,
																														  // if (MDR.sourceTools.SourceIsBankruptcy(right.source),
																														    // 'source_docid',
															                   'vl_id')))); //);
															self.idtype := if ( not  ((MDR.sourceTools.SourceIsExperian_FEIN(right.source)) OR
																											SourceDSingletonFlag OR isDNBDMIRow),				  																		
															                   idType, '');
															IdValue := if (MDR.sourceTools.SourceIsWC(right.source) OR
															                    MDR.sourceTools.SourceIsVehicle(right.source) OR
																									MDR.SourceTools.SourceIsLiens(right.source) OR
																									MDR.sourcetools.SourceIsBusiness_Registration(right.source) OR
																									OtherDirectoriesSource, // see above for meaning of boolean.																									
															                   (string100) right.source_record_id, 
																								     if (MDR.sourceTools.SourceIsBankruptcy(right.source),
																									         right.source_docid,
																									        right.vl_id)
																									);											
																 self.idValue :=  if (not((MDR.sourceTools.SourceIsExperian_FEIN(right.source)) OR
																														SourceDSingletonFlag OR isDNBDMIRow),																								
															                   idValue, '');
															self.Section := '';															
															self.Source := if (  (not(SourceDSingletonFlag)) and (not(isDNBDMIRow)), right.source, '');
															
															self.businessIDs.dotid :=  if ( (Not(SourceDSingletonFlag)) and (not(isDNBDMIRow)), right.dotid, 0);																													
															self.businessIDs.empid :=  if ( (not(SourceDSingletonFlag)) and (not(isDNBDMIRow)), right.empid, 0);
															self.businessIDs.powid :=  if ( (not(SourceDSingletonFlag)) and (not(isDNBDMIRow)), right.powid, 0);	
															self.businessIDs.proxid := if ( (Not(SourceDSingletonFlag)) and (not(isDNBDMIRow)), right.proxid, 0);
															self.businessIDs.seleid := if ( (not(SourceDSingletonFlag)) and (not(isDNBDMIRow)), right.seleid, 0);
															self.businessIDs.orgid :=  if ( (not(SourceDSingletonFlag)) and (not(isDNBDMIRow)), right.orgid, 0);
															self.businessIDs.ultid :=  if ( (not(SourceDSingletonFlag)) and (not(isDNBDMIRow)), right.ultid, 0);
															self.address := [];
															self.name := [];					
														)])
														);
			   
	     self.ProxID     := right.proxId; // needed for the join to the WAF key -- NO LONGER NEEDED.
	     	     	
	     self.OrgID      := left.OrgId;	     
			 
			 self.seleID      := left.seleId;	     
	
	     self.UltID      := left.Ultid;
	     			 						 			
       self := []; 
			), left outer); //(seleid <> 0);	
			
			// this filter should not filtering anything out currently but leaving in as a double check 5/8/14 DGL.
			
			//tmp_return_results_new_sorted := sort(dedup(sort(tmp_return_results_new, seleid, -proxweight, -record_score, record), seleid), -proxweight, -record_score, record);
			// ******** END SWITCH LEFT/RIGHT
		
			          // already dedup/sort by proxid 
								
							// so join against WAF key and which returns multiple proxid 
							// so have to join the results and then do a rollup in order to
							// keep each row on in individual row
							// works because for any given row in WAF key
							// only 1 boolea will be true
							//...so basically do this sequence twice once for the main search result row
							// and then once for the ultimate parent in the search results if that
							// exists.
							// THIS WAF key is indexed at the proxid level
							//
       
			 SELEIDWAFBooleans := project(tmp_return_results_NEW, transform({
			                                                   BIPV2_WAF.Process_Biz_Layouts.id_stream_layout;																												
			                                                      boolean incorp;
																														boolean uccs;
																														boolean mvrs;
																														boolean prop;
																														boolean contacts;},																													
                       self.seleid := left.SELEID;
											 self.orgid := left.orgid;
											 self.Ultid := left.ultid;																														
			                 self.proxid := 0;
											 self.uniqueID := counter;
											 self := []
											 ));     
    // do the project to find just the rows in the search results that have a parent information
		// in them.
											  // need to filter here before I do join later because
												// not every row in the search results returned has a
												// ulitmate_proxid > 0.
												// could be that some proxid following project are
												// duplicated cause some different proxid's from original results
												// may in turn lead to same ultimate_proxid....so dedup/sort 
												// by proxid following project to acccount for this.
												// to reduce the left side of the join to the WAF key.
												//
       ultWAFBooleans := dedup(sort(project(tmp_return_results_New(ultimate.businessIDs.seleid > 0),
			 transform({BIPV2_WAF.Process_Biz_Layouts.id_stream_layout;
			                                                      boolean incorp;
																														boolean uccs;
																														boolean mvrs;
																														boolean prop;
																														boolean contacts;},																														
																		
											 self.seleid := left.ultimate.businessIDs.SELEID;
											 self.orgid := left.ultimate.businessIDs.orgid;
											 self.Ultid := left.ultimate.businessIDs.ultid;											 
											 self.proxid := 0;
											 self.UniqueID := counter;
											 self := []
											 )), seleid, record), seleid);							 											       
		
       SELEIDWAFBooleansIn := project(SELEIDWAFBooleans, transform(BIPV2_WAF.Process_Biz_Layouts.id_stream_layout,
			                           self.ultid := left.ultid;
																 self.orgid := left.orgid;
																 self.seleid := left.seleid;
																 self.uniqueId := left.UniqueId;
																 self.proxid := 0;
																 self := [];
																 ));
       ultWAFBooleansIn :=  project(UltWAFBooleans, transform(BIPV2_WAF.Process_Biz_Layouts.id_stream_layout,
			                           self.ultid := left.ultid;
																 self.orgid := left.orgid;
																 self.seleid := left.seleid;
																 self.uniqueId := left.UniqueId;
																 self.proxid := 0;
																 self := [];
																 ));			
  					 																 
			 SELE_SALT_WAF_FETCH := BIPV2_WAF.Externals.FetchEFR(SELEIDWAFBooleansIn, userpermits_SALT);
			                         
			 ULT_SALT_WAF_FETCH := 	BIPV2_WAF.Externals.FetchEFR(ultWAFBooleansIn, userpermits_SALT);																	 
								        
	     tmpSeleidWAFresult := join(SELEIDWAFBooleans, SELE_SALT_WAF_FETCH, 
               left.uniqueid = right.uniqueID,
							 transform(recordOf(left),							
								 self.ultid := left.ultid;
                 self.orgid := left.orgid;
                 self.seleid := left.seleid;
								 self.proxid := left.proxid;								
				                                        
								 self.incorp := right.child_id = BIPV2_WAF.Ext_Layouts.ID_Corps and right.cnt >=1; //uses salt
								 self.uccs :=   right.child_id = BIPV2_WAF.Ext_Layouts.ID_UCC and right.cnt >=1; // uses salt
								 self.mvrs :=  right.child_id = BIPV2_WAF.Ext_Layouts.ID_Vehicle and right.cnt >=1; // uses salt
								 self.prop :=   right.child_id = BIPV2_WAF.Ext_Layouts.ID_PropertyV2 and right.cnt >=1;	//uses salt												 
								 self.contacts := right.child_id = BIPV2_WAF.Ext_Layouts.ID_BizContacts and right.cnt >=1; //uses salt									
								 self := left));	
										
      tmpSeleidWAFresult RollitSELEID (recordof(tmpSeleidWAFresult) l,
															recordof(tmpSeleidWAFresult) r) := transform				
				  self.incorp := if (L.incorp, L.incorp, r.incorp);
					self.uccs := if (L.uccs, L.uccs, R.uccs);
					self.mvrs := if (L.mvrs, L.mvrs, R.mvrs);
					self.prop := if (L.prop, L.prop, R.prop);
				  self.contacts := if (L.contacts, L.contacts, R.contacts);	
					self := l;
				  self := r;							
				end;

			SeleidWAFResult := rollup(tmpSeleidWAFresult, rollitSELEID(left,right), left.uniqueID = right.UniqueID);	         								

// ** now do same thing for the ULT information

	    tmpULTWAFresult := join(ultWAFBooleans, ULT_SALT_WAF_FETCH, 
               left.uniqueid = right.uniqueID,
							 transform(recordOf(left),
							 
								self.ultid := left.ultid;
                self.orgid := left.orgid;
                self.seleid := left.seleid;
								self.proxid := left.proxid;								
				                                        
								self.incorp := right.child_id = BIPV2_WAF.Ext_Layouts.ID_Corps and right.cnt >=1; //uses salt
								self.uccs :=   right.child_id = BIPV2_WAF.Ext_Layouts.ID_UCC and right.cnt >=1; // uses salt
								self.mvrs :=  right.child_id = BIPV2_WAF.Ext_Layouts.ID_Vehicle and right.cnt >=1; // uses salt
								self.prop :=   right.child_id = BIPV2_WAF.Ext_Layouts.ID_PropertyV2 and right.cnt >=1;	//uses salt												 
								self.contacts := right.child_id = BIPV2_WAF.Ext_Layouts.ID_BizContacts and right.cnt >=1; //uses salt									
								self := left));	
										
      tmpULTWAFresult RollitULTID (recordof(tmpULTWAFresult) l,
		 													     recordof(tmpULTWAFresult) r) := transform				
				  self.incorp := if (L.incorp, L.incorp, r.incorp);
					self.uccs := if (L.uccs, L.uccs, R.uccs);
					self.mvrs := if (L.mvrs, L.mvrs, R.mvrs);
					self.prop := if (L.prop, L.prop, R.prop);
				  self.contacts := if (L.contacts, L.contacts, R.contacts);	
					self := l;
				  self := r;							
				end;

			UltIDWAFResult := rollup(tmpULTWAFresult, rollitULTID(left,right), left.uniqueID = right.UniqueID);							
			  
				// *************************************
				// important next 4 joins are left outer
				
				ds_add_waf := join(tmp_return_results_new, SeleidWAFResult,
				                  left.businessIDs.ULTID = right.ULTID and
						              left.businessIDs.ORGID = right.ORGID and
				                  left.businessIDs.SELEID = right.SELEID,
													
					transform(recordof(left),
                   self.best.alsofound.incorporations := right.incorp;
                   self.best.alsofound.uccs := right.uccs;
									 self.best.alsofound.mvrs := right.mvrs;
									 self.best.alsofound.properties := right.prop;
									 self.best.alsofound.contacts := right.contacts;
                   // adding logic here to 
									 // help show more 'TRUE' values in the 'displayReportLink' field.
									 // This is a fix for jira RQ 12882.  Basically some other seleids not on bip bus header
									 // key (i.e. set of search results) are showing up in other places such as property data
									 // and possibly any other sources we use in bip report.  So  for now reseting this boolean flag
									 // to true BUT ONLY if 'displayReportLink'  is false from above code 
									 // this will help BIP search results 
									 // provide more BIP report links (field displayReportLink = true) as sometimes
									 // per bip linking team property recs are not part of the Xlink process  because they are not a trusted source
									 // also part of logic is making sure
									 // making sure we dont' set displayReportlink  to true if its a DNBDMI singleton
									 //
									 // ...and also have to null out source docs if this flag does get flipped since
									 // source docs are not needed in the BIP search results if a BIP report link (ult/org/seleid values)
									 // is output
									 displayReportLinkEXTRA := if ( (NOT(left.displayReportLink)),
									                          ((right.incorp OR right.uccs OR right.mvrs OR right.prop
																						 OR right.contacts) AND 
																						                    (NOT(LEFT.DNBDMIrecordOnly))),
																						 left.displayReportLink);
                   self.displayreportLink := displayReportLinkEXTRA;
									 // if true dont display source docs but if false do show source docs as set above.
									 SELF.SourceDocs := if ( displayReportLinkEXTRA,
									                         dataset([],iesp.topbusiness_share.t_TopBusinessSourceDocInfo),
									                          left.SourceDocs
									                        );
									 self := left),
									 left outer);

        ds_add_UltWAF := join(ds_add_waf, UltIDWAFResult,
												  left.ultimate.businessIDs.ULTID = right.ULTID and
						              left.ultimate.businessIDs.ORGID = right.ORGID and
				                  left.ultimate.businessIDs.SELEID = right.SELEID,
													
					transform(recordof(left),
                   self.ultimate.alsofound.incorporations := right.incorp;
                   self.ultimate.alsofound.uccs := right.uccs;
									 self.ultimate.alsofound.mvrs := right.mvrs;
									 self.ultimate.alsofound.properties := right.prop;
									 self.ultimate.alsofound.contacts := right.contacts;
									 self := left),
									 left outer);	 			
							
				// ds_add_ultWAF contains both the addition of the SELEID WAF and the ultimate part (parent area)
				// WAF boolean 
        add_metadata_1 := join(ds_add_UltWAF,
															 unique_phones_gong_rolled,
			          left.businessIDs.ultid  = right.ultid AND
								left.businessIDs.orgid  = right.orgid AND			
								left.businessIDs.seleid = right.seleid AND
								left.businessIDs.proxid = right.proxid AND
								// left.businessIDs.dotid  = right.dotid AND
								// left.businessIDs.powid  = right.powid AND
								// left.businessIDs.empid  = right.empid AND												
								left.Matches[1].PhoneInfo.Phone10 = right.phone,  // this join condition is the "if" to set the match fields
								                                             // so no if is needed in the match part to conditionally set the 
																														 // various fields.
			  transform(recordof(left),								 				  					
			     //self.Matches.PhoneInfo.ListingName 
					 tmpcname := LEFT.matches[1].CompanyNameInfo.companyName;
					 tmp_listed_name := right.listed_name;
					 //tmp_timeZone := right.time_zone;
			     //self.Matches.listingType 
					 tmp_listing_type := right.listing_type;			    
					 tmp_active_eda := map (right.active_eda = 'Y' => true,
			                             right.active_eda = 'N' => false,
																	 false);

					 tmp_disconnected := map( right.disconnected = 'Y' => true,
			                                right.disconnected = 'N' => false,
																			false);
					 
					 tmpFromDate := iesp.ECL2ESP.toDate((unsigned)right.from_date);			     
					 tmpToDate := iesp.ECL2ESP.toDate((unsigned)right.to_date);           				 
           tmpSelfMatches := project(left.matches, TopBusiness_Services.BusinessSearch_Layouts.matchRecScored);                                 										 
						 tmpMatches := project(tmpSelfMatches, transform(TopBusiness_Services.BusinessSearch_Layouts.matchRecScored,										      
							 self.phoneInfo.ListingName := tmp_listed_name;
							 self.ListingType := if (left.ListingType <> 'F', // account for fax #
													             tmp_listing_type,
																			 left.ListingType);
	             self.ActiveEDA := tmp_active_eda;
							 // need to account for wireless telephones being in our files but
							 // listed in GONG has not having a current record.
               self.Disconnected  := tmp_disconnected; 
							 self.FromDate := tmpFromDate;
						   self.ToDate := tmpToDate;
							 
							 // override the header data with phone data if we have it.
							 // only if particular row on header has the companyPhone data will this override take place
							 // ** THESE 2 fields isActive and isDefunct not displayed on the BIP GUI.
							 // 
							 self.isActive := left.isActive OR tmp_active_eda;
							 self.IsDefunct := left.isDefunct and not(tmp_active_eda);													
							 self := left;													
						));
													
           self.matches := tmpMatches;   
					 self.businessIDs.proxid := 0; // now that we are done using it for join set it back to zero.
					 self.Ultimate.businessIds.proxid := 0; // zero out parent proxid as well.
			     self := left;
					 self := []),
		     left outer);

    // gongLinkidsHasCurrentPhone := exists(Gong.key_History_LinkIDs.kfetch(project(add_metadata_1, transform(BIPV2.IDlayouts.l_xlink_ids,
		                                                 // self.ultid := left.businessIDs.ultid,
																										 // self.orgid := left.BusinessIDs.orgid,
																										 // self.seleid := left.businessIDs.seleid,
																										 // self := [])))(Current_record_flag = 'Y'));
	
		add_metadata_2 := join(add_metadata_1,unique_phones_gong_rolled_SELEID,
		   left.businessIDs.ultid  = right.ultid AND
			 left.businessIDs.orgid  = right.orgid AND							
			 left.businessIDs.seleid = right.seleid AND
								// left.businessIDs.proxid = right.proxid AND								
								// left.businessIDs.powid  = right.powid AND
								// left.businessIDs.empid  = right.empid AND			
								// left.businessIDs.dotid  = right.dotid AND
			 left.Best.PhoneInfo.Phone10 = right.phone,  
			 transform(recordof(add_metadata_1), 
		 		 tmpcname := LEFT.BEST.companyNameInfo.companyName;
			   self.Best.PhoneInfo.ListingName := right.listed_name,
			   self.Best.ListingType := right.listing_type,  // best key (SELEIDBEST EXPORT) doesn't return a 
                                                     // listing type so no override here
				 self.Best.ActiveEDA := map (right.active_eda = 'Y' => true,
			                               right.active_eda = 'N' => false,
																	   false);			
         self.Best.Disconnected := map( right.disconnected = 'Y' => true,
			                                right.disconnected = 'N' => false,
																			false);
			   self.Best.FromDate := iesp.ECL2ESP.toDate((unsigned)right.from_date),
			   self.Best.ToDate := iesp.ECL2ESP.toDate((unsigned)right.to_date),			
			   // 2 additional overides from phone data
			   //   to the isActive and isDefunct fields set from SELEID best.
			   //
				 
			   self.Best.IsActive := left.Best.isActive OR (right.active_EDA = 'Y' and 
				                   (ut.StringSimilar(tmpcname ,right.listed_name) <= TopBusiness_Services.Constants.STRINGSIMILARCONSTANT));
				 //                         and gongLinkidsHasCurrentPhone);
			                             // for isActive and isDefunct
			                             // using phone data to override the best data (i.e. header data even though from SELEIDBEST EXPORT)                                  			 
         self.Best.IsDefunct := left.Best.isDefunct and NOT(right.active_EDA = 'Y'); // and gongLinkidskeyOverride)
			   self := left;
			   self := []),
		   left outer);		 
			
		  sorted_add_metadata_2 := sort(add_metadata_2, -proxweight,
		    -record_score, -Best.ToDate.Year, -Best.ToDate.Month, -Best.ToDate.Day,
		    if ((unsigned)Best.PhoneInfo.Phone10 != 0
				and length(Best.PhoneInfo.Phone10) = 10 and Best.PhoneInfo.Phone10[1] <> '1' and Best.PhoneInfo.Phone10[1] <> '0', 0, 1),		  
			  if (Best.TinInfo.Tin <> '', 0, 1), 
			  record);			 						 									 
				
      // NOTE constant within self.matches has word 'PRE' in it																		 
			TopBusiness_Services.BusinessSearch_Layouts.tmp_output_layout_full
			   RollMatchresults( TopBusiness_Services.BusinessSearch_Layouts.tmp_output_layout_full l,
													 TopBusiness_Services.BusinessSearch_Layouts.tmp_output_layout_full r) := transform																	 
														 self.matches := choosen(l.matches + r.matches,iesp.constants.topbusiness.MAX_COUNT_SEARCH_MATCH_PRE_ROLLUP_RECORDS);
														 self.proxweight := l.proxweight;
														 self.record_score := l.record_score;																	 																	 																	
														 self := l;
														 self := r;
                           end;
			//  rollup set of match recs:
											   
			 ds_sortedBySELEID_results :=  sort(sorted_add_metadata_2,			                      
														 seleid, // need to keep this criteria 1st since rolling up by seleid.
														 -proxweight,
														 -record_score,record);
														
       ds_rolled_results := rollup(ds_sortedBySELEID_results,
				                          left.seleid = right.seleid,
				                        rollMatchresults(left, right));       			        				                                 
				                        				               
        // since already sorted by proxweight before seleid rollup then the max proxweight within a seleid group
				// will automatically be on the same row as the seleid now so sorting by this brings top 
				// seleid to the top of DS
        //ds_rolled_results_sorted := sort(ds_rolled_results, -proxweight, -record_score,record);			
				
				ds_rolled_results_sorted := if (InputSearch[1].company_name = '' and
		                                 inputSearch[1].inSeleid = '0',
																		 sort(ds_rolled_results,
																		  -proxweight, 
																			 -record_score,
																		   ds_rolled_results.Best.CompanyNameInfo.CompanyName, record),
																							
																		 sort(ds_rolled_results, -proxweight,
																		 -record_score,record)
																		 );
				// dedup out the matches that are the same within a particular SELEID even if different proxids
				// and a lot of FIELDs to exclude in the dedup too.
				// set the boolean MoreMatchRecords accordingly for downstream cosmetics.
        ds_rolled_final := project(ds_rolled_results_sorted,
															transform({iesp.topbusinessSearch.t_TopBusinessSearchrecord; integer rid;},
															      tmpMatches := dedup(
																		                project(left.matches,
																		               transform(iesp.topbusinessSearch.t_TopBusinessMatchRecord,																									    
																											self := left))
																											,all, except addressFromDate.Year,
																											AddressFromDate.Month,
																											AddressFromDate.Day,
																											AddressToDate.Year,
																											AddressToDate.Month,
																											AddressToDate.Day,
																											FromDate.Year, FromDate.Month,FromDate.Day,
																											ToDate.Year,toDate.Month,ToDate.Day,		
																	 LastReported.Year, LastReported.Month,LastReported.Day,
																	 TinInfo.Tin,TinInfo.TinInfoMatch, 																	 
																	 TinInfo.TinSource,																	 
																	 emailInfo.email,EmailInfo.emailInfoMatch,
																	 ContactInfo.Name.First,contactInfo.Name.Last,contactInfo.name.Middle, contactInfo.ssn,
																	 ContactInfo.ContactInfoMatch,
																	 sicInfo.Sic,
																	 isActive,isDefunct,
																	 BusinessIds.Proxid,BusinessIds.dotid,BusinessIds.empid,BusinessIds.powid);																																															
																	
                                   self.matches := choosen(tmpMatches, iesp.constants.topbusiness.MAX_COUNT_SEARCH_MATCH_ROLLUP_RECORDS);                                    																																			
                                   self.MoreMatchRecords := count(tmpMatches) > iesp.constants.topbusiness.MAX_COUNT_SEARCH_MATCH_ROLLUP_RECORDS;																		
																	 self.rid := counter;
															     self := left,
																	 self := []));
																		
        // could do the join to acct within ds_seleidMatch here
				// ds_rolled_final2 := join(ds_rolled_final, ds_seleidMatch,				                         
				                           // left.acctno = right.acctno,
																	 // transform(recordof(left),
																	 // self.IsSeleidValid := right.valid_sele;
																	 // self := left),
																	 // left outer);       
				
				 // project the matches child Dataset into workable DS.							
				 ds_rolled_finalMatch := project(ds_rolled_final.matches, 
				              transform(iesp.topbusinessSearch.t_TopBusinessMatchRecord,
											         self := left,
															 self := []))(businessIds.seleid <> 0);	
															               // ^^^^^^^^^^^^^^^^^^^^^^^^
																						 // added this filter to account for blank rows
																// as the choosen on matches child DS above already
																// provides functionality to trim row count to max of the maxrows of the child DS (matches) 
																// as defined in the layout
															  // bug # : RQ 191185
																						 
				
         // call suppression macro on the child dataset of the ds_rolled_finalMatch (which is proxid list of records)
				 // 
		     Suppress.MAC_Mask(ds_rolled_FinalMatch, ds_rolledFinalMatchSuppress, contactInfo.SSN, blank, true, false);	
				 // since
				 // already sorted in correct order.
				 // so now group on seleid
				 ds_rolledFinalMatchSuppressFinal := group(ds_rolledFinalMatchSuppress,businessIds.seleid);
																												 
         // transform into the structure for the rollup called from below rollup
         iesp.topbusinessSearch.t_TopBusinessSearchRecord 
				      matchDetail(iesp.topbusinessSearch.t_TopBusinessMatchRecord le,
								 dataset(iesp.topbusinessSearch.t_TopBusinessMatchRecord) r) := transform									 
									 self.matches := r;
									 self := le;
									 self := [];
							end;
				 // rollup the matches  child DS that is in the format of iesp.topbusinessSearch.t_TopBusinessSearchRecord  structure				 
         ds_rolledFinalMatchSuppressFinalGroup := rollup(ds_rolledFinalMatchSuppressFinal, group, matchDetail(left, rows(left)));
				 
				 // rejoin the ds_rolledFinalMatch by selid and  then sort by the rid field and then project 
				 // out the sorted field.
				 ds_rolled_Suppressed := project(sort(join(ds_rolled_final, ds_rolledFinalMatchSuppressFinalGroup,				                              
                                   left.businessIds.seleid = right.businessIds.seleid,
                                   transform(recordof(left),
                                     self.matches := right.matches;
                                     self := left;																		
                                    ), left outer), rid), transform(iesp.topbusinessSearch.t_TopBusinessSearchRecord,
                                     self := left));
                                         
         ds_HeaderAndBusinessCreditRecs := TopBusiness_Services.BusinessSearch_BusinessCredit.fn_addBusinessCreditSingletons( InputSearch, ds_rolled_Suppressed, ds_BipIdsWithWeight, global_mod.dataPermissionMask );                                   
         
         ds_rolledRecsToReturn := IF( useBusinessCreditSorting, ds_HeaderAndBusinessCreditRecs, ds_rolled_Suppressed);
         
		xrecords :=  choosen(ds_rolledRecsToReturn,iesp.Constants.TOPBUSINESS.MAX_COUNT_SEARCH_RESPONSE_RECORDS);
		
		// important to check for 0 rows returned cause if we have athe possible_LAFN set via conditions above
		// and we have recs to return we DO NOT want to set LAFN here to true thus the and condition.
		
		iesp.TopBusinessSearch.t_TopBusinessSearchRecord xrecords_LAFNxFORM() := TRANSFORM		
		                      self.IsLAFN := possible_LAFN and (NOT(EXISTS(xrecords))); 													
                          SELF := [];
													END;
													
    xrecords_LAFN := dataset([xrecords_LAFNxFORM()] );
													   
    // put possible lafn 1st possible  and truncation 2nd and then all the regular recs from search results
		// in reality we will never have mult xrecords with a xrecords_LAFN
		// & keeps the DS in order across roxie calls thus perserving isLAFN or isTruncated being 1st row in return
		// results.
		ds_xrecords := xrecords_LAFN(isLAFN) & xrecords;
		
		TopBusiness_Services.BusinessSearch_Layouts.final format_out() := transform          
							       // self.lafn    := false;
										  // self.isTruncated := false;
										self.acctno  := ''; //left.acctno;
							      self.records := ds_xrecords;										                 
              end;																			
		tmpRecs := dataset([format_out() ]);
    noRecsReturned := NOT(EXISTS(xrecords)); //count(xrecords) = 0;
		
		// now create a dummy row of 1 only if the LAFN exists..basically just set the boolean
		// if 0 rows gets returned if 0 recs count in xrecords.
		//
		             TopBusiness_Services.BusinessSearch_Layouts.final LAFNxForm() := TRANSFORM
								    self.records := xrecords_LAFN;
										SELF := []
								 END;
    lafn := if (count(xrecords_LAFN(isLafn)) > 0, DATASET( [ LAFNxFORM() ] )
		            );
		
// OUTPUT(useBusinessCreditSorting, NAMED('useBusinessCreditSorting'));
// OUTPUT(ds_HeaderAndBusinessCreditRecs, NAMED('ds_HeaderAndBusinessCreditRecs'));
// OUTPUT(ds_rolled_Suppressed, NAMED('ds_rolled_Suppressed')); 
									    
    // output(ds_add_UltWAF, named('ds_add_UltWAF'));											
    // output(ds_sortedBySELEID_results, named('ds_sortedBySELEID_results'));
//		output(ds_rolled_results, named('ds_rolled_results'));
		// output(ds_rolled_final, named('ds_rolled_final'));		
    																				    										    											   															   
		// DEBUG INFO 
//    output(ds_seleidMatch, named('ds_seleidMatch'));
//		output(inputSearch, named('inputSearch'));
		// output(cntRecsReturned, named('cntRecsReturned'));
//		output(DRM);
//		output(in_options, named('in_options'));
		// output(userpermits_SALT, named('userpermits_SALT'));
//		output(lafn, named('lafn'));
		// output(choosen(ds_linkIDsNonRestricted, 500),  named('ds_linkIDsNonRestricted'));
		// OUTPUT(ds_rolled_Suppressed, NAMED('ds_rolled_Suppressed'));
    // OUTPUT(useBusinessCreditSorting, NAMED('useBusinessCreditSorting'));
		               
		// output(choosen(ds_linkIDsRestricted(source = 'BA'),500), named('ds_linkIDsRestricted'));
		// output(choosen(ds_linkIDsNonRestricted,500), named('ds_linkIDsNonRestricted'));
		// OUTPUT(ds_rolled_final, NAMED('ds_rolled_final'));
    		
    // output(trimmedResultSet, named('trimmedResultSet'));
		// OUTPUT(resultSetSlim, named('resultSetSlim'));
		// OUTPUT(NonSourceDSELEIDs, named('NonSourceDSELEIDs'));
		// OUTPUT(SourceDSELEIDs, named('SourceDSELEIDs'));
		// output(SingleTonSELEIDsInSearchResults,named('SingleTonSELEIDsInSearchResults'));
//		output(tmpSourceDNBDMISingleTonSELEIDsInSearchResults, named('tmpSourceDNBDMISingleTonSELEIDsInSearchResults'));
	
//		output(SourceDNBDMISingleTonSELEIDsInSearchResults, named('SourceDNBDMISingleTonSELEIDsInSearchResults'));		 
		
		// output(topResultsPreSuppress, named('topResultsPreSuppress'));
		// output(tmpTopResultsScored, named('tmpTopResultsScored'));
//		output(topResults, named('TopResults'));
		// output(topResultsScored_ultProxidFilter, named('topResultsScored_ultProxidfilter'));
		// output(topResultsScored_orgidDiffProxid, named('topResultsScored_orgidDiffProxid'));
//	  output(possible_Lafn, named('possible_lafn'));
//	  output(possible_truncation, named('possible_truncation'));
//	  output(ds_linkIDsNonRestricted, named('ds_linkIDsNonRestricted'));
//    output(ds_linkIDsRestricted, named('ds_linkIDsRestricted'));
//		output(ds_seleidBestWirelessIndicator, named('ds_seleidBestWirelessIndicator'));		 		
		// output(SearchResultsStats, named('SearchResultsStats'));
		// output(cntRecsReturned, named('cntRecsReturned'));
		// output(recs, named('recs'));
		
		// output(ds_add_UltWAF, named('ds_add_UltWAF'));
		//output(ds_seleidBest, named('ds_seleidBest'));
		// output(ds_seleidBestTmp, named('ds_seleidBestTmp'));
//		output(ds_ultLinkIDInfo, named('ds_ultLinkIDInfo'));
		
	//	output(ds_seleidBestWirelessIndicator, named('ds_seleidBestWirelessIndicator'));
		// output(TopResultsScored_WirelessIndicator, named('TopResultsScored_WirelessIndicator'));
		//output(ds_ultInfo, named('ds_ultInfo'));		
		// output(choosen(ds_linkIDsNonRestricted, 4500), named('ds_linkIDsNonRestricted'));	
		// output(choosen(ds_linkIDsRestricted,5000), named('ds_linkIDsRestricted'));		
		// output(count(ds_seleidBest), named('count_ds_seleidBest'));
		
		// output(ds_rolled_results, named('ds_rolled_results'));
    // output(ds_rolled_resultsTmp, named('ds_rolled_resultsTmp'));
		// output(ds_rolled_final, named('ds_rolled_final'));
//		output(ds_rolled_Suppressed, named('ds_rolled_Suppressed'));
		// output(ds_rolled_finalMatch, named('ds_rolled_finalMatch'));
    // output(tmp, named('tmp'));
		 // output(choosen(ds_linkIDsNonRestricted,5999), named('ds_linkidsNonRestricted'));
		// output(choosen(ds_linkIDsRestricted,5999), named('ds_linkidsRestricted'));
		// output(SeleidWAFResult, named('SeleidWAFResult'));
		// output(UltIDWAFResult, named('UltIDWAFResult'));
//		output(TopResultsScored, named('TopResultsScored'));
		// output(tmpTopResultsScored, named('tmpTopResultsScored'));	
	  // OUTPUT(sort(choosen(ResultSetSlim(proxweight = firstproxweight and record_score = firstRecScore) , 5000), -dt_last_seen, record),
	          // NAMED('ResultSetSlim'));
	  // output(search_results_slimSicCode, named('search_results_slimSicCode'));	 
		// output(sorted_add_metadata_3, named('sorted_add_metadata_3'));
		 //output(ResultSetSlim, named('ResultSetSlim'));
		
    // output(topResultsPreSuppress, named('topResultsPreSuppress'));
	  // output(TopResultsScored_wirelessIndicator, named('TopResultsScored_wirelessIndicator'));
	  // output(tmp_return_results_NEW, named('tmp_return_results_new'));
		// output(tmp_return_results_NEW_sorted, named('tmp_return_results_new_sorted'));
				
		// output(tmp_return_results_NEWExpFein, named('tmp_return_results_NEWExpFein'));
		// output(tmp_return_results_NEWExpFeinSuppressed, named('tmp_return_results_NEWExpFeinSuppressed'));			 			
		// output(tmp_return_results_NEW2, named('tmp_return_results_new2'));
		// output(CountNumOfSourcesPerProxid, named('CountNumOfSourcesPerProxid'));
		
		// output(unique_phones, named('unique_phones'));
		// output(unique_phones_wgongdata_0, named('unique_phones_wgongdata_0'));
		// output(unique_phones_wgongdata_1, named('unique_phones_wgongdata_1'));
		
		// output(unique_phones_wgongdata, named('unique_phones_wgongdata'));
		// output(unique_phones_against_names, named('unique_phones_against_names'));
		// output(unique_phones_gong_rolled, named('unique_phones_gong_rolled'));
		  
		// output(deduped_unique_phones_SELEID, named('deduped_unique_phones_SELEID'));
		// output(unique_phones_wgongdata_0_SELEID, named('unique_phones_wgongdata_0_SELEID'));
		// output(unique_phones_wgongdata_1_SELEID, named('unique_phones_wgongdata_1_SELEID'));
		
		// output(unique_phones_wgongdata_SELEID, named('unique_phones_wgongdata_SELEID'));
		// output(unique_phones_gong_rolled_SELEID, named('unique_phones_gong_rolled_SELEID'));
		// output(TmpdsUltLinkIdInfo, named('TmpdsUltLinkIdInfo'));
		// output(ds_UltlinkIDInfo, named('ds_UltlinkIDInfo'));
		// output(ds_ultinfo, named('ds_ultinfo'));
		// output(ds_ultInfoWireless, named('ds_ultInfoWireless'));
   
		// output(proxidWAFBooleans, named('proxWAFBooleans'));
		// output(ultWAFBooleans, named('ultWAFBooleans'));
	  // output(SeleidWAFResult, named('SeleidWAFResult'));
		// output(SELE_SALT_WAF_FETCH, named('SELE_SALT_WAF_FETCH'));
		// output(ULTidWAFResult, named('ULTIDWAFRESULT'));
		// output(tmpDs_add_WAF, named('tmpDs_add_WAF'));
		// output(tmpDs_add_UltWAF, named('tmpDs_add_UltWAF'));
	   //output(ds_add_waf, named('ds_add_waf'));
		// output(ds_add_ultwaf, named('ds_add_ult_waf'));
		
	 // output(unique_phones_SELEID, named('unique_phones_SELEID'));
	 // output(unique_phones_wgongdata_0_SELEID, named('unique_phones_wgongdata_0_SELEID'));
	 //output(choosen(add_metadata_1,25), named('add_metadata_1'));
		// output(choosen(add_metadata_2,20), named('add_metadata_2'));				
		// output(TopResultsScored, named('TopResultsScored')); 
		//output(choosen(add_metadata_2,25), named('add_metadata_2'));
		// output(sorted_add_metadata_2, named('sorted_add_metadata_2'));
		
		 
    //**
		// output(ds_rolled_results_sorted,named('ds_rolled_results_sorted'));
		 
		
		//**
		// output(ds_rolled_final2, named('ds_rolled_final2'));		
	// output(ds_seleidBest, named('ds_seleidBest'));
	
		// output(sorted_add_metadata_3, named('sorted_add_metadata_3'));
		// output(ds_sortedBySELEID_results, named('ds_sortedBySELEID_results'));
	   // output(ds_rolled_results, named('ds_rolled_results'));			
		 // output(ds_rolled_results_sorted, named('ds_rolled_results_sorted'));
		 // output(ds_rolled_final, named('ds_rolled_final'));
		 
//		output(ds_rolled_finalMatch, named('ds_rolled_finalMatch'));
//		output(ds_rolledFinalMatchSuppress, named('ds_rolled_FinalMatchSuppress'));
		
//		output(ds_rolledFinalMatchSuppressFinal, named('ds_rolledFinalMatchSuppressFinal'));
//		output(ds_rolledFinalMatchSuppressFinalGroup, named('ds_rolledFinalMatchSuppressFinalGroup'));
		// output(ds_rolled_Suppressed, named('ds_rolled_Suppressed'));
		//output(gongLinkidsHasCurrentPhone, named('gongLinkidsHasCurrentPhone'));
   
 
    
     export recs := if (noRecsReturned, lafn, tmpRecs);											 
	END;							

END;


