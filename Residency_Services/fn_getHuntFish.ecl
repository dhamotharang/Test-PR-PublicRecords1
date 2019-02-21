IMPORT doxie, doxie_raw, Residency_Services, STD, ut;

EXPORT fn_getHuntFish (DATASET(doxie.layout_references_acctno) ds_in_acctnos_dids,
                       Residency_Services.IParam.BatchParams   mod_params_in):= FUNCTION

  // Project input onto layout needed by doxie_raw.hunt_raw, also stripping off the acctno
	HF_In := PROJECT(ds_in_acctnos_dids,doxie.layout_references);

	Ded_HF_In := DEDUP(SORT(HF_In, did), did);

	HuntFishRecs:= doxie_raw.hunt_raw(Ded_HF_In,
															      glb_purpose  := mod_params_in.glb,
																		dppa_purpose := mod_params_in.dppa);

	SlimHFrec := RECORD
		Residency_Services.Layouts.Int_Service_output;
		STRING8 datelicense;
	END;
	
	// Slimdown and fix license_date if it is only a 4 digit year
	SlimHFrec tf_FixYearOnlyDates(HuntFishRecs L) := TRANSFORM
		SELF.DID         := L.DID;
		SELF.county_name := L.county_name;
		SELF.st          := L.st;
			datelength := LENGTH(TRIM(l.datelicense));
		// Check for HF lic dates with a year only (length = 4).  If found append month & day = to 
		// the last day of the year, so they work in the date check below.
		SELF.datelicense := IF(datelength = Residency_Services.Constants.Year_Only_Length,
		                       TRIM(l.datelicense) + Residency_Services.Constants.Last_Day_of_Year,
													 L.datelicense);
		SELF :=[];
	END;
		
	SlimHFrecs := PROJECT(HuntFishRecs, tf_FixYearOnlyDates(LEFT));
	
  TodaysDate := Residency_Services.Constants.TodaysDate;

	HF_fltrd := SlimHFrecs(ut.DaysApart(datelicense, TodaysDate) 
	                       <  Residency_Services.Constants.Days_in_Year);
	
	HFwacctno := JOIN(HF_fltrd, ds_in_acctnos_dids,
										  (UNSIGNED6)LEFT.did = RIGHT.did, 
										TRANSFORM(Residency_Services.Layouts.Int_Service_output,
										  SELF.acctno       := RIGHT.acctno,
											SELF.did          := RIGHT.did,
											SELF.expired_flag := 'N',
											SELF.county_name  := LEFT.county_name,
											SELF.st           := LEFT.st
									 ));

	RETURN HFwacctno;

END;
