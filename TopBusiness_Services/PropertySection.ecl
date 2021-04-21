import iesp, ut, Census_Data,AutoStandardI,Codes,MDR,  LN_propertyv2, topBusiness_services, bipv2,
   LN_PropertyV2_Services, std;

export PropertySection := module

shared  getFieldName2(string1 inChar)
                       := case(inChar,
												'F' => 'FAR_F',
												'R' => 'FAR_F',
												'S' => 'FAR_S',
												'O' => 'OKCTY',
												'D' => 'DAYTN',
												'');								

EXPORT fn_fullView(
	dataset(TopBusiness_Services.PropertySection_Layouts.rec_Input) ds_in_data
	,TopBusiness_Services.PropertySection_Layouts.rec_OptionsLayout in_options
	,AutoStandardI.DataRestrictionI.params in_mod	
 ,string120 ReportCompanyName
	 ,unsigned2 in_sourceDocMaxCount = iesp.Constants.TopBusiness.MAX_COUNT_BIZRPT_SRCDOC_RECORDS
  ,unsigned2 in_propertyRecordsMaxCount = iesp.Constants.TopBusiness.MAX_COUNT_BIZRPT_PROPERTY_RECORDS
  ,unsigned2 in_propertyTotalRecsMaxCount = iesp.Constants.TopBusiness.MAX_COUNT_BIZRPT_PROPERTY_TOTAL_RECS
	) := function	
	
	FETCH_LEVEL := in_options.businessReportFetchLevel;
	property_recs_raw := TopBusiness_Services.Key_Fetches(project(ds_in_data, 
	                transform(BIPV2.IDlayouts.l_xlink_ids, self := left, self := [])),	                            
									FETCH_LEVEL,
									TopBusiness_Services.Constants.PropertyKfetchMaxLimit
									).ds_prop_linkidskey_recs;
  
   // this is set for use later to determine "current" flag.  Shows the name of the company that the report is run
	 // against.
  CnameReport := ReportCompanyName; 
																	
 	property_recs_dedup := dedup(property_recs_raw, all);
	 //
	 // build up the mortgage info
	 //
	 // LN_PropertyV2.layout_deed_mortgage_common_model_base
	 // LN_PropertyV2.layout_property_common_model_base

    TmpMort_info_forLNFARESIDNoExplosCodes := sort(dedup(
	                                 join(property_recs_raw,																	      
																	      LN_PropertyV2.key_deed_fid(),																	     
																	keyed(left.ln_fares_id = right.ln_fares_id)
																	AND if(in_options.IncludeAssignmentsAndReleases, true, not LN_PropertyV2.fn_isAssignmentAndReleaseRecord(right.record_type,right.state,right.document_type_code)), //flag is for checking if BK assignments and releases should be
																																																																																								//included. If not remove the rcd types for assgns and releases.
																	transform(TopBusiness_Services.PropertySection_layouts.rec_mortgage,																																		
																	self.st := right.state;
																	self.apn := right.apnt_or_pin_number;
																	self.in_ln_fares_id := left.ln_fares_id;
																	self.ln_fares_id := right.ln_fares_id;
																	self.recordingDate := iesp.ecl2esp.toDatestring8(right.recording_date);
																	self.contractDate := iesp.ecl2esp.toDatestring8(right.contract_date);
																	self.vendor := right.vendor_source_flag; 
																  self.loandate := iesp.ecl2esp.toDateString8(
                                                     if (right.contract_date <> '', 
																										  right.contract_date, right.recording_date));
																	self.loanamount := iesp.ECL2ESP.FormatDollarAmount(right.first_td_loan_amount);
																	self.loanamount2 := iesp.ECL2ESP.FormatDollarAmount(right.second_td_loan_amount);
																	self.lenderName := right.lender_name;
																	self.buyer_or_borrower_ind := right.buyer_or_borrower_ind;
																	                             												        																
																	self.firstTDLenderTypeCode := right.first_td_lender_type_code;
																	self.firstTDloantypecode := right.first_td_loan_type_code;																	
																																	
                                  self.DocumentTypeCode := 			right.Document_type_code;																			             
                                   self.Description := '';																									
                                   self.LoanType := '';                                  																							
																	 self.TransactionTYpe := '';	
																	 self.FaresTransactionType := '';
																	self := right), 
																	keep(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_PROPERTY_DEED_RECORDS))
																	,all, record)
																	,if (loandate.year<> 0 and loandate.month <> 0 and loandate.day <> 0,0,1)
																	   ,-loandate.year,-loandate.month,-loandate.day);


  Mort_Info_forLNFARESID_MortgageDeedType := JOIN(TmpMort_info_forLNFARESIDNoExplosCodes, Codes.Key_Codes_V3,
																					 RIGHT.file_name='FARES_1080' and 
																					 RIGHT.field_name='DOCUMENT_TYPE' AND
																						getFieldName2(LEFT.ln_fares_id[1]) =  RIGHT.field_name2 AND
		                                        LEFT.DocumentTypeCode = RIGHT.code,																					
																					TRANSFORM(RECORDOF(LEFT),																				 
		                                       SELF.Description := RIGHT.long_desc;
																					 SELF := LEFT), LEFT OUTER,limit(TopBusiness_Services.Constants.DefaultJoinLimit));
  
	 tmpMort_info_forLNFARESID := JOIN(Mort_Info_forLNFARESID_MortgageDeedType, Codes.Key_Codes_V3,
																					 RIGHT.file_name='FARES_2580' and 
																					 RIGHT.field_name='MORTGAGE_LOAN_TYPE_CODE' AND
																						getFieldName2(LEFT.ln_fares_id[1]) =  RIGHT.field_name2 AND
		                                        LEFT.firstTDloantypecode = RIGHT.code,																					
																					TRANSFORM(RECORDOF(LEFT),																				 
		                                       SELF.LoanType := RIGHT.long_desc;
																					 SELF := LEFT), LEFT OUTER,limit(TopBusiness_Services.Constants.DefaultJoinLimit));																		 
 																		 
																		 
 Mort_info_forLNFARESID_NoExplosionCodes := join(tmpMort_info_forLNFARESID, 
                                      LN_PropertyV2.key_addl_fares_deed_fid, 
																			keyed(left.ln_Fares_id = right.Ln_fares_id),
																			transform(recordof(left),																																					 
 
															field_name_2 := getFieldName2(left.ln_fares_id[1]);
															self.faresTransactionType := right.fares_transaction_type;			 
														
                              Description := project(Codes.Key_Codes_V3(file_name='FARES_2580' and 
					                                                   field_name = 'MORTGAGE_DEED_TYPE' and field_name2 = field_name_2 
																														 and code = right.fares_mortgage_deed_type),
																														 transform({string30 s;},self.s := left.long_desc;))[1].s;																			                                                               																											
                              self.Description := 			if (right.fares_transaction_type <> '', Description,
																	                             left.Description);
															self := left;
														),left outer, limit(0), keep(1));

  

  Mort_info_forLNFARESID := JOIN(Mort_info_forLNFARESID_NoExplosionCodes, Codes.Key_Codes_V3,
																					 RIGHT.file_name='FARES_1080' and 
																					 RIGHT.field_name='TRANSACTION_TYPE' AND
																						getFieldName2(LEFT.ln_fares_id[1]) =  RIGHT.field_name2 AND
		                                        LEFT.FaresTransactionType = RIGHT.code,																					
																					TRANSFORM(RECORDOF(LEFT),																				 
		                                       SELF.TransactionType := RIGHT.long_desc;
																					 SELF := LEFT), LEFT OUTER,limit(TopBusiness_Services.Constants.DefaultJoinLimit));																					                               
  property_recs_projectedTmp :=  project(property_recs_dedup,
		transform({       property_recs_dedup.ultid;
							 property_recs_dedup.orgid;
               property_recs_dedup.seleid;
							 property_recs_dedup.proxid;
							 property_recs_dedup.powid;
							 property_recs_dedup.empid;
							 property_recs_dedup.dotid;
							 property_recs_dedup.ln_fares_id;
							 unsigned4 owner_date;
							 string1 party_type;
							 string1 current_record;
                                      // new additions here.
                                      string10				prim_range;
	string2					predir;
	string28				prim_name;
	string4					suffix;
	string2					postdir;
	string10				unit_desig;
	string8					sec_range;
	// string25				p_city_name;
	string25				v_city_name;
	string2					st;
	string5					zip;
	string4					zip4;
     string5                         county;
							 },	
      self.ultid := left.ultid;
			self.orgid := left.orgid;
			self.seleid := left.seleid;
			self.proxid := left.proxid;
			self.powid := left.powid;
			self.empid := left.empid;
			self.dotid := left.dotid;
						
			self.ln_fares_id := left.ln_fares_id,
			self.party_type := left.source_code[1];
			self.owner_date := left.dt_last_seen * 100; // 100 here cause dt_last_seen needed to be 8 char length
			self.current_record := 'Y'; 
                // new addition
                self := left;
			)); 			  
      
    // adding new code
       property_recs_projected := join(property_recs_projectedTmp, Census_Data.Key_Fips2County,
                                                          keyed(left.st = right.state_code) and 
			                                         keyed(left.county[3..5] = right.county_fips),
                                                         transform({ iesp.share.t_Address property_address; 
							 property_recs_dedup.ultid;
							 property_recs_dedup.orgid;
                                      property_recs_dedup.seleid;
							 property_recs_dedup.proxid;
							 property_recs_dedup.powid;
							 property_recs_dedup.empid;
							 property_recs_dedup.dotid;
							 property_recs_dedup.ln_fares_id;
							 unsigned4 owner_date;
							 string1 party_type;
							 string1 current_record;},
                                       CountyName :=  right.county_name;
                                        self.property_address := iesp.ECL2ESP.SetAddress(
																	left.prim_name,left.prim_range,left.predir,left.postdir,
																	left.suffix,left.unit_desig,left.sec_range,left.v_city_name,
																	left.st,left.zip,left.zip4,CountyName,'','','','');
                                        self := left), LEFT OUTER, LIMIT(10000));
               
       // end  // new code       
	 property_partyPayload_rawTmp := join(property_recs_projected, LN_PropertyV2.key_search_fid(),
		                            keyed(left.ln_fares_id = right.ln_fares_id),																									 
																transform(
																  {
																	 property_recs_projected.current_record;
																	 unsigned6 ultid;
																	 unsigned6 orgid;
																	 unsigned6 seleid;
																	 unsigned6 proxid;
																	 unsigned6 powid;
																	 unsigned6 empid;
																	 unsigned6 dotid;
																	 string12 in_ln_fares_id;
																	 string45 apn;
																	 TopBusiness_Services.PropertySection_layouts.rec_party;                                                                                         
																	 },																													
																																					
																	self.ultid        := left.ultid,
																	self.orgid        := left.orgid,
																	self.seleid       := left.seleid,
																	self.proxid       := left.proxid,
																	self.powid        := left.powid,
																	self.empid        := left.empid,
																	self.dotid        := left.dotid,
																	self.company_name := right.cname;
                                                                                           self.name_last    := right.lname,
																	self.name_first   := right.fname,
																	self.name_middle  := right.mname,
																	self.name_suffix  := right.name_suffix,
																	self.name_title   := right.title,
																	self.party_type   := right.source_code[1]; // owner, buyer,seller(source_code[1] ='O' or source_code[1] = 'B' or source_code[1] = 'S'),
																	self.party_type_address := right.source_code[2];
																	self.vendor       := right.vendor_source_flag;
																	self.source       := right.source_code[1];
																	self.ln_fares_id  := right.ln_fares_id;
																	self.in_ln_fares_id := left.ln_fares_id;
																	self.owner_date   := left.owner_date;                                                                                                   
																	// lot of fields set by this self := right
																	self := right;
																	self := []), limit(0),
																	keep(TopBusiness_Services.Constants.SearchFidKeyConstant));
	                                 // separated out since there were dups in the seller rows 
																	 // and this way I get all the sellers
 // new code                                   
  property_partyPayload_raw := join(property_partyPayload_rawTmp, Census_Data.Key_Fips2County,
                                                                         LEFT.st = RIGHT.state_code AND
                                                                         LEFT.county[3..5] = RIGHT.county_fips,
                                                                         transform(RECORDOF(LEFT),
                                                                          countyName := RIGHT.county_name;
                                                                          self.property_address := iesp.ECL2ESP.SetAddress(
																	left.prim_name,left.prim_range,left.predir,left.postdir,
																	left.suffix,left.unit_desig,left.sec_range,left.v_city_name,
																	left.st,left.zip,left.zip4,countyName,'','','','');		
                                                                          self.ownerSeller_address := if (left.party_type_address <> 'P',
																	                            iesp.ECL2ESP.SetAddress(
																      left.prim_name,left.prim_range,left.predir,left.postdir,
																	left.suffix,left.unit_desig,left.sec_range,left.v_city_name,
																	left.st,left.zip,left.zip4,countyName,'','','',''));
                                                                          self := LEFT), LEFT OUTER,LIMIT(10000));
                                                                          
  // end  // new code     
																	 
  property_partyPayload		:= dedup(join(sort(property_partyPayload_raw, ln_fares_id),LN_PropertyV2.key_assessor_fid(),
	                                    keyed(left.ln_fares_id = right.ln_fares_id),
																			transform(recordof(left),
																			   // set current record here from accessor key
																			   self.Current_record := right.current_record;
																				 self := left),
																				 left outer,limit(TopBusiness_Services.Constants.PropertySectionKeepLimit,skip)
																				 ),all);																	 
		
  property_partySellers     := property_partyPayload(party_type = 'S' and (party_type_address = 'S' OR
	                                                                         party_type_address = 'P') and owner_date <> 0);
  property_partySellersSlim := dedup(property_partySellers, except owner_date);
	
	// now take this set and join against property_partyPayload using ln_fares_id	
	Property_partyPayloadSellersSlim := property_partyPayload(party_type='S' and (party_type_address='P' OR party_type_address='S') and owner_date <> 0);
	property_partySellersAll := dedup(join(property_partySellersSlim,  Property_partyPayloadSellersSlim,	                     
	                                 left.ln_fares_id = right.ln_fares_id,
																	 transform(left),limit(0),keep(TopBusiness_Services.Constants.PropertyKeepConstant)),all);
  																 
	property_partyPayloadSlim := property_partyPayload(party_type <> 'S' and party_type_address <> 'S') + property_partySellersAll;
																	 
   // contains just party_type <> S	 
	 property_partyPayloadDeduped1 := dedup(sort(property_partyPayloadSlim(party_type<> 'S'),
	                                            #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																							party_type,ln_fares_id,party_type_address,
																							current_record,Name_last,name_first,name_middle,
	                                            -owner_date,if (property_address.state <> '', 0, 1), record),
																							#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																							party_type,ln_fares_id, party_type_address,
																							current_record,Name_last,name_first,name_middle
																							);																							
    		
		 // contains party_type = S only but possible dups (cause owner ln_fares_id may be in 
		 // attr property_partyPayloadDedup1
     // so had to remove these dups later thus left only join below.
		 //				 
	 	 property_partyPayloadDeduped2 := sort(dedup(sort(property_partyPayloadSlim(party_type='S'),
	                                            #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																							ln_fares_id,
																							company_name,
																							Name_last,name_first,name_middle,ownerseller_address.state,																		
	                                            -owner_date,if (property_address.state <> '', 0, 1),																							           
																													record),
																							#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																							ln_fares_id, company_name, 																						
																							 Name_last,name_first,name_middle,ownerseller_address.state
																							), ln_fares_id);
																							

    Seller_ln_fares_ids := 	project(dedup(sort(property_partyPayloadDeduped2(party_type = 'S' and party_type_address = 'S'),
		                                              ln_fares_id),ln_fares_id),transform({string12 ln_fares_id},
																									         self.ln_fares_id := left.ln_fares_id));    																													 
    //																													 
    // contains all the party type = S recs but no ln_fares_ids that have party_type = S and party_type_address = S
		// 
		
	  property_partyPayloadDeduped4 := join(property_partyPayLoadDeduped2, seller_ln_fares_ids,
		                                                left.ln_fares_id = right.ln_fares_id,
																										transform(recordof(left),
																										  self := left), left only);
		// 
    //contains only ln_fares_ids that have  party_type = s and party_type_address = S																											
		// had to do these next two attrs to eliminate dups in final output.
		//
    Seller_ln_fares_idPayload := join(seller_ln_fares_ids, property_partyPayloadDeduped2,
		                                    left.ln_fares_id = right.ln_fares_id,
																				  transform(right),limit(0),keep(TopBusiness_Services.Constants.PropertyKeepConstant));
    Seller_ln_fares_idPayloadSlim :=  Seller_ln_fares_idPayload(party_type_address = 'S');
																							
   Property_partyPayloadDeduped := sort(property_partyPayloadDeduped1 + property_partyPayloadDeduped4 + Seller_ln_fares_idPayloadSlim, ln_fares_id);	 
   
	 // party_type_addresses here are types S,  (Seller) P (Property), O (Owner)
	 //
	 // now sort the property party information
	 	
   property_Transaction :=  project(property_partyPayloadDeduped,
														  transform(TopBusiness_Services.PropertySection_layouts.rec_PropertyTransactionExtra,
															self.ln_fares_id := left.ln_fares_id;
													     self.companyName := left.company_name;															 
															 self.Name := iesp.ECL2ESP.setName(left.name_first, left.name_middle, left.name_last,
																                                 left.name_suffix, left.name_title, '');
                               // this is owner address and is NOT a property address 																									 															 
															 self.Address := if (left.party_type_address = 'O' or left.party_type_address = 'B' OR
															                     left.party_type_address  ='S',
															                        left.ownerSeller_address); 																																										                       
                               self.partyType := left.party_type;
															 self.party_type_address := left.party_type_address;
															 ));
	
	   foreclosureNODSection :=  TopBusiness_Services.ForeclosureNODSection.fn_fullView(
	                      ds_in_data,
												FETCH_LEVEL,
												in_options.IncludeVendorSourceB
												);
                    
    nod := nofold(foreclosureNODSection).NoticeOfDefaults : onwarning(2131, ignore);
    
    foreclos := nofold(foreclosureNODSection).Foreclosures : onwarning(2131, ignore);
   
   // BROKE out this project into a 2nd one
	 // in order to reduce # of recs.
	 //
	 property_TransactionSlim := dedup(property_Transaction, all);
	 property_transactionO := property_TransactionSlim(partyType='O');
	 property_transactionS := property_TransactionSlim(partyType='S' and (party_type_address='S' OR party_type_address='P'));
   property_transactionB := property_TransactionSlim(partyType='B' and party_type_address='B');

  //
  // changed adding party child DS (owners, sellers, etc, and fores/nods) to
	// use group denormalize so as to reduce memory footprint of query.
	//
   property_party1 := dedup(project(property_partyPayloadDeduped,				                           	                   
	                     transform(TopBusiness_Services.PropertySection_layouts.rec_propertyBizLayoutExtra,	                 											    											 
												 self.ln_fares_id    := left.ln_fares_id;														
                         self.owner_date     := left.owner_date;	
												 self.current_record := left.current_record;
												 self.isForeclosed := false;
												 self.IsNOD := false;												 
												 self := left;
												 self := [];
    										)), all,HASH);
    							 																
                            tmpOwners1 := project(property_transactionO,
													transform(TopBusiness_Services.PropertySection_layouts.transactionInfo,
														self.partyType := left.partytype;
														self.companyName := left.CompanyName;
                            self.address :=	if (left.party_type_address <> 'P', left.address);
														self := left;
														self := [];
														));
																													 
                   tmpOwners2Large := join(tmpOwners1,property_party1,
									                      left.ln_fares_id = right.ln_fares_id,
																			transform(TopBusiness_Services.PropertySection_layouts.transactionInfo,	 									                          
																						self := left,
																						self :=[]),limit(0), keep(TopBusiness_Services.Constants.PropertyKeepConstant));       															
                   tmpOwners2 := dedup(tmpOwners2Large, all,HASH);																						
																																				
					property_party1OwnerLarge := denormalize(property_partyPayloadDeduped, tmpowners2,
					                                      left.ln_fares_id = right.ln_fares_id,
																								group,
					                                    	transform(TopBusiness_Services.PropertySection_layouts.rec_propertyBizLayoutExtra,	 																								
																								 self.owners := project(choosen(dedup(sort(rows(right),
																								               companyName, if (address.state <> '', 0, 1))
																													            ,companyName), iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_PROPERTY_PARTY_RECORDS),
																																			  transform(iesp.TopBusinessReport.t_TopbusinessPropertyTransaction,
																																				self := left, self := []));
                                                  self := left,
																									self := []));	
																									
    property_party1Owner := dedup(property_party1OwnerLarge,all,HASH);
	
    tmpSellers := project(property_transactionS,
	         transform(TopBusiness_Services.PropertySection_layouts.transactionInfo,
							 self := left;
							 self := [];
					));
																													 
   tmpSellers2Large := join(tmpSellers,  property_party1,
	                  left.ln_fares_id = right.ln_fares_id,
																			transform(TopBusiness_Services.PropertySection_layouts.transactionInfo,	 									                          
																						self := left,
																						self :=[]),limit(0), keep(TopBusiness_Services.Constants.PropertyKeepConstant));
    tmpSellers2 := dedup(tmpSellers2Large, all,HASH);
     
		 property_party1Seller := denormalize(property_party1Owner, tmpSellers2,
		                              left.ln_fares_id = right.ln_fares_id,
																	group,
																	transform(TopBusiness_Services.PropertySection_layouts.rec_propertyBizLayoutExtra,																	
																	  self.Sellers := choosen(dedup(project(rows(right),
												                              transform(iesp.TopBusinessReport.t_TopbusinessPropertyTransaction,
                                                             self := left;
																														 self := [])),all),
																										iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_PROPERTY_PARTY_RECORDS);																	
                                    self := left));	

  tmpBorrowers := project(property_TransactionB,
	                             transform(TopBusiness_Services.PropertySection_layouts.transactionInfo,
							 self := left;
							 self := [];
					));
  tmpBorrowers2 := join(tmpBorrowers, property_party1,
	                  left.ln_fares_id = right.ln_fares_id,
																			transform(TopBusiness_Services.PropertySection_layouts.transactionInfo,	 									                          
																						self := left,
																						self :=[]),limit(0),keep(TopBusiness_Services.Constants.PropertyKeepConstant));			

  property_party := dedup(denormalize(property_party1Seller, tmpborrowers2,
		                              left.ln_fares_id = right.ln_fares_id,
																	group,
																	transform(TopBusiness_Services.PropertySection_layouts.rec_propertyBizLayoutExtra,
																	
																	self.borrowers := choosen(project(rows(right),
												                              transform(iesp.TopBusinessReport.t_TopbusinessPropertyTransaction,
                                                             self := left;
																														 self := [];
																														 )),
																										iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_PROPERTY_PARTY_RECORDS);	 																				
                                   self := left)),all,HASH);			
																	 
 tmpNods := PROJECT(nod, transform( //{string1 defendant_borrower_owner_et_al_indicator; 
                          iesp.TopBusinessReport.t_TopBusinessPropertyForeclosure,
																			    self := left));
  // tmpNODS_etAl_ind := PROJECT(tmpNODS(defendant_borrower_owner_et_al_indicator != ''),
	                       // TRANSFORM(iesp.TopBusinessReport.t_TopBusinessPropertyForeclosure,
												 // SELF.siteAddress1.streetNumber := LEFT.siteAddress2.streetNumber;
											   // SELF.siteAddress1.Streetname := LEFT.siteAddress2.Streetname;
													// SELF.siteAddress1.City := LEFT.siteAddress2.City; 
                          // SELF.siteAddress1.State := LEFT.siteAddress2.State;
                          // SELF.siteAddress1.zip5 := LEFT.siteAddress2.zip5;
													// SELF.siteAddress1.unitNumber := LEFT.siteAddress2.unitNumber;
													// SELF := LEFT));
			
  tmpNods2_Situs1 := join(tmpNODS, property_party1,             
									  left.siteAddress1.streetNumber  = right.property_Address.StreetNumber  and
											left.siteAddress1.Streetname = right.property_Address.StreetName  and
													left.siteAddress1.City = right.property_Address.city and																												 
													left.siteAddress1.city <> '' and
                          left.siteAddress1.State  = right.property_Address.state and
                          left.siteAddress1.zip5 = right.property_Address.zip5 and
													left.siteAddress1.zip5 <> '' and
													left.siteAddress1.unitNumber = right.property_Address.UnitNumber,																																																																
													transform(iesp.TopBusinessReport.t_TopBusinessPropertyForeclosure,
													 SELF := LEFT),limit(0), keep(TopBusiness_Services.Constants.PropertyKeepConstant)
													); 
													
 tmpNods2 := dedup(tmpNods2_Situs1, all,HASH);
	
 property_party_WNOD := denormalize(property_party, tmpNods2,
                          left.property_Address.StreetNumber  = right.siteAddress1.streetNumber and
											    left.property_Address.StreetName = right.siteAddress1.Streetname  and
													 left.property_Address.city  = right.siteAddress1.City and																												 
													                              right.siteAddress1.city <> '' and
                          left.property_Address.state = right.siteAddress1.State  and
                          left.property_Address.zip5 = right.siteAddress1.zip5 and
													                             right.siteAddress1.zip5 <> '' and
													left.property_Address.UnitNumber = right.siteAddress1.unitNumber,													
	                           group,
														 transform(TopBusiness_Services.PropertySection_layouts.rec_propertyBizLayoutExtra,
														       
                             self.NoticeOfDefaults := choosen(dedup(rows(right), all), 
															                         iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_FORECLOSURE_NODS);
                             self.owner_date     := left.owner_date;	
														 self.current_record := left.current_record;
												     self.isForeclosed := false;
												     self.IsNOD := false;												 												 
                             self := left;
														 self := []));																																							
		
  tmpFores := project(foreclos, transform(iesp.TopBusinessReport.t_TopBusinessPropertyForeclosure,
																			    self := left));										
	
	 tmpFores2 := dedup(join(tmpFores, property_party1,
	                 left.siteAddress1.streetNumber  = right.property_Address.StreetNumber  and
											left.siteAddress1.Streetname = right.property_Address.StreetName  and
													left.siteAddress1.City = right.property_Address.city and																												 
													left.siteAddress1.city <> '' and
                          left.siteAddress1.State  = right.property_Address.state and
                          left.siteAddress1.zip5 = right.property_Address.zip5 and
													left.siteAddress1.zip5 <> '' and
													left.siteAddress1.unitNumber = right.property_Address.UnitNumber,
													transform(left),limit(0), keep(TopBusiness_Services.Constants.PropertyKeepConstant)), all,HASH);
		
	property_party_WFORE_NODS := denormalize(property_party_WNOD, tmpFores2,
                          left.property_Address.StreetNumber  = right.siteAddress1.streetNumber and
											    left.property_Address.StreetName = right.siteAddress1.Streetname  and
													left.property_Address.city  = right.siteAddress1.City and																												 
													                              right.siteAddress1.city <> '' and
                          left.property_Address.state = right.siteAddress1.State  and
                          left.property_Address.zip5 = right.siteAddress1.zip5 and
													                             right.siteAddress1.zip5 <> '' and
													left.property_Address.UnitNumber = right.siteAddress1.unitNumber,
	                           group,
														 transform(TopBusiness_Services.PropertySection_layouts.rec_propertyBizLayoutExtra,
														       
                              self.Foreclosures := choosen(dedup(rows(right), all), iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_FORECLOSURE_NODS);
 
                              self.owner_date     := left.owner_date;	
												      self.current_record := left.current_record;
												      self.isForeclosed := false;
												      self.IsNOD := false;												 												 
                              self := left;
															self := []));
															
  property_party_dedup := dedup(sort(property_party_WFORE_NODS, ln_fares_id,
	                              if (exists(Sellers),0,1),
																if (exists(Borrowers),0,1),
																if (exists(Foreclosures),0,1),
																if (exists(NoticeOfDefaults),0,1)
	                                     ),
	                                ln_fares_id);           										 								
	 
	 TopBusiness_Services.PropertySection_layouts.MortgageInfo 	 
	 fillInMort(TopBusiness_Services.PropertySection_layouts.rec_Mortgage l) := transform
	     self.in_ln_fares_id := l.in_ln_fares_id;
			 self.ln_fares_id := l.ln_fares_id;
			 self.current_record := l.current_record;
     
			 // self.LoanAmount       := l.first_td_loan_amount; // from DEED KEY from assessor key  field : mortgage_loan_amount	 
	     // self.LoanAmount2      := l.second_td_loan_amount; 
			 //self.LoanType         := '';      // from DEED KEY
	 
	    // self.TransactionType  := project(LN_PropertyV2.key_assessor_fid()(keyed(ln_fares_id=l.ln_fares_id)),
			                                  // transform({string25 TransactionType;},
																				   // self.transactionType := //left.transactionType
																						                      //  left.document_Type;))[1].transactionType;																				   			                                   
	
	     //self.Description      := '';    // from DEED Key
 		   //self.LenderName       := l.lender_name;   // from DEED KEY		 
			 //self.LoanDate         :=l.recording_date;			
			 //self.loanType := '';
			 self.addressType := '';
			 self.documentType := '';
			 //self.description := '';
			 
			 self.AssessmentDate := iesp.ecl2esp.toDateString8('');		
			 self.saleDate := iesp.ecl2esp.TodateString8('');
			 //self.assessedTotalValue := '';
			 self := l;			 
			 self := [];
	 end;	 	  																		
	 
	 TopBusiness_Services.PropertySection_Layouts.rec_PropertyParent party_xform(
	 
		 TopBusiness_Services.PropertySection_layouts.denorm_layout l,
		 dataset(TopBusiness_Services.PropertySection_layouts.rec_propertyBizLayoutExtra) r)	:= transform	     																			
  		  self.Parties := project(r, 
			                        transform(			                
			                  TopBusiness_Services.PropertySection_layouts.rec_propertyBizLayoutExtra,                        
												tmpMortgages := 
												           project(Mort_info_forLNFARESID, fillInMort(left))
												                        (in_ln_fares_id = left.ln_fares_id and
																								(ln_fares_id[2] = 'M' or ln_fares_id[2] = 'D'));// and current_record <> 'Y');  // this left is from "r" param																								 
																																				                 																						
                        self.Mortgages := choosen(project(tmpMortgages,
												                    transform(iesp.topbusinessReport.t_TopBusinessPropertyMortgageInfo,
																						   self := left)),iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_PROPERTY_DEED_RECORDS);                        			                       																							                        
																																																																  																	 
			                  self := left,	//sets NOD/foreclosures																									
					));		 
     
      self.ln_fares_id := l.ln_fares_id;		
			self.in_ln_fares_id := l.in_ln_fares_id;
			 self.Property_Address := l.property_address; 																	
			                                    
			self.AssessmentDate := ''; // set later
			self.ultid        := l.ultid,
			self.orgid        := l.orgid,
			self.seleid       := l.seleid,
			self.proxid       := l.proxid,
		  self.powid        := l.powid,
			self.empid        := l.empid,
			self.dotid        := l.dotid,
			self.PropertyUniqueID     := l.ln_fares_id;			
			self.assessedTotalValue := ''; // set later
			self.marketLandValue    := ''; // set later
			self.marketTotalValue   := ''; // set later	
			self.vendor := '';
		  self.county_code := '';
			self.apn := ''; // possibly ln_fares_id
			self.legal_description := '';
			self.owner_date := l.owner_date;
			// CnamePropertyOwner := trim(project(r.owners, transform({string120 cname;},
			                                  // self.cname := left.CompanyName))[1].cname,left,right);
																				     
      // CnamePropertySeller1 := trim(project(r.Sellers, transform({string120 cname;},
			                                  // self.cname := left.CompanyName))[1].cname,left,right);				
      // CnamePropertySeller2 := trim(project(r.Sellers, transform({string120 cname;},
			                                  // self.cname := left.CompanyName))[2].cname,left,right);																					
      		
			// based on the company name that the report is being run on
      // set the current_flag based on a 'Y' or based on if the owner of the property matches the name of the company
			// the report is being run on
			// but if the Seller of the property matches the name of the company then set prior indicator
      
			// ownerScore := (ut.StringSimilar(stringlib.stringToUppercase(CnameReport), 
													                   // stringlib.stringToUppercase(CnamePropertyOwner)
																						 // )
																						 // < 5
														// ); 
														
      // sellerScore1 := (ut.StringSimilar(stringlib.stringToUppercase(CnameReport), 
													                   // stringlib.stringToUppercase(CnamePropertySeller1)
																						 // )
																						 // < 5
														// );
       // sellerScore2 := (ut.StringSimilar(stringlib.stringToUppercase(CnameReport), 
													                   // stringlib.stringToUppercase(CnamePropertySeller2)
																						 // )
																						 // < 5
														// );	
														
			//default to false (not current but prior which means current_flag = false)
			self.current_flag :=  l.current_record = 'Y'; //bug # : 179969
			                              // if (OwnerScore, ownerScore,
			                            // if( sellerScore1 OR sellerScore2, 
																	      // false, false)); 
																				// no need for prior logic cause if its not current then
																				// is prior by default. but still have logic here.			                     																	 
			self.property_id := '';
			self.isForeclosed := false; 		//for each row														 
			self.IsNOD := false; 	
			//self.CnamePropertyOwner := CnamePropertyOwner;
		  self := l;
	end;		
  
  // get all recs from the initial linkids join
	// whose party information is needed for population of return dataset later.
	
	// added this logic to ensure that property listing in ln_fares_id rows in search.fid key that don't have
	// a party type of 'P' just 'O' ....i.e.  so no property address info just owner address ....i.e. so that that prop rec don't get excluded in report output.

