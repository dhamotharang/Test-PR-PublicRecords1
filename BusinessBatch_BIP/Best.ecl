IMPORT ADVO, BIPV2, BIPV2_BEST, Business_Risk_BIP, Census_Data,
       Gong, MDR, STD,  ut;

EXPORT Best := MODULE
 
  EXPORT fullView  (DATASET(
	                    RECORDOF(BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(DATASET([], 
											                 BIPV2.IDfunctions.rec_SearchInput)).SeleBest)) ds_seleBest, 																			
																			 BusinessBatch_Bip.iParam.BatchParams inMod,
																			 dataset(BIPV2.IDfunctions.rec_SearchInput) inRec) :=  MODULE   
	
  INTEGER maxVariationsPerAcctNo  := inMod.MaxResultsPerAcct;
	
	string8 CurDate := (string8) STD.Date.today();
	UNSIGNED4 curYear := (UNSIGNED4) curDate[1..4];
	
	rec_seleBest := RECORD		
		STRING20 acctno;
		BIPV2.Key_BH_Linking_Ids.kfetchOutRec;
	END;		
 
	// filter the particular records that are marked as having a parent
	//ds_parentsIds := ds_SeleBestWacctnoSorted
	ds_parentsIds := ds_SeleBest(ParentAboveSELE = TRUE);

  // setup up the DS for the best kfetch to get the parent information.
	ds_parentsIdsForBestKfetch := PROJECT(ds_parentsIds,
		                                 TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,		                           
															 SELF.PROXID := LEFT.ULTIMATE_PROXID;
															 SELF := [])); 
															 
  // don't need 'status' for parent information thus false at the end to save time
	// also 
  // this attr contains proxid field which we use to match against the correct row in search results
	// in order to attach parent name
	// ..
	// get the parent information in the best kfetch.
	//
	tds_parents_all := BIPV2_Best.Key_LinkIds.kfetch(ds_parentsIdsForBestKfetch,
                       BIPV2.IDconstants.Fetch_Level_PROXID,,,FALSE);  											   																										

  // JIRA RR-10621: Conditionallly remove Experian only records 
  tds_parents := IF( inMod.ExcludeExperian,
                     Business_Risk_BIP.fnMac_ExcludeExperian_ChildDataset(tds_parents_all, company_name[1].sources, source),
                     tds_parents_all );

  // ensure that the 1st row of parent information coming back from best key (thus the [1]
	// has actual populated company name.  This may be overkill but leaving it in for now.
	ds_parents := tds_parents(TRIM(company_Name[1].company_name,LEFT,RIGHT) <> '');
 
  // use ultimate_proxid and parent and proxid returned from best key
	// in order to reattach the list of parent recs to the particular rows in the best key 
	// that have the parent information.
	ds_seleidBestWithParent := DEDUP(SORT(
		 JOIN(ds_SeleBest,ds_parents,                         													
													
	     LEFT.ultimate_proxid = RIGHT.proxid AND												
			 LEFT.parentAboveSELE = TRUE,
				 TRANSFORM({RECORDOF(LEFT); BusinessBatch_BIP.layouts.PARENT_FINAL;},
				   SELF.acctno := LEFT.acctno;																	 					
					 
					 okToDisplayParent := RIGHT.company_name[1].sources[1].source <> MDR.sourceTools.src_Dunn_Bradstreet OR
																RIGHT.company_name[1].sources[2].source <> MDR.sourceTools.src_Dunn_Bradstreet;
					 
				 	 SELF.parent_company_name := if (okToDisplayParent, RIGHT.company_name[1].company_name,'');
					 SELF.parent_prim_range := if (okToDisplayParent, RIGHT.company_address[1].company_prim_range,'');
					 SELF.parent_predir := if (okToDisplayParent, RIGHT.company_address[1].company_predir,'');
					 SELF.parent_prim_name := if (okToDisplayParent, RIGHT.company_address[1].company_prim_name,'');
					 SELF.parent_addr_suffix := if (okToDisplayParent, RIGHT.company_address[1].company_addr_suffix,'');
					 SELF.parent_postdir :=  if (okToDisplayParent, RIGHT.company_address[1].company_postdir,'');
					 SELF.parent_unit_desig := if (okToDisplayParent, RIGHT.company_address[1].company_unit_desig,'');
					 SELF.parent_sec_range := if (okToDisplayParent, RIGHT.company_address[1].company_sec_range,'');
					 SELF.parent_city := if (okToDisplayParent, RIGHT.company_address[1].address_v_city_name,'');
					 SELF.parent_state := if (okToDisplayParent,RIGHT.company_address[1].company_st,'');
					 SELF.parent_zip := if (okToDisplayParent,RIGHT.company_address[1].company_zip5,'');
					 SELF.parent_zip4 := if (okToDisplayParent,RIGHT.company_address[1].company_zip4,'');
					 SELF.parent_phone := if (okToDisplayParent,RIGHT.company_phone[1].company_phone,'');
		    // DISCLAIMER : this parent_sub field was either "P" or "S" (parent subsidiary) in 
			  // pre bip business linking technology (BDID SSTUFF).
			  // I dont think this field applies in our new business linking technology 
		    //                       // of ult/org/ultid etc.
		                           // only populating it with an 
															 // S signals that we do have a row that has a parent.
		       SELF.parent_sub := IF (okToDisplayParent and RIGHT.company_name[1].company_name <> '', 'S','');		
					 SELF := LEFT;
		), LEFT OUTER),	// left outer join cause not all seleid's have parents we can attach.
													acctno, #expand(BIPV2.IDmacros.mac_ListTop3Linkids())), 
													acctno, #expand(BIPV2.IDmacros.mac_ListTop3Linkids())); 
													// don't need to sort by -record_score here cause sort is performed
													// in records attr at the bottom before results returned as 
													// proxweight and record_score is kept for sorting.
	
	// get company_corporation_date from bipv2_best kfetch2 and then  if its non 0 use that to calculate
	// years_in_business in below join.  bipv2_best....Kfetch2 call takes care of dealing with permissions/restrictions etc.
	// e.g. if only SOURCE = D contributing.
	// and also allows multiple inputs to be passed in and get mult outputs back.  
	// proxid= 0 filter limits results for each ult/org/sele combo input to 1 row of output.
	// company_incorporation_date is a Dataset thus the other project on right side below.
     CompanyIncorporationDate := PROJECT(bipv2_best.Key_LinkIds.kfetch2(PROJECT(ds_seleBest, TRANSFORM(
		                                                        BIPV2.IDlayouts.l_xlink_ids2,
										              SELF.uniqueId :=  (unsigned) LEFT.acctno;
												   SELF.ultid := LEFT.ultid;
												   SELF.orgid := LEFT.orgid;
												    SELF.seleid := LEFT.seleid;
														SELF := [])
														)
														)(proxid = 0),
													TRANSFORM({STRING20 acctno; bipv2.idlayouts.l_header_ids; STRING8 company_incorporation_date;},
													SELF.Acctno := (STRING20) LEFT.UniqueID,
													SELF.company_incorporation_date :=  PROJECT (LEFT.company_incorporation_date, 
													    TRANSFORM({STRING8 company_incorporation_date;}, 
														  SELF.company_incorporation_date := (STRING8) LEFT.company_incorporation_date;))[1].company_incorporation_date;
													SELF.ultid := LEFT.ultid;
												      SELF.orgid := LEFT.orgid;
													 SELF.seleid := LEFT.seleid;
													 SELF := []));
													
    ds_seleidbestWithParentDate := join(ds_seleidBestWithParent, CompanyIncorporationdate,		                                              
                                                          LEFT.acctno = RIGHT.acctno AND																									 
											LEFT.ultid = RIGHT.ultid and
											LEFT.orgid = RIGHT.orgid AND
											LEFT.seleid = RIGHT.seleid,
											TRANSFORM({RECORDOF(LEFT); STRING3 years_in_business;},							                     																	 																	 																														
                                                           SELF.Years_In_Business := IF (TRIM(RIGHT.company_incorporation_date,LEFT,RIGHT) <> '',
																      (STRING3) (curYear - (UNSIGNED4) (RIGHT.company_incorporation_date[1..4])),
																			     '');
									           SELF := LEFT)
											);										          																											
	ds_seleidBestoutTmp  := PROJECT(ds_seleidBestWithParentDate, 
												TRANSFORM({BusinessBatch_BIP.Layouts.Best_Final; INTEGER2 record_score;},
													SELF.acctno := LEFT.acctno;
													SELF.record_score := LEFT.record_score;
												
													SELF.ultid := LEFT.ultid;
													SELF.orgid := LEFT.orgid;
													SELF.seleid := LEFT.seleid;
															
													SELF.Best_company_name := LEFT.company_name;															
													SELF.best_prim_range := LEFT.prim_range;
													SELF.best_predir := LEFT.predir;
													SELF.best_prim_name := LEFT.prim_name;
													SELF.best_addr_suffix := LEFT.addr_suffix;
													SELF.best_postdir := LEFT.postdir;
													SELF.best_unit_desig := LEFT.unit_desig;
													SELF.best_sec_range := LEFT.sec_range;
													SELF.best_city := LEFT.v_city_name;
													SELF.best_state := LEFT.st;
													SELF.best_zip := LEFT.zip;
													SELF.best_zip4 := LEFT.zip4;
													SELF.best_county := LEFT.County_name;
													SELF.best_dt_first_seen := LEFT.dt_first_seen;
													SELF.best_dt_last_seen := LEFT.dt_last_seen;
													SELF.best_phone := LEFT.company_phone;
													SELF.best_fein := LEFT.company_fein;
												
		                          //self.best_sic_code ...fill in later.
                          SELF.best_address_status := LEFT.err_stat;																	
													  // tmpDs := project(ut.ds_oneRecord, transform(BIPV2.IDlayouts.l_xlink_ids,
														                   // SELF.ultid := tmpULTID;
																							 // SELF.ORGID := tmpORGID;
																							 // SELF.SELEID := tmpSELEID;
																							 // SELF := []));
												  // gongLinkidsHasCurrentPhone := exists(Gong.key_History_LinkIDs.kfetch(TMPDS)
													                                     // (Current_record_flag = 'Y'));
                          // gongHistoryPhone := exists(project(gong.Key_History_phone(p7 = LEFT.company_phone[4..10] AND
													                                                          // p3 = LEFT.company_phone[1..3]),
																																										// TRANSFORM(LEFT))(current_flag));
                         // Could do like we did in BIP search and override the Bip BH isActive flag if its false
												 // if we have a matching Phone # in the Gong key history that is current.
												 // possibly in future use going linkids key to do same
												 // since that uses more a match on company name and phone/address not just
												 // phone which may be recycled.  Working to keep BIP search and this service
												 // in sync.
												 // gongHistoryPhone could be used if need to override
												 // but not always accurate as phone #'s are recycled.
												 // not implementing currently but could in future
												 // if so desired.
                         SELF.status := MAP (LEFT.isActive
												                         //OR gongHistoryPHone 
																								 => 'ACTIVE',
																						 ~LEFT.isActive => 'INACTIVE',
																								 '');
												 
												 // if (LEFT.isActive, //OR gongHistoryPhone, 
												                                     // 'ACTIVE',
															                      // if (~LEFT.isActive, 'INACTIVE', ''));																												
																										 
													SELF.url := LEFT.company_url;
													SELF.email := ''; // field not populated in best key.															
		                             
													SELF.parent_company_name := LEFT.parent_company_name;
													SELF.parent_prim_range := LEFT.parent_prim_name; 
													SELF.parent_predir := LEFT.parent_predir;
													SELF.parent_prim_name := LEFT.parent_prim_name; 
													SELF.parent_addr_suffix := LEFT.parent_addr_suffix; 
													SELF.parent_postdir := LEFT.parent_postdir; 
													SELF.parent_unit_desig := LEFT.parent_unit_desig; 
													SELF.parent_sec_range := LEFT.parent_sec_range; 
													SELF.parent_city := LEFT.parent_city; 
													SELF.parent_state := LEFT.parent_state;
													SELF.parent_zip := LEFT.parent_zip;
													SELF.parent_zip4 := LEFT.parent_zip4;
													SELF.parent_phone := LEFT.parent_phone;
													SELF.parent_sub := LEFT.parent_sub;	
													//yrCompInCorporated :=  (unsigned4)( left.company_incorporation_date[1..4]);
													// if  years_in_business is blank from above (0 value company_incorporation_date from bipv2best key)
													// then use the dt_first_seen value from selebest to calculate yrs_in_business
													self.years_in_business :=  if ( left.years_in_business= '', 
																						(string3)  (CurYear -  (unsigned4) (left.dt_first_seen[1..4])), 
																					     left.years_in_business);											 	
													SELF := [];
													)
												);
												
     ds_seleidBestout := JOIN(ds_seleidBestoutTmp , Advo.Key_Addr1,
		                                              keyed(LEFT.best_ZIP = right.zip  AND LEFT.best_prim_range = right.prim_range AND
												     LEFT.best_prim_name = RIGHT.prim_name),
														 TRANSFORM(RECORDOF(LEFT),
														  RECORD_TYPE_CODE := RIGHT.RECORD_TYPE_CODE;
													SELF.best_address_type :=  MAP (RECORD_TYPE_CODE = 'F' => 'FIRM',
																									RECORD_TYPE_CODE = 'G' => 'GENERAL DELIVERY',
																									RECORD_TYPE_CODE = 'H' => 'HIGH RISE',
																									RECORD_TYPE_CODE = 'P' => 'PO box',
																									RECORD_TYPE_CODE = 'R' => 'Rural Route',
																									RECORD_TYPE_CODE = 'S' => 'Street',
										                           	'									');		
                                                                     SELF := LEFT;
												     SELF := [];
												      ), LEFT OUTER, limit(ut.limits.DEFAULT,skip));																								
 			
		 ////////////////
      addr_layout := RECORD
			                  INTEGER rec_num;
			                  STRING ZIP;
												STRING prim_range;
												STRING prim_name;
												STRING addr_suffix;
												STRING st;
												STRING fips_county;
										 END;
       
			  addr_info_layout := RECORD
					      INTEGER rec_num;
								STRING30 RECORD_TYPE;
								string20 countyName;
								END;		
		
      getAddrInfo(dataset(addr_layout) addr_ds) := FUNCTION
			    
								
         recordTypeCodeDs := JOIN(addr_ds, Advo.Key_Addr1,
				           LEFT.zip = RIGHT.zip AND
									 LEFT.prim_range = RIGHT.prim_range AND
									 LEFT.prim_name = RIGHT.prim_name AND
									 LEFT.Addr_suffix = RIGHT.Addr_suffix,
									 TRANSFORM({addr_info_layout; STRING st; string fips_county;},
									     RECORD_TYPE_CODE := right.record_type_CODE;
									    SELF.RECORD_TYPE :=  MAP (RECORD_TYPE_CODE = 'F' => 'FIRM',
				                                        RECORD_TYPE_CODE = 'G' => 'GENERAL DELIVERY',
											                          RECORD_TYPE_CODE = 'H' => 'HIGH RISE',
										                          	RECORD_TYPE_CODE = 'P' => 'PO box',
										                           	RECORD_TYPE_CODE = 'R' => 'Rural Route',
											                          RECORD_TYPE_CODE = 'S' => 'Street',
										                           	'');
											SELF := LEFT,
											SELF.countyName := '';
										  ), LEFT OUTER, limit(ut.limits.DEFAULT,skip));
         countyInfoDS := JOIN(recordTypeCodeDS, Census_data.Key_Fips2County,
				                KEYED(LEFT.st = RIGHT.state_code) AND
												KEYED(LEFT.fips_county = RIGHT.county_fips),
												TRANSFORM(addr_info_layout,
												     SELF.countyName := RIGHT.county_name;
														 SELF := LEFT), LEFT OUTER,limit(ut.limits.DEFAULT,skip));
        return(countyInfoDS);														 
          END;  											
					 
			
					 
   BusinessBatch_BIP.Layouts.ADDRESS_Final
       MakeFlatAddrs( rec_seleBest le,
                  DATASET(rec_seleBest) allrows) := TRANSFORM
									
             addr_ds := PROJECT(allRows, TRANSFORM(addr_layout,
						            SELF.rec_num := counter;
												SELF := LEFT));
             addr_info := getAddrInfo(addr_ds);									
								 
              SELF.acctno := le.acctno;
							SELF.ultid := LE.ultid;
							SELF.orgid := LE.orgid;
							SELF.seleid := LE.seleid;							
							SELF.prim_range_var1 := allrows[1].prim_range;
							SELF.prim_name_var1 := allrows[1].prim_name;
							SELF.predir_var1 := allrows[1].predir;
							SELF.postdir_var1 := allrows[1].postdir;
							SELF.sec_range_var1 := allrows[1].sec_range;
							SELF.unit_desig_var1 := allrows[1].unit_desig;
							SELF.addr_suffix_var1 := allrows[1].addr_suffix;
							SELF.city_var1 := allrows[1].v_city_name;
							SELF.state_var1 := allrows[1].st;
							SELF.zip_var1 := allrows[1].zip;
							SELF.zip4_var1 := allrows[1].zip4;							
							SELF.dt_first_seen_var1 := allrows[1].dt_first_seen;
							SELF.dt_last_seen_var1 := allrows[1].dt_last_seen;
							SELF.county_var1 := addr_info(rec_num = 1)[1].countyName;
							SELF.address_type_var1 := Addr_info(rec_num = 1)[1].RECORD_TYPE;							
							SELF.Address_status_var1 := allrows[1].err_stat;							
							
							SELF.prim_range_var2 := allrows[2].prim_range;
							SELF.prim_name_var2 := allrows[2].prim_name;
							SELF.predir_var2 := allrows[2].predir;
							SELF.postdir_var2 := allrows[2].postdir;
							SELF.sec_range_var2 := allrows[2].sec_range;
							SELF.unit_desig_var2 := allrows[2].unit_desig;
							SELF.addr_suffix_var2 := allrows[2].addr_suffix;
							SELF.city_var2 := allrows[2].v_city_name;
							SELF.state_var2 := allrows[2].st;
							SELF.zip_var2 := allrows[2].zip;
							SELF.zip4_var2 := allrows[2].zip4;							
							SELF.dt_first_seen_var2 := allrows[2].dt_first_seen;
							SELF.dt_last_seen_var2 := allrows[2].dt_last_seen;
							SELF.county_var2 := addr_info(rec_num = 2)[1].countyName;
							SELF.address_type_var2 := Addr_info(rec_num = 2)[1].RECORD_TYPE;						
						     SELF.Address_status_var2 := allrows[2].err_stat;
							SELF.URL_var2 := allrows[2].company_url;
							
							SELF.prim_range_var3 := allrows[3].prim_range;
							SELF.prim_name_var3 := allrows[3].prim_name;
							SELF.predir_var3 := allrows[3].predir;
							SELF.postdir_var3 := allrows[3].postdir;
							SELF.sec_range_var3 := allrows[3].sec_range;
							SELF.unit_desig_var3 := allrows[3].unit_desig;
							SELF.addr_suffix_var3 := allrows[3].addr_suffix;
							SELF.city_var3 := allrows[3].v_city_name;
							SELF.state_var3 := allrows[3].st;
							SELF.zip_var3 := allrows[3].zip;
							SELF.zip4_var3 := allrows[3].zip4;						
							SELF.dt_first_seen_var3 := allrows[3].dt_first_seen;
							SELF.dt_last_seen_var3 := allrows[3].dt_last_seen;
							SELF.county_var3 := addr_info(rec_num = 3)[1].countyName;
							SELF.address_type_var3 := Addr_info(rec_num = 3)[1].RECORD_TYPE;					 
							SELF.Address_status_var3 := allrows[3].err_stat;
							SELF.URL_var3 := allrows[3].company_url;
							
							SELF.prim_range_var4 := allrows[4].prim_range;
							SELF.prim_name_var4 := allrows[4].prim_name;
							SELF.predir_var4 := allrows[4].predir;
							SELF.postdir_var4 := allrows[4].postdir;
							SELF.sec_range_var4 := allrows[4].sec_range;
							SELF.unit_desig_var4 := allrows[4].unit_desig;
							SELF.addr_suffix_var4 := allrows[4].addr_suffix;
							SELF.city_var4 := allrows[4].v_city_name;
							SELF.state_var4 := allrows[4].st;
							SELF.zip_var4 := allrows[4].zip;
							SELF.zip4_var4 := allrows[4].zip4;							
							SELF.dt_first_seen_var4 := allrows[4].dt_first_seen;
							SELF.dt_last_seen_var4 := allrows[4].dt_last_seen;
							SELF.county_var4 := addr_info(rec_num = 4)[1].countyName;
							SELF.address_type_var4 := Addr_info(rec_num = 4)[1].RECORD_TYPE;															  
							SELF.Address_status_var4 := allrows[4].err_stat;
							
							SELF.prim_range_var5 := allrows[5].prim_range;
							SELF.prim_name_var5 := allrows[5].prim_name;
						     SELF.predir_var5 := allrows[5].predir;
							SELF.postdir_var5 := allrows[5].postdir;
							SELF.sec_range_var5 := allrows[5].sec_range;
							SELF.unit_desig_var5 := allrows[5].unit_desig;
							SELF.addr_suffix_var5 := allrows[5].addr_suffix;
							SELF.city_var5 := allrows[5].v_city_name;
							SELF.state_var5 := allrows[5].st;
							SELF.zip_var5 := allrows[5].zip;
							SELF.zip4_var5 := allrows[5].zip4;							
							SELF.dt_first_seen_var5 := allrows[5].dt_first_seen;
							SELF.dt_last_seen_var5 := allrows[5].dt_last_seen;
							SELF.county_var5 := addr_info(rec_num = 5)[1].countyName;
							SELF.address_type_var5 := Addr_info(rec_num = 5)[1].RECORD_TYPE;														 
							SELF.Address_status_var5 := allrows[5].err_stat;
							
							SELF.prim_range_var6 := allrows[6].prim_range;
							SELF.prim_name_var6 := allrows[6].prim_name;
							SELF.predir_var6 := allrows[6].predir;
							SELF.postdir_var6 := allrows[6].postdir;
							SELF.sec_range_var6 := allrows[6].sec_range;
							SELF.unit_desig_var6 := allrows[6].unit_desig;
							SELF.addr_suffix_var6 := allrows[6].addr_suffix;
							SELF.city_var6 := allrows[6].v_city_name;
							SELF.state_var6 := allrows[6].st;
							SELF.zip_var6 := allrows[6].zip;
							SELF.zip4_var6 := allrows[6].zip4;							
							SELF.dt_first_seen_var6 := allrows[6].dt_first_seen;
							SELF.dt_last_seen_var6 := allrows[6].dt_last_seen;
							SELF.county_var6 := addr_info(rec_num = 6)[1].countyName;
							SELF.address_type_var6 := Addr_info(rec_num = 6)[1].RECORD_TYPE;	
							SELF.Address_status_var6 := allrows[6].err_stat;																				 
							
							SELF.prim_range_var7 := allrows[7].prim_range;
							SELF.prim_name_var7 := allrows[7].prim_name;
							SELF.predir_var7 := allrows[7].predir;
							SELF.postdir_var7 := allrows[7].postdir;
							SELF.sec_range_var7 := allrows[7].sec_range;
							SELF.unit_desig_var7 := allrows[7].unit_desig;
							SELF.addr_suffix_var7 := allrows[7].addr_suffix;
							SELF.city_var7 := allrows[7].v_city_name;
							SELF.state_var7 := allrows[7].st;
							SELF.zip_var7 := allrows[7].zip;
							SELF.zip4_var7 := allrows[7].zip4;							
							SELF.dt_first_seen_var7 := allrows[7].dt_first_seen;
							SELF.dt_last_seen_var7 := allrows[7].dt_last_seen;
							SELF.county_var7 := addr_info(rec_num = 7)[1].countyName;
							SELF.address_type_var7 := Addr_info(rec_num = 7)[1].RECORD_TYPE;						 
							SELF.Address_status_var7 := allrows[7].err_stat;																				 
							
							SELF.prim_range_var8 := allrows[8].prim_range;
							SELF.prim_name_var8 := allrows[8].prim_name;
							SELF.predir_var8 := allrows[8].predir;
							SELF.postdir_var8 := allrows[8].postdir;
							SELF.sec_range_var8 := allrows[8].sec_range;
							SELF.unit_desig_var8 := allrows[8].unit_desig;
							SELF.addr_suffix_var8 := allrows[8].addr_suffix;
							SELF.city_var8 := allrows[8].v_city_name;
							SELF.state_var8 := allrows[8].st;
							SELF.zip_var8 := allrows[8].zip;
							SELF.zip4_var8 := allrows[8].zip4;							
							SELF.dt_first_seen_var8 := allrows[8].dt_first_seen;
							SELF.dt_last_seen_var8 := allrows[8].dt_last_seen;
							SELF.county_var8 := addr_info(rec_num = 8)[1].countyName;
							SELF.address_type_var8 := Addr_info(rec_num = 8)[1].RECORD_TYPE;	
						     SELF.Address_status_var8 := allrows[8].err_stat;
							
							SELF.prim_range_var9 := allrows[9].prim_range;
							SELF.prim_name_var9 := allrows[9].prim_name;
							SELF.predir_var9 := allrows[9].predir;
							SELF.postdir_var9 := allrows[9].postdir;
							SELF.sec_range_var9 := allrows[9].sec_range;
							SELF.unit_desig_var9 := allrows[9].unit_desig;
							SELF.addr_suffix_var9 := allrows[9].addr_suffix;
							SELF.city_var9 := allrows[9].v_city_name;
							SELF.state_var9 := allrows[9].st;
							SELF.zip_var9 := allrows[9].zip;
							SELF.zip4_var9 := allrows[9].zip4;							
							SELF.dt_first_seen_var9 := allrows[9].dt_first_seen;
							SELF.dt_last_seen_var9 := allrows[9].dt_last_seen;
							SELF.county_var9 := addr_info(rec_num = 9)[1].countyName;
							SELF.address_type_var9 := Addr_info(rec_num = 9)[1].RECORD_TYPE;
							SELF.Address_status_var9 := allrows[9].err_stat;																				 
							
							SELF.total_addresses := IF (allrows[1].v_city_name <> '' AND
							                             allrows[1].st <> '' , 1, 0) +
							                        IF (allrows[2].v_city_name <> '' AND
							                             allrows[2].st <> '' , 1, 0) +
											   IF (allrows[3].v_city_name <> '' AND
							                             allrows[3].st <> '' , 1, 0) +
											   IF (allrows[4].v_city_name <> '' AND
							                             allrows[4].st <> '' , 1, 0) +
											   IF (allrows[5].v_city_name <> '' AND
							                             allrows[5].st <> '' , 1, 0) +
											    IF (allrows[6].v_city_name <> '' AND
							                             allrows[6].st <> '' , 1, 0) +
												IF (allrows[7].v_city_name <> '' AND
							                             allrows[7].st <> '' , 1, 0) +
												IF (allrows[8].v_city_name <> '' AND
							                             allrows[8].st <> '' , 1, 0) +
												IF (allrows[9].v_city_name <> '' AND
							                             allrows[9].st <> '' , 1, 0);
							 SELF := [];
END;																 
				 
		 // transform for making cname vars into separate fields. 
   BusinessBatch_BIP.Layouts.cName_Final
       MakeFlatCname( rec_seleBest le,
                 DATASET(rec_seleBest) allrows) := TRANSFORM
						     SELF.acctno := le.acctno;
							SELF.ultid := LE.ultid;
							SELF.orgid := LE.orgid;
							SELF.seleid := LE.seleid;
							SELF.company_name_var1 := allrows[1].company_name;
							SELF.Company_name_var1_first_seen := ut.date_YYYYMMDDtoDateSlashed((string8) allrows[1].dt_first_seen_company_name);
							SELF.Company_name_var1_last_seen  := ut.date_YYYYMMDDtoDateSlashed((string8) allrows[1].dt_last_seen_company_name);
							SELF.company_name_var2 := allrows[2].company_name;
							SELF.Company_name_var2_first_seen := ut.date_YYYYMMDDtoDateSlashed((string8) allrows[2].dt_first_seen_company_name);
							SELF.Company_name_var2_last_seen  := ut.date_YYYYMMDDtoDateSlashed((string8) allrows[2].dt_last_seen_company_name);
							SELF.company_name_var3 := allrows[3].company_name;
							SELF.Company_name_var3_first_seen := ut.date_YYYYMMDDtoDateSlashed((string8) allrows[3].dt_first_seen_company_name);
							SELF.Company_name_var3_last_seen  := ut.date_YYYYMMDDtoDateSlashed((string8) allrows[3].dt_last_seen_company_name);
							SELF.company_name_var4 := allrows[4].company_name;
							SELF.Company_name_var4_first_seen := ut.date_YYYYMMDDtoDateSlashed((string8) allrows[4].dt_first_seen_company_name);
							SELF.Company_name_var4_last_seen  := ut.date_YYYYMMDDtoDateSlashed((string8) allrows[4].dt_last_seen_company_name);
							SELF.company_name_var5 := allrows[5].company_name;
							SELF.Company_name_var5_first_seen := ut.date_YYYYMMDDtoDateSlashed((string8) allrows[5].dt_first_seen_company_name);
							SELF.Company_name_var5_last_seen  := ut.date_YYYYMMDDtoDateSlashed((string8) allrows[5].dt_last_seen_company_name);
							SELF.company_name_var6 := allrows[6].company_name;
							SELF.Company_name_var6_first_seen := ut.date_YYYYMMDDtoDateSlashed((string8) allrows[6].dt_first_seen_company_name);
							SELF.Company_name_var6_last_seen  := ut.date_YYYYMMDDtoDateSlashed((string8) allrows[6].dt_last_seen_company_name);
							SELF.company_name_var7 := allrows[7].company_name;
							SELF.Company_name_var7_first_seen := ut.date_YYYYMMDDtoDateSlashed((string8) allrows[7].dt_first_seen_company_name);
							SELF.Company_name_var7_last_seen  := ut.date_YYYYMMDDtoDateSlashed((string8) allrows[7].dt_last_seen_company_name);
							SELF.company_name_var8 := allrows[8].company_name;
							SELF.Company_name_var8_first_seen := ut.date_YYYYMMDDtoDateSlashed((string8) allrows[8].dt_first_seen_company_name);
							SELF.Company_name_var8_last_seen  := ut.date_YYYYMMDDtoDateSlashed((string8) allrows[8].dt_last_seen_company_name);
							SELF.company_name_var9 := allrows[9].company_name;
							SELF.Company_name_var9_first_seen := ut.date_YYYYMMDDtoDateSlashed((string8) allrows[9].dt_first_seen_company_name);
							SELF.Company_name_var9_last_seen  := ut.date_YYYYMMDDtoDateSlashed((string8) allrows[9].dt_last_seen_company_name);
							SELF := [];
   END;							
	 
	 // transform for making fein vars into separate fields. 
		  BusinessBatch_BIP.Layouts.Fein_Final
       MakeFlatFein( rec_seleBest le,
                 DATASET(rec_seleBest) allrows) := TRANSFORM
              SELF.acctno := le.acctno;
						     SELF.ultid := LE.ultid;
							SELF.orgid := LE.orgid;
							SELF.seleid := LE.seleid;
							SELF.fein_var1 := allrows[1].company_fein;
							SELF.fein_var2 := allrows[2].company_fein;
							SELF.fein_var3 := allrows[3].company_fein;
							SELF.fein_var4 := allrows[4].company_fein;
							SELF.fein_var5 := allrows[5].company_fein;
							SELF.fein_var6 := allrows[6].company_fein;
							SELF.fein_var7 := allrows[7].company_fein;
							SELF.fein_var8 := allrows[8].company_fein;
							SELF.fein_var9 := allrows[9].company_fein;
							SELF.total_fein := IF (allrows[1].company_fein <> '', 1, 0) +
													IF (allrows[2].company_fein <> '', 1, 0) +
													IF (allrows[3].company_fein <> '', 1, 0) +
													IF (allrows[4].company_fein <> '', 1, 0) +
													IF (allrows[5].company_fein <> '', 1, 0) +
													IF (allrows[6].company_fein <> '', 1, 0) +
													IF (allrows[7].company_fein <> '', 1, 0) +
													IF (allrows[8].company_fein <> '', 1, 0) +
													IF (allrows[9].company_fein <> '', 1, 0);																 
							SELF := [];
   END;	
 
   DS_SELEBestRecsAcctnoBH := PROJECT(ds_SeleBest, TRANSFORM(
	                      {STRING20 acctno; UNSIGNED6 ultid; UNSIGNED6 orgid; UNSIGNED6 seleid;},
	                                                 SELF := LEFT));	 
   DS_SELEBestRecsAcctnoBHSlim := DEDUP(DS_SELEBestRecsAcctnoBH, ALL);																							 
	 FETCH_LEVEL := BIPV2.IDconstants.Fetch_Level_SELEID;
	 linkidsOnly := DEDUP(SORT(PROJECT(DS_SELEBestRecsAcctnoBH, TRANSFORM(
									BIPV2.IDlayouts.l_xlink_ids, 
											SELF.ultid := LEFT.ultid;
											SELF.orgid := LEFT.orgid; 
											SELF.seleid := LEFT.seleid;
									SELF  := [])),  #expand(BIPV2.IDmacros.mac_ListTop3Linkids())),  
						 #expand(BIPV2.IDmacros.mac_ListTop3Linkids()));
																
   // get recs from bus header cap at MaxBHLinkidsBest constant.			
	 // TRUE means don't return any SOURCE = D recs (Dun and Bradstreet).
   // JIRA RR-10621 - conditionally filter out Experian records based on inMod.ExcludeExperian boolean
	 ds_busHeaderRecsSlim := BIPV2.Key_BH_Linking_Ids.kfetch(linkidsOnly,FETCH_LEVEL,,,BusinessBatch_BIP.Constants.DEFAULTS.MaxBHLinkidsBest
	                                               ,TRUE)(source <> MDR.sourceTools.src_Dunn_Bradstreet AND
	                                                      source <> '' AND
                                                        ( IF(inMod.ExcludeExperian, source NOT IN SET(Business_Risk_BIP.Constants.ExperianRestrictedSources, Source), TRUE)));
	
	 ds_BHrecsDedup := DEDUP(SORT(ds_busHeaderRecsSlim,ultid,orgid,seleid, st,zip,st, v_city_name, prim_name, prim_range, cnp_name),
	                                                   ultid,orgid,seleid, st,zip,st, v_city_name, prim_name, prim_range, cnp_name);
																										 
   ds_BHrecsDedupWAcctno := SORT(JOIN(ds_BHrecsDedup,ds_seleBest,
	                               BIPV2.IDmacros.mac_JoinTop3Linkids(),
																 TRANSFORM({STRING20 Acctno;RECORDOF(LEFT);},
																 SELF.acctno := RIGHT.ACCTNO,
																 SELF := LEFT), LEFT OUTER), acctno, record);
																 
    // now post filter these recs based on the input.
		// need a count field for each acctno # row
		// take left which has Acctno's add a count field to it
		// then join it back to
		// use counter 
		// join left (acctno/linkids and input addr) to right (linkids, addr)
		//  filter using input addr to the right and only keep recs from right if they match the filter.
		//
		//		
    ds_input := SORT(InRec(prim_name != '' AND ((city != '' AND state != '') OR
																				(zip5 != ''))),acctno,RECORD);
		                                                   
		// when done join will have acctno/linkids and row of data which matches input
		// then need to do the counts for each individual SELEID
		//
	  ds_BHrecsCombined := SORT(JOIN(ds_BHrecsDedupWAcctno, ds_Input,
		                            LEFT.ACCTNO = RIGHT.ACCTNO,
																TRANSFORM(RECORDOF(LEFT),																  
																  match := LEFT.PRIM_NAME = RIGHT.PRIM_NAME AND
																	         LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE 
																						AND 
																						  ((LEFT.v_city_name = RIGHT.city AND LEFT.st = RIGHT.state) 
																										OR
																								(LEFT.ZIP = RIGHT.ZIP5));																																																					
																 SELF := IF (match, LEFT);																
																   )
																 ),acctno,record)(acctno != '');
																 
    // now do the counts for each acctno
		
		ds_ActiveAddrVariationsCount := TABLE(ds_BHrecsCombined(Current),
		    {acctno,UNSIGNED2 cnt:= COUNT(GROUP);},acctno);

    ds_InActiveAddrVariationsCount := TABLE(ds_BHrecsCombined(~(Current)),
		    {acctno,UNSIGNED2 cnt:= COUNT(GROUP);},acctno);				
				
		// END VARIATIONS of companies at the address.
		//	 	
   																									 
    ds_busHeaderRecsSlimSorted := SORT(ds_busHeaderRecsSlim,#expand(BIPV2.IDmacros.mac_ListTop3Linkids()), RECORD);
   // add back acctno to the DS.
   DS_BHRecsWAcctno := 	JOIN(SORT(DS_SELEBestRecsAcctnoBHSlim,#expand(BIPV2.IDmacros.mac_ListTop3Linkids())),
                                     	ds_busHeaderRecsSlimSorted,
	                             BIPV2.IDmacros.mac_JoinTop3Linkids(),
															TRANSFORM(rec_seleBest,
															  SELF.acctno := LEFT.acctno;
																SELF := RIGHT), LEFT OUTER, LIMIT(0), KEEP(100));
																
   DS_seleBestGroupedYrsInBusDedup := DEDUP(SORT(DS_BHRecsWAcctno(dt_first_seen <> 0),
	                                   acctno, #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),dt_first_seen),
																		  acctno,#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),dt_first_seen);

   // grab the top X rows for each acctno of the different linkids/acctno
		 DS_SeleBestGroupedYrsInBusDedupSmall := TOPN( GROUP( SORT(DS_seleBestGroupedYrsInBusDedup,acctno, dt_first_seen), 
	              acctno), maxVariationsPerAcctno , acctno);																						   																						 
			 
	 // slim the BH recs to be only ones with different linkids and addresses
	 DS_seleBestGroupedAddrDedup := DEDUP( SORT(DS_BHRecsWAcctno,	                                            
								   acctno, #expand(BIPV2.IDmacros.mac_ListTop3Linkids()), st,v_city_name,zip,prim_name,prim_range,record),
	                                        acctno, #expand(BIPV2.IDmacros.mac_ListTop3Linkids()), st,v_city_name,zip,prim_name,prim_range);
   									
   	// eliminate dups of the Bus header addresses that might exist in the best DS
	 DS_seleBestGroupedAddrDedupSlim := GROUP(SORT(JOIN(ds_seleBestGroupedAddrDedup, ds_seleBest, 
																								 LEFT.acctno = RIGHT.acctno AND
																								 BIPV2.IDmacros.mac_JoinTop3Linkids() AND
																								 LEFT.st = RIGHT.st AND
																								 LEFT.v_city_name = RIGHT.v_city_name AND
																								 LEFT.zip = RIGHT.zip AND
																								 LEFT.prim_name = RIGHT.prim_name AND
																								 LEFT.prim_range = RIGHT.prim_range,
																								 TRANSFORM(LEFT), LEFT ONLY), acctno), acctno);																					
    // grab the top X rows for each acctno of the different linkids/acctno
		 DS_SeleBestGroupedAddrDedupSmall := TOPN( GROUP( SORT(DS_seleBestGroupedAddrDedupSlim,acctno, -dt_last_seen), 
	              acctno), maxVariationsPerAcctno , acctno);
	
	// put the DS into  a flat layout
  ds_AddressVarsOutStart := ROLLUP(DS_SeleBestGroupedAddrDedupSmall, 
												GROUP, MakeFlatAddrs(LEFT,ROWS(LEFT)));
		
		
  // now do same type of thing with cnames/feins that we did with addresses
  // 		
	ds_seleBestGroupedcnameDedup := DEDUP(SORT(DS_BHRecsWAcctno, acctno,  
																	 #expand(BIPV2.IDmacros.mac_ListTop3Linkids()), company_name, RECORD),acctno,
	                                 #expand(BIPV2.IDmacros.mac_ListTop3Linkids()), company_name);
	
	// eliminate dups of cnames that might exist in best
	 ds_seleBestGroupedcnameDedupSlim := GROUP(SORT(JOIN(ds_seleBestGroupedcnameDedup, ds_seleBest,	                                               
																								 LEFT.acctno = RIGHT.acctno AND
																								  BIPV2.IDmacros.mac_JoinTop3Linkids() AND
																								 LEFT.company_name = RIGHT.company_name,
																								 TRANSFORM(LEFT), LEFT ONLY), acctno), acctno);
 
   DS_SeleBestGroupedCnameDedupSmall := TOPN( GROUP( SORT(DS_seleBestGroupedCnameDedupSlim,acctno, -dt_last_seen), 
	              acctno), maxVariationsPerAcctno , acctno);
																								 
	ds_CnameVarsOut := ROLLUP(ds_seleBestGroupedCnameDedupSmall , GROUP, MakeFlatCname(LEFT,ROWS(LEFT)));
  
	// ok if we drop rows with acctno's here cause we do left outer from selebest below
	ds_seleBestGroupedFeinDedup := DEDUP(SORT(DS_BHRecsWAcctno(source <> 'E5' and company_fein <> ''), acctno,   #expand(BIPV2.IDmacros.mac_ListTop3Linkids()), company_fein, record)
	                              ,acctno,  #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),company_fein);
	
	// eliminate dups of feins that might exist in best.
	 ds_seleBestGroupedFeinDedupSlim := GROUP(SORT(JOIN(ds_seleBestGroupedFeinDedup, ds_seleBest,	                                               
																								 LEFT.acctno = RIGHT.acctno AND
																								 BIPV2.IDmacros.mac_JoinTop3Linkids() AND
																								 LEFT.company_fein = RIGHT.company_fein,
																								 TRANSFORM(LEFT), LEFT ONLY), acctno), acctno);
																								     																								
  DS_SeleBestGroupedFeinDedupSmall := TOPN( GROUP( SORT(DS_seleBestGroupedFeinDedupSlim,acctno, -dt_last_seen), 
	              acctno), maxVariationsPerAcctno , acctno);																								 
																								 	
	ds_FeinVarsOut := ROLLUP(ds_seleBestGroupedFeinDedupSmall , GROUP, MakeFlatFein(LEFT,ROWS(LEFT)));
	
	
	// create a DS from input best to start with that will have all incoming acctno's from input
	//
	ds_initialAcctno := PROJECT(ds_seleBest, TRANSFORM({STRING20 acctno;
	                                     UNSIGNED6 ultid; UNSIGNED6 orgid;UNSIGNED6 seleid;},
																			 SELF := LEFT));
  ds_initialacctnoSlim := dedup(ds_initialAcctno, all);
  // this left outer is done cause ds_addressVarsOut might be empty need to 'seed'
	// the resulting DS with acctno's as its built to ensure 
	// e.g. extra fein variations are added in even if there are not extra address variations
	// so join together the addresses/cname variations and fein variations.
	ds_AddressVarsOut := JOIN(ds_initialAcctnoSlim, ds_AddressVarsOutStart,
	                      LEFT.acctno = RIGHT.acctno AND
											 BIPV2.IDmacros.mac_JoinTop3Linkids(),
												  TRANSFORM(BusinessBatch_BIP.Layouts.ADDRESS_Final,
																	 SELF := LEFT,
																	 SELF := RIGHT,
																	 SELF :=[];
																	 ), LEFT OUTER);  		
  // join in with cname variations.
	ds_NameAddressVarsOutFinal := JOIN(ds_AddressVarsOut, ds_CnameVarsOut,
	                                      LEFT.acctno = RIGHT.acctno and
									BIPV2.IDmacros.mac_JoinTop3Linkids(),
										TRANSFORM(BusinessBatch_BIP.Layouts.BestLayout,
																	 SELF := LEFT,
																	 SELF := RIGHT,
																	 SELF :=[];
																	 ), LEFT OUTER);  		
		   // add input_residential flag															 
	ds_YrsInBusinessOutFinal := JOIN(ds_NameAddressVarsOutFinal, DS_SeleBestGroupedYrsInBusDedupSmall,
		                                    LEFT.acctno  = RIGHT.acctno AND
										BIPV2.IDmacros.mac_JoinTop3Linkids(),
										TRANSFORM(BusinessBatch_BIP.Layouts.BestLayout,
																			
																			SELF.Input_residential :=  IF (RIGHT.Address_type_derived = 'R', 'Y',						
																													IF (RIGHT.address_type_derived = 'B','N','N')
																												);																					        																																																		
																			SELF := LEFT,																		
																			SELF := [];
																			), LEFT OUTER);
  
	ds_NameAddressFeinVarsOutFinal := JOIN(ds_YrsInBusinessOutFinal, ds_FeinVarsOut,	                                                                              
	                                      LEFT.acctno = RIGHT.acctno AND
								 BIPV2.IDmacros.mac_JoinTop3Linkids(),
									TRANSFORM(BusinessBatch_BIP.Layouts.BestLayoutWithFeinVars,																	 																																										 
																	 SELF := LEFT,																													 
																	 SELF := RIGHT,
																	 SELF :=[];
																	 ), LEFT OUTER);										 
																									 
  // add in current businesses count.
	ds_ActiveAddrVariationsCountFinal := JOIN(ds_nameAddressFeinVarsOutFinal, ds_ActiveAddrVariationsCount,
														LEFT.acctno = RIGHT.acctno,
														TRANSFORM(BusinessBatch_BIP.Layouts.BestLayoutWithFeinVars,
															SELF.Input_total_businesses_active := RIGHT.cnt;
															SELF := LEFT), 
														LEFT OUTER);
 // add in historical businesses count																				
  ds_InActiveAddrVariationsCountFinal := JOIN(ds_ActiveAddrVariationsCountFinal, ds_InActiveAddrVariationsCount,
														LEFT.acctno = RIGHT.acctno,
														TRANSFORM(BusinessBatch_BIP.Layouts.BestLayoutWithFeinVars,
															SELF.Input_total_businesses_history := RIGHT.cnt;
															SELF := LEFT), 
														 LEFT OUTER);																			
	
	// now need to combine the best/parent DS with variations of addresses/cnames/feins
	DS_BestNameAddressOutputTmp := PROJECT(SORT(JOIN(ds_seleidBestout, ds_InActiveAddrVariationsCountFinal,
																LEFT.acctno = RIGHT.acctno AND
																	 BIPV2.IDmacros.mac_JoinTop3Linkids(),
																	 TRANSFORM(BusinessBatch_BIP.Layouts.BestLayoutWithFeinVarsTmp,																	
																	 SELF.Input_residential := RIGHT.Input_residential;
																	 SELF.Input_total_businesses_Active := RIGHT.Input_Total_businesses_active;
																	 SELF.Input_total_businesses_history := RIGHT.Input_total_businesses_history;
																	 SELF.total_fein := IF (LEFT.best_fein <> '', Right.total_fein + 1,
																	                                          right.total_fein);
																	 SELF := LEFT,
																	 SELF := RIGHT,
																	 SELF :=[]; // self.business_type set later from corp data
																	 )), acctno,record), BusinessBatch_BIP.Layouts.BestLayoutWithFeinVars);	  																		  
   
	 // output(DS_SeleBestGrouped, named('DS_SeleBestGrouped'));
	  //output(ds_seleBest, named('ds_seleBest'));
	  //output(ds_seleBestSORTEDBYRecordScore, named('ds_seleBestSORTEDBYRecordScore'));
	// output(ds_SeleBestWacctno, named('ds_SeleBestWacctno'));
	// output(DS_SELEBestRecsAcctnoBH, named('DS_SELEBestRecsAcctnoBH'));
  // output(DS_SELEBestRecsAcctnoBHSlim, named('DS_SELEBestRecsAcctnoBHSlim'));
	  //output(ds_SeleBestWacctnoSorted, named('ds_SeleBestWacctnoSorted'));
		//output(ds_parents, named('ds_parents'));
	  //output(ds_seleidBestWithParent, named('ds_seleidBestWithParent'));
	 
		// output(ds_seleidBestWithParent_Sorted, named('ds_seleidBestWithParent_Sorted'));

           // output(ds_seleidbestWithParentDate, named('ds_seleidbestWithParentDate'));    
		//output(ds_initialAcctno, named('ds_initialAcctno'));
	 // output(ds_seleidBestout, named('ds_seleidBestout'));

	// output(inRec, named('inRec'));
	 //output(ds_busHeaderRecsSlim, named('ds_busHeaderRecsSlim'));
	 // output(ds_BHrecsDedup, named('ds_BHrecsDedup'));
	 //output(ds_initialAcctno, named('ds_initialAcctno'));
	 //output(ds_BHrecsDedupWAcctno, named('ds_BHrecsDedupWAcctno'));
	// output(ds_seleBest, named('ds_seleBest'));
	//output(ds_BHrecsCombined, named('ds_BHrecsCombined'));
	 // output(ds_AddrVariationsCount, named('ds_AddrVariationsCount'));
	// output(ds_seleidBestoutSlim, named('ds_seleidBestoutSlim'));
	// output(ds_parentsIds, named('ds_parentsIds'));
	// output(tds_parents, named('tds_parents'));
	// output(ds_parents, named('ds_parents'));
	//output(ds_CnameVarsOut, named('ds_CnameVarsOut'));
	// output(ds_seleBestGroupedFeinDedup, named('ds_seleBestGroupedFeinDedup'));
	// output(ds_seleBestGroupedFeinDedupSlim, named('ds_seleBestGroupedFeinDedupSlim'));
	// output(DS_SeleBestGroupedFeinDedupSmall, named('DS_SeleBestGroupedFeinDedupSmall'));
	//output(ds_seleBestGroupedcnameDedup, named('ds_seleBestGroupedcnameDedup'));
	// output(ds_FeinVarsOut, named('ds_FeinVarsOut'));
	// output(DS_BHRecsWAcctno, named('DS_BHRecsWAcctno'));
	  // DS_BHRecsWAcctno
	// output(DS_SeleBestGrouped, named('DS_SeleBestGrouped'));
	// output(DS_seleBestGroupedAddrDedup, named('DS_seleBestGroupedAddrDedup'));
    // output(CompanyIncorporationDate, named('CompanyIncorporationDate'));
	// output(ds_seleidbestWithParentDate, named('ds_seleidbestWithParentDate'));
	 // output(DS_seleBestGroupedAddrDedupSlim, named('DS_seleBestGroupedAddrDedupSlim'));
	// output(ds_AddressVarsOut, named('ds_AddressVarsOut'));

	// output(ds_CnameVarsOut, named('ds_CnameVarsOut'));
	// output(ds_FeinVarsOut, named('ds_FeinVarsOut'));
	// output(ds_NameAddressVarsOutFinal, named('ds_NameAddressVarsOutFinal'));
	//output(ds_NameAddressFeinVarsOutFinal, named('ds_NameAddressFeinVarsOutFinal'));
	//output(DS_BestNameAddressOutputTmp, named('DS_BestNameAddressOutputTmp'));
	//output(ds_NameAddressVarsOutFinal, named('ds_NameAddressVarsOutFinal'));
	// output(ds_busNameCorporLLC, named('ds_busNameCorporLLC'));
	// output(DS_SeleBestGroupedYrsInBusDedupSmall, named('DS_SeleBestGroupedYrsInBusDedupSmall'));
	// output(ds_YrsInBusOut, named('ds_YrsInBusOut'));  
	// output(ds_YrsInBusinessOutFinal, named('ds_YrsInBusinessOutFinal'));

	 // output(ds_NameAddressFeinVarsOutFinal, named('ds_NameAddressFeinVarsOutFinal'));  
	 
	// output(DS_seleBestGroupedYrsInBusDedup, named('DS_seleBestGroupedYrsInBusDedup'));
	// output(DS_SeleBestGroupedYrsInBusDedupSmall, named('DS_SeleBestGroupedYrsInBusDedupSmall'));
	//output(ds_YrsInBusOut, named('ds_YrsInBusOut'));
	
	// output(DS_seleBestGroupedAddrDedupSlim, named('DS_seleBestGroupedAddrDedupSlim'));
	// output(DS_SeleBestGroupedAddrDedupSmall, named('DS_SeleBestGroupedAddrDedupSmall'));
	 //output(ds_AddressVarsOutStart, named('ds_AddressVarsOutStart'));
	//output(DS_BestNameAddressOutputTmp, named('DS_BestNameAddressOutputTmp'));
	        
   EXPORT DS_BestParentNameAddressOutput := DS_BestNameAddressOutputTmp; 
	END;
END;