IMPORT Address, AutoStandardI, doxie, Residency_Services, Royalty, ut, VehicleV2_Services;

EXPORT fn_getVehicles(DATASET(Residency_Services.Layouts.IntermediateData) ds_input, 
                      Residency_Services.IParam.BatchParams mod_params_in):= FUNCTION

	mod_VehRTBv2_params := MODULE(VehicleV2_Services.IParam.RTBatch_V2_params)
		// The 2 below were specifically mentioned in req 4.3.6
		EXPORT BOOLEAN GatewayNameMatch      := TRUE;
		EXPORT BOOLEAN ReturnCurrent	       := TRUE;

		// AlwaysHitGateway is also being set here because it defaults to "false" in 
		//    VehicleV2_Services.IParam, but it is passed into 
		//    VehicleV2_Services.RealTime_Batch_Service_V2_records where it is checked there.
		//    It is set the same way here as the "useExperian" boolean is done down in the 
		//    VehicleV2_Services.Get_Gateway_Data attribute.
    EXPORT BOOLEAN AlwaysHitGateway      := ~doxie.DataPermission.use_Polk;

    // NOTE: All the other params in VehicleV2_Services.IParam.RTBatch_V2_params can use the default
		//       there or the common ones like: DPPA, GLB, DRM ,IndustryClass, ApplicationType, etc.
		//       are read from stored names by the use of inputParams := AutoStandardI.GlobalModule();
		//       in VehicleV2_Services.RealTime_Batch_Service_Records; which is called 
		//       by VehicleV2_Services.RealTime_Batch_Service_V2_records used below.
	END;

	ds_input_projtd := PROJECT(ds_input, 
	                           TRANSFORM(VehicleV2_Services.Batch_Layout.RealTime_InLayout_V2,
			SELF.AcctNo				:= (STRING)LEFT.seq,   
			SELF.Name_First 	:= LEFT.name_first,
			SELF.Name_Middle 	:= LEFT.name_middle,
			SELF.Name_Last		:= LEFT.name_last,
			SELF.Name_Suffix	:= LEFT.name_suffix,
			SELF.addr1        := LEFT.prim_range  + ' ' + LEFT.predir      + ' ' + 
										       LEFT.prim_name   + ' ' + LEFT.addr_suffix + ' ' + 
										       LEFT.postdir;
			// NOTE: have to put these 2 below in addr2.  putting them at the end of addr1, does not
			//       get them parsed correctly in VehicleV2_Services.RealTime_Batch_Service_V2_records
			SELF.addr2        := LEFT.unit_desig  + ' ' + LEFT.sec_range;
			SELF.p_City_name	:= LEFT.p_City_name,
			SELF.St						:= LEFT.St,
			SELF.Z5						:= LEFT.Z5,
			SELF := []  )); // null out other input fields

	ds_RTBSV2_recs := VehicleV2_Services.RealTime_Batch_Service_V2_records(ds_input_projtd,
																																				 mod_VehRTBv2_params,
																																				 TRUE);	//Is_VehV2?
	
	ds_RTBSv2_recs_fltrd   := ds_RTBSv2_recs(is_current = TRUE); // filter to only use the currently 
	                                                             // registered vehicles for
																				                       // the person/address above
	
	ds_RTBSv2_recs_deduped := DEDUP(SORT(ds_RTBSv2_recs_fltrd, acctno,vin,
	                                                           -reg_latest_effective_date,
	                                                           -reg_latest_expiration_date),
																	acctno,vin);

  // Check that either the reg_latest_effective_date (if not blank) or if it is blank, 
	// check that the the reg_latest_expiration_date is within 1 year of the current date.
	curr_date := Residency_Services.Constants.TodaysDate;

  ds_RTBSv2_recs_dd_dateok := ds_RTBSv2_recs_deduped(
																		         ((reg_latest_effective_date !='' and
																						   reg_latest_effective_date < curr_date) and 
	                                            (ut.DaysApart(reg_latest_effective_date, curr_date) 
																	            < Residency_Services.Constants.Days_in_Year))
																		         OR
																						 (reg_latest_expiration_date >= curr_date or
																						  (ut.DaysApart(reg_latest_expiration_date, curr_date) 
																	            < Residency_Services.Constants.Days_in_Year))
																						        );

  // Join and transform to match input to vehicle recs found
	Residency_Services.Layouts.Int_Service_output_addr  tf_temp_lo(ds_input L, 
	                                                               ds_RTBSv2_recs_dd_dateok R
	                                                               ) := TRANSFORM
		SELF.seq          := L.seq;
		SELF.did          := L.did;
		SELF.expired_flag := 'N';
    SELF.prim_range 	:= L.prim_range;
		SELF.predir     	:= L.predir;
		SELF.prim_name  	:= L.prim_name;
		SELF.addr_suffix 	:= L.addr_suffix;
		SELF.postdir     	:= L.postdir;
		SELF.unit_desig  	:= L.unit_desig;
		SELF.sec_range  	:= L.sec_range;
		SELF.p_city_name	:= L.p_city_name;
		SELF.st           := l.st,
		SELF.z5      		  := L.z5;
		SELF.zip4        	:= L.zip4;
		SELF.county_name  := L.county_name;
	END;

	ds_RTBSv2_recs_matched := JOIN(ds_input, ds_RTBSv2_recs_dd_dateok, 
													        LEFT.seq         = (UNSIGNED3)RIGHT.acctno   AND
														      // v--- only ones where input did is a registrant
														      (ut.NZEQ(LEFT.did, (UNSIGNED6)RIGHT.reg_1_did) or 
														       ut.NZEQ(LEFT.did, (UNSIGNED6)RIGHT.reg_2_did) or
																	 ut.NZEQ(LEFT.did, (UNSIGNED6)RIGHT.reg_3_did) ) AND
													        LEFT.prim_range  = RIGHT.prim_range          AND    
													        LEFT.predir			 = RIGHT.predir              AND
													        LEFT.prim_name	 = RIGHT.prim_name           AND
													        LEFT.addr_suffix = RIGHT.addr_suffix         AND
													        LEFT.postdir		 = RIGHT.postdir             AND
															    // v--- sec_range may or may not be present
                                  ut.NNEQ(LEFT.sec_range, RIGHT.sec_range)     AND
													        LEFT.p_city_name = RIGHT.p_city_name         AND
													        LEFT.st				   = RIGHT.st                  AND
													        LEFT.z5			     = RIGHT.z5
																	,
													      tf_temp_lo(LEFT,RIGHT),
													      INNER); //intentionally only keep left that match right
	

	returnDetailedRoyalties	:= FALSE : STORED('ReturnDetailedRoyalties');
	Royalty.RoyaltyVehicles.MAC_Append(ds_RTBSV2_recs, ds_resultsMA, vin, hit_flag, TRUE);	
	Royalty.RoyaltyVehicles.MAC_BatchSet(ds_resultsMA, ds_royalties,,returnDetailedRoyalties);	
	
	Veh_OutRec  := RECORD
			DATASET(RECORDOF(ds_RTBSv2_recs_matched)) Results;
			DATASET(RECORDOF(ds_royalties)) Royalties;
		end;
		
	ds_getVehs_out := DATASET([{ds_RTBSv2_recs_matched, ds_royalties}], Veh_OutRec);
		
  // OUTPUT(mod_VehRTBv2_params.RealTimePermissibleUse, NAMED('fgve_RealTimePermissibleUse'));
	// OUTPUT(ds_input,                 NAMED('fgve_ds_input'));
	// OUTPUT(ds_input_projtd,          NAMED('fgve_ds_input_projtd'));
  // OUTPUT(ds_RTBSV2_recs,           NAMED('fgve_ds_RTBSV2_recs'));
	// OUTPUT(ds_RTBSv2_recs_fltrd,     NAMED('fgve_ds_RTBSV2_recs_fltrd'));
	// OUTPUT(ds_RTBSv2_recs_deduped,   NAMED('fgve_ds_RTBSV2_recs_deduped'));
  // OUTPUT(ds_RTBSv2_recs_dd_dateok, NAMED('fgve_ds_RTBSV2_recs_dd_dateok'));
	// OUTPUT(ds_RTBSv2_recs_matched,   NAMED('fgve_ds_RTBSV2_recs_matched'));
	// OUTPUT(ds_royalties,             NAMED('fgve_ds_royalties'));	
	// OUTPUT(ds_getVehs_out,           NAMED('fgve_ds_getVehs_out'));

	RETURN ds_getVehs_out;

END;
	