denorm1stParamLarge := project(property_partyPayLoadDeduped, 
	                    transform(TopBusiness_Services.PropertySection_layouts.denorm_layout,
	                     self.property_address := if (left.party_type_address = 'P', left.property_address);															                           													                            
					self := left));	
  denorm1stParamSlim := denorm1stParamLarge(party_type_address <> 'O' OR ln_fares_id[2]='D');														
 
 denorm1stParam := if (count(denorm1stParamSlim) = 0  and exists(Denorm1stParamLarge),
                                               Denorm1stParamLarge, denorm1stParamSlim);  

 denorm1stParam_all := dedup(denorm1stParam, all,HASH);	    	
	// FILL IN THE DEED INFORMATION
  recs_parent_child := denormalize(denorm1stParam_all,											
																		property_party_dedup,	  // property_party is all non property addresses
	                                                                  // buyer and seller
		left.ln_fares_id = right.ln_fares_id,	
		group,
		party_xform(left,rows(right)));			  	
					 					 

  recs_parent_child_slim := dedup(recs_parent_child, all,HASH);
	   	 																								 
    TopBusiness_Services.PropertySection_layouts.rec_PropertyIntermediateLayout
		 assessment_info(TopBusiness_Services.propertySection_Layouts.rec_propertyParent l,
											recordof(LN_PropertyV2.key_assessor_fid()) r
											) := transform
      self.county_land_use_description := r.county_land_use_description;
			self.PropertyUniqueID     := l.ln_fares_id;
			
			self.AssessmentDate      := r.assessed_value_year + '0000';
			self.recording_date       := r.recording_date;
			
			self.assessedTotalValue := iesp.ECL2ESP.FormatDollarAmount(r.assessed_total_value);
			self.marketLandValue    := iesp.ECL2ESP.FormatDollarAmount(r.market_land_value);
			self.marketTotalValue   := iesp.ECL2ESP.FormatDollarAmount(r.market_total_value);
							
			self.Property_Address := l.property_Address;			      										        							
       
				self.CountForeclosed := count(l.parties.Foreclosures);
				
				self.CountNOD := count(l.Parties.Noticeofdefaults);										       
        self.isForeclosed := exists(l.parties.Foreclosures); 																	 
				self.IsNOD := exists(l.Parties.Noticeofdefaults);
				// self.NOD_stamped_date := tmpNOD;
				// self.foreclosure_stamped_date := tmpFor;				
				self.DocumentType := //r.document_type;	
                             if (l.ln_fares_id[2] = 'A',	
				                     'ASSESSOR',''); // per bug # : 125826
				                      // this is transaction_type on output	
				//self.fares_unformatted_apn := r.fares_unformatted_apn;
				self.fares_unformatted_apn := r.apna_or_pin_number;
				//self.SaleDate := iesp.ECL2ESP.toDateString8( r.assessed_value_year + '0000');				
				self.SaleDate := iesp.ecl2esp.ToDateString8(r.sale_date);
				self.SalesPrice := r.sales_price;				
				//self.PropertyOwner := l.PropertyOwner;											
			  self.ultid        := l.ultid,
				self.orgid        := l.orgid,
				self.seleid       := l.seleid,
				self.proxid       := l.proxid,
				self.powid        := l.powid,
				self.empid        := l.empid,
				self.dotid        := l.dotid,
				self.foreclosure_stamped_date := [];
				self.nod_stamped_date := [];		 
		    // start of all the NON BIP related accurint fields.
			  // self.legalLotNumber := r.Legal_lot_number;			 
		    // self.legalSubdivisionName := r.legal_subdivision_name;
				
				  self.accessor.StateCode := r.state_Code;
	         self.accessor.FipsCode := r.fips_code;
	          self.accessor.DuplicateApnMultipleAddressId := r.duplicate_apn_multiple_address_id;
	          self.accessor.AssesseeOwnershipRightsCode := r.assessee_ownership_rights_code;
	         
	          self.accessor.assesseeRelationshipCode := r.assessee_relationship_code;							          
            self.accessor.ownerOccupied := r.owner_occupied;
 
            self.accessor.PriorRecordingDate := r.prior_recording_date;
	          self.accessor.CountyLandUseDescription := r.county_land_use_description;		
		        self.accessor.StandardizedLandUseCode := r.standardized_land_use_code;
		 		 		 		
	    self.accessor.LegalLotNumber := r.legal_lot_number;
	    self.accessor.LegalSubdivisionName := r.legal_subdivision_name;
	    self.accessor.RecordTypeCode := r.record_type_code;			                                   
	
	    self.accessor.MortgageLoanAmount := r.mortgage_loan_amount;
      self.accessor.MortgageLoanTypeCode := r.mortgage_loan_type_code;			 
			
	    self.accessor.MortgageLenderName := r.mortgage_lender_name;
	
      self.accessor.AssessedTotalValue := r.assessed_total_value;
      self.accessor.AssessedValueYear := r.assessed_value_year; 
      self.accessor.HomesteadHomeownerExemption := r.homestead_homeowner_exemption;			 
		  self.accessor.MarketImprovementValue := r.market_improvement_value;
      self.accessor.MarketTotalValue := r.market_total_value;
      self.accessor.MarketValueYear := r.market_value_year;
	
	    self.accessor.TaxAmount := r.tax_amount;
      self.accessor.TaxYear := r.tax_year;	
	    self.accessor.LandSquareFootage := r.land_square_footage;		
	    self.accessor.YearBuilt := r.year_built;		 
	    self.accessor.NumberOfStories := r.no_of_stories;
	    	
	    self.accessor.NumberOfBedrooms := r.no_of_bedrooms;
      self.accessor.NumberOfBaths := r.no_of_baths;
      self.accessor.NumberOfPartialBaths := r.no_of_partial_baths;
	
	  self.accessor.GarageTypeCode := r.garage_type_code;
	 
	  self.accessor.PoolCode := r.pool_code;
	   
	  self.accessor.ExteriorWallsCode := r.exterior_walls_code;
	   		                                     			
    self.accessor.RoofTypeCode := r.roof_type_code;
	 		                                         	
	  self.accessor.heatingCode := r.heating_code;	

    self.accessor.heatingFuelTypeCode := r.heating_fuel_type_code;
    
    self.accessor.airConditioningCode := r.air_conditioning_code;
   
    self.accessor.airConditioningTypeCode := r.air_conditioning_type_code;
   
				self := l;		       
				self := []; // added in cause adding all the accurint stuff
		 end;
		 		    		                          		 
		 Assessment_info_ds := join(recs_parent_child_slim, LN_PropertyV2.key_assessor_fid(),                                                                                              
		                         keyed(left.ln_fares_id = right.ln_fares_id),
														 assessment_info(left, right), left outer, keep(TopBusiness_Services.Constants.PropertyKeepConstant)
													 );
													   	
  Assessment_info_Ds_AddedLandUse := join(assessment_info_DS,Codes.key_codes_v3,
	                                      right.file_name='FARES_2580' and 
																				right.field_name='LAND_USE' AND
																							 getFieldName2(LEFT.ln_fares_id[1]) =  RIGHT.field_name2 and
		                                      LEFT.accessor.StandardizedLandUseCode = RIGHT.code,																					
																					TRANSFORM(RECORDOF(LEFT),																				 
		                                       SELF.landUsage := RIGHT.long_desc;
																					 SELF.AddressType := right.long_desc;
																					 SELF := LEFT), LEFT OUTER,limit(TopBusiness_Services.Constants.DefaultJoinLimit));
	
  Assessment_info_ds_AddedAC_TYPE := join(Assessment_info_Ds_AddedLandUse,Codes.Key_Codes_V3,
																				right.file_name='FARES_2580' and 
																				right.field_name='AIR_CONDITIONING_TYPE_CODE' AND
																							 getFieldName2(LEFT.ln_fares_id[1]) =  RIGHT.field_name2 and
		                                      LEFT.accessor.airConditioningTypeCode = RIGHT.code,																					
																					TRANSFORM(RECORDOF(LEFT),																				 
		                                       SELF.accessor.airConditioningTypeDesc := RIGHT.long_desc;
																					 SELF := LEFT), LEFT OUTER,limit(TopBusiness_Services.Constants.DefaultJoinLimit));
																					 
   Assessment_info_ds_AddedAC_DESC := join(Assessment_info_ds_AddedAC_TYPE, Codes.Key_Codes_V3,
																					 RIGHT.file_name='FARES_2580' and 
																					 RIGHT.field_name='AIR_CONDITIONING' AND
																						getFieldName2(LEFT.ln_fares_id[1]) =  RIGHT.field_name2 AND
		                                        LEFT.accessor.airConditioningCode = RIGHT.code,																					
																					TRANSFORM(RECORDOF(LEFT),																				 
		                                       SELF.accessor.airConditioningDesc := RIGHT.long_desc;
																					 SELF := LEFT), LEFT OUTER,limit(TopBusiness_Services.Constants.DefaultJoinLimit));
																					 
   Assessment_info_ds_AddedHEATINGFUELTYPE_DESC := join(Assessment_info_ds_AddedAC_DESC, Codes.Key_Codes_V3,
																						 right.file_name='FARES_2580' and 
																						 right.field_name='HEATING_FUEL_TYPE_CODE' and
																						 	getFieldName2(LEFT.ln_fares_id[1]) =  RIGHT.field_name2 and																						 
		                                        LEFT.accessor.heatingfuelTypeCode = RIGHT.code,																				
																					TRANSFORM(RECORDOF(LEFT),																				 
		                                       SELF.accessor.heatingFuelTypeDesc := RIGHT.long_desc;
																					 SELF := LEFT), LEFT OUTER,limit(TopBusiness_Services.Constants.DefaultJoinLimit));
																					 
   Assessment_info_ds_AddedheatingDesc := join(Assessment_info_ds_AddedHEATINGFUELTYPE_DESC, Codes.Key_Codes_V3,
																							right.file_name='FARES_2580' and 
																							right.field_name='HEATING' and
																								getFieldName2(LEFT.ln_fares_id[1]) =  RIGHT.field_name2 and																							
		                                        LEFT.accessor.heatingCode = RIGHT.code,																				
																					TRANSFORM(RECORDOF(LEFT),																				 
		                                       SELF.accessor.heatingDesc := RIGHT.long_desc;
																					 SELF := LEFT), LEFT OUTER,limit(TopBusiness_Services.Constants.DefaultJoinLimit));	
																					 
     Assessment_info_ds_roofTypeDesc := join(Assessment_info_ds_AddedheatingDesc, Codes.Key_Codes_V3,
																						right.file_name='FARES_2580' and 
																						right.field_name='ROOF_TYPE' AND
																						getFieldName2(LEFT.ln_fares_id[1]) =  RIGHT.field_name2 AND
		                                        LEFT.accessor.roofTypeCode = RIGHT.code,																					
																					TRANSFORM(RECORDOF(LEFT),																				 
		                                       SELF.accessor.roofTypeDesc := RIGHT.long_desc;
																					 SELF := LEFT), LEFT OUTER,limit(TopBusiness_Services.Constants.DefaultJoinLimit));	

     Assessment_info_ds_ExteriorWallsDesc := join(Assessment_info_ds_roofTypeDesc, Codes.key_codes_v3,
																							RIGHT.File_name = 'FARES_2580' and 
																							RIGHT.field_name='EXTERIOR_WALLS' AND
																							getFieldName2(LEFT.ln_fares_id[1]) =  RIGHT.field_name2 AND
		                                        LEFT.accessor.exteriorWallsCode = RIGHT.code,																					
																					TRANSFORM(RECORDOF(LEFT),																				 
		                                       SELF.accessor.exteriorWallsDesc := RIGHT.long_desc;
																					 SELF := LEFT), LEFT OUTER,limit(TopBusiness_Services.Constants.DefaultJoinLimit));
																					      
		 Assessment_info_ds_PoolDesc := join(Assessment_info_ds_ExteriorWallsDesc, Codes.Key_Codes_V3,
																					 RIGHT.file_name='FARES_2580' and 
																					 RIGHT.field_name='POOL_CODE' AND
																					 getFieldName2(LEFT.ln_fares_id[1]) =  RIGHT.field_name2 AND
		                                        LEFT.accessor.PoolCode = RIGHT.code,																					
																					TRANSFORM(RECORDOF(LEFT),																				 
		                                       SELF.accessor.PoolDesc := RIGHT.long_desc;
																					 SELF := LEFT), LEFT OUTER,limit(TopBusiness_Services.Constants.DefaultJoinLimit));				     

  Assessment_info_ds_NumberOfStories := join(Assessment_info_ds_PoolDesc, Codes.Key_Codes_V3,
																							RIGHT.file_name='FARES_2580' and 
																							RIGHT.field_name='STORIES_CODE' AND
																							getFieldName2(LEFT.ln_fares_id[1]) =  RIGHT.field_name2 AND
		                                        LEFT.accessor.NumberOfStories = RIGHT.code,																					
																					TRANSFORM(RECORDOF(LEFT),																				 
		                                       SELF.accessor.NumberOfStoriesDesc := RIGHT.long_desc;
																					 SELF := LEFT), LEFT OUTER,limit(TopBusiness_Services.Constants.DefaultJoinLimit));	
																					 
  Assessment_info_ds_MortgageLoanType := join(Assessment_info_ds_NumberOfStories, Codes.Key_Codes_V3,
																							 RIGHT.file_name='FARES_2580' and 
																							 RIGHT.field_name='MORTGAGE_LOAN_TYPE_CODE' AND
																							 getFieldName2(LEFT.ln_fares_id[1]) =  RIGHT.field_name2 AND
		                                        LEFT.accessor.MortgageLoanTypeCode = RIGHT.code,																					
																					TRANSFORM(RECORDOF(LEFT),																				 
		                                       SELF.accessor.MortgageLoanTypeDesc := RIGHT.long_desc;
																					 SELF := LEFT), LEFT OUTER,limit(TopBusiness_Services.Constants.DefaultJoinLimit));	
																					 
 Assessment_info_ds_RecordTypeCode := join(Assessment_info_ds_MortgageLoanType, Codes.Key_Codes_V3,
																			      RIGHT.file_name='FARES_2580' and 
																				    RIGHT.field_name='RECORD_TYPE_CODE' AND
																						getFieldName2(LEFT.ln_fares_id[1]) =  RIGHT.field_name2 AND
		                                        LEFT.accessor.RecordTypeCode = RIGHT.code,																					
																					TRANSFORM(RECORDOF(LEFT),																				 
		                                       SELF.accessor.RecordTypeDesc := RIGHT.long_desc;
																					 SELF := LEFT), LEFT OUTER,limit(TopBusiness_Services.Constants.DefaultJoinLimit));	

 Assessment_info_ds_STANDARDIZED_LAND_USE_CODE := join(Assessment_info_ds_RecordTypeCode, Codes.Key_Codes_V3,
																									RIGHT.file_name='FARES_2580' and 
																									RIGHT.field_name='STANDARDIZED_LAND_USE_CODE' AND
																									getFieldName2(LEFT.ln_fares_id[1]) =  RIGHT.field_name2 AND
		                                        LEFT.accessor.StandardizedLandUseCode = RIGHT.code,																					
																					TRANSFORM(RECORDOF(LEFT),																				 
		                                       SELF.accessor.StandardizedLandUseDesc := RIGHT.long_desc;
																					 SELF := LEFT), LEFT OUTER,limit(TopBusiness_Services.Constants.DefaultJoinLimit));

 Assessment_info_ds_OWNER_RELATIONSHIP_CODE := join(Assessment_info_ds_STANDARDIZED_LAND_USE_CODE, Codes.Key_Codes_V3,
																									RIGHT.file_name='FARES_2580' and  
																									RIGHT.field_name='OWNER_RELATIONSHIP_CODE' AND
																									getFieldName2(LEFT.ln_fares_id[1]) =  RIGHT.field_name2 AND
		                                        LEFT.accessor.assesseeRelationshipCode = RIGHT.code,																					
																					TRANSFORM(RECORDOF(LEFT),																				 
		                                       SELF.accessor.assesseeRelationshipDesc := RIGHT.long_desc;
																					 SELF := LEFT), LEFT OUTER,limit(TopBusiness_Services.Constants.DefaultJoinLimit));	

 Assessment_info_ds_OWNER_RELATIONSHIP_RIGHTS_CODE :=
			                              join(Assessment_info_ds_OWNER_RELATIONSHIP_CODE, Codes.key_codes_v3,
																					RIGHT.File_name = 'FARES_2580' and 
																					RIGHT.field_name='OWNER_OWNERSHIP_RIGHTS_CODE' AND
																					getFieldName2(LEFT.ln_fares_id[1]) =  RIGHT.field_name2 AND
		                                      LEFT.accessor.AssesseeOwnershipRightsCode = RIGHT.code,																					
																					TRANSFORM(RECORDOF(LEFT),																				 
		                                       SELF.accessor.AssesseeOwnershipRightsDesc := RIGHT.long_desc;
																					 SELF := LEFT), LEFT OUTER,limit(TopBusiness_Services.Constants.DefaultJoinLimit));																					 																					 																			      															
		                                             		                                       
		 // grab just the deed recs from the initial linkids and 
		 // put them into a format that can be used in the join to the deed fid key below
		 //		 												 
		
		   TopBusiness_Services.PropertySection_layouts.rec_linkids_plus_PropertyDetail
		 deed_info(TopBusiness_Services.PropertySection_layouts.rec_PropertyIntermediateLayout l,
		                recordof(LN_PropertyV2.key_deed_fid()) r
		                  ) := transform
        				        													 			  
  		  self.recordingDate := if (l.recording_date = '', iesp.ecl2esp.toDatestring8(r.recording_date),
				                                                 iesp.ecl2esp.toDatestring8(l.recording_date));
				self.contractDate := iesp.ecl2esp.toDatestring8(r.contract_date);			
				self.DocumentType := if (l.propertyUniqueID[2] ='D' OR l.propertyUniqueID[2] ='M','DEED',
				                         l.DocumentType);
																											
         self.apn              := if (l.fares_unformatted_apn <> '',
				                               l.fares_unformatted_apn,
				                               r.apnt_or_pin_number);			
																			 // note r.fares_unformatted_apn is actually already formatted
																			 // without '-' chars in it.
																			        											
				//self.SaleDate := l.saleDate;
				//self.SalesDate := iesp.ecl2esp.toDateString8(r.salesDate);
				// self.recordingDate := '';
				// self.contractDate := '';
				self.AssessmentDate   := iesp.ECL2ESP.toDate((unsigned4) l.AssessmentDate);				    		
				self.AssessmentDateCalculation := (unsigned4) l.AssessmentDate;
					
				self.marketlandValue  := l.marketLandValue;
				self.totalMarketValue := l.marketTotalValue;
				self.AssessedValue    := l.AssessedTotalValue;
				self.PropertyAddress  := if (l.Property_address.state = '' or l.property_address.county = ''
				                             and (l.propertyUniqueID[2] = 'D' OR l.propertyUniqueID[2] = 'M'),
                                      iesp.ECL2ESP.SetAddress(
																	 l.Property_address.StreetName, //prim_name,
																   l.Property_address.StreetNumber, //right.prim_range,
																   l.Property_address.StreetPreDirection, //right.predir,
																	 l.Property_address.StreetPostDirection,// right.postdir,
																	 l.Property_address.StreetSuffix,// right.suffix,
																	l.property_address.UnitDesignation,// right.unit_desig,
																	l.property_address.UnitNumber,// right.sec_range,
																	l.property_address.City,// right.v_city_name,
																	r.state,
																	l.property_address.Zip5,// right.zip,
																	l.property_address.Zip4,// right.zip4,
																	r.county_name,// tmpcounty,
																	'','','',''),
																	l.property_address);
				                             
				self.addrs_per_state  := 0;
				self.PropertyUniqueID := l.ln_fares_id;
				self.SourceObscure := if ((l.ln_fares_id[1] in ['R','F','S']),
				                            'A',
                                      if ((l.ln_fares_id[1] in ['D','O']), 'B',
																			//otherwise
																			'')
																			);
																										
				   self.PsourceDocs      := dataset([transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
						 self.source := MDR.sourceTools.fProperty(l.ln_fares_id);						 
						 self.BusinessIds.ultid :=  l.ultid;
						 self.BusinessIds.orgid := l.orgid;
						 self.BusinessIds.seleid := l.seleid;
						 self.BusinessIds.proxid := l.proxid;
						 self.BusinessIds.powid := l.powid;
						 self.BusinessIds.empid := l.empid;
						 self.BusinessIds.dotid := l.dotid;
						 self.IdType := topBusiness_services.constants.propertykeys;
					   self.IdValue := l.ln_fares_id,
					   self.Section := topBusiness_services.constants.PropertySectionName;
					   self.Name := [];
					 self.Address := [];)]					 
					 );
				    parties := project(l.parties, transform(iesp.topbusinessREport.t_TopBusinessPropertyParty,
					                          self := left));
             Foreclosures := project(parties.foreclosures, transform(iesp.topbusinessREport.t_TopBusinessPropertyForeclosure,
						                          self := left));
             NoticeOfDefaults := project(parties.NoticeOfDefaults, transform(iesp.topbusinessREport.t_TopBusinessPropertyForeclosure,
						                          self := left));																			
                FsourceDocs := dedup(project(foreclosures.FsourceDocs, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
						                           self := left)), all);                                        			
               NSourceDocs := dedup(project(NoticeOfDefaults.FsourceDocs, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
						                           self := left)), all);
        self.FSourceDocs := FsourceDocs + NSourceDocs;										
				self.isForeclosed    := l.isForeclosed; 
				                        
        self.IsNoticeOfDefault := l.isNOD; 
        // to mark Deed and Mort recs that are 'current'.	
				// tmpCurrentRecord := if (l.current_flag, 'Y','');
				tmpCurrentRecord := if (l.current_flag, 'Y',r.current_record);
				self.current_record := tmpCurrentRecord; 
				self.CurrentRecord :=  tmpCurrentRecord; 
				
				 salesPrice := if (l.salesPrice <> '',
				                       iesp.ECL2ESP.FormatDollarAmount(l.SalesPrice),
				                      iesp.ECL2ESP.FormatDollarAmount(r.Sales_Price)
															);
				                        
       ownerPartyCname := trim(project(parties.owners,
				                  transform({string120 cname;},
													 self.cname := left.CompanyName;))[1].cname, left, right);
        
				 ownerPartyCname2 := trim(project(parties.owners,
				                  transform({string120 cname;},
													 self.cname := left.CompanyName;))[2].cname, left, right);
													 
        sellerPartyCname := trim(project(parties.sellers,
				                    transform({string120 cname;},
														 self.cname := left.companyName;))[1].cname, left, right);                       											 
        sellerPartyCname2 := trim(project(parties.sellers,
				                    transform({string120 cname;},
														 self.cname := left.companyName;))[2].cname, left, right);
     
		
                          
				ownerMatch := (  
				                  (ut.StringSimilar(std.str.ToUpperCase(ownerPartyCname), 													
														std.str.ToUppercase(CnameReport)) < 5) 
													 OR
													((ut.StringSimilar(std.str.ToUppercase(OwnerPartyCname2),
														std.str.ToUppercase(CnameReport))) < 5)
										  );
																										
				SellerMatch :=	(
				                 (ut.StringSimilar(std.str.ToUppercase(sellerPartyCname),														
														std.str.ToUppercase(CnameReport)) < 5)
														 OR
												 ((ut.StringSimilar(std.str.ToUppercase(SellerPartyCname2),													
														std.str.ToUppercase(CnameReport))) < 5)
											);

        OwnerSellerMatch := ownerMatch and SellerMatch;
			
				SalePriceColumn := Map(
							               ownerSellerMatch and (tmpcurrentRecord = 'Y' ) => 'PURCHASE',
														 ownerSellerMatch and Not(tmpCurrentRecord = 'Y' ) => 'SALE',
														 OwnerMatch and (tmpCurrentRecord = 'Y' ) => 'PURCHASE',
														 OwnerMatch and Not(tmpCurrentRecord ='Y' ) => 'PURCHASE',
														 SellerMatch and not(tmpCurrentRecord = 'Y' ) => 'SALE',
														 SellerMatch and (tmpCurrentRecord = 'Y') => 'SALE',
														 ((Not(ownerMatch)) and (not(sellerMatch))  and tmpcurrentRecord = 'Y')
                                                               => 'PURCHASE',
                              ((Not(ownerMatch)) and (not(sellerMatch))  and (Not(tmpcurrentRecord = 'Y')))
															                                 => 'SALE',
																															 '');
																															         
				self.purchasePrice := if (salePriceColumn = 'PURCHASE', salesPrice, '');
				self.salesPrice := if (salePriceColumn  = 'SALE', salesPrice, '');
				
				// start of all the NON bip related accurint desired fields																 
					self.deeds.state := r.state;
					self.deeds.countyName := ''; 
	        self.deeds.lenderName := r.lender_Name;
	        self.deeds.legalBriefDescription := ''; 
	        self.deeds.documentTypeCode := r.document_Type_Code;
         													
	      self.deeds.armResetDate := r.arm_Reset_Date;
	      self.deeds.documentNumber := r.document_Number;
				self.deeds.recorderBookNumber := r.recorder_Book_Number;
	      self.deeds.recorderPageNumber := r.recorder_Page_Number;
	      self.deeds.landLotSize := r.land_lot_size;
	      self.deeds.cityTransferTax := r.city_transfer_tax;
        self.deeds.countyTransferTax := r.county_transfer_tax;
        self.deeds.totalTransferTax := r.total_transfer_tax;
        self.deeds.propertyUseCode := r.property_use_code;
      
        self.deeds.firstTdLoanAmount := r.first_td_loan_amount;
        self.deeds.firstTdLoanTypeCode := r.first_td_loan_type_code;
       
        self.deeds.typeFinancing := r.type_financing;
        self.deeds.firstTdInterestRate := r.first_td_interest_rate;
        self.deeds.firstTdDueDate := r.first_td_due_date;
        self.deeds.titleCompanyName := r.title_company_name;
				self := l;
				self := []; // added back in since adding all the accurint stuff.
			end;		 		
    // join against deed key and add counter as well.				
	  // do a left outer here
    tmp_deed_info_plus_assessmentWITHOUTDEED_EXPLOSIONCODES := join(Assessment_info_ds_OWNER_RELATIONSHIP_RIGHTS_CODE,
		                            LN_PropertyV2.key_deed_fid(),		                   
                         keyed(left.in_ln_fares_id = right.ln_fares_id) and 											     
														 (left.ln_fares_id[2]='D' or left.ln_fares_id[2]='M')
														 AND if(in_options.IncludeAssignmentsAndReleases, true, not LN_PropertyV2.fn_isAssignmentAndReleaseRecord(right.record_type,right.state,right.document_type_code)), //flag is for checking if BK assignments and releases should be
																																																																																								//included. If not remove the rcd types for assgns and releases.
											   deed_info(left, right), left outer,keep(TopBusiness_Services.Constants.PropertyKeepDeedConstant));


    tmp_deed_info_plus_assessment_adding_docment_type_desc := 
		                          join(tmp_deed_info_plus_assessmentWITHOUTDEED_EXPLOSIONCODES, Codes.key_codes_v3,
																					RIGHT.File_name = 'FARES_1080' and 
																					RIGHT.field_name='DOCUMENT_TYPE' AND
																					getFieldName2(LEFT.PropertyUniqueID[1]) =  RIGHT.field_name2 AND
		                                      LEFT.Deeds.Documenttypecode = RIGHT.code,																					
																					TRANSFORM(RECORDOF(LEFT),																				 
		                                       self.deeds.documentTypeDesc := RIGHT.long_desc;
																					 SELF := LEFT), LEFT OUTER,limit(TopBusiness_Services.Constants.DefaultJoinLimit));										
		                    
      tmp_deed_info_plus_assessment_adding_property_use_desc := 		
                              join(tmp_deed_info_plus_assessment_adding_docment_type_desc , Codes.key_codes_v3,
																					RIGHT.File_name = 'FARES_2580' and 
																					RIGHT.field_name='PROPERTY_IND' AND
																					getFieldName2(LEFT.PropertyUniqueID[1]) =  RIGHT.field_name2 AND
		                                      LEFT.Deeds.propertyusecode = RIGHT.code,																					
																					TRANSFORM(RECORDOF(LEFT),																				 
		                                       self.deeds.propertyUseDesc := RIGHT.long_desc;
																					 SELF := LEFT), LEFT OUTER,limit(TopBusiness_Services.Constants.DefaultJoinLimit));										
																					 												 												
      tmp_deed_info_plus_assessment_adding_FirstTDLoadTypeDesc := 		
                              join(tmp_deed_info_plus_assessment_adding_property_use_desc , Codes.key_codes_v3,
																					RIGHT.File_name = 'FARES_2580' and 
																					RIGHT.field_name='MORTGAGE_LOAN_TYPE_CODE' AND
																					getFieldName2(LEFT.PropertyUniqueID[1]) =  RIGHT.field_name2 AND
		                                      LEFT.Deeds.firsttdloantypecode = RIGHT.code,																					
																					TRANSFORM(RECORDOF(LEFT),																				 
		                                       self.deeds.firstTdLoanTypeDesc := RIGHT.long_desc;
																					 SELF := LEFT), LEFT OUTER,limit(TopBusiness_Services.Constants.DefaultJoinLimit));										
	
	  tmp_deed_info_plus_assessmentLARGE := project( tmp_deed_info_plus_assessment_adding_FirstTDLoadTypeDesc,    
		                                              transform({unsigned4 rid;recordof(left);},
												 self.rid := counter;
												 self := left));
												 
   // attempt to filter out some recs that are similar.
   tmp_deed_info_plus_assessment_slimmer := Dedup(project(tmp_deed_info_plus_assessmentLARGE,
	                                            transform(recordof(left),																						
																							self.PsourceDocs := [];
																							self.FsourceDocs := [];
																							self := left)),all, except propertyUniqueId,rid,AssessedValue,
																							 Accessor.assessedTotalValue,Accessor.TaxYear,Accessor.TaxAmount,APN);
   																							
   tmp_deed_info_plus_assessment := project(join(tmp_deed_info_plus_assessment_slimmer, 
	                                        tmp_deed_info_plus_assessmentLARGE,
																					left.rid = right.rid,
																					transform(recordof(left),
																					self.PSourceDocs := right.PsourceDocs;
																					self.FsourceDocs := right.FsourceDocs;
																					tmpState := left.parties[1].owners[1].address.State;
																					tmpCounty := left.parties[1].owners[1].Address.county;
																								                                          																							
																					self.propertyAddress := if (left.PropertyAddress.state = '' and left.propertyAddress.County = '',																															 
																							iesp.ECL2ESP.SetAddress(
																									right.propertyAddress.streetName,right.propertyAddress.StreetNumber,right.propertyAddress.streetPredirection,right.propertyAddress.StreetPostdirection,
																									right.propertyAddress.StreetSuffix,right.propertyAddress.UnitDesignation,right.propertyAddress.UnitNumber,right.propertyAddress.City,
																								tmpState,
																							right.propertyAddress.zip5,right.propertyAddress.zip4,tmpCounty,'','','','')
																							, left.propertyAddress);																															 																																																				                          
																					self := left)), transform(TopBusiness_Services.PropertySection_layouts.rec_linkids_plus_PropertyDetail,
																					self := left));
																							
    TopBusiness_Services.PropertySection_layouts.rec_linkids_plus_PropertyDetail
					fares_info(TopBusiness_Services.PropertySection_layouts.rec_linkids_plus_PropertyDetail l,
		                recordof(LN_PropertyV2.key_addl_fares_tax_fid) r) := transform
		                 											               								
	              self.deeds.FaresMortgageTermCode     := r.Fares_Mortgage_Term_Code;
	           								                                
	              self.deeds.FaresMortgageTerm         := r.Fares_Mortgage_Term;
								self.deeds.FaresIrisApn              := r.Fares_IRIS_APN;
								self := l;
								self := [];
              end;											
											
    fares_deed_info := join(tmp_deed_info_plus_assessment, LN_PropertyV2.key_addl_fares_tax_fid,
		                       keyed(left.PropertyUniqueID = right.ln_fares_id),													 
													 fares_info(left,right),
													 left outer,limit(0),keep(1));
    fare_deed_info_withexplosionCode := join(fares_deed_info , Codes.key_codes_v3,
																					RIGHT.File_name = 'FARES_1080' and 
																					RIGHT.field_name='MORTGAGE_TERM_CODE' AND
																					'FAR_F' =  RIGHT.field_name2 AND
		                                      LEFT.Deeds.FaresMortgageTermCode = RIGHT.code,																					
																					TRANSFORM(RECORDOF(LEFT),																				 
		                                       self.deeds.FaresMortgageTermCodeDesc := RIGHT.long_desc;
																					 SELF := LEFT), LEFT OUTER,limit(TopBusiness_Services.Constants.DefaultJoinLimit));										 												 
	 
	         TopBusiness_Services.PropertySection_layouts.rec_linkids_plus_PropertyDetail 
					transaction_deed_info1(TopBusiness_Services.PropertySection_layouts.rec_linkids_plus_PropertyDetail l,
		                recordof(LN_PropertyV2.key_addl_fares_deed_fid) r) := transform
																				
							  //field_nametwo := getFieldName2(l.propertyUniqueID[1]);		                 											              
								self.deeds.FaresTransactionType     := r.Fares_Transaction_Type;								
								self.deeds.FaresMortgageDeedType     := r.Fares_Mortgage_Deed_Type;	             
								self := l;
								self := [];
               end;
  
   fares_transaction_deed_infoNoExplosionCode := join(fare_deed_info_withexplosionCode,
																	LN_PropertyV2.key_addl_fares_deed_fid,
																	 keyed(left.PropertyUniqueID = right.ln_fares_id),																	 
																	transaction_deed_info1(left,right),
																	  left outer, limit(0), keep(1)); 
   																		
   fares_transaction_deed_info_FaresTransactionTypeDesc :=  join(fares_transaction_deed_infoNoExplosionCode , Codes.key_codes_v3,
																					RIGHT.File_name = 'FARES_1080' and 
																					RIGHT.field_name='TRANSACTION_TYPE' AND
																					getFieldName2(LEFT.PropertyUniqueID[1]) =  RIGHT.field_name2 AND
		                                      LEFT.deeds.FaresTransactionType = RIGHT.code,																					
																					TRANSFORM(RECORDOF(LEFT),																				 
		                                       self.deeds.FaresTransactionTypeDesc := RIGHT.long_desc;
																					  SELF := LEFT), LEFT OUTER,limit(TopBusiness_Services.Constants.DefaultJoinLimit));										 												 
	 
	 fares_transaction_deed_info := join(fares_transaction_deed_info_FaresTransactionTypeDesc , Codes.key_codes_v3,
																					RIGHT.File_name = 'FARES_1080' and 
																					RIGHT.field_name='MORTGAGE_DEED_TYPE' AND
																					getFieldName2(LEFT.PropertyUniqueID[1]) =  RIGHT.field_name2 AND
		                                      LEFT.deeds.FaresMortgageDeedType = RIGHT.code,																					
																					TRANSFORM(RECORDOF(LEFT),																				 
		                                       self.deeds.FaresMortgageDeedTypeDesc := RIGHT.long_desc;
																					  SELF := LEFT), LEFT OUTER,limit(TopBusiness_Services.Constants.DefaultJoinLimit));										 												 
							            
   // now that source docs are filled in with all the Older accessor recs
	 // get rid of all the extra older than current or older than most
	 // recent assessed year and dedup by property address
	 //
	 // need to dedup the accessor recs by the sourceObscure by the source obscured field in order
	 // to keep accessors recs from both source "A" and source "B"
	 AccessorRecsWithSellers := dedup(fares_transaction_deed_info(exists(parties.sellers)),
	                                    except propertyUniqueId);																			         																		
	 //
	 tmp := dedup(sort(fares_transaction_deed_info(propertyUniqueId[2]='A'),
		                   propertyAddress.state, propertyAddress.city, propertyAddress.zip5, 
											 propertyAddress.StreetName,PropertyAddress.StreetNumber,SourceObscure, if (current_record ='Y',0,1), -AssessmentDate,
									 if (county_land_use_description = 'PERSONAL_PROPERTY', 0, 1))
										,propertyAddress.state, propertyAddress.city, propertyAddress.zip5,
									  propertyAddress.StreetName,PropertyAddress.StreetNumber,SourceObscure);
																						
     // now add back in the non assessor recs (deed/mort recs)
		
    tmp_deed_info_plus_assessment_extra := tmp + fares_transaction_deed_info(propertyUniqueId[2]<>'A') + 
		                                        AccessorRecsWithSellers; 
														
    tmp_deed_info_plus_assessment_extra_slim := dedup(dedup(sort(tmp_deed_info_plus_assessment_extra, 		                                                  
																										      PropertyUniqueID, SourceObscure , 
		                                                          if (propertyAddress.state <> '', 0, 1),
																															if (propertyAddress.zip5 <> '', 0,1), 
																															if (propertyAddress.streetNumber <> '', 0, 1),
																															if (propertyAddress.StreetName <> '', 0, 1),
																															if (county_land_use_description = 'PERSONAL_PROPERTY', 0, 1)),
																															 PropertyUniqueID,SourceObscure),all);																															 
    																														  
    // join back to mort attr to get the APN in the final output.																															 
    tmp_deed_info_plus_assessment_extra_slimWMortgageAPN :=
		                  join(tmp_deed_info_plus_assessment_extra_slim(propertyUniqueID[2]='M'),
											       Mort_info_forLNFARESID,											      
														  left.propertyUniqueID = right.ln_fares_id,
															transform(recordof(left),
															  self.apn := right.apn;																
																// used to sort later in dedup.
																self.recordingDate := right.RecordingDate; 																											
																self := left), left outer);
																				
      tmp_deed_info_plus_assessment_extra_slim2 := tmp_deed_info_plus_assessment_extra_slim(propertyUniqueId[2] <> 'M') &			                                                
			                                             tmp_deed_info_plus_assessment_extra_slimWMortgageAPN;
    
     deed_info_plus_assessmentLarge := project(tmp_deed_info_plus_assessment_extra_slim2, 
																	transform(
		                               TopBusiness_Services.PropertySection_layouts.rec_linkids_plus_PropertyDetail_ForeclosureNOD,
																	  self := left));
   																	
     allRecs_accessor := deed_info_plus_assessmentLarge(propertyUniqueID[2]='A');
		 allRecs_accessor_slim := dedup(sort(allrecs_Accessor,sourceObscure,propertyAddress.State,
                                            propertyAddress.city,propertyAddress.zip5,propertyAddress.StreetName,
																						propertyAddress.StreetNumber,propertyAddress.unitNumber,propertyAddress.unitDesignation,																						   
																							  if (current_record = 'Y', 0,1),-recordingDate.Year,-recordingDate.Month,-recordingDate.day,record),
																						sourceObscure,propertyAddress.State,
                                            propertyAddress.city,propertyAddress.zip5,propertyAddress.StreetName,
																						propertyAddress.StreetNumber,propertyAddress.unitNumber,propertyAddress.unitDesignation);
     //allRecs_deed := deed_info_plus_assessmentLarge(
		     //(propertyUniqueID[1]='R' or propertyUniqueID[1]='O' or propertyUniqueID[1] = 'D') and
				// propertyUniqueID[2]='D');
		 // allRecs_deed_slim := dedup(sort(allRecs_Deed,sourceObscure,propertyAddress.State,
                                            // propertyAddress.city,propertyAddress.zip5,propertyAddress.StreetName,
																						// propertyAddress.StreetNumber,propertyAddress.unitNumber,propertyAddress.unitDesignation,																						
																						// if (exists(parties(exists(owners))),0,1),
																						// if (exists(parties(exists(sellers))),0,1),
																						// -RecordingDate.Year,-RecordingDate.Month,-RecordingDate.day,
																						// if (PurchasePrice <> '', 0, 1), if (SalesPrice <> '', 0,1),record)																													
																						
																						// ,sourceObscure,propertyAddress.State,
                                            // propertyAddress.city,propertyAddress.zip5,propertyAddress.StreetName,
																						// propertyAddress.StreetNumber,propertyAddress.unitNumber,propertyAddress.unitDesignation
																						// ,if (exists(parties(exists(owners))),0,1)
																						// ,if (exists(parties(exists(sellers))),0,1)
																						// );

      // AllRecs_mort := deed_info_plus_assessmentLarge(propertyUniqueID[2]='M');
			// allRecs_mort_slim := dedup(sort(allRecs_Mort,sourceObscure,propertyAddress.State,
                                            // propertyAddress.city,propertyAddress.zip5,propertyAddress.StreetName,
																						// propertyAddress.StreetNumber,propertyAddress.unitNumber,propertyAddress.unitDesignation,
																						// -RecordingDate.Year,-RecordingDate.Month,-Recordingdate.Day,record),
																						// sourceObscure,propertyAddress.State,
                                            // propertyAddress.city,propertyAddress.zip5,propertyAddress.StreetName,
																						// propertyAddress.StreetNumber,propertyAddress.unitNumber,propertyAddress.unitDesignation);

      //deed_info_plus_assessment
			tmp_recs := allRecs_accessor_slim;
			
      tmp_recs_sorted_Acc := sort (
			                           tmp_Recs(																 
																  propertyUniqueID[2]='A')			                                            
																									,sourceObscure,propertyAddress.State,
                                            propertyAddress.city,propertyAddress.zip5,propertyAddress.StreetName,
																						propertyAddress.StreetNumber,propertyAddress.unitNumber,propertyAddress.unitDesignation																						
																						,-RecordingDate.Year,-RecordingDate.Month,-Recordingdate.Day
																						,if (exists(parties(exists(sellers))),0,1),record);
       
			tmp_recs_Sorted_MortDeed := sort(deed_info_plus_assessmentLarge(propertyUniqueID[2]='M' OR
			                                      propertyUniqueID[2]='D'),
			                                      sourceObscure,propertyAddress.State,
																						propertyAddress.County,
                                            propertyAddress.city,propertyAddress.zip5,propertyAddress.StreetName,
																						propertyAddress.StreetNumber,propertyAddress.unitNumber,propertyAddress.unitDesignation,
																						if (propertyUniqueId[2] = 'D',0,1), if (current_record = 'Y', 0, 1),
																						-RecordingDate.Year,-RecordingDate.Month,-Recordingdate.Day, 																																											
																						if (exists(parties(exists(sellers))),0,1),record);
  
	   TopBusiness_Services.PropertySection_layouts.rec_linkids_plus_PropertyDetail_ForeclosureNOD
			                           RollupPropRecs( TopBusiness_Services.PropertySection_layouts.rec_linkids_plus_PropertyDetail_ForeclosureNOD l,
							   									   TopBusiness_Services.PropertySection_layouts.rec_linkids_plus_PropertyDetail_ForeclosureNOD r) := transform             										 																															 																	 																	
																	                                   
                                   // they want to keep source docs for
																	 // past accessors even though they 
																	 // are being rolled up.
                                   self.pSourceDocs := choosen(l.pSourcedocs + r.pSourceDocs, in_sourceDocMaxCount);																	
                                   tmpParties := l.parties + r.parties;                                  																																			                                   
                                    tmpPartiesMortgages := dedup(project(tmpparties.Mortgages, 	
																	                    transform(iesp.TopBusinessReport.t_TopBusinessPropertyMortgageInfo,
                                  													self := left;
																														)),all);			
                                   tmpPartiesOwners := dedup(project(tmpparties.owners, 	
																	                    transform(iesp.TopBusinessReport.t_TopbusinessPropertyTransaction,
                                  													self := left;
																														)),all); 
                                   tmppartiesSellers := dedup(project(tmpparties.sellers,
																	                     transform(iesp.TopBusinessReport.t_TopbusinessPropertyTransaction,
                                  													self := left;
																														)),all); 
																		 tmppartiesBorrowers := dedup(project(tmpparties.borrowers,
																	                     transform(iesp.TopBusinessReport.t_TopbusinessPropertyTransaction,
                                  													self := left;
																														)),all); 
                                   tmppartiesForeclosures := dedup(project(tmpparties.foreclosures,
																	                     transform(iesp.TopBusinessReport.t_TopBusinessPropertyForeclosure,
                                  													self := left;
																														)),all);
                                   tmppartiesNods := dedup(project(tmpparties.NoticeOfDefaults,
																	                     transform(iesp.TopBusinessReport.t_TopBusinessPropertyForeclosure,
                                  													self := left;
																														)),all);																																																													
                                                                   																																		
																	iesp.TopBusinessReport.t_TopBusinessPropertyParty PropParty_Xform() := TRANSFORM
																		  self.Owners := choosen(tmpPartiesOwners, iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_PROPERTY_PARTY_RECORDS);
																			self.Sellers := choosen(tmpPartiesSellers, iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_PROPERTY_PARTY_RECORDS);
																			self.Borrowers := choosen(tmpPartiesBorrowers, iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_PROPERTY_PARTY_RECORDS);
																			self.Foreclosures := choosen(tmpPartiesForeclosures, iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_PROPERTY_PARTY_RECORDS);
																		  self.NoticeofDefaults := choosen(tmpPartiesNods, iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_PROPERTY_PARTY_RECORDS);
																		  self.Mortgages := choosen(tmppartiesMortgages, iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_PROPERTY_PARTY_RECORDS);																	  
																	END;
																	 self.parties := DATASET([PropParty_Xform()]);
																	 self := l;																	 
																	 self := r;
                                   end;
      																	 																			
      tmp_recsRolledA := rollup(tmp_recs_sorted_Acc(propertyUniqueID[2] ='A'),			                            
			                             left.sourceObscure = right.sourceObscure and
			                             left.propertyAddress.state = right.propertyAddress.state and
																	 left.propertyAddress.city  = right.propertyAddress.city and
																	 left.propertyAddress.zip5 = right.propertyAddress.zip5 and
																	 left.propertyAddress.StreetName = right.propertyAddress.streetName and
																	 left.propertyAddress.streetNumber = right.propertyAddress.StreetNumber and
																	 left.propertyAddress.unitNumber   = right.propertyAddress.unitNumber and
																	 left.propertyAddress.unitDesignation = right.propertyAddress.unitDesignation,																	 
			                          RollupPropRecs(left,right));
 
      // rollup only mort Deed recs together.
      tmp_recsRolledMortDeed := rollup(tmp_recs_sorted_MortDeed,
			                             left.sourceObscure = right.sourceObscure and																	 
			                             left.propertyAddress.state = right.propertyAddress.state and
																	 left.propertyAddress.County = right.propertyAddress.County and
																	 left.propertyAddress.city  = right.propertyAddress.city and
																	 left.propertyAddress.zip5 = right.propertyAddress.zip5 and
																	 left.propertyAddress.StreetName = right.propertyAddress.streetName and
																	 left.propertyAddress.streetNumber = right.propertyAddress.StreetNumber and
																	 left.propertyAddress.unitNumber   = right.propertyAddress.unitNumber and
																	 left.propertyAddress.unitDesignation = right.propertyAddress.unitDesignation,																	
			                          RollupPropRecs(left,right));

     tmpSet := 	sort(tmp_recsRolledA &
			               tmp_recsRolledMortDeed &				
								     deed_info_plus_assessmentLarge( propertyUniqueID[2] <> 'A'
																  and PropertyUniqueID[2] <> 'M' and propertyUniqueID[2] <> 'D'),
											sourceObscure,
											propertyAddress.State,propertyAddress.County,propertyAddress.city,propertyAddress.zip5,propertyAddress.StreetName,
											propertyAddress.StreetNumber,propertyAddress.unitNumber,propertyAddress.unitDesignation,	
											if (current_record = 'Y',0,1), 
											if (propertyUniqueID[2] = 'A',0,1),
											if (propertyUniqueId[2] = 'D',0,1),														
											record);
											// need to keep accessor/deed rec if available at the front ahead of mort recs
											// so as to keep the main
                      // property information for final layout available so it doesn't get removed by rollup.										

      tmpSetRolled := rollup(tmpSet,
			                      left.sourceObscure = right.sourceObscure and
			                      left.propertyAddress.state = right.propertyAddress.state and
														left.propertyAddress.County = right.propertyAddress.County and
														left.propertyAddress.city  = right.propertyAddress.city and
														left.propertyAddress.zip5 = right.propertyAddress.zip5 and
														left.propertyAddress.StreetName = right.propertyAddress.streetName and
														left.propertyAddress.streetNumber = right.propertyAddress.StreetNumber and
														left.propertyAddress.unitNumber   = right.propertyAddress.unitNumber and
														left.propertyAddress.unitDesignation = right.propertyAddress.unitDesignation,
														RollupPropRecs(left,right));
			                            
      deed_info_plus_assessment := tmpsetRolled;	
			deed_info_plus_assessmentCurrent := deed_info_plus_assessment(current_record='Y');
			deed_info_plus_assessmentNotCurrent := deed_info_plus_assessment(current_record <> 'Y');															 		                                                                 
	// now implement the sorting stuff...	
	//
	 layout_property_info := record    
	    deed_info_plus_assessment.ultid;
			deed_info_plus_assessment.orgid;
			deed_info_plus_assessment.seleid;
			// deed_info_plus_assessment.proxid;
			// deed_info_plus_assessment.powid;
			// deed_info_plus_assessment.empid;
			// deed_info_plus_assessment.dotid;
			deed_info_plus_assessment.PropertyAddress.state;
      addr_state_count := COUNT(GROUP);
   end;
  
	linkids_states_tabled_current := table(deed_info_plus_assessmentCurrent,
	                              layout_property_info,#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
	                                           PropertyAddress.state,few);
	linkids_states_tabled_prior   := table(deed_info_plus_assessmentNotCurrent,
	                          layout_property_info,#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
	                                           PropertyAddress.state,few);
	
	 // Join number of addresses per state for the bid back to the addresses/phones recs 
	//  with rolled phones 
  layout_propertyPartyWlinkids_plus_stcnt := record
    recordof(deed_info_plus_assessment);	  
	end;
		
	propertyParty_recs_plus_stcnt_current := 
	           sort(dedup(
						        project(
						          join(deed_info_plus_assessmentCurrent
													 ,linkids_states_tabled_current,
	                      BIPV2.IDmacros.mac_JoinTop3Linkids() AND
											  left.PropertyAddress.state = right.state,																			
										    transform(layout_propertyPartyWlinkids_plus_stcnt,
											    self.addrs_per_state := right.addr_state_count;
													self := left
												),
											left outer),
										transform(TopBusiness_Services.PropertySection_layouts.rec_linkids_plus_PropertyDetail_ForeclosureNOD,
											 self := left)), all, record),
							    #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
									          -addrs_per_state,
											// recs with no state name use highest alpha value to sort last
								  if(PropertyAddress.state = '','ZZ',PropertyAddress.state));
																			
	 	propertyParty_recs_plus_stcnt_prior :=
		          sort(dedup(
		                 project(
									     join(deed_info_plus_assessmentNotCurrent
														 ,linkids_states_tabled_prior,
	                       BIPV2.IDmacros.mac_JoinTop3Linkids() AND
										     left.PropertyAddress.state = right.state,																			
											   transform(layout_propertyPartyWlinkids_plus_stcnt,
											     self.addrs_per_state := right.addr_state_count;
												   self := left
											   ), 
										   left outer),
									    transform(TopBusiness_Services.PropertySection_layouts.rec_linkids_plus_PropertyDetail_ForeclosureNOD,
									      self := left)),all, record),  
									  #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),  -addrs_per_state,
										 // recs with no state name use highest alpha value to sort last
										if(PropertyAddress.state = '','ZZ',PropertyAddress.state));  
 
  // extraNOD_foreclosure_cnt := PROJECT(foreclosureNODSection, TRANSFORM({integer cnt;},
												                      // SELF.cnt := LEFT.NOD_foreclosure_count;
																							// ))[1].cnt;
																							
  TopBusiness_Services.PropertySection_Layouts.rec_linkids_plus_PropertyRecord 
	rollup_rptdetail(	 
		TopBusiness_Services.PropertySection_layouts.rec_linkids_plus_PropertyDetail_ForeclosureNOD l,
	  dataset(TopBusiness_Services.PropertySection_layouts.rec_linkids_plus_PropertyDetail_ForeclosureNOD) allrows) := transform
     		
			self.acctno  := '';					
			self.ultid        := l.ultid,
				self.orgid        := l.orgid,
				self.seleid       := l.seleid,
				self.proxid       := l.proxid,
				self.powid        := l.powid,
				self.empid        := l.empid,
				self.dotid        := l.dotid,
			         					                                   
			self.totalCnt := count(allrows);
			 self.currentRecordsCount := if (count(allrows(current_record = 'Y')) < in_propertyRecordsMaxCount, 
			                                 count(allrows(current_record = 'Y')), in_propertyRecordsMaxCount);
																			
       self.TotalCurrentRecordsCount := count(allrows(current_record = 'Y'));																	 
			  self.priorRecordsCount   := if (count(allrows(current_record <> 'Y')) < in_propertyRecordsMaxCount,
		                                     count(allrows(current_record <> 'Y')), in_propertyRecordsMaxCount);
																				  
        self.TotalPriorRecordsCount  :=  count(allrows(current_record <> 'Y'));																			
      self.properties := choosen(project(sort(allrows(current_record='Y'),   if (current_record ='Y', 0, 1), -recordingdate.Year, -recordingDate.Month, -recordingDate.Day,
			                                 -addrs_per_state,if(PropertyAddress.state = '','ZZ',PropertyAddress.state), record
																	),
														transform(
														iesp.TopBusinessReport.t_TopBusinessProperty,													    
														  self := left)),																
											 in_propertyRecordsMaxCount)
											    &
													choosen(project(sort(allrows(current_record<> 'Y'),   if (current_record <>'Y', 0, 1),  -recordingdate.Year, -recordingDate.Month, -recordingDate.Day,
			                                 -addrs_per_state,if(PropertyAddress.state = '','ZZ',PropertyAddress.state), record
																  ),
														transform(
														iesp.TopBusinessReport.t_TopBusinessProperty,													    
														  self := left)),				                          							
											 in_propertyRecordsMaxCount);
      tmpprops := self.properties;								 
      self.DerogSummaryCntForeclosureNOD := count(tmpProps(isForeclosed OR isNoticeofDefault));  
			                  //+ extraNOD_foreclosure_cnt;// + count(tmpNods2_Situs1_OldProp);
												
												// PROJECT(foreclosureNODSection, TRANSFORM({integer cnt;},
												                      // SELF.cnt := LEFT.NOD_foreclosure_count;
																							// ))[1].cnt;
      self := l;
			self.CurrentSourceDocs := if(count(allrows(current_record='Y')) > 0,
			  choosen(project(allrows(current_record='Y'),		
			       transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
				  	self.businessids.ultid        := l.ultid,
				self.businessids.orgid        := l.orgid,
				self.businessids.seleid       := l.seleid,
				self.businessids.proxid       := l.proxid,
				self.businessids.powid        := l.powid,
				self.businessids.empid        := l.empid,
				self.businessids.dotid        := l.dotid,							
				self.IdType := topBusiness_services.constants.propertykeys;
					 self.IdValue := ''; 
					 self.Section := topBusiness_services.constants.PropertySectionName;
					 self.Name := [];
					 self.Address := [];
					 self.source := [];					 
				)),in_sourceDocMaxCount));
			self.PriorSourceDocs := if(count(allrows(current_record<>'Y')) > 0,
			  choosen(project(allrows(current_record<>'Y'),			
			   transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
					self.businessids.ultid        := l.ultid,
			   	self.businessids.orgid        := l.orgid,
				self.businessids.seleid       := l.seleid,
				self.businessids.proxid       := l.proxid,
				self.businessids.powid        := l.powid,
				self.businessids.empid        := l.empid,
				self.businessids.dotid        := l.dotid,			
				// self.SourceCode := '',
				// self.SourceDocID := ''
				self.IdType := topBusiness_services.constants.propertykeys; 
					 self.IdValue := '' ; 
					 self.Section := topBusiness_services.constants.PropertySectionName;
					 self.Name := [];
					 self.Address := [];
					 self.source := [];
				)),in_sourceDocMaxCount));	
				self := []; 
	end;																					 
																										 
	prop_list := propertyParty_recs_plus_stcnt_current & propertyParty_recs_plus_stcnt_prior;
													 
  all_grouped := group(sort(prop_list,
															 #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
															 if (current_record='Y',0,1),PropertyUniqueID,record),
															 #expand(BIPV2.IDmacros.mac_ListTop3Linkids())
															 );																	  															 	 	                     																																						 
  all_rptdetail_rolled := rollup(all_grouped,
																 group,
																 rollup_rptdetail(left,rows(left)));													 																 																 
  raw_data_wAcctno := join(ds_in_data,all_rptdetail_rolled, // in_data has acctno on it	 
	                         BIPV2.IDmacros.mac_JoinTop3Linkids(), // maybe not join on all linkids..
														transform(TopBusiness_Services.PropertySection_Layouts.rec_linkids_plus_PropertyRecord,
														   self.acctno   := left.acctno,
															 self          := right),
												left outer); // 1 out rec for every left (in_data) rec 																			 																		
																		 
    final_results := rollup(group(sort(raw_data_wAcctno,acctno),acctno),group,
		  transform(TopBusiness_Services.PropertySection_Layouts.rec_Final,	
			  self.TotalPropertyRecordCount := left.totalCnt; // assume this is total of both current/prior		   
			
        self.PropertyRecordCount :=  if (left.currentRecordsCount  + left.priorRecordsCount <																 
																			 in_propertyTotalRecsMaxCount,
																			   left.currentRecordsCount  + left.priorRecordsCount,
																				  in_propertyTotalRecsMaxCount);
			 self.PropertyRecords := left;
		   self := left));			
