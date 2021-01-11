IMPORT BIPV2, BankruptcyV3, DeathV2_Services, doxie, LiensV2,TopBusiness_Services, iesp, LN_PropertyV2, MDR, 
       dx_Property, Suppress, UCCV2, UCCV2_Services, VehicleV2, Watercraft, Foreclosure_Services;


EXPORT AssociateSection := MODULE;

 // *********** Main function to return BIPV2 format business report results

 export fn_FullView(
   dataset(TopBusiness_Services.Layouts.rec_input_ids) ds_in_ids_wacctno
	 ,TopBusiness_Services.Layouts.rec_input_options in_options
	 ,doxie.IDataAccess mod_access
                   ):= function 
  


	 FETCH_LEVEL := in_options.BusinessReportFetchLevel;

  // Strip off the input acctno from each record, will re-attach them later.
	 ds_in_ids_only := project(ds_in_ids_wacctno,
                      transform(BIPV2.IDlayouts.l_xlink_ids,
                        self := left,
                        self := []
                    ));


  // ****** Get the needed info for each set of input linkids from the appropriate source linkids
	 // keys that reflect business/person associates of the company being reported on.

  // ****** BANKRUPTCY
  ds_bankr_linkids_keyrecs := TopBusiness_Services.Key_Fetches(
                                ds_in_ids_only,
                                FETCH_LEVEL).ds_bankr_linkidskey_recs;

  // Project onto a slimmed layout.
  ds_bankr_linkids_keyrecs_slimmed := project(ds_bankr_linkids_keyrecs,
                                        transform(TopBusiness_Services.AssociateSection_layouts.rec_ids_with_linkidsdata_slimmed,
                                          self.source      := MDR.sourceTools.src_Bankruptcy,
                                          self.role_source := Constants.ASSOCIATE_ROLE_BANKR;
                                          self             := left, // to preserve ids & other key fields being kept
                                          self             := [], // to null out any unassigned fields???
                                      ));

  // Sort/dedup by linkids & tmsid to only keep 1(does it matter which one?) record per
	 // linkids/tmsid combo in case there are more than 1.
  ds_bankr_linkids_keyrecs_deduped := dedup(sort(ds_bankr_linkids_keyrecs_slimmed,
                                              #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
                                              tmsid),
                                        #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
                                        tmsid);

  //temp layout for needed linkids key fields plus party key fields
  rec_bankr_linkids_party_combo := record
    BIPV2.IDlayouts.l_header_ids;
	   TopBusiness_Services.AssociateSection_layouts.rec_ids_with_linkidsdata_slimmed.source;
	   TopBusiness_Services.AssociateSection_layouts.rec_ids_with_linkidsdata_slimmed.role_source;
		  recordof(BankruptcyV3.key_bankruptcyv3_search_full_bip()) - BIPV2.IDlayouts.l_header_ids;
	   BIPV2.IDlayouts.l_header_ids associated_business_linkids;
	 end;

  // Next join the bankr linkids keyrecs to the bankruptcy search/party key to get all
	 // the bankruptcy "party" data for the tmsids involved to output on the report.
  ds_bankr_linkids_keyrecs_plusparty := join(ds_bankr_linkids_keyrecs_deduped,
                                             BankruptcyV3.key_bankruptcyv3_search_full_bip(),
                                             keyed(left.tmsid = right.tmsid)
                                             // v--- only get the "parties" not on the linkids key,
                                             //i.e. the parties other than the company the report
                                             //is being run on.
                                             and left.seleid != right.seleid //and 3 others???
                                             // and that have either a person last name or company name
                                             and (right.lname !='' or right.cname !=''),
                                               transform(rec_bankr_linkids_party_combo,
                                                 // assign reported on ids from left first because
                                                 // right/key has fields with the same name.
                                                 // v--- revise to use some kind on macro like BIPV2.IDmacros.mac_ListTop3Linkids()???
                                                 self.ultid                       := left.ultid,
                                                 self.orgid                       := left.orgid,
                                                 self.seleid                      := left.seleid,
                                                 self.proxid                      := left.proxid,
                                                 self.powid                       := left.powid,
                                                 self.empid                       := left.empid,
                                                 self.dotid                       := left.dotid,
                                                 // associated ids from right (party) key
                                                 self.associated_business_linkids := right,
                                                 self                             := right,
                                                 // to preserve input linkids & any other kept linkids key fields
                                                 self                             := left,
                                               ),
                                            inner, // only ones that match(???)
                                            //keep(TopBusiness_Services.Constants.liens_max_party_recs)); //from bip1??? only keep 100 recs
		                                          limit(10000,skip) //???
                                        );

	 // Might have party recs with some duplicate info, so sort/dedup to remove any duplicates.
	 // Keep recs with did/address info(???) as opposed to those without.???
	 ds_bankr_linkids_keyrecs_plusparty_dd := dedup(sort(ds_bankr_linkids_keyrecs_plusparty,
				                                               #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
                                                   //orig_name, //or company_name & person name fields???
                                                   // ^--- and/or use 1-4 associated_business_linkids???
                                                   // ultid, orgid ???
                                                   associated_business_linkids.seleid,
                                                   did,
                                                   //-prim_name,
                                                   //-prim_range,
                                                   //-v_city_name,
                                                   //-st,
                                                   //-zip5,
                                                   -date_vendor_last_reported
                                                   ),
				                                         #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
                                             //orig_name,
                                             // ^--- and/or use 1-4 associated_business_linkids???
                                             // ultid, orgid ???
                                             associated_business_linkids.seleid,
                                             did
                                             //prim_name,
                                             //prim_range,
                                             //v_city_name,
                                             //st,
                                             //zip5
                                           );


  // Project bankruptcy party+linkids data onto temp business/person common child record layout
  ds_bankr_common_child := project(ds_bankr_linkids_keyrecs_plusparty_dd,
		                           transform(TopBusiness_Services.AssociateSection_layouts.rec_child_party,
                               self.company_name               := left.cname,
                               self.person_name.title          := left.title,
                               self.person_name.fname          := left.fname,
                               self.person_name.mname          := left.mname,
                               self.person_name.lname          := left.lname,
                               self.person_name.name_suffix    := left.name_suffix;
                               self.ssn                        := left.app_ssn,
                               self.is_deceased                := false,
                               self.has_derog                  := false,
                               self.common_address.prim_range  := left.prim_range,
                               self.common_address.predir      := left.predir,
                               self.common_address.prim_name   := left.prim_name,
                               self.common_address.addr_suffix := left.addr_suffix,
                               self.common_address.postdir     := left.postdir,
                               self.common_address.unit_desig  := left.unit_desig,
                               self.common_address.sec_range   := left.sec_range,
                               self.common_address.v_city_name := left.v_city_name,
                               self.common_address.st          := left.st,
                               self.common_address.zip5        := left.zip,
                               self.common_address.zip4        := left.zip4,
                               self.common_address.fips_county := left.county[3..5], //use last 3 of full 5 digit fips
                               self.associate_type             := if(left.cname !='',Constants.Business,Constants.Person);
                               self                            := left, // to preserve ids & other fields being kept with same name
				                           self                            := [], // to null out any unassigned fields, 2 total_* fields??
                           ));


  // ****** LIENS
  // Key fetch to get data from new BIP2 liens linkids key file.
  ds_liens_linkids_keyrecs := TopBusiness_Services.Key_Fetches(
	                               ds_in_ids_only, // input file to join key with
                                FETCH_LEVEL).ds_liens_linkidskey_recs;

  // Project onto a slimmed layout.
  ds_liens_linkids_keyrecs_slimmed := project(ds_liens_linkids_keyrecs,
                                        transform(TopBusiness_Services.AssociateSection_layouts.rec_ids_with_linkidsdata_slimmed,
                                          self.source      := MDR.sourceTools.src_Liens_v2,
                                          self.role_source := Constants.ASSOCIATE_ROLE_JL,
                                          self             := left, // to preserve ids & other key fields being kept
                                          self             := [], // to null out any unassigned fields???
                                      ));

  // Sort/dedup by linkids, tmsid & rmsid to only keep 1(most recent) record per
	 // linkids/tmsid/rmsid combo.
  ds_liens_linkids_keyrecs_deduped := dedup(sort(ds_liens_linkids_keyrecs_slimmed,
                                              #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
                                              tmsid, rmsid,
                                              -date_vendor_last_reported // ???
                                           ),
				                                    #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
                                        tmsid,rmsid);

  //temp layout for needed linkids key fields plus party key fields
  rec_liens_linkids_party_combo := record
	   BIPV2.IDlayouts.l_header_ids;
	   TopBusiness_Services.AssociateSection_layouts.rec_ids_with_linkidsdata_slimmed.source;
	   TopBusiness_Services.AssociateSection_layouts.rec_ids_with_linkidsdata_slimmed.role_source;
	   recordof(LiensV2.key_liens_party_ID) - BIPV2.IDlayouts.l_header_ids; //TODO: check if was meant to be "- BIPV2.IDlayouts.l_xlink_ids"
	   BIPV2.IDlayouts.l_header_ids associated_business_linkids;
	 end;

  // Next join the liens linkid keyrecs to the Liens party key to get all the Liens "party"
	 // data for the tmsids/rmsids involved to output on the report.
  ds_liens_linkids_keyrecs_plusparty := join(ds_liens_linkids_keyrecs_deduped,
                                             LiensV2.key_liens_party_ID,
                                             keyed(left.tmsid = right.tmsid and
                                             // v--- to only get the sub-filings (rmsids) on the linkids key
                                             left.rmsid = right.rmsid)
                                             // v--- only get the "parties" not on the linkids key,
                                             //   i.e. the parties other than the company the report
                                             //        is being run on.
                                             and left.seleid != right.seleid //and 3 others???
                                             // and that have either a person last name or cleaned company name
                                             and (right.lname !='' or right.cname !=''),
                                               transform(rec_liens_linkids_party_combo,
                                                 // assign reported on ids from left first because
                                                 // right/key has fields with the same name.
                                                 // v--- revise to use some kind on macro like BIPV2.IDmacros.mac_ListTop3Linkids()???
                                                 self.ultid                       := left.ultid,
                                                 self.orgid                       := left.orgid,
                                                 self.seleid                      := left.seleid,
                                                 self.proxid                      := left.proxid,
                                                 self.powid                       := left.powid,
                                                 self.empid                       := left.empid,
                                                 self.dotid                       := left.dotid,
                                                 // associate ids from right/key
                                                 self.associated_business_linkids := right,
                                                 self                             := right,
                                                 // to preserve input linkids & any other kept linkids key fields
                                                 self                             := left,
                                               ),
                                             inner, // only ones that match(?) OR left outer, //???
                                             //keep(TopBusiness_Services.Constants.liens_max_party_recs)); //from bip1??? only keep 100 recs
                                             limit(10000,skip) //???
                                        );

	 // Might have party recs with some duplicate info, so sort/dedup to remove any duplicates.
	 // Keep recs with address info as opposed to those without.???
	 ds_liens_linkids_keyrecs_plusparty_dd := dedup(sort(ds_liens_linkids_keyrecs_plusparty,
				                                               #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
                                                   //orig_name, //or company_name & person name fields???
                                                   // ^--- and/or use 1-4 associated_business_linkids???
                                                   // ultid, orgid ???
                                                   associated_business_linkids.seleid,
                                                   did,
                                                   //-prim_name,
                                                   //-prim_range,
                                                   //-v_city_name,
                                                   //-st,
                                                   //-zip5,
                                                   -date_vendor_last_reported
                                                 ),
				                                         #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
                                             //orig_name,
                                             // ^--- and/or use 1-4 associated_business_linkids???
                                             // ultid, orgid ???
                                             associated_business_linkids.seleid,
                                             did
                                             //prim_name,
                                             //prim_range,
                                             //v_city_name,
                                             //st,
                                             //zip5
                                           );

  // Project liens party+linkids data onto temp business/person common child record layout
  ds_liens_common_child := project(ds_liens_linkids_keyrecs_plusparty_dd,
                                     transform(TopBusiness_Services.AssociateSection_layouts.rec_child_party,
                                       self.company_name               := left.cname,
                                       self.person_name.title          := left.title;
                                       self.person_name.fname          := left.fname;
                                       self.person_name.mname          := left.mname;
                                       self.person_name.lname          := left.lname;
                                       self.person_name.name_suffix    := left.name_suffix;
                                       self.ssn                        := left.ssn;
                                       self.is_deceased                := false,
                                       self.has_derog                  := false,
                                       self.common_address.prim_range  := left.prim_range,
                                       self.common_address.predir      := left.predir,
                                       self.common_address.prim_name   := left.prim_name,
                                       self.common_address.addr_suffix := left.addr_suffix,
                                       self.common_address.postdir     := left.postdir,
                                       self.common_address.unit_desig  := left.unit_desig,
                                       self.common_address.sec_range   := left.sec_range,
                                       self.common_address.v_city_name := left.v_city_name,
                                       self.common_address.st          := left.st,
                                       self.common_address.zip5        := left.zip,
                                       self.common_address.zip4        := left.zip4,
                                       self.common_address.fips_county := left.county[3..5]; //use last 3 of full 5 digit fips
                                       self.associate_type             := if(left.cname !='',Constants.Business, Constants.Person),
                                       self.liens_name_type            := left.name_type,
                                       // to preserve ids & other fields being kept with same name
                                       self                            := left,
                                       // to null out any unassigned fields, 2 total_* fields??
                                       self                            := [],
                                   ));


  // MVRs (VehicleV2)
  // *** Key fetch to get data from new BIP2 vehiclev2 linkids key file.
  ds_mvr_linkids_keyrecs := TopBusiness_Services.Key_Fetches(
	                             ds_in_ids_only, // input file to join key with
											                   FETCH_LEVEL,TopBusiness_Services.Constants.SlimKeepLimit).ds_veh_linkidskey_recs;

  // Filter to ONLY include linkids key recs where the reported on company (set of input linkids)
	 // is either an: Owner(type=1), Registrant(type=4) or Lessee(type=5) of the vehicle,
	 // but not any others like Lessor(type=2) or Lienholder(type=7).
  // Then project linkids key recs/data being used onto a slimmed layout.
  ds_mvr_linkids_keyrecs_slimmed := project(ds_mvr_linkids_keyrecs(
	                                             orig_name_type = Constants.VEH_OWNER or
																				                          orig_name_type = Constants.VEH_REGISTRANT or
																				                          orig_name_type = Constants.VEH_LESSEE),
		                                              transform(TopBusiness_Services.AssociateSection_layouts.rec_ids_with_linkidsdata_slimmed,
				                                              self.source      := MDR.sourceTools.fVehicles(left.state_origin,left.source_code),
				                                              self.role_source := Constants.ASSOCIATE_ROLE_MVR;
			                                               self.date_vendor_last_reported := (string) left.date_vendor_last_reported;
				                                              self := left, // to preserve ids & other key fields being kept
				                                              self := [], // to null out any unassigned fields???
			                                 ));

  // Sort/dedup by linkids, vehicle_key, iteration_key & sequence_key to only keep
	 // 1(most recent) record per linkids/vehicle_key/iteration_key/sequence_key combo.
  ds_mvr_linkids_keyrecs_deduped := dedup(sort(ds_mvr_linkids_keyrecs_slimmed,
				                                        #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			                         vehicle_key,iteration_key,sequence_key,
																								                    -date_vendor_last_reported
																							                  ),
				                                  #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																                      vehicle_key,iteration_key,sequence_key);

  //temp layout for needed linkids key fields plus party key fields
  rec_mvr_linkids_party_combo := record
	   BIPV2.IDlayouts.l_header_ids;
	   TopBusiness_Services.AssociateSection_layouts.rec_ids_with_linkidsdata_slimmed.source;
	   TopBusiness_Services.AssociateSection_layouts.rec_ids_with_linkidsdata_slimmed.role_source;
	   recordof(VehicleV2.Key_Vehicle_Party_Key) - BIPV2.IDlayouts.l_header_ids;
	   BIPV2.IDlayouts.l_header_ids associated_business_linkids;
	 end;

  // Next join the vehicle linkids keyrecs to the vehicle party plus linkids key to get all
	 // the "party" data for the vehicle_key/iteration_key(s?) involved to output on the report.
  ds_mvr_linkids_keyrecs_plusparty_pre := join(ds_mvr_linkids_keyrecs_deduped,
	                                              VehicleV2.Key_Vehicle_Party_Key,
		                                             keyed(left.vehicle_key   = right.vehicle_key   and
									                                      left.iteration_key = right.iteration_key and
                                               left.sequence_key  = right.sequence_key)
														                                 // v--- only get the "parties" not on the linkids key,
														                                 //i.e. the parties other than the company the report
														                                 //is being run on
														                                 and left.seleid != right.seleid //and 3 others???
														                                 // and that have either a person last name or cleaned company name
														                                 and (right.append_clean_name.lname !='' or
														                                 right.append_clean_cname      !=''),
	                                                transform(rec_mvr_linkids_party_combo,
														                                     // assign reported on ids from left first because
															                                    // right/key has fields with the same name.
															                                    // v--- revise to use some kind on macro like BIPV2.IDmacros.mac_ListTop3Linkids()???
															                                    self.ultid                       := left.ultid,
															                                    self.orgid                       := left.orgid,
															                                    self.seleid                      := left.seleid,
															                                    self.proxid                      := left.proxid,
															                                    self.powid                       := left.powid,
															                                    self.empid                       := left.empid,
															                                    self.dotid                       := left.dotid,
												                                       // associate ids from right/key
															                                    self.associated_business_linkids := right,
	                                                  // to assign needed fields from the key
                                                   self                             := right,
                                                   // to preserve other kept linkids key fields
                                                   self                             := left,
                                                 ),
		                                             inner, // only ones that match???
                                               //keep(TopBusiness_Services.Constants.liens_max_party_recs)); //from bip1??? only keep 100 recs
		                                             limit(10000,skip) //chg to use constants.???
														                            );
  ds_mvr_linkids_keyrecs_plusparty := suppress.mac_suppressSource(ds_mvr_linkids_keyrecs_plusparty_pre,mod_access,append_did);
	 // Might have party recs with some duplicate info, so sort/dedup to remove any duplicates.
	 // Keep recs with address info as opposed to those without.???
	 ds_mvr_linkids_keyrecs_plusparty_dd := dedup(sort(ds_mvr_linkids_keyrecs_plusparty,
				                                             #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																										                       //orig_name, //or append_clean_cname & person name fields???
																										                       // ^--- and/or use 1-4 associated_business_linkids???
																									                        // ultid, orgid ???
																									                        associated_business_linkids.seleid, //vers2???
																									                        append_did,
																										                       // -append_clean_address.prim_name,
																										                       // -append_clean_address.prim_range,
																										                       // -append_clean_address.v_city_name,
																										                       // -append_clean_address.st,
																										                       // -append_clean_address.zip5,
																										                       -date_vendor_last_reported
																								                       ),
				                                         #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																						                       //orig_name, //or append_clean_cname & person name fields???
																							                      // ^--- and/or use 1-4 associated_business_linkids???
																							                      // ultid, orgid ???
																							                      associated_business_linkids.seleid, //vers2???
																							                      append_did
																							                      // -append_clean_address.prim_name,
																							                      // -append_clean_address.prim_range,
																							                      // -append_clean_address.v_city_name,
																							                      // -append_clean_address.st,
																							                      // -append_clean_address.zip5,
																							                  );

  // Project vehicle party+linkids data onto temp business/person common child record layout
  ds_mvr_common_child := project(ds_mvr_linkids_keyrecs_plusparty_dd,
		                                 transform(TopBusiness_Services.AssociateSection_layouts.rec_child_party,
                                     self.company_name               := left.append_clean_cname,
                                     self.person_name.title          := left.append_clean_name.title;
	                                    self.person_name.fname          := left.append_clean_name.fname;
	                                    self.person_name.mname          := left.append_clean_name.mname;
	                                    self.person_name.lname          := left.append_clean_name.lname;
	                                    self.person_name.name_suffix    := left.append_clean_name.name_suffix;
				                                 self.ssn                        := left.append_ssn;
				                                 self.is_deceased                := false,
				                                 self.has_derog                  := false,
		                                   self.common_address.prim_range  := left.append_clean_address.prim_range,
		                                   self.common_address.predir      := left.append_clean_address.predir,
		                                   self.common_address.prim_name   := left.append_clean_address.prim_name,
		                                   self.common_address.addr_suffix := left.append_clean_address.addr_suffix,
		                                   self.common_address.postdir     := left.append_clean_address.postdir,
		                                   self.common_address.unit_desig  := left.append_clean_address.unit_desig,
		                                   self.common_address.sec_range   := left.append_clean_address.sec_range,
		                                   self.common_address.v_city_name := left.append_clean_address.v_city_name,
		                                   self.common_address.st          := left.append_clean_address.st,
		                                   self.common_address.zip5        := left.append_clean_address.zip5,
		                                   self.common_address.zip4        := left.append_clean_address.zip4,
				                                 self.common_address.fips_county := left.append_clean_address.fips_county;
                                     self.associate_type             := if(left.append_clean_cname !='',Constants.Business,
				                                                                       Constants.Person);
				                                 self.date_first_seen            := (string8) left.date_first_seen, //same field name, but diff type???
				                                 self.date_last_seen             := (string8) left.date_last_seen, //same field name, but diff type???
				                                 self.date_vendor_last_reported  := (string8) left.date_vendor_last_reported, //same field name, but diff type???
			                                  // to preserve rptd on ids & other fields being kept with same name
                                     self                            := left,
				                                 // to null out any unassigned fields, 2 total_* fields
                                     self                            := []
			                              ));


  // ****** UCCs
  // Key fetch to get data from new BIP2 ucc linkids key file.
  ds_ucc_linkids_keyrecs := TopBusiness_Services.Key_Fetches(
	                             ds_in_ids_only, // input file to join key with
                               FETCH_LEVEL,TopBusiness_Services.Constants.UCCKfetchMaxLimit).ds_ucc_linkidskey_recs;

  // Project onto a slimmed layout.
  ds_ucc_linkids_keyrecs_slimmed := project(ds_ucc_linkids_keyrecs,
		                                            transform(TopBusiness_Services.AssociateSection_layouts.rec_ids_with_linkidsdata_slimmed,
				                                            self.source                    := MDR.sourceTools.src_UCCv2,
				                                            self.role_source               := Constants.ASSOCIATE_ROLE_UCC;
                                                self.date_vendor_last_reported := (string8)left.dt_vendor_last_reported,
			                                             self                           := left, // to preserve ids & other key fields being kept
				                                            self                           := [], // to null out any unassigned fields
                                           ));

  // Sort/dedup by linkids, tmsid & rmsid to only keep 1(most recent) record per
	 // linkids/tmsid/rmsid combo.
  ds_ucc_linkids_keyrecs_deduped1 := dedup(sort(ds_ucc_linkids_keyrecs_slimmed,
				                                         #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			                          tmsid,rmsid,
																							                      //,-date_last_seen, //???
																							                      -date_vendor_last_reported // OR process_date???
																							                    ),
				                                   #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			                    tmsid,rmsid);

  // Next fix the rmsid, if needed on D&B UCCs so we get the right party recs.
	 // This is due to an idiosyncrasy in the UCC D&B data.
  ds_ucc_linkids_keyrecs_deduped2 := project(ds_ucc_linkids_keyrecs_deduped1,
	                                              transform(TopBusiness_Services.AssociateSection_layouts.rec_ids_with_linkidsdata_slimmed,
			                                              self.rmsid := UCCV2_Services.fn_remove_DNB_rmsid_seq(left.rmsid,left.tmsid);
							                                          self       := left));

  //temp layout for needed linkids key fields plus party key fields
  rec_ucc_linkids_party_combo := record
	   BIPV2.IDlayouts.l_header_ids;
	   TopBusiness_Services.AssociateSection_layouts.rec_ids_with_linkidsdata_slimmed.source;
	   TopBusiness_Services.AssociateSection_layouts.rec_ids_with_linkidsdata_slimmed.role_source;
		  recordof(UCCV2.Key_rmsid_party()) - BIPV2.IDlayouts.l_header_ids;
	   BIPV2.IDlayouts.l_header_ids associated_business_linkids;
	 end;

  // Next join the ucc linkids keyrecs to the UCC party+ key to get all the UCC "party"
	 // data for the tmsids/rmsids involved to output on the report.
  ds_ucc_linkids_keyrecs_plusparty := join(ds_ucc_linkids_keyrecs_deduped2,
	                                          UCCV2.Key_rmsid_party(),
                                           keyed(left.tmsid = right.tmsid and
											                                // v--- to only get the sub-filings (rmsids) from the linkids key
                                           left.rmsid = right.rmsid)
														                             // v--- only get the "parties" not on the linkids key,
														                             //   i.e. the parties other than the company the report
																	                          //is being run on
														                             and left.seleid != right.seleid //and 3 others???
														                             // and that have either a person last name or cleaned company name
														                             and (right.lname !='' or right.company_name !=''),
	                                            transform(rec_ucc_linkids_party_combo,
														                                 // assign reported on ids from left first because
															                                // right/key has fields with the same name.
															                                // v--- revise to use some kind on macro like BIPV2.IDmacros.mac_ListTop3Linkids()???
															                                self.ultid                       := left.ultid,
															                                self.orgid                       := left.orgid,
															                                self.seleid                      := left.seleid,
															                                self.proxid                      := left.proxid,
															                                self.powid                       := left.powid,
															                                self.empid                       := left.empid,
															                                self.dotid                       := left.dotid,
												                                   // associate ids from right/key
															                                self.associated_business_linkids := right,
			                                            self                             := right,
			                                            // to preserve input linkids & any other kept linkids key fields
                                               self                             := left
                                             ),
		                                         inner, // only ones that match(?) OR left outer, //???
                                           //keep(TopBusiness_Services.Constants.liens_max_party_recs)); //from bip1??? only keep 100 recs
		                                         limit(10000,skip) //chg to Constants.???
																                      );

	 // Might have party recs with some duplicate info, so sort/dedup to remove any duplicates.
	 // Keep recs with address info as opposed to those without.???
	 ds_ucc_linkids_keyrecs_plusparty_dd := dedup(sort(ds_ucc_linkids_keyrecs_plusparty,
				                                             #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																									                        //orig_name, //or company_name & person name fields???
																									                        // ^--- and/or use 1-4 associated_business_linkids???
																									                        // ultid, orgid ???
																									                        associated_business_linkids.seleid, //vers2???
																									                        did,
																									                        //-prim_name,
																									                        //-prim_range,
																									                        //-v_city_name,
																									                        //-st,
																									                        //-zip5,
																									                        -dt_vendor_last_reported
																								                       ),
				                                       #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																						                     //orig_name,
																							                    // ^--- and/or use 1-4 associated_business_linkids???
																							                    // ultid, orgid ??? 
																							                    associated_business_linkids.seleid, //vers2???
																							                    did
																							                    //prim_name,
																							                    //prim_range,
																							                    //v_city_name,
																							                    //st,
																							                    //zip5
																							                  );

  // Project ucc party+linkids data onto temp business/person common child record layout.
  ds_ucc_common_child := project(ds_ucc_linkids_keyrecs_plusparty_dd,
		                                 transform(TopBusiness_Services.AssociateSection_layouts.rec_child_party,
                                     self.company_name               := left.company_name,
                                     self.person_name.title          := left.title;
	                                    self.person_name.fname          := left.fname;
	                                    self.person_name.mname          := left.mname;
	                                    self.person_name.lname          := left.lname;
	                                    self.person_name.name_suffix    := left.name_suffix;
				                                 self.did                        := //(string) left.did; //same field name, but needs cast???
				                                                                    intformat(left.did,12,1); //same field name, but needs converted to string12 with leading zeroes
				                                 self.ssn                        := left.ssn;
				                                 self.is_deceased                := false,
				                                 self.has_derog                  := false,
		                                   self.common_address.prim_range  := left.prim_range,
		                                   self.common_address.predir      := left.predir,
		                                   self.common_address.prim_name   := left.prim_name,
		                                   self.common_address.addr_suffix := left.suffix,
		                                   self.common_address.postdir     := left.postdir,
		                                   self.common_address.unit_desig  := left.unit_desig,
		                                   self.common_address.sec_range   := left.sec_range,
		                                   self.common_address.v_city_name := left.v_city_name,
		                                   self.common_address.st          := left.st,
		                                   self.common_address.zip5        := left.zip5,
		                                   self.common_address.zip4        := left.zip4,
				                                 self.common_address.fips_county := left.county; //ucc party rmsid linkids key "county" field appears to only contain the 3 digit county fips code
                                     self.associate_type             := if(left.company_name !='',Constants.Business, Constants.Person),
				                                 self.date_first_seen            := (string8) left.dt_first_seen,
				                                 self.date_last_seen             := (string8) left.dt_last_seen,
				                                 self.date_vendor_last_reported  := (string8) left.dt_vendor_last_reported,
			                                  self                            := left, // to preserve ids & other fields being kept with same name
				                                 self                            := [], // to null out any unassigned fields, 2 total_* fields??
			                                ));


  // WATERCRAFT
  // *** Key fetch to get data from new BIP2 watercraft linkids key file.
  ds_wc_linkids_keyrecs := TopBusiness_Services.Key_Fetches(
	                            ds_in_ids_only, // input file to join key with
											                  FETCH_LEVEL).ds_wc_linkidskey_recs;

  // Project onto a slimmed layout.
  ds_wc_linkids_keyrecs_slimmed := project(ds_wc_linkids_keyrecs,
		                                           transform(TopBusiness_Services.AssociateSection_layouts.rec_ids_with_linkidsdata_slimmed,
				                                           self.source      := MDR.sourceTools.fWatercraft(left.source_code,left.state_origin),
				                                           self.role_source := Constants.ASSOCIATE_ROLE_WC;
			                                            self             := left, // to preserve ids & other key fields being kept
				                                           self             := [], // to null out any unassigned fields???
			                                       ));

  // Sort/dedup by linkids, state_origin, watercraft_key & sequence_key(?) to only keep the 1 most
	 // recent(highest date_last_seen?) record per linkids/st_origin/watercraft_key/sequence_key combo.
  ds_wc_linkids_keyrecs_deduped := dedup(sort(ds_wc_linkids_keyrecs_slimmed,
				                                       #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			                        state_origin, watercraft_key, sequence_key,
																								                   //,-date_last_seen// and/or ---v ???
																								                   -date_vendor_last_reported
																								                 ),
				                                   #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			                    state_origin, watercraft_key, sequence_key); //seq_key???

  //temp layout for needed linkids key fields plus party key fields
  rec_wc_linkids_party_combo := record
	   BIPV2.IDlayouts.l_header_ids;
	   TopBusiness_Services.AssociateSection_layouts.rec_ids_with_linkidsdata_slimmed.source;
	   TopBusiness_Services.AssociateSection_layouts.rec_ids_with_linkidsdata_slimmed.role_source;
	   recordof(Watercraft.key_watercraft_sid_linkids) - BIPV2.IDlayouts.l_header_ids;
	   BIPV2.IDlayouts.l_header_ids associated_business_linkids;
	 end;

  // Next join the watercraft linkids keyrecs to the watercraft party key to get all the
	 // Watercraft "party" data for the watercraft_keys involved to output on the report.
  ds_wc_linkids_keyrecs_plusparty := join(ds_wc_linkids_keyrecs_deduped,
	                                         Watercraft.key_watercraft_sid_linkids(),
		                                        keyed(left.state_origin   = right.state_origin   and
									                                 left.watercraft_key = right.watercraft_key and
                                          left.sequence_key = right.sequence_key)
														                            // v--- only get the "parties" not on the linkids key,
														                            //   i.e. the parties other than the company the report
														                            //        is being run on
														                            and left.seleid != right.seleid //and 3 others???
														                            // and that have either a person last name or company name ???
														                            and (right.lname        !='' or
														                            right.company_name !=''),
	                                           transform(rec_wc_linkids_party_combo,
													                                 // assign reported on ids from left first because
														                                // right/key has fields with the same name.
														                                // v--- revise to use some kind on macro like BIPV2.IDmacros.mac_ListTop3Linkids()???
														                                self.ultid                       := left.ultid,
														                                self.orgid                       := left.orgid,
														                                self.seleid                      := left.seleid,
														                                self.proxid                      := left.proxid,
														                                self.powid                       := left.powid,
														                                self.empid                       := left.empid,
														                                self.dotid                       := left.dotid,
												                                  // associate ids from right/key
														                                self.associated_business_linkids := right,
			                                           self                             := right, // to assign needed fields from the key
			                                           self                             := left, // to preserve other kept linkids key fields
                                            ),
		                                        inner, // only ones that match(?) OR left outer, //???
                                          //keep(TopBusiness_Services.Constants.liens_max_party_recs)); //from bip1??? only keep 100 recs
                                          limit(10000,skip) //chg to use constants.???
												                         );

  // Might have duplicate parties, so sort/dedup to remove any duplicates (based upon did only?).
	 // For dupes, keep most recent record based upon highest date_vendor_last_reported???
	 ds_wc_linkids_keyrecs_plusparty_dd := dedup(sort(ds_wc_linkids_keyrecs_plusparty,
				                                            #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																									                       associated_business_linkids.seleid, //vers2???
																									                       // ^--- and/or use 1-4 associated_business_linkids???
																									                       // ultid, orgid ???
																									                       did,
																									                       orig_name,  //in case > 1 rec has did=0???
																									                       //^--- or company_name & person name fields???
															   								                      // and ---v ???
																									                       //,-prim_name,
																									                       //-prim_range,
																									                       //-v_city_name,
																									                       //-st,
																									                       //-zip5,
																									                       -date_vendor_last_reported
																								                      ),
				                                        #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																							                     // ^--- and/or use 1-4 associated_business_linkids???
																							                     // ultid, orgid ???
																							                     associated_business_linkids.seleid, //vers2???
																							                     did,
																						                      orig_name //in case > 1 rec has did=0???
																							                     // and ---v ???
																							                     //,prim_name,
																							                     //prim_range,
																							                     //v_city_name,
																							                     //st,
																							                     //zip5
																							                   );

  // Project watercraft party+linkids data onto temp business/person common child record layout
  ds_wc_common_child := project(ds_wc_linkids_keyrecs_plusparty_dd,
		                                transform(TopBusiness_Services.AssociateSection_layouts.rec_child_party,
                                    self.company_name               := left.company_name,
                                    self.person_name.title          := left.title;
	                                   self.person_name.fname          := left.fname;
	                                   self.person_name.mname          := left.mname;
	                                   self.person_name.lname          := left.lname;
	                                   self.person_name.name_suffix    := left.name_suffix;
				                                self.ssn                        := left.ssn;
				                                self.is_deceased                := false,
				                                self.has_derog                  := false,
		                                  self.common_address.prim_range  := left.prim_range,
		                                  self.common_address.predir      := left.predir,
		                                  self.common_address.prim_name   := left.prim_name,
		                                  self.common_address.addr_suffix := left.suffix,
		                                  self.common_address.postdir     := left.postdir,
		                                  self.common_address.unit_desig  := left.unit_desig,
		                                  self.common_address.sec_range   := left.sec_range,
		                                  self.common_address.v_city_name := left.v_city_name,
		                                  self.common_address.st          := left.st,
		                                  self.common_address.zip5        := left.zip5,
		                                  self.common_address.zip4        := left.zip4,
				                                self.common_address.fips_county := left.county;  //wc sid linkids key "county" field appears to only contain the 3 digit county fips code
                                    self.associate_type             := if(left.company_name !='',Constants.Business,Constants.Person);
			                                 self                            := left, // to preserve ids & other fields being kept with same name
				                                self                            := [], // to null out any unassigned fields, 2 total_* fields??
			                             ));


  // REAL PROPERTY (Tax Assessor, Deed Transfers/sales & Mortgage info)
  // *** Key fetch to get data from new BIP2 LN_Propertyv2 linkids key file.
	 ds_prop_linkids_keyrecs := TopBusiness_Services.Key_Fetches(ds_in_ids_only,
									                       FETCH_LEVEL,TopBusiness_Services.Constants.PropertyKfetchMaxLimit).ds_prop_linkidskey_recs;

  // Project onto a slimmed layout
  ds_prop_linkids_keyrecs_slimmed := project(ds_prop_linkids_keyrecs,
		                                             transform(TopBusiness_Services.AssociateSection_layouts.rec_ids_with_linkidsdata_slimmed,
				                                             self.source      := MDR.sourceTools.fProperty(left.ln_fares_id),
				                                             self.role_source := Constants.ASSOCIATE_ROLE_RP;
			                                              self             := left, // to preserve ids & other key fields being kept
				                                             self             := [] // to null out any unassigned fields
			                                          ));

  // Sort/dedup by linkids & ln_fares_id to only keep 1(does it matter which one???) record per
	 // linkids/ln_fares_id combo in case there are more than 1.
  ds_prop_linkids_keyrecs_deduped := dedup(sort(ds_prop_linkids_keyrecs_slimmed,
				                                         #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			                          ln_fares_id
																								                     //,-date_last_seen,-date_vendor_last_reported ???
																								                   ),
				                                    #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			                     ln_fares_id);

  //temp layout for needed linkids key fields plus party key fields
  rec_prop_linkids_party_combo := record
	   BIPV2.IDlayouts.l_header_ids;
	   TopBusiness_Services.AssociateSection_layouts.rec_ids_with_linkidsdata_slimmed.source;
	   TopBusiness_Services.AssociateSection_layouts.rec_ids_with_linkidsdata_slimmed.role_source;
		  recordof(LN_PropertyV2.key_search_fid()) - BIPV2.IDlayouts.l_header_ids;
	   BIPV2.IDlayouts.l_header_ids associated_business_linkids;
	 end;

  // Next join the property linkids keyrecs to the property search/party key to get all of
	 // the property "party" data for the ln_fares_ids involved to output on the report.
  ds_prop_linkids_keyrecs_plusparty := join(ds_prop_linkids_keyrecs_deduped,
	                                           LN_PropertyV2.key_search_fid(),
                                            keyed(left.ln_fares_id = right.ln_fares_id)
														                              // v--- only get the "parties" not on the linkids key,
														                              //   i.e. the parties other than the company the report
																	                           //is being run on.
														                              and left.seleid != right.seleid //and 3 others???
														                              //and that have either a person last name or company name ???
														                              and (right.lname !='' or right.cname !=''),
	                                             transform(rec_prop_linkids_party_combo,
													                                   // assign reported on ids from left first because
														                                  // right/key has fields with the same name.
														                                  // v--- revise to use some kind on macro like BIPV2.IDmacros.mac_ListTop3Linkids()???
														                                  self.ultid                       := left.ultid,
        													                           self.orgid                       := left.orgid,
														                                  self.seleid                      := left.seleid,
														                                  self.proxid                      := left.proxid,
														                                  self.powid                       := left.powid,
														                                  self.empid                       := left.empid,
														                                  self.dotid                       := left.dotid,
												                                    // associate ids from right/key
														                                  self.associated_business_linkids := right,
			                                             self                             := right,
			                                             // to preserve input linkids & any other kept linkids key fields
                                                self                             := left,
                                              ),
		                                          inner, // only ones that match(?) OR left outer, //???
                                            //keep(TopBusiness_Services.Constants.liens_max_party_recs)); //from bip1??? only keep 100 recs
		                                          limit(10000,skip) //???
																                       );

	 // Might have duplicate party names/addresses, so sort/dedup to remove any duplicates.
	 // Keep recs with address or ssn info as opposed to those without. ???
	 ds_prop_linkids_keyrecs_plusparty_dd := dedup(sort(ds_prop_linkids_keyrecs_plusparty,
				                                              #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																									                         //nameasis, //or cname & person name fields???
																									                         // ^--- and/or use 1-4 associated_business_linkids???
																									                         // ultid, orgid ???
																									                         associated_business_linkids.seleid, //vers2???
																									                         did,
																									                         //-prim_name,
																									                         //-prim_range,
																									                         //-v_city_name,
																									                         //-st,
																									                         //-zip5,
																										                        //-app_ssn???
																									                         -dt_vendor_last_reported
																								                        ),
				                                          #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																						                        //nameasis, //or cname & person name fields???
																							                       // ^--- and/or use 1-4 associated_business_linkids???
																							                       // ultid, orgid ???
																							                       associated_business_linkids.seleid, //vers2???
																							                       did
																							                       //prim_name,
																							                       //prim_range,
																							                       //v_city_name,
																							                       //st,
																							                       //zip5
																							                       //app_ssn ???
                                            );

  // Project property party+linkids data onto temp business/person common child record layout
  ds_prop_common_child := project(ds_prop_linkids_keyrecs_plusparty_dd,
		                                  transform(TopBusiness_Services.AssociateSection_layouts.rec_child_party,
                                      self.company_name               := left.cname,
                                      self.person_name.title          := left.title;
	                                     self.person_name.fname          := left.fname;
	                                     self.person_name.mname          := left.mname;
	                                     self.person_name.lname          := left.lname;
	                                     self.person_name.name_suffix    := left.name_suffix;
				                                  self.did                        := //(string) left.did; //same field name, but need type chged ???
				                                                                     intformat(left.did,12,1); //same field name, but needs chgd from unsigned6 to string12 with leading zeroes
				                                  self.ssn                        := left.app_ssn;
				                                  self.is_deceased                := false,
				                                  self.has_derog                  := false,
		                                    self.common_address.prim_range  := left.prim_range,
		                                    self.common_address.predir      := left.predir,
		                                    self.common_address.prim_name   := left.prim_name,
		                                    self.common_address.addr_suffix := left.suffix,
		                                    self.common_address.postdir     := left.postdir,
		                                    self.common_address.unit_desig  := left.unit_desig,
		                                    self.common_address.sec_range   := left.sec_range,
		                                    self.common_address.v_city_name := left.v_city_name,
		                                    self.common_address.st          := left.st,
		                                    self.common_address.zip5        := left.zip,
		                                    self.common_address.zip4        := left.zip4,
				                                  self.common_address.fips_county := left.county[3..5]; //use last 3 of full 5 digit fips ???
                                      self.associate_type             := if(left.cname !='',Constants.Business, Constants.Person);
				                                  self.date_first_seen            := (string8) left.dt_first_seen,
				                                  self.date_last_seen             := (string8) left.dt_last_seen,
				                                  self.date_vendor_last_reported  := (string8) left.dt_vendor_last_reported,
			                                   // to preserve ids & other fields being kept with same name
                                      self                            := left,
				                                  // to null out any unassigned fields, 2 total_* fields??
                                      self := []
			                               ));


  // FORECLOSURE
  // *** Key fetch to get data from new BIP2 Property Foreclosure linkids key file.
  ds_fc_linkids_keyrecs := TopBusiness_Services.Key_Fetches(
	                            ds_in_ids_only,
													                FETCH_LEVEL,TopBusiness_Services.Constants.ForeclosureNODKfetchMaxLimit).ds_fc_linkidskey_recs;

  // Project onto a common slimmed layout
  ds_fc_linkids_keyrecs_slimmed := project(ds_fc_linkids_keyrecs,
		                                           transform(TopBusiness_Services.AssociateSection_layouts.rec_ids_with_linkidsdata_slimmed,
				                                           self.source             := MDR.sourceTools.src_Foreclosures, //???
	                                              //self.source_docid     := left.foreclosure_id; //???
	                                              //self.source_recid     := left.source_rec_id; //???
                                               //self.fc_name_first    := , ... ???
				                                           self.forec_name_company := left.name_company,  // fc vers1???
				                                           // ^--- needed for matching to foreclosure fid linkids key until all 6(?) names on there
				                                           //have an associated set of ids aded to the key???
				                                           self.role_source        := Constants.ASSOCIATE_ROLE_FC; // or ..._RP???
			                                            self                    := left, // to preserve ids & other key fields being kept
				                                           self                    := [], // to null out any unassigned fields
			                                        ));

  // Sort/dedup by linkids & foreclosure_id to only keep 1(does it matter which one???) record per
	 // linkids/foreclosure_id combo in case there are more than 1.
  ds_fc_linkids_keyrecs_deduped := dedup(sort(ds_fc_linkids_keyrecs_slimmed,
				                                       #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			                        foreclosure_id
																								                   //, ???
																								                 ),
				                                   #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			                    foreclosure_id);

  // First just get all foreclosure fid plus linkids key recs for each set of linkids.
  // Is a new TopBusiness_Services.AssociateSection_layouts record needed for fc linkids key fields plus party(fid) key fields???
  rec_fc_linkids_party_combo := record
	   BIPV2.IDlayouts.l_header_ids;
	   TopBusiness_Services.AssociateSection_layouts.rec_ids_with_linkidsdata_slimmed.role_source;
		  TopBusiness_Services.AssociateSection_layouts.rec_ids_with_linkidsdata_slimmed.forec_name_Company;
		  recordof(dx_Property.Key_Foreclosures_FID_Linkids()) - [name1,name2, name3, name4];
	   BIPV2.IDlayouts.l_header_ids associated_business_linkids1;
		  BIPV2.IDlayouts.l_header_ids associated_business_linkids2;
		  BIPV2.IDlayouts.l_header_ids associated_business_linkids3;
		  BIPV2.IDlayouts.l_header_ids associated_business_linkids4;
	 end;

  // Next join the deduped foreclosure linkids keyrecs to the foreclosure fid(party?) plus linkids key to get
	// all of the foreclosure "party" data for the foreclosure_ids involved to output on the report.
  ds_fc_linkids_keyrecs_plusparty := 
	                         join(ds_fc_linkids_keyrecs_deduped,
	                              dx_Property.Key_Foreclosures_FID_Linkids,
                                   keyed(left.foreclosure_id = right.fid) //AND RIGHT.source=MDR.sourceTools.src_Foreclosures
																																			AND right.source IN Foreclosure_Services.Functions.getCodes(in_options.IncludeVendorSourceB)
																	 // vers1, just get all recs because they will have to be normalized first due to multiple names???

														       // vers1b can't do here??? 
																	 // v--- only get the "parties" not on the linkids key,
														       //   i.e. the parties other than the company the report
																	 //        is being run on.
														       //and (left.forec_name_company != right.name1_company
                                   //     and 
                                   //     left.forec_name_company != right.name2_company
                                   //     and
                                   //     ... thru 4th
                                   // and plaintiff_1 and plaintiff_2??? (NO? contains either a company name or unparsed person name(s)???)
																		//	 )
																	 // v--- vers 2, once new party+linkids key is created ???
																	 // still can't do here???
																	 //and left.seleid != right.name1.seleid //???
														       //and left.seleid != right.name*.seleid //and 3 or 5 others need added to key???
                                   // ...
														       // and that have either a person last name or company name ???
														       //and (right.lname !='' or 
														       //     right.cname !='')
																,
	                              transform(rec_fc_linkids_party_combo,
													         // assign reported on ids from left first because 
														       // right/key has fields with the same name.
														       // v--- revise to use some kind on macro like BIPV2.IDmacros.mac_ListTop3Linkids()???
														       self.ultid  := left.ultid,  
        													 self.orgid  := left.orgid, 
														       self.seleid := left.seleid, 
														       self.proxid := left.proxid, //???
														       self.powid  := left.powid,  //???
														       self.empid  := left.empid,  //???
														       self.dotid  := left.dotid,  //???
												           // associate ids from right/key
														       self.associated_business_linkids1 := right.name1, //???
																	 // v--- vers2
														       self.associated_business_linkids2 := right.name2, //???
														       self.associated_business_linkids3 := right.name3, //???
														       self.associated_business_linkids4 := right.name4, //???
																	 
			                             self := right,
			                             self := left, // to preserve input linkids & any other kept linkids key fields
                                 ),
		                             inner, // only ones that match(?) OR left outer, //???
                                 //keep(TopBusiness_Services.Constants.liens_max_party_recs)); //from bip1??? only keep 100 recs
		                             limit(10000,skip) //???
																);

  // Then sort/dedup all fid (party) key recs by linkids & foreclosure_id since it appears that
	 // some foreclosure_ids have partial duplicate recs/name data (except tax_year etc. are diff) ???
	 // For example, see foreclosure_id = 06081185HALTOMOAKS (found on ult/org/sele = 9187) &
	 //                                   ??? <--------------------------------------- !!!
	 ds_fc_linkids_keyrecs_pp_dd := dedup(sort(ds_fc_linkids_keyrecs_plusparty,
				                                     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			                      foreclosure_id,
                                         -tax_year // ???
																							               ),
				                                #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			                 foreclosure_id);


  // !!! Do roll-up instead of sort/dedup above???  See comments below in the NOD section.???


  // Then "Normalize" to put each "name" field (up to 7) on a separate record.   ???
	 //
	 // NOTE: On the foreclosure fid (party) linkids key, the 4 original "*_defendant_borrower_*"
	 // name fields (cleaned & stored into "name*" (*=1-4) fields) and the 2 unparsed "plaintiff*" (*=1&2)
	 // fields are actually miss-labeled in that for the foreclosure, the business/person being
	 // foreclosed on should be the "defendant", but is stored in the plaintiff* field(s) and the
	 // business/person doing the foreclosing should be the "plaintiff", but is stored in the
	 // "*_defendant_*"/"name_*" field(s).
	 // This was confirmed by Rosemary Murphy from the data insight team via an email sent to
	 // Dave Wright on 11/05/13.
	 // So the "situs1" address (the address of the property being foreclosed on) should go with
	 // the "plaintiff*" fields and the "situs2" address (the mailing address, when present)
	 // should go with the "*_defendant_*"/"name*" fields.
 	TopBusiness_Services.AssociateSection_layouts.rec_child_party tf_norm_fcnames(
    recordof(ds_fc_linkids_keyrecs_pp_dd) L, integer C) := transform
				  // parse/clean the trustee_mailing_address only if trustee_name != blank
				  //trustee_exists := if(trustee_name !='',true,false);
				  //temp_trustee_addr := L.trustee_mailing_address;
				  // v--- Also below normalize/use: trustee_ name (bus or unparsed person) field per Tim B in 11/18/13 mtg.
      self.company_name           := choose(C, L.name1_company,L.name2_company,L.name3_company,
																								                    L.name4_company,L.plaintiff_1,L.plaintiff_2,
																								                    L.trustee_name);
      // plaintiff* & trustee (---^) fields appear to
						// contain either a company name or an unparsed
						// person name/names.
						// So for now(vers1) it was decided to just store
						// plaintiffs into the output "company_name" field
						// until this can be investigated further.
      // v--- kept getting odd syntax errors with this. //fc vers1a???
      //self.associated_business_linkids        := choose(C, L.associated_business_linkids1, //???
				  //[], [],[],[],[]); //???
      // fc vers1b, next 10 lines  ---v
      self.associated_business_linkids.dotid  := 0;
	     self.associated_business_linkids.empid  := 0;
      self.associated_business_linkids.powid  := 0;
	     self.associated_business_linkids.proxid := 0;
      self.associated_business_linkids.seleid := choose(C,L.associated_business_linkids1.seleid, //vers1???
																											                             L.associated_business_linkids2.seleid, //vers2???
																														                          L.associated_business_linkids3.seleid, //vers2???
																														                          L.associated_business_linkids4.seleid, //vers2???
																														                          0,0); // // 5th & 6th name ids???
	      self.associated_business_linkids.orgid  := choose(C,L.associated_business_linkids1.orgid,  //vers1???
																											                              L.associated_business_linkids2.orgid, //vers2???
																														                           L.associated_business_linkids3.orgid, //vers2???
																														                           L.associated_business_linkids4.orgid, //vers2???
																														                           0,0); // // 5th & 6th name ids???
	      self.associated_business_linkids.ultid  := choose(C,L.associated_business_linkids1.ultid, //vers1???
																											                              L.associated_business_linkids2.ultid, //vers2???
																														                           L.associated_business_linkids3.ultid, //vers2???
																														                           L.associated_business_linkids4.ultid, //vers2???
																														                           0,0); // // 5th & 6th name ids???
				   self.person_name.title       := choose(C, L.name1_prefix,L.name2_prefix,L.name3_prefix,
																								  L.name4_prefix,'','','');
	      self.person_name.fname       := choose(C, L.name1_first,L.name2_first,L.name3_first,
																								  L.name4_first,'','','');
	      self.person_name.mname       := choose(C, L.name1_middle,L.name2_middle,L.name3_middle,
																								  L.name4_middle,'','','');
	      self.person_name.lname       := choose(C, L.name1_last,L.name2_last,L.name3_last,
																								  L.name4_last,'','','');
	      self.person_name.name_suffix := choose(C, L.name1_suffix,L.name2_suffix,L.name3_suffix,
																								  L.name4_suffix,'','','');
				   self.did                     := choose(C, L.name1_did,L.name2_did,L.name3_did,
				                                          L.name4_did,'','','');
				   self.ssn                     := choose(C, L.name1_ssn,L.name2_ssn,L.name3_ssn,
				                                          L.name4_ssn,'','','');
				   self.is_deceased             := false,
				   self.has_derog               := false,
				   // fc fid linkids key has multiple "situs1/2" address fields, but which one goes with
				   // which "party"???
				   // situs1 address = foreclosed property address? should go with plaintiff1&2(?) ???
				   // situs2 address = s/b defendant1(&2?/3?/4?) mailing address ???
				   // See note above about defendant/plaintiff field names being miss-labeled.
		     self.common_address.prim_range  := choose(C, L.situs2_prim_range, '','','', // 2/3/4 ???
				                                              L.situs1_prim_range, L.situs1_prim_range,''), //7???
		     self.common_address.predir      := choose(C, L.situs2_predir, '','','', // 2/3/4 ???
				                                              L.situs1_predir, L.situs1_predir,''), //7???
		     self.common_address.prim_name   := choose(C, L.situs2_prim_name, '','','', // 2/3/4 ???
				                                              L.situs1_prim_name, L.situs1_prim_name,''), //7???
		     self.common_address.addr_suffix := choose(C, L.situs2_addr_suffix, '','','', // 2/3/4 ???
				                                              L.situs1_addr_suffix, L.situs1_addr_suffix,''), //7???
		     self.common_address.postdir     := choose(C, L.situs2_postdir, '','','', // 2/3/4 ???
				                                              L.situs1_postdir, L.situs1_postdir,''), //7???
		     self.common_address.unit_desig  := choose(C, L.situs2_unit_desig, '','','', // 2/3/4 ???
				                                              L.situs1_unit_desig, L.situs1_unit_desig,''), //7???
		     self.common_address.sec_range   := choose(C, L.situs2_sec_range, '','','', // 2/3/4 ???
				                                              L.situs1_sec_range, L.situs1_sec_range,''), //7???
		     self.common_address.v_city_name := choose(C, L.situs2_v_city_name, '','','', // 2/3/4 ???
				                                              L.situs1_v_city_name, L.situs1_v_city_name,''), //7???
		     self.common_address.st          := choose(C, L.situs2_st, '','','', // 2/3/4 ???
				                                              L.situs1_st, L.situs1_st,''), //7???
		     self.common_address.zip5        := choose(C, L.situs2_zip, '','','', // 2/3/4 ???
				                                              L.situs1_zip, L.situs1_zip,''), //7???
		     self.common_address.zip4        := choose(C, L.situs2_zip4, '','','', // 2/3/4 ???
				                                              L.situs1_zip4, L.situs1_zip4,'',''), //7??? //7???
				   self.common_address.fips_county := choose(C, L.situs2_fipscounty, '','','', // 2/3/4 ???
				                                              L.situs1_fipscounty, L.situs1_fipscounty,''), //7???
       self.associate_type             := choose(C, if(L.name1_company !='',Constants.Business,Constants.Person),
				                                      if(L.name2_company !='',Constants.Business,Constants.Person),
											                               if(L.name3_company !='',Constants.Business,Constants.Person),
											                               if(L.name4_company !='',Constants.Business,Constants.Person),
											                               Constants.Business, //L.plaintiff_1, 1 field for either a company name or an unparsed person name/names
											                               Constants.Business,  //L.plaintiff_2, 1 field for either a company name or an unparsed person name/names
											                               Constants.Business  //L.trustee_name, 1 field for either a company name or an unparsed person name/names
									                                 );
				   self.date_first_seen            := L.recording_date; //???
				   self.date_last_seen             := L.process_date;  //???
				   self.date_vendor_last_reported  := L.process_date; //???
			    self := L, // to preserve ids & other fields being kept with same name
				   self := [], // to null out any unassigned fields, 2 total_* fields??
	 end;

  ds_fc_common_child_normed := normalize(ds_fc_linkids_keyrecs_pp_dd,
                                         7, //up to 4 defendants(names*), 2 plaintiffs & 1 trustee
                                         tf_norm_fcnames(left, counter));

	 // Might have empty or duplicate party names or the company_name is the same as the
	 // company that is being reported on; so filter/sort/dedup to remove those conditions.
	 // Keep recs with address or ssn info as opposed to those without. ???
	 ds_fc_common_child_normed_dd := dedup(sort(ds_fc_common_child_normed(
	                                           (company_name != '' and
																								                    (company_name != forec_name_company or
																									                   (associated_business_linkids.seleid != 0 and
																									                   seleid != associated_business_linkids.seleid)))or
	                                           person_name.lname !=''),  //???
				                                        #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																						                      company_name,
																						                      person_name.lname,person_name.fname,person_name.mname,
																						                      // ^--- and/or use 1-4 associated_business_linkids???
																						                      // ultid, orgid, seleid ???
																						                      //associated_business_linkids1.seleid, //???, vers2 once all 4/6? filled in
																						                      //did,   ???
																						                      //-prim_name,
																						                      //-prim_range,
																						                      //-v_city_name,
																						                      //-st,
																						                      //-zip5,
																						                      //-app_ssn???
																						                      -date_last_seen  //???
																						                    ),
				                                    #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			                     company_name,
																			                     person_name.lname,person_name.fname,person_name.mname
																			                     //associated_business_linkids1.seleid, //vers2???
																			                     //did //???
																				                    //prim_name,
																				                    //prim_range,
																				                    //v_city_name,
																				                    //st,
																				                    //zip5
																				                    //app_ssn ???
                                      );

  ds_fc_common_child := //dataset([], TopBusiness_Services.AssociateSection_layouts.rec_child_party);  //vers1 for testing
	                       ds_fc_common_child_normed_dd;


  // NOTICE OF DEFAULT (NOD)
  // *** Key fetch to get data from new BIP2 Property NOD linkids key file.
  ds_nod_linkids_keyrecs := TopBusiness_Services.Key_Fetches(
	                             ds_in_ids_only,
													                 FETCH_LEVEL).ds_nod_linkidskey_recs;

  // Project onto a common slimmed layout
  ds_nod_linkids_keyrecs_slimmed := project(ds_nod_linkids_keyrecs,
		                                            transform(TopBusiness_Services.AssociateSection_layouts.rec_ids_with_linkidsdata_slimmed,
				                                            self.source      := MDR.sourceTools.src_Foreclosures_Delinquent, //???
	                                               //self.source_docid := left.foreclosure_id; //???
	                                               //self.source_recid := left.source_rec_id; //???
                                                //self.nod_name_first   := , //???//... ???
				                                            self.nod_name_company := left.name_company; // nod vers1???
				                                            // ^--- needed for matching to nod fid linkids key until all 6(?) names on there
				                                            //      have an associated set of ids added to the key???
				                                            self.role_source := Constants.ASSOCIATE_ROLE_NOD; // or ..._FC or ..._RP???
			                                             self := left, // to preserve ids & other key fields being kept
				                                            self := [], // to null out any unassigned fields
			                                         ));

  // Sort/dedup by linkids & foreclosure_id to only keep 1(does it matter which one???) record per
	 // linkids/foreclosure_id combo in case there are more than 1.
  ds_nod_linkids_keyrecs_deduped := dedup(sort(ds_nod_linkids_keyrecs_slimmed,
				                                        #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			                         foreclosure_id //, ???
																								                  ),
				                                    #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			                     foreclosure_id);

  // First just get all NOD fid links recs for each set of linkids.
  rec_nod_linkids_party_combo := record
	   BIPV2.IDlayouts.l_header_ids;
	   TopBusiness_Services.AssociateSection_layouts.rec_ids_with_linkidsdata_slimmed.role_source;
		  TopBusiness_Services.AssociateSection_layouts.rec_ids_with_linkidsdata_slimmed.nod_name_Company;
		  recordof(dx_Property.Key_NOD_FID_Linkids) - [name1, name2, name3, name4];
	   BIPV2.IDlayouts.l_header_ids associated_business_linkids1;
	   BIPV2.IDlayouts.l_header_ids associated_business_linkids2;
	   BIPV2.IDlayouts.l_header_ids associated_business_linkids3;
	   BIPV2.IDlayouts.l_header_ids associated_business_linkids4;
	 end;

  // Next join the deduped NOD linkids keyrecs to the NOD fid(party?) plus linkids key to get
	// all of the NOD "party" data for the foreclosure_ids involved to output on the report.
  ds_nod_linkids_keyrecs_plusparty := 
	                         join(ds_nod_linkids_keyrecs_deduped,
	                              dx_Property.Key_NOD_FID_Linkids,
                                   keyed(left.foreclosure_id = right.fid) //AND RIGHT.source=MDR.sourceTools.src_Foreclosures
																								AND right.source IN Foreclosure_Services.Functions.getCodes(in_options.IncludeVendorSourceB)
																	 // vers1, just get all recs because they will have to be normalized first due to multiple names???

														       // vers1b can't do here??? 
																	 // v--- only get the "parties" not on the linkids key,
														       //   i.e. the parties other than the company the report
																	 //        is being run on.
														       //and (left.nod_name_company != right.name1_company
                                   //     and 
                                   //     left.nod_name_company != right.name2_company
                                   //     and
                                   //     ... thru 4th
                                   // and plaintiff_1 and plaintiff_2??? (NO? contains either a company or unparsed person name(s)???)
																		//	 )
																	 // v--- vers 2b, once fid+linkids key is revised ???
																	 // still can't do here???
																	 //and left.seleid != right.name1.seleid //???
														       //and left.seleid != right.name*.seleid //and 3 or 5 others need added to key???
                                   // ...
														       // and that have either a person last name or company name ???
														       //and (right.lname !='' or 
														       //     right.cname !='')
																,
	                              transform(rec_nod_linkids_party_combo,
													         // assign reported on ids from left first because 
														       // right/key has fields with the same name.
														       // v--- revise to use some kind on macro like BIPV2.IDmacros.mac_ListTop3Linkids()???
														       self.ultid  := left.ultid,  
        													 self.orgid  := left.orgid, 
														       self.seleid := left.seleid, 
														       self.proxid := left.proxid, //???
														       self.powid  := left.powid,  //???
														       self.empid  := left.empid,  //???
														       self.dotid  := left.dotid,  //???
												           // associate ids from right/key
														       self.associated_business_linkids1 := right.name1, //vers1???
														       self.associated_business_linkids2 := right.name2, //vers2???
														       self.associated_business_linkids3 := right.name3, //vers2???
														       self.associated_business_linkids4 := right.name4, //vers3???

			                             self := right,
			                             self := left, // to preserve input linkids & any other kept linkids key fields
                                 ),
		                             inner, // only ones that match(?) OR left outer, //???
                                 //keep(TopBusiness_Services.Constants.liens_max_party_recs)); //from bip1??? only keep 100 recs
		                             limit(10000,skip) //???
																);


  // Then sort/dedup all fid (party) key recs by linkids & foreclosure_id since it appears that
	 // some foreclosure_ids have partial duplicate recs/name data (except some dates???, etc.
	 // are different). ???
	 // For example, see foreclosure_id = 7470010520ELCOMPADRELLC
	 //                  (found on ult/org/sele = 7528 as of 11/08/13)
	 ds_nod_linkids_keyrecs_pp_dd := dedup(sort(ds_nod_linkids_keyrecs_plusparty,
				                                      #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			                       foreclosure_id,
																							                   -recording_date // or earliest ???
																							                ),
				                                 #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			                  foreclosure_id);


  // !!!NOTE: Instead of sort/dedup above, may need to "roll up" all nod fid recs for the same
	 // foreclosure_id value to preserve earliest recording date & latest process_date? and to
	 // keep "all" names if some diff on multi recs for the same fc_id???
	 // see foreclosure_id = 7470010520ELCOMPADRELLC


  // Then "Normalize" to put each "name" related field (up to 6?) on a separate record.
	 // NOTE: On the NOD fid (party) linkids key, there are 4 original "*_defendant_borrower_*"
	 // name fields (also stored into "name*" (*=1-4) fields) and 2 unparsed "plaintiff*" (*=1&2)
	 // fields that labeled correctly as opposed to the fields similar foreclosure fid plus linkids key
	 // (See comments above in the Foreclosure tf_norm_fcnames area).
  // ??????????????????????????????????????????????
	 // So the "situs1" address (the address of the property being foreclosed on) should go with
	 // the "*_defendant/name*" fields and the "situs2" address (the mailing address, when present)
	 // should go with the "plaintiff*" fields.
 	TopBusiness_Services.AssociateSection_layouts.rec_child_party tf_norm_nodnames(
    recordof(ds_nod_linkids_keyrecs_pp_dd) L, integer C) := transform
      // trustee ????????????????????????????????????????????????????????????????????
				  // v--- Also below normalize/use: title_company_name, attorney_name (bus & per unparsed?),
				  //      lender_beneficiary_first/last/company_name & trustee_ name (bus & per unparsed?)
				  //      fields???     Ask Tim B.???
      self.company_name           := choose(C, L.name1_company,L.name2_company,L.name3_company,
						                   																		 L.name4_company,L.plaintiff_1,L.plaintiff_2,
																								                    L.trustee_name);
					 // plaintiff* & trustee_name (---^) fields appear to
						// contain either a company name or an unparsed
						// person name/names.
						// So for now(vers1) it was decided to just store
						// plaintiffs into the output "company_name" field
						// until this can be investigated further.
      // nod vers1, next 10 lines  ---v
      self.associated_business_linkids.dotid  := 0;
	     self.associated_business_linkids.empid  := 0;
      self.associated_business_linkids.powid  := 0;
	     self.associated_business_linkids.proxid := 0;
      self.associated_business_linkids.seleid := choose(C,L.associated_business_linkids1.seleid, //vers1???
																											                             L.associated_business_linkids2.seleid, //vers2???
																														                          L.associated_business_linkids3.seleid, //vers2???
																														                          L.associated_business_linkids4.seleid, //vers2???
																														                          0,0); // // 5th & 6th name ids???
	     self.associated_business_linkids.orgid  := choose(C,L.associated_business_linkids1.orgid,  //vers1???
																											                             L.associated_business_linkids2.orgid, //vers2???
																														                          L.associated_business_linkids3.orgid, //vers2???
																														                          L.associated_business_linkids4.orgid, //vers2???
																														                          0,0); // // 5th & 6th name ids???
	     self.associated_business_linkids.ultid  := choose(C,L.associated_business_linkids1.ultid, //vers1???
																											                             L.associated_business_linkids2.ultid, //vers2???
																														                          L.associated_business_linkids3.ultid, //vers2???
																														                          L.associated_business_linkids4.ultid, //vers2???
																														                          0,0); // // 5th & 6th name ids???
				  self.person_name.title       := choose(C, L.name1_prefix,L.name2_prefix,L.name3_prefix,
																								                      L.name4_prefix,'','','');
	     self.person_name.fname       := choose(C, L.name1_first,L.name2_first,L.name3_first,
																								                      L.name4_first,'','','');
	     self.person_name.mname       := choose(C, L.name1_middle,L.name2_middle,L.name3_middle,
																								                      L.name4_middle,'','','');
	     self.person_name.lname       := choose(C, L.name1_last,L.name2_last,L.name3_last,
																								                      L.name4_last,'','','');
	     self.person_name.name_suffix := choose(C, L.name1_suffix,L.name2_suffix,L.name3_suffix,
																								                      L.name4_suffix,'','','');
				  self.did                     := choose(C, L.name1_did,L.name2_did,L.name3_did,
				                                          L.name4_did,'','','');
				  self.ssn                     := choose(C, L.name1_ssn,L.name2_ssn,L.name3_ssn,
				                                          L.name4_ssn,'','','');
				  self.is_deceased             := false,
				  self.has_derog               := false,
				  // nod fid linkids key has multiple "situs1/2" address fields, but which one goes with
				  // which "party"???
				  // situs1 address = foreclosed property address(?) should go with defendant1 (& 2, 3 & 4???) ???
				  // situs2 address = s/b plaintiff1(&2?) mailing address ???
		    self.common_address.prim_range  := choose(C, L.situs1_prim_range, '','','', // 2/3/4 ???
				                                             L.situs2_prim_range, L.situs2_prim_range,''), // both pt1&2 (iteration 5&6)? and 7???
		    self.common_address.predir      := choose(C, L.situs1_predir, '','','', // 2/3/4 ???
				                                             L.situs2_predir, L.situs2_predir,''), // 7???
		    self.common_address.prim_name   := choose(C, L.situs1_prim_name, '','','', // 2/3/4 ???
				                                             L.situs2_prim_name, L.situs2_prim_name,''), // 7???
		    self.common_address.addr_suffix := choose(C, L.situs1_addr_suffix, '','','', // 2/3/4 ???
				                                             L.situs2_addr_suffix, L.situs2_addr_suffix,''), // 7???
		    self.common_address.postdir     := choose(C, L.situs1_postdir, '','','', // 2/3/4 ???
				                                             L.situs2_postdir, L.situs2_postdir,''), // 7???
		    self.common_address.unit_desig  := choose(C, L.situs1_unit_desig, '','','', // 2/3/4 ???
				                                             L.situs2_unit_desig, L.situs2_unit_desig,''), // 7???
		    self.common_address.sec_range   := choose(C, L.situs1_sec_range, '','','', // 2/3/4 ???
				                                             L.situs2_sec_range, L.situs2_sec_range,''), // 7???
		    self.common_address.v_city_name := choose(C, L.situs1_v_city_name, '','','', // 2/3/4 ???
				                                             L.situs2_v_city_name, L.situs2_v_city_name,''), // 7???
		    self.common_address.st          := choose(C, L.situs1_st, '','','', // 2/3/4 ???
				                                             L.situs2_st, L.situs2_st,''), // 7???
		    self.common_address.zip5        := choose(C, L.situs1_zip, '','','', // 2/3/4 ???
				                                             L.situs2_zip, L.situs2_zip,''), // 7???
		    self.common_address.zip4        := choose(C, L.situs1_zip4, '','','', // 2/3/4 ???
				                                             L.situs2_zip4, L.situs2_zip4,''), // 7???
				  self.common_address.fips_county := choose(C, L.situs1_fipscounty, '','','', // 2/3/4 ???
				                                             L.situs2_fipscounty, L.situs2_fipscounty,''), // 7???
      self.associate_type             := choose(C, if(L.name1_company !='',Constants.Business,Constants.Person),
				                                     if(L.name2_company !='',Constants.Business,Constants.Person),
											                              if(L.name3_company !='',Constants.Business,Constants.Person),
											                              if(L.name4_company !='',Constants.Business,Constants.Person),
											                              Constants.Business, //L.plaintiff_1, 1 field for either a company name or an unparsed person name(s)
											                              Constants.Business, //L.plaintiff_2, 1 field for either a company name or an unparsed person name(s)
											                              Constants.Business  //L.trustee_name, 1 field for either a company name or an unparsed person name(s)
                                         );

				  self.date_first_seen            := if(L.filing_date != '',
				                                      L.filing_date,L.recording_date); //???
				  self.date_last_seen             := L.process_date;  //???
				  self.date_vendor_last_reported  := L.process_date; //???
			   self := L, // to preserve ids & other fields being kept with same name
				  self := [], // to null out any unassigned fields, 2 total_* fields??
  end;

  ds_nod_common_child_normed := normalize(ds_nod_linkids_keyrecs_pp_dd,
                                          7, //up to 4 defendants(names*), 2 plaintiffs and
																						                    // 1 trustee_name ???
                                          tf_norm_nodnames(left, counter));

	// Might have empty or duplicate party names or the company_name is the same as the
	// company that is being reported on; so filter/sort/dedup to remove those conditions.
	// Keep recs with address or ssn info as opposed to those without. ???
	ds_nod_common_child_normed_dd := dedup(sort(ds_nod_common_child_normed(
	                                         (company_name != '' and
																								                  (company_name != nod_name_company or
																									                 (associated_business_linkids.seleid != 0 and
																									                 seleid != associated_business_linkids.seleid))) or
	                                         person_name.lname !=''),  //???
				                                      #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																						                    //associate_type???
																						                    company_name,
																						                    // ^--- and/or use 1-4 associated_business_linkids???
																						                    // ultid, orgid, seleid ???
																						                    //associated_business_linkids1.seleid, //???, vers2 once all 4/6? filled in
																						                    if(did !='000000000000',did,''), // ???
																						                    person_name.lname,person_name.fname,-person_name.mname, //???
																						                    //-prim_name,
																						                    //-prim_range,
																						                    //-v_city_name,
																						                    //-st,
																						                    //-zip5,
																						                    //-ssn???
																						                    -date_last_seen  //???
																						                  ),
				                                  #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			                   company_name,
																			                   //associated_business_linkids1.seleid, //vers2???
																			                   if(did !='000000000000',did,''), // ???
																			                   person_name.lname,person_name.fname //,person_name.mname //???
																				                  //prim_name,
																				                  //prim_range,
																				                  //v_city_name,
																				                  //st,
																				                  //zip5
																				                  //ssn ???
                                    );

  ds_nod_common_child := ds_nod_common_child_normed_dd;

  //function to fix bug - RR-18344
  date_convertToString8 (string8 date) := function
    date_val := IF(LENGTH(TRIM(date)) = 6 , TRIM(date) + '00', date);
    return date_val;
  end;

  // Once all data is fetched & processed, concatenate common child datasets from all sources.
	 ds_all_common_child := ds_bankr_common_child +
	                        ds_liens_common_child +
                        
	                        project(ds_mvr_common_child, 
                           transform(TopBusiness_Services.AssociateSection_layouts.rec_child_party,
                             self.date_first_seen           := date_convertToString8(left.date_first_seen),
                             self.date_last_seen            := date_convertToString8(left.date_last_seen),
                             self.date_vendor_last_reported := date_convertToString8(left.date_vendor_last_reported),
                             self                           := left)) +
                        
                         project(ds_ucc_common_child, 
                           transform(TopBusiness_Services.AssociateSection_layouts.rec_child_party,
                             self.date_first_seen           := date_convertToString8(left.date_first_seen),
                             self.date_last_seen            := date_convertToString8(left.date_last_seen),
                             self.date_vendor_last_reported := date_convertToString8(left.date_vendor_last_reported),
                             self                           := left)) +
                        
	                        ds_wc_common_child    +
                         
                         project(ds_prop_common_child, 
                           transform(TopBusiness_Services.AssociateSection_layouts.rec_child_party,
                             self.date_first_seen           := date_convertToString8(left.date_first_seen),
                             self.date_last_seen            := date_convertToString8(left.date_last_seen),
                             self.date_vendor_last_reported := date_convertToString8(left.date_vendor_last_reported),
                             self                           := left)) +
                        
	                        ds_fc_common_child    +
	                        ds_nod_common_child;

  // First sort all recs for a set of reported on linkids & person associate (non zero did) or
  // business associtate (non-zero comp linkids)???
  ds_all_common_child_sorted := dedup(sort(ds_all_common_child,
 				                                   #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																		                      associate_type,
																		                      if(associated_business_linkids.ultid !=0, associated_business_linkids.ultid,0), //???
                                        if(associated_business_linkids.orgid !=0, associated_business_linkids.orgid,0),  //???
																		                      if(associated_business_linkids.seleid !=0, associated_business_linkids.seleid,0), //???, //vers2 once all 3 filled in???
																			                     // ^--- associated_business_linkids and company_name ---v ???
																	                       company_name,
																		                      if(did !='000000000000',did,''), // ...,hash(lname, fname, address parts?)), // if use this, then don't need fields below???
																			                     if(ssn !='', ssn,''),
																			                     // ^--- did and ssn? and f/m?/l name parts ---v???
																		                      person_name.lname,person_name.fname, person_name.mname,
																		                      //-prim_name,//prefer ones with addr parts vs ones without???
																		                      //-prim_range,
																		                      //-v_city_name,
																		                      //-st,
																		                      //-zip5,
																			                     role_source,
																			                     //date_first_seen  //lowest first seen???
																		                      date_last_seen  //lowest last seen???
                                      ),
 				                               #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																		                  associate_type,
																		                  if(associated_business_linkids.ultid !=0, associated_business_linkids.ultid,0), //???
                                    if(associated_business_linkids.orgid !=0, associated_business_linkids.orgid,0),  //???
																		                  if(associated_business_linkids.seleid !=0, associated_business_linkids.seleid,0), //???, //vers2 once all 3 filled in???
																			                 // ^--- associated_business_linkids and company_name ---v ???
																	                   company_name,
																		                  if(did !='000000000000',did,''), // ...,hash(lname, fname, address parts?)), // if use this, then don't need fields below???
																			                 if(ssn !='', ssn,''),
																			                 // ^--- did and ssn? and f/m?/l name parts ---v???
																		                  person_name.lname,person_name.fname, person_name.mname,
																		                  //-prim_name,//all addr parts ---v ???
																		                  //-prim_range,
																		                  //-v_city_name,
																		                  //-st,
																		                  //-zip5,
																			                 role_source
																	               );

  // Rollup record pairs for the same entity (person/did/ssn & company/linkids) into 1 rec
	 // keeping all the role values separated by a ";" (or a ???) to signify to the gui to
	 // separate with line break(?).
  TopBusiness_Services.AssociateSection_layouts.rec_child_party  tf_rollup_common_child(
	   TopBusiness_Services.AssociateSection_layouts.rec_child_party l,
	   TopBusiness_Services.AssociateSection_layouts.rec_child_party r) := transform
      // fix date first/last seen to add dd=00 if missing???
	  	  //string8 fix_ldfs := if(l.date_first_seen[7..8] != '  ', l.date_first_seen,...), ???
			   //... ???
      // keep lowest date_first_seen
	  	  self.date_first_seen := if(l.date_first_seen <= r.date_first_seen,
			                              l.date_first_seen, r.date_first_seen);
		    // keep highest date_last_seen
	  	  self.date_last_seen  := if(l.date_last_seen >= r.date_last_seen,
			                              l.date_last_seen, r.date_last_seen);
		    // accumulate role values separating with a ";" // OR ???
      self.role_source := trim(l.role_source,left,right) +
			                         if(r.role_source !='',';'+ trim(r.role_source,left,right),''); //ask Todd Rider???
      //other fields, use l (left)
      self := l;
  end;

  ds_all_common_child_rolled := rollup(ds_all_common_child_sorted, tf_rollup_common_child(left,right),
                                  #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
															                   associate_type,
															                   if(associated_business_linkids.ultid !=0, associated_business_linkids.ultid,0), //???
                                  if(associated_business_linkids.orgid !=0, associated_business_linkids.orgid,0),  //???
															                   if(associated_business_linkids.seleid !=0, associated_business_linkids.seleid,0), //???, //vers2 once all 3 filled in???
																			               // ^--- associated_business_linkids and company_name ---v ???
															                   company_name,
															                   if(did !='000000000000',did,''), // ...,hash(lname, fname, address parts?)), // if use this, then don't need fields below???
																			               if(ssn !='', ssn,''),
																			               // ^--- did and ssn? and f/m?/l name parts ---v ???
															                   person_name.lname,person_name.fname,person_name.mname
																			               //prim_name, //also addr parts to keep all unique name/addr pairs???
																		                //prim_range,
																		                //v_city_name,
																		                //st,
																		                //zip5
                                );

  // Remove people that are "executive"s for the set of linkids, since they will be listed
	 // in the Contact "current/prior executives" section.

	 // First join the input linkids to the "Contact" linkids key to get all contacts including
	 // "Executives" for the company being reported on.
  // ds_contact_linkids_keyrecs := BIPV2_Build.key_contact_linkids.kFetch(
	                                   // ds_in_ids_only, // input file to join key with
													           // FETCH_LEVEL)(source <> 'D' and source <> ''); // level of ids to join with
							  					           // 3rd parm is ScoreThreshold, take default of 0


	 ds_contact_linkids_keyrecs := TopBusiness_Services.Key_Fetches(
																			               ds_in_ids_only,
																		                FETCH_LEVEL,TopBusiness_Services.Constants.ContactsKfetchMaxLimit
																		                ).ds_contact_linkidskey_recs
																		                (source <> 'D' and source <> ''); // level of ids to join with
							  					                    // 3rd parm is ScoreThreshold, take default of 0

	// Next filter/sort/dedup to just include unique "Executives".
  ds_contact_linkids_keyrecs_execs := dedup(sort(ds_contact_linkids_keyrecs(executive_ind),
 	                                            #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																		                            contact_did,
																								                      //ssn???
																								                      //v--- in case did=0???
																								                      contact_name.fname,
																								                      contact_name.mname, //???
																								                      contact_name.lname,
																				                          -dt_last_seen),
	                                           #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
															                             contact_did,
																						                      //ssn???
																						                      //v--- in case did=0???
																				                        contact_name.fname,
																						                      contact_name.mname, //???
																						                      contact_name.lname
                                          );

  // Split into separate datasets for business & person associates
	 ds_all_common_child_rolled_bus := ds_all_common_child_rolled(associate_type != Constants.PERSON);
	 ds_all_common_child_rolled_per := ds_all_common_child_rolled(associate_type = Constants.PERSON);


	 // Then join all person associates to the "executives" from the Contact key to
	 // only keep person associates that are NOT executives.
  ds_all_common_child_nonexecs := join(ds_all_common_child_rolled_per,
	                                      ds_contact_linkids_keyrecs_execs,
																								               BIPV2.IDmacros.mac_JoinTop3Linkids() and
																								               ((integer) left.did = right.contact_did),
																								                 transform(left),
																								                   left only //only keep left recs that don't match to right???
																								                   //,keep(?),      ???
																								                   //,limit(?)      ???
																								               );

  // Also pull recs by did and/or ssn???


	 // Count the number of total business & non-executive person associates for each set of linkids
	 // before limiting them to 100 (most recent) of each.
  //
  // First sort on just the fields to be tabled/counted: linkids & associate_type.
	 //
	 ds_all_common_child_comb := ds_all_common_child_rolled_bus +
	                             ds_all_common_child_nonexecs;

  ds_all_tblsrtd := sort(ds_all_common_child_comb,
				                  #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
											           associate_type);

	ds_all_tabled := table(ds_all_tblsrtd,
	                       // v--- Create table layout on the fly
                          {#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
													             associate_type,
											               bp_count := count(group)
												              },
												            // table on top 3 linkids & type(b or p)
                        #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
												            associate_type,
												            few); //???

  // Join count of the number of business & person associates per set of linkids back to
  // all child recs to attach the total counts to all records for the set of linkids.
	 ds_all_common_child_wcounts := join(ds_all_common_child_comb,
																		                    ds_all_tabled,
																                      BIPV2.IDmacros.mac_JoinTop3Linkids()
																                      and left.associate_type = right.associate_type,
																		                      transform(TopBusiness_Services.AssociateSection_layouts.rec_child_party,
																		                        self.total_business := if(left.associate_type=Constants.BUSINESS,right.bp_count,0);
																		                        self.total_person   := if(left.associate_type=Constants.PERSON,right.bp_count,0);
																			                       self                := left
                                        ),
																		                    inner, //???
																		                    //keep(1)  //???
																		                    limit(10000,skip) //chg to use ???.Constants.???
																		                  );

  // Now that total possible business/person counts have been determined; chop the dataset of
	 // records per set of linkids here to just the most recent 100 business and
	 // 100 person associates records for each set of linkids (reqs 1280 & 1410).
	 //
  // First, sort/dedup records with bp counts by: linkids, associate_type indicator and
	 // descending by date_vendor_last_reported to keep the most recent 100 of each type.
  ds_all_common_child_top100_bp := dedup(sort(ds_all_common_child_wcounts,
	                                          #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																		                         associate_type,
																				                       -date_vendor_last_reported
                                         ), //most recent???
	                                      #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																	                      associate_type,
																				                   keep(iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_ASSOCIATE_RECORDS)); //100


  // Next, for the top 100 to be used, split out business assoc recs and person records into
  // separate datasets, so for person associates we can set a deceased indicator, do ssn masking
	 // and set a "has_derog" indicator.
  // Then later recombine revised person recs with the remaining business ones.
  ds_all_common_child_top100_bus := ds_all_common_child_top100_bp(associate_type = Constants.BUSINESS);
  ds_all_common_child_top100_per := ds_all_common_child_top100_bp(associate_type = Constants.PERSON);


  // Fill in is_deceased indicator here for only person associate records.
  ds_dids_deceased := DeathV2_Services.raw.get_report.FROM_DIDS(
	                       project(ds_all_common_child_top100_per,
			                               transform({unsigned6 did},
																                    self.did := (unsigned6) left.did)),
											                         mod_access.ssn_mask);

  ds_all_common_child_top100_per_decind := join(ds_all_common_child_top100_per,
	                                               ds_dids_deceased,
			                                             left.did = right.did,
															                                   transform(TopBusiness_Services.AssociateSection_layouts.rec_child_party,
															                                     self.is_deceased := ((unsigned6) right.did) != 0;
															                                     self             := left),
															                                left outer, // all recs from left even if no match to right
																							                        keep(1));  // chg to Constants.???

  // Mask any SSNs on the party records.
	 Suppress.MAC_Mask(ds_all_common_child_top100_per_decind,
	                   ds_all_common_child_top100_per_masked, ssn, blank, true, false, , , ,mod_access.ssn_mask);


  // Fill in has_derog indicator here for only person associate records.
  ds_all_common_child_top100_per_derogb := join(ds_all_common_child_top100_per_masked,
	                                               BankruptcyV3.key_bankruptcyv3_did(),
	                                               keyed((unsigned6)left.did = right.did),
																							                           transform(TopBusiness_Services.AssociateSection_layouts.rec_child_party,
															                                     self.has_derog := right.did != 0;
												                                        self           := left
                                                  ),
	  										                                   left outer, keep(1)); //???

	 ds_all_common_child_top100_per_derogl:= join(ds_all_common_child_top100_per_derogb,
	                                              LiensV2.key_liens_DID,
			                                            keyed((unsigned6)left.did = right.did),
																							                          transform(TopBusiness_Services.AssociateSection_layouts.rec_child_party,
															                                    self.has_derog := if(left.has_derog,left.has_derog,if(right.did != 0,true,false)),
													                                      self           := left
                                                 ),
													                                  left outer, keep(1)); //???

  ds_all_common_child_top100_per_derogf := join(ds_all_common_child_top100_per_derogl,
	                                               dx_Property.Key_Foreclosure_DID,
			                                             keyed((unsigned6)left.did = right.did),
																							                           transform(TopBusiness_Services.AssociateSection_layouts.rec_child_party,
															                                     self.has_derog := if(left.has_derog,left.has_derog,if(right.did != 0,true,false)),
													                                       self := left
                                                  ),
													                                   left outer, keep(1)); //???

	ds_all_common_child_top100_per_derogn:= join(ds_all_common_child_top100_per_derogf,
	                                             dx_Property.Key_NOD_DID,
			                                           keyed((unsigned6)left.did = right.did),
																							                         transform(TopBusiness_Services.AssociateSection_layouts.rec_child_party,
															                                   self.has_derog := if(left.has_derog,left.has_derog,if(right.did != 0,true,false)),
													                                     self           := left
                                                ),
													                                 left outer, keep(1)); //???

  // Combine business & revised person associate records back together
  ds_all_common_child_top100_bp2 :=  sort(ds_all_common_child_top100_bus +
																					                     ds_all_common_child_top100_per_derogn,
                                          #expand(BIPV2.IDmacros.mac_ListTop3Linkids())
																					                    );

  // Next create a parent layout dataset with 1 empty record for each set of linkids
	 // to be used for denormalizing below.
  ds_parent_empty_recs := project(dedup(sort(ds_all_common_child_top100_bp2,
	                                         #expand(BIPV2.IDmacros.mac_ListTop3Linkids())),
	                                       #expand(BIPV2.IDmacros.mac_ListTop3Linkids())),
																	                         transform(TopBusiness_Services.AssociateSection_layouts.rec_parent_section,
																		                          self := left,
																		                          self := []));

  // Denormalize to attach all child recs for a set of linkids to their parent rec.
  TopBusiness_Services.AssociateSection_layouts.rec_parent_section tf_denorm_children(
		  TopBusiness_Services.AssociateSection_layouts.rec_parent_section L,
	     dataset(TopBusiness_Services.AssociateSection_layouts.rec_child_party) R) := transform
        // Determine total values
		      self.total_business := max(R,total_business);
		      self.total_person   := max(R,total_person);
			     // Fill in the child datasets.
			     // sort child ds recs into final output/display order here (---v) or below???
			     self.business_associates := choosen(project(sort(R(associate_type=Constants.BUSINESS), company_name
																                       //also address fields and/or role_source???
																	                     ),
																	                     TopBusiness_Services.AssociateSection_layouts.rec_child_Party),
				                                  iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_ASSOCIATE_RECORDS);
			     self.person_associates   := choosen(project(sort(R(associate_type=Constants.PERSON),
			                                   person_name.lname, person_name.fname,
																                      person_name.mname, person_name.name_suffix
																                      // also address fields and/or role_source???
																	                     ),
															                       TopBusiness_Services.AssociateSection_layouts.rec_child_Party),
				                                  iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_ASSOCIATE_RECORDS);
			     self := L;
	 end;

  ds_parent_child := denormalize(ds_parent_empty_recs,
                                 ds_all_common_child_top100_bp2,
	                                BIPV2.IDmacros.mac_JoinTop3Linkids(),
		                             group,
		                             tf_denorm_children(left,rows(right)));


  // Transforms to project the parent & child recs into the BIP report Associate section
	 // iesp layout fields.
  //
  // The transform to handle the Business Associate child dataset
	 iesp.TopBusinessReport.t_TopBusinessAssociateBusiness
	   tf_child_business(TopBusiness_Services.AssociateSection_layouts.rec_child_party l) := transform
      self.CompanyName                 := l.company_name,
		    self.BusinessIds                 := l.associated_business_linkids,
      self.Address.StreetName          := l.common_address.prim_name,
		    self.Address.StreetNumber        := l.common_address.prim_range,
		    self.Address.StreetPreDirection  := l.common_address.predir,
		    self.Address.StreetPostDirection := l.common_address.postdir,
		    self.Address.StreetSuffix        := l.common_address.addr_suffix,
		    self.Address.UnitDesignation     := l.common_address.unit_desig,
		    self.Address.UnitNumber          := l.common_address.sec_range,
		    self.Address.City                := l.common_address.v_city_name,
		    self.Address.State               := l.common_address.st,
		    self.Address.Zip5                := l.common_address.zip5,
		    self.Address.Zip4                := l.common_address.zip4,
      self.Address.StreetAddress1      := '',
      self.Address.StreetAddress2      := '',
      self.Address.County              := Functions_Source.get_county_name(
		                                        l.common_address.st,l.common_address.fips_county),
      self.Address.PostalCode          := '',
      self.Address.StateCityZip        := '',
		    self.Role                        := l.role_source,
	 end;

  // The transform to handle the Person Associate child dataset
	 iesp.TopBusinessReport.t_TopBusinessAssociatePerson
	   tf_child_person(TopBusiness_Services.AssociateSection_layouts.rec_child_party l) := transform
      self.Name.Full                   := '';
      self.Name.First                  := l.person_name.fname;
	     self.Name.Middle                 := l.person_name.mname;
	     self.Name.Last                   := l.person_name.lname;
	     self.Name.Suffix                 := l.person_name.name_suffix;
      self.Name.Prefix                 := l.person_name.title;
		    self.UniqueId                    := l.did,
      self.IsDeceased                  := l.is_deceased,
		    self.HasDerog                    := l.has_derog,
      self.Address.StreetName          := l.common_address.prim_name,
		    self.Address.StreetNumber        := l.common_address.prim_range,
		    self.Address.StreetPreDirection  := l.common_address.predir,
		    self.Address.StreetPostDirection := l.common_address.postdir,
		    self.Address.StreetSuffix        := l.common_address.addr_suffix,
		    self.Address.UnitDesignation     := l.common_address.unit_desig,
		    self.Address.UnitNumber          := l.common_address.sec_range,
		    self.Address.City                := l.common_address.v_city_name,
		    self.Address.State               := l.common_address.st,
		    self.Address.Zip5                := l.common_address.zip5,
		    self.Address.Zip4                := l.common_address.zip4,
      self.Address.StreetAddress1      := '',
      self.Address.StreetAddress2      := '',
      self.Address.County              := Functions_Source.get_county_name(
		                                        l.common_address.st,l.common_address.fips_county),
      self.Address.PostalCode          := '',
      self.Address.StateCityZip        := '',
		    self.FromDate                    := iesp.ECL2ESP.toDate ((integer)l.date_first_seen),
		    self.ToDate                      := iesp.ECL2ESP.toDate ((integer)l.date_last_seen),
		    self.Role                        := l.role_source,
		    self.SSN                         := l.ssn,
  end;

  // The transform to store data in the iesp Associate Section parent dataset fields
  TopBusiness_Services.AssociateSection_layouts.rec_ids_plus_AssociateSection tf_rollup_rptdetail(
	   TopBusiness_Services.AssociateSection_layouts.rec_parent_section l,
	   dataset(TopBusiness_Services.AssociateSection_layouts.rec_parent_section) allrows) := transform
      self.acctno              := '';  // just null out here; it will be assigned in a join below
      self.ReturnBusinessCount := count(allrows.business_associates);
	     self.TotalBusinessCount  := l.total_business;
			   self.BusinessAssociates  := choosen(project(allrows.business_associates,
			                                         tf_child_business(left)),
																                            iesp.Constants.TopBusiness.MAX_COUNT_BIZRPT_ASSOCIATE_RECORDS);
      self.ReturnPersonCount   := count(allrows.person_associates);
	     self.TotalPersonCount    := l.total_person;
			   self.PersonAssociates    := choosen(project(allrows.person_associates,
			                                         tf_child_person(left)),
																                            iesp.Constants.TopBusiness.MAX_COUNT_BIZRPT_ASSOCIATE_RECORDS);
      self := l; //to assign all BusinessIds.linkids
	 end;

  // Sort/Group all recs for a set of linkids.
  ds_all_rptdetail_grouped := group(sort(ds_parent_child,
		                                    #expand(BIPV2.IDmacros.mac_ListTop3Linkids())
																			                 ),
                                  #expand(BIPV2.IDmacros.mac_ListTop3Linkids())
																                );

  // Rollup all recs for a set of linkids.
  ds_all_rptdetail_rolled := rollup(ds_all_rptdetail_grouped,
																               group,
																                 tf_rollup_rptdetail(left,rows(left)));

  // Attach input acctnos back to the linkids.
  ds_all_wacctno_joined := join(ds_in_ids_wacctno,ds_all_rptdetail_rolled,
																	               BIPV2.IDmacros.mac_JoinTop3Linkids(),
														                    transform(TopBusiness_Services.AssociateSection_layouts.rec_ids_plus_AssociateSection,
														                      self.acctno   := left.acctno,
															                     self          := right),
														                      left outer); // 1 output rec for every left (in_data) rec

	 // Roll up all recs for the acctno.
	 ds_final_results := rollup(group(sort(ds_all_wacctno_joined,acctno),acctno),
	                        group,
		                         transform(TopBusiness_Services.AssociateSection_layouts.rec_final,
			                          self := left));
  // Uncomment for debugging
  // output(ds_in_ids_wacctno,                     named('ds_in_ids_wacctno'));
	 // output(ds_in_ids_only,                        named('ds_in_ids_only'));

  // output(ds_bankr_linkids_keyrecs,              named('ds_bankr_linkids_keyrecs'));
  // output(ds_bankr_linkids_keyrecs_slimmed,      named('ds_bankr_linkids_keyrecs_slimmed'));
  // output(ds_bankr_linkids_keyrecs_deduped,      named('ds_bankr_linkids_keyrecs_deduped'));
  // output(ds_bankr_linkids_keyrecs_plusparty,    named('ds_bankr_linkids_keyrecs_plusparty'));
  // output(ds_bankr_linkids_keyrecs_plusparty_dd, named('ds_bankr_linkids_keyrecs_plusparty_dd'));
  // output(ds_bankr_common_child,                 named('ds_bankr_common_child'));
  // output(ds_liens_linkids_keyrecs,              named('ds_liens_linkids_keyrecs'));
  // output(ds_liens_linkids_keyrecs_slimmed,      named('ds_liens_linkids_keyrecs_slimmed'));
  // output(ds_liens_linkids_keyrecs_deduped,      named('ds_liens_linkids_keyrecs_deduped'));
  // output(ds_liens_linkids_keyrecs_plusparty,    named('ds_liens_linkids_keyrecs_plusparty'));
  // output(ds_liens_linkids_keyrecs_plusparty_dd, named('ds_liens_linkids_keyrecs_plusparty_dd'));
  // output(ds_liens_common_child,                 named('ds_liens_common_child'));
  // output(choosen(ds_mvr_linkids_keyrecs,100),               named('ds_mvr_linkids_keyrecs'));
  // output(choosen(ds_mvr_linkids_keyrecs_slimmed,100),       named('ds_mvr_linkids_keyrecs_slimmed'));
  // output(choosen(ds_mvr_linkids_keyrecs_deduped,100),       named('ds_mvr_linkids_keyrecs_deduped'));
  // output(choosen(ds_mvr_linkids_keyrecs_plusparty,100),     named('ds_mvr_linkids_keyrecs_plusparty'));
  // output(choosen(ds_mvr_linkids_keyrecs_plusparty_dd,100),  named('ds_mvr_linkids_keyrecs_plusparty_dd'));
  // output(choosen(ds_mvr_common_child,100),                  named('ds_mvr_common_child'));
  // output(choosen(ds_ucc_linkids_keyrecs,100),                named('ds_ucc_linkids_keyrecs'));
  // output(choosen(ds_ucc_linkids_keyrecs_slimmed,100),        named('ds_ucc_linkids_keyrecs_slimmed'));
  // output(choosen(ds_ucc_linkids_keyrecs_deduped1,100),       named('ds_ucc_linkids_keyrecs_deduped1'));
  // output(choosen(ds_ucc_linkids_keyrecs_deduped2,100),       named('ds_ucc_linkids_keyrecs_deduped2'));
  // output(choosen(ds_ucc_linkids_keyrecs_plusparty,100),      named('ds_ucc_linkids_keyrecs_plusparty'));
  // output(choosen(ds_ucc_linkids_keyrecs_plusparty_dd,100),   named('ds_ucc_linkids_keyrecs_plusparty_dd'));
  // output(choosen(ds_ucc_common_child,100),                   named('ds_ucc_common_child'));
  // output(ds_wc_linkids_keyrecs,                 named('ds_wc_linkids_keyrecs'));
  // output(ds_wc_linkids_keyrecs_slimmed,         named('ds_wc_linkids_keyrecs_slimmed'));
  // output(ds_wc_linkids_keyrecs_deduped,         named('ds_wc_linkids_keyrecs_deduped'));
  // output(ds_wc_linkids_keyrecs_plusparty,       named('ds_wc_linkids_keyrecs_plusparty'));
  // output(ds_wc_linkids_keyrecs_plusparty_dd,    named('ds_wc_linkids_keyrecs_plusparty_dd'));
  // output(ds_wc_common_child,                    named('ds_wc_common_child'));
  // output(ds_prop_linkids_keyrecs,               named('ds_prop_linkids_keyrecs'));
  // output(ds_prop_linkids_keyrecs_slimmed,       named('ds_prop_linkids_keyrecs_slimmed'));
  // output(ds_prop_linkids_keyrecs_deduped,       named('ds_prop_linkids_keyrecs_deduped'));
  // output(ds_prop_linkids_keyrecs_plusparty,     named('ds_prop_linkids_keyrecs_plusparty'));
  // output(ds_prop_linkids_keyrecs_plusparty_dd,  named('ds_prop_linkids_keyrecs_plusparty_dd'));
  // output(ds_prop_common_child,                  named('ds_prop_common_child'));

  // output(ds_fc_linkids_keyrecs,              named('ds_fc_linkids_keyrecs'));
  // output(ds_fc_linkids_keyrecs_slimmed,      named('ds_fc_linkids_keyrecs_slimmed'));
  // output(ds_fc_linkids_keyrecs_deduped,      named('ds_fc_linkids_keyrecs_deduped'));
  // output(ds_fc_linkids_keyrecs_plusparty,    named('ds_fc_linkids_keyrecs_plusparty'));
  // output(ds_fc_linkids_keyrecs_pp_dd,        named('ds_fc_linkids_keyrecs_pp_dd'));
  // output(ds_fc_common_child_normed,          named('ds_fc_common_child_normed'));
  // output(ds_fc_common_child_normed_dd,       named('ds_fc_common_child_normed_dd'));
  // output(ds_fc_common_child,                 named('ds_fc_common_child'));

  // output(ds_nod_linkids_keyrecs,              named('ds_nod_linkids_keyrecs'));
  // output(ds_nod_linkids_keyrecs_slimmed,      named('ds_nod_linkids_keyrecs_slimmed'));
  // output(ds_nod_linkids_keyrecs_deduped,      named('ds_nod_linkids_keyrecs_deduped'));
  // output(ds_nod_linkids_keyrecs_plusparty,    named('ds_nod_linkids_keyrecs_plusparty'));
  // output(ds_nod_linkids_keyrecs_pp_dd,        named('ds_nod_linkids_keyrecs_pp_dd'));
  // output(ds_nod_common_child_normed,          named('ds_nod_common_child_normed'));
  // output(ds_nod_common_child_normed_dd,       named('ds_nod_common_child_normed_dd'));
  // output(ds_nod_common_child,                 named('ds_nod_common_child'));

  // output(choosen(ds_all_common_child,1000),              named('ds_all_common_child'));
  // output(choosen(ds_all_common_child_sorted,1000),       named('ds_all_common_child_sorted'));
  // output(choosen(ds_all_common_child_rolled,1000),       named('ds_all_common_child_rolled'));
	 // output(ds_contact_linkids_keyrecs,       named('ds_contact_linkids_keyrecs'));
  // output(ds_contact_linkids_keyrecs_execs, named('ds_contact_linkids_keyrecs_execs'));
	 // output(ds_all_common_child_rolled_bus,   named('ds_all_common_child_rolled_bus'));
	 // output(ds_all_common_child_rolled_per,   named('ds_all_common_child_rolled_per'));
  // output(ds_all_common_child_nonexecs,     named('ds_all_common_child_nonexecs'));
  // output(ds_all_common_child_comb,         named('ds_all_common_child_comb'));

  // output(ds_all_tblsrtd,                   named('ds_all_tblsrtd'));
  // output(ds_all_tabled,                    named('ds_all_tabled'));
  // output(ds_all_common_child_wcounts,      named('ds_all_common_child_wcounts'));
  // output(ds_all_common_child_top100_bp,    named('ds_all_common_child_top100_bp'));

  // output(ds_all_common_child_top100_bus,   named('ds_all_common_child_top100_bus'));
  // output(ds_all_common_child_top100_per,   named('ds_all_common_child_top100_per'));
  // output(ds_dids_deceased,                       named('ds_dids_deceased'));
  // output(ds_all_common_child_top100_per_decind,  named('ds_all_common_child_top100_per_decind'));
  // output(ds_all_common_child_top100_per_masked,  named('ds_all_common_child_top100_per_masked'));
  // output(ds_all_common_child_top100_per_derogb,  named('ds_all_common_child_top100_per_derogb'));
  // output(ds_all_common_child_top100_per_derogl,  named('ds_all_common_child_top100_per_derogl'));
  // output(ds_all_common_child_top100_per_derogf,  named('ds_all_common_child_top100_per_derogf'));
  // output(ds_all_common_child_top100_per_derogn,  named('ds_all_common_child_top100_per_derogn'));
  // output(ds_all_common_child_top100_bp2,         named('ds_all_common_child_top100_bp2'));

  // output(ds_parent_empty_recs,           named('ds_parent_empty_recs'));
  // output(ds_parent_child,                named('ds_parent_child'));
	 // output(ds_all_rptdetail_grouped,       named('ds_all_rptdetail_grouped'));
  // output(ds_all_rptdetail_rolled,        named('ds_all_rptdetail_rolled'));
  // output(ds_all_wacctno_joined,          named('ds_all_wacctno_joined'));

	 // return ds_in_ids_wacctno;
	 // return ds_all_common_child_rolled;
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
assoc_sec := TopBusiness_Services.AssociateSection.fn_FullView(
             dataset([
						          //{'test-B1d', 0, 0, 0, 977876, 977876, 977876, 977876} // bankr, 1 bus & 5 person(1 attorney, 1 trustee  & 3 debtors) assocs
						          //{'test-B1p', 0, 0, 0, 149, 149, 149, 149} // bankr, 1 bus(attorney) & 2 person(1 attorney, 1 debtor) assocs
											//{'test-B2p', 0, 0, 0, 70191241, 70191241, 70191241, 70191241} // bankr, 1 bus & 5 person(1 attorney, 1 trustee  & 3 debtors) assocs
						          //{'test-L1', 0, 0, 0, 123, 123, 123, 123} // liens, 2 bus assocs
						          //{'test-L2', 0, 0, 0, 378, 378, 378, 378} // liens, 1 bus assoc
						          //{'test-L3', 0, 0, 0, 510, 510, 510, 510} // liens, 2 bus assocs
						          //{'test-L4', 0, 0, 0, 766, 766, 766, 766} // liens, 1 bus(attorney) & 2 person assocs
						          //{'test-LU5p', 0, 0, 0, 0, 86030884, 86030884, 86030884} // bug 133469; 2 liens & 1 UCC bus assocs
						          //{'test-L6p', 0, 0, 0, 0, 37, 37, 37} // bug 126371, liens, 2 bus & 1 person (with derog) assocs
						          //{'test-M1', 0, 0, 0, 165, 165, 165, 165} // mvr, 1 bus assoc
						          //{'test-M2', 0, 0, 0, 241, 241, 241, 241} // mvr, 5 linkidskey recs/3 vehs, 1 unique bus assoc w/ret linkids
						          //{'test-U1p', 0, 0, 0, 88, 88, 88, 88} // uccs, 5 bus & 1 per assocs
						          //{'test-W1', 0, 0, 0, 686, 686, 686, 686} // wc, 1 person assoc
						          //{'test-W2', 0, 0, 0, 41112, 41112, 41112, 41112} // wc, 1 bus assoc with same name diff addr as comp being rptd on
						          //{'test-W3p', 0, 0, 0, 0, 15054936, 15054936, 15054936} // bug 126735&12675, watercraft, dupe person assocs & add from/to dates
                      //{'test-W4p', 0, 0, 0, 0, 15054936, 15054936, 15054936} // bug 126355, 17 wc linkids recs & 10 person associates (s/b 12 assocs)
						          //{'test-P1d', 0, 0, 0, 79, 79, 79, 79} // property, 1 person assoc
						          //{'test-P2d', 0, 0, 0, 152, 152, 152, 152} // property, 1? business assoc
                      //{'test-P3p', 0, 0, 0, 613, 613, 613, 613} // property, 2/1 bus assoc (1 name, 2 addrs)& 2/1 person assocs (1 name, 2 addrs)
						          //{'test-PW4p', 0, 0, 0, 0, 15054936, 15054936, 15054936} // bugs 126356 & 126358, property, 0 person assocs (after execs removed)
                      //{'test-F1p', 0, 0, 0, 0, 888, 888, 888} // foreclosure, 1 fc linkids key recs; 1 bus (actually a person) assocs & 0 person assocs
                      //{'test-F2p', 0, 0, 0, 0, 7528, 7528, 7528} // foreclosure, 1 fc linkids key recs; 2 bus assocs & 0 person assocs
                      //{'test-F3p', 0, 0, 0, 0, 4790, 4790, 4790} // foreclosure, 2 fc linkids key recs; 1 bus assoc & 1 person assoc(an unparsed person name)
                      //{'test-F4p', 0, 0, 0, 0, 9187, 9187, 9187} // foreclosure, 2 fc linkids key recs; 0 bus assocs & 2 person assocs (1 is a single name & the other is 2 person names in the plaintiff2 field)
                      //{'test-N1p', 0, 0, 0, 0, 7528, 7528, 7528} // nod, 2 nod linkids key recs; 0 bus assocs & 0 person assocs, after filter & dedup
                      //{'test-N2p', 0, 0, 0, 0, 16644623, 16644623, 16644623} // nod, 1 nod linkids key recs/1 fc_id; 1 bus assocs & 0 person assocs
                      //{'test-N3p', 0, 0, 0, 0, 293720384, 293720384, 293720384} // nod, 3 nod linkids key recs/2 fc_id; 0 bus assocs & 1 person assocs
                      //{'test-N4p', 0, 0, 0, 0, 3700871943, 3700871943, 3700871943} // nod, 2 nod linkids key recs/2 fc_ids; 1 bus assocs & 0 person assocs
                      //{'test-N5p', 0, 0, 0, 0, 6213637149, 6213637149, 6213637149} // nod, 11 nod linkids key recs; 5 (s/b 2/1) bus assocs & 0 person assocs
						          //{'test-PN6ap', 0, 0, 0, 0, 117555429, 117555429, 117555429} // bug 141386 test case 1, PUREBEAUTY INC  property&nod(no?) jackie hagel duplicated per assoc, 2? person assocs (duplicated, s/b 1?)
						          //{'test-PN6bp', 0, 0, 0, 0, 293720384, 293720384, 293720384} // bug 141386 test case 2, YORKSHIRE COMMONS ASSOCIATION INC property&nod harriet currier duplicated per assoc, 2? person assocs (duplicated, s/b 1?)
						          //{'test-M7p', 0, 0, 0, 0, 2489345854, 2489345854, 2489345854} // bug 152864 test case 1, A.H.FC; duplicated roles (MVR;MVR) on 3 person assocs. then after mvr+ li key filter revision discussed with Tim on 05/28/14, no MVR roles should be returned
						          //{'test-MVR11', 0, 0, 0, 165, 165, 165, 165} // no bug test key fetches chg mvr, 1 bus assoc w/retd linkids, CHASE MANHATTAN AUTO FIN GROUP
						          //{'test-WC11', 0, 0, 0, 686, 686, 686, 686} // no bug test key fetches chg wc, 1 person assoc, STEVEN RAYMOND ANDREWS

             ],topbusiness_services.Layouts.rec_input_ids)
						,ds_options[1]
					  ,tempmod
            );
output(assoc_sec);
// */
