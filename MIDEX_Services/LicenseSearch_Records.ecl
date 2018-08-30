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
                                                                    lic_state,taxid,,,,did,,,,,,,,,,,
                                                                    nmls_info[1].NMLSId);

		searchPenalty := MIDEX_Services.Functions.getPenalty(in_mod);

		all_recs_kept := all_recs_penalt(penalt < searchPenalty OR exactMatch);
		            				
		all_recs_sorted := IF (in_mod.CompanyName != '' and in_mod.firstName = '' and in_mod.middleName = '' and in_mod.lastName = '',								
								SORT(all_recs_kept, if ( licensee_firstname = '', 0, 1), if( licensee_midname = '', 0, 1), if ( licensee_lastname = '', 0, 1),
												penalt, ~isCurrent, IF (seleid !=0, 1,2) ),                                        
								SORT(all_recs_kept,penalt,~isCurrent,IF(DID != 0,1,2))
								); 																				
  
		alertUpdateHash_recs := PROJECT(all_recs_sorted,MIDEX_Services.Layouts.hash_layout);
		
		finalresults := MIDEX_Services.Functions.Format_licenseSearch_iesp(all_recs_sorted,alertUpdateHash_recs,in_mod);
        // output(all_recs_penalt, named('all_recs_penalt'));
	   // output(all_recs_kept, named('all_recs_kept'));
        // output(all_recs_sorted_old, named('all_recs_sorted_old'));				
	   // output(all_recs_sorted, named('all_recs_sorted'));
		// output(alertUpdateHash_recs, named('alertUpdateHash_recs'));
	  RETURN(finalresults);

	END;
