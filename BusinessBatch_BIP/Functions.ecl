/*2017-08-21T16:06:34Z (dlingle)
C:\Users\lingledg\AppData\Roaming\HPCC Systems\eclide\dlingle\OSS_Dataland\BusinessBatch_BIP\Functions\2017-08-21T16_06_34Z.ecl
*/
IMPORT BIPV2,BIPV2_Build, BusinessBatch_BIP,
	Corp2,DCAV2,Gong,LiensV2,LN_PropertyV2,
       Suppress,TopBusiness_Services,UCCV2,FAA,Watercraft,VehicleV2,ut, 
			 SAM,Business_Risk,Business_Risk_BIP,Codes,bankruptcyV3, STD,
			 UCCV2_Services, AutoStandardI, MDR, diversity_certification,OSHAIR,LaborActions_WHD;
			 
// These are general functions which for the most part go against the *linkids* kfetch routines
// which return unique Id's for particular datasets.  These unique ID's can then be used to return
// payload data.  Generally the return layout structures form these functions are subsets of
// data which are used in the businessBatch_BIP rollupService roxie query.
//

EXPORT Functions(BusinessBatch_Bip.iParam.BatchParams inMod) :=
MODULE

shared  getFieldName2(string1 inChar)
                       := case(inChar,
												'F' => 'FAR_F',
												'R' => 'FAR_F',
												'S' => 'FAR_S',
												'O' => 'OKCTY',
												'D' => 'DAYTN',
												'');	

EXPORT getLINkidsAtProxidLevel( dataset(BIPV2.IDfunctions.rec_SearchInput) ds_Format2SearchInput,
	unsigned8 MaxResultsPerAcct,
	AutoStandardI.DataRestrictionI.params in_mod2   ) := FUNCTION
	
  ds_bestInfoProxIdNonRestricted := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(ds_Format2SearchInput).data2_;
	
	TopBusiness_Services.functions.MAC_IsRestricted(ds_bestInfoProxIdNonRestricted,
															 ds_bestInfoBatchProxIdRestricted, 															
	                             source, // field name
															 vl_id, // field name
															 in_mod2, 
															 false, //in_options.lnBranded, 															 
															 false, // //in_options.internal_testing, default to false for internal_testing
															 dt_first_seen // this is field name only no value
															 );
		 																							   
	   topResults := dedup(sort(ds_bestInfoBatchProxIdRestricted(proxid <> 0), acctno,ultid, orgid, seleid, proxid,
			                         -proxweight, -record_score, if (source <> MDR.sourceTools.src_Dunn_Bradstreet, 0,1),
		                           -dt_last_seen, 													               
		                           if ((unsigned)trim(company_phone,left,right) != 0
		                               and length(company_phone) = 10 and company_phone[1] <> '1' and company_phone[1] <> '0', 0, 1),						     
						                   if (company_fein <> '', 0, 1),
						                   if (company_phone <> '9999999999', 0, 1) ,record),
		                 acctno,ultid, orgid, seleid, proxid															
													);
   																											        																				
    // sort by -proxweight to bubble top score within a proxid group to the top again.
		tmpTopResultsScored := sort(topResults,acctno,-proxweight, -record_score, -dt_last_seen,
																if ((unsigned)trim(company_phone,left,right) != 0
																				and length(company_phone) = 10 and company_phone[1] <> '1' and company_phone[1] <> '0', 0, 1),																				   																				
															   if (company_fein <> '', 0, 1),	 if (company_phone <> '9999999999', 0, 1),                                   
													record);  
  
			tmpTopResultsScoredGrouped := PROJECT(ungroup(topn(group(tmpTopresultsScored,acctno),inmod.MaxResultsPerAcct,acctno)),
				                                      TRANSFORM(LEFT));																								     																							   																								
	RETURN (tmpTopResultsScoredGrouped);
