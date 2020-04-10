/* TBD : 
   1. Research/resolve open issues, search on "???"
*/
IMPORT AutoStandardI, BIPV2, iesp, LiensV2, MDR, Suppress,  liensv2_services, TopBusiness_Services;


           
EXPORT LienSection := MODULE;

EXPORT GetLienBipLinkids(dataset(BIPV2.IDlayouts.l_xlink_ids)   ds_in_unique_ids_only, 
                                                  string1 FETCH_LEVEL) := 
                     TopBusiness_Services.Key_Fetches(
	                    ds_in_unique_ids_only // input file to join key with
				    ,FETCH_LEVEL // level of ids to join with
										              // 3rd parm is ScoreThreshold, take default of 0
					 ).ds_liens_linkidskey_recs;		

 // *********** Main function to return BIPV2 format business report results
 export fn_FullView(
   dataset(TopBusiness_Services.Layouts.rec_input_ids) ds_in_ids
	 ,TopBusiness_Services.Layouts.rec_input_options in_options
	 ,AutoStandardI.DataRestrictionI.params in_mod
   ,unsigned2 in_souceDocMaxCount = iesp.Constants.TopBusiness.MAX_COUNT_BIZRPT_SRCDOC_RECORDS
                   ):= function 
   FETCH_LEVEL := in_options.BusinessReportFetchLevel;

  // Strip off the input acctno from each record, will re-attach them later.
	ds_in_ids_only := project(ds_in_ids,transform(BIPV2.IDlayouts.l_xlink_ids,
	                                                       self := left, self := []));
                                                         
  // ****** Get the needed linkids key J&Ls info for each set of input linkids
  //
  // *** Key fetch to get Liens tmsid/rmsid data from new bip2 linkids key file.
   ds_linkids_keyrecs := GetLienBipLinkids( ds_in_ids_only, FETCH_LEVEL);
  // Project onto a slimmed layout and filter linkids key recs to only use ones where
	// "name_type" is a D(Debtor) or C(Creditor), but not A(Attorney) or AD(Attorney for Debtor 
	// or T=Third Party?); per req 0717?). ???
  ds_linkids_keyrecs_slimmed := project (ds_linkids_keyrecs(name_type[1] = 'C' or 
	                                                          name_type[1] = 'D'),
		  transform(TopBusiness_Services.LienSection_Layouts.rec_ids_with_linkidsdata_slimmed,
				self.source          := MDR.sourceTools.src_Liens_v2, 
				self.source_docid    := trim(left.tmsid,left,right),
				// v--- Only need the first character of party "name_type" which should indicate the
				// "role" (i.e. D=Debtor, C=Creditor) on the filing of the company being reported on.
				// Is this even needed???  JLs are not like UCCs where need to distinguish between
				// "AsDebtor" and "AsSecurred"???
                   self.role_party_type := left.name_type[1],
			  self := left, // to preserve ids & other key fields being kept
			  self := [], // to null out any unassigned fields, tot_rec_count???
			));

  // Sort/dedup by linkids, tmsid & rmsid(?) to only keep 1(which one?) record per 
	// linkids/tmsid/rmsid combo.  //Is this even a problem???
  ds_linkids_keyrecs_deduped := dedup(sort(ds_linkids_keyrecs_slimmed,
				                                   #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),																			
																			     tmsid,rmsid),
				                              #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			tmsid,rmsid);
 
  // Next join to get the Liens "main"(filing) data needed to output on the report.
  ds_main_keyrecs := join(ds_linkids_keyrecs_deduped,
	                                          LiensV2.Key_liens_main_ID(),
									keyed(left.tmsid = right.tmsid and
										       left.rmsid  = right.rmsid
														      //^--- only get main key recs with the same rmsid as the linkids key
                                 ),
	  transform(TopBusiness_Services.LienSection_Layouts.rec_ids_with_maindata_slimmed,		
               self.acctno := '';																		
			self := right, // to pull off the Liens main key fields we want
			               // (which have the same name on the temp layout as on the main key)
			self := left,  // to preserve ids & any other kept linkids key fields					
    ),
		inner, // only key recs that match, but shouldn't there always be a match???
		// keep all matches???  
		limit(10000) //??? chg to TopBusiness_services.Constants.???
	 );
	 
	 // call the new function to put values into these 2 fields: case_link_id and the case_link_priority 	 
	outDStmp := liensv2_services.fn_link_liens_cases(ds_main_keyrecs,  true, acctno);
	
	// keep this logic in here to populate the various fields if they are not there
	// following call to  fn_link_liens_cases function call to populate the 2 new fields.
	outDS :=  project(outDStmp, transform(recordof(outDStmp),
	   self.orig_filing_number := if(left.orig_filing_number !='',
			                              left.orig_filing_number,left.filing_number);
			self.orig_filing_date   := if(left.orig_filing_date !='',
			                              left.orig_filing_date,left.filing_date);
			self.orig_filing_type   := if(left.orig_filing_type !='',
			                              left.orig_filing_type,left.filing_type_desc);
			self := left));

  // Next, sort/dedup by linkids, case_link_id and case_link_priority,
	//
	// this example may not apply any more
	// This is being done due to extra/invalid/replaced filing data on the Liens main key 
	// for certain tmsids.   (i.e. see ult/org/sele ids=510 on the linkids key and the record with
	// tmsid=CA00000219060681.  On the Liens main tmsid_rmsid key for that tmsid value, 
	// it has the same orig/filing info on 2 sets of 4 recs on the Liens main key).
	
	// new logic.  Sort/dedup by case_link_id and sort by case_link_priority
  
  // added here to replace ds_main_keyrecs_deduped1	 
	// and to keep the 'amount' field value and 3 other field values too since rows that have that field populated 
	// seemed to be ranked with the higher values of case_link_priority field thus pushing them to bottom  of set during rollup so saving this
	// 'amount' value and the 3 other fields here as rollup happens.
  ds_main_keyrecs_deduped1 := rollup( sort(outDS,     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
							         case_link_id, case_link_priority),
	                                                                BIPV2.IDmacros.mac_JoinTop3Linkids() AND
	                                                                 left.case_link_id = right.case_link_id, 
												transform(recordof(OUTDS),
													self.amount := if (left.amount  != '', left.amount, right.amount);;
													self.filing_type_desc := if (left.filing_type_desc  != '', left.filing_type_desc,  right.filing_type_desc); 
													self.filing_number := if (left.filing_number != '', left.filing_number, right.filing_number); 
													self.filing_jurisdiction := if (left.filing_jurisdiction != '', left.filing_jurisdiction,  right.filing_jurisdiction); 
													self := left;
													self := right));
										
  // Now count the number of filings(case_link_ids) per each set of linkids
  rec_layout_filings_count := record
	    ds_main_keyrecs_deduped1.ultid;
	    ds_main_keyrecs_deduped1.orgid;
	    ds_main_keyrecs_deduped1.seleid;
      filings_count := COUNT(GROUP);
  end;
													
  // Then table to count the number of filings (case_link_id) per set of linkids
	ds_ids_filings_tabled := table(ds_main_keyrecs_deduped1,
	                                                        rec_layout_filings_count,
												#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
												few);  //few???
 
  // Join number of filings count for the linkids back to the non-restricted recs. 
	ds_main_keyrecs_dd2_plus_counts := join(ds_main_keyrecs_deduped1,
	                                                                                 ds_ids_filings_tabled,
																          BIPV2.IDmacros.mac_JoinTop3Linkids(),
																		      transform(TopBusiness_Services.LienSection_Layouts. rec_ids_with_maindata_slimmedExtra,																					             
																		         self.tot_rec_count :=  right.filings_count;
																				self.case_link_id := left.case_link_id;
																				self.case_link_priority := left.case_link_priority;
																			       self := left),
																		      inner, //??? or left outer???
																		      //keep(?????) //???
																					limit(10000,skip) //???
																					);

	// Sort recs by linkids & descending orig_filing_date & filing-date; then dedup to only
	// keep the 100(per req 0710) most recent(?) filings/tmsids for each set of linkids.
	// Revise to use topn(...     ---v   ???
	ds_main_keyrecs_dd2_top100 := dedup(sort(ds_main_keyrecs_dd2_plus_counts,
																		       #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),																					
																					 case_link_priority,																				
																						record),
																      #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																		  keep(TopBusiness_Services.Constants.liens_max_main_recs));// keep 100???
																			// change ---^ to use iesp.constants.topbusiness_max_???

  // Join the top 100 ds back to the deduped ds_main_keyrecs to keep all 
	// the case_link_id
	// the rmsids for the tmsids being kept.
	ds_main_keyrecs_top100_perids := join(ds_main_keyrecs_deduped1,
	                                                                         ds_main_keyrecs_dd2_top100,
																          BIPV2.IDmacros.mac_JoinTop3Linkids()
																					and left.case_link_id = right.case_link_id,																				
																		      transform(TopBusiness_Services.LienSection_Layouts.rec_ids_with_maindata_slimmedExtra,																	
																		         self.tot_rec_count := right.tot_rec_count;
																			       self := left),
																		      inner, //??? or left outer???
																		      //keep(?????) //???
																					limit(10000,skip) //???
																					);

  // Sort & group all the main recs (for 1 orig filing) by the linkids & case_linkid

  //
  // smart linx bus enhacement changes sort to sort on new field case_link_id, before rollup
  // 
	ds_main_keyrecs_srtd_grpd := group(sort(ds_main_keyrecs_top100_perids,
																				  #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																					case_link_id,
																					case_link_priority  // lowest # first
																					 // in filing(rmsid) order??? To put the
																					       // correct orig_filing_type on the first rec
																								 // (in case there are > 1) for a tmsid???
																					// v--- are any of these needed? since we are just 
																					// going to roll all recs for a tmsid up anyways
																					// and they will be sorted into output order later???
																					//filing_jurisdiction, // puts non-blank ones last???
																					//filing_date,   //is this needed???
																					//filing_number, //is this needed???
																					//record
																					// this next line is commented out.
																					////process_date // oldest first for a tmsid/rmsid???
																					),
                                     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																		 case_link_id																		
																		 );

  // Then do a group rollup on all recs for a tmsid for a set of linkids to create the 
	// main "filing_info"  and the individual "filings" child dataset.
	TopBusiness_Services.LienSection_Layouts.rec_LiensDataParent tf_rollup_mainrecs(
		TopBusiness_Services.LienSection_Layouts.rec_ids_with_maindata_slimmedExtra l,
		dataset(TopBusiness_Services.LienSection_Layouts.rec_ids_with_maindata_slimmedExtra) allrows) := transform
		  self.filing_jurisdiction  := max(allrows(filing_jurisdiction !=''),filing_jurisdiction),
			self.orig_filing_date     := min(allrows(orig_filing_date !=''),orig_filing_date), 
			self.orig_filing_number   := min(allrows(orig_filing_number !=''),orig_filing_number),
			self.orig_filing_type     := min(allrows(orig_filing_type !=''),orig_filing_type),
			self.amount               := max(allrows(amount !=''),amount), 
			self.eviction             := max(allrows(eviction !=''),eviction),
			// Use all non-blank filing info rows of the group to create the "Filings" child dataset
		  self.filings              := choosen(//dedup(  //<--- why dedup here??? from bip1???  was there an issue with duped filings???
			                                             // only use main recs with some (subsequent) filing info???
			                                             project(allrows(filing_number    !='' or 
                                                                   filing_type_desc !='' or
		                                                               filing_date      !='' //or ???
																																	 //orig_filing_number != '' or //???
																																	 //orig_filing_type != ''   or //??? 
																																	 //orig_filing_date !=''       //???
																																	 //or other fields???
																																	 ),
		                                                       transform(TopBusiness_Services.LienSection_Layouts.rec_LiensDataChild_Filings, 
																																			 self := left)), 
																									//record, all), 
																					 iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_LIENS_FILINGS);
      self.ret_rec_count := 1; //1 rec per group/tmsid
	 self.tot_rec_count := allrows[1].tot_rec_count; //??? 
      self := l;  //  to preserve ids & any other kept left fields
			self := []; // to null out the 2 diff party child datasets here since they will be created below???
	end;

	ds_main_keyrecs_rolled0 := rollup(ds_main_keyrecs_srtd_grpd,
	                                                                group,
												tf_rollup_mainrecs(left,rows(left)));

  // Filter to remove main recs without at least 1 of the 3 necessary original filing fields. ???
  ds_main_keyrecs_rolled := ds_main_keyrecs_rolled0(orig_filing_number != '' or
	                                                                                              orig_filing_date   != '' or
                                                                                                   orig_filing_type   != '');

  // Next join the deduped linkid keyrecs to the Liens party key to get all the Liens
	// "party" data for the filings(tmsids) involved to output on the report.
	//
	// OR just use ds_main_keyrecs_rolled ---v ???
  ds_party_keyrecs := join(outDS,                        
	                         LiensV2.key_liens_party_ID(),
                             keyed(left.tmsid = right.tmsid 
											        // v--- to get the correct parties for the sub-filings (rmsids)
                               and left.rmsid = right.rmsid
                          ),
	  transform(TopBusiness_Services.LienSection_Layouts.rec_ids_with_partydata_slimmed,
			// Since linkids for the party were added to the party key layout, 
      // fill in the "report-by" linkids from the left dataset. 
			// Create a new macro for this(---v)??? Something like TopBusiness_Services.IDMacros. mac_IespTransferLinkids
      self.case_link_id := left.case_link_id;
	 self.case_link_priority := left.case_link_priority;	
      self.ultid  := left.ultid,
      self.orgid  := left.orgid,
      self.seleid := left.seleid,
      self.proxid := left.proxid, //???
      self.powid  := left.powid,  //???
      self.empid  := left.empid,  //???
      self.dotid  := left.dotid,  //???
      // Store certain party key fields individually.
			// Only keep tin/ssn/address fields for Debtor records (req 0717)
			IsDebtor         := right.name_type[1] = TopBusiness_Services.Constants.DEBTOR;
      self.tax_id      := if(IsDebtor,right.tax_id,''); // fein when party is a company???
		  self.ssn         := if(IsDebtor,right.ssn,'');    // only when a party is a person???
		  self.prim_range  := if(IsDebtor,right.prim_range,'');
		  self.predir      := if(IsDebtor,right.predir,'');
		  self.prim_name   := if(IsDebtor,right.prim_name,'');
		  self.addr_suffix := if(IsDebtor,right.addr_suffix,'');
		  self.postdir     := if(IsDebtor,right.postdir,'');
		  self.unit_desig  := if(IsDebtor,right.unit_desig,'');
		  self.sec_range   := if(IsDebtor,right.sec_range,'');
		  self.p_city_name := if(IsDebtor,right.p_city_name,'');
		  self.v_city_name := if(IsDebtor,right.v_city_name,'');			
		  self.st          := if(IsDebtor,right.st,'');
		  self.zip         := if(IsDebtor,right.zip,'');
		  self.zip4        := if(IsDebtor,right.zip4,'');
		 				   
			// v--- to pull off the rest of the Liens party key "name" related  fields we want
			// (which have the same name on the temp layout as on the party key)
			self :=right,
			self := left, // to preserve other kept linkids key fields
    ),
		inner, // only ones that match(?) OR left outer, //???
		// keep all matches.  ???
		// then count them and limit them to 100 parties per a set of linkids/tmsid(?) below???
    //keep(TopBusiness_Services.Constants.liens_max_party_recs)); //from bip1??? only keep 100 recs
		limit(10000,skip) //???
	 );

	// Might have duplicate party recs across all the recs for a tmsid; 
	// so dedup to remove any duplicates???           from bip1, is this still needed???
	//
	// added fields to the except list here.
	ds_party_keyrecs_deduped := dedup(ds_party_keyrecs,record, except rmsid, 
	                                 // added here 2 new fields smart linx bus enhancements project
							case_link_id,
	                                 case_link_priority,
							all);

  // Mask any SSNs on the party records
	// Set the "ssn_mask_value" field that is used in Suppress.MAC_Mask
  string6 ssn_mask_value := AutoStandardI.InterfaceTranslator.ssn_mask_val.val(
	                            project(AutoStandardI.GlobalModule(),
                                      AutoStandardI.InterfaceTranslator.ssn_mask_val.params));   

	Suppress.MAC_Mask(ds_party_keyrecs_deduped, ds_party_keyrecs_masked, ssn, blank, true, false);

  // Group denormalize mainrecs rolled and deduped party recs to attach party/child recs 
	// to their associated main/parent recs.
  TopBusiness_Services.LienSection_Layouts.rec_LiensDataParent tf_denorm_parties(
		TopBusiness_Services.LienSection_Layouts.rec_LiensDataParent L,
	  dataset(TopBusiness_Services.LienSection_Layouts.rec_ids_with_partydata_slimmed) R) := transform
		  // Keep track of "Active"(cannot do in bip2???) filings where the linkids company is a "Debtor".
      self.derog_count := if(L.role_party_type = TopBusiness_Services.Constants.DEBTOR,
														 1,0);
			self.ret_rec_count := l.ret_rec_count;
		  self.tot_rec_count := l.tot_rec_count;
			// Fill in the "party" child datasets.
    
			temp_debtors   := project(R(name_type=TopBusiness_Services.Constants.DEBTOR),
				                        TopBusiness_Services.LienSection_Layouts.rec_LiensDataChild_Party) ;
		  self.debtors   := choosen(temp_debtors, 
				                        iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_LIENS_PARTYS);
      // v--- Is this still needed???
			self.debtoroverflow     := count(temp_debtors) > iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_LIENS_PARTYS,
			temp_creditors := project(R(name_type=TopBusiness_Services.Constants.CREDITOR),
				                        TopBusiness_Services.LienSection_Layouts.rec_LiensDataChild_Party) ;
		  self.creditors := choosen(temp_creditors, 
				                        iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_LIENS_PARTYS);
      // v--- Is this still needed???
			self.creditoroverflow   := count(temp_creditors) > iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_LIENS_PARTYS,
		
			self              := L;
	end;

  ds_parent_child := denormalize(ds_main_keyrecs_rolled,
											 ds_party_keyrecs_masked,
		                               left.source_docid = right.tmsid,   
																 group,
		                             tf_denorm_parties(left,rows(right)));

  // Transforms to project the parent & child recs into the BIZ report JL detail record 
	// iesp layout fields.
  //
  // The transform to handle the "Parties" child dataset
	iesp.TopBusinessReport.t_TopBusinessJudgmentLienParty 
	  tf_child_party(TopBusiness_Services.LienSection_Layouts.rec_LiensDataChild_Party l) := transform
          self.CompanyName                 := l.cname,	
	     self.TaxId                       := l.tax_id,
	     self.SSN                         := l.ssn,
          self.Name.Full                   := ''; 
          self.Name.First                  := l.fname;
	     self.Name.Middle                 := l.mname;
	     self.Name.Last                   := l.lname;
	     self.Name.Suffix                 := l.name_suffix;
          self.Name.Prefix                 := l.title;
          self.Address.StreetName          := l.prim_name,
		self.Address.StreetNumber        := l.prim_range,
		self.Address.StreetPreDirection  := l.predir,
		self.Address.StreetPostDirection := l.postdir,
		self.Address.StreetSuffix        := l.addr_suffix,
		self.Address.UnitDesignation     := l.unit_desig,
		self.Address.UnitNumber          := l.sec_range,
		self.Address.City                := l.p_city_name,
		self.Address.State               := l.st,
		self.Address.Zip5                := l.zip,
		self.Address.Zip4                := l.zip4,
    self.Address.StreetAddress1      := '',
    self.Address.StreetAddress2      := '',
    self.Address.County              := '',
    self.Address.PostalCode          := '',
    self.Address.StateCityZip        := ''
	end;
	
  // The transform to handle the "Filings" child dataset
	iesp.TopBusinessReport.t_TopBusinessJudgmentLienFilings 	
	  tf_child_filings(TopBusiness_Services.LienSection_Layouts.rec_LiensDataChild_Filings l) := transform
    self.FilingDate       := iesp.ECL2ESP.toDate ((integer)l.filing_date),
		self.ReleaseDate      := iesp.ECL2ESP.toDate ((integer)l.Release_date),
    self.FilingNumber     := l.filing_number,	
    self.FilingType       := l.filing_type_desc,
		self.FilingStatus     := l.filing_status[1].filing_status_desc;  //only first occurrence???
    self.Agency           := l.agency,
    self.AgencyState      := l.agency_state,
    self.AgencyCounty     := l.agency_county,			
	end;

  // The transform to store data in the iesp report detail parent dataset fields
	TopBusiness_Services.LienSection_Layouts.rec_ids_plus_JL_Detail
	  tf_parent_detail(TopBusiness_Services.LienSection_Layouts.rec_LiensDataParent l) := transform
   //  addition
    self.case_link_id          := l.case_link_id;
    self.case_link_priority  := l.case_link_priority;
    //
    self.derogCount            := l.derog_count; 
    self.ret_rec_count        := l.ret_rec_count;
	  self.tot_rec_count     := l.tot_rec_count;
		//self.sort_order         := ???; 
		// ^--- map ??? to an unsigned1(?) sort_order value for sorting the filings for each 
		// bid and/or set a sort_date (---v) to put them in the desired order.    ???
    //self.sort_date	        := l.orig_filing_date(if not blank?) 
		//                           OR filing_date? OR latest filing_date? 
		//                           OR earliest_filng_date? 
    self.Debtors            := sort(project(l.debtors,tf_child_party(left)),
		                                if (Name.last <> '', 0, 1), CompanyName, Name.Last, Name.First, Name.Middle, Name.prefix, record),		
    self.Creditors          := sort(project(l.creditors,tf_child_party(left)),
		                                if (Name.last <> '', 0, 1),CompanyName, Name.Last, Name.First, Name.Middle, Name.Prefix, record),		
	  self.FilingJurisdiction := l.filing_jurisdiction,  
    self.Amount             := l.amount,
    self.OrigFilingNumber   := l.orig_filing_number,	
		ReleaseDate :=          PROJECT(l.filings,
		                        TRANSFORM({
														TopBusiness_Services.LienSection_Layouts.rec_LiensDataChild_Filings.release_date;},
														  SELF.Release_Date := if (LEFT.Release_date <> '', LEFT.Release_date,'');
															))(release_date <> '');   									
															// note this will only get the 1st release date so assuming 1st date in the 
															// list is the release date needed.
		self.ReleaseDate        := iesp.ECL2ESP.toDate( (INTEGER) (ReleaseDate[1].Release_date ));		                              															 															 															 															
    self.OrigFilingType     := l.orig_filing_type,
		self.OrigFilingDate     := iesp.ECL2ESP.toDate ((integer)l.orig_filing_date),
    self.Eviction           := if(l.eviction='N','NO',
		                              if(l.eviction='Y','YES',l.eviction));
    self.Filings            := choosen( project(l.filings,tf_child_filings(left)), 		                                            
		                                   iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_LIENS_FILINGS),
    // Output 1 row of dataset with source info.
		self.SourceDocs := dataset([transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
			self.BusinessIds := l, // to store all linkids
      self.IdType      := Constants.tmsid,
		  self.IdValue     := l.source_docid,
		  self.Section     := Constants.LienSectionName, //needed here???
		  self.Source      := l.source,
		  self := []) // null out other fields
		]);
		// addition for smart linx bus enhancements May 2019
       self.PartyType :=  MAP(l.role_party_type = 'C' => 'Creditor',
			                                 l.role_party_type = 'D' => 'Debtor',
							              '');			 
										
	  self := l; //to assign all linkids
	end;


  // Next project parent/child recs into biz report JL detail record layout plus ids
  ds_recs_rptdetail         := project(ds_parent_child,tf_parent_detail(left));
	
	ds_recs_rptdetail_deduped := dedup(ds_recs_rptdetail, record,all); //in bip1, why???

  // Sort/Group/Rollup all recs for a set of linkids.
  TopBusiness_Services.LienSection_Layouts.rec_ids_plus_JL_Rec tf_rollup_rptdetail(
	  TopBusiness_Services.LienSection_Layouts.rec_ids_plus_JL_Detail l,
	  dataset(TopBusiness_Services.LienSection_Layouts.rec_ids_plus_JL_Detail) allrows) := transform
      self.acctno := '';  // just null out here; it will be assigned in a join below
      self.DerogSummaryCntJL   := count(allrows(derogCount!= 0)); //???
			
      self.ReturnedRecordCount :=  sum(allrows,ret_rec_count);
			                                  
	    self.TotalRecordCount    := l.tot_rec_count; //???
			
			self.JudgmentsLiens := choosen(sort(project(allrows,
		                                             transform(iesp.TopBusinessReport.t_TopBusinessJudgmentLienDetail,
                                                           self.sourceDocs := choosen(left.sourceDocs, in_souceDocMaxCount),
				  										                             self := left)),
																				 // reverse chron (req 0680)
																         -OrigFilingDate.Year,
																				 -OrigFilingDate.Month,
																				 -OrigFilingDate.Day,
																				 -OrigFilingNumber, record), 
																    iesp.Constants.TopBusiness.MAX_COUNT_BIZRPT_LIENS_RECORDS);
			// Create a dataset with only 1 row of source info to be used for "ViewSources" feature.
		  self.SourceDocs := project(l.SourceDocs[1],
		                           transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
		                             //self.BusinessIds := l, // to store all linkids
																 self.BusinessIds.ultid  := l.ultid,
																 self.BusinessIds.orgid  := l.orgid,
																 self.BusinessIds.seleid := l.seleid,
		                             self.Section     := Constants.LienSectionName,
		                             self := [])), // null all other fields
      self := l; //to assign all linkids
	end;

  // Sort/group all recs for a set of linkids. 
  ds_all_rptdetail_grouped := group(sort(ds_recs_rptdetail_deduped,
		                                     #expand(BIPV2.IDmacros.mac_ListTop3Linkids())																				
																			  ),
                                    #expand(BIPV2.IDmacros.mac_ListTop3Linkids())
																   );
	
  ds_all_rptdetail_rolled := rollup(ds_all_rptdetail_grouped,
																    group,
																    tf_rollup_rptdetail(left,rows(left)));

  // Attach input acctnos back to the bdids
  ds_all_wacctno_joined := join(ds_in_ids,ds_all_rptdetail_rolled,
																	BIPV2.IDmacros.mac_JoinTop3Linkids(),
														    transform(TopBusiness_Services.LienSection_Layouts.rec_ids_plus_JL_Rec,
														      self.acctno   := left.acctno,
															    self          := right),
														    left outer); // 1 output rec for every left (in_data) rec

	// Roll up all recs for the acctno
	ds_final_results := rollup(group(sort(ds_all_wacctno_joined,acctno),
	                                 acctno),
	                           group,
		                         transform(TopBusiness_Services.LienSection_Layouts.rec_final,
			                                   self := left));

  // Uncomment for debugging
  // output(ds_in_ids,                      named('ds_in_ids'));
	//output(ds_in_ids_only,                 named('ds_in_unique_ids_only'));
  //output(ds_linkids_keyrecs,             named('ds_linkids_keyrecs'));
  // output(ds_linkids_keyrecs_slimmed,     named('ds_linkids_keyrecs_slimmed'));//
  // output(ds_linkids_keyrecs_deduped,     named('ds_linkids_keyrecs_deduped'));//

   // output(ds_main_keyrecs,                 named('ds_main_keyrecs'));
	 // output(outDStmp, named('outDStmp'));
	 // output(outDS, named('outDS'));

