import AutoStandardI, iesp, doxie;

EXPORT LicenseSearch_Records (MIDEX_Services.IParam.searchrecords in_mod) := 
  FUNCTION
		
		nonPubAccess := MIDEX_Services.Functions.fn_GetNonPubDataSources(in_mod.DataPermissionMask);
    
    UNSIGNED1 alertVersion := in_mod.AlertVersion;
    
		// Get non public sanction data
		nonpub_sanct_ids := MIDEX_Services.Search_IDs.Mari_NonPublic_Sanct_val(in_mod);
		nonPub_src_recs := MIDEX_Services.Raw_Nonpublic.License.Search_View.by_midex_rpt_num(nonpub_sanct_ids,alertVersion,,,nonPubAccess);
		
		// Get public sanction data
		pub_sanct_ids := MIDEX_Services.Search_IDs.Mari_Public_Sanct_val(in_mod);
		Pub_src_recs := MIDEX_Services.Raw_Public.License.Search_View.by_midex_rpt_num(pub_sanct_ids,alertVersion);
		
		// Get professional license data
		prof_ids := MIDEX_Services.Search_IDs.Mari_ProfLic_val(in_mod);
		Prof_src_recs := MIDEX_Services.Raw_ProfessionalLicenses.License.Search_View.by_mari_num(prof_ids,alertVersion);
		
		// Combine and penalize
		all_recs_dedup := DEDUP(nonPub_src_recs+Pub_src_recs+Prof_src_recs,ALL);	
		
		all_recs_penalt := MIDEX_Services.Macros.fnMac_penalize_results(all_recs_dedup,in_mod,
																							                      MIDEX_Services.Layouts.license_srch_layout,
																							                      licensee_FirstName,licensee_MidName,
                                                                    licensee_LastName,
                                                                    licensee_companyName,lic_number,
                                                                    lic_state,taxid,,,,did);
		
		all_recs_kept := all_recs_penalt((penalt DIV 1000) < MIDEX_Services.Constants.penaltyThreshold); 
    all_recs_sorted := SORT(all_recs_kept, penalt, ~isCurrent);
    
		/*
    // Since we moved to a different alert version, we don't need to make use of the "ReturnAllRecords" flag
		// Only keep search records that do not match the previous search hash values.
    alertOnly_recs := JOIN(all_recs_sorted,in_mod.searchHashes,
													 LEFT.all_hash = RIGHT.all_hash,
													 TRANSFORM(LEFT),
													 LEFT ONLY);
		
    // If Alert search and if ReturnAllRecords is false (default), return the changed search records, otherwise return all of the search records.
    all_recs_final := IF(~in_mod.EnableAlert OR in_mod.ReturnAllRecords,all_recs_sorted,alertOnly_recs);
    */
   	alertUpdateHash_recs := PROJECT(all_recs_sorted,MIDEX_Services.Layouts.hash_layout);
		
		finalresults := MIDEX_Services.Functions.Format_licenseSearch_iesp(all_recs_sorted,alertUpdateHash_recs,in_mod);
    
	  RETURN(finalresults);

	END;
