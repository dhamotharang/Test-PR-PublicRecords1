﻿IMPORT tools, ut;

EXPORT Build_Base_Main(STRING pversion,
	                     DATASET(CLIA.Layouts.Base) inMainBase,
	                     BOOLEAN pUseAltLayout) := MODULE

  inMainUpdate := CLIA.Files().Input_From_CD.Main.Sprayed;

	// Take the update file and project it into the base layout.
	workingMainUpdate := PROJECT(inMainUpdate,
			                         TRANSFORM(CLIA.Layouts.Base,
				                                 SELF.dt_vendor_first_reported := (UNSIGNED4)pversion,
				                                 SELF.dt_vendor_last_reported := (UNSIGNED4)pversion,
				                                 SELF.record_type := 'C',

				                                 SELF := LEFT,
				                                 SELF := []));
	
	workingMainUpdate_clean_facility := CLIA.Standardize_Facility_Name(workingMainUpdate);
	workingMainUpdate_clean_phone := CLIA.Standardize_Phone(workingMainUpdate_clean_facility);

  // Distribute needed files for quicker processing
	workingMainUpdate_dist := DISTRIBUTE(workingMainUpdate_clean_phone, HASH(CLIA_number));
	inMainBase_dist := DISTRIBUTE(inMainBase, HASH(CLIA_number));

	// Make the input unique for CLIA_number, to help determine what's historical and what's not.
	unique_update := DEDUP(SORT(workingMainUpdate_dist, CLIA_number, LOCAL), CLIA_number, LOCAL);

	// Determine the records that are current, because the vendor is no longer sending any updates related
	// to that particular CLIA_number.
  workingCurrentMainBase := JOIN(inMainBase_dist, unique_update,
	                               LEFT.CLIA_number = RIGHT.CLIA_number,
																 TRANSFORM(CLIA.Layouts.Base,
																	 SELF.record_type := 'C';
																	 SELF := LEFT),

																 LEFT ONLY,
																 LOCAL);

  // Determine the records that are historical... vendor is still sending updates for that CLIA_number.
	workingHistoricalMainBase := JOIN(inMainBase_dist, unique_update,
	                                  LEFT.CLIA_number = RIGHT.CLIA_number,
																		TRANSFORM(CLIA.Layouts.Base,
																			SELF.record_type := 'H';
																			SELF := LEFT),

																		LOCAL);

	// Join base and update to determine what's new
	combinedMain := CLIA.Standardize_Addr(workingCurrentMainBase + workingHistoricalMainBase +
	                                    workingMainUpdate_dist);
	// Add/overwrite certificate type for all records
	combinedMainCertificate := CLIA.Append_Certificate_Type(combinedMain);
	// Add BDID
	combinedMainAID := CLIA.Append_IDs.fAll(combinedMainCertificate);
	combinedMain_dist := DISTRIBUTE(combinedMainAID, HASH(CLIA_number));
	combinedMain_sort := SORT(combinedMain_dist,
										        CLIA_number, lab_type, facility_name, facility_name2, address1, address2,
														   certificate_type, -expiration_date, record_type,
															 -dt_vendor_last_reported, RECORD, skew(0.1,0.5),
				                    LOCAL);
	
	CLIA.Layouts.Base rollupMain(CLIA.Layouts.Base L, CLIA.Layouts.Base R) := TRANSFORM
    SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported  := ut.LatestDate(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
   	SELF.source_rec_id            := IF(L.source_rec_id = 0, R.source_rec_id, L.source_rec_id);
		SELF.prov_cat_code            := if(L.dt_vendor_last_reported > R.dt_vendor_last_reported, L.prov_cat_code, R.prov_cat_code);																						 
	  SELF := L;
	END;
	
	baseMain := ROLLUP(combinedMain_sort,
	                   rollupMain(LEFT, RIGHT),
										 CLIA_number, RECORD,
										    EXCEPT record_type, dt_vendor_last_reported, dt_vendor_first_reported,
												   source_rec_id, prov_cat_code,
										 LOCAL);
	
 	// Add source record id
  ut.MAC_Append_Rcid(baseMain, source_rec_id, baseMainPlusSourceRid);

	// Return
	tools.mac_WriteFile(CLIA.Filenames(pversion).Base.Main.New, baseMainPlusSourceRid, Build_Base_File);

	EXPORT full_build := SEQUENTIAL(Build_Base_File,
			                            CLIA.Promote(pversion).buildfiles.New2Built);
		
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
		               full_build,
		               OUTPUT('No Valid version parameter passed, skipping CLIA.Build_Base_Main atribute'));

END;