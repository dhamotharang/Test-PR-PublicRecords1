/* As of 04/04, items below still need to be investigated:
   1. Investigate about adding addr_dt_first_seen to doxie.layout_best without
      impacting all the attributes that use that layout.
*/

IMPORT Address, Autokey_batch, didville, doxie, header, NID, risk_indicators, Suppress, ut, 
       VehicleV2, VehicleV2_Services, MDR;

EXPORT NonRegisteredVehicles_BatchService_Records(boolean useCannedRecs=false,
																									boolean includeNonRegulatedSources=false) := FUNCTION 

  // Constant values name shortcuts
  unsigned1 SIXMONTHS            := NonRegisteredVehicles_BatchService_Constants.SIXMONTHS;
  unsigned1 TWELVEMONTHS         := NonRegisteredVehicles_BatchService_Constants.TWELVEMONTHS;
  unsigned1 TWENTYFOURMONTHS     := NonRegisteredVehicles_BatchService_Constants.TWENTYFOURMONTHS;

	unsigned2 DAYSIN_6MONTHS     := NonRegisteredVehicles_BatchService_Constants.DAYSIN_6MONTHS;
	unsigned2 DAYSIN_12MONTHS    := NonRegisteredVehicles_BatchService_Constants.DAYSIN_12MONTHS;
	unsigned2 DAYSIN_24MONTHS    := NonRegisteredVehicles_BatchService_Constants.DAYSIN_24MONTHS;

	string2 INHOUSE_FIRST        := NonRegisteredVehicles_BatchService_Constants.INHOUSE_FIRST;
	string2 INHOUSE_AND_REALTIME := NonRegisteredVehicles_BatchService_Constants.INHOUSE_AND_REALTIME;
	string2 INHOUSE_ONLY         := NonRegisteredVehicles_BatchService_Constants.INHOUSE_ONLY;
  string2 REALTIME_ONLY        := NonRegisteredVehicles_BatchService_Constants.REALTIME_ONLY;

	string7 NO_HIT               := NonRegisteredVehicles_BatchService_Constants.NO_HIT;
	string7 INSTATE_REG          := NonRegisteredVehicles_BatchService_Constants.INSTATE_REG;
  string7 OUTOFSTATE_REG       := NonRegisteredVehicles_BatchService_Constants.OUTOFSTATE_REG;
	string7 REJECTED_REC         := NonRegisteredVehicles_BatchService_Constants.REJECTED_REC;

  unsigned2 JOIN_LIMIT         := NonRegisteredVehicles_BatchService_Constants.JOIN_LIMIT;
  unsigned2 JOIN_LIMIT_UNLMTD  := NonRegisteredVehicles_BatchService_Constants.JOIN_LIMIT_UNLMTD;
  unsigned2 KEEP_LIMIT_HDR     := NonRegisteredVehicles_BatchService_Constants.KEEP_LIMIT_HDR;

  unsigned1 USE_BEST           := NonRegisteredVehicles_BatchService_Constants.USE_BEST;
  unsigned1 USE_PREV           := NonRegisteredVehicles_BatchService_Constants.USE_PREV;

  // *** Stored soap input and temporary/internal constants
  string2   in_SearchTimeInMonths_str := '12' : STORED('SearchTimeInMonths'); //default per specs is 12
  unsigned1 in_SearchTimeInMonths     := (unsigned1) in_SearchTimeInMonths_str;
	
	boolean IncludePplAtAddr      := false : STORED('IncludePplAtAddr');   //default per specs is No/false
  //NOTE: SearchMVR proposed option values are:
  //     IF = In-house first, then if not found try Real Time (default)
  //     IR = Both In-house and Real Time
  //     IH = In-house only
  //     RT = Real Time only 
  string2 SearchMVR_in  := INHOUSE_FIRST : STORED('SearchMVR'); // default per specs is in-house first, then if not found use real time
	string2 SearchMVR     := StringLib.StringToUpperCase(SearchMVR_in);
	
	boolean IncludeMinors := false : STORED('IncludeMinors');
	boolean GetSSNBest := true  : STORED('GetSSNBest');
  
  // Validate the value passed in SearchTimeInMonths for 1 of the 3 valid ones
  unsigned1 SearchTimeInMonths := if(in_SearchTimeInMonths = SIXMONTHS or
		                                 in_SearchTimeInMonths = TWELVEMONTHS or
													           in_SearchTimeInMonths = TWENTYFOURMONTHS,
													           in_SearchTimeInMonths,
									                   TWELVEMONTHS);

	// Set booleans to be checked later, dependent upon SearchMVR option values.
  boolean InhouseMVRFirst  := // If 1 of the 3 below set to false, 
	                            // otherwise set to true because it is the default
	                            if(SearchMVR = INHOUSE_AND_REALTIME or 
															   SearchMVR = INHOUSE_ONLY         or
                                 SearchMVR = REALTIME_ONLY,
																 false,true);

	boolean BothInhouseRtMVR := SearchMVR = INHOUSE_AND_REALTIME;
	boolean InhouseMvrOnly   := SearchMVR = INHOUSE_ONLY;
  boolean RtMvrOnly        := SearchMVR = REALTIME_ONLY;
	

  // Layout name shortcuts:
  layout_batch_in     := Autokey_batch.Layouts.rec_inBatchMaster;
	layout_hdr_recs     := doxie.layout_presentation;
	layout_final_wextra := BatchServices.NonRegisteredVehicles_BatchService_Layouts.final_wextra;
	layout_final        := BatchServices.NonRegisteredVehicles_BatchService_Layouts.final;


  // ***************************************************************************
  // *** Main processing
  /*
  Basic flow of this batch service:
   1. Process/validate the input data to:
      a. Store the input from batch_in adding seq#s or used "canned" records for testing.
      b. Capitalize the input data.
      c. Validate the input to: 
         1. Clean the input address to fill in and or correct address data.
         2. Check for minimum input fields present or input addresses that should have a 
            sec_range, but do not. Mark those as "REJ"ected.
         3. If the IncludePplAtAddr option was set on, temp blank the input name fields so 
            we will get all the dids for the address.
         4. Split the validated/cleaned input into "good" & "rejected" files.
   2. Get the header recs for the cleaned input address.
   3. Check/clean the header records that were acquired.
   4. See if the earliest "date_first_seen" from all of the header recs for a did/address
      is within the SearchTimeInMonths timeframe/date.
   5. For those dids that are within the timeframe, get their "best" data.
      Then perform ssn/did pulling/suppression and ssn masking.
   6. Also for those dids, if requested get in-house MVR data.
   7. Also for those dids, if requested get real-time MVR data via 1, 2 or 3 different 
      lookups depending upon the input address, best address and optional previous address
      state values.
   8. Combine datasets of records with in-house mvr & real-time mvr.
   9. Assign a vehicle_id to each vin within a did.
  10. Assign a person_id to each did within an acctno.
  11. Add back in the rejected input records and sort in acctno+ order.
  12. Attach original input data to output.
  13. Join cleaned input to interim output to set "current_address" & "hit_flag".
  */


  // 1. Process/clean/validate the input data. 
  //
  // 1.1 Grab the batch input XML and throw into a dataset, assigning seq#s.  
	//     Check to see if want to use "canned" test recs for internal testing.
	ds_batch_in := IF(NOT useCannedRecs, 
	                  BatchServices.file_inBatchMaster(false), // parm=forceSeq=false
	                  BatchServices._Sample_inBatchMaster('NONREGVEH'));
 
  // 1.2 Do a project with transform to convert any lower case input to upper case.
  ds_batch_in_caps := project(ds_batch_in,BatchServices.transforms.xfm_capitalize_input(left));
 
  // 1.3 Clean the input address and check for the minimum input address fields present 
	//     and check for an input address that needs a sec_range value. 
	//     If either situation found, mark those recs as "REJ"ected and filter those recs
	//     out so they are not processed, but they can be added to the final output later.
  // 	
	layout_batch_in  xform_clean_input(layout_batch_in l) := transform
		// First set boolean for minimum input criteria. We must have at least a  
		// street address1 (house # & street name) and either a city&state or a zip.
		minimum_addr := if(l.prim_range != '' and l.prim_name !='' and
			                 ((l.p_city_name != '' and l.st != '') or 
											 l.z5 != ''),true,false);

    // Clean the input address to fill in city&state or zip if either is missing
		// and get the "rec_type" to check if need a sec_range.
		temp_addr1 := Address.Addr1FromComponents(l.prim_range, l.predir, l.prim_name, 
		                                          l.addr_suffix, l.postdir, 
																							l.unit_desig, l.sec_range);
    temp_addr2 := Address.Addr2FromComponents(l.p_city_name, l.st, l.z5);

		clean_addr := Address.GetCleanAddress(temp_addr1,temp_addr2,0).str_addr;
		ca         := Address.CleanFields(clean_addr); 
		// Replace the raw address input with the cleaned address fields for 
		// better did retrieval. 
		self.prim_range  := ca.prim_range;
		self.predir      := ca.predir;
		self.prim_name   := ca.prim_name;
		self.addr_suffix := ca.addr_suffix;
		self.postdir     := ca.postdir;
    self.unit_desig  := ca.unit_desig;
		self.sec_range   := ca.sec_range;
		self.p_city_name := ca.p_city_name;
		self.st          := ca.st;
		self.z5          := ca.zip;
 		// Check for minimum input address info or if sec_range is missing but required.
		// Temp store the rejected indicator into an unused field (MatchCode) in 
		// the common batch input layout.
		self.MatchCode := if(not minimum_addr or 
			                   ((ca.rec_type = 'H' or ca.rec_type ='HD') and ca.sec_range = ''),
			                   REJECTED_REC,'');
		self := l;
	end;

  ds_batch_in_cleaned := project(ds_batch_in_caps,xform_clean_input(left));

  // 1.4 Filter to split into good recs and rejected recs, projecting the rejected ones
	//     onto the temp interim layout.
	ds_batch_in_good     := ds_batch_in_cleaned(MatchCode != REJECTED_REC);
  ds_batch_in_rejected := project(ds_batch_in_cleaned(MatchCode = REJECTED_REC),
	                                transform(layout_final_wextra,
                                    //For a reject, only store the acctno and hit_flag.
																    self.acctno   := left.acctno;
																    self.hit_flag := left.MatchCode;
															   ));


  // 2. Get the header recs for the cleaned input address.
  // 
  // 2.1 Join cleaned input to the header address key file to get the header records that 
	//     match the cleaned input address and optionally match the input name info.
  //     NOTE: The coding below was cloned from the first part of BatchServices.Residents_Records
	//     to get hdr recs directly from the header address key file.
 	
	ds_keyhdraddr := doxie.Key_Header_Address;
	layout_kha    := recordof(ds_keyhdraddr);
	layout_header := header.Layout_Header;
	layout_hdr_wacctno := record
	  layout_batch_in.acctno;
	  layout_header; //needed for use by Header.MAC_GlbClean_Header
	end;
	
	layout_hdr_wacctno xform_kha(layout_batch_in l, layout_kha r) := TRANSFORM
	  self.acctno := l.acctno;
		self        := r;
		self        := []; //null out fields on layout_header, but are not on hdr addr key file
	END;

	ds_hdr_recs_match_input := JOIN(ds_batch_in_good,ds_keyhdraddr,
										                keyed(left.prim_name  = right.prim_name)  and
											              keyed(left.z5         = right.zip)        and
											              keyed(left.prim_range = right.prim_range) and
											              keyed(left.sec_range  = right.sec_range)  and 
											              left.predir           = right.predir      and 
											              left.postdir          = right.postdir     and
											              left.addr_suffix      = right.suffix
	                                  // Also check name related fields when needed
													          AND
													          (IncludePplAtAddr OR
																		 ((left.name_first ='' or 
													             (NID.mod_PFirstTools.PF(left.name_first) = 
													              NID.mod_PFirstTools.PF(right.fname)))
																		  and
													            (left.name_last = '' or 
													             (metaphonelib.DMetaPhone1(left.name_last) = 
													              metaphonelib.DMetaPhone1(right.lname)))
 													           ))
																	,
										              xform_kha(LEFT,RIGHT),
												          inner,
												          keep(KEEP_LIMIT_HDR),
											            LIMIT(JOIN_LIMIT_UNLMTD));


  // 3. Check/clean the header records that were acquired.
	mod_access := doxie.functions.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule ());
  glb_ok :=  mod_access.isValidGLB ();
  dppa_ok := mod_access.isValidDPPA ();
	Header.MAC_GlbClean_Header(ds_hdr_recs_match_input,ds_hdr_recs_outglbclean, , , mod_access);


  // 4. Check header records to see if they are within the requested timeframe.
  //	
  // 4.1 First sort, then rollup all the glb cleaned header recs for a acctno/did and
	//     determine the earliest dt_first_seen and latest date_last_seen for each.
	ds_hdr_recs_sorted   := sort(ds_hdr_recs_outglbclean,acctno,did);
  layout_hdr_recs_clnd := recordof(ds_hdr_recs_outglbclean);

 	layout_hdr_recs_clnd hdr_rec_xform(layout_hdr_recs_clnd l, layout_hdr_recs_clnd r) := transform
	  // accumulate the date range info
		self.dt_last_seen  := ut.max2(r.dt_last_seen,l.dt_last_seen);
		self.dt_first_seen := ut.min2(r.dt_first_seen,l.dt_first_seen); 
   	self               := l;
		self               := []; 
 	end;

  ds_hdr_recs_rolled := rollup(ds_hdr_recs_sorted,
															   left.acctno = right.acctno and
	                               left.did    = right.did, 
															 hdr_rec_xform(left, right));

  // 4.2 Get the date the batch is being run on.
  string8   run_date_str := StringLib.GetDateYYYYMMDD();
  unsigned4 run_date     := (unsigned4) run_date_str;
	// Determine the early date value within 06, 12 or 24 months of the run date.
	// NOTE: even though the number of days in 12 months could be 366 if that time span 
	// includes a leap year; using the standard 365 days/yr is Ok for this application.
	unsigned2 numdays := map(SearchTimeInMonths = SIXMONTHS        => DAYSIN_6MONTHS,
	                         SearchTimeInMonths = TWENTYFOURMONTHS => DAYSIN_24MONTHS,
											     //default of 365 days if neither 6 or 24 entered
	                                                                  DAYSIN_12MONTHS); 

  // 4.3 Subtract the calculated number of days from the run date.
  string8 early_date_str := ut.DateFrom_DaysSince1900(
	                             ut.DaysSince1900(run_date_str[1..4], 
																				        run_date_str[5..6], 
																								run_date_str[7..8]) - 
															 numdays);

  // 4.4 Convert to numeric yyyymm only format like the header recs dt_first_seen is.
  unsigned3 early_date := (unsigned3) early_date_str[1..6];

  // 4.5 Also calculate the date 6 months back from the run date to check registration 
	//     latest expiration dates against later.
	//     Do that by subtracting 6 months worth of days from the current (run) date.
  string8 early_reg_expdt := ut.DateFrom_DaysSince1900(
	                              ut.DaysSince1900(run_date_str[1..4], 
																				         run_date_str[5..6], 
																						 		 run_date_str[7..8]) - 
															  DAYSIN_6MONTHS);

  // 4.6 Filter to only keep dids/header recs with dt_first_seen (in yyyymm format) 
	//     greater than or equal to the calculated early_date.
  ds_hdr_recs_kept := ds_hdr_recs_rolled(dt_first_seen >= early_date);

	// 4.7 Sort/dedup to only keep 1 record for each did in case multiple addresses were
	//     associated to the same did.
  ds_hdr_recs_kept_deduped := dedup(sort(ds_hdr_recs_kept,did),
	                                  did);


  // 5. Get the "best" info for the dids.
  //
  // 5.1 Project the deduped dids from the rolled header recs onto the layout
	//     needed by doxie.best_records.
  ds_dids_projctd_dlr := project(ds_hdr_recs_kept_deduped,
	                               transform(doxie.layout_references, self := left));

	// 5.2 Get the "Best" name,address,SSN info for each did.
	ds_best_info_for_dids := doxie.best_records(ds_dids_projctd_dlr,
																							doSuppress    := false,
																							include_minors:= IncludeMinors,
																							getSSNBest    := GetSSNBest,
																							modAccess := mod_access
																						 );
	addrBest_recs := BatchServices.NonRegisteredVehicles_BatchService_Functions.getRankedAddrBest(ds_best_info_for_dids);

  // 5.3 Join the header recs kept (in timeframe) with the "best" recs to start building 
	//     up the interim final layout plus some extra fields.
	//     NOTE: header recs kept is used because it also has the acctno(s) connected to each
	//     did, because the same did can potentially be connected to more than 1 acctno.
	ds_hdr_recs_wbest_raw := join(ds_hdr_recs_kept, addrBest_recs,
	                                left.did = right.did,
							                  transform(layout_final_wextra,
															// keep certain fields from the "left" (hdr recs kept) file
                              self.acctno                 := left.acctno;		                          
															self.did                    := (string) left.did;
                              string6 temp_dt_first_seen  := (string6) left.dt_first_seen;
                              string6 temp_dt_last_seen   := (string6) left.dt_last_seen;
															// Calculate the number of months the person has been at the
															// address. 
															// Account for empty/zero dt_last_seen and
															// account for dates the same = 1 month instead of 0.
                              self.months_at_addr := if(temp_dt_last_seen = ''  or 
															                          temp_dt_last_seen = '0' or
																												temp_dt_last_seen = '000000',
															                          '',
															                          (string2) (ut.MonthsApart(
															                                    temp_dt_first_seen,
														                                      temp_dt_last_seen) + 1)); 
                              self.inaddr_date_first_seen := temp_dt_first_seen;
                              self.inaddr_date_last_seen  := temp_dt_last_seen;
                              // store fields from the "right" (best) file
                              self.occupant_fname         := right.fname;
                              self.occupant_mname         := right.mname;
                              self.occupant_lname         := right.lname;
                              self.occupant_suffix        := right.name_suffix;
                              self.occupant_ssn           := right.ssn;
		                          self.best_address           := Address.Addr1FromComponents(
														                                 right.prim_range,
                                                             right.predir,
                                                             right.prim_name,
                                                             right.suffix,
                                                             right.postdir,
                                                             right.unit_desig,
                                                             right.sec_range),
		                          self.best_city              := right.city_name;
                              self.best_state             := right.st;
                              self.best_zip               := right.zip + if(right.zip4 !='' and right.zip4 !='0000', 
														                                                '-' + right.zip4,'');
                              //self.best_date_first_seen   := (string) right.addr_dt_first_seen;
															//  best dfs not returned in doxie.best_records (---^)
															// so commented out the line above for now (03/09/12) until 
															// can investigate further about adding it to doxie.layout_best
															// without impacting other things.
                              self.best_date_last_seen    := (string) right.addr_dt_last_seen;
                              // the 2 fields below are not in the final layout, but are
															// needed for setting the current_address flag.
															self.best_prim_range        := right.prim_range,
															self.best_prim_name         := right.prim_name,
															self.best_sec_range         := right.sec_range,
													    // null out all other output fields; they will be filled in later
													   self := []),
                             left outer, // keep all recs from left, 
														             // whether they match to best or not
														 limit(JOIN_LIMIT)
														);

  // 5.4 DID & SSN pulling/suppression and SSN masking.
	Suppress.MAC_Suppress(ds_hdr_recs_wbest_raw,ds_hrwbr_pulled_dids,mod_access.application_type,Suppress.Constants.LinkTypes.DID,did);
	Suppress.MAC_Suppress(ds_hrwbr_pulled_dids,ds_hrwbr_pulled_ssns,mod_access.application_type,Suppress.Constants.LinkTypes.SSN,occupant_ssn);
	Suppress.MAC_Mask(ds_hrwbr_pulled_ssns,ds_hdr_recs_wbest,occupant_ssn,'',true, false,,,,mod_access.ssn_mask);


  // 6. Get in-house MVR data if requested.
  //
	// 6.1 Assign the dataset of dids to get info for, depending upon the SearchMVR option 
	//     that was input.
	ds_ihmvrs_dids := if(~RtMvrOnly  // not RT=in-house first or in-house only or in-house & rt
	                     and dppa_ok, // don't even try if DPPA_Purpose is not a valid value
	                     ds_hdr_recs_wbest,
	                     dataset([],layout_final_wextra));

	// 6.2 First get all the vehicle/iteration/sequence keys for all the dids.
  ds_ihmvrs_vehkeys := join(ds_ihmvrs_dids, VehicleV2.Key_Vehicle_DID,
									            Keyed((integer) left.did = right.append_did),
											      transform(right),
											      inner, // only keep left recs with match in right
														limit(JOIN_LIMIT));

  // 6.3 Sort/dedup by vehicle_key to identify the 1 most recent record 
	//     (highest iteration_key & sequence_key) of each vehicle(vin).
	//     NOTE: since the "AE" & "DI" sources data is the same for the few fields we want,
	//     it doesn't really matter which one we get, so we dedup just on vehicle_key.
	ds_ihmvrs_vehkeys_vk_deduped := dedup(sort(ds_ihmvrs_vehkeys,vehicle_key,
	                                                             -iteration_key,
	                                                             -sequence_key),
	                                      vehicle_key);

	// 6.4.1 Next get the vehicle(vin) related data for those deduped vehicle_keys 
	//       from the mvr "main" key file.
	ds_ihmvrs_vin_data := join(ds_ihmvrs_vehkeys_vk_deduped,VehicleV2.Key_Vehicle_Main_Key,
	                              keyed(left.vehicle_key   = right.vehicle_key and
															        left.iteration_key = right.iteration_key),
														 transform(right), 
														 inner, // only keep left recs with match in right
														 limit(JOIN_LIMIT));

	// 6.4.2 Filter to check if the data is ok to use depending upon dppa_purpose, state_origin, etc.
	//       NOTE: This coding was cloned from VehicleV2_Services.Functions.Get_VehicleSearch
	//       and modified for use here.
  //dppa_purpose_x := DPPA_Purpose; // from doxie.MAC_Header_Field_Declare()
  ds_ihmvrs_vin_data_ok := ds_ihmvrs_vin_data(
							mod_access.isValidDPPAState (state_origin, , source_code) and
							(includeNonRegulatedSources or source_code not in [MDR.sourceTools.src_infutor_veh,MDR.sourceTools.src_infutor_motorcycle_veh]));
 
  // 6.4.3 Join the dataset of all the vehicle/iteration/sequence keys for all the dids 
	//       with the vin data records that are ok to use.  Which will keep only the 
	//       dids/keys that are ok use.
  ds_ihmvrs_vehkeys_ok := join(ds_ihmvrs_vehkeys, ds_ihmvrs_vin_data_ok, 
		                             left.vehicle_key   = right.vehicle_key and
															   left.iteration_key = right.iteration_key,
																 // NOTE: sequence_key is not on the main key file which 
																 // was used to create the vin data ok file above.
																 // So it cannot be used for joining here.
														   transform(left),
														   inner, // only keep left recs with match in right
														   limit(JOIN_LIMIT));

	// 6.5 Next get the registration related data for the vehicle_key/did 
	//     from the mvr "party" key file.
	ds_ihmvrs_reg_data := join(ds_ihmvrs_vehkeys_ok,VehicleV2.Key_Vehicle_Party_Key,
	                             keyed(left.vehicle_key   = right.vehicle_key   AND
															       left.iteration_key = right.iteration_key AND
															       left.sequence_key  = right.sequence_key)       
																AND
																//registration expiration date is not blank 
																(right.reg_latest_expiration_date !='' and
																 (right.history   = '' or //only use if current or 
																 // within 6 months of current date (req 4.1.9)
                                  right.reg_latest_expiration_date >= early_reg_expdt))
																AND 
				                        left.append_did = right.append_did // only get the rec for the did
										          ,
															transform(right),
															inner, // only keep left recs with match in right
														  keep(1), // only keep 1 key file rec if multiple (i.e. owner & registrant) 
														  limit(JOIN_LIMIT));

  // 6.6 Sort & dedup to only keep the most recent registration record for each 
	//     did/vin(vehicle_key) combo, in case there were multiples 
	//     (i.e. a recently expired registration and a renewal for the same vin).
  ds_ihmvrs_reg_data_deduped := dedup(sort(ds_ihmvrs_reg_data,append_did,vehicle_key,
	                                         -reg_latest_expiration_date,record),
	                                    append_did,vehicle_key);
	 

  // 6.7 Next join the hdr recs rolled/deduped with "best" data appended to the  
	//     mvr party (registration) data of those dids that have "current" registration  
	//     info for the vin/did combos identified above.
	ds_hdr_recs_wbest_ihmvr_reg_data := join(ds_hdr_recs_wbest, ds_ihmvrs_reg_data_deduped,
	                                           left.did = (string12) right.append_did,
							                             transform(layout_final_wextra,
																			       // Get registration data we want from right
																		         self.registration_source := if(right.append_did != 0,INHOUSE_ONLY,'');
                                             self.registration_date   := right.reg_latest_effective_date;
                                             self.expiration_date     := right.reg_latest_expiration_date;
                                             self.plate               := right.reg_license_plate;
															               self.reg_state           := right.state_origin;
																		         self.vehicle_key         := right.vehicle_key;
		 									    		               // keep rest of fields from left
															               self := left),
                                           left outer, // keep all recs from left, 
														                    // whether they had current reg data or not
														               limit(JOIN_LIMIT));

  // 6.8 Next join the hdr recs with best + mvr reg data appended with 
	//     the mvr main (vin) data.
	ds_hdr_recs_wbest_ihmvr_all_data := join(ds_hdr_recs_wbest_ihmvr_reg_data, ds_ihmvrs_vin_data,
	                                           left.vehicle_key = right.vehicle_key,
							                             transform(layout_final_wextra,
																			       // Get vehicle related data we want from right.
																				     // Use the vina "lookup" fields if not empty (expect color),
																				     // otherwise use the original fields.
                                             self.vin          := right.vina_vin;
                                             self.vehicle_year := if(right.vina_model_year !='',
																				                             right.vina_model_year,
																																     right.orig_year);
                                             self.make         := if(right.vina_make_desc !='',
																				                             right.vina_make_desc,
																																     right.orig_make_desc);
                                             self.model        := if(right.vina_model_desc !='',
																				                             right.vina_model_desc,
																																     right.orig_model_desc);
																				     self.color        := right.orig_major_color_desc;
		 									    		               // keep rest of fields from left
															               self := left),
                                           left outer, // keep all recs from left, 
														                       // whether they had a mvr match or not
														               limit(JOIN_LIMIT));


  // 7. Get Polk "Real Time" MVR gateway data if requested.

  // A common transform with a counter so it can be used to store either the best or 
  // previous address fields into the rt mvr gateway input "search by" fields.
  VehicleV2_Services.Batch_Layout.RealTime_InLayout 
	                           rtgwin_xform(layout_final_wextra l, unsigned1 c) := transform
    self.acctno      := l.did; //temporarily put did in here for matching to rt output
    self.name_full   := ''; //not needed
		// Store best name fields always
    self.name_first  := l.occupant_fname;
    self.name_middle := l.occupant_mname;
    self.name_last   := l.occupant_lname;
    self.name_suffix := l.occupant_suffix;
		// Store best or previous address fields depending upon input "c" value
		self.addr1       := choose(c,l.best_address,l.prev_address);
    self.addr2       := ''; //not needed
		self.p_city_name := choose(c,l.best_city,l.prev_city_name);
    self.st          := choose(c,l.best_state,l.prev_st);
    self.z5          := choose(c,l.best_zip[1..5],l.prev_z5);
    // rest of RealTime_InLayout fields can be blanked out
    self             := [];
	end;

  // A common transform to store the rt mvr gateway output fields we want.
  layout_final_wextra 
	         rtgwout_xform(layout_final_wextra l, 
	                       VehicleV2_Services.Batch_Layout.RealTime_OutLayout r) := transform
    // Store the rt gw out vehicle/vin & registration data from the r(ight) input ds.
    self.vin                 := r.vin;
    self.vehicle_year        := r.model_year;
    self.make                := r.make_desc;
    self.model               := r.model_desc;
	  self.color               := ''; // not returned from rt gw
		self.registration_source := REALTIME_ONLY;
    self.registration_date   := r.reg_latest_effective_date;
    self.expiration_date     := r.reg_latest_expiration_date;
    self.plate               := ''; // not returned from rt gw
		self.reg_state           := r.reg_license_state;
		// keep rest of fields from l(eft) input ds; 
    // which will restore the actual acctno value
    self := l;
  end;
 
 	// 7.0.1 Depending upon the SearchMVR option that was input, assign the dataset of 
	//       people&addresses to get the real time mvr info for.
  //       If InhouseMvrFirst was requested, filter to only keep those recs without a VIN
	//       (i.e., no vehicle info found for the did in the in_house mvr data), 
	//       so we can then try "looking" them up in the real time mvr gateway.
	//       Otherwise, if InhouseMvrOnly was not requested (which means either 
	//       BothInhouseRtMvr or RtMVROnly was requested), try getting real time mvr data 
	//       for all the dids (people) associated with the input address.
	//       Otherwise, if InhouseMvrOnly was requested, create an empty dataset in the
	//       proper layout so no rt mvr access is attempted.
	ds_recs_for_rtmvr_lookup_all := if(InhouseMVRFirst,
	                                   // If "in-house" first was requested, only include 
																	   // recs that did not have in-house mvr data
																		 // (i.e. vin is blank).
	                                   ds_hdr_recs_wbest_ihmvr_all_data(vin =''),
																		 // Otherwise, BothInhouseRtMvr or RtMVROnly 
																		 // was requested, so include all recs.
	                                   if(~InhouseMvrOnly, 
	                                      ds_hdr_recs_wbest,
	                                      // Otherwise it has to be an InHouseMvrOnly 
																			  // request, so use an "empty" dataset.
																				dataset([], layout_final_wextra)));

  // 7.0.2 Join the "good/cleaned" input to the ds of all hdr recs for rt lookup to put 
	//       the input address fields in the temp final-with-extra layout for use below.
	ds_recs_for_rtmvr_lookup_win := join(ds_batch_in_good, 
	                                     ds_recs_for_rtmvr_lookup_all,
		                                     left.acctno = right.acctno,
									                     transform(layout_final_wextra,
                  											 // Copy "cleaned" input fields to temp output layout
                                         self.in_prim_range  := left.prim_range;
                                         self.in_predir      := left.predir;
                                         self.in_prim_name   := left.prim_name;
                                         self.in_addr_suffix := left.addr_suffix;
                                         self.in_postdir     := left.postdir;
                                         self.in_unit_desig  := left.unit_desig;
                                         self.in_sec_range   := left.sec_range;
                                         self.in_city_name   := left.p_city_name;
                                         self.in_st          := left.st;
                                         self.in_z5          := left.z5;
                                         self.in_zip4        := left.zip4;
													               // rest of fields from right
													               self                := right),
											                 inner, // only recs from left that match to right
												               limit(JOIN_LIMIT));

  // 7.1.1 For the first RT access attempt, filter all the potential rt recs to only 
	//       keep ones where the input-state is not= best-state. (req 4.1.9.1)
  ds_recs_for_rtmvr_lookup1_instnebest := ds_recs_for_rtmvr_lookup_win(in_st != best_state);

	// 7.1.2 Then project them into the gateway input layout using best address.
  ds_rtmvr_gwin1_instnebest := project(ds_recs_for_rtmvr_lookup1_instnebest,
	                                     rtgwin_xform(left,USE_BEST));

	// 7.1.3 If there are records (people) that need real time mvr info to be looked up, 
	//       call the RT mvr gateway via an existing batch service records function.
	//       Otherwise create an empty dataset in the layout of the RT mvr gateway 
	//       batch service records function output.
	UNSIGNED1 RTGW_Operation := 0; // 0 = not vin or plate/st search
  ds_rtmvr_gwout1_data := 
	   if(exists(ds_rtmvr_gwin1_instnebest),
	      VehicleV2_Services.RealTime_Batch_Service_Records(ds_rtmvr_gwin1_instnebest,
																	                        RTGW_Operation),
	      dataset([],VehicleV2_Services.Batch_Layout.RealTime_OutLayout));

  // 7.1.4 Filter to only keep recs with a registration expiration date non-blank and 
  //       within 6 months of the current(run) date (req 4.1.9)
  ds_rtmvr_gwout1_kept := ds_rtmvr_gwout1_data(reg_latest_expiration_date !='' and 
                                               reg_latest_expiration_date >= early_reg_expdt);

	// 7.1.5 Join the recs for rt lookup#1 with the recs kept from the rt output #1 to find
	//       those recs that had a rt "hit" and to store the rt gw data in the interim layout.
  ds_recs_for_rtmvr_lookup1_wrthit := join(ds_recs_for_rtmvr_lookup1_instnebest,
	                                         ds_rtmvr_gwout1_kept,
	                                           left.did = right.acctno AND // right.acctno is the did 
																				     right.vin != '' AND // only use gw results that had a vin
																				     // best name = 1 of gw out registrant name(s)
																				     // since gateway seems to return all vehicles at 
																				     // an input address regardless of the input name.
																				     (left.occupant_fname = right.reg_1_fname or
																				      left.occupant_fname = right.reg_2_fname)    AND
																				     (left.occupant_mname[1] = right.reg_1_mname[1] or
																				      left.occupant_mname[1] = right.reg_2_mname[1] or
																							left.occupant_mname != '' and
																							right.reg_1_mname   = '')                   AND
                                             (left.occupant_lname = right.reg_1_lname or
																				      left.occupant_lname = right.reg_2_lname),
																				   rtgwout_xform(left,right),
												                   inner, // only keep left recs with match in right
												                   limit(JOIN_LIMIT));

  // 7.1.6 Join the recs for rtmvr lookup #1 with the recs that had a rt "hit" to 
	//       determine the "no hit" recs.
  ds_recs_for_rtmvr_lookup1_wrtnohit := join(ds_recs_for_rtmvr_lookup1_instnebest,
	                                           ds_recs_for_rtmvr_lookup1_wrthit,
																						   left.acctno = right.acctno and
																							 left.did    = right.did,
							                               transform(left),
												                     left only // only keep left recs with no match in right
																						);
																					 
  // 7.2.1 For the second RT access attempt, first filter all the potential rt recs to  
	//       only keep ones where the input-state is = best-state. (req 4.1.9.2)
  ds_recs_for_rtmvr_lookup2_insteqbest := ds_recs_for_rtmvr_lookup_win(in_st = best_state);
	
	// 7.2.2 Combine the recs with in-state = best_state with recs with no rt lookup1 hit 
	//       (req 4.1.9.2) and then sort/dedup them by acctno/did.
  ds_recs_for_rtmvr_lookup2 := dedup(sort(ds_recs_for_rtmvr_lookup2_insteqbest + 
	                                        ds_recs_for_rtmvr_lookup1_wrtnohit,
																					acctno,did,record),
																		 acctno,did);

	// 7.2.3 Then call a function to get the previous address for all of those acctnos/dids.
  ds_prevaddrs_recs_for_rtmvr_lookup2 := 
	    BatchServices.NonRegisteredVehicles_BatchService_Functions.GetPrevAddr_for_DID(
	                 project(ds_recs_for_rtmvr_lookup2,
									         transform(doxie.layout_references_acctno,
													   self.did    := (unsigned6) left.did;
														 self.acctno := left.acctno;
													 )));

  // 7.2.4 Join the recs for rt lookup#2 with the previous address recs to attach the 
	//       previous address info to them.
	ds_recs_for_rtmvr_lookup2_wprevaddrs := join(ds_recs_for_rtmvr_lookup2,
	                                             ds_prevaddrs_recs_for_rtmvr_lookup2,
																						     left.acctno = right.acctno and
                                                 left.did    = (string12) right.did,
							                                 transform(layout_final_wextra,
																						     // get prev addr fields from right
																						     self.prev_address   := Address.Addr1FromComponents(
														                                            right.prim_range,
                                                                        right.predir,
                                                                        right.prim_name,
                                                                        right.suffix,
                                                                        right.postdir,
                                                                        right.unit_desig,
                                                                        right.sec_range);
                                                 self.prev_city_name := right.city_name; 
                                                 self.prev_st        := right.st;
                                                 self.prev_z5        := right.zip;
																						     // rest of fields from left
																							   self := left;
																						   ),
																				       left outer, //keep all recs from left
												                       limit(JOIN_LIMIT));

  // 7.2.5 For the second RT access attempt, filter the potential rt lookup2 recs to
	//       only keep ones where the input-state is not= prev-state (which is 
	//       not blank). (req 4.1.9.3)
  ds_recs_for_rtmvr_lookup2_instneprev := ds_recs_for_rtmvr_lookup2_wprevaddrs(
                                                        in_st != prev_st and prev_st !='');

	// 7.2.6 Then project them into the gateway input layout using previous address.
  ds_rtmvr_gwin2_instneprev := project(ds_recs_for_rtmvr_lookup2_instneprev,
	                                     rtgwin_xform(left,USE_PREV));

	// 7.2.7 If there are records (people) that need real time mvr info to be looked up a second
	//       time, call the RT mvr gateway via an existing batch service records function.
	//       Otherwise create an empty dataset in the layout of the RT mvr gateway 
	//       batch service records function output.
  ds_rtmvr_gwout2_data := 
	   if(exists(ds_rtmvr_gwin2_instneprev),
	      VehicleV2_Services.RealTime_Batch_Service_Records(ds_rtmvr_gwin2_instneprev,
																	                        RTGW_Operation),
	      dataset([],VehicleV2_Services.Batch_Layout.RealTime_OutLayout));

  // 7.2.8 Filter to only keep recs with a registration expiration date non-blank and 
  //       within 6 months of the current(run) date (req 4.1.9)
  ds_rtmvr_gwout2_kept := ds_rtmvr_gwout2_data(reg_latest_expiration_date !='' and 
                                               reg_latest_expiration_date >= early_reg_expdt);

	// 7.2.9 Join the recs for rt lookup#2 with the recs kept from the rt output #2 to find
	//       those recs that had a rt2 "hit" and to store the rt gw data2 in the interim layout.
  ds_recs_for_rtmvr_lookup2_wrthit := join(ds_recs_for_rtmvr_lookup2_instneprev,
	                                         ds_rtmvr_gwout2_kept,
	                                           left.did = right.acctno AND // right.acctno is the did 
																				     right.vin != '' AND // only use gw results that had a vin
																				     // best name = 1 of gw out registrant name(s)
																				     // since gateway seems to return all vehicles at 
																				     // an input address regardless of the input name.
																				     (left.occupant_fname = right.reg_1_fname or
																				      left.occupant_fname = right.reg_2_fname)    AND
																				     (left.occupant_mname[1] = right.reg_1_mname[1] or
																				      left.occupant_mname[1] = right.reg_2_mname[1] or
																							left.occupant_mname != '' and
																							right.reg_1_mname   = '')                   AND
                                             (left.occupant_lname = right.reg_1_lname or
																				      left.occupant_lname = right.reg_2_lname),
																			     rtgwout_xform(left,right),
												                   inner, // only keep left recs with match in right
												                   limit(JOIN_LIMIT));

  // 7.2.10 Join the recs for rtmvr lookup #2 with the recs that had a rt "hit" to 
	//        determine the "no hit" recs.
  ds_recs_for_rtmvr_lookup2_wrtnohit := join(ds_recs_for_rtmvr_lookup2_instneprev, 
	                                           ds_recs_for_rtmvr_lookup2_wrthit,
																						   left.acctno = right.acctno,
							                               transform(left),
												                     left only // only keep left recs with no match in right
																						);
																							 
  // 7.2.11 Filter to just keep recs with in-state = best-state
	ds_recs_for_rtmvr_lookup2_nohit_insteqbest := ds_recs_for_rtmvr_lookup2_wrtnohit(
                                                          in_st = best_state);
																													
  // 7.3.1 For the third RT access attempt, filter the potential rt lookup2 recs to
	//       only keep ones where the input-state = prev-state or the prev_state = blank
	//       (no prev addr found). (req 4.1.9.4)
  ds_recs_for_rtmvr_lookup3_insteqprev := ds_recs_for_rtmvr_lookup2_wprevaddrs(
                                 (in_st = prev_st or prev_st ='') and in_st = best_state);

	// 7.3.2 Combine the recs with in-state = prev-state with recs with no rt lookup2 hit 
	//       (req 4.1.9.4) and then sort/dedup them by acctno/did.
  ds_recs_for_rtmvr_lookup3 := dedup(sort(ds_recs_for_rtmvr_lookup3_insteqprev + 
	                                        ds_recs_for_rtmvr_lookup2_nohit_insteqbest,
																					acctno,did,record),
																		 acctno,did);

  // 7.3.3 Also for the third RT access attempt, filter all the potential rt lookup3 recs 
	//       to only use ones where the input-state = best-state. (req 4.1.9.4)
  ds_recs_for_rtmvr_lookup3_insteqbest := ds_recs_for_rtmvr_lookup2(in_st = best_state);

	// 7.3.4 Then project them into the gateway input layout using best address.
  ds_rtmvr_gwin3_insteqbest := project(ds_recs_for_rtmvr_lookup3_insteqbest,
	                                     rtgwin_xform(left,USE_BEST));

	// 7.3.5 If there are records (people) that need real time mvr info to be looked up a 
	//       third time, call the RT mvr gateway via an existing batch service records function.
	//       Otherwise create an empty dataset in the layout of the RT mvr gateway 
	//       batch service records function output.
  ds_rtmvr_gwout3_data := 
	   if(exists(ds_rtmvr_gwin3_insteqbest),
	      VehicleV2_Services.RealTime_Batch_Service_Records(ds_rtmvr_gwin3_insteqbest,
																	                        RTGW_Operation),
	      dataset([],VehicleV2_Services.Batch_Layout.RealTime_OutLayout));

  // 7.3.6 Filter to only keep recs with a registration expiration date non-blank and 
  //       within 6 months of the current(run) date (req 4.1.9)
  ds_rtmvr_gwout3_kept := ds_rtmvr_gwout3_data(reg_latest_expiration_date !='' and 
                                               reg_latest_expiration_date >= early_reg_expdt);

	// 7.3.7 Join the recs for rt lookup#3 with the recs kept from the rt output #3 to find
	//       those recs that had a rt "hit" and to store the rt gw data in the interim layout.
  ds_recs_for_rtmvr_lookup3_wrthit := join(ds_recs_for_rtmvr_lookup3_insteqbest,
	                                         ds_rtmvr_gwout3_kept,
	                                           left.did = right.acctno AND // right.acctno is the did 
																				     right.vin != '' AND // only use gw results that had a vin
																				     // best name = 1 of gw out registrant name(s)
																				     // since gateway seems to return all vehicles at 
																				     // an input address regardless of the input name.
																				     (left.occupant_fname = right.reg_1_fname or
																				      left.occupant_fname = right.reg_2_fname)   AND
																				     (left.occupant_mname[1] = right.reg_1_mname[1] or
																				      left.occupant_mname[1] = right.reg_2_mname[1] or
																							left.occupant_mname != '' and
																							right.reg_1_mname   = '')                   AND
                                             (left.occupant_lname = right.reg_1_lname or
																				      left.occupant_lname = right.reg_2_lname),
																				   rtgwout_xform(left,right),
																				   inner, // only keep left recs with match in right
												                   limit(JOIN_LIMIT));

  // 7.4 Combine the rt mvr lookup hits from all 3 lookups.
  ds_hdr_recs_wbest_rtmvr_lookup_hits := ds_recs_for_rtmvr_lookup1_wrthit +
	                                       ds_recs_for_rtmvr_lookup2_wrthit + 
																         ds_recs_for_rtmvr_lookup3_wrthit;


  // 8. Combine/dedup/sort datasets.
  // 
  // 8.1 Combine dataset of all hdr recs with best info plus in-house mvr data (optional)
	//    with the dataset of hdr recs that had real-time mvr data (if requested & found)
	//    and sort into order for deduping.
	//    Then dedup to remove any blank vehicle info "placeholder" records for a did, 
	//    if a IH and/or RT record exists for the did.
	ds_hdr_recs_wallmvr_deduped := dedup(sort(ds_hdr_recs_wbest_ihmvr_all_data + 
	                                          ds_hdr_recs_wbest_rtmvr_lookup_hits
																						,
																						acctno,did,-vehicle_year,-vin,
																						-registration_source,record),
																			 // dedup on acctno, did, veh_yr, vin & reg_src. 
																			 // if one reg_src is blank and one is not, 
																			 // keep the one that is not.
																			 left.acctno = right.acctno and
                                       left.did    = right.did    and
																			 ut.nneq(left.vehicle_year, right.vehicle_year) and
																			 ut.nneq(left.vin, right.vin) and
																			 ut.nneq(left.registration_source, right.registration_source));
																			 
  // 8.2 Re-sort into a better order   
	ds_hdr_recs_wallmvr_sorted := sort(ds_hdr_recs_wallmvr_deduped,
	                                   acctno,did,vehicle_year,vin,registration_source,record);


  // 9. Set the vehicle_id for each vehicle(vin) for each did within an acctno.
	layout_final_wextra xform_vid(layout_final_wextra L, layout_final_wextra R) := transform
	  // only set the vehicle_id for recs with vehicle(vin) info on them
    self.vehicle_id := if(R.vin !='',L.vehicle_id + 1,0);
		self            := R;
	end;

  ds_hdr_recs_wallmvr_wvid := iterate(group(ds_hdr_recs_wallmvr_sorted,acctno,did),
	                                    xform_vid(left,right));

  // 10. Assign person_id field.
	//
  // 10.1 Sort in preferred order and then group by acctno.
	ds_out_wacctno_grouped := group(sort(ds_hdr_recs_wallmvr_wvid,
	                                     acctno,(unsigned6) did,vehicle_id,record),
	                                acctno);

  // 10.2 Set the person_id for each did within each acctno.
	layout_final_wextra xform_pid(layout_final_wextra L, layout_final_wextra R) := transform
	  // only set the person_id for recs with did info on them
    self.person_id := if(L.did != R.did,L.person_id + 1,L.person_id);
		self           := R;
	end;
  ds_out_wacctno_pid := iterate(ds_out_wacctno_grouped,xform_pid(left,right));


  // 11. Add any "REJ"ected input records back in here and sort by acctno+
	ds_out_wacctno_all := sort(ds_out_wacctno_pid + ds_batch_in_rejected,
	                           acctno,person_id,vehicle_id,record);


  // 12. Join the "raw" (unvalidated/uncleaned) input ds to the interim output data
	//     to put	the input fields in the final output.
	ds_out_winput := join(ds_batch_in, ds_out_wacctno_all,
		                      left.acctno = right.acctno,
											  transform(layout_final_wextra,
												  // Copy "raw" input fields to output layout
													self.acctno         := left.acctno;
													self.in_name_first  := left.name_first;
                          self.in_name_middle := left.name_middle;
                          self.in_name_last   := left.name_last;
                          self.in_name_suffix := left.name_suffix;
                          self.in_prim_range  := left.prim_range;
                          self.in_predir      := left.predir;
                          self.in_prim_name   := left.prim_name;
                          self.in_addr_suffix := left.addr_suffix;
                          self.in_postdir     := left.postdir;
                          self.in_unit_desig  := left.unit_desig;
                          self.in_sec_range   := left.sec_range;
                          self.in_city_name   := left.p_city_name;
                          self.in_st          := left.st;
                          self.in_z5          := left.z5;
                          self.in_zip4        := left.zip4;
                          self.in_ssn         := left.ssn;
													Self.in_dob         := left.dob;
													// rest of fields from right
													self                := right),
											  left outer, // return all recs from left (input) whether results or not
												limit(JOIN_LIMIT)); 


  // 13. Join the cleaned input ds to the interim output data to set the 
	//     "current_address" indicator and to set the "hit_flag".
	ds_final_results := join(ds_batch_in_cleaned, ds_out_winput,
		                         left.acctno = right.acctno,
											     transform(layout_final,
													   // Set the "hit_flag".
														 // Account for input recs that were rejected or 
														 // with no results (no did value in right file or 
														 // no vehicle/vin) or
                             // input state = vehicle registered state or
														 // input state not = vehicle registered state.
														 self.hit_flag :=
											 							map(right.hit_flag = REJECTED_REC  => right.hit_flag,
                                        right.did = '' or right.vin='' => NO_HIT,
                                        left.st = right.reg_state      => INSTATE_REG,
                                                                          OUTOFSTATE_REG);
														 // Set the current_address indicator by comparing the 
														 // "cleaned" input address fields vs the "best" address data.
														 temp_cur_addr_ind := 
															 if(right.best_address !='' AND // first must have a best addr 
															                                // to even check for current
															    (((left.z5 !='' and left.z5 = right.best_zip[1..5]) or
																     left.z5 ='')                                          AND
																   ((left.st !='' and left.st = right.best_state) or
																	   left.st = '')                                         AND
																	 ((left.p_city_name !='' and left.p_city_name = right.best_city) or
																		 left.p_city_name = '')                                AND
                                   ((left.prim_range !='' and left.prim_range = right.best_prim_range) or
																		 left.prim_range = '')                                 AND
                                   ((left.prim_name  !='' and left.prim_name  = right.best_prim_name) or
																		 left.prim_name = '')                                  AND
				                           ((left.sec_range  !='' and left.sec_range  = right.best_sec_range) or
																		 left.sec_range = '')),
																  'Y','N');
														 self.current_address := temp_cur_addr_ind;
														 // v--- Temp fix until can complete all research about adding
														 //      addr_dt_first_seen to doxie.best_layout.
														 self.best_date_first_seen := if(right.best_date_first_seen !='',
														                                 right.best_date_first_seen,
																														 if(temp_cur_addr_ind = 'Y',
																														    right.inaddr_date_first_seen,
																																''));
														 
														 // rest of fields from right
														 self                := right),
													 left outer, // return all recs from left (input) whether results or not
													 limit(JOIN_LIMIT)); 

  // Uncomment lines below as needed for debugging
  //OUTPUT(SearchTimeInMonths,         NAMED('SearchTimeInMonths'));
	//OUTPUT(IncludePplAtAddr,           NAMED('IncludePplAtAddr')); 
  //OUTPUT(SearchMVR,                  NAMED('SearchMVR'));
	
	//OUTPUT(ds_batch_in,                NAMED('ds_batch_in'));
	//OUTPUT(ds_batch_in_caps,           NAMED('ds_batch_in_caps'));
	//OUTPUT(ds_batch_in_cleaned,        NAMED('ds_batch_in_cleaned'));
	// OUTPUT(ds_batch_in_good,           NAMED('ds_batch_in_good'));
	// OUTPUT(ds_batch_in_rejected,       NAMED('ds_batch_in_rejected'));
  // OUTPUT(ds_hdr_recs_match_input,    NAMED('ds_hdr_recs_match_input'));
	// OUTPUT(ds_hdr_recs_outglbclean,    NAMED('ds_hdr_recs_outglbclean'));
	//OUTPUT(ds_hdr_recs_sorted,         NAMED('ds_hdr_recs_sorted'));
  // OUTPUT(ds_hdr_recs_rolled,         NAMED('ds_hdr_recs_rolled'));
  // OUTPUT(run_date_str,               NAMED('run_date_str'));
  // OUTPUT(run_date,                   NAMED('run_date'));
  // OUTPUT(numdays,                    NAMED('numdays'));
  // OUTPUT(early_date_str,             NAMED('early_date_str'));
  // OUTPUT(early_date,                 NAMED('early_date'));
  // OUTPUT(early_reg_expdt,            NAMED('early_reg_expdt'));
  // OUTPUT(ds_hdr_recs_kept,           NAMED('ds_hdr_recs_kept'));
  //OUTPUT(ds_hdr_recs_kept_deduped,   NAMED('ds_hdr_recs_kept_deduped'));
  //OUTPUT(ds_dids_projctd_dlr,        NAMED('ds_dids_projctd_dlr'));
	// OUTPUT(ds_best_info_for_dids,      NAMED('ds_best_info_for_dids'));	
	// OUTPUT(addrBest_recs,      				 NAMED('addrBest_recs'));
	// OUTPUT(ds_hdr_recs_wbest_raw,      NAMED('ds_hdr_recs_wbest_raw'));
	//OUTPUT(ds_hrwb_pulled_dids,        NAMED('ds_hrwb_pulled_dids'));
	//OUTPUT(ds_hrwb_pulled_ssns,        NAMED('ds_hrwb_pulled_ssns'));
	//OUTPUT(ds_hdr_recs_wbest,          NAMED('ds_hdr_recs_wbest'));

	//OUTPUT(ds_ihmvrs_dids,                   NAMED('ds_ihmvrs_dids'));
  //OUTPUT(ds_ihmvrs_vehkeys,                NAMED('ds_ihmvrs_vehkeys'));
  //OUTPUT(ds_ihmvrs_vehkeys_vk_deduped,     NAMED('ds_ihmvrs_vehkeys_vk_deduped'));	
	//OUTPUT(ds_ihmvrs_vin_data,               NAMED('ds_ihmvrs_vin_data'));
  //OUTPUT(ds_ihmvrs_vin_data_ok,            NAMED('ds_ihmvrs_vin_data_ok'));
  //OUTPUT(ds_ihmvrs_vehkeys_ok,             NAMED('ds_ihmvrs_vehkeys_ok'));
  //OUTPUT(ds_ihmvrs_vehkeys_vkdid_deduped,  NAMED('ds_ihmvrs_vehkeys_vkdid_deduped'));
	//OUTPUT(ds_ihmvrs_reg_data,               NAMED('ds_ihmvrs_reg_data'));
	//OUTPUT(ds_ihmvrs_reg_data_deduped,       NAMED('ds_ihmvrs_reg_data_deduped'));
	//OUTPUT(ds_hdr_recs_wbest_ihmvr_reg_data, NAMED('ds_hdr_recs_wbest_ihmvr_reg_data'));
	//OUTPUT(ds_hdr_recs_wbest_ihmvr_all_data, NAMED('ds_hdr_recs_wbest_ihmvr_all_data'));
	//OUTPUT(ds_recs_for_rtmvr_lookup_all,         NAMED('ds_recs_for_rtmvr_lookup_all'));
	//OUTPUT(ds_recs_for_rtmvr_lookup_win,         NAMED('ds_recs_for_rtmvr_lookup_win'));
	//OUTPUT(ds_recs_for_rtmvr_lookup1_instnebest, NAMED('ds_recs_for_rtmvr_lookup1_instnebest'));
	//OUTPUT(ds_rtmvr_gwin1_instnebest,            NAMED('ds_rtmvr_gwin1_instnebest'));
  //OUTPUT(ds_rtmvr_gwout1_data,                 NAMED('ds_rtmvr_gwout1_data'));
  //OUTPUT(ds_rtmvr_gwout1_kept,                 NAMED('ds_rtmvr_gwout1_kept'));
  //OUTPUT(ds_recs_for_rtmvr_lookup1_wrthit,     NAMED('ds_recs_for_rtmvr_lookup1_wrthit'));
  //OUTPUT(ds_recs_for_rtmvr_lookup1_wrtnohit,   NAMED('ds_recs_for_rtmvr_lookup1_wrtnohit'));
  //OUTPUT(ds_recs_for_rtmvr_lookup2_insteqbest, NAMED('ds_recs_for_rtmvr_lookup2_insteqbest'));
  //OUTPUT(ds_recs_for_rtmvr_lookup2,            NAMED('ds_recs_for_rtmvr_lookup2'));
  //OUTPUT(ds_prevaddrs_recs_for_rtmvr_lookup2,  NAMED('ds_prevaddrs_recs_for_rtmvr_lookup2'));
  //OUTPUT(ds_recs_for_rtmvr_lookup2_wprevaddrs, NAMED('ds_recs_for_rtmvr_lookup2_wprevaddrs'));
  //OUTPUT(ds_recs_for_rtmvr_lookup2_instneprev, NAMED('ds_recs_for_rtmvr_lookup2_instneprev'));
  //OUTPUT(ds_rtmvr_gwin2_instneprev,            NAMED('ds_rtmvr_gwin2_instneprev'));
  //OUTPUT(ds_rtmvr_gwout2_data,                 NAMED('ds_rtmvr_gwout2_data'));
  //OUTPUT(ds_rtmvr_gwout2_kept,                 NAMED('ds_rtmvr_gwout2_kept'));
  //OUTPUT(ds_recs_for_rtmvr_lookup2_wrthit,     NAMED('ds_recs_for_rtmvr_lookup2_wrthit'));
  //OUTPUT(ds_recs_for_rtmvr_lookup2_wrtnohit,   NAMED('ds_recs_for_rtmvr_lookup2_wrtnohit'));
  //OUTPUT(ds_recs_for_rtmvr_lookup2_nohit_insteqbest, NAMED('ds_recs_for_rtmvr_lookup2_nohit_insteqbest'));
	//OUTPUT(ds_recs_for_rtmvr_lookup3_insteqbest, NAMED('ds_recs_for_rtmvr_lookup3_insteqbest'));
	//OUTPUT(ds_rtmvr_gwin3_insteqbest,            NAMED('ds_rtmvr_gwin3_insteqbest'));
  //OUTPUT(ds_rtmvr_gwout3_data,                 NAMED('ds_rtmvr_gwout3_data'));
  //OUTPUT(ds_rtmvr_gwout3_kept,                 NAMED('ds_rtmvr_gwout3_kept'));
  //OUTPUT(ds_recs_for_rtmvr_lookup3_wrthit,     NAMED('ds_recs_for_rtmvr_lookup3_wrthit'));
  //OUTPUT(ds_hdr_recs_wbest_rtmvr_lookup_hits,  NAMED('ds_hdr_recs_wbest_rtmvr_lookup_hits'));
	//OUTPUT(ds_hdr_recs_wallmvr_deduped,   NAMED('ds_hdr_recs_wallmvr_deduped'));
	//OUTPUT(ds_hdr_recs_wallmvr_sorted,    NAMED('ds_hdr_recs_wallmvr_sorted'));

  //OUTPUT(ds_hdr_recs_wallmvr_wvid,      NAMED('ds_hdr_recs_wallmvr_wvid'));
  //OUTPUT(ds_out_wacctno_pid,            NAMED('ds_out_wacctno_pid'));
  //OUTPUT(ds_out_wacctno_all,            NAMED('ds_out_wacctno_all'));
	//OUTPUT(ds_out_winput,                 NAMED('ds_out_winput'));
  //OUTPUT(ds_final_results,              NAMED('ds_final_results'));

	//return ds_batch_in;
	//return ds_batch_in_cleaned;
	//return ds_hdr_recs_kept;
	//return ds_hdr_recs_wbest;
	//return ds_hdr_recs_wbest_ihmvr_all_data;
	//return ds_hdr_recs_wbest_rtmvr_lookup_hits;
  //return ds_hdr_recs_wallmvr_deduped;
	//retrun ds_hdr_recs_wallmvr_sorted;
  //return ds_hdr_recs_wallmvr_wvid;	
	//return ds_out_wacctno_pid;
	
  RETURN ds_final_results;

END;