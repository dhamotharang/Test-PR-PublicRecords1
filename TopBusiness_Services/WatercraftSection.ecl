/* TBD: 
   1. Remove commented out BIP1 sample coding.
   2. Research/resolve open issues, search on "???"
*/
IMPORT AutoStandardI, BIPV2, iesp, MDR, Watercraft;

EXPORT WatercraftSection := MODULE;

 // *********** Main function to return BIPV2 format business report results
 export fn_FullView(
   dataset(TopBusiness_Services.Layouts.rec_input_ids) ds_in_ids
	 ,TopBusiness_Services.Layouts.rec_input_options in_options
	 ,AutoStandardI.DataRestrictionI.params in_mod
   ,unsigned2 in_sourceDocMaxCount = iesp.Constants.TopBusiness.MAX_COUNT_BIZRPT_SRCDOC_RECORDS
                   ):= function 
  	
	FETCH_LEVEL := in_options.BusinessReportFetchLevel;

  // Strip off the input acctno from each record, will re-attach them later.
	ds_in_unique_ids_only := project(ds_in_ids,transform(BIPV2.IDlayouts.l_xlink_ids,
	                                                       self := left,
																							           self := []));


  // ****** Get watercraft info for each set of input linkids
  //
  // *** Key fetch to get watercraft key linking data from BIP2 linkids key file.
  ds_linkids_keyrecs := TopBusiness_Services.Key_Fetches(
	                         ds_in_unique_ids_only, // input file to join key with
											     FETCH_LEVEL).ds_wc_linkidskey_recs;

  // Project linkids key data being used onto a slimmed layout. 
  ds_linkids_keyrecs_slimmed := project(ds_linkids_keyrecs,
		  transform(TopBusiness_Services.WatercraftSection_Layouts.rec_ids_with_linkidsdata_slimmed,
				self.source          := MDR.sourceTools.fWatercraft(left.source_code,left.state_origin),
				self.source_docid    := left.state_origin         + '//' + // wid&sid keys uses this
				                        trim(left.watercraft_key) + '//' + // wid&sid keys uses this
																trim(left.sequence_key),           // wid&sid keys uses this
				//self.source_recid := left.source_rec_id; //???
			  self               := left, // to preserve ids & other key fields being kept???
			));

  // Sort/dedup by linkids & all 3 watercraft key fields to only keep the 1 record with the 
	// latest(highest) sequence_key (same as registration_date) for each set of linkids/watercraft_key.
  ds_linkids_keyrecs_deduped := dedup(sort(ds_linkids_keyrecs_slimmed,
				                                   #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			     state_origin, watercraft_key, -sequence_key),
   			 // may need to chg for alphas in sequence_key (see ids=????? ---^  ???
				                              #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																      state_origin, watercraft_key);
 

  // Next join to get the watercraft registration & vessel info data needed to 
	// output on the report from the existing watercraft "wid" (main) key.
	ds_wcmain_keyrecs := join(ds_linkids_keyrecs_deduped,
														Watercraft.key_watercraft_wid(),
		                        keyed(left.state_origin   = right.state_origin and
									                left.watercraft_key = right.watercraft_key and
												          left.sequence_key   = right.sequence_key),
									          transform(TopBusiness_Services.WatercraftSection_Layouts.rec_parent_wcdetail, 
												      self.current_prior   := if(right.history_flag='',Constants.CURRENT,Constants.PRIOR),
															self.NonDMVSource 	 := left.source in MDR.sourcetools.set_Infutor_Watercraft;
															self.prior_parties   := [];
															self.current_parties := [];
													    self := right, // to keep the main wid key fields we want
	 		                                       // (which have the same name on the temp layout as on the main key)
			                        self := left, // to preserve ids & other linkids key fields being kept
                            ),
								          	inner, // OR left outer, //???
		                        //keep(Constants.watercraft_max_???_recs), // ??? recs ???
                            limit(10000, skip) // change to use Constants.???.LIMIT
									         );

  // Sort/dedup main recs by linkids, state_origin & hull_number and latest(highest) sequence_number
	// to only keep 1 record (1 state_origin/watercraft_key/sequence_key combo) per hull_number 
	// for each set of linkids.
  ds_wcmain_keyrecs_deduped := dedup(sort(ds_wcmain_keyrecs,
				                                  #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			    state_origin, 
																					hull_number,
																					//watercraft_key, //??? not needed, some hull#s have dierent watercraft_key values???
																					-sequence_key // to sort highest/latest one first???
																					//,-exp_date  //???
																					//, -model_year //???
                                         ),
				                             #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																     state_origin, 
																		 hull_number
																		);


	// Count the number of total current & prior watercrafts(hull#s) for each set of linkids.
  //
  // First sort/dedup on just the fields to be tabled/counted: top 3 linkids & current_prior.
  ds_wcmain_keyrecs_deduped2 := dedup(sort(//ds_wcmain_keyrecs, //vers1??? use this one OR this ---v ???
	                                         ds_wcmain_keyrecs_deduped, //ver2??? use this  one???
				                                   #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			     current_prior, 
																					 state_origin, watercraft_key
																					 //, xxx???
																					 ),
				                              #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																      current_prior, 
																      state_origin, watercraft_key);
	
	ds_wcmain_keyrecs_tabled := table(//ds_wcmain_keyrecs_deduped, //vers1???
	                                  ds_wcmain_keyrecs_deduped2, //vers2???
	                                   // Create table layout on the fly
                                     {#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																      current_prior,
																		  cp_count := count(group)
																	   },
	                                 #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																   current_prior,
																   few); //???

  // Join count of the number of wcs per current_prior for the linkids back to the deduped & 
	// wc main key recs to attach the total counts for the linkids to all records.
	ds_wcmain_keyrecs_all_counts := join(//ds_wcmain_keyrecs, //??? OR ---v ???
	                                     //ds_wcmain_keyrecs_deduped, //???,
																			 ds_wcmain_keyrecs_deduped2, //???,
																			 ds_wcmain_keyrecs_tabled,
																         BIPV2.IDmacros.mac_JoinTop3Linkids() and
																         left.current_prior = right.current_prior,
																		   transform(TopBusiness_Services.WatercraftSection_Layouts.rec_parent_wcdetail,
																		     self.total_current := if(left.current_prior=Constants.CURRENT,right.cp_count,0);
																		     self.total_prior   := if(left.current_prior=Constants.PRIOR,right.cp_count,0);
																			   self := left),
																		   inner, //??? or left outer??? should be many to 1 match so inner should be OK???
																		   keep(1)  //from bip1, why 1 ???
																		   //limit(10000) //???
																		  );


  // Since current/prior total counts have been determined; now chop the total # of WC 
	// records per set of linkids here to just the most recent 100 (50 current and  
	// 50 prior) records for each set of linkids (req 1090).
	//
  // First, sort/dedup main keyrecs with cp counts by: linkids & descending registration_date
	// to keep the 50 most recent current & 50 most recent prior recs.
  ds_wcmain_keyrecs_top100_cp := dedup(sort(ds_wcmain_keyrecs_all_counts,
                                            #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																		        current_prior,
																					  -registration_date), // AND/OR sequence_key???
		                                   #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																		   current_prior,
																			 keep(iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_WATERCRAFT_MAIN_RECORDS)
																			);

  // Second, join all the main recs (with counts) to the ds with the top 100 current/prior
	// to only keep the main recs for the top 100 Watercrafts per set of linkids.
  ds_wcmain_keyrecs_tobe_used := join(ds_wcmain_keyrecs_all_counts,
		                                  ds_wcmain_keyrecs_top100_cp,
																         BIPV2.IDmacros.mac_JoinTop3Linkids() and
																			   left.state_origin   = right.state_origin and
									                       left.watercraft_key = right.watercraft_key
												                 // and left.sequence_key = right.sequence_key // should not be needed???
																				 ,
																		inner //only left recs that are found in the right ds??? 
																		//,keep         //??? OR ---v 
																		//,limit(10000) //???
																	 );


/* from bip1, no longer needed  ???
  ...
  // Sort/dedup current & prior together to only keep the 1 most recent record 
	// (either current if it exists or prior if no current exists) for each hull_number
  // AND/OR watercraft_key  ???
  current_prior_comb_deduped := dedup(sort(mainrecs,
	                                         bid, 
                                           watercraft_id, -registration_date, record),
	                                    bid, 
                                      watercraft_id);
	
	// Dedup to get only the unique hull number and registration date combinations
	unique_hn_regdate_combo := dedup(current_prior_comb_deduped,watercraft_id,registration_date,all);
	// Dedup to get only the unique hull number and registration date combinations
	unique_hn_regdate_combo := dedup(current_prior_comb_deduped,watercraft_id,registration_date,all);
	
	// Normalize to get all search paths
	normalized_hn_regdate_combo := normalize(unique_hn_regdate_combo,2,
		transform({unique_hn_regdate_combo.watercraft_id; 
		           unique_hn_regdate_combo.registration_date;
							 string1 current_prior;},
			self.watercraft_id     := left.watercraft_id,
			self.registration_date := choose(counter,left.registration_date,''),
			self.current_prior     := choose(counter,'',TopBusiness.Constants.CURRENT)));

  // Get the current & prior party key rec(s) associated with the watercrafts
	partyrecs := join(normalized_hn_regdate_combo,TopBusiness.Keys().Watercraft.party.QA,
		keyed(left.watercraft_id = right.watercraft_id) and
		keyed(left.registration_date = '' or left.registration_date = right.registration_date) and
		keyed(left.current_prior = '' or left.current_prior = right.current_prior),
		transform(right),
		keep(Constants.watercraft_max_current_recs)); // 100 parties ???
*/ 


  // Next join to get the party (owner/registrant) info associated with the current & prior 
	// watercrafts, from the existing watercraft "sid" (party) key.
	ds_wcparty_keyrecs := join(ds_wcmain_keyrecs_tobe_used,
	                           Watercraft.key_watercraft_sid(),
		                         keyed(left.state_origin   = right.state_origin   and
									                 left.watercraft_key = right.watercraft_key and
																	 left.sequence_key   = right.sequence_key)
														 ,
									           transform(TopBusiness_Services.WatercraftSection_Layouts.rec_child_party,
															 // Since linkids for the party were added to the party key layout, 
                               // fill in the "report-by" linkids from the left dataset. 
															 // Create a new macro for this(---v)??? Something like TopBusiness_Services.IDMacros. mac_IespTransferLinkids
                               self.ultid  := left.ultid,
                               self.orgid  := left.orgid,
                               self.seleid := left.seleid,
                               self.proxid := left.proxid, //???
                               self.powid  := left.powid,  //???
                               self.empid  := left.empid,  //???
                               self.dotid  := left.dotid,  //???
															 // Store certain fields from the right(party key)
        							         self.current_prior_party := if(right.history_flag='',  //???
															                                Constants.CURRENT,Constants.PRIOR),
                               self.city_name := right.v_city_name;
															 self := right, // to keep the party sid key fields we want
	 		                                        // (which have the same name on the temp layout as on the main key)
			                         self := left, // to preserve other main key fields being kept
                            ),
								          	inner, // OR left outer, //???
		                        //keep(Constants.watercraft_max_???_recs), // ??? recs ???
                            limit(10000,skip) // change to use Constants.???.LIMIT
									         );

	// Might have duplicated parties, so dedup just in case.
	// Might need some more "tweaking" ---v ???
	ds_wcparty_keyrecs_deduped := dedup(sort(ds_wcparty_keyrecs,
				                                    #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			      state_origin,watercraft_key,
		                                        orig_name_type_description,
																						company_name,
                                            fname,mname,lname,
																						//other fields???, address?, current_prior? 
																						-sequence_key //???
																						),
				                               #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			 state_origin,watercraft_key, //sequence_key,??? 
		                                   orig_name_type_description,
																			 company_name,
                                       fname,mname,lname
																			 //other fields???, address?, current_prior? 
																			 ); 


  // Now that we got all the data, pull it all together onto an interim parent/child layout.
	//
  // Denormalize to attach child(party) recs to their associated parent(main) recs.
  TopBusiness_Services.WatercraftSection_Layouts.rec_parent_wcdetail tf_denorm_parties(
	  TopBusiness_Services.WatercraftSection_Layouts.rec_parent_wcdetail L,
		dataset(TopBusiness_Services.WatercraftSection_Layouts.rec_child_party) R)	:= transform
		  self.current_parties := choosen(R(current_prior_party=Constants.CURRENT),
																			iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_WATERCRAFT_PARTY_RECORDS);
		  self.prior_parties   := choosen(R(current_prior_party=Constants.PRIOR),
																			iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_WATERCRAFT_PARTY_RECORDS);
		  self                 := L;
	end;

  ds_parent_child := denormalize(ds_wcmain_keyrecs_tobe_used,
																 ds_wcparty_keyrecs_deduped,
																	 left.state_origin   = right.state_origin   and
																	 left.watercraft_key = right.watercraft_key 
																 ,
		                             group,
		                             tf_denorm_parties(left,rows(right)));


  // Transforms for the iesp Watercraft Section related layouts
  //
  // transform to handle the "Parties" child dataset
	iesp.TopbusinessReport.t_TopbusinessWatercraftParty 
	  tf_party_child(TopBusiness_Services.WatercraftSection_Layouts.rec_child_party l) := transform
    self.PartyTypeDescription        := l.orig_name_type_description,
    self.CompanyName                 := l.company_name,	
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
		self.Address.StreetSuffix        := l.suffix,
		self.Address.UnitDesignation     := l.unit_desig,
		self.Address.UnitNumber          := l.sec_range,
		self.Address.City                := l.city_name,
		self.Address.State               := l.st,
		self.Address.Zip5                := l.zip5,
		self.Address.Zip4                := l.zip4,
    self.Address.StreetAddress1      := '',
    self.Address.StreetAddress2      := '',
    self.Address.County              := '',
    self.Address.PostalCode          := '',
    self.Address.StateCityZip        := '',
	end;

  // transform to store data in the iesp report detail parent fields
	TopBusiness_Services.WatercraftSection_Layouts.rec_ids_plus_WatercraftDetail
	  tf_detail_parent(TopBusiness_Services.WatercraftSection_Layouts.rec_parent_wcdetail l) := transform
		self.current_prior      := l.current_prior,
	  self.StateJurisdiction  := l.st_registration,
	  self.HullNumber         := l.hull_number,
	  self.ModelYear          := (integer2) l.model_year,
	  self.VesselMake         := l.watercraft_make_description,
    self.VesselModel        := l.watercraft_model_description,
	  self.Propulsion         := l.propulsion_description,
	  self.Length             := l.watercraft_length,
	  self.Use                := l.use_description,
	  self.VesselName         := l.watercraft_name,
	  self.RegistrationStatus := l.registration_status_description,
	  self.RegistrationNumber := l.registration_number,
		self.RegistrationDate   := iesp.ECL2ESP.toDate ((integer)l.registration_date),
		self.NonDMVSource				:= l.NonDMVSource;
		// fix expiration dates missing dd or mmdd // done in bip1, is this still an issue???
    integer1 length_exp_date := length(trim(l.registration_expiration_date,left,right));
		temp_exp_date            := map(length_exp_date = 6 => l.registration_expiration_date[1..6]+'00',
		                                length_exp_date = 4 => l.registration_expiration_date[1..4]+'0000',
		                                l.registration_expiration_date); 
	  self.ExpirationDate     := iesp.ECL2ESP.toDate ((integer) temp_exp_date),
    self.PriorParties       := choosen(project(l.prior_parties,tf_party_child(left)), 
		                                   iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_WATERCRAFT_PARTY_RECORDS),
    self.CurrentParties     := choosen(project(l.current_parties,tf_party_child(left)),
		                                   iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_WATERCRAFT_PARTY_RECORDS),
		self.SourceDocs := []; //can be empty dataset because detailed sourcedoc info not needed at this level
		self := l; // to assign all linkids
		self := []; // in case any new/extra fields added to the iesp layout, like done for bug 157976
	end;

  // project recs into report record detail iesp layout plus ids  
  ds_recs_rptdetail := project(ds_parent_child,tf_detail_parent(left));


  // transform to handle iesp SourceDocs structure
	iesp.topbusiness_share.t_TopBusinessSourceDocInfo
	  tf_sourcedoc(TopBusiness_Services.WatercraftSection_Layouts.rec_ids_plus_WatercraftDetail L) := transform
		   self.BusinessIds := l, // to store all linkids
       //self.IdType      := Constants.watercraftkeys,  //vers1???
		   //self.IdValue     := l.source_docid,            //vers1???
		   self.Section     := Constants.WatercraftSectionName, // vers1 & 2???
		   //self.Source      := l.source,                  //vers1???
		   self := []  //null out other fields
	end;

  // sort/group/rollup all current & prior watercraft recs for a set of linkids
  TopBusiness_Services.WatercraftSection_Layouts.rec_ids_plus_WatercraftRecord tf_rollup_rptdetail(
	  TopBusiness_Services.WatercraftSection_Layouts.rec_ids_plus_WatercraftDetail l,   
	  dataset(TopBusiness_Services.WatercraftSection_Layouts.rec_ids_plus_WatercraftDetail) allrows) := transform
      self.acctno := '';		// will be assigned below
		  self.CurrentRecordCount      := count(allrows(current_prior=Constants.CURRENT));
      // Grab total_current count from the first row of the input dataset that is for a 
			// "current" watercraft.
			self.TotalCurrentRecordCount := allrows(current_prior=Constants.CURRENT)[1].total_current,
      self.CurrentWatercrafts := choosen(project(allrows(current_prior=Constants.CURRENT),
		                                             transform(iesp.TopbusinessReport.t_TopbusinessWatercraftDetail, 
				  										                     self := left)), 
																         iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_WATERCRAFT_MAIN_RECORDS);
			self.CurrentSourceDocs := if(self.CurrentRecordCount > 0,
                                   choosen(project(allrows(current_prior=Constants.CURRENT),
															                     tf_sourcedoc(left)),
								                           //in_sourceDocMaxCount  // needed for Business Credit Report changes
																					 1 // vers2??? only need 1 sourcedoc rec now???
																					)
																  );

			self.PriorRecordCount      := count(allrows(current_prior=Constants.PRIOR));
      // Grab total_prior count from the first row of the input dataset that is for a 
			// "prior" watercraft.
			self.TotalPriorRecordCount :=allrows(current_prior=Constants.PRIOR)[1].total_prior,
		  self.PriorWatercrafts  := choosen(project(allrows(current_prior=Constants.PRIOR),
		                                            transform(iesp.TopbusinessReport.t_TopbusinessWatercraftDetail, 
														                      self := left)), 
																        iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_WATERCRAFT_MAIN_RECORDS),
			self.PriorSourceDocs   := if(self.PriorRecordCount > 0,
                                   choosen(project(allrows(current_prior=Constants.PRIOR),
															                     tf_sourcedoc(left)),
								                           //in_sourceDocMaxCount // needed for Business Credit report changes
																					 1 // vers2??? only need 1 sourcedoc rec now???
																					)
																	);

		  self := l; // to assign all linkids
	end;

  ds_all_rptdetail_grouped := group(sort(ds_recs_rptdetail,
				                                 #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																				 current_prior, -RegistrationDate, HullNumber, record),  //order???
                                    #expand(BIPV2.IDmacros.mac_ListTop3Linkids())
																   );
	
  ds_all_rptdetail_rolled := rollup(ds_all_rptdetail_grouped,
																    group,
																    tf_rollup_rptdetail(left,rows(left)));

  // Attach input acctnos back to the bdids
  ds_all_wacctno_joined := join(ds_in_ids,ds_all_rptdetail_rolled,
															    BIPV2.IDmacros.mac_JoinTop3Linkids(),
														    transform(TopBusiness_Services.WatercraftSection_Layouts.rec_ids_plus_WatercraftRecord,
														      self.acctno := left.acctno,
															    self        := right),
														    left outer); // 1 out rec for every left rec

	// Roll up all recs for the acctno
	ds_final_results := rollup(group(sort(ds_all_wacctno_joined,acctno),
	                                 acctno),
	                           group,
		                         transform(TopBusiness_Services.WatercraftSection_Layouts.rec_final,
                               self.acctno                := left.acctno,
		                           self.WatercraftRecordCount := left.CurrentRecordCount + 
									                                           left.PriorRecordCount,
		                           self.TotalWatercraftRecordCount := left.TotalCurrentRecordCount + 
									                                                left.TotalPriorRecordCount,
			                         self.WatercraftRecords     := left)
														);

  // Uncomment for debugging
  // output(ds_in_ids,                    named('ds_in_ids'));
	// output(ds_in_unique_ids_only,        named('ds_in_unique_ids_only'));
  // output(ds_linkids_keyrecs,           named('ds_linkids_keyrecs'));
  // output(ds_linkids_keyrecs_slimmed,   named('ds_linkids_keyrecs_slimmed'));
  // output(ds_linkids_keyrecs_deduped,   named('ds_linkids_keyrecs_deduped'));

  // output(ds_wcmain_keyrecs,            named('ds_wcmain_keyrecs'));
  // output(ds_wcmain_keyrecs_deduped,    named('ds_wcmain_keyrecs_deduped'));
  // output(ds_wcmain_keyrecs_deduped2,   named('ds_wcmain_keyrecs_deduped2'));
  // output(ds_wcmain_keyrecs_tabled,     named('ds_wcmain_keyrecs_tabled'));
  // output(ds_wcmain_keyrecs_all_counts, named('ds_wcmain_keyrecs_all_counts'));
  // output(ds_wcmain_keyrecs_top100_cp,  named('ds_wcmain_keyrecs_top100_cp'));
  // output(ds_wcmain_keyrecs_tobe_used,  named('ds_wcmain_keyrecs_tobe_used'));

  // output(ds_wcparty_keyrecs,           named('ds_wcparty_keyrecs'));
  // output(ds_wcparty_keyrecs_deduped,   named('ds_wcparty_keyrecs_deduped'));

  // output(ds_parent_child,              named('ds_parent_child'));
  // output(ds_recs_rptdetail,            named('ds_recs_rptdetail'));
  // output(ds_all_rptdetail_grouped,     named('ds_all_rptdetail_grouped'));
  // output(ds_all_rptdetail_rolled,      named('ds_all_rptdetail_rolled'));
  // output(ds_all_wacctno_joined,        named('ds_all_wacctno_joined'));
	// output(ds_final_results,             named('ds_final_results'));

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
		export unsigned1 DPPAPurpose := 1 : stored('DPPAPurpose'); <---------------- !!!
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
waterc_sec := TopBusiness_Services.WatercraftSection.fn_FullView(
             dataset([
						          //{'test1d', 0, 0, 0, 1142, 1142, 1142, 1142} // 1 wc_key & 1 seq_key, 1 prior
						          //{'test2d', 0, 0, 0, 2431, 2431, 2431, 2431} // 1 wc_key & 7 seq_keys, 1 current
						          //{'test3d', 0, 0, 0, 256132, 256132, 256132, 256132} // 2 wc_key & 2 seq_keys, 2 prior
						          //{'test4d', 0, 0, 0, 300176 ,300176, 300176, 300176} // 2 wc_key & 4 seq_keys, 2 current
						          //{'test5p', 0, 0, 0, 686, 686, 686, 686} // 1 wc_key & 1 seq_key, 1 prior
						          //{'test6p', 0, 0, 0, 261, 261, 261, 261} // 1 wc_key & 3 seq_key, 1 prior
						          //{'test7p', 0, 0, 0, 0, 104247368, 22840, 22840} // bug 133469, 5 linkids recs, 1 seleid/2 proxids, 2 wc_key
                      //{'test8p', 0, 0, 0, 0, 76249693, 76249693, 76249693} // bug 141640, Jesco Constr Corp, 10 linkids recs, 5 wc_keys but only 3 unique hull#s
						          //{'testx', 0, 0, 0, ???, ?????, ?????, ?????} // ? wc_key & 6 seq_keys, 1 current & 2 prior???
                  ],topbusiness_services.Layouts.rec_input_ids)
						,ds_options[1]
					  ,tempmod
            );
output(waterc_sec);
// */