// output(ds_main_keyrecs_deduped1byRMSIDASWELL, named('ds_main_keyrecs_deduped1byRMSIDASWELL'));
  // output(ds_main_keyrecs_deduped1,        named('ds_main_keyrecs_deduped1')); //
	  // output(ds_main_keyrecs_deduped15,        named('ds_main_keyrecs_deduped15')); 
	// output(ds_ids_filings_tabled,           named('ds_ids_filings_tabled'));
	
	// output(ds_main_keyrecs_dd2_plus_counts, named('ds_main_keyrecs_dd2_plus_counts'));
	// output(ds_main_keyrecs_dd2_top100,      named('ds_main_keyrecs_dd2_top100'));
	 // output(ds_main_keyrecs_top100_perids,   named('ds_main_keyrecs_top100_perids'));
	
  // output(ds_main_keyrecs_srtd_grpd,       named('ds_main_keyrecs_srtd_grpd')); //
  // output(ds_main_keyrecs_rolled0,         named('ds_main_keyrecs_rolled0')); //
  // output(ds_main_keyrecs_rolled,          named('ds_main_keyrecs_rolled'));
 // output(ds_main_keyrecs_rolled_final,          named('ds_main_keyrecs_rolled_final')); //
  // output(ds_party_keyrecs,               named('ds_party_keyrecs')); //
  // output(ds_party_keyrecs_deduped,       named('ds_party_keyrecs_deduped')); //
  // output(ds_party_keyrecs_masked,        named('ds_party_keyrecs_masked'));//

   // output(ds_parent_child,                named('ds_parent_child'));//
  // output(ds_recs_rptdetail,              named('ds_recs_rptdetail'));	
  // output(ds_recs_rptdetail_deduped,      named('ds_recs_rptdetail_deduped'));//
	// output(ds_all_rptdetail_grouped,       named('ds_all_rptdetail_grouped'));
  // output(ds_all_rptdetail_rolled,        named('ds_all_rptdetail_rolled'));
  // output(ds_all_wacctno_joined,          named('ds_all_wacctno_joined'));

	return ds_final_results;

 END; // end of the fn_FullView function
	
