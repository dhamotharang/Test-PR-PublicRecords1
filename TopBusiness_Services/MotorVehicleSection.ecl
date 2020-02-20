/* TBD:
   1. Research/resolve open issues, search on "???"
*/
IMPORT BIPV2, Codes, doxie, iesp, MDR, suppress, VehicleV2;

EXPORT MotorVehicleSection := MODULE;

 // *********** Main function to return BIPV2 format business report results
 export fn_FullView(
   dataset(TopBusiness_Services.Layouts.rec_input_ids) ds_in_ids
	 ,TopBusiness_Services.Layouts.rec_input_options in_options
	 ,doxie.IDataAccess mod_access
   ,unsigned2 in_sourceDocMaxCount = iesp.Constants.TopBusiness.MAX_COUNT_BIZRPT_SRCDOC_RECORDS
                   ):= function 
   
   FETCH_LEVEL := in_options.BusinessReportFetchLevel;

  // Strip off the input acctno from each record, will re-attach them later.
	ds_in_unique_ids_only := project(ds_in_ids,transform(BIPV2.IDlayouts.l_xlink_ids,
	                                                       self := left,
																							           self := []));


  // *** Key fetch to get needed vehicle internal key values from BIP2 linkids key file.
  ds_linkids_keyrecs := TopBusiness_Services.Key_Fetches(
	                         ds_in_unique_ids_only, // input file to join key with
											     FETCH_LEVEL,TopBusiness_Services.Constants.SlimKeepLimit).ds_veh_linkidskey_recs;

  // Filter to ONLY include recs where the reported on company (set of input linkids) is either 
	// an Owner(type=1), Registrant(type=4) or Lessee(type=5) of the vehicle, 
	// but not any others like Lessor(type=2) or Lienholder(type=7).
	// (See party key fetch transform below for more info on orig_name_type)
  // Then project linkids key data being used onto a slimmed layout.
  ds_linkids_keyrecs_slimmed := project(ds_linkids_keyrecs(
	                                        orig_name_type = Constants.VEH_OWNER      or
																				  orig_name_type = Constants.VEH_REGISTRANT or
																				  orig_name_type = Constants.VEH_LESSEE),
	   transform(TopBusiness_Services.MotorVehicleSection_Layouts.rec_ids_with_linkidsdata_slimmed,
		    // Use existing function to derive correct indivdual state mvr source "code".
				self.source        := MDR.sourceTools.fVehicles(left.state_origin,left.source_code),
				// Concatenate 3 fields with separators for "source_docid" info
			  self.source_docid  := trim(left.vehicle_key,left,right)   + '//' +  
				                      trim(left.iteration_key,left,right) + '//' +
															trim(left.sequence_key,left,right); // needed to get to specific recs from the party key
				//self.source_recid  := left.source_rec_id; //???

				// v--- set current_prior vehicle indicator here
				// On the "linkids" key (built from party "building" file), the "History" field seems to
				// have an "E" or "H" to indicate historical/expired data/vehicle
				self.current_prior := if(left.history='',Constants.CURRENT,Constants.PRIOR),
			  self               := left, // to preserve ids & other key fields being kept
			));
 
  // Sort/dedup by linkids and 2 vehicle data key fields to only keep the 1 most recent record
	//   (the one with the latest(highest) iteration_key and sequence_key and date_last_seen) 
	// for each vehicle_key in a set of linkids. 
  ds_linkids_keyrecs_deduped := dedup(sort(ds_linkids_keyrecs_slimmed,
				                                   #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			     vehicle_key, 
																					 -iteration_key, //...[1..8], //all or only first 8 (a date)???
																					 -sequence_key, //all or only first 8 ...[1..8]???
																					 -date_last_seen //???
																					),
				                              #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			vehicle_key);

  // Now join to existing vehiclev2 "main" key to get the vehicle characteristics info
	// (vin, year, make, model, etc.) data to be output on the report.
	ds_mvrmain_keyrecs := join(ds_linkids_keyrecs_deduped,
	                           VehicleV2.Key_Vehicle_Main_Key,
		                            keyed(left.vehicle_key   = right.vehicle_key 
														      and left.iteration_key = right.iteration_key //???
															  // ^--- get all recs for each vehicle_key, or just the 1  
																// that also matched on the highest(?) iteration_key from  
																// the linkids key record???
														),
									          transform(TopBusiness_Services.MotorVehicleSection_Layouts.rec_parent_mvrdetail,
                              // Assign some right "main" key fields to interim layout field names.
															// Use VINA (VIN decoded) fields when non-blank for all but 1 field,
															// otherwise use the orig fields.
	                            self.vin          := if(right.VINA_VIN != '', 
															                        right.VINA_VIN,right.Orig_VIN);
	                            self.model_year   := if(right.VINA_Model_Year != '', 
															                        right.VINA_Model_Year,right.Orig_Year);
 	                            self.make         := if(right.VINA_Make_Desc != '', 
															                        right.VINA_Make_Desc,right.Orig_Make_Desc);
		                          self.model_series := if(right.VINA_VP_Series_Name != '', 
															                        right.VINA_VP_Series_Name,
																											trim(right.Orig_Model_Desc) + ' ' + 
																											if(right.Orig_Series_Desc[1..3] !='000', //see bug 137949
																											   trim(right.Orig_Series_Desc),''));
  	                          self.style        := if(right.VINA_Body_Style_Desc != '', 
															                        right.VINA_Body_Style_Desc,
																											right.Orig_Body_Desc);
															self.NonDmvSource	:= right.source_code in MDR.sourceTools.set_infutor_all_veh;
			                       	// null out "parties" child dataset which will be filled in later
                              self.parties := [];
                              self         := left,  // to keep ids & other linkids key fields being kept
															self         := right, // to keep certain main (right) key fields
                            ),
								          	inner, // OR left outer, //???
		                        //keep(Constants.???), // ???
                            limit(10000,skip) // change to use Constants.???.LIMIT
									         );

  // Sort/dedup main key recs to only keep 1 record (the record with the latest/highest 
	// iteration_key???) for each vin in a set of linkids.
  ds_mvrmain_keyrecs_deduped := dedup(sort(ds_mvrmain_keyrecs,
				                                   #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																					 vin,
																					 -iteration_key
																					),
				                              #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			vin
																		 ); 

  // Next join the deduped main recs back to the deduped linkids recs to just keep
  // the deduped linkids recs for each unique vin in a set of linkids.
  ds_linkids_keyrecs_vin_deduped := join(ds_linkids_keyrecs_deduped,
	                                       ds_mvrmain_keyrecs_deduped,
				                                   left.vehicle_key  = right.vehicle_key    and
														               left.iteration_key = right.iteration_key and
														               left.sequence_key  = right.sequence_key //???
																           ,
																				 transform(left),
																				 inner //only left that match to right???
																				 //,keep ???
																				 //,limit ???
																				);
																 
	// Count the number of total current & prior vehicles (unique vins)
	// for each set of linkids before limiting them to 50 of each.
  //
  // First re-sort on just the fields to be tabled/counted: 
  // linkids & current_prior indicator only.
  ds_linkids_keyrecs_tblsrtd := sort(ds_linkids_keyrecs_vin_deduped,
				                             #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																     current_prior);
	
	ds_linkids_keyrecs_tabled := table(ds_linkids_keyrecs_tblsrtd,
	                                     // v--- Create table layout in place
                                       {#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																        current_prior,
																		    cp_count := count(group)
																			 },
	                                   #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																     current_prior,
																     few); //???

  // Join the count of the number of current & prior vehicles per set of linkids back to
  // the vin deduped linkids key recs to attach the total counts for the linkids to all 
	// records(vins/vehicle_keys) in a set of linkids.
	ds_linkids_keyrecs_dd_wcounts := join(ds_linkids_keyrecs_vin_deduped,
																			  ds_linkids_keyrecs_tabled,
																          BIPV2.IDmacros.mac_JoinTop3Linkids() and 
																          left.current_prior = right.current_prior,
																		    transform(TopBusiness_Services.MotorVehicleSection_Layouts.rec_ids_with_linkidsdata_slimmed, //???	
																		      self.total_current := if(left.current_prior=Constants.CURRENT,right.cp_count,0);
																		      self.total_prior   := if(left.current_prior=Constants.PRIOR,right.cp_count,0);
																			    self := left),
																		    inner,
																		    //keep(1)  //???
																		    limit(10000,skip) //chg to use ???.Constants.???
																		   );

  // Since current/prior total counts have been determined; now chop the dataset of records 
	// per set of linkids here to just the most recent 50 current and the most recent 50 prior
	// records for each set of linkids (req 1090).
	//
  // First, sort/dedup linkids keyrecs with cp counts by: linkids, current_prior indicator 
	// and descending by iteration_key to keep the 50 most recent current & prior recs.
  ds_linkids_keyrecs_top100_cp := dedup(sort(ds_linkids_keyrecs_dd_wcounts,
	                                           #expand(BIPV2.IDmacros.mac_ListTop3Linkids()), 
																		         current_prior,
																					  -iteration_key // all??? positions OR 
																						//         ...[1..8] only first 8 since those appear
																						//                   to be a date in yyymmdd format???
																						//OR -date_last_seen (not on all recs???)
																						),
	                                      #expand(BIPV2.IDmacros.mac_ListTop3Linkids()), 
																		    current_prior,
																			  keep(Constants.motorvehicle_max_curpri_recs)); //50???

  // Second, join the vin deduped linkids recs to the ds with the top 50 current & prior to only
	// keep the vin deduped linkids recs for those top 50 MVRs per set of linkids and to attach 
	// the total counts.
  ds_linkids_keyrecs_tobe_used := join(ds_linkids_keyrecs_vin_deduped,
		                                   ds_linkids_keyrecs_top100_cp,
																         BIPV2.IDmacros.mac_JoinTop3Linkids() and
									                       left.vehicle_key = right.vehicle_key
												                 // and left.iteration_key = right.iteration_key // should not be needed???
																				 ,
																			    transform(TopBusiness_Services.MotorVehicleSection_Layouts.rec_ids_with_linkidsdata_slimmed,
																		        self.total_current := right.total_current;
																		        self.total_prior   := right.total_prior;
																			      self := left),
																		inner //only left recs that are found in the right ds??? 
																		//,keep         //??? OR ---v 
																		,limit(10000,skip) // Constants.???
																	 );

  // Third, join all the main recs to the linkids recs to be used to only keep the main recs
	// for the vins/vehicle_keys being returned.
  ds_mvrmain_keyrecs_tobe_used := join(ds_mvrmain_keyrecs,  //OR ..._deduped  should not matter???
		                                   ds_linkids_keyrecs_tobe_used,
																         BIPV2.IDmacros.mac_JoinTop3Linkids() and 
									                       left.vehicle_key = right.vehicle_key
												                 // and left.iteration_key = right.iteration_key // should not be needed???
												                 // and left.sequence_key  = right.sequence_key // should not be needed???
																				 ,
																			    transform(TopBusiness_Services.MotorVehicleSection_Layouts.rec_parent_mvrdetail,
																		        self.total_current := right.total_current;
																		        self.total_prior   := right.total_prior;
																			      self := left),
																		inner //only left recs that are found in the right ds 
																		//,keep         //??? OR ---v 
																		,limit(10000,skip) // Constants.???
																	 );


  // Now join all the linkids key recs to be used (under the max return limit) to the 
	// vehiclev2 "party" key with linkids to get all the party/title/registration info 
	// to be output on the report.
  
  tmp_layout := record(TopBusiness_Services.MotorVehicleSection_Layouts.rec_child_party)
                   unsigned4 global_sid;
                   unsigned8 record_sid;
                   unsigned6 append_did;
                end;   
	ds_mvrparty_keyrecs_pre := join(ds_linkids_keyrecs_tobe_used,
	                            VehicleV2.Key_Vehicle_Party_Key,
		                            keyed(left.vehicle_key  = right.vehicle_key   and
														         left.iteration_key = right.iteration_key and
														         left.sequence_key  = right.sequence_key //???
																     )
																 //  v--- don't use lienholder when it is the subject of the report
															  and	(right.orig_name_type != //'7' //7=lienholder,
                                                             Constants.VEH_LIENHOLDER or 
																     left.seleid != right.seleid //the company being reported on???
																    )
															 ,
									           transform(tmp_layout,
															 // Since linkids for the party were added to the party key layout, 
                               // fill in the "report-by" linkids from the left dataset. 
															 // Create a new macro for this(---v)??? Something like TopBusiness_Services.IDMacros. mac_IespTransferLinkids
                               self.ultid  := left.ultid,  //???
                               self.orgid  := left.orgid,  //???
                               self.seleid := left.seleid,  //???
                               self.proxid := left.proxid,  //???
                               self.powid  := left.powid,
                               self.empid  := left.empid,
                               self.dotid  := left.dotid,
																
		                           // Derive name_type_description from 1 char name_type code
															 // Got this info from some VehicleV2.* attribute, but
															 // can't remember which one.???
															 // Not sure about values = 3&6 or if they even exist.???
                               self.name_type_description := map(
												        right.orig_name_type = Constants.VEH_OWNER      => 'Owner',
	  			                      right.orig_name_type = Constants.VEH_LESSOR     => 'Lessor',
																right.orig_name_type = Constants.VEH_REGISTRANT => 'Registrant', 
																right.orig_name_type = Constants.VEH_LESSEE     => 'Lessee',
																right.orig_name_type = Constants.VEH_LIENHOLDER => 'LienHolder',	
		                                                                                'Unknown'),
																												// OR left.orig_name_type ---^);  ???

                               // keep seleid or did for sort/dedup below 
                               self.entity_id := if(right.Append_Clean_CName !='',
															                      right.seleid,right.append_did),

															 // For some reason some clean names/address fields are empty 
															 // (it appears to be ones with orig_party_type=U),
															 // even though the orig_* fields are not.  
															 // So keep orig values if the cleaned ones are empty.
															 self.Append_Clean_CName := if(right.Append_Clean_CName !='' ,
															                               right.Append_Clean_CName,
																														 if(right.orig_party_type !='I' and //chg to use constant value??? 
																														    right.orig_party_type !='P' , //chg to use constant value??? 
																														    right.orig_name,'')),
	                             self.Append_Clean_Address.prim_name
															                         := if(right.Append_Clean_Address.prim_name !='',
															                               right.Append_Clean_Address.prim_name,
																													   right.orig_address),
	                             self.Append_Clean_Address.v_city_name
															                         := if(right.Append_Clean_Address.v_city_name !='',
															                               right.Append_Clean_Address.v_city_name,
																														 right.orig_city),
	                             self.Append_Clean_Address.st   := if(right.Append_Clean_Address.st !='',
															                                      right.Append_Clean_Address.st,
																																    right.orig_state),
	                             self.Append_Clean_Address.zip5 := if(right.Append_Clean_Address.zip5 !='',
															                                      right.Append_Clean_Address.zip5,
																															      right.orig_zip),
                               self.county_name := Functions_Source.get_county_name(
															                       right.Append_Clean_Address.st, 
																										 right.Append_Clean_Address.fips_county),
															 self.src_first_date 			:= right.src_first_date;											 
															 self.src_last_date  			:= right.src_last_date;
															 self.ReportedName       := right.raw_name;    
															 self := right, // to keep the remaining party key fields we
	 		                                        // want (which have the same name on the temp 
																							//       layout as on the party key)
			                         self := left, // to preserve other linkids key fields being kept
                            ),
								          	inner, // OR if only left recs use  left outer, //???
		                        //keep(Constants.???), // ???
                            limit(10000,skip) // change to use Constants.???.LIMIT
									         );
  ds_mvrparty_keyrecs_suppressed := suppress.mac_suppresssource(ds_mvrparty_keyrecs_pre,mod_access,append_did);
  ds_mvrparty_keyrecs := project(ds_mvrparty_keyrecs_suppressed,
                                   TopBusiness_Services.MotorVehicleSection_Layouts.rec_child_party);
	// Might have duplicated parties, so dedup just in case.
	// Might need some more "tweaking" ---v ???
	ds_mvrparty_keyrecs_deduped := dedup(sort(ds_mvrparty_keyrecs,
				                                    #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			      vehicle_key,//-iteration_key, //-sequence_key, ???
																			      orig_name_type,
																						entity_id, //???
																			      if(entity_id=0,Append_Clean_CName,''), // ???
																						if(entity_id=0,Append_Clean_name.fname,''), // ???
																			      if(entity_id=0,Append_Clean_name.mname,''), // ???
																						if(entity_id=0,Append_Clean_name.lname,''), // ???
																			      //Append_Clean_Address.prim_range,Append_Clean_Address.prim_name,
																			      //Append_Clean_Address.v_city_name,
																			      //Append_Clean_Address.st,
																			      //Append_Clean_Address.zip5,
																			      //reg_license_plate,
																						//-reg_latest_expiration_date
																						//,-reg_latest_effective_date,
																						//-reg_earliest_effective_date,-reg_first_date,
																						//ttl_number,-ttl_latest_issue_date,
																						-iteration_key,
																						-sequence_key
																						),
				                               #expand(BIPV2.IDmacros.mac_ListTop3Linkids()), 
																			 vehicle_key,//iteration_key,//sequence_key, ???
																			 orig_name_type,
																			 entity_id, //???
																			 if(entity_id=0,Append_Clean_CName,''), // ???
																			 if(entity_id=0,Append_Clean_name.fname,''), // ???
																			 if(entity_id=0,Append_Clean_name.mname,''), // ???
																			 if(entity_id=0,Append_Clean_name.lname,'')  //, ???
																			 //Append_Clean_Address.prim_range,Append_Clean_Address.prim_name,
																			 //Append_Clean_Address.v_city_name,
																			 //Append_Clean_Address.st,
																			 //Append_Clean_Address.zip5,
																			 //reg_license_plate,
																			 //reg_latest_expiration_date
																			 //,reg_latest_effective_date,
																			 //reg_earliest_effective_date,reg_first_date,
																			 //ttl_number,ttl_latest_issue_date
																			 ); 

  // Now that we got all the data, pull it all together onto an interim parent/child layout.
	//
  // Denormalize to attach child(party) recs to their associated parent(main key) recs.
  TopBusiness_Services.MotorVehicleSection_Layouts.rec_parent_mvrdetail tf_denorm_parties(
	  TopBusiness_Services.MotorVehicleSection_Layouts.rec_parent_mvrdetail L,
		dataset(TopBusiness_Services.MotorVehicleSection_Layouts.rec_child_party) R)	:= transform
		  self.parties := choosen(//sort( // may need to put party recs in reverse chron order???
			                        R, 
															  // how handle spaces in some dates???
															  // -Ttl_Latest_Issue_Date, -Reg_First_Date, 
															  //-Reg_Earliest_Effective_Date, -Reg_Latest_Effective_Date),
			                        iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_MVR_PARTY_RECORDS);
		  self         := L;
	end;

  ds_parent_child := denormalize(ds_mvrmain_keyrecs_tobe_used,
	                               ds_mvrparty_keyrecs_deduped,
															     // v--- ids no longer needed???, see bugs 126493 & 126489???
																   //BIPV2.IDmacros.mac_JoinTop3Linkids() and
																	 left.vehicle_key = right.vehicle_key
																	 // and ???
																 ,
		                             group,
		                             tf_denorm_parties(left,rows(right)));


  // Transforms for the iesp MotorVehicle Section related layouts
  //
  // transform to handle the MVR "Party" child dataset
	iesp.TopbusinessReport.t_TopBusinessMotorVehicleParty 
	  tf_party_child(TopBusiness_Services.MotorVehicleSection_Layouts.rec_child_party l) := transform
    self.PartyTypeDescription        := l.name_type_description,
    self.CompanyName                 := l.Append_Clean_CName,	
    self.Name.Full                   := ''; 
    self.Name.First                  := l.Append_Clean_Name.fname;
	  self.Name.Middle                 := l.Append_Clean_Name.mname;
	  self.Name.Last                   := l.Append_Clean_Name.lname;
	  self.Name.Suffix                 := l.Append_Clean_Name.name_suffix;
    self.Name.Prefix                 := l.Append_Clean_Name.title;
    self.Address.StreetName          := l.Append_Clean_Address.prim_name,
		self.Address.StreetNumber        := l.Append_Clean_Address.prim_range,
		self.Address.StreetPreDirection  := l.Append_Clean_Address.predir,
		self.Address.StreetPostDirection := l.Append_Clean_Address.postdir,
		self.Address.StreetSuffix        := l.Append_Clean_Address.addr_suffix,
		self.Address.UnitDesignation     := l.Append_Clean_Address.unit_desig,
		self.Address.UnitNumber          := l.Append_Clean_Address.sec_range,
		self.Address.City                := l.Append_Clean_Address.v_city_name,
		self.Address.State               := l.Append_Clean_Address.st,
		self.Address.Zip5                := l.Append_Clean_Address.zip5,
		self.Address.Zip4                := l.Append_Clean_Address.zip4,
    self.Address.StreetAddress1      := '',
    self.Address.StreetAddress2      := '',
    self.Address.County              := l.county_name;
    self.Address.PostalCode          := '',
    self.Address.StateCityZip        := '',
	  self.TitleNumber                := l.ttl_number,
		self.TitleDate                  := iesp.ECL2ESP.toDate ((integer)l.ttl_latest_issue_date),
		// only output orig regis date if it differs from regis date.
		self.OriginalRegistrationDate   := if(l.reg_earliest_effective_date != l.reg_latest_effective_date,
                                          iesp.ECL2ESP.toDate ((integer)l.reg_earliest_effective_date),
                                          iesp.ECL2ESP.toDate (0) //???
																					),
		self.RegistrationDate           := iesp.ECL2ESP.toDate ((integer)l.reg_latest_effective_date),
		self.RegistrationExpirationDate := iesp.ECL2ESP.toDate ((integer)l.reg_latest_expiration_date),
	  self.LicensePlate               := l.reg_license_plate,
		// only output license plate state if a license plate value exists (i.e. a regis rec, not a title rec)???
		self.LicensePlateState          := if(l.reg_license_plate !='',
		                                      if(l.reg_license_state != '',
		                                         l.reg_license_state,l.state_origin),
																					 ''),
	  self.LicensePlateType           := l.reg_license_plate_type_desc,
		// only output previous license plate if a license plate value exists (i.e. a regis rec, not a title rec)??? 
		// and if it differs from license plate.
	  self.PreviousLicensePlate       := if(l.reg_license_plate !='',
		                                      if(l.reg_previous_license_plate != l.reg_license_plate,
                                             l.reg_previous_license_plate,''),
																					 ''),
	  // v--- new fields for bug 150816
	  self.TitleStatus     := l.Ttl_Status_Desc;
	  self.OdometerMileage := // (integer)??? 
		                        l.Ttl_Odometer_Mileage;
	  self.DecalYear       := // (integer)??? 
		                        l.Reg_Decal_Year;
	  //end of new fields for bug 150816
		
		self.SourceDateFirstSeen				:= iesp.ECL2ESP.toDate ((integer)l.SRC_FIRST_DATE);
		self.SourceDateLastSeen					:= iesp.ECL2ESP.toDate ((integer)l.SRC_LAST_DATE);
		self.ReportedName              := l.ReportedName; 
		self := []; // temp in case bug 150816 iesp changes are checked in before roxie chnages are ready???
	end;

  // transform to store data in the iesp report MVR "detail" record layout/fields
	TopBusiness_Services.MotorVehicleSection_Layouts.rec_ids_plus_MotorVehicleDetail
	  tf_detail_parent(TopBusiness_Services.MotorVehicleSection_Layouts.rec_parent_mvrdetail l) := transform
		self.current_prior     := l.current_prior,
	  self.VIN               := l.vin,
	  self.VehicleType       := l.orig_vehicle_type_desc;
	  self.ModelYear         := (integer2) l.model_year,
	  self.Make              := l.make,
	  self.Series            := l.model_series,
	  self.Style             := l.style,
	  self.BasePrice         := l.VINA_Price;

    //Bug 150816 changes
		// Explosion coding below copied from VehicleV2_Services.Functions.Functions.MAC_report_out,
		// which is what the current bus comp rpt Motor_Vehicles_V2 section uses for output???
		self.StateOfOrigin        := Codes.GENERAL.state_long(l.state_origin);
    self.Color                := l.Orig_Major_Color_Desc; //??? OR ---v
		                             //VehicleCodes.getColor(l.best_Major_Color_Code); // use keycodes instead?
    //self.best_minor_color_desc := VehicleCodes.getColor(r.best_Minor_Color_Code); //???
    self.VehicleUse           := l.Orig_Vehicle_Use_Desc;
		self.NumberOfCylinders    := l.VINA_Number_Of_Cylinders;
    self.EngineSize           := l.VINA_Engine_Size;
    self.FuelTypeName         := Codes.VEHICLE_REGISTRATION.FUEL_CODE(l.VINA_Fuel_Code);
    self.Restraints           := Codes.VEHICLE_REGISTRATION.VP_RESTRAINT(l.VINA_VP_Restraint);
	  self.AntiLockBrakes       := Codes.VEHICLE_REGISTRATION.VP_ANTI_LOCK_BRAKES(l.VINA_VP_Anti_Lock_Brakes);
	  self.AirConditioning      := codes.VEHICLE_REGISTRATION.VP_AIR_CONDITIONING(l.VINA_VP_Air_Conditioning);
	  self.DaytimeRunningLights := Codes.VEHICLE_REGISTRATION.VP_DAYTIME_RUNNING_LIGHTS(l.VINA_VP_Daytime_Running_Lights);
	  self.PowerSteering        := Codes.VEHICLE_REGISTRATION.VP_POWER_STEERING(l.VINA_VP_Power_Steering);
	  self.PowerBrakes          := Codes.VEHICLE_REGISTRATION.VP_POWER_BRAKES(l.VINA_VP_Power_Brakes);
	  self.PowerWindows         := Codes.VEHICLE_REGISTRATION.VP_POWER_WINDOWS(l.VINA_VP_Power_Windows);
    self.SecuritySystem       := Codes.VEHICLE_REGISTRATION.VP_SECURITY_SYSTEM(l.VINA_VP_Security_System);
	  self.Roof                 := Codes.VEHICLE_REGISTRATION.VP_ROOF(l.VINA_VP_Roof);
    //self.VINA_VP_Optional_Roof1_Desc  := Codes.VEHICLE_REGISTRATION.VP_OPTIONAL_ROOF1(l.VINA_VP_Optional_Roof1);
    //self.VINA_VP_Optional_Roof2_Desc  := Codes.VEHICLE_REGISTRATION.VP_OPTIONAL_ROOF2(l.VINA_VP_Optional_Roof2);
	  self.Radio                := Codes.VEHICLE_REGISTRATION.VP_RADIO(l.VINA_VP_Radio);
    //self.VINA_VP_Optional_Radio1_Desc := Codes.VEHICLE_REGISTRATION.VP_OPTIONAL_RADIO1(l.VINA_VP_Optional_Radio1);
    //self.VINA_VP_Optional_Radio2_Desc := Codes.VEHICLE_REGISTRATION.VP_OPTIONAL_RADIO2(l.VINA_VP_Optional_Radio2);
	  self.FrontWheelDrive      := Codes.VEHICLE_REGISTRATION.VP_FRONT_WHEEL_DRIVE(l.VINA_VP_Front_Wheel_Drive);
	  self.FourWheelDrive       := Codes.VEHICLE_REGISTRATION.VP_FOUR_WHEEL_DRIVE(l.VINA_VP_Four_Wheel_Drive);
	  self.TiltWheel            := Codes.VEHICLE_REGISTRATION.VP_Tilt_Wheel(l.VINA_VP_Tilt_Wheel);
    // self.VINA_VP_Transmission_Desc           := Codes.VEHICLE_REGISTRATION.VP_TRANSMISSION(l.VINA_VP_Transmission);
    // self.VINA_VP_Optional_Transmission1_Desc := Codes.VEHICLE_REGISTRATION.VP_TRANSMISSION(l.VINA_VP_Optional_Transmission1);
    // self.VINA_VP_Optional_Transmission2_Desc := Codes.VEHICLE_REGISTRATION.VP_TRANSMISSION(l.VINA_VP_Optional_Transmission2);
    // end of fields added for bug 150816

    self.Parties    := choosen(project(sort(l.parties,Orig_Name_Type),
		                                   tf_party_child(left)),
		                           iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_MVR_PARTY_RECORDS),
		// Create 1 row of the SourceDocs dataset
		self.SourceDocs := dataset([ transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
			self.BusinessIds := l, // store all ids with same field names
      self.IdType      := Constants.vehiclekeys,
			self.IdValue     := l.source_docid,
			self.Source      := l.source,
      self             := [], //null rest of the fields
			)]);

    // Check multiple dates on first record in the "parties" child datset, to determine the 
		// vehicle output/display order. ???
		// May need to put input l.parties into reverse chron date order first???  See above???
    self.display_order_date := if(l.parties[1].Ttl_Latest_Issue_Date != '',
		                              l.parties[1].Ttl_Latest_Issue_Date,
		                              if(l.parties[1].Reg_First_Date != '',
																	   l.parties[1].Reg_First_Date,
		                                 if(l.parties[1].Reg_Earliest_Effective_Date != '',
																	      l.parties[1].Reg_Earliest_Effective_Date,
																	      l.parties[1].Reg_Latest_Effective_Date)
																		)
																 );
		self := l; // to assign all linkids
		self := []; // temp in case bug 150816 iesp changes are checked in before roxie chnages are ready???
	end;

  // Project interim parent/child recs into report MVR "detail" iesp layout plus ids
  ds_recs_rptdetail := project(ds_parent_child,tf_detail_parent(left));


  // transform to handle iesp SourceDocs structure
	iesp.topbusiness_share.t_TopBusinessSourceDocInfo
	  tf_sourcedoc(TopBusiness_Services.MotorVehicleSection_Layouts.rec_ids_plus_MotorVehicleDetail L) := transform
		   self.BusinessIds := l, // to store all linkids
       self.IdType      := Constants.vehiclekeys,
		   self.IdValue     := l.source_docid,
		   self.Section     := Constants.MVRSectionName, //is this needed on top level anymore???
		   self.Source      := l.source,
		   self := []  //null out other fields
	end;

  // Transform to store data in the iesp report MVR "summary" record layout/fields
  TopBusiness_Services.MotorVehicleSection_Layouts.rec_ids_plus_MotorVehicleSummary tf_rollup_rptdetail(
	  TopBusiness_Services.MotorVehicleSection_Layouts.rec_ids_plus_MotorVehicleDetail l,   
	  dataset(TopBusiness_Services.MotorVehicleSection_Layouts.rec_ids_plus_MotorVehicleDetail) allrows) := transform
      self.acctno := ''; // null here, will be assigned below
		  self.CurrentRecordCount      := count(allrows(current_prior=Constants.CURRENT));
      // Grab total_current count from the first row of the input dataset that is for a 
			// "current" VehicleV2.
			self.TotalCurrentRecordCount := allrows(current_prior=Constants.CURRENT)[1].total_current,
      self.CurrentVehicles := choosen(project(allrows(current_prior=Constants.CURRENT),
		                                             transform(iesp.TopbusinessReport.t_TopBusinessMotorVehicleDetail, 
				  										                     self := left)), 
																         iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_MVR_MAIN_RECORDS);
			self.CurrentSourceDocs := if(self.CurrentRecordCount > 0,
                                   choosen(project(allrows(current_prior=Constants.CURRENT),
															                     tf_sourcedoc(left)),
								                           in_sourceDocMaxCount));
			self.PriorRecordCount  := count(allrows(current_prior=Constants.PRIOR));
      // Grab total_prior count from the first row of the input dataset that is for a 
			// "prior" VehicleV2.
			self.TotalPriorRecordCount :=allrows(current_prior=Constants.PRIOR)[1].total_prior,
		  self.PriorVehicles  := choosen(project(allrows(current_prior=Constants.PRIOR),
		                                         transform(iesp.TopbusinessReport.t_TopBusinessMotorVehicleDetail, 
														                   self := left)), 
																     iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_MVR_MAIN_RECORDS),
			self.PriorSourceDocs := if(self.PriorRecordCount > 0,
                                 choosen(project(allrows(current_prior=Constants.PRIOR),
															                   tf_sourcedoc(left)),
								                         in_sourceDocMaxCount));

		  self := l; // to assign all linkids
	end;

  // Sort/group all current & prior motorvehicle recs for a set of linkids
  ds_all_rptdetail_grouped := group(sort(ds_recs_rptdetail,
                                         #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																				 current_prior,
																				 NonDMVSource,
																				 -display_order_date, record),
	                                  #expand(BIPV2.IDmacros.mac_ListTop3Linkids())
																   );

	// Rollup all current & prior motorvehicle recs for a set of linkids
  ds_all_rptdetail_rolled := rollup(ds_all_rptdetail_grouped,
																    group,
																    tf_rollup_rptdetail(left,rows(left)));

  // Attach input acctnos back to the bdids
  ds_all_wacctno_joined := join(ds_in_ids,ds_all_rptdetail_rolled,
															    BIPV2.IDmacros.mac_JoinTop3Linkids(),
														    transform(TopBusiness_Services.MotorVehicleSection_Layouts.rec_ids_plus_MotorVehicleSummary,
														      self.acctno := left.acctno,
															    self        := right),
														    left outer); // 1 out rec for every left rec

	// Roll up all recs for the acctno
	ds_final_results := rollup(group(sort(ds_all_wacctno_joined,acctno),
	                                 acctno),
	                           group,
		                         transform(TopBusiness_Services.MotorVehicleSection_Layouts.rec_final,
                               self.acctno                       := left.acctno,
		                           self.MotorvehicleRecordCount      := left.CurrentRecordCount + 
									                                                  left.PriorRecordCount,
		                           self.TotalMotorVehicleRecordCount := left.TotalCurrentRecordCount + 
									                                                  left.TotalPriorRecordCount,
			                         self.MotorVehicleRecords          := left)
														);


  // Uncomment for debugging
  // output(ds_in_ids,                       named('ds_in_ids'));
	// output(ds_in_unique_ids_only,           named('ds_in_unique_ids_only'));

  // output(ds_linkids_keyrecs,              named('ds_linkids_keyrecs'));
  // output(ds_linkids_keyrecs_slimmed,      named('ds_linkids_keyrecs_slimmed'));
  // output(ds_linkids_keyrecs_deduped,      named('ds_linkids_keyrecs_deduped'));

  // output(ds_mvrmain_keyrecs,              named('ds_mvrmain_keyrecs'));
  // output(ds_mvrmain_keyrecs_deduped,      named('ds_mvrmain_keyrecs_deduped'));
  // output(ds_linkids_keyrecs_vin_deduped,  named('ds_linkids_keyrecs_vin_deduped'));
  // output(ds_linkids_keyrecs_tblsrtd,      named('ds_linkids_keyrecs_tblsrtd'));
  // output(ds_linkids_keyrecs_tabled,       named('ds_linkids_keyrecs_tabled'));
  // output(ds_linkids_keyrecs_dd_wcounts,   named('ds_linkids_keyrecs_dd_wcounts'));
  // output(ds_linkids_keyrecs_top100_cp,    named('ds_linkids_keyrecs_top100_cp'));
  // output(ds_linkids_keyrecs_tobe_used,    named('ds_linkids_keyrecs_tobe_used'));
  // output(ds_mvrmain_keyrecs_tobe_used,    named('ds_mvrmain_keyrecs_tobe_used'));

  // output(ds_mvrparty_keyrecs,             named('ds_mvrparty_keyrecs'));
  // output(ds_mvrparty_keyrecs_deduped,     named('ds_mvrparty_keyrecs_deduped'));

  // output(ds_parent_child,                 named('ds_parent_child'));
  // output(ds_recs_rptdetail,               named('ds_recs_rptdetail'));
  // output(ds_all_rptdetail_grouped,        named('ds_all_rptdetail_grouped'));
  // output(ds_all_rptdetail_rolled,         named('ds_all_rptdetail_rolled'));
  // output(ds_all_wacctno_joined,           named('ds_all_wacctno_joined'));
	// output(ds_final_results,                named('ds_final_results'));

  //return ds_linkids_keyrecs_slimmed;
	return ds_final_results;

 END; // end of the fn_FullView function
	
END; //end of the module

/*  to test, in a builder window use this: 
IMPORT AutoStandardI;

  //v--- for use with Todd's macro???
  #STORED('DPPAPurpose',1);
  #STORED('GLBPurpose',1);  // 2= shows minors

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

// input dataset layout= acctno,DotID,EmpID,POWID,ProxID,Seleid, OrgID,UltID  
mvr_sec := TopBusiness_Services.MotorVehicleSection.fn_FullView(
             dataset([
						          //{'test1p', 0, 0, 0, 165, 165, 165, 165} // 1 rec, 1 veh_key/1 it_key, 1 prior vehicle
						          //{'test2p', 0, 0, 0, 123, 123, 123, 123} // 2 recs, 1 veh_key/1 it_key, 1 prior vehicle
						          //{'test3d', 0, 0, 0, 647??, 647, 647, 647} // 6 recs, 4 veh_key/4 it_key, 3 prior & 1 current vehicles
						          //{'test4p', 0, 0, 0, 4201641, 4201641, 4201641, 4201641} // 8 recs, bug 126185 a report on a lienholder
                      //{'test5dp', 0, 0, 0, 5294294, 5294294, 5294294, 5294294} // 417(?) linkids recs, bug 124345 example 1
                      //{'test6dp', 0, 0, 0, 249, 249, 249, 249} // 1 linkids recs, bug 124345 example 2
                      //{'test7dp', 0, 0, 0, 18677481, 18677481, 18677481, 18677481} // 390 linkids recs, bug 124350 example 2
											//{'test8dp', 0, 0, 0, 23793907, 23793907, 23793907, 23793907} // 32 linkids recs, bug 126775 example 1
                      //{'test9dp', 0, 0, 0, 18677481, 18677481, 18677481, 18677481} // 390 linkids recs, 2 vehicles, bug 129357
                      //{'test10p', 0, 0, 0, 0, 76249693, 76249693, 76249693} // bug 137948&137949, 75 linkids recs, 33 vehicle_keys, but s/b 31 vins, 4 curr & 27 prior
                      //{'test11p1', 0, 0, 0, 0, 3316779, 3316779, 3316779} // bug 133839 test case1 AAA WHEELCHAIR WAGON, 2305 linkids recs, 382 vehicle_keys, 372 vins, ?? curr & ?? prior; s/b ?? curr & ?? prior
	                    //{'test11p2', 0, 0, 0, 0, 2, 2, 2} // bug 133839 test case 2 THE TRUCK DEPOT,  166 li recs, 6 vehicle_keys/6 vins, 1 curr & 5 prior
	                    //{'test11p3', 0, 0, 0, 0, 233, 233, 233} // bug 133839 test case 3 NAPLES DAILY NEWS,  ? li recs, ? vehicle_keys/? vins, ? curr & ? prior
                      //{'test121p', 0, 0, 0, 0, 4201641, 4201641, 4201641} // bug 130389 test case 1, 8 linkids recs, 8 vehicle_keys, but 7 are lienholder recs(not retuned), 1 vin, 0 curr & 1 prior
                      //{'test12p2', 0, 0, 0, 0, 9372868, 9372868, 9372868} // bug 130389 test case 2, 37 linkids recs, 10 vehicle_keys, 10 vins, 5 curr & 5 prior
                      //{'test13p1', 0, 0, 0, 0, 2, 2, 2} // bug 145547 test case 3,  166 li recs, 6 vehicle_keys/6 vins, 1 curr & 5 prior
                      //{'test14p1', 0, 0, 0, 0, 87259037, 4148495, 4148495} // bug 150816, testcase1 SEISINT INC., 2 li recs/1 vins, 1 total/1 prior

                      //{'testx', 0, 0, 0, ?, ?, ?, ?} // ? veh_key & ? it_keys, ? current & ? prior???
                  ],topbusiness_services.Layouts.rec_input_ids)
						,ds_options[1]
					  ,tempmod
            );
output(mvr_sec);
*/