END;

	// Phones 

  EXPORT GetPhones( DATASET(BusinessBatch_BIP.Layouts.LinkIdsWithAcctNo) dLinkIDsWithAcctNo,
                    DATASET(BIPV2.IDlayouts.l_xlink_ids)                 dLinkIds) :=
  FUNCTION
    dGongPhones := Gong.key_History_LinkIDs.kFetch(dLinkIds,
		     BIPV2.IDconstants.Fetch_Level_SELEID)(phone10 != '');
    
    // Dedup phones
    dGongPhonesDedup := DEDUP(DEDUP(SORT( dGongPhones,
                                          #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()),
                                          phone10,-(current_record_flag = 'Y'),-dt_last_seen,dt_first_seen,RECORD),
                                    #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()),phone10),
                              // Need max of 9 phones
                              #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()),
                              KEEP(BusinessBatch_BIP.Constants.Limits.MaxResultsPerSection));
    
    // Join by link ids to get the acctno
    BusinessBatch_BIP.Layouts.Phones tGongPhonesWithAcctNo(dLinkIDsWithAcctNo le,dGongPhonesDedup ri) :=
    TRANSFORM
      SELF.acctno := le.acctno;
      SELF.ultid  := le.ultid;
      SELF.orgid  := le.orgid;
      SELF.seleid := le.seleid;
      SELF.proxid := le.proxid;
      SELF        := ri;
    END;
    
    dGongPhonesWithAcctNo := JOIN(dLinkIDsWithAcctNo,dGongPhonesDedup,
                                  BIPV2.IDmacros.mac_JoinTop3Linkids(),
                                  tGongPhonesWithAcctNo(LEFT,RIGHT),
                                  LIMIT(0),KEEP(BusinessBatch_BIP.Constants.Limits.MaxResultsPerSection));
    
    // OUTPUT(dGongPhones,NAMED('dGongPhones'));
    // OUTPUT(dGongPhonesDedup,NAMED('dGongPhonesDedup'));
    
    RETURN dGongPhonesWithAcctNo;
  END;
		
  EXPORT GetCorps(DATASET(BusinessBatch_BIP.Layouts.LinkIdsWithAcctNo) dLinkIDsWithAcctNo,
                  DATASET(BIPV2.IDlayouts.l_xlink_ids)                 dLinkIds) :=
  FUNCTION
    dCorps := Corp2.Key_Linkids.Corp.kFetch(dLinkIds,BIPV2.IDconstants.Fetch_Level_SELEID);
    
    // Dedup corps
    dCorpsDedup := DEDUP(SORT(dCorps,#EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()),corp_key),
                          #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()),corp_key);
    
    // Join to the corp key and get all the corp recs for each corp_key
    dCorpsInfo := JOIN( dCorpsDedup,
                        Corp2.Keys().Corp.CorpKey.QA,
                        KEYED(LEFT.corp_key = RIGHT.corp_key),
                        TRANSFORM(RECORDOF(RIGHT),SELF := RIGHT),
                        LIMIT(BusinessBatch_BIP.Constants.Limits.MaxCorps,SKIP)
                      );
    
    // Sort/dedup all the corp recs fetched to keep the most recent "Current" record (or Historical, if no Current record exists) for each corp_key.
		  dCorpsInfoDedup := SORT(DEDUP(SORT(dCorpsInfo,
                                  #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()),	
																	corp_key,
																	record_type, // c and h so sorting by this put c (current) before h (historical)
																	-corp_process_date,
																	IF(corp_ln_name_type_desc = 'LEGAL',0,1), 
																	-corp_filing_date,																                                                                                                    																	
                                  -corp_status_desc,   
																	-corp_inc_date,
                                  -corp_forgn_date,
                                  -corp_status_date,
                                  -dt_vendor_last_reported
                                  ),
                             #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()),corp_key),
														 #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()),
														 -corp_filing_date);
    // some of this coding to normalize the value of corp_filing_desc which
		// ultimately becomes the corp_filing_type field in the output of this query
		// was taken from the BIPv2 comprehensive report incorporationSection
		// so that the value of corp_filing_type could be normalized across all of the different
		// states
	  dCorpsInfoNormalized := project(dCorpsInfoDedup, transform(RECORDOF(LEFT),
	  temp_company_org_structure_raw	:= corp2.Linking_filters.org_structure(
				                                         left.corp_orig_org_structure_desc,
				                                         left.corp_state_origin,
																								 left.corp_orig_bus_type_desc,
																								 left.corp_name_comment); 
		    
        temp_business_type := BIPV2.BL_Tables.CompanyOrgStructure(temp_company_org_structure_raw);
				
        corp_filing_desc := if(temp_business_type !='', 
											           temp_business_type, // use standardized value if not blank															
																 if(temp_company_org_structure_raw != '', 
																    temp_company_org_structure_raw,  //else use "raw" out of corp linking_filter
                                    if(left.corp_orig_org_structure_desc !='',  // else use 1st orig corp data value
																       left.corp_orig_org_structure_desc, 
                                       left.corp_orig_bus_type_desc   // else use 2nd orig corp data value
																)));
       self.corp_filing_desc := if (left.corp_filing_desc != '', left.corp_filing_desc, corp_filing_desc);																
       self := LEFT));
	  
    // Join by link ids to get the acctno
    BusinessBatch_BIP.Layouts.Corps tCorpsInfoWithAcctNo(dLinkIDsWithAcctNo le,  dCorpsInfoNormalized  ri) :=
    TRANSFORM
      SELF.acctno := le.acctno;
      SELF.ultid  := le.ultid;
      SELF.orgid  := le.orgid;
      SELF.seleid := le.seleid;
      SELF.proxid := le.proxid;
			SELF.Corp_filing_jurisdiction := '';
			// adding ri.corp_filing_date with this self := RI here.			
      SELF        := ri;
    END;
    
    dCorpsInfoWithAcctNo := JOIN(dLinkIDsWithAcctNo,dCorpsInfoNormalized ,
                                  BIPV2.IDmacros.mac_JoinTop3Linkids(),
                                  tCorpsInfoWithAcctNo(LEFT,RIGHT),
                                  LIMIT(0),KEEP(10));
    
     //OUTPUT(dCorps,NAMED('dCorps'));
    // OUTPUT(dCorpsDedup,NAMED('dCorpsDedup'));
    // OUTPUT(dCorpsInfo,NAMED('dCorpsInfo'));
    //OUTPUT(dCorpsInfoDedup,NAMED('dCorpsInfoDedup'));
    
    RETURN dCorpsInfoWithAcctNo;
  END;
	
	EXPORT GetBankruptcy(DATASET(BusinessBatch_BIP.Layouts.LinkIdsWithAcctNo) dLinkIDsWithAcctNo,
                       DATASET(BIPV2.IDlayouts.l_xlink_ids)                 dLinkIds) :=
	FUNCTION
	  // Fetch BK data but only pull debtor companies thus filter on 'D'			
		dBankruptcy := bankruptcyV3.key_bankruptcyV3_linkids.kfetch(dLinkIds,		
											BIPV2.IDconstants.Fetch_Level_SELEID)(name_type[1] = 'D'); 

    // dedup by tmsid to get individual BK's. keep the most recent date_filed ones on top.		
    dBankruptcyInfoDedup := dedup(sort(dBankruptcy, #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()),tmsid, -date_filed,record), 
		                                                #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()),tmsid)(date_filed <> '');
    				
     // Join by link ids to get the acctno
    BusinessBatch_BIP.Layouts.BankruptcyInfo tBankruptcyInfoWithAcctNo(dLinkIDsWithAcctNo le,
		                                                                   dBankruptcyInfoDedup ri) :=
    TRANSFORM
      // SELF.acctno := le.acctno;
      // SELF.ultid  := le.ultid;
      // SELF.orgid  := le.orgid;
      // SELF.seleid := le.seleid;
      // SELF.proxid := le.proxid;
			SELF.Total_bankruptcies := 0;
			SELF.bankruptcy_date_filed := (string)(ri.date_filed);
      SELF        := le;
    END;
    
    dBankruptcyInfoWithAcctNoTmp := JOIN(dLinkIDsWithAcctNo,dBankruptcyInfoDedup,
                                  BIPV2.IDmacros.mac_JoinTop3Linkids(),
                                  tBankruptcyInfoWithAcctNo(LEFT,RIGHT),
																	LEFT OUTER,
                                  LIMIT(0),KEEP(1000));	
    // add in a ecl cmd here to count # of TMSIds's by SELEID here
		// filter on the rows that have a BK only
		dCountsBankruptcyInfoWithAcctNo := TABLE(dBankruptcyInfoWithAcctNoTmp(bankruptcy_date_filed <> ''),
		    {acctno,seleid, UNSIGNED2 total_bankruptcies:= COUNT(GROUP);},acctno,seleid);
    // now join back this DS back to dBankruptcyInfoWithAcctNoTmp
		
		dBankruptcyInfoWithAcctNo := JOIN(dBankruptcyInfoWithAcctNoTmp, dCountsBankruptcyInfoWithAcctNo,
		                                        LEFT.ACCTNO = RIGHT.ACCTNO AND
																						LEFT.SELEID = RIGHT.SELEID,
																						TRANSFORM(RECORDOF(LEFT),
																						  SELF.Total_bankruptcies := RIGHT.Total_bankruptcies;
																							SELF := LEFT), LEFT OUTER);
    dBankruptcyInfoWithAcctnoSorted := sort(dBankruptcyInfoWithAcctNo,acctno,	
		                                      #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			    -bankruptcy_date_filed,record);
    // OUTPUT(dBankruptcyInfoDedup, named('dBankruptcyInfoDedup'));																							
    // OUTPUT(dBankruptcyInfoWithAcctNoTmp, named('dBankruptcyInfoWithAcctNoTmp'));
		 // OUTPUT(dCountsBankruptcyInfoWithAcctNo, named('dCountsBankruptcyInfoWithAcctNo'));
		// OUTPUT(dBankruptcyInfoWithAcctNo, named('dBankruptcyInfoWithAcctNo'));
		
		RETURN (dBankruptcyInfoWithAcctnoSorted);		
  END;
	
	//GetWatchList data
	
	EXPORT getWatchList(DATASET(BusinessBatch_BIP.Layouts.LinkIdsWithAcctNo) dLinkIDsWithAcctNo,
                  DATASET(BIPV2.IDlayouts.l_xlink_ids) dLinkIds,
									DATASET( BusinessBatch_BIP.Layouts.BestLayoutWithFeinVars) ds_BestInfoRecs) := FUNCTION
					
    
		STRING8 CurDate := (string8) STD.Date.today();
		
	  dWatchListLinkids := SAM.key_linkID.kfetch(dLinkIds,BIPV2.IDconstants.Fetch_Level_SELEID);				
		 
		   BusinessBatch_BIP.Layouts.watchListInfo  tWatchListInfoWithAcctNo(dLinkIDsWithAcctNo le,
																																				 dWatchListLinkids  ri) :=
    TRANSFORM
      SELF.acctno := le.acctno;
      SELF.ultid  := le.ultid;
      SELF.orgid  := le.orgid;
      SELF.seleid := le.seleid;
      SELF.proxid := le.proxid;
			SELF.Gov_debarred := if ( Std.Str.ToUpperCase(ri.terminationDate) = 'INDEFINITE'
			                         OR
															 ((UNSIGNED4) (Std.Str.ToUpperCase(ri.terminationdate))) >
															              (UNSIGNED4)(CURdate)
															 ,'Yes', 'No');
     	
			
      SELF.gov_debarred_start_date := ut.date_YYYYMMDDtoDateSlashed(ri.activedate);
		  SELF.gov_debarred_exp_date   := ut.date_YYYYMMDDtoDateSlashed(ri.terminationdate);
																
			SELF.Ofac_auth_rep := '';
		  SELF.Ofac_business := '';
      SELF := [];
    END;
		
		  dWatchListInfoDebarredWithAcctNo := JOIN(dLinkIDsWithAcctNo,dWatchListLinkids,
                                  BIPV2.IDmacros.mac_JoinTop3Linkids(),
                                  tWatchListInfoWithAcctNo(LEFT,RIGHT),
																	LEFT OUTER,
                                  LIMIT(0),KEEP(1));												
		
		// ****************** OFAC watchlist stuff ******************
		// some calls in section borrowed from : Business_Risk_BIP.getWatchlists
		//
		// 
		// now add seq # to best recs so that I can join back later to obtain acctno and linkids
		//
		bestInfoRecsSeqenced := PROJECT(ds_bestInfoRecs, TRANSFORM({RECORDOF(LEFT);UNSIGNED6 seq;},
		                             SELF.seq := COUNTER;
																 SELF := LEFT));
		watchListInputPrep  := PROJECT(bestInfoRecsSeqenced, 
		                    // 
		           transform(Business_Risk.Layout_Output,
							            // ^^^^^^^^^^^^^^^^^^^^^^^^
													// yes we populate an output layout for the input layout
													//
     SELF.seq := LEFT.seq; 
     SELF.company_name := LEFT.best_company_name;
		 SELF.Alt_Company_Name := LEFT.best_company_name;		 
		 self.country := 'US';
		 SELF := []
		 ));
		 
		 
	watchlistInput := GROUP(SORT(watchlistInputPrep, Seq), Seq);
  
	// OBTAINED FROM   Business_Risk_BIP.getWatchlists
	OFAC_Only := TRUE; // doing this basically only uses this (source='Office of Foreign Asset Control');
	                  // in Business_Risk.getWatchLists2 call below
	Include_OFAC := TRUE;
	Include_Additional_Watchlists := FALSE;
	From_BIID := FALSE; 
	 
  dOFACWatchList := Business_Risk.getWatchLists2(watchlistInput, OFAC_Only, From_BIID, 
        Business_Risk_BIP.Constants.Default_OFAC_Version,
				 Include_OFAC, Include_Additional_Watchlists,         
				BusinessBatch_BIP.Constants.Defaults.OFAC_ONLY_GlobalWatchListThreshold);
				//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
				// this is a defined set value for this query only ...since the default value
				// used previously was not stringent enough and got too many false hits of 'true' (i.e. yes)
				// for the OFAC_BUSINESS  field for this query.
		 		 		
  //
  // join by seq to get acctno and linkids together with watchList info
	//
		
		dOFACWatchListwAcctno := JOIN(bestInfoRecsSeqenced,dOFACWatchList,
		                                LEFT.seq = RIGHT.SEQ,
																		TRANSFORM(BusinessBatch_BIP.Layouts.WatchListInfo,
																		SELF.Acctno := LEFT.acctno;
																		SELF.ULTID := LEFT.ULTID;
																		SELF.ORGID := LEFT.ORGID;
																		SELF.SELEID := LEFT.SELEID;
																		SELF.OFAC_BUSINESS := IF(RIGHT.Watchlist_Cmpy <> '', 'Yes','No');
																		SELF.OFAC_AUTH_REP := IF(RIGHT.Watchlist_FNAME <> '' OR
																		                         RIGHT.Watchlist_LNAME <> '', 'Yes','No');
																		SELF := []
																		)																													
																		,LIMIT(0),KEEP(1));
     // now join debarred list with OFAC list
	  dWatchListInfoWithAcctno := JOIN(dWatchListInfoDebarredWithAcctNo,dOFACWatchListwAcctno,
		                                LEFT.ACCTNO = RIGHT.ACCTNO AND
																		 BIPV2.IDmacros.mac_JoinTop3Linkids(),
																		 TRANSFORM(BusinessBatch_BIP.Layouts.WatchListInfo,
																		 SELF.OFAC_BUSINESS := RIGHT.OFAC_BUSINESS;
																		 SELF.OFAC_AUTH_REP := RIGHT.OFAC_AUTH_REP;
																		 SELF := LEFT),
																		 LEFT OUTER);		
    // output(watchlistInput, named('watchlistInput'));																		 
    // output(bestInfoRecsSeqenced, named('bestInfoRecsSeqenced'));
		// output(dOFACWatchList, named('dOFACWatchList'));
		
		RETURN dWatchListInfoWithAcctNo;
		
	END;
	
	EXPORT getUCCLinkids(DATASET(BIPV2.IDlayouts.l_xlink_ids) dLinkIds) := FUNCTION
									
    // Fetch UCCs
    dUCCs := UCCV2.Key_LinkIds.KeyFetch(dLinkIds,BIPV2.IDconstants.Fetch_Level_SELEID
		,,BusinessBatch_BIP.Constants.LIMITS.MAXUccs);
		RETURN(dUCCs);		
	END;
	
	EXPORT getUCCs(DATASET(BusinessBatch_BIP.Layouts.LinkIdsWithAcctNo) dLinkIDsWithAcctNo,
                  DATASET(BIPV2.IDlayouts.l_xlink_ids) dLinkIds) := 
	FUNCTION
     uccLinkIds := getUCCLinkids(dLinkIds);	
		 
		 set_terminated_types := ['LAPSED','L','RELEASE','EXPUNGED','DELETED',
	                         'TERMINATED','TERMINATION','UCC3 TERMINATION'];
					 
					// FILL IN rest here with the getting necessary property fields
					// setup for later join into main DS
 
       dUccInfoDedup := DEDUP(SORT(uccLinkIds(party_type != 'A'), #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			     tmsid),
		                                     #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			     tmsid);
   																					 
   BusinessBatch_BIP.Layouts.UccInfoExtra GetUccMainInfo(DUccInfoDedup le,
	                                                    RECORDOF(UCCV2.Key_Rmsid_Main()) ri) :=
   TRANSFORM
	   
	    // orig_filing_number := IF(ri.orig_filing_number !='',
			                              // ri.orig_filing_number,ri.filing_number);
			orig_filing_date   := IF(ri.orig_filing_date !='',
			                              ri.orig_filing_date,ri.filing_date);
			// orig_filing_type   := IF(ri.orig_filing_type !='',
			                              // ri.orig_filing_type,ri.filing_type_desc);	
      temp_status_type           := Std.Str.ToUpperCase(ri.status_type);
			temp_filing_type           := Std.Str.ToUpperCase(ri.filing_type);
			
			// *
			// in BIP report Terminated is the set defined here.
			// in Batch BIP rollup business query 
			// 'released' is same as 'termintated'..thus the set defined above.
			//
			// self.status           := if(temp_status_type in set_terminated_types or
						                           // temp_filing_type in set_terminated_types,
																			 // 'T','A');																																				 
			// *
			self.filing_type           := temp_filing_type,
      SELF.ucc_date_filed := orig_filing_date; // TODO still have to find most recently filed lien													
			SELF.Total_ucc := 0;
			SELF.Total_ucc_released := 0;
			SELF.UCCIsReleased := temp_status_type in set_terminated_types or
						                           temp_filing_type in set_terminated_types;
																			 				
      SELF := le;		
			SELF := ri;
			SELF := []; // set acctno later.
	 END;																					 																					 

    DUccMainRecs := JOIN(DUccInfoDedup,UCCV2.Key_Rmsid_Main(),
                            KEYED(LEFT.tmsid = RIGHT.tmsid),
                                  // AND LEFT.rmsid  = RIGHT.rmsid),
																	GetUccMainInfo(LEFT,RIGHT),
																	LEFT OUTER,
																	limit(10000,skip));
																	 //LIMIT(0),KEEP(1));	
    // code taken from bip uccsection
    DUccMainRecsSlimmed := DEDUP(SORT(DUccMainRecs,
																            #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()),
	                                          tmsid, filing_number, filing_type, filing_date, 
																					 -process_date, RECORD),
																       #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			 tmsid, filing_number, filing_type, filing_date);
																			 
   ////***
	 // Next fix the rmsid if needed on D&B UCCs. 
  ds_uccmain_keyrecs_deduped2 := 
	   PROJECT(DuccMainRecsSlimmed,
	           TRANSFORM(BusinessBatch_BIP.Layouts.uccInfoExtra,
			         SELF.rmsid := UCCV2_Services.fn_remove_DNB_rmsid_seq(LEFT.rmsid,LEFT.tmsid);
							 SELF := LEFT;							
							 ));
															
  // Temporary record layout to hold both main UCC data and party UCC data.	
	rec_ucc_main_party := record		
		BusinessBatch_BIP.Layouts.uccInfoExtra;
		BIPV2.IDlayouts.l_header_ids party_linkids;
		UCCV2.Layout_UCC_Common.Party;
	end;
		
	// Next join the kept main keyrecs (with role counts) to the ucc party key to
	// get all the ucc "party" data for the tmsids & rmsids involved.  We are retrieving
	// the party data here (rather than later on) because we need DIDs & SSNs to do tmsid 
	// suppression before the roles(debtor vs. secured) are tallied.
	ds_uccparty_keyrecs_main_plus_party := JOIN(ds_uccmain_keyrecs_deduped2, UCCV2.Key_Rmsid_Party(),
																						KEYED(LEFT.tmsid = RIGHT.tmsid AND
																									// v--- to get the correct parties for the sub-filings (rmsids)
																									LEFT.rmsid = RIGHT.rmsid ),
																					TRANSFORM(rec_ucc_main_party,
																						// Since linkids for the party were added to the party key layout, 
																						// fill in the "report-by" linkids from the left dataset. 																						
																						SELF.ultid  := LEFT.ultid,
																						SELF.orgid  := LEFT.orgid,
																						SELF.seleid := LEFT.seleid,
																						SELF.proxid := LEFT.proxid,
																						SELF.powid  := LEFT.powid,
																						SELF.empid  := LEFT.empid,
																						SELF.dotid  := LEFT.dotid,
																						// v--- pull off the party key fields we want (which have
																						//   the same name on the temp layout as on the party key)
																						SELF.party_linkids := RIGHT, //???
																						SELF := LEFT, 
																						SELF := RIGHT, // to preserve other kept linkids/main key fields
																					),
																					LEFT OUTER, //in case main recs have no party key match																					
																					LIMIT(BusinessBatch_BIP.Constants.Limits.MaxUccs,SKIP) 
																				 );
	
	ds_uccrecs_in := PROJECT(ds_uccparty_keyrecs_main_plus_party, 
											TRANSFORM(uccv2_services.layout_ucc_party_raw, 
														SELF := LEFT, 
														SELF := []));
																						
  // Function to suppress records by tmsid.  This function will not actually suppress by a given 
	// tmsid.  (tmsid is not one of the document types currently in the suppression key.)  It will 
	// look for look for dids and ssn in the suppression key, then suppress the tmsids associated
	// with the dids and ssn found in the suppression key.
	ds_uccrecs_tmsids_wout_pulled := UCCv2_Services.fn_pullIDs(ds_uccrecs_in, '');

	ds_uccrecs_w_tmsids_pulled := JOIN(ds_uccrecs_tmsids_wout_pulled, ds_uccmain_keyrecs_deduped2,
																		LEFT.tmsid = RIGHT.tmsid, 
																		TRANSFORM(BusinessBatch_BIP.Layouts.UccInfoExtraSlim, 																						
																			 SELF := RIGHT),
																     LEFT OUTER);
   // ***																	 
		
    DUCCMainRecsCounted := 	ds_uccrecs_w_tmsids_pulled; //DUccMainRecsSlimmed; 														 
																					   																				     				
     // Join by link ids to get the acctno
    BusinessBatch_BIP.Layouts.UccInfoExtraSlim tUCCInfoWithAcctNo(dLinkIDsWithAcctNo le,
		                                                          DUccMainRecsCounted ri) :=
    TRANSFORM
      SELF.acctno := le.acctno;      
      SELF        := ri;
    END;
    
    dUccInfoWithAcctNoTmp := JOIN(dLinkIDsWithAcctNo,DUccMainRecsCounted,
                                  BIPV2.IDmacros.mac_JoinTop3Linkids(),
                                  tUccInfoWithAcctNo(LEFT,RIGHT),
																	LEFT OUTER,
                                  LIMIT(0),KEEP(1000));	
																	
    // ecl cmd here to count # of SELEID for each acctno.
		
		dCountsUCCInfoWithAcctNo1 := TABLE(dUccInfoWithAcctNoTmp,
		    {acctno,seleid, UNSIGNED2 total_UCC:= COUNT(GROUP);},acctno,seleid);
				
    dCountsUCCInfoWithAcctNo2 := TABLE(dUccInfoWithAcctNoTmp(UCCIsReleased = TRUE),
		    {acctno,seleid, UNSIGNED2 total_UCC_released := COUNT(GROUP);},acctno,seleid);				
    // now join back this DS back to dUCCInfoWithAcctNoTmp
		
		dUccWithAcctNo := JOIN(dUCCInfoWithAcctNoTmp, dCountsUccInfoWithAcctNo1,
		                                        LEFT.ACCTNO = RIGHT.ACCTNO AND
																						LEFT.SELEID = RIGHT.SELEID,
																						TRANSFORM(RECORDOF(LEFT),
																						  SELF.Total_UCC := RIGHT.Total_UCC;																							
																							SELF := LEFT), LEFT OUTER);																							
    dUccWithAcctNoUCCSReleased := JOIN(dUccWithAcctNo, dCountsUccInfoWithAcctNo2,
		                                        LEFT.ACCTNO = RIGHT.ACCTNO AND
																						LEFT.SELEID = RIGHT.SELEID,
																						TRANSFORM(RECORDOF(LEFT),																						 
																							SELF.total_UCC_Released := RIGHT.Total_UCC_Released;
																							SELF := LEFT), LEFT OUTER);			
    dUccWithAcctNoFinal := SORT(PROJECT(dUccWithAcctNoUCCSReleased,
		                           TRANSFORM(BusinessBatch_BIP.Layouts.UccInfoLayout,
															         SELF := LEFT)), acctno,#EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			    -ucc_date_filed,record);
																			 
     // OUTPUT(dUCCInfoDedup, named('dUCCInfoDedup'));																							
		 // OUTPUT(DUccMainRecs, named('DUccMainRecs'));
		 // OUTPUT(DUccMainRecsSlimmed, named('DUccMainRecsSlimmed'));
		 // output(ds_uccmain_keyrecs_deduped2, named('ds_uccmain_keyrecs_deduped2'));
		 // output(ds_uccparty_keyrecs_main_plus_party, named('ds_uccparty_keyrecs_main_plus_party'));
		 
    // OUTPUT(dUCCInfoWithAcctNoTmp, named('dUCCInfoWithAcctNoTmp'));

		// OUTPUT(dCountsUCCInfoWithAcctNo1, named('dCountsUCCInfoWithAcctNo1'));
		// OUTPUT(dCountsUCCInfoWithAcctNo2, named('dCountsUCCInfoWithAcctNo2'));
		// OUTPUT(dUCCWithAcctNo, named('dUCCInfoWithAcctNo'));
		// OUTPUT(dUccWithAcctNoUCCSReleased, named('dUccWithAcctNoUCCSReleased'));
		RETURN (dUCCWithAcctNoFinal);
    											   
	END;
	
	EXPORT getLiensLinkids(DATASET(BIPV2.IDlayouts.l_xlink_ids) dLinkIds) :=
	FUNCTION
      dLiens := LiensV2.Key_Linkids.KeyFetch(dLinkIds,BIPV2.IDconstants.Fetch_Level_SELEID);											 												 
   RETURN(dliens);
  END;												 
	
	EXPORT GetLiens(DATASET(BusinessBatch_BIP.Layouts.LinkIdsWithAcctNo) dLinkIDsWithAcctNo,
                  DATASET(BIPV2.IDlayouts.l_xlink_ids)                 dLinkIds) := 
	FUNCTION	
	              // Filter by Credit or Debtor liens (same as BIP report did).
								// "name_type" is a D(Debtor) or C(Creditor),
								dLiens := getLiensLinkIds(dLinkIds)(name_type[1] = 'C' OR name_type[1] = 'D');	
            																														
							 // dedup by tmsid to get individual Liens.	
							 // SO THIS HAS linkids and tmsID, RMSID               
    dLienInfoDedup := DEDUP(SORT(dLiens, #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			     tmsid,rmsid), 
		                                     #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			     tmsid,rmsid);
																					 
   BusinessBatch_BIP.Layouts.LienInfoExtra GetLienMainInfo(DLienInfoDedup le,
	                                                    RECORDOF(LiensV2.Key_liens_main_ID) ri) :=
   TRANSFORM
	    // orig_filing_number := IF(ri.orig_filing_number !='',
			                              // ri.orig_filing_number,ri.filing_number);
			orig_filing_date   := IF(ri.orig_filing_date !='',
			                              ri.orig_filing_date,ri.filing_date);
			// orig_filing_type   := IF(ri.orig_filing_type !='',
			                              // ri.orig_filing_type,ri.filing_type_desc);		     																		
      SELF.judgment_liens_date_filed := orig_filing_date; 											
			SELF.total_judgments_and_liens := 0;						
			// TOTAL number of j and L's both satisfied and released.
			SELF.LienRowJudgmentIsSatisfied := TRIM(ri.filing_status[1].filing_status_desc,left,right) = 'RELEASED' OR
			                                      TRIM(ri.filing_status[1].filing_status_desc,left,right) = 'SATISFIED';
      SELF.Judgments_liens_satisfied  := 0;
			
      SELF := le;		
			SELF := []; // set acctno later.
	 END;						

    DLiensMainRecs := JOIN(DLienInfoDedup,LiensV2.Key_liens_main_ID(),
                            KEYED(LEFT.tmsid = RIGHT.tmsid AND
                                  LEFT.rmsid  = RIGHT.rmsid),
																	GetLienMainInfo(LEFT,RIGHT),
																	LEFT OUTER,
																	 LIMIT(0),KEEP(1));																		 																	 																					   																				 
    				
     // Join by link ids to get the acctno
    BusinessBatch_BIP.Layouts.LienInfoExtra tLienInfoWithAcctNo(dLinkIDsWithAcctNo le,
		                                                            DLiensMainRecs ri) :=
    TRANSFORM
      SELF.acctno := le.acctno;      
      SELF        := ri;
    END;
    
    dLienInfoWithAcctNoTmp := JOIN(dLinkIDsWithAcctNo,DLiensMainRecs,
                                  BIPV2.IDmacros.mac_JoinTop3Linkids(),
                                  tLienInfoWithAcctNo(LEFT,RIGHT),
																	LEFT OUTER,
                                  LIMIT(0),KEEP(1000));	
    // a ecl cmd here to count # of TMSIds's by SELEID here		
		dCountsLienInfoWithAcctNo := TABLE(dLienInfoWithAcctNoTmp,
		    {acctno,seleid, UNSIGNED2 total_judgments_and_liens := COUNT(GROUP);},acctno, seleid);
				
    dCountsLienInfoSatisfiedWithAcctNo := TABLE(dLienInfoWithAcctnoTmp(LienRowJudgmentIsSatisfied = TRUE),
		     {acctno,seleid, UNSIGNED2 Judgments_liens_satisfied := COUNT(GROUP);},acctno, seleid);
		  
    // now join back both of these DS's to dLienInfoWithAcctNoTmp
		
		dLienInfoWithAcctNo1 := JOIN(dLienInfoWithAcctNoTmp, dCountsLienInfoWithAcctNo,
		                                        LEFT.ACCTNO = RIGHT.ACCTNO AND
																						LEFT.SELEID = RIGHT.SELEID,
																						TRANSFORM(RECORDOF(LEFT),
																						  SELF.total_judgments_and_liens := RIGHT.total_judgments_and_liens;
																							SELF := LEFT), LEFT OUTER);
    dLienInfoWithAcctNo := JOIN(dLienInfoWithAcctNo1, dCountsLienInfoSatisfiedWithAcctNo,
		                                        LEFT.ACCTNO = RIGHT.ACCTNO AND
																						LEFT.SELEID = RIGHT.SELEID,
																						TRANSFORM(RECORDOF(LEFT),
																						  SELF.Judgments_liens_satisfied  := RIGHT.Judgments_liens_satisfied;
																							SELF := LEFT), LEFT OUTER);  				
   dLienInfoWithAcctNoFinal := sort(PROJECT(dLienInfoWithAcctNo, 
	                                          TRANSFORM(BusinessBatch_BIP.Layouts.LienInfo,
																						       SELF := LEFT)),acctno,#EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			    -Judgment_Liens_date_filed,record);
		
    // OUTPUT(dLienInfoDedup, named('dLienInfoDedup'));																							
    // OUTPUT(dLienInfoWithAcctNoTmp, named('dLienInfoWithAcctNoTmp'));
		// OUTPUT(dCountsLienInfoWithAcctNo, named('dCountsLienInfoWithAcctNo'));
		// OUTPUT(dCountsLienInfoSatisfiedWithAcctNo, named('dCountsLienInfoSatisfiedWithAcctNo'));
		// OUTPUT(dLienInfoWithAcctNo1, named('dLienInfoWithAcctNo1'));
		// OUTPUT(dLienInfoWithAcctNo, named('dLienInfoWithAcctNo'));
		
		RETURN (dLienInfoWithAcctNoFinal);
	
	END;
	
	EXPORT getPropertyLinkids(DATASET(BIPV2.IDlayouts.l_xlink_ids) dLinkIds) :=
	FUNCTION
	  
		 dProperty := LN_PropertyV2.Key_LinkIds.kFetch(dLinkIds,BIPV2.IDconstants.Fetch_Level_SELEID,
		            ,,BusinessBatch_BIP.Constants.LIMITS.MAXProps);
								
     RETURN(dProperty);
  END;		 
	// used to a date within property data so that we can sort and get a proper count of # of properties owned by a
	// particular company.
	EXPORT fn_getSortbyDate(STRING Assessed_Value_Year, STRING Tax_Year, STRING Market_Value_Year, 
	                        STRING Certification_Date, STRING Tape_Cut_Date, STRING Recording_Date, 
													STRING Prior_Recording_Date, STRING Sale_Date) := 
		FUNCTION
			sortby_date :=
				MAP( // We want the assessed value, so favor assessed_value_year above all others.
					Assessed_Value_Year != ''  => Assessed_Value_Year+'0000',
					Tax_Year != ''             => Tax_Year+'0000',
					Market_Value_Year != ''    => Market_Value_Year+'0000',
					Certification_Date != ''   => Certification_Date+'00',
					Tape_Cut_Date != ''        => Tape_Cut_Date,
					Recording_Date != ''       => Recording_Date,
					Prior_Recording_Date != '' => Prior_Recording_Date,
					Sale_Date
				);
			RETURN sortby_date;
		END;
		
	EXPORT getProperty(DATASET(BusinessBatch_BIP.Layouts.LinkIdsWithAcctNo) dLinkIDsWithAcctNo,
                     DATASET(BIPV2.IDlayouts.l_xlink_ids)                 dLinkIds) :=
	FUNCTION
								// call to get the ln_fares_id (unique ID for property).	
		dPropertyLinkids := getPropertyLinkids(dLinkIds)(source_code[1] IN [BusinessBatch_BIP.Constants.Property.Party.Borrower,
                                                         BusinessBatch_BIP.Constants.Property.Party.Owner]);
		

   // get all property recs and then eventually roll them up based on LN-fares-Id
	 // then do a rollup based on linkid/acctno combo
	 // and count the # of recs for each set of linkids that are common
	 // do this for both accessor and for deeds recs.
											 
         				  			 			  							    									
		dPropertyAssessmentRaw := JOIN(dPropertyLinkids, LN_PropertyV2.key_assessor_fid(),
					               LEFT.ln_fares_id = RIGHT.ln_fares_id,
												 TRANSFORM(BusinessBatch_BIP.Layouts.PropertyInfoExtra,
												   
													    // filter string into just digits to get rid of 'SF' and then to INTeger to get rid of 0's
															// and then back to string.								std.str.filter					
												   SELF.sProperty_owned_size := (STRING)(INTEGER)std.str.filter(RIGHT.Land_square_footage, '0123456789');
													 SELF.SortByDate := fn_getSortbyDate(RIGHT.Assessed_Value_Year, RIGHT.Tax_Year,
													                              RIGHT.Market_Value_Year, RIGHT.Certification_Date, 
																												RIGHT.Tape_Cut_Date, RIGHT.Recording_Date, 
																												RIGHT.Prior_Recording_Date, RIGHT.Sale_Date),
                           //SELF.apnt_or_pin_number := (STRING)(INTEGER)StringLib.StringFilter(RIGHT.apna_or_pin_number,'0123456789');													 
													 SELF.apnt_or_pin_number := RIGHT.apna_or_pin_number;
													 //field_nametwo := getFieldName2(RIGHT.ln_fares_id[1]);
													 
			 			  							
														
														// May use this in future thus why I left it in here.
														// Input_residential := choosen(project(Codes.Key_Codes_V3(file_name='FARES_2580'
																// and field_name='LAND_USE' and field_name2 = field_nametwo and code = RIGHT.standardized_land_use_code),
																// transform({string30 s;},self.s := left.long_desc;)),1)[1].s;
                            // ....to see if 'Residential' or 'SFR' (single family residence' 
														//  string is in it if so flag it as 'Y'																								
														
													  // self.Input_residential := if ((stringlib.stringfind('RESIDENTIAL',Input_residential,1)  > 0) OR
														                              // (stringlib.stringfind('SFR',        Input_residential,1)  > 0), 
																													// 'Y',
																													// 'N');													                        																								
                           SELF.property_owned := 1;																													
													 SELF := LEFT;
													 SELF := RIGHT;
													 SELF := [];
													 ), limit(ut.limits.DEFAULT,skip));
    
		dAssessments_filtered := dPropertyAssessmentRaw(sortbydate != ''); //and sProperty_owned_size != '' );
  
	  // rollup and keep as much as the property size populated field values as we can
	  dAssessments_Rolled_wCount := ROLLUP(SORT(dAssessments_filtered, #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()),
		                                  apnt_or_pin_number,
																			-((INTEGER)sortbydate)),
		                                  BIPV2.IDmacros.mac_JoinTop3Linkids() AND 
																			 left.APNT_OR_PIN_NUMBER = RIGHT.APNT_OR_PIN_NUMBER,
																		 TRANSFORM(BusinessBatch_BIP.Layouts.PropertyInfoExtra,
																		
																		 SELF.sProperty_owned_size := IF( TRIM(LEFT.sProperty_owned_size,left,right) != '', 
                                           LEFT.sProperty_owned_size, RIGHT.sProperty_owned_size);  
																		 //SELF.property_owned := 1;
																		 SELF := LEFT));
    // now rollup and count at the same time per seleid/org/ult combo as well as grab biggest property size
    dAssessments_rolled_final := ROLLUP(SORT(dAssessments_Rolled_wCount, #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids())		                                   
																				),
																				BIPV2.IDmacros.mac_JoinTop3Linkids(),
																				TRANSFORM(BusinessBatch_BIP.Layouts.PropertyInfoExtra,
																				SELF.property_owned := LEFT.property_owned + RIGHT.property_owned;
																				SELF.sProperty_owned_size := 
																				   (STRING) (MAX((INTEGER) LEFT.sProperty_owned_size, (INTEGER) RIGHT.sProperty_owned_size));
																			  SELF := LEFT));																		
		//
		// INput_total_businesses
		//
		// Get Property Deeds
	dDeeds_raw := JOIN(dPropertyLinkids, LN_PropertyV2.key_deed_fid(),																	     
			KEYED(LEFT.ln_fares_id = RIGHT.ln_fares_id),// AND
			//RIGHT.Buyer_Or_Borrower_Ind = 'O', 
			TRANSFORM(BusinessBatch_BIP.Layouts.PropertyInfoExtra,
			 
				SELF.sortbydate    := fn_getSortbyDate(RIGHT.Contract_Date, RIGHT.Recording_Date, RIGHT.Process_Date, '', '', '', '', '');
				// Filter out the 'SF' at the end of each record, then convert blanks to INTEGER so that they become 0's, then back to the STRING layout
				SELF.sProperty_owned_size	:= (STRING)(INTEGER)std.str.filter(RIGHT.land_lot_size, '0123456789'); 
				//SELF.apnt_or_pin_number := (STRING)(INTEGER)StringLib.StringFilter(RIGHT.apnt_or_pin_number,'0123456789');
				 SELF.apnt_or_pin_number := RIGHT.apnt_or_pin_number;
				SELF.Buyer_Or_Borrower_Ind := RIGHT.Buyer_Or_Borrower_Ind;
				SELF                := LEFT;
				SELF := [];
			), KEEP(1), ATMOST(100));
 
  //dDeeds_raw_owner := dDeeds_raw(Buyer_Or_Borrower_Ind = 'O');
	dDeeds_filtered := dDeeds_raw(sortbydate != '');
	
	dDeeds_sorted :=	SORT(dDeeds_filtered,
	 #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()),
	 apnt_or_pin_number,
			// seq,
			// ln_fares_id,
			//unique_prop_id,
			-((INTEGER)sortbydate)
			//-((INTEGER)(vendor_source_flag IN ['F','S'])) // 'F','S' are FARES records; 'D','O' are FIDELITY records
		);
				  			
	dDeeds_most_recent_owner := ROLLUP(sort(dDeeds_sorted(Buyer_Or_Borrower_Ind = 'O'), ln_fares_id),
	                                   LEFT.Ln_fares_id = RIGHT.ln_fares_id,
													TRANSFORM(RECORDOF(LEFT),
																SELF.sProperty_owned_size := IF( trim(LEFT.sProperty_owned_size,left,right) != '', 
				                         LEFT.sProperty_owned_size, RIGHT.sProperty_owned_size);       															
				SELF := LEFT));
										
	dDeeds_inflated_owner := PROJECT(dDeeds_most_recent_owner,
			TRANSFORM(BusinessBatch_BIP.Layouts.PropertyInfoExtra,
				SELF.Property_owned            := 1;				
				SELF := LEFT; 
				SELF := []));
				
	dDeeds_unique_prop_owner := ROLLUP(SORT(dDeeds_inflated_owner , 
	                      #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()), APNT_or_PIN_Number), 												
						BIPV2.IDmacros.mac_JoinTop3Linkids() AND LEFT.APNT_or_PIN_Number = RIGHT.APNT_or_PIN_Number,
			TRANSFORM(BusinessBatch_BIP.Layouts.PropertyInfoExtra,				
				SELF.sProperty_owned_size := (STRING) (MAX((INTEGER) LEFT.sProperty_owned_size, (INTEGER) RIGHT.sProperty_owned_size));
				SELF.Property_owned := LEFT.Property_owned;
				SELF := LEFT));
		
	dDeeds_Owner_rolled_wCount :=	ROLLUP(SORT(dDeeds_unique_prop_owner, #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids())), 
	                                BIPV2.IDmacros.mac_JoinTop3Linkids(), 
			TRANSFORM(BusinessBatch_BIP.Layouts.PropertyInfoExtra,			
				SELF.Property_owned := LEFT.Property_owned + RIGHT.Property_owned;				
				SELF := LEFT));
													 
    // join by linkids here to add in deeds to accessor recs
    dPropertyOwnedSize := JOIN(dAssessments_rolled_final ,dDeeds_Owner_rolled_wCount, 													 
		                               BIPV2.IDmacros.mac_JoinTop3Linkids(),
																	TRANSFORM(BusinessBatch_BIP.Layouts.PropertyInfoExtra,																	
																	SELF.property_owned_size := MAX(LEFT.property_owned_size, RIGHT.property_owned_size);
                                  // not using Deed to contribute to property count at this point																	
																	//SELF.Property_owned      := LEFT.Property_owned + RIGHT.Property_owned;
																	SELF := LEFT																
																	),  LEFT OUTER, KEEP(1), FEW);
																	   																																	   										
		dPropertyInfo := dpropertyOwnedSize; 
		          
		 // Join by link ids to get the acctno
    BusinessBatch_BIP.Layouts.PropertyInfo tPropertyInfoWithAcctNo(dLinkIDsWithAcctNo le,
		                                                                dPropertyInfo ri) :=
    TRANSFORM
      SELF.acctno := le.acctno;      
      SELF        := ri;
    END;
    // left outer done here in case there are dup 
		// linkids from different acctno's in the input.
    //
    dPropertyInfoWithAcctNo := JOIN(dLinkIDsWithAcctNo, dPropertyInfo,
                                  BIPV2.IDmacros.mac_JoinTop3Linkids(),
                                  tPropertyInfoWithAcctNo(LEFT,RIGHT),
																	LEFT OUTER,
                                  LIMIT(0),KEEP(100))(SELEID != 0);	
												 
				 
    // DEBUG
		
		 // output(dPropertyAssessmentRaw, named('dPropertyAssessmentRaw'));
		// output(dAssessments_filtered, named('Assessments_filtered'));
		 // output(dAssessments_Rolled_wCount, named('dAssessments_Rolled_wCount'));		
		 // output(dAssessments_rolled_final, named('dAssessments_rolled_final'));
		// output(dDeeds_raw, named('dDeeds_raw'));
		// output(dDeeds_sorted, named('dDeeds_sorted'));
		// output(dDeeds_most_recent_owner, named('dDeeds_most_recent_owner'));
		 // output(dDeeds_inflated_owner, named('dDeeds_inflated_owner'));
		 // output(dDeeds_unique_prop_owner, named('dDeeds_unique_prop_owner'));
		
		 // output(dDeeds_Owner_rolled_wCount , named('dDeeds_Owner_rolled_wCount'));
		// output(dPropertyOwnedSize, named('dPropertyOwnedSize'));
		// output(dPropertyInfoWithAcctNo, named('dPropertyInfoWithAcctNo'));
		RETURN(dPropertyInfoWithAcctNo);					
  END;									
	
  // Flag info
  EXPORT GetFlags(DATASET(BusinessBatch_BIP.Layouts.LinkIdsWithAcctNo) dLinkIDsWithAcctNo,
                  DATASET(BIPV2.IDlayouts.l_xlink_ids)                 dLinkIds) :=
  FUNCTION
	
	  // Fetch MVR and filter only 
		// Owner(type=1), Registrant(type=4) or Lessee(type=5) of the vehicle, 
		dVehicles := VehicleV2.Key_Vehicle_Linkids.kFetch(dLinkIds,BIPV2.IDconstants.Fetch_Level_SELEID)
													 (orig_name_type = BusinessBatch_BIP.Constants.MVR.VEH_OWNER OR
														orig_name_type = BusinessBatch_BIP.Constants.MVR.VEH_REGISTRANT OR
														orig_name_type = BusinessBatch_BIP.Constants.MVR.VEH_LESSEE);
	 // Join by link ids to get the acctno
    BusinessBatch_BIP.Layouts.Flags tVehicleInfoWithAcctNo(dLinkIDsWithAcctNo le, dVehicles ri) :=
    TRANSFORM
		  SELF.Vehicles := IF (ri.vehicle_key != '','Y','');
			SELF.Aircraft      := '';
			SELF.watercraft   := '';
      SELF.judgmentlien_flag := ''; 
      SELF.property_flag     := '';
      SELF.ucc_flag          := '';
      SELF                   := le;
    END;
	
    dVehicleInfoWithAcctNo := JOIN( dLinkIDsWithAcctNo,dVehicles,
                                  BIPV2.IDmacros.mac_JoinTop3Linkids(), 
                                  tVehicleInfoWithAcctNo(LEFT,RIGHT),
                                  LEFT OUTER,
                                  LIMIT(0),KEEP(1));																	
	 // Fetch Watercraft
		dWatercraft := Watercraft.Key_LinkIds.keyFetch(dLinkIds,BIPV2.IDconstants.Fetch_Level_SELEID);
		
    BusinessBatch_BIP.Layouts.Flags tWatercraftInfoWithAcctNo(dVehicleInfoWithAcctNo le,dWatercraft ri) :=
    TRANSFORM			
			SELF.watercraft := IF (ri.watercraft_key != '','Y','');      
      SELF                 := le;
    END;
		
	  // Join by link ids to get the acctno								 
    dWatercraftInfoWithAcctNo := JOIN(dVehicleInfoWithAcctNo,dWatercraft,
                                  BIPV2.IDmacros.mac_JoinTop3Linkids(),
                                  tWatercraftInfoWithAcctNo(LEFT,RIGHT),
                                  LEFT OUTER,
                                  LIMIT(0),KEEP(1));
  
	  // Fetch aircraft
	 dAircraft := faa.key_aircraft_linkids.keyFetch(dLinkIds,BIPV2.IDconstants.Fetch_Level_SELEID);
	  
    BusinessBatch_BIP.Layouts.Flags tAircraftInfoWithAcctNo(dWatercraftInfoWithAcctNo le,dAircraft ri) :=
    TRANSFORM			
			SELF.aircraft := if (ri.n_number != '' and ri.serial_number != '',
			                            'Y','');
      SELF                   := le;
    END;			
		
    // Join by link ids to get the acctno													 
    dAircraftInfoWithAcctNo := JOIN(dWatercraftInfoWithAcctNo,dAircraft,
                                  BIPV2.IDmacros.mac_JoinTop3Linkids(),
                                  tAircraftInfoWithAcctNo(LEFT,RIGHT),
                                  LEFT OUTER,
                                  LIMIT(0),KEEP(1));
	 	 			 													 
    // Fetch liens and judgment
   
    dLiens := getLiensLinkids(dLinkIds);
    // Join by link ids to get the acctno
    BusinessBatch_BIP.Layouts.Flags tLiensInfoWithAcctNo(dAircraftInfoWithAcctNo le,dLiens ri) :=
    TRANSFORM
      SELF.judgmentlien_flag := IF(ri.tmsid != '','Y','');     
      SELF                   := le;
    END;
    
    dLiensInfoWithAcctNo := JOIN(dAircraftInfoWithAcctNo,dLiens,
                                  BIPV2.IDmacros.mac_JoinTop3Linkids() AND
                                  RIGHT.name_type = BusinessBatch_BIP.Constants.UCC.DEBTOR,
                                  tLiensInfoWithAcctNo(LEFT,RIGHT),
                                  LEFT OUTER,
                                  LIMIT(0),KEEP(1));    
    // Fetch UCCs		
		dUCCs := getUCCLinkids(dLinkIds);		
    
    // Join by link ids to get the acctno
    BusinessBatch_BIP.Layouts.Flags tUCCsInfoWithAcctNo(dLiensInfoWithAcctNo le,dUCCs ri) :=
    TRANSFORM
      SELF.ucc_flag := IF(ri.tmsid != '','Y','');
      SELF          := le;
    END;
    
    dUCCsInfoWithAcctNo := JOIN(dLiensInfoWithAcctNo,dUCCs,
                                BIPV2.IDmacros.mac_JoinTop3Linkids() AND
                                RIGHT.party_type = BusinessBatch_BIP.Constants.UCC.DEBTOR,
                                tUCCsInfoWithAcctNo(LEFT,RIGHT),
                                LEFT OUTER,
                                LIMIT(0),KEEP(1));
    
    // Fetch property
    dProperty := getPropertyLinkids(dLinkIds);
		
    // Join by link ids to get the acctno
    BusinessBatch_BIP.Layouts.Flags tPropInfoWithAcctNo(dUCCsInfoWithAcctNo le,dProperty ri) :=
    TRANSFORM
      SELF.property_flag := IF(ri.ln_fares_id != '','Y','');
      SELF               := le;
    END;
    
    dPropInfoWithAcctNo := JOIN(dUCCsInfoWithAcctNo,dProperty,
                                BIPV2.IDmacros.mac_JoinTop3Linkids() AND
                                RIGHT.source_code[1] IN [BusinessBatch_BIP.Constants.Property.Party.Borrower,
                                                          BusinessBatch_BIP.Constants.Property.Party.Owner],
                                tPropInfoWithAcctNo(LEFT,RIGHT),
                                LEFT OUTER,
                                LIMIT(0),KEEP(1));
    
    // OUTPUT(dLiens,NAMED('dLiens'));
    // OUTPUT(dLiensInfo,NAMED('dLiensInfo'));
    // OUTPUT(dLiensInfoWithAcctNo,NAMED('dLiensInfoWithAcctNo'));
    // OUTPUT(dUCCs,NAMED('dUCCs'));
    // OUTPUT(dUCCsInfo,NAMED('dUCCsInfo'));
    // OUTPUT(dUCCsInfoWithAcctNo,NAMED('dUCCsInfoWithAcctNo'));
    // OUTPUT(dProperty,NAMED('dProperty'));
    // OUTPUT(dPropInfo,NAMED('dPropInfo'));
    
    RETURN dPropInfoWithAcctNo;
  END;
  
  // Get executives
  // JIRA RR-10621 - conditionally remove Experian records based on inMod.ExcludeExperian boolean
  EXPORT GetExecutives( DATASET(BusinessBatch_BIP.Layouts.LinkIdsWithAcctNo) dLinkIDsWithAcctNo,
                        DATASET(BIPV2.IDlayouts.l_xlink_ids)                 dLinkIds, 
                        BusinessBatch_Bip.iParam.BatchParams                 inMod ) :=
  FUNCTION
    dContacts := 
      BIPV2_Build.key_contact_linkids.kFetch(dLinkIds,BIPV2.IDconstants.Fetch_Level_SELEID)
        ( IF(inMod.ExcludeExperian, source NOT IN SET(Business_Risk_BIP.Constants.ExperianRestrictedSources, Source), TRUE));
    
    // Filter to get only executives
    dExecutives := dContacts(executive_ind);
    
    // Suppression code
    Suppress.MAC_Suppress(dExecutives,dExecutivesDIDSuppress,inMod.ApplicationType,'DID',contact_did);
    Suppress.MAC_Suppress(dExecutivesDIDSuppress,dExecutivesSuppress,inMod.ApplicationType,'SSN',contact_ssn);
    
    // Set isCurrent flag
    rExecsAppendCurrentFlag :=
    RECORD
      RECORDOF(dExecutives);
      BOOLEAN isCurrent;
    END;
    
    rExecsAppendCurrentFlag tExecsAppendCurrentFlag(dExecutivesSuppress pInput) :=
    TRANSFORM
      STRING8 vCurrentDate := (STRING8)Std.Date.Today();
      
      // Treat executives as current if date last seen is greater than current date - 2 years
      SELF.isCurrent := IF((UNSIGNED4) pInput.dt_last_seen_contact != 0, 
                            (UNSIGNED4) pInput.dt_last_seen_contact >= (UNSIGNED4)ut.date_math(vCurrentDate,BusinessBatch_BIP.Constants.Limits.TwoYearsInDays),
														FALSE);
      SELF           := pInput;
    END;
    
    dExecsAppendCurrentFlag := PROJECT(dExecutives,tExecsAppendCurrentFlag(LEFT));
    
    // Current Executives
   dCurrentExecutives := dExecsAppendCurrentFlag(isCurrent);
    
    // Dedup by name (since contact_did isn't populated much) and keep a max of 9 executives for each link id
   dExecutivesDedup := DEDUP(DEDUP(SORT( dCurrentExecutives,
                                          #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()),
                                          contact_name.lname,contact_name.fname,contact_name.mname,contact_name.name_suffix,
                                          executive_ind_order,-dt_last_seen_contact,-dt_last_seen,-dt_vendor_last_reported,RECORD),
                                    #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()),
                                    contact_name.lname,contact_name.fname,ut.NNEQ(LEFT.contact_name.mname,RIGHT.contact_name.mname),contact_name.name_suffix), 
                              //Need max of 9 executives
                                #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()),KEEP(BusinessBatch_BIP.Constants.Limits.MaxResultsPerSection));
    
    // Sort executives for display purposes
    dExecutivesSortDisplay := SORT( dExecutivesDedup,
                                    #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()),
                                    executive_ind_order,contact_name.lname,contact_name.fname,contact_name.mname);
    
    // Join by link ids to get the acctno
   BusinessBatch_BIP.Layouts.Executives tExecutivesWithAcctNo(dLinkIDsWithAcctNo le,dExecutivesSortDisplay ri) :=
    TRANSFORM
		  SELF.dt_first_seen_contact     := (string10) ri.dt_first_seen_contact;
			SELF.dt_last_seen_contact      := (string10) ri.dt_last_seen_contact;
			SELF.contact_did               := ri.contact_did;
      SELF.contact_job_title_derived := ri.contact_job_title_derived;
      SELF                           := ri.contact_name;			
      SELF                           := le;
    END;
    
    dExecutivesWithAcctNo := JOIN(dLinkIDsWithAcctNo,dExecutivesSortDisplay,
                                  BIPV2.IDmacros.mac_JoinTop3Linkids(),
                                  tExecutivesWithAcctNo(LEFT,RIGHT),
                                  LEFT OUTER,
                                  LIMIT(0),KEEP(BusinessBatch_BIP.Constants.Limits.MaxResultsPerSection));
    // OUTPUT(dContacts,NAMED('dContacts'));
    // OUTPUT(dExecutives,NAMED('dExecutives'));
    // OUTPUT(dExecutivesSuppress,NAMED('dExecutivesSuppress'));
    // OUTPUT(dExecsAppendCurrentFlag,NAMED('dExecsAppendCurrentFlag'));
    // OUTPUT(dExecutivesDedup,NAMED('dExecutivesDedup'));
    // OUTPUT(dExecutivesSortDisplay,NAMED('dExecutivesSortDisplay'));
    
     RETURN dExecutivesWithAcctNo;
    END;
  
  // Get DCA information
  EXPORT GetDCAInfo(DATASET(BusinessBatch_BIP.Layouts.LinkIdsWithAcctNo) dLinkIDsWithAcctNo,
                    DATASET(BIPV2.IDlayouts.l_xlink_ids)                 dLinkIds) :=
  FUNCTION
    dDCAInfo := DCAV2.Key_LinkIds.kFetch(dLinkIds,BIPV2.IDconstants.Fetch_Level_SELEID);
    
    rDCAInfo_Layout :=
    RECORD
      dDCAInfo.ultid;
      dDCAInfo.orgid;
      dDCAInfo.seleid;
      STRING10  num_employees    := MAX(GROUP,dDCAInfo.rawfields.emp_num);
      STRING10  sales_or_revenue := MAX(GROUP,dDCAInfo.rawfields.sales_desc);
      STRING15  sales            := MAX(GROUP,dDCAInfo.rawfields.sales);
    END;
    
    tblDCAInfo := TABLE(dDCAInfo,rDCAInfo_Layout,#EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()));
    
    // Join by link ids to get the acctno
    BusinessBatch_BIP.Layouts.DCAInfo tDCAInfoWithAcctNo(dLinkIDsWithAcctNo le,tblDCAInfo ri) :=
    TRANSFORM
      SELF.num_employees    := ri.num_employees;
      SELF.sales_or_revenue := ut.cleanSpacesAndUpper(ri.sales_or_revenue);
      SELF.sales            := ri.sales;
      SELF                  := le;
    END;
    
    dDCAInfoWithAcctNo := JOIN(dLinkIDsWithAcctNo,tblDCAInfo,
                                BIPV2.IDmacros.mac_JoinTop3Linkids(),
                                tDCAInfoWithAcctNo(LEFT,RIGHT),
                                LEFT OUTER,
                                LIMIT(0),KEEP(1));
    
    // OUTPUT(dDCAInfo,NAMED('dDCAInfo'));
    // OUTPUT(tblDCAInfo,NAMED('tblDCAInfo'));
    
    RETURN dDCAInfoWithAcctNo;
  END;
	
	EXPORT GetDiversityCertInfo(DATASET(BusinessBatch_BIP.Layouts.LinkIdsWithAcctNo) dLinkIDsWithAcctNo,
                    DATASET(BIPV2.IDlayouts.l_xlink_ids)                 dLinkIds) :=
  FUNCTION
	
	   dDiversityCertInfo := Diversity_Certification.Key_LinkIds.keyFetch(dLinkIds,BIPV2.IDconstants.Fetch_Level_SELEID,,
		                                                                  BusinessBatch_BIP.Constants.Limits.MAXDivCert);   
  
	   dDivsersityCertInfoSorted := sort(dDiversityCertInfo, -dt_last_seen, record);
																																			
	   dDiversityCertInfoWithAcctNo := JOIN(dLinkIDsWithAcctNo,dDivsersityCertInfoSorted,
																					BIPV2.IDmacros.mac_JoinTop3Linkids(),
															     TRANSFORM(BusinessBatch_BIP.Layouts.DivCertInfo,
																			SELF.acctno := LEFT.acctno;      
																			SELF.div_dt_first_seen := RIGHT.dt_first_seen;
																			SELF.div_dt_last_seen := RIGHT.dt_last_seen;
																			SELF.div_state := RIGHT.addressstate;
																			SELF.div_minorityAffiliation := RIGHT.minorityAffiliation;
																			SELF.div_certificationtype1 := RIGHT.certificationtype1;
																			SELF.div_certificatedatefrom1 := RIGHT.certificatedatefrom1;
																			SELF.div_certificatedateto1  := RIGHT.certificatedateto1;
																			SELF.div_certificatestatus1   := RIGHT.certificatestatus1;
																			SELF.div_certificatenumber1   := RIGHT.certificationnumber1;
																	
																			SELF.div_certificationtype2 := RIGHT.certificationtype2;
																			SELF.div_certificatedatefrom2 := RIGHT.certificatedatefrom2;
																			SELF.div_certificatedateto2  := RIGHT.certificatedateto2;
																			SELF.div_certificatestatus2   := RIGHT.certificatestatus2;
																			SELF.div_certificatenumber2   := RIGHT.certificationnumber2;
																	
																			SELF.div_certificationtype3 := RIGHT.certificationtype3;
																			SELF.div_certificatedatefrom3 := RIGHT.certificatedatefrom3;
																			SELF.div_certificatedateto3  := RIGHT.certificatedateto3;
																			SELF.div_certificatestatus3   := RIGHT.certificatestatus3;
																			SELF.div_certificatenumber3   := RIGHT.certificationnumber3;
																	
																			SELF.div_certificationtype4 := RIGHT.certificationtype4;
																			SELF.div_certificatedatefrom4 := RIGHT.certificatedatefrom4;
																			SELF.div_certificatedateto4  := RIGHT.certificatedateto4;
																			SELF.div_certificatestatus4   := RIGHT.certificatestatus4;
																			SELF.div_certificatenumber4   := RIGHT.certificationnumber4;
																			
																			SELF        := LEFT
																			), LEFT OUTER, 
																			LIMIT(0), KEEP(1)); 
				
	  RETURN dDiversityCertInfoWithAcctNo;
		
END;

EXPORT GetLaborActionsWHDInfo(DATASET(BusinessBatch_BIP.Layouts.LinkIdsWithAcctNo) dLinkIDsWithAcctNo,
                    DATASET(BIPV2.IDlayouts.l_xlink_ids)                 dLinkIds) :=
  FUNCTION
	   // max limit not needed as per thor job to check max of any seleid < 4K
	   dLaborActionsWHDInfo := LaborActions_WHD.Key_LinkIDS.kFetch(dLinkIds,BIPV2.IDconstants.Fetch_Level_SELEID);
		 		                                                            
	   dLaborActionsWHDSlim := DEDUP(SORT(dLaborActionsWHDInfo, #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()), caseid,-dateupdated),
																				#EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()), caseid);
																				
	   dLaborActionsWHDWithAcctNo := JOIN(dLinkIDsWithAcctNo,dLaborActionsWHDSlim,
														     BIPV2.IDmacros.mac_JoinTop3Linkids(),
															     TRANSFORM(BusinessBatch_BIP.Layouts.LaborActionsWHDInfo,
																			SELF.acctno := LEFT.acctno;  
																				SELF.laborActionViolations := RIGHT.totalViolations; // meaning total case violations
																	      SELF.laborActionBackWages := RIGHT.bw_totalagreedamount; // total back wages agreed to pay
																	      SELF.laborActionMoneyPenalties := RIGHT.cmp_totalAssessments;// total civil monetary penalties assessment										
																			SELF        := LEFT;
																			)
																 , LEFT OUTER, 
																 LIMIT(0), KEEP(1)
																 ); 				
	  RETURN dLaborActionsWHDWithAcctNo;		
END;

	EXPORT GetOSHAInfo(DATASET(BusinessBatch_BIP.Layouts.LinkIdsWithAcctNo) dLinkIDsWithAcctNo,
                    DATASET(BIPV2.IDlayouts.l_xlink_ids)                 dLinkIds) :=
  FUNCTION
	
	   dOSHAInfo := OSHAIR.Key_OSHAIR_LinkIds.kFetch(dLinkIds,BIPV2.IDconstants.Fetch_Level_SELEID,,
		                                               BusinessBatch_BIP.Constants.Limits.MAXOshair);

     dOSHAInfoSlim := DEDUP(SORT(dOSHAInfo,activity_number),activity_number);
		         
	   dOSHADataWithAcctNo := JOIN(dLinkIDsWithAcctNo,dOSHAInfoSlim,
														  BIPV2.IDmacros.mac_JoinTop3Linkids(),
															  TRANSFORM(BusinessBatch_BIP.Layouts.OSHAInspectionInfo,
																  SELF.acctno := LEFT.acctno; 
																	SELF.OshaViolations := (unsigned2) RIGHT.total_Violations;
																	SELF        := LEFT;
																)
															, LEFT OUTER, 
															LIMIT(0), KEEP(1)
														); 				
	  RETURN dOSHADataWithAcctNo;		
	END;
END;