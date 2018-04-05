/* TBD:
   1. Revise all "joins" for type, keep, limit, etc. and 
      replace join limit with Constants.
   2. Research/resolve open issues, search on "???"
*/
IMPORT AutoStandardI, BIPV2, iesp, MDR, Suppress, UCCV2, UCCV2_Services;

EXPORT UCCSection := MODULE;

 // *********** Main function to return BIPV2 format business report results
 export fn_FullView(
   dataset(TopBusiness_Services.Layouts.rec_input_ids) ds_in_ids_wacctno
	 ,TopBusiness_Services.Layouts.rec_input_options_ucc in_options
	 ,AutoStandardI.DataRestrictionI.params in_mod 
   ,unsigned2 in_sourceDocMaxCount = iesp.Constants.TopBusiness.MAX_COUNT_BIZRPT_SRCDOC_RECORDS
 ):= function
 
  FETCH_LEVEL := in_options.BusinessReportFetchLevel;

  // Strip off the input acctno from each record, will re-attach them later.
	ds_in_ids_only := project(ds_in_ids_wacctno,transform(BIPV2.IDlayouts.l_xlink_ids,
	                                                       self := left,
																							           self := []));
																												 
  // ****** Get UCC tmsids/rmsids or each set of input linkids
  //
  // *** Key fetch to get ucc tmsid/rmsid data from new bip2 linkids key file.
  ds_linkids_keyrecs := TopBusiness_Services.Key_Fetches(
	                         ds_in_ids_only,
													 FETCH_LEVEL,TopBusiness_Services.Constants.UCCKfetchMaxLimit).ds_ucc_linkidskey_recs;

	// Filter to only use recs that are not 'A'/Assignee (bug 138650) and 
	// then project onto a slimmed layout.
  ds_linkids_keyrecs_slimmed := project (ds_linkids_keyrecs(party_type != 'A'),
		  transform(TopBusiness_Services.UCCSection_Layouts.rec_ids_with_linkidsdata_slimmed,
				self.source       := MDR.sourceTools.src_UCCv2, // not needed here???
				// v--- not needed here???
				//self.source_docid := trim(left.tmsid,left,right), 
				                     //+ '//' + trim(left.rmsid,left,right),
				// //self.source_recid := left.source_rec_id; //also ???
        // v--- "role_type" field on the interim layout has a different name to distinguish
				//      between the "role" of the "reported-on" company on the UCC filing vs 
				//      the party_type of the record on the party file.
				self.role_type    := //left.party_type,  bip2, vers1???
				                     if(left.party_type = Constants.DEBTOR, //D = Debtor
														    Constants.DEBTOR,Constants.SECUREDPARTY), //S = SecuredParty
			  self              := left, // to preserve ids & other key fields being kept
			));

  // Get the UCC "main" (filing) data for all the tmsids for the linkids.
	//
  // First sort/dedup to only keep 1 record for each tmsid per set of linkids to reduce
	// the number of key lookups when joining to the ucc main key file below.
	ds_linkids_keyrecs_deduped := dedup(sort(ds_linkids_keyrecs_slimmed,
												                   #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			     tmsid // does it matter which tmsid rec ???
																					 ),
																      #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			tmsid);

  // Next join to get all the UCC "main" recs/filing data needed to output on the report and 
	// determine the overall UCC "status".
	set_terminated_types := ['LAPSED','L','RELEASE','EXPUNGED','DELETED',
	                         'TERMINATED','TERMINATION','UCC3 TERMINATION', 'UCC-3 TERMINATION'];

  ds_uccmain_keyrecs := join(ds_linkids_keyrecs_deduped,UCCV2.Key_Rmsid_Main(),
                               keyed(left.tmsid = right.tmsid), //get all recs for the tmsids
	  transform(TopBusiness_Services.UCCSection_Layouts.rec_ids_with_maindata_slimmed,
		  //self.source_docid := left.tmsid, // store tmsid into the bip source_docid field???
			temp_status_type           := StringLib.StringToUpperCase(right.status_type);
			temp_filing_type           := StringLib.StringToUpperCase(right.filing_type);
			//temp_filing_status         := StringLib.StringToUpperCase(right.filing_status),//???
			// rename/check certain fields
			                           // from bip1 ---v, is this still needed ???
			self.orig_filing_number    := if(right.orig_filing_number != '',
			                                 right.orig_filing_number,right.filing_number),
			self.status_type           := temp_status_type,
			self.filing_type           := temp_filing_type,
			// a third field to be used for checking the ucc overall status ---v ??? Discuss wth Tim B???
			//self.filing_status         := temp_filing_status, // ??? OR StringLib.StringToUpperCase(right.filing_status),
	    // Fill in derived UCC overall status(status_code), A=active or T=terminated
			self.status_code           := if(temp_status_type in set_terminated_types or
						                           temp_filing_type in set_terminated_types,
																			 Constants.TERMINATED,Constants.ACTIVE
			                     // also look at filing_status field on the main key ???    AND/OR  
			                     // if expiration_date <= today's date ???
													 // Discuss with Tim B. ???
																			 );
			self := right, // to pull off the ucc main key fields we want                       ???
			               // (which have the same name on the temp layout as on the main key)
			self := left, // to preserve ids & other(?) kept linkids key fields ???
    ),
		left outer, //???
		//keep(???),
		limit(10000,skip) // needed because of bad/generic tmsid=DNB, see bug 148946
	 );

  // Now get rid of partial duplicates (main filing data is duplicated, but records have a
	// different process_date for some reason) seen in some UCCs from D&B(i.e. tmsid = DNB...).
	// (i.e. see ids=?? on the ucc linkids key for tmsid=DNB2010342913520101001 on the 
	// ucc main key).  This shows the same filing info, but there are 2 recs/rmsids on the 
	// ucc main key, so use the latest (highest process_date?).  Also the latest one is the 
	// one that has the most recent collateral info.  NOTE: However that the rmsid on the 
	// latest one might not be the same rmsid as on the linkids key and/or ucc party key.
	// Sometimes the partial duplicate recs have a pseudo sequential rmsid, 
	// i.e. rec1 rmsid=xxxxxx, rec2 rmsid = 2Dxxxxxx, rec3 rmsid=3Dxxxxxx, etc.
	// In all(?) cases the party info will have the rec1 rmsid on it (without the "*D" on 
	// front), not any of the subsequent ones.
	// So even after we identify the filing record to keep in these circumstances, we will 
	// need to revise the rmsid to get rid of the *D on front if present.
  //	
  // So first sort/dedup by linkids, tmsid, filing-number, filing-type & filing-date and 
	// then only keep the record for that info with the latest/highest process_date.
  ds_uccmain_keyrecs_deduped1 := dedup(sort(ds_uccmain_keyrecs,
																            #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
	                                          tmsid, filing_number, filing_type, filing_date, 
																					 -process_date, record),
																       #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			 tmsid, filing_number, filing_type, filing_date);

  // Next fix the rmsid if needed on D&B UCCs. 
  ds_uccmain_keyrecs_deduped2 := 
	   project(ds_uccmain_keyrecs_deduped1,
	           transform(TopBusiness_Services.UCCSection_Layouts.rec_ids_with_maindata_slimmed,
			         self.rmsid := UCCV2_Services.fn_remove_DNB_rmsid_seq(left.rmsid,left.tmsid);
							 self := left;
							 ));
															
  // Temporary record layout to hold both main UCC data and party UCC data.	
	rec_ucc_main_party := record
		TopBusiness_Services.UCCSection_Layouts.rec_ids_with_maindata_slimmed,
		BIPV2.IDlayouts.l_header_ids party_linkids;
		UCCV2.Layout_UCC_Common.Party;
	end;
		
	// Next join the kept main keyrecs (with role counts) to the ucc party key to
	// get all the ucc "party" data for the tmsids & rmsids involved.  We are retrieving
	// the party data here (rather than later on) because we need DIDs & SSNs to do tmsid 
	// suppression before the roles(debtor vs. secured) are tallied.
	ds_uccparty_keyrecs_main_plus_party := join(ds_uccmain_keyrecs_deduped2, UCCV2.Key_Rmsid_Party(),
																						keyed(left.tmsid = right.tmsid and
																									// v--- to get the correct parties for the sub-filings (rmsids)
																									left.rmsid = right.rmsid ),
																					transform(rec_ucc_main_party,
																						// Since linkids for the party were added to the party key layout, 
																						// fill in the "report-by" linkids from the left dataset. 
																						// Create a new macro for this(---v)??? Something like TopBusiness_Services.IDMacros. mac_IespTransferLinkids
																						self.ultid  := left.ultid,
																						self.orgid  := left.orgid,
																						self.seleid := left.seleid,
																						self.proxid := left.proxid,
																						self.powid  := left.powid,
																						self.empid  := left.empid,
																						self.dotid  := left.dotid,
																						// v--- pull off the party key fields we want (which have
																						//   the same name on the temp layout as on the party key)
																						self.party_linkids := right, //???
																						self := left, 
																						self := right, // to preserve other kept linkids/main key fields
																					),
																					left outer, //in case main recs have no party key match
																					//keep(???),
																					limit(10000,skip) //<----- replace with constant???  
																				 );
	
	ds_uccrecs_in := project(ds_uccparty_keyrecs_main_plus_party, 
											transform(uccv2_services.layout_ucc_party_raw, 
														self := left, 
														self := []));
																						
  // Function to suppress records by tmsid.  This function will not actually suppress by a given 
	// tmsid.  (tmsid is not one of the document types currently in the suppression key.)  It will 
	// look for look for dids and ssn in the suppression key, then suppress the tmsids associated
	// with the dids and ssn found in the suppression key.
	ds_uccrecs_tmsids_wout_pulled := UCCv2_Services.fn_pullIDs(ds_uccrecs_in, '');

	ds_uccrecs_w_tmsids_pulled := join(ds_uccrecs_tmsids_wout_pulled, ds_uccmain_keyrecs_deduped2,
																		left.tmsid = right.tmsid, 
																		transform(TopBusiness_Services.UCCSection_Layouts.rec_ids_with_maindata_slimmed, self := right),
																left outer);
								 
	// Count the number of uccs(tmsids) by "role" for each set of linkids.
	//
  // Sort/dedup on just the fields to be tabled/counted: linkids, role_type & tmsid
  ds_uccmain_keyrecs_deduped3 := dedup(sort(ds_uccrecs_w_tmsids_pulled,
																            #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			      role_type,tmsid),
																       #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			 role_type,tmsid);
																			 	
	ds_roles_tabled_counted := table(ds_uccmain_keyrecs_deduped3,
	                                   // Create table layout on the fly
	                                   {#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																      role_type,
																		  role_count := count(group)},
																   #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																   role_type,
																   few); //???

  // Join count of the number of uccs(tmsids) per role for the linkids back to the deduped & 
	// fixed ucc main key recs to attach the total counts for the linkids to all records.
	ds_uccmain_keyrecs_all_wrolecnts := join(ds_uccrecs_w_tmsids_pulled,
																			     ds_roles_tabled_counted,
																			BIPV2.IDmacros.mac_JoinTop3Linkids() and
																      left.role_type = right.role_type,
																		transform(TopBusiness_Services.UCCSection_Layouts.rec_ids_with_maindata_slimmed,
																		  self.total_as_debtor  := if(left.role_type  = Constants.DEBTOR,right.role_count,0);
																		  self.total_as_secured := if(left.role_type != Constants.DEBTOR,right.role_count,0);
																			self := left),
																		inner, //??? or left outer??? should be many to 1 match so inner should be OK???
																		keep(1)  //from bip1, why 1 ???
																		//limit(10000) //???
																		);


  // Since role total counts have been determined; now chop the total # of UCC records per 
	// set of linkids here to just the most recent 100 tmsids "As Debtor" and 
	// 100 tmsids "As Secured" records for each set of linkids (req 0770).
	//
  // First sort/dedup main keyrecs with role counts by: linkids, tmsids & descending 
	// filing_date (note: have to use this one since the orig_filing-date is missing on some
	// recs???) to keep the 1 most recent filing record for each tmsid.
  ds_uccmain_keyrecs_all_dd := dedup(sort(ds_uccmain_keyrecs_all_wrolecnts,
				                                  //#expand(BIPV2.IDmacros.mac_ListAllLinkids()),
																					// All 6(---^) ids or just the top 3(4?) ---v ids ???
																          #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																					tmsid,-filing_date),
				                             //#expand(BIPV2.IDmacros.mac_ListAllLinkids()),
																		 // All 6(---^) ids or just the top 3(4?) ---v ids ???
																     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																		 tmsid);

  // Second, sort/dedup to keep the top 100 most recent recs for each set of linkids & role.
  ds_uccmain_keyrecs_top100_byrole := dedup(sort(ds_uccmain_keyrecs_all_dd,
		                                             //#expand(BIPV2.IDmacros.mac_ListAllLinkids()),
																						     // All 6(---^) ids or just the top 3(4?) ---v ids ???
														                     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																		             role_type,
																					       -filing_date),
		                                        //#expand(BIPV2.IDmacros.mac_ListAllLinkids()),
																						// All 6(---^) ids or just the top 3(4?) ---v ids ???
														                #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																		        role_type,
																						//keep 100, v--- either AsDebtors or AsSecured max count will work
																						keep(iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_UCC_ASDEBTORS));

  // Third, join all the main recs (with role counts) to the ds with the top 100 by role
	// to only keep the main recs for the top 100 UCCs(tmsids) per set of linkids.
  ds_uccmain_keyrecs_wrolecnts := join(ds_uccmain_keyrecs_all_wrolecnts,
		                                   ds_uccmain_keyrecs_top100_byrole,
																         //BIPV2.IDmacros.mac_JoinAllLinkids() and
																				 // All 6(---^) ids or just the top 3(4?) ---v ids ???
																         BIPV2.IDmacros.mac_JoinTop3Linkids() and
																			   left.tmsid  = right.tmsid,
																				 // and/or ???
																		   inner //only left recs that are found in the right ds??? 
																			 //,keep         //??? OR ---v 
																			 //,limit(10000) //???
																		   );

  // Normalize the kept main key recs(with role counts) with a collateral description(string512)
	// to split the main recs up into multiple recs with 100 byte collateral description 
	// fields/child dataset recs.
  ds_uccmain_keyrecs_coll_normed := normalize(ds_uccmain_keyrecs_wrolecnts(collateral_desc !=''),
                                     ((length(trim(left.collateral_desc)) - 1) div 100) + 1,
			transform(TopBusiness_Services.UCCSection_Layouts.rec_ids_with_colldata_split, //??? or TopBusiness.Layout_UCC.Collateral, //???
        self.filing_number := left.filing_number, //what if empty?;is this really an issue??
        self.filing_date   := left.filing_date,   //what if empty???
				self.collateral_sequence    := counter,
				//v--- don't trim leading or trailing space so as to not remove any blank between words
				self.collateral_description := //trim(   //fromp bip1, but no onger needed???
				                                 left.collateral_desc
				                                    [((counter * 100) - 99)..(counter * 100)],
				self := left));
	
	 // Next join the kept main keyrecs (with role counts, minus the recs for tmsids that were removed 
	 // because they need to be suppressed)to the dataset contain ucc party data that we created
	 // earlier.
	 ds_uccparty_keyrecs := join(ds_uccmain_keyrecs_wrolecnts, ds_uccparty_keyrecs_main_plus_party,
                                left.tmsid = right.tmsid and
																      // v--- to get the correct parties for the sub-filings (rmsids)
                                      left.rmsid = right.rmsid,
	                            transform(TopBusiness_Services.UCCSection_Layouts.rec_ids_with_partydata_slimmed,
															  // Since linkids for the party were added to the party key layout, 
                                // fill in the "report-by" linkids from the left dataset. 
																// Create a new macro for this(---v)??? Something like TopBusiness_Services.IDMacros. mac_IespTransferLinkids
                                self.ultid  := left.ultid,
                                self.orgid  := left.orgid,
                                self.seleid := left.seleid,
                                self.proxid := left.proxid,
                                self.powid  := left.powid,
                                self.empid  := left.empid,
                                self.dotid  := left.dotid,
			                          // v--- pull off the party key fields we want (which have
                                //   the same name on the temp layout as on the party key)
																self.party_linkids := right, //???
																self := right, 
                                self := left, // to preserve other kept linkids/main key fields
                              ),
		                          left outer, //in case main recs have no party key match
		                          //keep(???),
		                          limit(10000,skip) //<----- replace with constant???  
	                           );

	// Mask any SSNs on the party records
	// Set the "ssn_mask_value" field that is used in Suppress.MAC_Mask
  string6 ssn_mask_value := AutoStandardI.InterfaceTranslator.ssn_mask_val.val(
	                            project(AutoStandardI.GlobalModule(),
                                      AutoStandardI.InterfaceTranslator.ssn_mask_val.params));   

	Suppress.MAC_Mask(ds_uccparty_keyrecs, ds_uccparty_keyrecs_masked, ssn, blank, true, false);

  // Transforms for the interim/final iesp UCCSection related layouts
	//
  // transform to handle "SourceDocs" child dataset
	iesp.topbusiness_share.t_TopBusinessSourceDocInfo
	  tf_sourcedoc(TopBusiness_Services.UCCSection_Layouts.rec_parent_ucc L) := transform
		   self.BusinessIds := l, // to store all linkids
       self.IdType      := Constants.tmsid,
		   self.IdValue     := l.tmsid,
		   //self.Section     := Constants.UCCSectionName,  //not needed here???
		   self.Source      := l.source,
		   self := []
	end;

  // transform to handle "Party" child dataset
	iesp.TopbusinessReport.t_TopBusinessUCCParty 
	  tf_party(TopBusiness_Services.UCCSection_Layouts.rec_ids_with_partydata_slimmed l) := transform
	  self.OriginalName := l.orig_name;
		self.CompanyName  := l.company_name,
	  self.TaxId        := l.fein,
		self.SSN          := l.ssn,
		self.Name.Full    := '';
		self.Name.First   := l.fname;
		self.Name.Middle  := l.mname;
		self.Name.Last    := l.lname;
		self.Name.Suffix  := l.name_suffix;
		self.Name.Prefix  := l.title;
		self.Address.StreetNumber        := l.prim_range;
		self.Address.StreetPreDirection  := l.predir;
		self.Address.StreetName          := l.prim_name;
		self.Address.StreetSuffix        := l.suffix;
		self.Address.StreetPostDirection := l.postdir;
		self.Address.UnitDesignation     := l.unit_desig;
		self.Address.UnitNumber          := l.sec_range;
		self.Address.StreetAddress1      := '';
		self.Address.StreetAddress2      := '';
		self.Address.City                := l.p_city_name;
		self.Address.State               := l.st;
		self.Address.Zip5                := l.zip5;
		self.Address.Zip4                := l.zip4;
    self.Address.County              := ''; 
    self.Address.PostalCode          := '';
    self.Address.StateCityZip        := '';
	end;

  // transform to handle "Collateral" child dataset
	iesp.TopbusinessReport.t_TopBusinessUCCCollateral 
	  tf_collateral(TopBusiness_Services.UCCSection_Layouts.rec_ids_with_colldata_split l) := transform
    self.FilingNumber          := L.filing_number,
		self.FilingDate            := iesp.ECL2ESP.toDate((unsigned) L.filing_date),
		self.CollateralSequence    := l.collateral_sequence,
		self.CollateralDescription := l.collateral_description,
	end;

  // "Filings" parent/child dataset transform #1 to add party children
  TopBusiness_Services.UCCSection_Layouts.rec_parchild_filing 
	  tf_filings_parchild1(TopBusiness_Services.UCCSection_Layouts.rec_ids_with_maindata_slimmed L,
			                   dataset(TopBusiness_Services.UCCSection_Layouts.rec_ids_with_partydata_slimmed) R) := transform
			self.FilingNumber   := L.filing_number,
			self.FilingDate     := iesp.ECL2ESP.toDate((unsigned) L.filing_date),
			self.FilingType     := L.filing_type,
			self.ExpirationDate := iesp.ECL2ESP.toDate((unsigned)L.expiration_date),
			self.Debtors   := choosen(dedup(project(
				 dedup(R(party_type = Constants.DEBTOR and party_linkids.seleid != 0),party_linkids.seleid,all) +
				 R(party_type = Constants.DEBTOR and party_linkids.seleid = 0), tf_party(left)),
																		  record,all),
															  iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_UCC_DEBTORS),
			self.Secureds  := choosen(dedup(project(
				 dedup(R(party_type = Constants.SECUREDPARTY and party_linkids.seleid != 0),party_linkids.seleid,all) +
				 R(party_type = Constants.SECUREDPARTY and party_linkids.seleid = 0), tf_party(left)),
																		  record,all),
															  iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_UCC_SECUREDS),
			self.Assignees := choosen(dedup(project(
				 dedup(R(party_type = Constants.ASSIGNEE and party_linkids.seleid != 0),party_linkids.seleid,all) +
				 R(party_type = Constants.ASSIGNEE and party_linkids.seleid = 0), tf_party(left)),
																		  record,all),
															  iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_UCC_ASSIGNEES),
			self.Collaterals := [], //null here, will be filled in below
			self             := L;
	end;

  // "Filings" parent/child dataset transform #2 to add collateral children
  TopBusiness_Services.UCCSection_Layouts.rec_parchild_filing 
	  tf_filings_parchild2(TopBusiness_Services.UCCSection_Layouts.rec_parchild_filing L,
			                   dataset(TopBusiness_Services.UCCSection_Layouts.rec_ids_with_colldata_split) R) := transform
			// only use "R" recs with non-blank collateral_description ---v      
			// Not needed here since also done above when main key collateral_description is split out???  
			self.Collaterals := choosen(project(R(collateral_description !=''),
			                                    tf_collateral(left)),
			                            iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_UCC_COLLATERALS),
			self             := L;
	end;


  // *** Build interim child/parent recs in iesp layouts
  //	
  // Denormalize first to build parent/child "Filings" recs in interim/iesp layouts with 
	// the appropriate "Party" children.
	
	ds_filings_parchild_recs1 := denormalize(ds_uccmain_keyrecs_wrolecnts, 
																					 ds_uccparty_keyrecs_masked,
																			       left.tmsid = right.tmsid   and
																			       left.rmsid = right.rmsid,
		                                       group,
		                                       tf_filings_parchild1(left,rows(right)));

  // Denormalize a second time to add on "collateral" child recs to the "Filings" parent recs.
  ds_filings_parchild_recs2 := denormalize(ds_filings_parchild_recs1,
	                                         ds_uccmain_keyrecs_coll_normed,
																			       left.tmsid = right.tmsid   and
																			       left.rmsid = right.rmsid,
		                                       group,
		                                       tf_filings_parchild2(left,rows(right)));

 // Next build parent/child "UCC" recs in interim/iesp layouts
 // 
 // transform to handle UCC "parent" dataset
	TopBusiness_Services.UCCSection_Layouts.rec_parent_ucc 
	  tf_ucc_parent(TopBusiness_Services.UCCSection_Layouts.rec_ids_with_maindata_slimmed L,
			            dataset(TopBusiness_Services.UCCSection_Layouts.rec_parchild_filing) R) := transform
			// Use all rows of "R" dataset for the "Filings" child ds, but first create a temp ds
			// to use below so can get to the first record to determine the latest-filing-type.
			// Also sort them in reverse chron filing-date/number order for report display.
			temp_filings := choosen(sort(project(R,iesp.topbusinessReport.t_TopBusinessUCCFiling),
			                             -FilingDate.Year, -FilingDate.Month, -FilingDate.Day,
																	 -FilingNumber),
			                        iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_UCC_FILINGS);
			self.Filings := temp_filings,
			// v--- Output filing_type of the first "Filings" record, i.e. the one with latest filing_date
			self.LatestFilingType     := temp_filings[1].FilingType,
			self.FilingJurisdiction   := L.filing_jurisdiction, 
			self.OriginalFilingNumber := L.orig_filing_number, 
			self.OriginalFilingDate   := iesp.ECL2ESP.toDate((unsigned)L.orig_filing_date),
			self.FilingAgencyName     := L.filing_agency,
			self.FilingAgencyAddress  := iesp.ECL2ESP.SetAddress(
				'','','','','','','',
				trim(L.city),
				trim(L.state),
				trim(L.zip), //...zip[1..5]), //???
				'', //zip4 ???
				'', //l.county, ???
				'',
				L.address,  //addr1
				'', //addr2,
				);
		  // Create 1 row of SourceDocs dataset
			// change to use tf_sourcedoc somehow???
			self.SourceDocs := dataset([
			   transform(//iesp.TopBusinessReport.t_TopBusinessReportItemInfo, //vers1 ???
									 iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
			     self.BusinessIds := l, // to store all linkids
		       //self.SourceCode  := l.source,       //vers1???
           //self.SourceDocId := l.tmsid, //vers1???
           self.IdType      := Constants.tmsid,
		       self.IdValue     := l.tmsid,
		       //self.Section     := Constants.UCCSectionName,
		       self.Source      := l.source,
		       //self.BusinessIds := l, // to store all linkids
		       self := [])]);
					 
			self := L;  //keep ids and other needed fields from "L" ucc main data slimmed layout
	end;

  // Sort/dedup main keyrecs to only keep the 1 most recent rec for each linkids/tmsid combo
	// OR just do a dedup all???
  ds_uccmain_keyrecs_deduped4 := dedup(sort(ds_uccmain_keyrecs_wrolecnts,
														                #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			      tmsid,
																						//-orig_filing_date,  ???
																		        // ---^ not all sub-filings for a tmsid have the orig filing date on them.
																						// see tmsid=TX80001525011
																						// may have to populate the orig_filing_date on all recs for a tmsid ???
																						-orig_filing_number,
																						-filing_date,-filing_number,
																						-status_code),
																						//,source_docid), ???
														           #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			 tmsid); // & ...,source_docid);???

  // Denormalize to build parent/child "ucc" recs in interim/iesp layouts
  ds_ucc_parent_recs := denormalize(ds_uccmain_keyrecs_deduped4,
	                                  ds_filings_parchild_recs2,
																			BIPV2.IDmacros.mac_JoinTop3Linkids() and //is this needed???
																			left.tmsid = right.tmsid,
		                                group,
		                                tf_ucc_parent(left,rows(right)));

  // Rollup to build parent ucc "role" recs in interim/iesp layouts
  TopBusiness_Services.UCCSection_Layouts.rec_parent_role
	  tf_role_parent(TopBusiness_Services.UCCSection_Layouts.rec_parent_ucc l,
	                 dataset(TopBusiness_Services.UCCSection_Layouts.rec_parent_ucc) allrows)	:= transform
			// Use all rows with appropriate status_code to create the "*UCCs" & "*SourceDocs" child datasets
			self.ActiveUCCs := choosen(sort(project(allrows(status_code = Constants.ACTIVE),
			                                        iesp.TopbusinessReport.t_TopbusinessUCC), 
																			-OriginalFilingDate.Year,-OriginalFilingDate.Month,
																			-OriginalFilingDate.Day,-OriginalFilingNumber), 
																 iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_ACTIVE_UCCS),
			self.ActiveSourceDocs := if(count(allrows(status_code = Constants.ACTIVE)) > 0,
           choosen(project(allrows(status_code = Constants.ACTIVE),
													 tf_sourcedoc(left)),
								   in_sourceDocMaxCount),
					 //[] caused syntax errors???
           dataset([],iesp.topbusiness_share.t_TopBusinessSourceDocInfo)
					 ),
			self.TerminatedUCCs := choosen(sort(project(allrows(status_code = Constants.TERMINATED),
																									iesp.TopBusinessReport.t_TopBusinessUCC), 
																									-OriginalFilingDate.Year,-OriginalFilingDate.Month,
																									-OriginalFilingDate.Day,-OriginalFilingNumber), 			
																     iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_TERMINATED_UCCS),
			self.TerminatedSourceDocs := if(count(allrows(status_code = Constants.TERMINATED)) > 0,
           choosen(project(allrows(status_code = Constants.TERMINATED),
													 tf_sourcedoc(left)),
								   in_sourceDocMaxCount),
					 //[] caused syntax errors???
           dataset([],iesp.topbusiness_share.t_TopBusinessSourceDocInfo)
					 ),
			self := l;  // to assign rest of the individual fields
	end;
	
	ds_role_parent_recs := rollup(group(sort(ds_ucc_parent_recs,
														               #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																		       role_type),
														          #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			role_type),
		                            group,
			                          tf_role_parent(left,rows(left)));


  // Denormalize one last time to determine the "role" the reported-on company (linkids) holds 
	// on the UCC, either "As the Debtor" or "As the Secured Party/Assignee".
	// Also at the same time, re-attach the input acctno to the denormed recs. 
	ds_recs_wacctno_joined := denormalize(ds_in_ids_wacctno,ds_role_parent_recs,
																			  BIPV2.IDmacros.mac_JoinTop3Linkids(),
		                                    group,
    // v--- change to stand-alone transform???																				
		transform(TopBusiness_Services.UCCSection_Layouts.rec_parent_uccsection,
			self.acctno    := left.acctno,
			self.AsDebtor  := project(rows(right)(role_type = Constants.DEBTOR), 
			                          iesp.TopbusinessReport.t_TopbusinessUCCRole)[1], // had to use [1]???
			self.AsSecured := if (in_options.IncludeUCCFilingsSecureds,
                            project(rows(right)(role_type != Constants.DEBTOR), //in ['S','A']),
														        iesp.TopbusinessReport.t_TopbusinessUCCRole)[1], // had to use [1]???
														// even though creating empty ds, had to use [1] (------v) due to syntax error???
														dataset([],iesp.TopbusinessReport.t_TopbusinessUCCRole)[1] 
														),
			self.DerogSummaryCntUCC     := count(self.AsDebtor.ActiveUCCs), //only AsDebtor active recs per req BIZ2.0-0740
			self.SecuredAssetsCntUCC    := if (in_options.IncludeUCCFilingsSecureds,
			                                   count(self.AsSecured.ActiveUCCs),0), //only AsSecured active recs per req BIZ2.0-074?
	    self.ReturnedAsDebtorCount  := count(self.AsDebtor.ActiveUCCS) + 
																		 count(self.AsDebtor.TerminatedUCCS),
	    self.TotalAsDebtorCount     := sum(rows(right),total_as_debtor),
	    self.ReturnedAsSecuredCount := if (in_options.IncludeUCCFilingsSecureds,
			                                   count(self.AsSecured.ActiveUCCs) + 
			                                   count(self.AsSecured.TerminatedUCCs),0),
	    self.TotalAsSecuredCount    := if (in_options.IncludeUCCFilingsSecureds,
			                                   sum(rows(right),total_as_secured),
																				 0),
			self := right  // to store all link ids
			));

	// Roll up all recs for the acctno
  ds_final_results := rollup(group(sort(ds_recs_wacctno_joined,acctno),
		                               acctno),
														 group,
		                         transform(TopBusiness_Services.UCCSection_Layouts.rec_final,
		                                     self := left));

  // Uncomment for debugging
  // output(ds_in_ids_wacctno,                 named('ds_in_ids_wacctno'));
	// output(ds_in_ids_only,                    named('ds_in_ids_only'));
  // output(ds_linkids_keyrecs,                named('ds_linkids_keyrecs'));
  // output(ds_linkids_keyrecs_slimmed,        named('ds_linkids_keyrecs_slimmed'));
	// output(ds_linkids_keyrecs_deduped,        named('ds_linkids_keyrecs_deduped'));

  // output(ds_uccmain_keyrecs,                named('ds_uccmain_keyrecs'));
  // output(ds_uccmain_keyrecs_deduped1,       named('ds_uccmain_keyrecs_deduped1'));
  // output(ds_uccmain_keyrecs_deduped2,       named('ds_uccmain_keyrecs_deduped2'));
  // output(ds_uccmain_keyrecs_deduped3,       named('ds_uccmain_keyrecs_deduped3'));
  // output(ds_roles_tabled_counted ,          named('ds_roles_tabled_counted'));
  // output(ds_uccmain_keyrecs_all_wrolecnts,  named('ds_uccmain_keyrecs_all_wrolecnts'));
  // output(ds_uccmain_keyrecs_all_dd,         named('ds_uccmain_keyrecs_all_dd'));
  // output(ds_uccmain_keyrecs_wrolecnts,      named('ds_uccmain_keyrecs_wrolecnts'));
  // output(ds_uccmain_keyrecs_coll_normed,    named('ds_uccmain_keyrecs_coll_normed'));

  // output(ds_uccparty_keyrecs,               named('ds_uccparty_keyrecs'));
  // output(ds_uccparty_keyrecs_masked,        named('ds_uccparty_keyrecs_masked'));

  // output(ds_filings_parchild_recs1,         named('ds_filings_parchild_recs1'));
  // output(ds_filings_parchild_recs2,         named('ds_filings_parchild_recs2'));
  // output(ds_uccmain_keyrecs_deduped4,       named('ds_uccmain_keyrecs_deduped4'));
  // output(ds_ucc_parent_recs,                named('ds_ucc_parent_recs'));
  // output(ds_role_parent_recs,               named('ds_role_parent_recs'));
  // output(ds_recs_wacctno_joined,            named('ds_recs_wacctno_joined'));
	
	return ds_final_results;

 END; // end of the fn_FullView function
	
END; //end of the module

/*  to test, in a builder window use this: 
IMPORT AutoStandardI;

	tempmod := module(AutoStandardI.DataRestrictionI.params)
		export boolean AllowAll := false;
		export boolean AllowDPPA := false;
		export boolean AllowGLB := false;
		export unsigned1 DPPAPurpose := 0 : stored('DPPAPurpose');
		export unsigned1 GLBPurpose := 0 : stored('GLBPurpose');
		export boolean includeMinors := false;
    //        position 3=0 to use EBR  -----v
		export string DataRestrictionMask := '000000000000000' : stored('DataRestrictionMask');
		export boolean ignoreFares := false;
		export boolean ignoreFidelity := false;
	end;

  // Set SSN Mask for testing in certain sections: UCC, Liens, Bankr 
	string6 SSNMask := 'NONE'; //for testing chg default to: FIRST5, LAST4 or ALL
  #stored('SSNMask', SSNMask);

  // Report sections input options.  
	// Just 2 booleans for now: lnbranded and internal_testing
  // 3rd parm is IncludeUCCFilingsV2Secureds, changed as needed for testing
  ds_options_ucc := dataset([{false, false, true}
                            ],topbusiness_services.Layouts.rec_input_options_ucc);

// input dataset layout= acctno,DotID,EmpID,POWID,ProxID,OrgID,UltID  
ucc_sec := TopBusiness_Services.UCCSection.fn_FullView(
             dataset([
						          //{'test1d', 0, 0, 0, 3, 3, 3} // 13 linkid recs, 9 tmsids/13 rmsids, all as debtor
						          //{'test2d', 0, 0, 0, 20, 20, 20} // 36 linkid recs, 28 tmsids/?? rmsids, 8 as debtor & 20 as secured
			                //{'test3d', 0, 0, 0, 28, 28, 28} // 10 linkid recs, 3 tmsids/6 rmsids, all as debtor
						          //{'test4d', 0, 0, 0, 30, 30, 30} // 6 linkid recs, 2 tmsids/6 rmsids, all as debtor
						          //{'test5d', 0, 0, 0, 40, 40, 40} // 1 tmsid/rmsid as debtor
						          //{'test6d', 0, 0, 0, 41, 41, 41} // 1 tmsid/2 rmsids/1 filing# as secured
						          //{'test7d', 0, 0, 0, 52, 52, 52} // 10 linkid recs, 7 tmsids/10 rmsids, all as debtor
						          //{'test8?', 0, 0, 0, 332, 332, 332} // 28 linkid recs, ? tmsids/?? rmsids, as debtor & as SP
						          //{'test9d1', 0, 0, 0, 14183781, 14183781, 14183781, 14183781} // 9 linkid recs, 5 tmsids/9 rmsids, bug 126493/example1
						          //{'test9d2', 0, 0, 0, 118060741, 118060741, 118060741, 118060741} // 2 linkid recs, 2 tmsids/2 rmsids, bug 126493/example2
						          //{'test10d', 0, 0, 0, 128061, 128061, 128061, 128061} // 3linkid recs, 1 tmsids/3 rmsids, bug 126584
						          //{'test11ad', 0, 0, 0, 261, 261, 261, 261} // 46 linkid recs, ?? tmsids/?? rmsids, bug 123850 test1
						          //{'test11bd', 0, 0, 0, 139113912, 139113912, 139113912, 139113912} // 1280 linkid recs, 914 tmsids/rmsids, 6 as debtor, 908 as sp, bug 123850 example1
					            //{'test12p', 0, 0, 0, 88, 88, 88, 88} // bug 120330, a ucc, 5 bus with a person with an ssn
					            //{'test13p', 0, 0, 0, 0, 139113912, 139113912, 139113912} // bug 133798, 1281 linkids key recs, duplicate Debtors on tmsid=DNB2006014719-320060510
					            //{'test14p', 0, 0, 0, 0, 159332797, 159332797, 159332797} // bug 138650, 4 linkids key recs only 3 s/b used

                  ],topbusiness_services.Layouts.rec_input_ids)
						,ds_options_ucc[1]
					  ,tempmod
            );
output(ucc_sec);
// */
