import TopBusiness,iesp,AutoStandardI, BankruptcyV3, BIPV2, MDR, Codes,
Suppress, ut;

export BankruptcySection := module

EXPORT GetBankruptcyBipLinkids(DATASET(BIPV2.IDlayouts.l_xlink_ids)   ds_in_unique_ids_only, 
                    STRING1 FETCH_LEVEL) :=  
                     TopBusiness_Services.Key_Fetches(
	                    ds_in_unique_ids_only // input file to join key with
				    ,FETCH_LEVEL // level of ids to join with
										              // 3rd parm is ScoreThreshold, take default of 0
					 ).ds_bankr_linkidskey_recs;

export fn_fullView(
	dataset(TopBusiness_Services.BankruptcySection_Layouts.rec_Input) ds_in_data,
	TopBusiness_Services.BankruptcySection_Layouts.rec_OptionsLayout in_options,
	AutoStandardI.DataRestrictionI.params in_mod,
  unsigned2 in_sourceDocMaxCount = iesp.Constants.TopBusiness.MAX_COUNT_BIZRPT_SRCDOC_RECORDS
	) := function	
	
	bankruptcy_record_ext := record
		ds_in_data.ultid;
		ds_in_data.orgid;
		ds_in_data.seleid;
		ds_in_data.proxid;
		ds_in_data.empid;
		ds_in_data.powid;
		ds_in_data.dotid;
		string1 party_type;
		iesp.TopbusinessReport.t_topbusinessBankruptcy;
	end;
	
	ds_deduped_linkids := dedup(ds_in_data,UltID,OrgID,Seleid,all);
	
	ds_normalized_linkids := project(ds_deduped_linkids,
		transform({ds_deduped_linkids.ultid;
		           ds_deduped_linkids.orgid;
							 ds_deduped_linkids.seleid;
							 ds_deduped_linkids.proxid;
							 ds_deduped_linkids.powid;
							 ds_deduped_linkids.empid;
							 ds_deduped_linkids.dotid;
		        string1 party_type;},
			self.proxid := left.proxid,
			self.dotid := left.dotid,
			self.orgid := left.orgid,
			self.seleid := left.seleid,
			self.ultid := left.ultid,
			self.powid := left.powid,
			self.empid := left.empid,
			self.party_type  := 'D'));
			
	// get the main data from the new linkds key
	FETCH_LEVEL := in_options.BusinessReportFetchLevel;
 
    ds_bk_bip_raw_recs := GetBankruptcyBipLinkids(project(ds_deduped_linkids, 
	                        transform(BIPV2.IDlayouts.l_xlink_ids,
													self := left)), 
                                                                      FETCH_LEVEL)(name_type[1] = 'D'); // only want debtor recs not attorney recs
                                                                        // that have the same TMSID

  ds_bk_bip_raw_recs2 := join(ds_normalized_linkids,ds_bk_bip_raw_recs,
														BIPV2.IDmacros.mac_JoinTop3Linkids(),
														 transform({string1 party_type; recordof(right);},
															 self.party_type := left.party_type;
															 self := right															 
															  ), limit(10000, skip));

	//filter out just the business related BK recs
  ds_bk_BIP_recs_filtered := ds_bk_BIP_raw_recs2(tmsid != ''); //filing_type = 'B'); removed per bug  : 

	
	// get the debtor and attorney recs by join and filter
	ds_bk_BIP_recs := join(dedup(sort(ds_bk_BIP_recs_filtered, tmsid), tmsid),
	BankruptcyV3.key_bankruptcyV3_search_full_bip(),
	     left.tmsid = right.tmsid,			
			 transform({recordof(right); BIPV2.IDlayouts.l_xlink_ids; },
			        self.proxid := left.proxid;
							self.ultid := left.ultid;
							self.seleid := left.seleid;
							self.orgid := left.orgid;							
							self.dotid := left.dotid;
							self.powid := left.powid;
							self.empid := left.empid,
							self := right;
							),limit(10000, skip));
							

	// get debtor recs;							
	ds_bk_debtor_recs := ds_bk_BIP_recs(name_type[1]='D');

	ds_bk_attorney_recs :=  ds_bk_BIP_recs(name_type[1]='A');

  // get the trustee info and add linkids.
	ds_tmp_bk_raw_recs_main_fullV3 :=  
		join(//ds_bk_BIP_recs_filtered,
			ds_bk_BIP_recs, BankruptcyV3.key_bankruptcyV3_main_full(),					 
			keyed(left.tmsid = right.tmsid),
				transform({recordof(right); BIPV2.IDlayouts.l_header_ids;},
					self.proxid := left.proxid,
					self.dotid := left.dotid,
					self.seleid := left.seleid,
					self.orgid := left.orgid,
					self.ultid := left.ultid,
					self.powid := left.powid,
					self.empid := left.empid,
					self := right), limit(10000, skip));
							
							
	ds_filtered := ds_tmp_bk_raw_recs_main_fullV3(process_date != '' and case_number != '');		                 //ds_bk_BIP_recs(process_date != '' and case_number != '');
	// now add the linkids onto this main debtor record
	ds_extract := dedup(join(ds_bk_BIP_recs_filtered, ds_filtered, 
		left.tmsid = right.tmsid,
		transform(TopBusiness_Services.BankruptcySection_Layouts.rec_bklayout,
			self.proxid := left.proxid,
			self.dotid := left.dotid,
			self.orgid := left.orgid,
			self.seleid := left.seleid,
			self.ultid := left.ultid,
			self.powid := left.powid,
			self.empid := left.empid,				   										
			self.source := MDR.sourceTools.src_Bankruptcy,
			self.source_docid := left.tmsid,
			self.tmsid := left.tmsid,
			self.case_number := right.case_number;
			self.chapter := right.orig_chapter;
			self.date_filed          := right.date_filed;
			self.filing_status       := right.filing_status;
			self.filing_jurisdiction := right.filing_jurisdiction;
			self.StatusRaw := trim(sort(right.status,-status_date,record)[1].status_type,left,right);
			self.status              := if (trim(sort(right.status,-status_date,record)[1].status_type,left,right) = 'REOPENED' OR
																			trim(sort(right.status,-status_date,record)[1].status_type,left,right) = 'CONVERTED',
																			'ACTIVE','CLOSED');
			self.status_date         := sort(right.status,-status_date,record)[1].status_date;
			self.court_code          := right.court_code;
			self.court_name          := right.court_name;
			self.court_location      := right.court_location;
			self.casetype            := right.casetype;
			self.assets              := right.assets; //???
			self.liabilities         := right.liabilities; //???
			self.disposition         := ''; // left.???;
			self.disposed_date       := ''; // left.???; 
			self.case_closing_date   := right.case_closing_date; 
			self.orig_case_number    := right.orig_case_number;
			self.orig_chapter        := right.orig_chapter;
			self.orig_filing_date    := right.orig_filing_date;
			self.orig_filing_type    := map(
				left.filing_type = 'I' => 'INDIVIDUAL',
						'BUSINESS');
			self.filer_type          := Codes.BANKRUPTCIES.FILER_TYPE(right.filer_type);
			self.party_type          := left.party_type;
			self.filing_type         := 'CHAPTER ' + right.orig_chapter;
			self.ssn := left.ssn;
			self.did := left.did;
			//self.TaxId := right.Taxid;
			self.comment := sort(right.comments,-filing_date,record)[1].description;
																					//self.comment := left.description;))[1].comment;
			self.FilingStatus := right.Filing_Status;
			//self.originalFilingType := ''; // ?? left.orginal_filing_type;
			),
		left outer), all, except source_docid);
   
  // project to common party layout				
	ds_bk_recs_debtor := dedup( 		
		project(ds_bk_debtor_recs, 
		transform(TopBusiness_Services.BankruptcySection_Layouts.rec_partylayout,
			self.proxid := left.proxid,
			self.dotid := left.dotid,
			self.orgid := left.orgid,
			self.ultid := left.ultid,
			self.seleid := left.seleid,
			self.powid := left.powid,
			self.empid := left.empid,
			self.tmsid := left.tmsid,
			self.source := MDR.sourceTools.src_Bankruptcy;
			self.source_docid := left.tmsid;
			self.source_party := '';// := trim(left.name_type) + trim(left.debtor_type) + trim(left.debtor_seq),
			self.court_code := left.court_code;
			self.orig_case_number := left.orig_case_number;
			self.party_type := 'D'; // debtor
			self.debtor_type := left.debtor_type;
			self.DID := left.did;
			self.app_SSN := left.app_ssn;
			self.ssn := left.app_ssn;
			self.app_tax_id := '';
			self.taxId := left.tax_id;
			self.cname := stringlib.StringCleanSpaces(left.cname); // added this call to temp fix 120543						                                                        
			self.title        := left.title;
			self.fname        := left.fname;
			self.mname        := left.mname;
			self.lname        := left.lname;
			self.name_suffix  := left.name_suffix;       
			self.prim_range   := left.prim_range;
			self.predir       := left.predir;
			self.prim_name    := left.prim_name;
			self.addr_suffix  := left.addr_suffix;
			self.postdir      := left.postdir;
			self.unit_desig   := left.unit_desig;
			self.sec_range    := left.sec_range;
			self.p_city_name  := left.p_city_name;
			self.v_city_name  := left.v_city_name;
			self.st           := left.st;
			self.zip          := left.zip;
			self.zip4         := left.zip4;
			self.phone        := ''; 
			self.timezone     := ''; 
			)), all, except source_docid);
	
	// get trustree information		
	ds_filtered_trustee := ds_filtered(trusteename != '');

	ds_bk_recs_trustee := project( ds_filtered_trustee,			
		transform(TopBusiness_Services.BankruptcySection_Layouts.rec_partylayout,
			self.tmsid := left.tmsid,
			self.source := MDR.sourceTools.src_Bankruptcy;
			self.source_docid := left.tmsid;
			self.source_party := 'TR',			
			self.proxid := left.proxid,
			self.dotid := left.dotid,
			self.orgid := left.orgid,
			self.seleid := left.seleid,
			self.ultid := left.ultid,
			self.powid := left.powid,
			self.empid := left.empid,							
			self.court_code := left.court_code;
			self.orig_case_number := left.orig_case_number;
			self.party_type := 'TR'; // trustee
			self.debtor_type := '';
			self.DID := left.did;
			self.app_SSN := left.app_ssn;
			self.ssn := left.app_ssn;
			self.app_tax_id := '';
			self.taxId := '';
			self.cname := '';				
			self.title        := left.title;
			self.fname        := left.fname;
			self.mname        := left.mname;
			self.lname        := left.lname;
			self.name_suffix  := left.name_suffix;       
			self.prim_range   := left.prim_range;
			self.predir       := left.predir;
			self.prim_name    := left.prim_name;
			self.addr_suffix  := left.addr_suffix;
			self.postdir      := left.postdir;
			self.unit_desig   := left.unit_desig;
			self.sec_range    := left.sec_range;
			self.p_city_name  := left.p_city_name;
			self.v_city_name  := left.v_city_name;
			self.st           := left.st;
			self.zip          := left.zip;
			self.zip4         := left.zip4;
			self.phone        := left.trusteephone; 
			self.timezone     := ''; // ???							
			));
				
	ds_bk_recs_attorney := dedup(project( ds_bk_attorney_recs,
		transform(TopBusiness_Services.BankruptcySection_Layouts.rec_partylayout,		
			self.tmsid := left.tmsid,
			self.source := MDR.sourceTools.src_Bankruptcy;
			self.source_docid := left.tmsid;
			self.source_party := 'A'; // 'A' for attorney
			self.proxid := left.proxid,
			self.dotid := left.dotid,
			self.orgid := left.orgid,
			self.seleid := left.seleid,
			self.ultid := left.ultid,
			self.powid := left.powid,
			self.empid := left.empid,		
			self.court_code := left.court_code;
			self.orig_case_number := left.orig_case_number;
			self.party_type := left.name_type[1]; // 'A' for attorney
			self.debtor_type := '';
			self.DID := left.did;
			self.app_SSN := left.app_ssn;
			self.ssn := left.app_ssn;
			self.app_tax_id := '';
			self.taxId := '';
			self.cname := left.cname;				
			self.title        := left.title;
			self.fname        := left.fname;
			self.mname        := left.mname;
			self.lname        := left.lname;
			self.name_suffix  := left.name_suffix;       
			self.prim_range   := left.prim_range;
			self.predir       := left.predir;
			self.prim_name    := left.prim_name;
			self.addr_suffix  := left.addr_suffix;
			self.postdir      := left.postdir;
			self.unit_desig   := left.unit_desig;
			self.sec_range    := left.sec_range;
			self.p_city_name  := left.p_city_name;
			self.v_city_name  := left.v_city_name;
			self.st           := left.st;
			self.zip          := left.zip;
			self.zip4         := left.zip4;
			self.phone        := left.phone; 
			self.timezone     := ''; // ???							
			)), all);
				
	ds_bk_recs_attorney_slim := dedup(
		sort(ds_bk_recs_attorney,
		#expand(BIPV2.IDmacros.mac_ListTop3Linkids())
			, source_docid,
			cname, zip, p_city_name, prim_name, prim_range, if (lname <> '', 0, 1)),
		#expand(BIPV2.IDmacros.mac_ListTop3Linkids())
			, source_docid,
			cname, zip, p_city_name, prim_name, prim_range);
																		
	deduped_linkid_cc_ocn := dedup(dedup(sort(ds_extract, 
		#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
			court_code, orig_case_number, -date_filed),
		#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
			court_code, orig_case_number),all);

	iesp.TopbusinessReport.t_topbusinessBankruptcyParty addr_xform(	        
		TopBusiness_Services.BankruptcySection_Layouts.rec_partylayout
		// KEY OF THE BK PARTY
		le) := transform
			self.CompanyName := le.cname,
			self.Name.Full := '';
			self.Name.First := le.fname;
			self.Name.Middle := le.mname;
			self.Name.Last := le.lname;
			self.Name.Suffix := le.name_suffix;
			self.Name.Prefix := le.title;
			self.Address.StreetNumber := le.prim_range;
			self.Address.StreetPreDirection := le.predir;
			self.Address.StreetName := le.prim_name;
			self.Address.StreetSuffix := le.addr_suffix;
			self.Address.StreetPostDirection := le.postdir;
			self.Address.UnitDesignation := le.unit_desig;
			self.Address.UnitNumber := le.sec_range;
			self.Address.StreetAddress1 := '';
			self.Address.StreetAddress2 := '';
			self.Address.City := le.p_city_name;
			self.Address.State := le.st;
			self.Address.Zip5 := le.zip;
			self.Address.Zip4 := le.zip4;
			self.Address := [];
			self.TaxId := le.taxID;
			self.ssn := le.ssn;
			self := [];
	end;
	
  string6 ssn_mask_value := AutoStandardI.InterfaceTranslator.ssn_mask_val.val(project(autostandardi.globalModule(false),
                             AutoStandardI.InterfaceTranslator.ssn_mask_val.params));      														 
														 
  ds_party_all :=  dedup(sort(ds_bk_recs_debtor + ds_bk_recs_trustee + ds_bk_recs_attorney_slim, 
		#expand(BIPV2.IDmacros.mac_ListTop3Linkids())
		),all);
  
	//Do suppression and then masking
	Suppress.MAC_pullIDs_tmsid(ds_party_all, ds_party_allSuppressed,true, false, in_options.ApplicationType,'BK');
	Suppress.MAC_Mask(ds_party_allSuppressed, ds_party_allMasked, ssn, blank, true, false);														 
	
	bankruptcies := denormalize(deduped_linkid_cc_ocn,ds_party_allMasked, 
		left.Court_Code = right.court_code and
		left.orig_case_number = right.orig_case_number,
		group,
		transform(TopBusiness_Services.BankruptcySection_Layouts.rec_bankruptcy_record_ext,
			self.proxid := left.proxid,
			self.dotid := left.dotid,
			self.orgid := left.orgid,
			self.seleid := left.seleid,
			self.ultid := left.ultid,
			self.powid := left.powid,
			self.empid := left.empid,			
			self.party_type := left.party_type,
			self.comment := left.comment;
			self.ssn := left.ssn;
			self.taxId := right.Taxid;
			self.UniqueID := left.did;
			self.CourtCode := left.court_code,
			self.CourtLocation := left.court_name,			                        		
			self.StatusRaw := left.StatusRaw;
			self.Status := left.status;
			self.StatusDate := iesp.ecl2esp.toDatestring8(left.status_date);
			self.OriginalCaseNumber := left.orig_case_number,
			self.OriginalFilingDate := iesp.ECL2ESP.toDate((integer) left.orig_filing_date),
			self.OriginalFilingType := left.orig_Filing_Type;
			self.FilingType := left.filing_Type; //left.orig_filing_type;
			self.FilerType := left.filer_type;
			self.filingStatus := left.FilingStatus;
			self.debtors := choosen(dedup(project(
				 dedup(rows(right)(party_type[1] = 'D' and ultid != 0 and orgid != 0 and seleid != 0  // and dotid != 0
				                                    ),all)		        				
				 //rows(right)(party_type[1] = 'D' and ultid = 0 and orgid = 0 and proxid = 0 and dotid = 0)
				       ,addr_xform(left)),all),iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_BANKRUPTCY_DEBTORS),
							 				
			self.attorneys := choosen(dedup(project(
				 dedup(rows(right)(party_type[1] = 'A' and ultid != 0 and orgid != 0 and seleid != 0 // and dotid != 0
				                                    ),all) +
				rows(right)(party_type[1] = 'A' and ultid = 0 and orgid = 0 and seleid = 0),addr_xform(left)),record,all),iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_BANKRUPTCY_ATTORNEYS),
       				
      self.trustees := choosen(project(
				rows(right)(party_type[1] = 'T' and ultid != 0 and orgid != 0 and seleid != 0  //and dotid != 0
				                    ) +
				rows(right)(party_type[1] = 'T' and ultid = 0 and orgid = 0 and seleid = 0 //and dotid = 0
				                ),addr_xform(left)), iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_BANKRUPTCY_TRUSTEES),
								
			self.SourceDocs := choosen(dedup(project(rows(right), 
						transform(iesp.TopBusiness_share.t_TopBusinessSourceDocInfo,
			self.businessIDs.proxid := left.proxid,
			self.businessIDs.ultid := left.ultid,
			self.businessIDs.orgid := left.orgid,
			self.businessIDs.seleid := left.seleid,
			self.businessIDs.dotid := left.dotid,
			self.BusinessIDs.empid := left.empid,
			self.BusinessIDs.powid := left.powid,
			//self.SourceDocId := left.source_docid, 		
			self.IdType := TopBusiness_Services.Constants.tmsid;
			self.IdValue := left.source_docid,
			self.Section := topBusiness_services.constants.BankruptcySectionName;
			self.Address := []; //ecl2esp.toDate(
			self.Name := [];
			self.Source := left.source;
			)
		), all), in_sourceDocMaxCount);
		self := [];									
	 )
	 );
		
	Suppress.MAC_Mask(bankruptcies, bankruptcies_supressed, ssn, blank, true, false);
	
	final_records := denormalize(ds_in_data,bankruptcies_supressed,
		 left.ultid = right.ultid AND
		 left.orgid = right.orgid AND
		 left.seleid = right.seleid,
		  // left.proxid = right.proxid AND			
			// left.dotid = right.dotid AND
			// left.empid = right.empid AND
			// left.powid = right.powid,
		group,
		transform(TopBusiness_Services.BankruptcySection_Layouts.rec_final,
			self.AsDebtors := choosen(sort(project(rows(right)(party_type = 'D'),
				transform(iesp.TopbusinessReport.t_topbusinessBankruptcy,
				self := left, self := [])), -OriginalFilingDate.Year,-OriginalFilingDate.Month,-OriginalFilingDate.Day),
				iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_BANKRUPTCIES),
			self.DebtorSourceDocs := if(count(rows(right)(party_type = 'D')) > 0,			      
				choosen(
					project(rows(right).sourceDocs, //transform(iesp.TopBusinessReport.t_TopBusinessReportItemInfo,												    
						transform(iesp.TopBusiness_share.t_TopBusinessSourceDocInfo,
							self.Section := left.Section;												
							self.businessIDs := left.businessIDs,			 				
							self := [];
					)),1));
			self.DerogSummaryCntBankruptcy := if (count(rows(right)(party_type = 'D')) < 
			                                      iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_BANKRUPTCIES,
																						count(rows(right)(party_type = 'D')),
																						iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_BANKRUPTCIES);																									                                      			                                   
																				 // active and terminated may only want actives?
			self.TotalDerogSummaryCntBankruptcy := count(rows(right)(party_type = 'D'));
			self := left;
			self := []));
			
  // debug outputs
	// output(ds_bk_BIP_raw_recs, named('ds_bk_BIP_raw_recs'));

	// output(ds_bk_BIP_recs_filtered, named('ds_bk_BIP_recs_filtered'));
	// output(ds_filtered, named('ds_filtered'));
	// output(ds_bk_BIP_recs, named('ds_bk_BIP_recs')); 
	// output(ds_bk_recs_debtor_final, named('ds_bk_recs_debtor_final'));
	// output(ds_tmp_bk_raw_recs_main_fullV3 , named('ds_tmp_bk_raw_recs_main_fullV3'));
	// output(ds_bk_bip_raw_recs2, named('ds_bk_bip_raw_recs2'));
	 
	// output(ds_extract, named('ds_extract'));
	
	// output(ds_filtered_trustee, named('ds_filtered_trustee'));

	// output(ds_bk_recs_attorney_slim, named('ds_bk_recs_attorney_slim'));

	// output(deduped_linkid_cc_ocn, named('deduped_bid_cc_ocn'));

	// output(ds_party_all, named('ds_party_all'));
	// output(ds_party_allSuppressed, named('ds_party_allSuppressed'));

	// output(bankruptcies, named('bankruptcies'));
	 
	return final_records;

end;

end; // module