// output(CnameReport, named('CnameReport'));
//output(property_recs_raw, named('property_recs_raw'));
//output(TmpMort_info_forLNFARESIDNoExplosCodes, named('TmpMort_info_forLNFARESIDNoExplosCodes'));
//output(property_recs_projected, named('property_recs_projected'));
//output(property_partyPayload_raw, named('property_partyPayload_raw'));
//output(property_partyPayload, named('property_partyPayload'));
//output(property_partySellers, named('property_partySellers'));
//output(property_partySellersSlim, named('property_partySellersSlim'));
//output(Property_partyPayloadSellersSlim, named('Property_partyPayloadSellersSlim'));
//output(property_partySellersAll, named('property_partySellersAll'));
//output(property_partyPayloadSlim, named('property_partyPayloadSlim'));
//output(property_partyPayloadDeduped1, named('property_partyPayloadDeduped1'));
//output(property_partyPayloadDeduped2, named('property_partyPayloadDeduped2'));
//output(Seller_ln_fares_ids, named('Seller_ln_fares_ids'));
//output(property_partyPayloadDeduped4, named('property_partyPayloadDeduped4'));
//output(Seller_ln_fares_idPayload, named('Seller_ln_fares_idPayload'));
//output(Seller_ln_fares_idPayloadSlim, named('Seller_ln_fares_idPayloadSlim'));
//output(Property_partyPayloadDeduped, named('Property_partyPayloadDeduped'));
//output(property_transaction, named('Property_transaction'));
//output(foreclosureNODSection, named('foreclosureNODSection'));
 //output(property_TransactionSlim, named('property_TransactionSlim'));