END; //end of the module

/*  to test, in a builder window use this: 
IMPORT AutoStandardI;

	tempmod := module(AutoStandardI.DataRestrictionI.params)
		export boolean AllowAll := false;
		export boolean AllowDPPA := false;
		export boolean AllowGLB := false;
    //        position 3=0 to use EBR  -----v
		export string DataRestrictionMask := '000000000000000' : stored('DataRestrictionMask');
		export unsigned1 DPPAPurpose := 0 : stored('DPPAPurpose');
		export unsigned1 GLBPurpose := 0 : stored('GLBPurpose');
		export boolean ignoreFares := false;
		export boolean ignoreFidelity := false;
		export boolean includeMinors := false;
	end;

  // Report sections input options.  
	// Just 2 booleans for now: lnbranded and internal_testing
  ds_options := dataset([{false, false}
                     ],topbusiness_services.Layouts.rec_input_options);

// input dataset layout= acctno,DotID,EmpID,POWID,ProxID,OrgID,UltID  
Liens_sec := TopBusiness_Services.LienSection.fn_FullView(
             dataset([
 						          //{'test4p', 0, 0, 0, 102695539, 102695539, 102695539, 102695539} // 9 recs, 9 tmsids (2 tmsid have 2 rmsids), bug 124326
 						          //{'test5p', 0, 0, 0, 14771, 14771, 14771, 14771} // 149? recs, bug 124078 ** invalid linkid currently **
 						          //{'test6d', 0, 0, 0, 238, 238, 238, 238} // 11 recs, 11 tmsids
						          //{'test7d', 0, 0, 0, 9076, 9076, 9076, 9076} // bug 120330 lien with a person with an ssn *linkids changed no person with SSN*
						          //{'test9p', 0, 0, 0, 86030884, 86030884, 86030884, 86030884} // bug 133469, 12 linkids recs, 1 seleid with 2 proxids
					            //{'test10p1', 0, 0, 0, 0, 510 , 510, 510} // bug 132084/test case 1, 17 linkids recs, duped filing info on tmsid=CA00000219060681
					            //{'test10p2', 0, 0, 0, 0, 86192, 86192, 86192} // bug 132084/test case 2, 15 linkids recs, duped filing info on tmsid=HG08CV004103WIMILD1
                 ],topbusiness_services.Layouts.rec_input_ids)
						,ds_options[1]
					  ,tempmod
            );
output(Liens_sec);
// */
