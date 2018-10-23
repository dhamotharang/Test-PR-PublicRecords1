IMPORT AutoStandardI, iesp, ut;

EXPORT LicenseReport_Records (MIDEX_Services.IParam.reportrecords in_mod) := 
  FUNCTION
	
		ssn_mask_val := AutoStandardI.InterfaceTranslator.ssn_mask_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.ssn_mask_value.params));
		application_type_value := AutoStandardI.InterfaceTranslator.application_type_val.val(project(in_mod,AutoStandardI.InterfaceTranslator.application_type_val.params));
		
		// Two possible report Ids can be passed, midex_rpt_num is for sanct(public and nonpublic) and 
		// mari_rid is for professional license. 
		
		// ds_test_ids := dataset([										// individuals
														// {'5718827'},
														// {'5893328'},
														// {'6213547'},
														// {'4815386'},
														// {'3600106'}
														// ],Layouts.rec_profLicMari_payloadKeyField);
														
		// ds_test_ids := dataset([										//company
														// {'159079'},
														// {'1718037'},
														// {'50987'},
														// {'638607'},
														// {'332456'}
														// ],Layouts.rec_profLicMari_payloadKeyField);
		
    ds_AllRidsNmlsDbas := MIDEX_Services.Functions.fn_GetAdditional_NMLS_MariRids(in_mod):INDEPENDENT;

    ds_dsNMLSwithDBAs := 
      PROJECT(ds_AllRidsNmlsDbas, MIDEX_Services.Layouts.rec_NMLSWithDBAs);
    
    ds_DBAsRolled :=
      ROLLUP(ds_dsNMLSwithDBAs,
             LEFT.nmlsid = RIGHT.nmlsid,
             TRANSFORM(MIDEX_Services.Layouts.rec_NMLSWithDBAs,
                       SELF.NMLSId   := LEFT.NMLSId,
                       SELF.DBANames := LEFT.DBANames + RIGHT.DBANames ));
      
    ds_Profreport_ids  := DEDUP(SORT(ds_AllRidsNmlsDbas.MariRids + in_mod.MariRidNumbers, mari_rid), mari_rid);
		ds_Sanctreport_ids := in_mod.MidexReportNumbers;
    
    // Get Non Public Sanction report(s)
		nonPubAccess   := MIDEX_Services.Functions.fn_GetNonPubDataSources(in_mod.DataPermissionMask);
    sanctNP_report := MIDEX_Services.Raw_NonPublic.License.Report_View.by_midex_rpt_num(ds_Sanctreport_ids,in_mod.AlertVersion,in_mod.SearchType,,,nonPubAccess);
		
		// Get Public sanction report(s)
    sanctPub_report := MIDEX_Services.Raw_Public.License.Report_View.by_midex_rpt_num(ds_Sanctreport_ids,in_mod.AlertVersion,in_mod.SearchType,in_mod.ssnmask,in_mod.applicationType);
		
		// Get Profesional License Mari report(s)
		profLic_report := MIDEX_Services.Raw_ProfessionalLicenses.License.Report_View.by_mari_num(ds_Profreport_ids, 
                                                                                              in_mod.AlertVersion, 
                                                                                              in_mod.ssnmask, 
                                                                                              in_mod.applicationType, 
                                                                                              IF(in_mod.isLicenseOnlyReport,MIDEX_Services.Constants.ALL_LICENSES_SEARCH,in_mod.searchType));
																																															
          // removed (Dedup, DS, all ) so as not to resort the data set that is returned from the 3 DS's being added together.
		nohash_results_raw :=       
		CHOOSEN(sanctNP_report+sanctPub_report+profLic_report,iesp.Constants.MIDEX.MAX_COUNT_REPORT_LICENSES);	

    ds_nohash_withLicNMLSid :=
      PROJECT(nohash_results_raw,
              TRANSFORM(MIDEX_Services.Layouts.LicenseReport_RollupTempLayout,
                        SELF.LicNMLS_id := LEFT.Licenses[1].nmls_id,  // at this point there will always only be one row
                        SELF            := LEFT));

    ds_nohash_withLicNMLSid_nonblank := ds_nohash_withLicNMLSid(LicNMLS_id != 0);
		
    ds_nohash_withBlank_LicNMLSid    := 
      PROJECT(ds_nohash_withLicNMLSid(LicNMLS_id  = 0), MIDEX_Services.Layouts.LicenseReport_Layout);
			
    nohash_resultsLicsRolled :=
			  ROLLUP(ds_nohash_withLicNMLSid_nonblank,
             LEFT.LicNMLS_id = RIGHT.LicNMLS_id, // rollup all licenses associated with nmls id into one report
             TRANSFORM(MIDEX_Services.Layouts.LicenseReport_RollupTempLayout,
                       SELF.Licenses            := LEFT.Licenses + RIGHT.Licenses,
                       SELF.license_status_hash := LEFT.license_status_hash + RIGHT.license_status_hash,
                       SELF.DBAName             := IF(LEFT.DBAName = '', RIGHT.DBAName, LEFT.DBAName);
                       SELF.Locations           := LEFT.Locations + RIGHT.Locations,
                       SELF.Represents          := LEFT.Represents + RIGHT.Represents,
                       SELF.represent_hash 			:= LEFT.represent_hash + RIGHT.represent_hash,
				               SELF.Regulators          := LEFT.Regulators + RIGHT.Regulators,
                       SELF.Disc_Actions        := LEFT.Disc_Actions + RIGHT.Disc_Actions,
                       SELF.disciplinary_hash 	:= LEFT.disciplinary_hash + RIGHT.disciplinary_hash,
				               SELF.Reg_Actions         := LEFT.Reg_Actions + RIGHT.Reg_Actions,
                       SELF.registration_hash		:= LEFT.registration_hash + RIGHT.registration_hash,
                       SELF                     := LEFT));
    // the choosen for licenses, locations, represents, regulators, disc_actions & reg_actions is in 
    // transform to iesp in functions
    nohash_results_withNMLSids :=
      JOIN(ds_DBAsRolled, nohash_resultsLicsRolled, 
           LEFT.nmlsid = RIGHT.LicNMLS_id,
           TRANSFORM(MIDEX_Services.Layouts.LicenseReport_Layout,
                     SELF.NMLS_DBAs.nmlsId   := LEFT.nmlsid,
                     SELF.NMLS_DBAs.DBANames := CHOOSEN(DEDUP(SORT(LEFT.DBANames, DBAName), DBAName)(DBAName != ''),iesp.Constants.MIDEX.MAX_COUNT_REPORT_AKA_DBA) ,
                     SELF.Licenses           := DEDUP(SORT(RIGHT.Licenses, -lic_issue_date, lic_state, 
                                                                           lic_type, lic_number, 
                                                                           lic_status, -lic_expir_date, 
                                                                           -IsCurrent ), 
                                                          lic_issue_date, lic_state, 
                                                          lic_type, lic_number,  
                                                          lic_status, lic_expir_date),
                     SELF.Locations          := DEDUP(SORT(RIGHT.Locations, -start_date, company_name, 
                                                                            prim_name, predir, 
                                                                            prim_range, addr_suffix, 
                                                                            postdir, sec_range, 
                                                                            city, st, zip5, 
                                                                            -county, -nmls_id, 
                                                                            -comp_nmls_id, -mari_rid, 
                                                                            -phone, -location_type ), 
                                                          company_name, prim_name, 
                                                          predir, prim_range, 
                                                          addr_suffix, postdir, 
                                                          sec_range, city, st, 
                                                          zip5, county, nmls_id, 
                                                          comp_nmls_id, mari_rid, 
                                                          phone, location_type),
                     SELF.Represents         := DEDUP(SORT(RIGHT.Represents, -start_date, regulator_name, 
                                                                             registration_name, authorized, 
                                                                             company_name, reg_status ), 
                                                          ALL),
                     SELF.Regulators         := DEDUP(SORT(RIGHT.Regulators, regulator_name, registration_name, 
                                                                             authorized, Registrations),
                                                          All),
                     SELF.Disc_Actions       := DEDUP(SORT(RIGHT.Disc_Actions, action_type, -action_date, 
                                                                               action_detail, assoc_doc, 
                                                                               regulator_name, authority_name, 
                                                                               authority_type), 
                                                          ALL),
                     SELF.Reg_Actions        := DEDUP(SORT(RIGHT.Reg_Actions, action_type, -action_date, 
                                                                              regulator_name, action_detail,
                                                                              authority_name, authority_type, 
                                                                              -assoc_doc ),
                                                          ALL),
                     SELF                    := RIGHT),
           RIGHT OUTER);
    
    nohash_results := nohash_results_withNMLSids + ds_nohash_withBlank_LicNMLSid;
    
    // JIRA 10581 -- there now can be more than one row returned, 
    // so we must combine hashes
	  combineHashes := MIDEX_Services.Functions.fn_rollHashes(nohash_results);
    
    // replace individually calculated hashes with combined hashes 
    // and add passed values 
    hash_temp := PROJECT(nohash_results,TRANSFORM(MIDEX_Services.Layouts.monitor_layout,
                                            SELF.passed_name_hash := in_mod.namehash,
                                            SELF.passed_license_status_hash := in_mod.licensestathash,
                                            SELF.passed_phone_hash := in_mod.phonehash,
                                            SELF.passed_address_hash := in_mod.addresshash,
                                            SELF.passed_nmls_ID_hash := in_mod.NMLSIdHash,
                                            SELF.passed_Represent_hash := in_mod.RepresentHash,
                                            SELF.passed_Registration_hash := in_mod.RegistrationHash,
                                            SELF.passed_Disciplinary_hash := in_mod.DisciplinaryHash,
                                            SELF.passed_AKA_and_name_variation_hash := in_mod.AKAAndNameVariationHash,
                                            SELF.name_hash := combineHashes[1].name_hash,
				                                    SELF.address_hash := combineHashes[1].address_hash,
				                                    SELF.license_status_hash := combineHashes[1].license_status_hash,
				                                    SELF.nmls_Id_hash := combineHashes[1].nmls_Id_hash,
				                                    SELF.Represent_hash := combineHashes[1].Represent_hash,
				                                    SELF.Disciplinary_hash := combineHashes[1].Disciplinary_hash,
				                                    SELF.Registration_hash := combineHashes[1].Registration_hash,
				                                    SELF.phone_hash := combineHashes[1].phone_hash,
				                                    SELF.AKA_and_name_variation_hash	:= combineHashes[1].AKA_and_name_variation_hash,
                                            SELF := LEFT,
                                            SELF := []));
		
    hash_calcs := MIDEX_Services.alert_calcs.calcChanges(hash_temp,in_mod);	
		
		hash_results := JOIN(hash_calcs,nohash_results,
														LEFT.report_number = RIGHT.report_number,
														TRANSFORM(MIDEX_Services.Layouts.LicenseReport_Layout,
																			SELF := LEFT,
																			SELF := RIGHT,
																			SELF := []),
														LIMIT(ut.limits.default,SKIP));
		
	  MIDEX_Services.Layouts.LicenseReport_Layout xfm_make_delete_record() := TRANSFORM
		  SELF.report_number   	:= IF(in_mod.MariRidNumbers[1].mari_rid != 0,(STRING)in_mod.MariRidNumbers[1].mari_rid,in_mod.MidexReportNumbers[1].midex_rpt_nbr);
			SELF.deleted 					:= TRUE;
			SELF                  := [];
    END;
    
		deleted_results := DATASET([xfm_make_delete_record()]);
	
	 
		// If an alert report request and the document/report isn't found anymore, then return a record
		// with the record deleted flag set to true.
		rec_results := IF(in_mod.EnableAlert,
                      IF(EXISTS(hash_results),hash_results,deleted_results),
                      nohash_results);
           
		RETURN(rec_results);
	END;
	