//output(property_transactionO, named('property_transactionO'));
//output(property_transactionS, named('property_transactionS')); 
//output(property_transactionB, named('property_transactionB'));

//output(property_party1, named('property_party1'));
//output(tmpOwners2, named('tmpOwners2'));
//output(tmpOwners2Large, named('tmpOwners2Large'));
//output(property_party1OwnerLarge, named('property_party1OwnerLarge'));
//output(property_party1Owner, named('property_party1Owner'));
//output(tmpSellers, named('tmpSellers'));
//output(tmpSellersLarge, named('tmpSellersLarge'));
//ouptut(tmpSellers2, named('tmpSellers2'));

//output(property_party1Seller, named('property_party1Seller'));
//output(tmpBorrowers, named('tmpBorrowers'));
//output(tmpBorrowers2, named('tmpBorrowers2'));
//output(property_party, named('property_party'));
//output(tmpNods, named('tmpNods'));
//output(tmpNods2_Situs1, named('tmpNods2_Situs1'));
//output(tmpNods2, named('tmpNods2'));
//output(property_party_WNOD, named('property_party_WNOD'));
//output(tmpFores, named('tmpFores'));
//output(tmpFores2, named('tmpFores2'));
//output(property_party_WFORE_NODS, named('property_party_WFORE_NODS'));
//output(property_party_dedup, named('property_party_dedup'));
 
