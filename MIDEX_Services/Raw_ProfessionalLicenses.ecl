IMPORT AutoKeyI, AutoStandardI, census_data, iesp, Prof_License_Mari, ut, BIPV2;

// ==============================================================================================================	
//  MARI MIDEX "LICENSE" DATA (Prof_License_Mari) related functions
// ==============================================================================================================	

EXPORT Raw_ProfessionalLicenses := 
  MODULE
  
        //===========================================
        // Functions
        //===========================================
        EXPORT fn_get_ProfLicMari_AutokeyData ():=
          FUNCTION
       
            tempmod_License := 
              MODULE(PROJECT(AutoStandardI.GlobalModule(),AutoKeyI.AutoKeyStandardFetchArgumentInterface,OPT))
                EXPORT STRING autokey_keyname_root := Prof_License_Mari.constants.AK_QA_KEYNAME;
                EXPORT STRING typestr              := Prof_License_Mari.constants.TYPE_STR;
                EXPORT SET OF STRING1 get_skip_set := Prof_License_Mari.constants.SET_SKIP;
                EXPORT BOOLEAN useAllLookups       := Prof_License_Mari.constants.USE_ALL_LOOKUPS;
              END;

            ds_MidexProfLic_AutokeyData := AutoKeyI.AutoKeyStandardFetch(tempmod_License).ids;
            // ds_MidexProfLic_AutokeyData_Sorted := DEDUP( SORT( ds_MidexProfLic_AutokeyData, fakeid), fakeid);   
            ds_MidexProfLic_Autokey_mariRids := 
              JOIN( ds_MidexProfLic_AutokeyData,
                    Prof_License_Mari.key_autokey_payload,
                    KEYED(LEFT.id = RIGHT.fakeid),
                    TRANSFORM( MIDEX_Services.Layouts.rec_profLicMari_payloadKeyField, 
                               SELF.mari_rid := RIGHT.mari_rid;
                             ),
										LIMIT(ut.limits.default,SKIP));
                    
            RETURN ds_MidexProfLic_Autokey_mariRids;
            
          END; // fn_get_MidexProfLicAutokeyData

        
        EXPORT fn_get_ProfLicMari_BdidData (  UNSIGNED6 in_bdid ):=
          FUNCTION
            ds_ProfLicMari_bdid_recs := CHOOSEN(Prof_License_Mari.key_bdid( KEYED( BDID = in_bdid ) AND in_bdid != 0),ut.limits.default);
            MIDEX_Services.Macros.MAC_GetProfLic_MidexLayout_mariRid(ds_ProfLicMari_bdid_recs, ds_outDataSet );
            RETURN ds_outDataSet;  
          END; // fn_get_ProfLicMari_BdidData
            
        EXPORT fn_get_ProfLicMari_LinkIdData (  dataset(BIPV2.IDlayouts.l_xlink_ids) in_linkid, STRING1 FetchLevel ):=
          FUNCTION
            ds_ProfLicMari_linkid_recs := CHOOSEN(Prof_License_Mari.key_Linkids.kFetch(in_linkid, FetchLevel),ut.limits.default);
            MIDEX_Services.Macros.MAC_GetProfLic_MidexLayout_mariRid(ds_ProfLicMari_linkid_recs, ds_outDataSet );
            RETURN ds_outDataSet;  
          END; // fn_get_ProfLicMari_LinkIdData
					
        EXPORT fn_get_ProfLicMari_DidData ( UNSIGNED6 in_did ):=
          FUNCTION
            ds_ProfLicMari_did_recs := CHOOSEN(Prof_License_Mari.key_did()( KEYED( S_DID = in_did ) AND in_did != 0),ut.limits.default);
            MIDEX_Services.Macros.MAC_GetProfLic_MidexLayout_mariRid(ds_ProfLicMari_did_recs, ds_outDataSet );
            
            RETURN ds_outDataSet;  
          END; // fn_get_ProfLicMari_DidData
          
          
        EXPORT fn_get_ProfLicMari_licNbrData ( STRING30 in_lic_num, STRING30 in_lic_state = ''  ):=
          FUNCTION
            ds_ProfLicMari_License_recs := CHOOSEN(Prof_License_Mari.key_license_nbr( KEYED( cln_license_nbr = in_lic_num AND
                                                                                            (in_lic_state = '' OR license_state = in_lic_state )) AND in_lic_num != ''),ut.limits.default);
            MIDEX_Services.Macros.MAC_GetProfLic_MidexLayout_mariRid(ds_ProfLicMari_License_recs, ds_outDataSet );
            
            RETURN ds_outDataSet;  
          END; // get_ProfLicMari_licNbrPayloadData   
        
             
        EXPORT fn_get_ProfLicMari_tinSsnData ( STRING9 in_taxid, STRING2 in_tax_type ) :=
          FUNCTION
            // this key was built for three types using the same in_ssn_taxid field.  The tax id, ssn and ssn4
            // the id types are: E = tax id, S = ssn, s4 = ssn4
            ds_ProfLicMari_ssn_tin_recs := CHOOSEN(Prof_License_Mari.key_ssn_taxid( KEYED( ssn_taxid = in_taxid AND tax_type = in_tax_type ) AND in_taxid != ''),ut.limits.default);
            MIDEX_Services.Macros.MAC_GetProfLic_MidexLayout_mariRid(ds_ProfLicMari_ssn_tin_recs, ds_outDataSet );
            
            RETURN ds_outDataSet;
          END;
				
				EXPORT fn_get_ProfLicMari_nmlsIDData ( STRING40 in_nmls_id ):=
          FUNCTION
            ds_ProfLicMari_nmlsID_recs := CHOOSEN(Prof_License_Mari.key_nmls_id( KEYED( nmls_id = (INTEGER) in_nmls_id)),ut.limits.default);
            MIDEX_Services.Macros.MAC_GetProfLic_MidexLayout_mariRid(ds_ProfLicMari_nmlsID_recs, ds_outDataSet );
            
						RETURN ds_outDataSet;  
          END; // get_ProfLicMari_nmlsIDPayloadData   

        //===========================================
        // MODULE: License Search and report view 
        //===========================================
        EXPORT LICENSE := MODULE
				
						 EXPORT REPORT_VIEW := MODULE
								
                // Do not set a default for searchType becasue if a 
                // blank is defaulted, no records will ever be returned. 
                // New attributes calling this code must be sure to send the 
                // searchType in the function call. 
                // Use: MIDEX_Services.Constants.INDIV_SEARCH OR MIDEX_Services.Constants.COMP_SEARCH
								EXPORT by_mari_num( DATASET (MIDEX_Services.layouts.rec_profLicMari_payloadKeyField) in_ids,
                                    UNSIGNED1 alertVersion = Midex_Services.Constants.AlertVersion.None,
                                    STRING in_ssn_mask_type = '', STRING32 in_app_type = '', STRING1 searchType ) := FUNCTION
										
										prof_recsRaw := JOIN(in_ids,Prof_License_Mari.key_mari_payload,
																				KEYED(LEFT.mari_rid = RIGHT.mari_rid) AND
                                        // Bug# 182946 - Filter out records which have been superceded							   
                                        RIGHT.result_cd_1 NOT IN [Midex_Services.Constants.RECORD_STATUS.SupercededMariRidUpdatingSource,
                                                                  Midex_Services.Constants.RECORD_STATUS.SupercededMariRidNonUpdatingSource]												
													AND
																				CASE(searchType,
                                             MIDEX_Services.Constants.COMP_SEARCH => 
                                               RIGHT.affil_type_cd = MIDEX_Services.Constants.AFFILIATE_TYPES.COMPANY OR
                                               RIGHT.affil_type_cd = MIDEX_Services.Constants.AFFILIATE_TYPES.BRANCH,
                                             MIDEX_Services.Constants.INDIV_SEARCH => 
                                               RIGHT.affil_type_cd = MIDEX_Services.Constants.AFFILIATE_TYPES.INDIVIDUAL,
                                             MIDEX_Services.Constants.ALL_LICENSES_SEARCH =>
                                               TRUE,
                                             FALSE),													
																				TRANSFORM(MIDEX_Services.Layouts.LicenseReport_Layout,
																									SELF.data_source := RIGHT.std_source_desc,
																									SELF.last_upd_date := RIGHT.last_upd_dte,
																									SELF.TitleName := RIGHT.title,
																									SELF.FirstName := RIGHT.fname,
																									SELF.MiddleName := RIGHT.mname,
																									SELF.LastName := RIGHT.lname,
																									SELF.SuffixName := RIGHT.name_sufx,
																									SELF.companyName := RIGHT.name_company,
																									SELF.DBAName := IF(RIGHT.dba_flag = 1, RIGHT.name_dba_orig,''),
																									SELF.company_predir := RIGHT.bus_predir,
																									SELF.company_prim_range := RIGHT.bus_prim_range,
																									SELF.company_prim_name := RIGHT.bus_prim_name,
																									SELF.company_addr_suffix := RIGHT.bus_addr_suffix,
																									SELF.company_postdir := RIGHT.bus_postdir,
																									SELF.company_unit_desig := RIGHT.bus_unit_desig,
																									SELF.company_sec_range := RIGHT.bus_sec_range,
																									SELF.company_city := RIGHT.bus_v_city_name,
																									SELF.company_st := RIGHT.bus_state,
																									SELF.company_zip5 := RIGHT.bus_zip5,
																									SELF.company_county_fips := RIGHT.bus_county,
																									SELF.Licenses := IF(RIGHT.cln_license_nbr != '' OR RIGHT.std_license_desc != '' OR
                                                                      RIGHT.license_state != '' OR RIGHT.nmls_id != 0,
																																			DATASET([{RIGHT.cln_license_nbr,RIGHT.std_license_desc,RIGHT.std_status_desc,
																																				        RIGHT.license_state,RIGHT.curr_issue_dte,RIGHT.expire_dte,
																																				       (RIGHT.result_cd_1 = Midex_Services.Constants.RECORD_STATUS.LatestRecordUpdatingSource),
                                                                                RIGHT.business_type,IF(RIGHT.charter != '0',RIGHT.charter,''),
																																				        RIGHT.nmls_id,RIGHT.orig_issue_dte}],
                                                                                MIDEX_Services.Layouts.LicenseInfo_Layout),
                                                                      DATASET([], MIDEX_Services.Layouts.LicenseInfo_Layout)),         
																									SELF.ssn := MAP(RIGHT.tax_type_1 = 'S' => RIGHT.ssn_taxid_1,
                                                                  RIGHT.tax_type_2 = 'S' => RIGHT.ssn_taxid_2,
                                                                                            ''),
																									SELF.taxid := MAP(RIGHT.tax_type_1 = 'E' => RIGHT.ssn_taxid_1,
                                                                    RIGHT.tax_type_2 = 'E' => RIGHT.ssn_taxid_2,
                                                                                              ''),
                                                  SELF.did := (UNSIGNED6)RIGHT.did,
																									SELF.bdid := (UNSIGNED6)RIGHT.bdid,
																									// If phone1 is all zeroes or blank use contact phone
																									SELF.phone := IF(stringlib.stringfilterOut(RIGHT.phn_phone_1,'0') != '',RIGHT.phn_phone_1,RIGHT.phn_contact);
																									SELF.report_number := (STRING) RIGHT.mari_rid,
																									SELF.nmls_id := RIGHT.nmls_id,
																									SELF := RIGHT,
																									SELF := []),
																				LIMIT(MIDEX_Services.Constants.JOIN_LIMIT,SKIP));
                  
									// Multiple and older versions of the same license are occurring, so sort/dedup on license 
									// number and keep the most recent license.								
									
									// sort  by -last_upd_date around dedup/sort added here to bubble the most recent to top before returning results
									profs_recsRaw_dedup := SORT(DEDUP(SORT(prof_recsRaw,mari_rid,Licenses[1].lic_number,-last_upd_date),mari_rid,Licenses[1].lic_number), -last_upd_date);
									
									census_data.MAC_Fips2County_Keyed(profs_recsRaw_dedup,company_st,company_county_fips,company_county,prof_recs);
                                        
									// get nmls info if it exists
									prof_nmls_recs := MIDEX_Services.Functions.add_nmls_info(prof_recs);
									prof_recsHash := PROJECT(prof_nmls_recs,MIDEX_Services.alert_calcs.calcLicenseReptHashes(LEFT,alertVersion));
									
									RETURN(IF(alertVersion != Midex_Services.Constants.AlertVersion.None,prof_recsHash,prof_nmls_recs));
								END;
					 END;

					 
           EXPORT SEARCH_VIEW := MODULE
													
								EXPORT by_mari_num( DATASET (MIDEX_Services.Layouts.rec_profLicMari_payloadKeyField) in_ids,
                                    UNSIGNED1 alertVersion = Midex_Services.Constants.AlertVersion.None,
                                    STRING in_ssn_mask_type = '', STRING32 in_app_type = '') := FUNCTION
										
										prof_recsRaw := JOIN(in_ids,Prof_License_Mari.key_mari_payload,
                                          KEYED(LEFT.mari_rid = RIGHT.mari_rid) AND
                                          // Bug# 182946 - Filter out records which have been superceded
                                          RIGHT.result_cd_1 NOT IN [Midex_Services.Constants.RECORD_STATUS.SupercededMariRidUpdatingSource,
                                                                    Midex_Services.Constants.RECORD_STATUS.SupercededMariRidNonUpdatingSource],
										       
                                          TRANSFORM(MIDEX_Services.Layouts.license_srch_layout,
                                                    SELF.mari_rid := RIGHT.mari_rid,
                                                    SELF.nmls_id := RIGHT.nmls_id,
                                                    SELF.nmls_info := IF(RIGHT.nmls_id != 0,
                                                                         DATASET([{'',RIGHT.nmls_id}], MIDEX_Services.Layouts.rec_nmlsInfo),
                                                                         DATASET([], MIDEX_Services.Layouts.rec_nmlsInfo));
                                                    SELF.licensee_FirstName := RIGHT.fname,
                                                    SELF.licensee_MidName := RIGHT.mname,
                                                    SELF.licensee_LastName := RIGHT.lname,
                                                    SELF.licensee_companyName := RIGHT.name_company,
                                                    SELF.predir := RIGHT.bus_predir,
                                                    SELF.prim_range := RIGHT.bus_prim_range,
                                                    SELF.prim_name := RIGHT.bus_prim_name,
                                                    SELF.addr_suffix := RIGHT.bus_addr_suffix,
                                                    SELF.postdir := RIGHT.bus_postdir,
                                                    SELF.unit_desig := RIGHT.bus_unit_desig,
                                                    SELF.sec_range := RIGHT.bus_sec_range,
                                                    SELF.city := RIGHT.bus_v_city_name,
                                                    SELF.st := RIGHT.bus_state,
                                                    SELF.zip5 := RIGHT.bus_zip5,
                                                    SELF.fips_county := RIGHT.bus_county,
                                                    SELF.lic_number := RIGHT.cln_license_nbr,
                                                    SELF.lic_type := RIGHT.std_license_desc,
                                                    SELF.lic_state := RIGHT.license_state,
                                                    SELF.lic_status := RIGHT.std_status_desc,
                                                    SELF.lic_issue_date := RIGHT.orig_issue_dte,
                                                    SELF.lic_expir_date := RIGHT.expire_dte,
                                                    SELF.ssn := MAP(RIGHT.tax_type_1 = 'S' => RIGHT.ssn_taxid_1,
                                                                    RIGHT.tax_type_2 = 'S' => RIGHT.ssn_taxid_2,
                                                                                              ''),
																									  SELF.taxid := MAP(RIGHT.tax_type_1 = 'E' => RIGHT.ssn_taxid_1,
                                                                      RIGHT.tax_type_2 = 'E' => RIGHT.ssn_taxid_2,
                                                                                                ''),
                                                    SELF.dob := RIGHT.birth_dte,
                                                    SELF.did := (UNSIGNED6)RIGHT.did,
                                                    // If phone1 is all zeroes or blank use contact phone
                                                    SELF.phone := IF(stringlib.stringfilterOut(RIGHT.phn_phone_1,'0') != '',RIGHT.phn_phone_1,RIGHT.phn_contact);
                                                    SELF.data_source := RIGHT.std_source_desc,
                                                    SELF.isCurrent := (RIGHT.result_cd_1 = Midex_Services.Constants.RECORD_STATUS.LatestRecordUpdatingSource),
                                                    SELF := RIGHT,
                                                    SELF := []),
                                          LIMIT(iesp.Constants.MIDEX.MAX_COUNT_SEARCH_RESPONSE_RECORDS,SKIP));
                  
                  census_data.MAC_Fips2County_Keyed(prof_recsRaw,st,fips_county,county,prof_recs);
                                       
									prof_recsHash := PROJECT(prof_recs,MIDEX_Services.alert_calcs.calcLicenseSrchHashes(LEFT));
									
                  RETURN(IF(alertVersion != Midex_Services.Constants.AlertVersion.None,prof_recsHash,prof_recs));
								END;  // end funtion
        END; // Search view module
      END; // License module
 END; //  Raw_ProfessionalLicenses module
  
