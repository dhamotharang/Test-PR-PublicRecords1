Import BIPV2,AutoStandardI,TopBusiness_Services,MDR,STD;
EXPORT fn_BIPLookup( dataset(BIPV2.IDfunctions.rec_SearchInput) ds_Format2SearchInput,
												AutoStandardI.DataRestrictionI.params in_mod2   
											) := FUNCTION
	

	ds_Format2SearchInput_Hsort := project(ds_Format2SearchInput,
																		 transform(BIPV2.IDfunctions.rec_SearchInput,
                                   self.hsort := true,
	                                 self := left )) ;
	
	ds_InfoProxIdNonRestrictedWithD := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(ds_Format2SearchInput_Hsort).data2_;
	ds_InfoProxIdNonRestricted := ds_InfoProxIdNonRestrictedWithD(source <> MDR.SourceTools.src_Dunn_Bradstreet);
   	
	TopBusiness_Services.functions.MAC_IsRestricted(ds_InfoProxIdNonRestricted,
																 ds_ProxIdRestricted, 															
																 source, // field name
																 vl_id, // field name
																 in_mod2, 
																 false, //in_options.lnBranded, 															 
																 false, // //in_options.internal_testing, default to false for internal_testing
																 dt_first_seen // this is field name only no value
															 );
		 																							   
	topResults := dedup(sort(ds_ProxIdRestricted,ultid, orgid, seleid, proxid,powid,-proxweight,-record_score,-dt_last_seen,record),
															ultid, orgid, seleid, proxid,powid);
 
		
  status_coded := bipv2.key_bh_linking_ids.kFetch2(project(topResults,transform(BIPV2.IDlayouts.l_xlink_ids2,self := left)),
																												BIPV2.IDconstants.Fetch_Level_PowID, //The lowest level you'd like to pay attention to.
																												0, //ScoreThreshold
																												PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt),
																												5, //JoinLimit
																												true, //dnbFullRemove
																												); 						 
	
  topResults_with_status := 
														join(topResults,status_coded, 
															 left.ultid = right.ultid and 
															 left.orgid = right.orgid and  
															 left.seleid = right.seleid and  
															 left.proxid = right.proxid and 
															 left.powid = right.powid,
															 transform(UPS_Services.layouts.RecBipRecordOut2, 
																					self := left , self := right),
															 left outer, keep(1),limit(0));
	
  //sort by -proxweight to bubble top score within a proxid group to the top again.
  tmpTopResultsScored := project(sort(topResults_with_status,-proxweight,-record_score, -dt_last_seen), UPS_Services.layouts.RecBipRecordOut2); 
	
	return tmpTopResultsScored;
	end;