//output(denorm1stParamLarge, named('denorm1stParamLarge'));
//output(denorm1stParamSlim, named('denorm1stParamSlim'));
//output(denorm1stParam, named('denorm1stParam'));
//output(denorm1stParam_all, named('denorm1stParam_all'));
//output(recs_parent_child, named('recs_parent_child'));
//output(recs_parent_child_slim, named('recs_parent_child_slim'));
//output(Assessment_info_ds, named('Assessment_info_ds'));
//output(tmp_deed_info_plus_assessmentWITHOUTDEED_EXPLOSIONCODES, named('tmp_deed_info_plus_assessmentWITHOUTDEED_EXPLOSIONCODES'));
//output(tmp_deed_info_plus_assessmentLARGE, named('tmp_deed_info_plus_assessmentLARGE'));
//output(tmp_deed_info_plus_assessment_Slimmer, named('tmp_deed_info_plus_assessment_Slimmer'));
//output(tmp_deed_info_plus_assessment, named('tmp_deed_info_plus_assessment'));
//output(fares_deed_info, named('fares_deed_info'));
//output(fares_transaction_deed_infoNoExplosionCode, named('fares_transaction_deed_infoNoExplosionCode'));
//output(AccessorRecsWithSellers, named('AccessorRecsWithSellers'));
//output(tmp, named('tmp'));
//output(tmp_deed_info_plus_assessment_extra, named('tmp_deed_info_plus_assessment_extra'));
//output(tmp_deed_info_plus_assessment_extra_slim, named('tmp_deed_info_plus_assessment_extra_slim'));
//output(tmp_deed_info_plus_assessment_extra_slimWMortgageAPN, named('tmp_deed_info_plus_assessment_extra_slimWMortgageAPN'));
//output(tmp_deed_info_plus_assessment_extra_slim2, named('tmp_deed_info_plus_assessment_extra_slim2'));
//output(deed_info_plus_assessmentLarge, named('deed_info_plus_assessmentLarge'));
//output(allRecs_accessor, named('allRecs_accessor'));
//output(allRecs_accessor_slim, named('allRecs_accessor_slim'));
//output(tmp_recs_sorted_Acc, named('tmp_recs_sorted_Acc'));
//output(tmp_recs_Sorted_MortDeed, named('tmp_recs_Sorted_MortDeed'));
//output(tmp_recsRolledA, named('tmp_recsRolledA'));
//output(tmp_recsRolledMortDeed, named('tmp_recsRolledMortDeed'));
//output(tmpSet, named('tmpSet'));
//output(tmpSetRolled, named('tmpSetRolled'));
//output(deed_info_plus_assessment, named('deed_info_plus_assessment'));
//output(prop_list, named('prop_list'));
// output(all_grouped, named('all_grouped'));         
// output(all_rptdetail_rolled, named('all_rptdetail_rolled'));
// output(raw_data_wAcctno, named('raw_data_wAcctno'));
// output(final_results, named('final_results'));
															  
  
	return(final_results);
	
end; // function
end;// module