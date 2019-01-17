IMPORT Address_Rank, AutoStandardI, Didville, Residency_Services, ut;
			 
EXPORT fn_getBestInfo(DATASET(Residency_Services.Layouts.Batch_in) ds_batch_in,
                      Residency_Services.IParam.BatchParams        mod_params_in
                     ) := FUNCTION

	rec_layout_intermed_ext := Residency_Services.Layouts.IntermediateData_ext;

  // Use input data to get the did (& score) and the "Best" address & ssn, etc.
	DidVille.Layout_Did_OutBatch tf_input(ds_batch_In l) := TRANSFORM
	 // store certain input fields into a diferent name
	 SELF.seq     := (UNSIGNED)l.acctno; // didville function below uses seq, not acctno
	 SELF.phone10 := l.phone;
	 SELF.fname   := l.name_first;
	 SELF.mname   := l.name_middle;
	 SELF.lname   := l.name_last;
	 SELF.suffix  := l.name_suffix;
	 SELF.title   := '';
	 SELF	:= l; // <--- picks up other input fields: ssn, dob, parsed address fields
	END;

	ds_batch_in_proj := PROJECT(ds_Batch_In, tf_input(LEFT));

	append_l  := 'BEST_ALL, BEST_EDA'; //Append_1 allows all Best Info to return
	verify_l  := 'BEST_ALL';

	// NO_GM = no global mod hits (Copied from BatchShare.MAC_Get_Scored_DIDs) 
  NO_GM  := AutoStandardI.PermissionI_Tools.val(ut.PopulateDRI_Mod(mod_params_in));
  glb_ok := NO_GM.glb.ok(mod_params_in.GLBPurpose);

	ds_bestrecs := didville.did_service_common_function(ds_batch_in_proj,
																									    appends_value := append_l, 
																									    verify_value  := verify_l,
																									    glb_flag           := glb_ok, 
																									    glb_purpose_value  := mod_params_in.GLBPurpose,
																									    appType            := mod_params_in.ApplicationType,
																									    dppa_purpose_value := mod_params_in.DPPAPurpose,
																									    IndustryClass_val  := mod_params_in.industryclass,
																									    DRM_val            := mod_params_in.DataRestrictionMask
																										 );

	ds_bestrecs_fltrd := ds_bestrecs(score >= Residency_Services.Constants.Defaults.DidScoreThreshold);

  // Join ds with best info found with the batch_in to put didville best info
	// onto a common/intermediate layout.
	rec_layout_intermed_ext tf_BestInfo(ds_bestrecs_fltrd l, ds_batch_in r) := TRANSFORM
	  // Keep certain fields from "best"
		SELF.acctno 		  := (STRING20)l.seq; // restore acctno from best routine "seq" field
		SELF.ssn          := l.best_ssn;
		SELF.dob          := l.best_dob;
		SELF.did          := l.did;
		SELF.p_city_name	:= l.best_city;
    SELF.st           := l.best_state;
    SELF.z5           := l.best_zip;
    SELF.zip4         := l.best_zip4;
		SELF.dt_last_seen := (UNSIGNED4)l.best_addr_date;

    // Also keep these from "best", but it really should not matter
		SELF.name_first  := l.best_fname;
		SELF.name_middle := l.best_mname;
		SELF.name_last   := l.best_lname;
		SELF.name_suffix := l.best_name_suffix;
		SELF.phone       := l.best_phone;

		// Keep these 2 from input
		SELF.Residency_County := r.Residency_County;
		SELF.Residency_State	:= r.Residency_State;

		// Set these 2 as needed
		SELF.isBestAddress    := 'Y';
		SELF.Entity_NotFound  := 'N';

    SELF.seq :=0; // will be assigned in Residency_Services.Functions.DedupeAddrs
		SELF := r;   // keep rest of fields from right/batch input
	END;

	ds_batch_in_found_wbest := JOIN(ds_bestrecs_fltrd, ds_batch_in,
									                  LEFT.seq = (UNSIGNED) RIGHT.acctno,
									                tf_BestInfo(LEFT,RIGHT)
														     );

  // Next get "Government Best Address" using Address_Rank.BatchService(Address_Rank.Records), 
	// per Change Control request on 07/08/16 from product manager Cindy Liozzo.
	mod_params_AR := MODULE(PROJECT(mod_params_in, Address_Rank.IParams.BatchParams, OPT))
                   END;		

	// Project ds of recs found with best info onto the layout expect by Address_Rank.Records
  ds_batch_in_fwb_arlo := PROJECT(ds_batch_in_found_wbest,
                                  TRANSFORM(Address_Rank.Layouts.Batch_in,
																    SELF := LEFT;));

	ds_AddrRankRecs := Address_Rank.Records(ds_batch_in_fwb_arlo, mod_params_AR);

	rec_layout_intermed_ext tf_AddrRankInfo(ds_batch_in_found_wbest L, ds_AddrRankRecs R) := TRANSFORM
		// keep the individual Address Rank "best" address(BA_*) fields
		SELF.prim_range  := R.BA_prim_range;
		SELF.predir			 := R.BA_predir;
		SELF.prim_name	 := R.BA_prim_name;
		SELF.addr_suffix := R.BA_addr_suffix;
		SELF.postdir		 := R.BA_postdir;
		SELF.unit_desig  := R.BA_unit_desig;
		SELF.sec_range 	 := R.BA_sec_range;
		SELF.p_city_name := R.BA_p_city_name;
		SELF.st					 := R.BA_st;
		SELF.z5					 := R.BA_z5;
		SELF.zip4				 := R.BA_zip4;
    SELF.dt_last_seen := (UNSIGNED4)R.BA_dt_last_seen;
		SELF := L; //keep all other fields from left/batch_in found with best
	END;

	ds_batch_in_found_wBestAR := JOIN(ds_batch_in_found_wbest,
                                    ds_AddrRankRecs(BA_flag='B'), //only recs with best addr found
														          LEFT.acctno = RIGHT.acctno,
									                  tf_AddrRankInfo(LEFT,RIGHT),
														        LEFT OUTER); // keep all from left even if no match to right

	// Update Entity_NotFound flag for persons(dids) that were not found based upon the input
	ds_batch_in_notfound := JOIN(ds_batch_in, ds_bestrecs_fltrd,
									                (UNSIGNED) LEFT.acctno = RIGHT.seq,
									             TRANSFORM(rec_layout_intermed_ext,  
											           SELF.Entity_NotFound := 'Y',
												         SELF :=LEFT,
												         SELF :=[]),
											         LEFT ONLY); //only ones in left with no match to right

	ds_recs_all := ds_batch_in_found_wBestAR + ds_batch_in_notfound;

   //OUTPUT(ds_batch_in,               NAMED('fgBA_ds_batch_in'));
   //OUTPUT(ds_batch_in_proj,          NAMED('fgBA_ds_batch_in_proj'));
   //OUTPUT(ds_bestrecs,               NAMED('fgBA_ds_bestrecs'));
	 //OUTPUT(ds_bestrecs_fltrd,         NAMED('fgBA_ds_bestrecs_fltrd'));
   //OUTPUT(ds_batch_in_found_wbest,   NAMED('fgBA_ds_batch_found_wbest'));
	 //OUTPUT(ds_batch_in_fwb_arlo,      NAMED('fgBA_ds_batch_in_fwb_arlo'));
	 //OUTPUT(ds_AddrRankRecs,           NAMED('fgBA_ds_AddrRankRecs'));
	 //OUTPUT(ds_batch_in_found_wBestAR, NAMED('fgBA_ds_batch_in_found_wBestAR'));
   //OUTPUT(ds_batch_in_notfound,      NAMED('fgBA_ds_batch_in_notfound'));
   //OUTPUT(ds_recs_all,               NAMED('fgBA_ds_recs_all'));

	RETURN SORT(ds_recs_all,acctno);  //sort to put recs back in acctno order

END;