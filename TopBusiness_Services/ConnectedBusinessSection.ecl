// ************
// NOTE if timeouts reoccur place to look for improved join limits may be within 
// BIPV2.mac_AddStatus
// ******************
import BIPV2, iesp, BIPV2_Best, autostandardi, ut, BusinessCredit_Services, MDR;
export ConnectedBusinessSection := module

 //per Franz/DAB email 3/28 11:09 AM : Basically SKIP any records with same SELEID 
          //on your relatives key fetch when running a report by SELEID.
					// implemented on line 163 in tmp_con.
					
					
 export fn_fullView (
	dataset(ConnectedBusinessSection_Layouts.rec_Input) ds_in_data,
	ConnectedBusinessSection_Layouts.rec_OptionsLayout in_options,
	AutoStandardI.DataRestrictionI.params in_mod
	) := function

	layout_linkids := record
		BIPV2.IDlayouts.l_xlink_ids linkids1;
		BIPV2.IDlayouts.l_xlink_ids linkids2;
	end;
	 FETCH_LEVEL := in_options.BusinessReportFetchLevel;	
		MaxRelatives := 200;
	 
	ds_recs_kfetch := BIPV2.Key_BH_Relationship_SELEID.kFetch(project(ds_in_data,
								       transform(BIPV2.Key_BH_Relationship_SELEID.l_kFetch_in, 
											     self.seleid := left.seleid)), TopBusiness_Services.Constants.ConnectedBusinessesKfetchMaxLimit												 												 
											 ); 
											 // per bug # : 124853 -- covered within kfetch call now not in this attr.
  ds_recs_kfetchTmp := project(ds_recs_kfetch,transform({unsigned6 seleid1; unsigned6 seleid2;
	                                                       unsigned6 orgid; unsigned6 ultid;},
													self := left));																						
	 
	ds_recs_kfetchSlim := choosen(dedup(ds_recs_kfetchTmp,all),MaxRelatives);
		
	ds_best2_rawProxidZeroDS := project(ds_recs_kfetchSlim,
		                                 transform(BIPV2.IDlayouts.l_xlink_ids,
		                           self.ultid := left.ultid;
															 self.orgid := left.orgid;
															 self.seleid := left.seleid2;
															 self := [])); 
   // proxid = 0 is here as a filter to reduce the # of return results from the BEST key call
	 // it is intentional.
  ds_bip_best := BIPV2_Best.Key_LinkIds.kfetch(ds_best2_rawProxidZeroDS,,,,FALSE,
		                             TopBusiness_Services.Constants.BestKfetchMaxLimitConnectedBusinesses)
		                                 (proxid = 0 AND company_Name[1].company_name <> '');
																		 
	// filtering out the company names[1] coming from restricted experian sources	ER and Q3														 
	ds_SourceQ3_AND_ER_Results_SINGLETONS  :=  ds_bip_best((COUNT(company_name[1].sources) = 1 AND 
	                                  (company_name[1].sources[1].source = MDR.sourceTools.src_EBR OR 
																		company_name[1].sources[1].source = MDR.sourceTools.src_Experian_CRDB)
																		  )
																		OR
																		   (COUNT(company_name[1].sources) = 2 AND 
	                                    (
																		   (company_name[1].sources[1].source = MDR.sourceTools.src_EBR AND 
																		    company_name[1].sources[2].source = MDR.sourceTools.src_Experian_CRDB)
																	      ) 
																			  OR
																			  (
																				 (company_name[1].sources[1].source = MDR.sourceTools.src_Experian_CRDB AND 
																		     company_name[1].sources[2].source = MDR.sourceTools.src_EBR)
																				 )
																			 )
																			 );																																																					
																							
  ds_bestInfo := join(ds_bip_best, ds_SourceQ3_AND_ER_Results_SINGLETONS,
                         BIPV2.IDmacros.mac_JoinTop3Linkids(),
                         TRANSFORM(LEFT), LEFT ONLY);    
												 
	//restricting experian sources if flag set to true	
	ds_best2_rawProxidZeroBest := if(in_options.restrictexperian,ds_bestInfo,ds_bip_best);
																							
	ds_best2_rawProxidZero := project( choosen(ds_best2_rawProxidZeroBest,MaxRelatives),
	                               transform( {string120 companyName; 															
																iesp.share.t_address companyAddress; 
																iesp.share.t_businessIdentity businessIds; 
																string12 businessId;string9 tin; string2 TinSource},																         																				
																
																  self.CompanyName := left.company_name[1].company_name;												
												  self.companyaddress.StreetName := 
												           left.company_address[1].company_prim_name;
												  self.companyaddress.StreetNumber :=
																	 left.company_address[1].company_prim_range,
												   self.companyaddress.StreetPredirection :=
																	 left.company_address[1].company_predir,
													 self.companyAddress.StreetPostdirection :=
																	 left.company_address[1].company_postdir,
													self.companyAddress.StreetSuffix := 
																	 left.Company_address[1].company_addr_suffix,
													self.companyAddress.UnitDesignation :=
																	  left.company_address[1].company_unit_desig,
													self.companyAddress.UnitNumber :=
																	   left.company_address[1].company_sec_range,
													self.companyAddress.City := 
																	   left.company_address[1].address_v_city_name,
												  self.companyAddress.State :=
																	   left.company_address[1].company_st,
													self.companyAddress.zip5 :=
																	   left.company_address[1].company_zip5,
													self.companyAddress.zip4 := 
																	   left.company_address[1].company_zip4,
													self.companyAddress.County := 
																		left.company_address[1].county_name; 
                          self.companyaddress.streetAddress1 := '';
													self.companyAddress.StreetAddress2 := '';
													self.companyAddress.postalcode := '';
													self.companyAddress.statecityzip := '';
													
                         self.businessIDs.ultid := left.ultid;
												 self.businessIDs.orgid := left.orgid;
												 self.businessIDs.seleid :=  left.seleid;
												 self.businessIDs.proxid := left.proxid;
												 self.businessIDs.powid := left.powid;
												 self.businessIDs.empid :=  left.empid;
												 self.businessIDs.dotid := left.dotid;												 
												 // set the bdid value.
												 self.BusinessID := (string12) left.company_bdid;		
												 self.Tin := left.company_fein[1].company_fein;
												 self.TinSource := project(left.company_fein[1].sources, transform({string2 source;},
			                   self.source := left.source))[1].source; 
											  ));																								                                   																								
																							 
   // add back in the proxid1 (same as input linkids) to the results from best;
	 // so that later can add backin the account number to the section.
	 
	 	ds_recs := project( ds_recs_kfetchSlim, 
								 transform(layout_linkids,
								 self.linkids1.ultid := left.seleid1;
								 self.linkids1.orgid := left.seleid1;
								 self.linkids1.seleid := left.seleid1;
								 //self.linkids1.proxid := left.seleid1;
								 
								 self.linkids2.ultid := left.seleid2;
								 self.linkids2.orgid := left.seleid2;
								 self.linkids2.seleid := left.seleid2;
								 //self.linkids2.proxid := left.seleid2;
								 self := [];
								 )); //(fein_score > 10 and charter_score > 10 and namest_score > 10);
	 
	 ds_best2_rawWithInputLinkids := join(ds_recs, ds_best2_rawPROXIDZERO,
	                           left.linkids2.ultid = right.businessIds.ultid AND
														 left.linkids2.orgid = right.businessIDs.orgid AND
														 left.linkids2.seleid = right.businessIDs.seleid,
														 //left.linkids2.proxid = right.proxid,
														 transform({unsigned6 in_ultid; unsigned6 in_orgid; unsigned6 in_seleid;
														            recordof(right);},
														 self.in_ultid := left.linkids1.ultid,
														 self.in_orgid := left.linkids1.orgid,
														 self.in_seleid := left.linkids1.seleid,
														 //self.in_proxid := left.linkids1.proxid,
														 self := right,
														 self := [];
														 ), left outer); 
	
	// do the filter here:
	// take out recs that have In_seleid the same as right seleid because relationship key
	// is built at proxid to proxid level match and if we have similar seleid's then
	// that means both sides in the relationship already are in the same 'seleid' family.
	// so to speak.
	//
	tmp_con := ds_best2_rawWithInputLinkids(in_seleid <> businessids.seleid);
	ds_best2_rawWithInputLinkids_slim := dedup(tmp_con,all);
	 
	 ds_recs_busRelatives := project(ds_best2_rawWithInputLinkids_slim,
	    // this layout contains the in_ultid, in_orid, in_seleid, in_proxid
	    transform(TopBusiness_Services.ConnectedBusinessSection_Layouts.rec_linkids_plus_ConnectedBusinessRecord,					  							
				self.companyName := left.companyName;// left.company_name[1].company_name;

				self.address.StreetNumber := left.companyAddress.StreetNumber; // := left.company_address[1].company_prim_range,
				self.Address.StreetPreDirection := left.companyaddress.streetPredirection; //left.company_address[1].company_predir,
				self.Address.StreetName := left.companyaddress.StreetName; //left.company_address[1].company_prim_name,
				self.Address.StreetSuffix := left.companyaddress.StreetSuffix; //left.company_address[1].company_addr_suffix,
				self.Address.StreetPostDirection := left.companyaddress.StreetPostdirection;  //left.company_address[1].company_postdir,
				self.Address.UnitDesignation := left.companyaddress.unitDesignation; //.company_address[1].company_unit_desig,
				self.Address.UnitNumber := left.companyaddress.UnitNumber; //left.company_address[1].company_sec_range,
				self.Address.City := left.companyaddress.city; //left.company_address[1].address_v_city_name,
				self.Address.State := left.companyaddress.state; //left.company_address[1].company_st,
			
				self.Address.ZIP5 := left.companyaddress.zip5; //left.company_address[1].company_zip5,
				self.Address.Zip4 := left.companyaddress.zip4; //left.company_address[1].company_zip4,			
			
				self.Address.County := left.companyaddress.county; //left.company_address[1].county_name; 
			          	 
          self.address.streetAddress1 :=  '';
				  self.address.streetAddress2 := '';
					self.address.postalcode := '';
					self.address.statecityzip := '';
					self.businessIds.ultid := left.businessids.ultid;
					self.businessIds.orgid := left.businessIDs.orgid;
					self.businessIds.seleid := left.businessIDs.seleid;					
					self.businessIds.proxid := 0;
					self.businessIds.powid := 0;
					self.businessIds.empid := 0;
					self.businessIDs.dotid := 0;
				  self.tin := left.tin;
	        self.tinSource := left.tinSource;	     
					self := left; // this catches the in_ultid, in_orgid...etc.
					self := [];
        ))(companyName <> '');						
	
   // removed the 'execept fields' based on possibly what is needed for bug 143472.
   ds_recs_busRelatives_dedup := dedup(ds_recs_busRelatives, all); 
																																		 
    // Sort/Group/Rollup all recs for each set of linkids.
  TopBusiness_Services.ConnectedBusinessSection_Layouts.rec_linkidsIntermediate rollup_rptdetail(
	  TopBusiness_Services.ConnectedBusinessSection_Layouts.rec_linkids_plus_ConnectedBusinessRecord l,
	  dataset(TopBusiness_Services.ConnectedBusinessSection_Layouts.rec_linkids_plus_ConnectedBusinessRecord) allrows) := transform    
		  self.acctno := '';
			self.TotalCountConnectedBusinesses := count(allrows);
			self.CountConnectedBusinesses := if ( count(allrows) >
															 iesp.constants.TopBusiness.MAX_COUNT_CONNECTED_BUSINESSES,
															      iesp.constants.TopBusiness.MAX_COUNT_CONNECTED_BUSINESSES,
																		count(allrows) ); 
		  self.ConnectedBusinessRecords := choosen(project(allrows,
		                                   transform(iesp.topbusinessReport.t_TopBusinessConnectedBusiness, 
																					self := left)),
															 iesp.constants.TOPBUSINESS.MAX_COUNT_CONNECTED_BUSINESSES);
		  self := l; // to preserve all linkids; for later join.		
	end;

  ds_all_rptdetail_grouped := group(sort(ds_recs_busRelatives_dedup,
																				 in_ultid,in_orgid,in_seleid,																		
																				 companyName,
																				 record),	                                
																	  in_ultid,in_orgid,in_seleid															
																		);
	
  ds_all_rptdetail_rolled := rollup(ds_all_rptdetail_grouped,
																    group,
																    rollup_rptdetail(left,rows(left)));

  // Attach input acctnos back to the linkids
  ds_all_wacctno_joined := join(ds_in_data,ds_all_rptdetail_rolled,
	                                  // removed these two join criteria since input ult/org
																		// is sometimes different than resulting ult/org
                                    // left.ultid = right.in_ultid and
																		// left.orgid = right.in_orgid and
																		left.seleid = right.in_seleid,
																		//left.proxid = right.in_proxid,
														    transform(TopBusiness_Services.ConnectedBusinessSection_Layouts.rec_linkidsIntermediate,
														      self.acctno := left.acctno,																	
															    self := right),
														    left outer); // 1 out rec for every left (input ds) rec
	
   ds_final_results := project(ds_all_wacctno_joined,transform(TopBusiness_Services.ConnectedBusinessSection_Layouts.rec_Final,	                                 
																		self := left));
   // output(ds_in_data, named('ds_in_data'));     	   		
	 // output(choosen(ds_recs_kfetchTmp, 100), named('ds_recs_kfetch'));	 
	  // output(count(ds_recs_kfetch), named('count_ds_recs_kfetch_count'));
		// output(count(ds_recs_kfetchTmp), named('count_ds_recs_kfetchTmp'));
		 // output(count(ds_recs_kfetchSlim), named('count_ds_recs_kfetchSlim'));
	 // output(choosen(ds_recs_kfetch,200), named('ds_recs_kfetch'));    
		// output(count(ds_best2_raw), named('count_ds_best2_raw'));
		  //output(choosen(ds_best2_Raw,2000), named('ds_best2_Raw'));	
	   // output(count(ds_best2_rawProxidZero), named('count_ds_best2_rawProxidZero'));
			 // output(choosen(ds_best2_rawProxidZero, 1000), named('ds_best2_rawProxidZero'));
    // output(choosen(ds_recs,200), named('ds_recs'));
  // output(ds_best2_rawProxidZeroNEW, named('ds_best2_rawProxidZeroNEW'));
	// output(ds_best2_rawProxidZero, named('ds_best2_rawProxidZero'));
	 //output(ds_best2_rawWithInputLinkids, named('ds_best2_rawWithInputLinkids'));
	 // output(choosen(ds_best2_rawwithInputLinkids,100), named('ds_best2_rawwithInputLinkids'));
	 // output(choosen(ds_best2_rawWithInputLinkids_slim,100), named('ds_best2_rawWithInputLinkids_slim'));	
	 // output(tmp_con, named('tmp_con'));
	   // output(count(ds_recs_busRelatives), named('count_ds_recs_busRelatives'));
	   // output(count(ds_recs_busRelatives_dedup), named('count_ds_recs_busRelatives_dedup'));
	 // output(ds_all_rptdetail_rolled, named('ds_all_rptdetail_rolled'));
	 // output(ds_all_wacctno_joined, named('ds_all_wacctno_joined'));
	 // output(FETCH_LEVEL, named('FETCH_LEVEL'));
	// output(ds_final_results, named('ds_final_results'));
	 							 
   return(ds_final_results);							 
				
	 end; // function
	 
end; // module