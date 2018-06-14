IMPORT AutoKeyI, AutoStandardI, census_data, iesp, lib_stringlib, SANCTN_Mari, Suppress, ut, BIPV2, MIDEX_Services;

// ==============================================================================================================	
//  MARI MIDEX "NON-PUBLIC" DATA (SANCTN_Mari) related functions
//   Mortgage Industry Data Exchange(MIDEX) from Mortgage Asset Research Institute(MARI)
// ==============================================================================================================	

EXPORT Raw_Nonpublic := 
  MODULE
  
    //===========================================
    // Functions
    //===========================================
    EXPORT fn_get_nonPublicAutokeyData ():=
      FUNCTION
   
        tempmod_nonPublic := 
          MODULE(PROJECT(AutoStandardI.GlobalModule(),AutoKeyI.AutoKeyStandardFetchArgumentInterface,OPT))
            EXPORT STRING autokey_keyname_root := SANCTN_Mari.Constants.AK_QA_KEYNAME;
            EXPORT STRING typestr              := SANCTN_Mari.Constants.TYPE_STR;
            EXPORT SET OF STRING1 get_skip_set := SANCTN_Mari.Constants.SKIPSET;
            EXPORT BOOLEAN useAllLookups       := SANCTN_Mari.Constants.USE_ALL_LOOKUPS;
          END;

        ds_nonPublicAutokeyIds := AutoKeyI.AutoKeyStandardFetch(tempmod_nonPublic).ids;
        ds_nonPubAutokeyIdsSorted := DEDUP( SORT( ds_nonPublicAutokeyIds, id), id);            

        RETURN ds_nonPubAutokeyIdsSorted;
      END; // get_nonPublicAutokeyData
      
    // -----------[ Get MIDEX payload key fields by nonPublic SANTCN_Mari Keys ]-----------------------------------------

    EXPORT fn_get_nonPublicBdidData ( UNSIGNED6 in_bdid ):=
      FUNCTION
        ds_SANCTN_Mari_bdid_recs := CHOOSEN(SANCTN_Mari.Key_BDID( KEYED( BDID = in_bdid )  AND in_bdid != 0 ), MIDEX_Services.Constants.JOIN_LIMIT);
        
        MIDEX_Services.Macros.MAC_midexPayloadKeyField(ds_SANCTN_Mari_bdid_recs, ds_outDataSet, BATCH, INCIDENT_NUM, PARTY_NUM, MIDEX_PRT_NBR );
        
        RETURN ds_outDataSet;
      END; // get_nonPublicBdidData
    
    
    EXPORT fn_get_nonPublicDidData ( UNSIGNED6 in_did ):=
      FUNCTION
        ds_SANCTN_Mari_did_recs := CHOOSEN(SANCTN_Mari.Key_DID( KEYED( DID = in_did ) AND in_did != 0 ), MIDEX_Services.Constants.JOIN_LIMIT);
        
        MIDEX_Services.Macros.MAC_midexPayloadKeyField(ds_SANCTN_Mari_did_recs, ds_outDataSet, BATCH, INCIDENT_NUM, PARTY_NUM, MIDEX_PRT_NBR );

        RETURN ds_outDataSet;
      END; // get_nonPublicDidData
    
		EXPORT fn_get_nonPublicLinkIdData ( dataset(BIPV2.IDlayouts.l_xlink_ids) in_linkid, STRING1 FetchLevel ):=
      FUNCTION
        ds_SANCTN_Mari_linkid_recs 		:= CHOOSEN(SANCTN_Mari.Key_LinkIds_Party.kFetch(in_linkid, FetchLevel), MIDEX_Services.Constants.JOIN_LIMIT);
        
        MIDEX_Services.Macros.MAC_midexPayloadKeyField(ds_SANCTN_Mari_linkid_recs, ds_outDataSet, BATCH, INCIDENT_NUM, PARTY_NUM, MIDEX_PRT_NBR );
        
        RETURN ds_outDataSet;
      END; // get_nonPublicLinkIdData
			
    // The license keys are overloaded with NMLS data. The existing keys use the license number as either the 
    // License number or the NMLS ID.  The differentiation is in the license type.  
    EXPORT fn_get_nonPublicLicNbrData( STRING20 in_licNbr, STRING30 in_licState) :=
      FUNCTION
       
       upperCaseLicense  := TRIM(StringLib.StringToUpperCase(in_licNbr));
			 upperCaseLicState := TRIM(StringLib.StringToUpperCase(in_licState));
        
       ds_SANCTN_Mari_lic_recs := CHOOSEN(SANCTN_Mari.Key_License_NBR( KEYED( cln_license_number = upperCaseLicense AND
                                                                              (upperCaseLicState = '' OR license_state = upperCaseLicState) ) AND
                                                                        upperCaseLicense != ''), iesp.Constants.MIDEX.MAX_COUNT_SEARCH_LICENSES);
        MIDEX_Services.Macros.MAC_midexPayloadKeyField(ds_SANCTN_Mari_lic_recs, ds_outDataSet, BATCH, INCIDENT_NUM, PARTY_NUM, MIDEX_PRT_NBR );

        RETURN ds_outDataSet;
      END; // get_nonPublicLicData
           

    EXPORT fn_get_nonPublicNMLSId( STRING20 in_NMLSId) :=
      FUNCTION
        ds_SANCTN_Mari_nmlsId_recs := CHOOSEN(SANCTN_Mari.Key_NMLS_ID( KEYED( nmls_id = in_NMLSId )  AND
                                                                       in_NMLSId != ''), MIDEX_Services.Constants.JOIN_LIMIT);
        MIDEX_Services.Macros.MAC_midexPayloadKeyField(ds_SANCTN_Mari_nmlsId_recs, ds_outDataSet, BATCH, INCIDENT_NUM, PARTY_NUM, MIDEX_PRT_NBR );
        
        RETURN ds_outDataSet;
      END; // get_nonPublicLicData
           

    
    EXPORT fn_get_nonPublicSsn4Data ( STRING4 in_ssn4 ) :=
      FUNCTION
        ds_SANCTN_Mari_ssn4_recs := CHOOSEN(SANCTN_Mari.Key_SSN4( KEYED( SSN4 = in_ssn4 ) AND in_ssn4 != ''),MIDEX_Services.Constants.JOIN_LIMIT);
        
        MIDEX_Services.Macros.MAC_midexPayloadKeyField(ds_SANCTN_Mari_ssn4_recs, ds_outDataSet, BATCH, INCIDENT_NUM, PARTY_NUM, MIDEX_PRT_NBR );
        
        RETURN ds_outDataSet;
      END; // get_nonPublicSsn4Data

  
    EXPORT fn_get_nonPublicTinData ( STRING9 in_tin ) :=
      FUNCTION
        ds_SANCTN_Mari_tin_recs := CHOOSEN(SANCTN_Mari.Key_TIN( KEYED( TIN = in_tin ) AND in_tin != '' ),MIDEX_Services.Constants.JOIN_LIMIT);
        
        MIDEX_Services.Macros.MAC_midexPayloadKeyField(ds_SANCTN_Mari_tin_recs, ds_outDataSet, BATCH, INCIDENT_NUM, PARTY_NUM, MIDEX_PRT_NBR );
        
        RETURN ds_outDataSet;
      END; // get_nonPublicTinData
      
  
    EXPORT fn_get_nonPublicMariPayload ( DATASET( MIDEX_Services.Layouts.rec_midex_payloadKeyField ) ds_mari ) :=
      FUNCTION
        ds_mari_sorted := DEDUP( SORT( ds_mari, midex_rpt_nbr ), midex_rpt_nbr );
        ds_mari_recs :=
          JOIN( ds_mari_sorted,
                SANCTN_Mari.key_MIDEX_RPT_NBR,
                KEYED(LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr),
                TRANSFORM(RIGHT),
                LIMIT(MIDEX_Services.Constants.JOIN_LIMIT,SKIP));
       RETURN ds_mari_recs;
     END;


    //==================================================
    // MODULE: NonPublic License Search and report view 
    //==================================================
    EXPORT LICENSE := MODULE
    
      EXPORT REPORT_VIEW := MODULE
              
            EXPORT by_midex_rpt_num(DATASET (MIDEX_Services.layouts.rec_midex_payloadKeyField) in_ids,
                                    UNSIGNED1 alertVersion = Midex_Services.Constants.AlertVersion.None,
                                    STRING in_search_type = 'I', STRING in_ssn_mask_type = '',
                                    STRING32 in_app_type = '', SET OF STRING1 ds_nonPubAccess = []) := FUNCTION
              
                sanctNP_recsRaw := JOIN(in_ids,SANCTN_Mari.key_MIDEX_RPT_NBR,
                                        KEYED(LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr) AND
                                        RIGHT.DBCODE IN ds_nonPubAccess,
                                        TRANSFORM(MIDEX_Services.Layouts.LicenseReport_Layout,
                                                  SELF.data_source := Constants.DATASOURCE_NON_PUB,
                                                  SELF.last_upd_date := '',
                                                  SELF.TitleName := RIGHT.title,
                                                  SELF.FirstName := RIGHT.fname,
                                                  SELF.MiddleName := RIGHT.mname,
                                                  SELF.LastName := RIGHT.lname,
                                                  SELF.SuffixName := RIGHT.name_suffix,
                                                  SELF.companyName := RIGHT.cname,
                                                  SELF.ssn := RIGHT.ssn,
                                                  SELF.taxid := RIGHT.tin,
                                                  SELF.did := (UNSIGNED6)RIGHT.did,
                                                  SELF.bdid := (UNSIGNED6)RIGHT.bdid,
                                                  SELF.phone := RIGHT.phone;
                                                  SELF.report_number := RIGHT.midex_rpt_nbr,
                                                  SELF.city := RIGHT.v_city_name,
                                                  SELF := RIGHT,
                                                  SELF := []),
                                          KEEP(1),
                                          LIMIT(0));
              
              census_data.MAC_Fips2County_Keyed(sanctNP_recsRaw,st,fips_county,county,sanctNP_recs);
               
              // Get license info via midex rpt number									
              sanctNP_recs_wlicInfo := JOIN(sanctNP_recs,SANCTN_Mari.key_License_midex,
                                              KEYED(LEFT.report_number = RIGHT.midex_rpt_nbr),
                                              TRANSFORM(MIDEX_Services.Layouts.LicenseReport_Layout,
                                                        SELF.Licenses := IF(RIGHT.cln_license_number != '' OR 
                                                                          RIGHT.std_type_desc != '' OR 
                                                                          RIGHT.license_state != '',
                                                                          DATASET([{RIGHT.cln_license_number,RIGHT.std_type_desc,'',RIGHT.license_state,'','',TRUE}], MIDEX_Services.Layouts.LicenseInfo_Layout),
                                                                          DATASET([], MIDEX_Services.Layouts.LicenseInfo_Layout)),
                                                        SELF := LEFT),
                                              LEFT OUTER,
                                              LIMIT(iesp.Constants.MIDEX.MAX_COUNT_REPORT_LICENSES,SKIP));
              
              // Add nmls info
              //Setup match on individual or company based on the search (individual or company).
              //If the user performed a indivdual search use the nmls_id with the type of individual,
              //if it is a company use the nmls with a type of company.
              nmls_type := MIDEX_Services.Functions.set_nmlsLicenseType(in_search_type);
                               
              // Add the nmlsID to recordset if one exists.
              sanctNP_recs_nmlsID := JOIN (sanctNP_recs_wlicInfo,SANCTN_Mari.key_nmls_midex,
                                         KEYED(LEFT.report_number = RIGHT.midex_rpt_nbr) AND
                                         nmls_type = Stringlib.StringToUpperCase(RIGHT.license_type),
                                         TRANSFORM(MIDEX_Services.Layouts.LicenseReport_Layout,
                                                    SELF.nmls_id :=(INTEGER) RIGHT.nmls_id,
                                                    SELF := LEFT),
                                         LEFT OUTER,
                                         KEEP(1),
																				 LIMIT(0));
                                              
              sanctNP_nmls_recs := MIDEX_Services.Functions.add_nmls_info(sanctNP_recs_nmlsID);
              sanctNP_group := GROUP(SORT(DEDUP(sanctNP_nmls_recs,ALL),report_number),report_number);
              MIDEX_Services.Layouts.LicenseReport_Layout licenseRollup(MIDEX_Services.Layouts.LicenseReport_Layout l, DATASET(MIDEX_Services.Layouts.LicenseReport_Layout) allRows) := TRANSFORM
                  SELF.Licenses := NORMALIZE (allRows, LEFT.Licenses, TRANSFORM (RIGHT));
                  SELF := l;
              END;
              
              sanctNP_rolled := ROLLUP(sanctNP_group,GROUP,licenseRollup(LEFT,ROWS(LEFT)));
              sanctNP_recsHash := PROJECT(sanctNP_rolled,MIDEX_Services.alert_calcs.calcLicenseReptHashes(LEFT,alertVersion));
              RETURN(IF(alertVersion != Midex_Services.Constants.AlertVersion.None,sanctNP_recsHash,sanctNP_rolled));
            END;
      END;
       
      EXPORT SEARCH_VIEW := MODULE
                      
            EXPORT by_midex_rpt_num(DATASET (MIDEX_Services.layouts.rec_midex_payloadKeyField) in_ids,
                                    UNSIGNED1 alertVersion = Midex_Services.Constants.AlertVersion.None,
                                    STRING in_ssn_mask_type = '', STRING32 in_app_type = '',SET OF STRING1 ds_nonPubAccess = []) := FUNCTION
                
                sanctNP_recsRaw := JOIN(in_ids,SANCTN_Mari.key_MIDEX_RPT_NBR,
                                    KEYED(LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr) AND
                                    RIGHT.DBCODE IN ds_nonPubAccess,
                                    TRANSFORM(MIDEX_Services.Layouts.license_srch_layout,
                                              SELF.licensee_FirstName := RIGHT.fname,
                                              SELF.licensee_MidName := RIGHT.mname,
                                              SELF.licensee_LastName := RIGHT.lname,
                                              SELF.licensee_companyName := RIGHT.cname,
                                              SELF.taxid := RIGHT.tin,
                                              SELF.ssn := RIGHT.ssn,
                                              SELF.data_source := MIDEX_Services.Constants.DATASOURCE_NON_PUB,
                                              SELF.city := RIGHT.v_city_name,
                                              SELF := RIGHT,
                                              SELF := []),
                                      LIMIT(iesp.Constants.MIDEX.MAX_COUNT_SEARCH_RESPONSE_RECORDS,SKIP));

                census_data.MAC_Fips2County_Keyed(sanctNP_recsRaw,st,fips_county,county,sanctNP_recs);								
                
                // Get license info via midex rpt number									
                sanctNP_recs_wlicInfo := JOIN(sanctNP_recs,SANCTN_Mari.key_License_midex,
                                              KEYED(LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr) AND
                                              RIGHT.field_name = MIDEX_Services.Constants.LICENSECODE,
                                              TRANSFORM(MIDEX_Services.Layouts.license_srch_layout,
                                                        SELF.lic_number := RIGHT.cln_license_number,
                                                        SELF.lic_type := RIGHT.std_type_desc,
                                                        SELF.lic_state := RIGHT.license_state,
                                                        SELF.isCurrent := TRUE, //non public sanctions data is daily full file replace
                                                        SELF := LEFT,
                                                        SELF := []),
                                              LEFT OUTER,
                                              LIMIT(iesp.Constants.MIDEX.MAX_COUNT_SEARCH_RESPONSE_RECORDS,SKIP));
                sanctNP_recs_wlicInfo_Dedup := DEDUP(sanctNP_recs_wlicInfo,ALL);
                
                // Attach nmls info
                sanctNP_recs_wNmlsID := JOIN(sanctNP_recs_wlicInfo_Dedup,SANCTN_Mari.key_nmls_midex,
                                              KEYED(LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr),
                                              TRANSFORM(MIDEX_Services.Layouts.license_srch_layout,
                                                        SELF.nmls_info := ROW ({RIGHT.license_type,RIGHT.nmls_id}, MIDEX_Services.Layouts.rec_nmlsInfo),
                                                        SELF := LEFT,
                                                        SELF := []),
                                              LEFT OUTER,
                                              LIMIT(iesp.Constants.MIDEX.MAX_COUNT_SEARCH_NMLS,SKIP));
                                              
                sanctNP_recs_wNmlsID_group := GROUP(SORT(sanctNP_recs_wNmlsID,midex_rpt_nbr),midex_rpt_nbr);
                  
                MIDEX_Services.Layouts.license_srch_layout Roll_NMLSInfo(MIDEX_Services. Layouts.license_srch_layout l, DATASET(MIDEX_Services.Layouts.license_srch_layout) allRows) := TRANSFORM
                      SELF.nmls_info := allRows.nmls_info;
                      SELF := l;
                END;
                
                sanctNP_recs_wNmlsID_rolled := ROLLUP(sanctNP_recs_wNmlsID_group,GROUP,Roll_NMLSInfo(LEFT,ROWS(LEFT)));
                
                sanctNP_recsHash := PROJECT(sanctNP_recs_wNmlsID_rolled,MIDEX_Services.alert_calcs.calcLicenseSrchHashes(LEFT));

                RETURN(IF(alertVersion != Midex_Services.Constants.AlertVersion.None,sanctNP_recsHash,sanctNP_recs_wNmlsID_rolled));
            END;
      END; // Search view module
    END; // License module

    //===============================================================
    // MODULE: NonPublic Midex Comprehensive Search and report views 
    //===============================================================
    // I was asked to add comments describing what each join included as the datasets are built. Comments
    // for each join and what the new dataset will include are preceeding each join.
    EXPORT MIDEX := MODULE
      EXPORT REPORT_VIEW := MODULE
                      
        EXPORT fn_nonPub_by_midexReportNumbers (DATASET( MIDEX_Services.Layouts.rec_midex_payloadKeyField ) ds_nonPubMidexReportNumbers, SET OF STRING1 set_nonPubAccess = [], BOOLEAN alert = FALSE, STRING1 in_searchType, STRING ssnMask, STRING dobMask, STRING8 StartLoadDate = '') := 
          FUNCTION                                        
            //  An incident can be associated with multiple parties. These parties are contained in a
            // separate key file. For the child dataset, the parties key is joined to the midex report
            // number(s) coming in. Since only one of the associated people will have the same midex
            // report number, we need to keep the report numbers from the parties file and use those
            // numbers to glean the additional information for each party. 
            
            //--- Additional Parties Information ------------------------------------------------------------------------------
            // join with the party key to get all parties associated with the incident that are not the subject
            // Per Rodney, for nonpublic data only, the subject for the report output is always party = zero, 
            //             whereas the subject for the Freddie Mac report is the subject that was searched on.  
            //             The subject midex report number NP_subject_rpt_nbr & NP_subjectParty_num are assigned 
            //             in the two macros: MAC_midexPayloadKeyField & MAC_getIncidentNumFromMidexReportNum based
            //             upon the data type/DBCODE.
            //             
            // When joining, removing the subject from the party dataset, so that the party records don't 
            // contain a record that duplicates the same information as the subject for the report.
            
            // 03/2015 -- QuickWins #1 -- user now allowed to request records for a period
            //            of years (i.e.: 1, 5, 7, 10 and all) A date will be passed in so
            //            that monitoring can be set up and the date won't roll and trigger
            //            a false alert when a record becomes older than the year window.
            ds_nonPubMidexReportNumbersFiltered := 
              JOIN( ds_nonPubMidexReportNumbers,
                    SANCTN_Mari.key_Midex_NP_incident,
                    KEYED(LEFT.incident_num = RIGHT.incident_num) AND
                    LEFT.batch = RIGHT.batch AND
                    RIGHT.DBCODE IN set_nonPubAccess AND
                    RIGHT.batch_date >= StartLoadDate,
                    TRANSFORM(LEFT), 
                    LIMIT(MIDEX_Services.Constants.JOIN_LIMIT),
                    KEEP(1));
              
            ds_incidentPartyRecsRaw := 
              JOIN( ds_nonPubMidexReportNumbersFiltered,
                    SANCTN_Mari.key_Midex_NP_party,
                    KEYED(LEFT.batch = RIGHT.batch AND
                          LEFT.incident_num = RIGHT.incident_num ) AND
                    RIGHT.DBCODE IN set_nonPubAccess AND
                    LEFT.NP_subjectParty_num != RIGHT.party_num,
                    TRANSFORM( MIDEX_Services.Layouts.compReport_PartyTempLayout,
                               ssnMasked                := Suppress.ssn_Mask( RIGHT.ssn, ssnMask );
                               SELF.batchNumber         := RIGHT.batch,
                               SELF.incidentNumber      := RIGHT.incident_num,
                               SELF.partyNumber         := RIGHT.party_num, 
                               SELF.dbcode              := RIGHT.dbcode,                         
                               SELF.dataSource          :=  IF( RIGHT.DBCODE = MIDEX_Services.Constants.DATASOURCE_CODE_NONPUB,  
                                                                MIDEX_Services.Constants.DATASOURCE_NON_PUB,
                                                                MIDEX_Services.Constants.DATASOURCE_FREDDIE ),
                               SELF.tin                 := RIGHT.tin,
                               SELF.additionalInfo      := RIGHT.additional_info,
                               SELF.Name                := iesp.ECL2ESP.setName( RIGHT.name_first, RIGHT.name_middle, RIGHT.name_last, RIGHT.suffix, ''),
                               SELF.ssn                 := IF( (UNSIGNED) ssnMasked = 0,
                                                               '',
                                                               ssnMasked
                                                              ),
                               SELF.dob                 := MIDEX_services.Functions.fn_dobMask ( RIGHT.dob, dobMask),
                               SELF.address             := iesp.ECL2ESP.setAddress ('', '', '', '', '', '', '', RIGHT.city, RIGHT.state, 
                                                                                     RIGHT.zip, '', '', '', RIGHT.address, '', ''),
                               SELF.partyEmployer       := RIGHT.party_employer,
                               SELF.partyPosition       := RIGHT.party_position,
                               SELF.partyFirm           := RIGHT.party_firm,
                               SELF.UniqueId            := (STRING12)RIGHT.did,
                               SELF.BusinessId          := (STRING12)RIGHT.bdid,
                               SELF.midex_rpt_nbr       := TRIM(RIGHT.batch, LEFT, RIGHT) + '-' + TRIM(RIGHT.incident_num, LEFT, RIGHT) + '-' + TRIM(RIGHT.party_num, LEFT, RIGHT),
                               SELF.NP_subject_rpt_nbr  := LEFT.NP_subject_rpt_nbr,
                               SELF.NP_subjectParty_num := LEFT.NP_subjectParty_num,
                               SELF                     := [],
                              ),  
                    INNER,
                    LIMIT(MIDEX_Services.Constants.JOIN_LIMIT,SKIP));

              ds_incidentPartyRecs := DEDUP( SORT( ds_incidentPartyRecsRaw, midex_rpt_nbr ), midex_rpt_nbr );
              
							// Collect AKAs and DBAs, overloaded in the same key
              ds_akasDbasAll := 
                JOIN( ds_incidentPartyRecs,
                      SANCTN_Mari.key_party_aka_dba,
                      KEYED( LEFT.batchNumber = RIGHT.batch AND
                             LEFT.incidentNumber = RIGHT.incident_num AND
                             LEFT.partyNumber = RIGHT.party_num ) AND
                      LEFT.dbcode = RIGHT.dbcode,
                      TRANSFORM( MIDEX_Services.Layouts.compReport_AkaDbaLayout,
                                 SELF.AKANames := IF( RIGHT.name_type = MIDEX_Services.Constants.AKA_NAME_TYPE,
                                                      DATASET( [{RIGHT.aka_dba_text,'','','','',''}],iesp.Share.t_name ),
                                                      DATASET( [],iesp.Share.t_name )
                                                    ),
                                 SELF.DBANames := IF( RIGHT.name_type = MIDEX_Services.Constants.DBA_NAME_TYPE,
                                                      DATASET( [{RIGHT.aka_dba_text}],iesp.midexcompreport.t_MIDEXDBAName ),
                                                      DATASET( [],iesp.midexcompreport.t_MIDEXDBAName )
                                                    ),
                                 SELF.DBCODE   := LEFT.DBCODE,
                                 SELF          := RIGHT,  // name_type
                                 SELF          := LEFT,   // batch, incident & party numbers, midex rpt nbr, subject rpt & party numbers
                               ),
                      LEFT OUTER,
                      LIMIT(MIDEX_Services.Constants.JOIN_LIMIT_FOR_CHOOSEN, SKIP));
              
              ds_akasDbasAllSorted := SORT( ds_akasDbasAll, midex_rpt_nbr, dbcode, name_type ); 

              // rollup akas and dbas into two records for each midex report number, keeping only the max for each dataset
              ds_akasDbasRolled := 
                ROLLUP( ds_akasDbasAllSorted,
                        LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr AND
                        LEFT.dbcode = RIGHT.dbcode,
												TRANSFORM(  MIDEX_Services.Layouts.compReport_AkaDbaLayout,
																	 SELF.AKANames := LEFT.AKANames + RIGHT.AKANames,
																	 SELF.DBANames := LEFT.DBANames + RIGHT.DBANames,
                                   SELF          := LEFT,
																	 SELF          := [],
																 ));


            // The professions of the additional party entities are in an overloaded key and will need
            // to be rolled up into a child datset. FMAC0003-1225409-4        
            ds_incidentPartyRecsPlusPartyProfessions := 
              JOIN( ds_incidentPartyRecs, 
                    SANCTN_Mari.key_Midex_NP_codes,
                    KEYED(LEFT.incidentNumber = RIGHT.incident_num) AND
                    LEFT.batchNumber = RIGHT.batch AND
                    LEFT.partyNumber = RIGHT.number AND
                    LEFT.DBCODE = RIGHT.DBCODE AND
                    RIGHT.field_name = Midex_Services.Constants.PROFESSIONCODE,
                    TRANSFORM( MIDEX_Services.Layouts.compReport_PartyTempLayout,
                               SELF.Professions := IF( RIGHT.field_name = Midex_Services.Constants.PROFESSIONCODE,
                                                       DATASET([{RIGHT.other_desc}], iesp.share.t_StringArrayItem),  /*other_desc is declared as string500 */
                                                       DATASET([], iesp.share.t_StringArrayItem)
                                                     ),
                               SELF := LEFT,
                              ), 
                    LEFT OUTER, 
                    LIMIT(MIDEX_Services.Constants.JOIN_LIMIT,SKIP));
            
            ds_incidentPartyRecsPlusProfessionsSorted := SORT(ds_incidentPartyRecsPlusPartyProfessions, batchNumber, incidentNumber, partyNumber);
            
            ds_incidentPartyRecsPlusPartyProfessionsRolled := 
              ROLLUP( ds_incidentPartyRecsPlusProfessionsSorted, 
                      LEFT.batchNumber = RIGHT.batchNumber AND
                      LEFT.incidentNumber = RIGHT.incidentNumber AND
                      LEFT.partyNumber = RIGHT.partyNumber AND
                      LEFT.DBCODE = RIGHT.DBCODE,
                      TRANSFORM( MIDEX_Services.Layouts.compReport_PartyTempLayout,
                                 SELF.Professions := LEFT.Professions + RIGHT.Professions,
                                 SELF             := LEFT,
                               ) ); 
                               
            // The following join adds the licenses for each of the associated party to the 
            // party payload and licenses. The licenses will be rolled and then joined back
            // into the main Party child dataset.
            ds_partiesWithLicenses :=
              JOIN( ds_incidentPartyRecsPlusPartyProfessionsRolled,
                    SANCTN_Mari.key_license_midex,
                    KEYED(LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr),
                    TRANSFORM(MIDEX_Services.Layouts.compReport_nonpublicCodesRawLayout,
                              SELF.batch               := LEFT.batchnumber,
                              SELF.incident_num        := LEFT.incidentnumber,
                              SELF.party_num           := LEFT.partynumber,
                              SELF.other_desc          := [],
                              SELF.Licenses            := DATASET([{RIGHT.STD_TYPE_DESC, RIGHT.CLN_LICENSE_NUMBER,  
                                                                     '', RIGHT.LICENSE_STATE, ROW([],iesp.share.t_Date),TRUE}], iesp.midex_share.t_MIDEXLicenseInfo),
                              SELF.DBCODE              := LEFT.DBCODE,
                              SELF                     := RIGHT,
                              SELF                     := LEFT,
                            ), 
                    LEFT OUTER, 
                    LIMIT(MIDEX_Services.Constants.JOIN_LIMIT,SKIP));
                          
            ds_partiesWithLicensesSorted := SORT(ds_partiesWithLicenses, batch, incident_num, party_num);
            
            ds_partyLicensesRolled := 
              ROLLUP( ds_partiesWithLicensesSorted, 
                      LEFT.batch = RIGHT.batch AND
                      LEFT.incident_num = RIGHT.incident_num AND
                      LEFT.party_num = RIGHT.party_num,
                      TRANSFORM(MIDEX_Services.Layouts.compReport_nonpublicCodesRawLayout,
                                licenseCount    := COUNT( LEFT.Licenses );
                                SELF.Licenses   := IF( licenseCount < iesp.Constants.MIDEX.MAX_COUNT_REPORT_LICENSES, 
                                                       LEFT.Licenses + RIGHT.Licenses,
                                                       LEFT.Licenses
                                                     ),
                                SELF            := LEFT,
                               )); 
            
            // This join adds the NMLS ID and type for each of the party to the dataset that has
            // the parties payload, professions and licenses.  
            
            // There are three types of NMLS IDs. Product wants the corresponding 
            // nmls ID displayed. Individual is straight forward. 
            // For company searches, if there is a company nmls id in the key file,
            // then product wants that ID used.  However if there is no company id and 
            // there is a branch nmls id in the key file, product wants that displayed.
            // The join takes both the company and branch NMLS ID if it's available.  
            // The subsequent sort dedup, pulls the company NMLS ID to the top so that 
            // the dedup will keep the company if it's available, if it's not, then the 
            // branch NMLS ID will be kept.
            ds_partiesWithNmls := 
              JOIN( ds_incidentPartyRecsPlusPartyProfessionsRolled,
                    SANCTN_Mari.key_nmls_midex,
                    KEYED(LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr) AND
                    ( (in_searchType = MIDEX_Services.Constants.INDIV_SEARCH AND 
                       Stringlib.StringToUpperCase(RIGHT.license_type) = MIDEX_Services.Constants.NMLS_INDIV ) OR
                      
                      (in_searchType = MIDEX_Services.Constants.COMP_SEARCH AND  
                       Stringlib.StringToUpperCase(RIGHT.license_type) = MIDEX_Services.Constants.NMLS_COMP ) OR
                      
                      (in_searchType = MIDEX_Services.Constants.COMP_SEARCH AND  
                       Stringlib.StringToUpperCase(RIGHT.license_type) = MIDEX_Services.Constants.NMLS_BR )
                    ),
                    TRANSFORM( MIDEX_Services.Layouts.compReport_PartyTempLayout,
                               SELF.nmlsType    := RIGHT.license_type,
                               SELF.nmlsId      := RIGHT.nmls_id,
                               SELF.professions := CHOOSEN( DEDUP( SORT( LEFT.professions, Value), Value), iesp.constants.MIDEX.MAX_COUNT_REPORT_PROFESSIONS),
                               SELF             := LEFT,
                             ),
                    LEFT OUTER,
                    LIMIT(iesp.Constants.MIDEX.MAX_COUNT_REPORT_NMLS,SKIP));
            
            // When the join to the nmls key is for a company, there could be two nmls types: company 
            // or branch. If both are found, Bonnie Taepakdee would like the company nmls ID to always be 
            // chosen before the branch. If there is no company nmls id, then the branch one can/should be 
            // displayed. When the sort is done, if it's an individual search, there will always
            // only be one nmls id if it's available so having the reverse sort on the type does 
            // not impact the nmls id chosen. However, when the company nmls id is requested, sorting 
            // normally would put the branch first. We want the company nmls id first, so sorting 
            // needs to by reverse.
            // the dedup, removes the branch sort when it's the second record and keeps the company nmls id.
            ds_incidentPartyWithNmlsDedup := DEDUP(SORT(ds_partiesWithNmls, midex_rpt_nbr, -nmlsType), midex_rpt_nbr);
            ds_partyMidexReportNumbers    := SORT( ds_incidentPartyRecsPlusPartyProfessionsRolled, batchNumber, incidentNumber, partyNumber);
            
            // The following join gleans the other identifying references text for each of the parties 
            // in the parties child dataset. The text will all be subsequently rolled up and 
            // joined back to the main party (child) dataset.
            ds_partyOtherIdenRef := 
              JOIN( ds_partyMidexReportNumbers,
                    SANCTN_Mari.key_party_text,
                    KEYED( LEFT.batchNumber = RIGHT.batch AND
                           LEFT.incidentNumber = RIGHT.incident_num AND
                           LEFT.partyNumber = RIGHT.party_num ) AND
                    LEFT.DBCODE = RIGHT.DBCODE,
                    TRANSFORM( MIDEX_Services.Layouts.compReport_nonpublicTextRawLayout,
                               SELF.orderNumber          := RIGHT.seq,
                               SELF.Text                 := MIDEX_Services.Functions.fn_setStringArray(RIGHT.field_txt),
                               SELF.DBCODE               := LEFT.DBCODE,
                               SELF                      := RIGHT,
                               SELF                      := LEFT,
                               SELF                      := [],
                             ),
                    LEFT OUTER,
                    LIMIT(MIDEX_Services.Constants.JOIN_LIMIT,SKIP)); 
            
            ds_partyOtherIdenRefSorted := SORT(ds_partyOtherIdenRef, batch, incident_num, party_num, DBCODE, (UNSIGNED3)orderNumber);
            
            ds_partyOtherIdenRefRolled := 
              ROLLUP( ds_partyOtherIdenRefSorted, 
                      LEFT.batch        = RIGHT.batch        AND
                      LEFT.incident_num = RIGHT.incident_num AND
                      LEFT.party_num    = RIGHT.party_num    AND
                      LEFT.DBCODE       = RIGHT.DBCODE,
                      TRANSFORM( MIDEX_Services.Layouts.compReport_nonpublicTextRawLayout,
                                 SELF.Text := IF( (UNSIGNED3)RIGHT.orderNumber <= iesp.Constants.MIDEX.MAX_COUNT_REPORT_TEXT,
                                                   LEFT.Text + RIGHT.Text,
                                                   LEFT.Text
                                                ), 
                                 SELF      := LEFT,
                               ) ); 
           
            // This join adds the other identifying references text dataset to the parties child 
            // dataset. The parties child dataset now has: the party payload, professions, licenses
            // nmls information and other identifying references. 
           ds_incPartyWithProfsAndOtherIdenRefs :=
              JOIN( ds_incidentPartyWithNmlsDedup,
                    ds_partyOtherIdenRefRolled,
                    LEFT.batchNumber    = RIGHT.batch AND
                    LEFT.incidentNumber = RIGHT.incident_num AND
                    LEFT.partyNumber    = RIGHT.party_num AND
                    LEFT.dbcode         = RIGHT.DBCODE,
                    TRANSFORM( MIDEX_Services.Layouts.compReport_iespPartyFlatPlusJoinFields,
                               SELF.Licenses                   := [],  
                               SELF.Professions                := CHOOSEN( DEDUP( SORT( LEFT.Professions, value), value), iesp.Constants.MIDEX.MAX_COUNT_REPORT_PROFESSIONS), 
                               SELF.NMLSInfo                   := ROW({LEFT.nmlsId, LEFT.nmlsType}, iesp.midex_share.t_NMLSInfo),
                               SELF.otherIdentifyingReferences := RIGHT.Text,
                               SELF.batch                      := LEFT.batchNumber,
                               SELF.incident_num               := LEFT.incidentNumber,
                               SELF.party_num                  := LEFT.partyNumber,
                               SELF                            := LEFT,
                             ),
                    LEFT OUTER,
                    KEEP(1),
                    LIMIT(MIDEX_Services.Constants.JOIN_LIMIT));

              ds_partiesWithAkaDba :=
                JOIN( ds_incPartyWithProfsAndOtherIdenRefs,
                      ds_akasDbasRolled,
                      LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr AND
                      LEFT.DBCODE = RIGHT.DBCODE,
                      TRANSFORM( MIDEX_Services.Layouts.compReport_iespPartyFlatPlusJoinFields,
															   SELF.AKANames := CHOOSEN( DEDUP( SORT( RIGHT.AKANames, FULL ), FULL), iesp.Constants.MIDEX.MAX_COUNT_REPORT_AKA_DBA),
																 SELF.DBANames := CHOOSEN( DEDUP( SORT( RIGHT.DBANames, name ), name),  iesp.Constants.MIDEX.MAX_COUNT_REPORT_AKA_DBA),
                                 SELF          := LEFT
                               ),
                      LEFT OUTER,
                      KEEP(1), 
                      LIMIT(MIDEX_Services.Constants.JOIN_LIMIT));          

           // finally join the license data to the main party dataset
           ds_incPartyRecs :=
              JOIN( ds_partiesWithAkaDba,
                    ds_partyLicensesRolled,
                    LEFT.batch        = RIGHT.batch AND
                    LEFT.incident_num = RIGHT.incident_num AND
                    LEFT.party_num    = RIGHT.party_num AND
                    LEFT.dbcode       = RIGHT.DBCODE,
                    TRANSFORM( MIDEX_Services.Layouts.compReport_iespPartyFlatPlusJoinFields,
                               SELF.Licenses                   := RIGHT.Licenses,  
                               SELF                            := LEFT,
                             ),
                    LEFT OUTER,
                    KEEP(1),
                    LIMIT(MIDEX_Services.Constants.JOIN_LIMIT));         
         
         // group the party dataset, then roll up all records by batch and incident number which 
         // will be used to join this group of associated individuals to the incident
         ds_partiesGrouped :=
           GROUP( SORT( ds_incPartyRecs, batch, incident_num, DBCODE ), batch, incident_num, DBCODE);
         
         MIDEX_Services.Layouts.compReport_iespPartyPlusJoinFields xfm_party( MIDEX_Services.Layouts.compReport_iespPartyFlatPlusJoinFields le,  DATASET(MIDEX_Services.Layouts.compReport_iespPartyFlatPlusJoinFields) allRows) :=
           TRANSFORM
             SELF.partyRecs := PROJECT(allRows, iesp.midexcompreport.t_MIDEXCompParty);
             SELF           := le; 
           END;
           
         ds_partiesRolled :=
           ROLLUP( ds_partiesGrouped, GROUP, xfm_party( LEFT, ROWS(LEFT)) );
         
         ds_partiesRolledSorted := SORT(ds_partiesRolled, batch, incident_num);
              
                                                                                          
        //--- End Party information -------------------------------------------------------------------------
        
// -- Start Subject/Incident information ------------------------------------------------------------
          // In the next sections, the child datasets are gathered. After each of the sections 
          // are gathered and rolled into their own child dataset, the building process for the 
          // final layout begins.
          // Per Rodney -- for nonpublic only, the subject is filled with part_num = 0 data
          //               Freddie Mac records are populate the subject with the searched on party
         
          // deduping by subject report numbers to eliminate getting multiple records for the same incident/subject
          // due to multiple parties associated with the incident
          ds_nonPublicSubjectReportNumbers := DEDUP( SORT( ds_nonPubMidexReportNumbersFiltered, np_subject_rpt_nbr ), np_subject_rpt_nbr );
          
          // There are three types of NMLS IDs. See explanation above for more details.
          ds_subjectNmls := 
            JOIN( ds_nonPublicSubjectReportNumbers,
                  SANCTN_Mari.key_nmls_midex,
                  KEYED( LEFT.NP_subject_rpt_nbr = RIGHT.midex_rpt_nbr ) AND
                  ( (in_searchType = MIDEX_Services.Constants.INDIV_SEARCH AND 
                     Stringlib.StringToUpperCase(RIGHT.license_type) = MIDEX_Services.Constants.NMLS_INDIV ) OR
                    
                    (in_searchType = MIDEX_Services.Constants.COMP_SEARCH AND  
                     Stringlib.StringToUpperCase(RIGHT.license_type) = MIDEX_Services.Constants.NMLS_COMP ) OR
                    
                    (in_searchType = MIDEX_Services.Constants.COMP_SEARCH AND  
                     Stringlib.StringToUpperCase(RIGHT.license_type) = MIDEX_Services.Constants.NMLS_BR )
                  ),
                  TRANSFORM( MIDEX_Services.Layouts.compReport_PartyTempLayout,
                             SELF.nmlsType       := RIGHT.license_type,
                             SELF.nmlsId         := RIGHT.nmls_id,
                             SELF.batchnumber    := LEFT.batch,
                             SELF.incidentnumber := LEFT.incident_num,
                             SELF.partynumber    := LEFT.party_num,
                             SELF                := LEFT,  // dbcode
                             SELF                := [],
                           ),
                  LEFT OUTER,
                  LIMIT(iesp.Constants.MIDEX.MAX_COUNT_REPORT_NMLS,SKIP));
          
          ds_subjectNmlsDedup := DEDUP( SORT( ds_subjectNmls, midex_rpt_nbr, -nmlsType ), midex_rpt_nbr );

          // Get Other Identifying References for the midex report number subject and 
          // rollup the results
          ds_subjectOtherIdenRefRaw := 
            JOIN( ds_nonPublicSubjectReportNumbers,
                  SANCTN_Mari.key_party_text,
                  KEYED( LEFT.batch        = RIGHT.batch AND
                         LEFT.incident_num = RIGHT.incident_num ) AND
                  RIGHT.DBCODE IN set_nonPubAccess AND
                  IF( RIGHT.DBCODE = MIDEX_Services.Constants.DATASOURCE_CODE_NONPUB,
                      (UNSIGNED1)RIGHT.party_num = 0,
                      LEFT.party_num = RIGHT.party_num
                    ),
                  TRANSFORM( MIDEX_Services.Layouts.compReport_nonpublicTextRawLayout,
                             SELF.orderNumber  := RIGHT.seq,
                             SELF.Text         := MIDEX_Services.Functions.fn_setStringArray(RIGHT.field_txt),
                             SELF.DBCODE       := LEFT.DBCODE,
                             SELF              := RIGHT,
                             SELF              := LEFT,
                             SELF              := []
                           ),
                  INNER,
                  LIMIT(MIDEX_Services.Constants.JOIN_LIMIT_FOR_CHOOSEN,SKIP)); 
            
            ds_subjectOtherIdenRefSorted := SORT(ds_subjectOtherIdenRefRaw, batch, incident_num, party_num, DBCODE, (UNSIGNED3)orderNumber);
            
            ds_subjectOtherIdenRefRolled := 
              ROLLUP( ds_subjectOtherIdenRefSorted, 
                      LEFT.batch        = RIGHT.batch        AND
                      LEFT.incident_num = RIGHT.incident_num AND
                      LEFT.party_num    = RIGHT.party_num    AND
                      LEFT.DBCODE       = RIGHT.DBCODE,
                      TRANSFORM( MIDEX_Services.Layouts.compReport_nonpublicTextRawLayout,
                                 SELF.Text := LEFT.Text + RIGHT.Text, 
                                 SELF      := LEFT
                               ) ); 
            
            // get nonpublic incident and response text, as well as Freddie Mac incident text (other info)
            // This key is overloaded. The key also has text that needs to be concatenated based on the
            // type of text it is.
            ds_textKeyRaw := 
              JOIN( ds_nonPublicSubjectReportNumbers,
                    SANCTN_Mari.key_Midex_NP_text,
                    KEYED(LEFT.incident_num = RIGHT.incident_num) AND
                    LEFT.batch = RIGHT.batch AND
                    RIGHT.DBCODE IN set_nonPubAccess,
                    TRANSFORM( MIDEX_Services.Layouts.compReport_nonpublicTextRawLayout,
                               SELF.orderNumber  := RIGHT.seq,
                               SELF.Text         := MIDEX_Services.Functions.fn_setStringArray(RIGHT.field_txt),
                               SELF.DBCODE       := LEFT.DBCODE,
                               SELF              := RIGHT,
                               SELF              := LEFT,
                               SELF              := []
                             ),
                    INNER,
                    LIMIT(MIDEX_Services.Constants.JOIN_LIMIT_FOR_CHOOSEN,SKIP));
                   
            ds_textKeySorted := CHOOSEN( SORT( ds_textKeyRaw, batch, incident_num, DBCODE, field_name, (UNSIGNED3)orderNumber ), iesp.Constants.MIDEX.MAX_COUNT_REPORT_TEXT);
               
            ds_textKeyRolled :=
              ROLLUP( ds_textKeySorted, 
                      LEFT.batch = RIGHT.batch AND
                      LEFT.incident_num = RIGHT.incident_num AND
                      LEFT.DBCODE = RIGHT.DBCODE AND
                      LEFT.field_name = RIGHT.field_name,
                      TRANSFORM( MIDEX_Services.Layouts.compReport_nonpublicTextRawLayout,
                                 SELF.Text := IF( (UNSIGNED3)RIGHT.orderNumber <=  iesp.Constants.MIDEX.MAX_COUNT_REPORT_TEXT, 
                                                  LEFT.Text + RIGHT.Text,
                                                  LEFT.Text
                                                 ),
                                 SELF      := LEFT 
                                ) );
                                
            // grab the license other description and verification info and roll them up
            ds_codesKeyRaw := 
              JOIN( ds_nonPublicSubjectReportNumbers,
                    SANCTN_Mari.key_Midex_NP_codes,
                    KEYED(LEFT.incident_num = RIGHT.incident_num ) AND
                    LEFT.batch = RIGHT.batch AND
                    LEFT.NP_subjectParty_num = RIGHT.NUMBER AND
                    RIGHT.DBCODE IN set_nonPubAccess AND
                    RIGHT.field_name != Midex_Services.Constants.LICENSECODE,
                    TRANSFORM( MIDEX_Services.Layouts.compReport_nonpublicCodesRawLayout,
                               SELF.other_desc   := MIDEX_Services.Functions.fn_setStringArray(RIGHT.other_desc),
                               SELF.Licenses     := [],
                               SELF.party_num    := RIGHT.number,
                               SELF.verification := IF( RIGHT.field_name = Midex_Services.Constants.INTERNALCODE AND RIGHT.code_type = Midex_Services.Constants.VERIFICATION,
                                                        RIGHT.other_desc,
                                                        ''
                                                      ),
                               SELF.DBCODE       := LEFT.DBCODE,
                               SELF              := RIGHT,
                               SELF              := LEFT,
                              ), 
                    INNER, 
                    LIMIT(MIDEX_Services.Constants.JOIN_LIMIT,SKIP));
            
            ds_codesKeyRawSorted := SORT( ds_codesKeyRaw, batch, incident_num, party_num, field_name, code_type);
            
            // these are the professions of the name on the midex report 
            ds_professionsRolled :=                      
              ROLLUP( ds_codesKeyRawSorted(field_name = Midex_Services.Constants.PROFESSIONCODE), 
                      LEFT.batch = RIGHT.batch AND
                      LEFT.incident_num = RIGHT.incident_num AND
                      LEFT.party_num = RIGHT.party_num,
                      TRANSFORM(MIDEX_Services.Layouts.compReport_nonpublicCodesRawLayout,
                                professionCount := COUNT( LEFT.other_desc );
                                SELF.other_desc := IF( professionCount < iesp.Constants.MIDEX.MAX_COUNT_REPORT_PROFESSIONS,
                                                       LEFT.other_desc + RIGHT.other_desc,
                                                       LEFT.other_desc
                                                     ),
                                SELF := LEFT,
                               )); 

            // verification here is a variable length string, so there is no need to worry about the length
            ds_verificationRolled := 
              ROLLUP( ds_codesKeyRawSorted(field_name = Midex_Services.Constants.INTERNALCODE AND code_type = Midex_Services.Constants.VERIFICATION), 
                      LEFT.batch = RIGHT.batch AND
                      LEFT.incident_num = RIGHT.incident_num AND
                      LEFT.party_num = RIGHT.party_num,
                      TRANSFORM(MIDEX_Services.Layouts.compReport_nonpublicCodesRawLayout,
                                SELF.verification := MAP( LEFT.verification = '' AND
                                                          TRIM(LEFT.OTHER_DESC[1].value, LEFT, RIGHT)   = '' AND
                                                          TRIM(RIGHT.OTHER_DESC[1].value, LEFT, RIGHT) != ''        => TRIM(RIGHT.OTHER_DESC[1].value, LEFT, RIGHT),
                                
                                                          LEFT.verification = '' AND
                                                          TRIM(LEFT.OTHER_DESC[1].value, LEFT, RIGHT)  != '' AND
                                                          TRIM(RIGHT.OTHER_DESC[1].value, LEFT, RIGHT)  = ''        => TRIM(LEFT.OTHER_DESC[1].value, LEFT, RIGHT),
                                                          
                                                          LEFT.verification != '' AND
                                                          TRIM(RIGHT.OTHER_DESC[1].value, LEFT, RIGHT) != ''        => TRIM(LEFT.verification, LEFT, RIGHT) +  '; ' + TRIM(RIGHT.OTHER_DESC[1].value, LEFT, RIGHT),
                                                          /* default: left.verification != '' & right.otherDesc = '' */ 
                                                                                                                       TRIM(LEFT.verification, LEFT, RIGHT)
                                                       ),
                                 SELF := LEFT
                               ));    
                               
            // glean licenses from key file and then roll them up                   
            ds_licenseRecs := 
               JOIN(ds_nonPublicSubjectReportNumbers,
                    SANCTN_Mari.key_license_midex,
                    KEYED( LEFT.NP_subject_rpt_nbr = RIGHT.midex_rpt_nbr ), 
                    TRANSFORM(MIDEX_Services.Layouts.compReport_nonpublicCodesRawLayout,
                              SELF.Licenses := DATASET([{RIGHT.STD_TYPE_DESC, RIGHT.CLN_LICENSE_NUMBER,  
                                                         '', RIGHT.LICENSE_STATE, ROW([],iesp.share.t_Date),TRUE}], iesp.midex_share.t_MIDEXLicenseInfo),
                              SELF.other_desc := [],
                              SELF          := RIGHT
                            ),
                     LIMIT(MIDEX_Services.Constants.JOIN_LIMIT));
           
            ds_licensesRolled := 
              ROLLUP( ds_licenseRecs, 
                      LEFT.batch = RIGHT.batch AND
                      LEFT.incident_num = RIGHT.incident_num AND
                      LEFT.party_num = RIGHT.party_num,
                      TRANSFORM(MIDEX_Services.Layouts.compReport_nonpublicCodesRawLayout,
                                licenseCount    := COUNT( LEFT.Licenses );
                                SELF.Licenses   := IF( licenseCount < iesp.Constants.MIDEX.MAX_COUNT_REPORT_LICENSES, 
                                                       LEFT.Licenses + RIGHT.Licenses,
                                                       LEFT.Licenses
                                                     ),
                                SELF.other_desc := [],
                                SELF            := LEFT
                               )); 
            
            // Collect subject AKAs/DBAs
            ds_akasDbasSubjAll := 
              JOIN( ds_nonPublicSubjectReportNumbers,
                    SANCTN_Mari.key_party_aka_dba,
                    KEYED( LEFT.batch = RIGHT.batch AND
                           LEFT.incident_num = RIGHT.incident_num AND
                           LEFT.NP_subjectParty_num = RIGHT.party_num ) AND
                    LEFT.dbcode = RIGHT.dbcode,
                    TRANSFORM( MIDEX_Services.Layouts.compReport_AkaDbaLayout,
                               SELF.AKANames       := IF( RIGHT.name_type = MIDEX_Services.Constants.AKA_NAME_TYPE,
                                                          DATASET( [{RIGHT.aka_dba_text,'','','','',''}],iesp.Share.t_name ),
                                                          DATASET( [],iesp.Share.t_name )
                                                        ),
                               SELF.DBANames       := IF( RIGHT.name_type = MIDEX_Services.Constants.DBA_NAME_TYPE,
                                                          DATASET( [{RIGHT.aka_dba_text}],iesp.midexcompreport.t_MIDEXDBAName ),
                                                          DATASET( [],iesp.midexcompreport.t_MIDEXDBAName )
                                                        ),
                               SELF.batchNumber    := LEFT.batch,   
                               SELF.incidentNumber := LEFT.incident_num,
                               SELF.partyNumber    := LEFT.party_num,
                               SELF.dbcode         := LEFT.dbcode,
                               SELF                := RIGHT,  // name_type
                               SELF                := LEFT, // midex rpt nbr, subject rpt & party numbers 
                             ),
                    LEFT OUTER,
                    LIMIT(MIDEX_Services.Constants.JOIN_LIMIT_FOR_CHOOSEN, SKIP));
            
            ds_akasDbasSubjAllSorted := SORT( ds_akasDbasSubjAll, batchNumber, incidentNumber, partyNumber, dbcode, name_type );
            
            // rollup akas and dbas into two records for each midex report number, keeping only the max for each dataset
            ds_akasDbasSubjRolled := 
              ROLLUP( ds_akasDbasSubjAllSorted,
                      LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr AND
                      LEFT.dbcode = RIGHT.dbcode,
                      TRANSFORM(  MIDEX_Services.Layouts.compReport_AkaDbaLayout,
                                  SELF.AKANames  := LEFT.AKANames + RIGHT.AKANames,
                                  SELF.DBANames  := LEFT.DBANames + RIGHT.DBANames,
                                  SELF.name_type := '';  // clearing out variable since both types are in their own child dataset
                                  SELF           := LEFT,
                                  SELF           := [],
                                ));
            
            //----------------------------------------------------------------------------------------------------------
            //    start building the main record  - There are several keys that need to be hit.  
            //----------------------------------------------------------------------------------------------------------
            // Get payload data for midex report numbers 
            ds_nonPubSanctnMidexRptNbrRecsRaw := 
              JOIN( ds_nonPublicSubjectReportNumbers, 
                    SANCTN_Mari.key_MIDEX_RPT_NBR,
                    KEYED( LEFT.NP_subject_rpt_nbr = RIGHT.midex_rpt_nbr ) AND
                    RIGHT.DBCODE IN set_nonPubAccess,
                    TRANSFORM( MIDEX_Services.Layouts.CompReport_TempLayout,
                               SELF.dataSource          := IF( RIGHT.DBCODE = MIDEX_Services.Constants.DATASOURCE_CODE_NONPUB,  
                                                               MIDEX_Services.Constants.DATASOURCE_NON_PUB,
                                                               MIDEX_Services.Constants.DATASOURCE_FREDDIE ),
                               SELF.MIDEXFileNumber     := LEFT.NP_subject_rpt_nbr,
                               SELF.midex_rpt_nbr       := LEFT.NP_subject_rpt_nbr,
                               SELF.party_num           := LEFT.party_num,
                               SELF.batch               := LEFT.batch,
                               SELF.incident_num        := LEFT.incident_num,
                               SELF.DBCODE              := RIGHT.DBCODE,
                               SELF.firstName           := RIGHT.fname,
                               SELF.middleName          := RIGHT.mname,
                               SELF.lastName            := RIGHT.lname,
                               SELF.suffixName          := RIGHT.name_suffix,
                               SELF.prefixName          := RIGHT.title,
                               SELF.companyName         := RIGHT.cname,
                               SELF.ename               := RIGHT.ename,
                               SELF.UniqueId            := INTFORMAT(RIGHT.DID,12,1),  
                               SELF.did                 := (UNSIGNED6)RIGHT.DID,
                               SELF.BusinessId          := INTFORMAT(RIGHT.BDID,12,1),  
                               SELF.bdid                := (UNSIGNED6)RIGHT.BDID,
															 SELF.BusinessIds					:= RIGHT,
															 SELF.UltID								:= RIGHT.UltID,
															 SELF.OrgID								:= RIGHT.OrgID,
															 SELF.SeleID							:= RIGHT.SeleID,
															 SELF.ProxID							:= RIGHT.ProxID,
															 SELF.POWID								:= RIGHT.POWID,
															 SELF.EmpID								:= RIGHT.EmpID,
															 SELF.DotID								:= RIGHT.DotID,
                               SELF.action              := RIGHT.sanctions,
                               SELF.tin                 := RIGHT.tin,
                               SELF.ssn                 := Suppress.ssn_Mask( RIGHT.ssn, ssnMask ),
                               SELF.dob                 := RIGHT.dob,
                               SELF.jobTitle            := RIGHT.party_position,
                               SELF.prim_range          := RIGHT.prim_range,
                               SELF.predir              := RIGHT.predir,
                               SELF.prim_name           := RIGHT.prim_name,
                               SELF.addr_suffix         := RIGHT.addr_suffix,
                               SELF.postdir             := RIGHT.postdir,
                               SELF.unit_desig          := RIGHT.unit_desig,
                               SELF.sec_range           := RIGHT.sec_range,
                               SELF.city                := RIGHT.v_city_name,
                               SELF.st                  := RIGHT.st,
                               SELF.zip5                := RIGHT.zip5,
                               SELF.zip4                := RIGHT.zip4,
                               SELF.fips_county         := RIGHT.fips_county,
                               SELF.phone               := RIGHT.phone,
                               SELF                     := LEFT,
                               SELF                     := []
                              ),
                    INNER,
                    LIMIT(iesp.Constants.MIDEX.MAX_COUNT_REPORT_INCIDENTS,SKIP));  

            ds_nonPubSanctnMidexRptNbrRecsDedup := DEDUP( SORT( ds_nonPubSanctnMidexRptNbrRecsRaw, midex_rpt_nbr ), midex_rpt_nbr );
            census_data.MAC_Fips2County_Keyed(ds_nonPubSanctnMidexRptNbrRecsDedup,st,fips_county,county,ds_nonPubSanctnMidexRptNbrRecs);
            
            // Per Rodney, the date of inclusion for Freddie Mac records is the incident date. 
            // for nonpublic it's the batch_date.
            
            // add incident specifics to the payload file
            ds_nonpublicWithIncRecs := 
              JOIN( ds_nonPubSanctnMidexRptNbrRecs,
                    SANCTN_Mari.key_Midex_NP_incident, 
                    KEYED(LEFT.incident_num = RIGHT.incident_num) AND
                    LEFT.batch = RIGHT.batch,
                    TRANSFORM( MIDEX_Services.Layouts.CompReport_TempLayout,
                               SELF.propertyAddr       := RIGHT.prop_addr,
                               SELF.propertyCity       := RIGHT.prop_city,
                               SELF.propertyState      := RIGHT.prop_state,
                               SELF.propertyZip        := RIGHT.prop_zip,
                               SELF.incidentReportedOnDate := RIGHT.ENTRY_DATE,
                               SELF.modifiedDate       := RIGHT.modified_date,
                               SELF.loadDate           := RIGHT.batch_date,
                               SELF.incidentDate       := RIGHT.incident_date,
                               SELF.dateOfInclusion    := IF(RIGHT.DBCODE = MIDEX_Services.Constants.DATASOURCE_CODE_NONPUB,
                                                             RIGHT.batch_date,
                                                             RIGHT.incident_date ),
                               SELF.sourceDocument     := RIGHT.source_doc,
                               SELF.jurisdiction       := RIGHT.jurisdiction,
                               SELF.caseNumber         := RIGHT.case_num,
                               SELF.additionalInfo     := RIGHT.additional_info,
                               SELF                    := LEFT
                              ),
                    LEFT OUTER,
                    LIMIT(MIDEX_Services.Constants.JOIN_LIMIT,SKIP));
            
            // add rolled incident text to payload and other incident info
            ds_nonpublicWithIncResTextRecs :=
              JOIN( ds_nonpublicWithIncRecs,  
                    ds_textKeyRolled,
                    LEFT.batch = RIGHT.batch AND 
                    LEFT.incident_num = RIGHT.incident_num AND 
                    LEFT.DBCODE = RIGHT.DBCODE,
                    TRANSFORM( MIDEX_Services.Layouts.CompReport_TempLayout,   
                               SELF.freddieIncidentText := IF( RIGHT.field_name = Midex_Services.Constants.OTHERINFO AND RIGHT.DBCODE = MIDEX_Services.Constants.DATASOURCE_CODE_FREDDIE, 
                                                               PROJECT(RIGHT, 
                                                                       TRANSFORM(iesp.midexcompreport.t_MIDEXCompComment,
                                                                                 SELF.Date := RIGHT.Date;
                                                                                 SELF.Text := RIGHT.Text)),
                                                               ROW([],iesp.midexcompreport.t_MIDEXCompComment)),
                               SELF.IncidentText        := IF( RIGHT.field_name = Midex_Services.Constants.INCIDENT_TEXT AND RIGHT.DBCODE = MIDEX_Services.Constants.DATASOURCE_CODE_NONPUB,
                                                               PROJECT(RIGHT, 
                                                                       TRANSFORM(iesp.midexcompreport.t_MIDEXCompComment,
                                                                                 SELF.Date := RIGHT.Date;
                                                                                 SELF.Text := RIGHT.Text)),
                                                               ROW([],iesp.midexcompreport.t_MIDEXCompComment)),
                               SELF.responseText        := IF( RIGHT.field_name = MIDEX_Services.Constants.INCIDENT_RESPONSE AND RIGHT.DBCODE = MIDEX_Services.Constants.DATASOURCE_CODE_NONPUB,
                                                               PROJECT( RIGHT, 
                                                                        TRANSFORM(iesp.midexcompreport.t_MIDEXCompComment,
                                                                                  SELF.Date := RIGHT.Date;
                                                                                  SELF.Text := RIGHT.Text)),
                                                               ROW([],iesp.midexcompreport.t_MIDEXCompComment)),   
                               SELF                     := LEFT,
                              ),
                    LEFT OUTER,
										LIMIT(MIDEX_Services.Constants.JOIN_LIMIT_FOR_CHOOSEN, SKIP));
                      // The limit statement was changed because of bug: 159622 to match what the public code is doing. For Timothy Lester Kyle, there are 349 incident records. The max in the iesp is 50, so these 
                      // records were being skipped. The Source Doc, incident info, date, ect were not picked up in the output for this reason.
                      // because the layout is so wide, we are collecting 1000 records, sorting and keeping the max count along with the other
                      // fields that were not populated if the number of records for the join was too large. 
 
 	
            ds_nonpublicWithIncResTextSorted := SORT( ds_nonpublicWithIncResTextRecs, midex_rpt_nbr, dbcode );
            
            // the SANCTN_Mari.key_Midex_NP_text key is overloaded. ds_textKeyRolled rolls the incident text 
            // this rollup combines the incident and response text into the same record for each midex report number
            ds_nonpublicWithIncResTextRolled := 
              ROLLUP( ds_nonpublicWithIncResTextSorted, 
                      LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr AND
                      LEFT.DBCODE = RIGHT.DBCODE,
                      TRANSFORM(MIDEX_Services.Layouts.CompReport_TempLayout,
                                SELF.freddieIncidentText := IF( COUNT(LEFT.freddieIncidentText.Text) = 0,  
                                                                RIGHT.freddieIncidentText,
                                                                LEFT.freddieIncidentText
                                                              ),
                                SELF.IncidentText        := IF( COUNT(LEFT.IncidentText.Text) = 0, 
                                                                RIGHT.IncidentText,
                                                                LEFT.IncidentText
                                                              ),
                                SELF.responseText        := IF( COUNT(LEFT.responseText.Text) = 0, 
                                                                RIGHT.responseText,
                                                                LEFT.responseText
                                                              ),
                                SELF            := LEFT
                               )); 
                               
            // adding professions to payload, incident text, incident info dataset                 
            ds_nonpublicWithProfessions := 
              JOIN( ds_nonpublicWithIncResTextRolled,
                    ds_professionsRolled,  
                    LEFT.batch = RIGHT.batch AND 
                    LEFT.incident_num = RIGHT.incident_num AND 
                    LEFT.DBCODE = RIGHT.DBCODE,
                    TRANSFORM( MIDEX_Services.Layouts.CompReport_TempLayout,
                               SELF.professions := RIGHT.OTHER_DESC,
                               SELF             := LEFT
                             ),
                     LEFT OUTER,
                     LIMIT(MIDEX_Services.Constants.JOIN_LIMIT,SKIP));
            
            // adding rolled licenses to payload, incident text, incident info and professions dataset
            ds_nonpublicWithLicenses := 
              JOIN( ds_nonpublicWithProfessions, 
                    ds_licensesRolled,  
                    LEFT.batch = RIGHT.batch AND 
                    LEFT.incident_num = RIGHT.incident_num AND 
                    LEFT.party_num = RIGHT.party_num AND
                    LEFT.DBCODE = RIGHT.DBCODE,
                    TRANSFORM( MIDEX_Services.Layouts.CompReport_TempLayout,
                               SELF.Licenses := RIGHT.Licenses,
                               SELF          := LEFT
                             ),
                     LEFT OUTER,
                     LIMIT(MIDEX_Services.Constants.JOIN_LIMIT,SKIP));
                            
            // adding rolled verification text to payload, incident text, incident info, professions and licenses dataset
            ds_nonpublicWithVerification := 
              JOIN( ds_nonpublicWithLicenses, 
                    ds_verificationRolled,
                    LEFT.batch = RIGHT.batch AND 
                    LEFT.incident_num = RIGHT.incident_num AND 
                    LEFT.np_subjectParty_num = RIGHT.party_num AND
                    LEFT.DBCODE = RIGHT.DBCODE,
                    TRANSFORM( MIDEX_Services.Layouts.CompReport_TempLayout,
                               SELF.verification := RIGHT.verification,
                               SELF              := LEFT
                             ),
                     LEFT OUTER,
                     LIMIT(MIDEX_Services.Constants.JOIN_LIMIT,SKIP));
                            
            // adding rolled other identifying references to payload, incident text, 
            // incident info, professions, licenses and verification dataset
            ds_nopublicWithOtherIdenRef :=
              JOIN( ds_nonpublicWithVerification,
                    ds_subjectOtherIdenRefRolled,
                    LEFT.batch = RIGHT.batch AND 
                    LEFT.incident_num = RIGHT.incident_num AND 
                    LEFT.np_subjectParty_num = RIGHT.party_num AND
                    LEFT.DBCODE = RIGHT.DBCODE,
                    TRANSFORM( MIDEX_Services.Layouts.CompReport_TempLayout,
                               SELF.otherIdentifyingRef := CHOOSEN( DEDUP( SORT( RIGHT.Text, value), value ), iesp.Constants.MIDEX.MAX_COUNT_REPORT_TEXT),
                               SELF                     := LEFT
                             ),
                     LEFT OUTER,
                     LIMIT(MIDEX_Services.Constants.JOIN_LIMIT,SKIP));

            // adding rolled nmls data to payload, incident text, incident info, 
            // professions, licenses, verification and other identifying references dataset
            ds_nonpublicWithNmlsInfo :=
              JOIN( ds_nopublicWithOtherIdenRef,
                    ds_subjectNmlsDedup,
                    LEFT.midex_rpt_nbr = RIGHT.np_subject_rpt_nbr,
                    TRANSFORM( MIDEX_Services.Layouts.CompReport_TempLayout,
                               SELF.nmlsId   := RIGHT.nmlsId,
                               SELF.nmlsType := RIGHT.nmlsType,
                               SELF          := LEFT
                             ),
                    LEFT OUTER,
                    KEEP(iesp.Constants.MIDEX.MAX_COUNT_SEARCH_NMLS));

						 ds_subjWithAkaDba :=
                JOIN( ds_nonpublicWithNmlsInfo,
                      ds_akasDbasSubjRolled,
                      LEFT.midex_rpt_nbr = RIGHT.np_subject_rpt_nbr,
                      TRANSFORM( MIDEX_Services.Layouts.CompReport_TempLayout,
																	 SELF.AKANames := CHOOSEN( SORT( RIGHT.AKANames, Full ), iesp.Constants.MIDEX.MAX_COUNT_REPORT_AKA_DBA),
																	 SELF.DBANames := CHOOSEN( SORT( RIGHT.DBANames, name ), iesp.Constants.MIDEX.MAX_COUNT_REPORT_AKA_DBA),
                                   SELF             := LEFT
                                ),
                      LEFT OUTER,
                      KEEP(1), 
                      LIMIT(MIDEX_Services.Constants.JOIN_LIMIT) );  
             
            // adding rolled parties data to payload, incident text, incident info, 
            // professions, licenses, verification, other identifying references and
            // NMLS dataset
            ds_nonpublicRecs :=
              JOIN( ds_subjWithAkaDba,
                    ds_partiesRolledSorted,
                    LEFT.batch = RIGHT.batch AND 
                    LEFT.incident_num = RIGHT.incident_num AND 
                    LEFT.DBCODE = RIGHT.DBCODE,
                    TRANSFORM( MIDEX_Services.Layouts.CompReport_TempLayout,
                               SELF.IncidentParties := RIGHT.partyRecs,
                               SELF                 := LEFT
                             ),
                     LEFT OUTER,
                     LIMIT(MIDEX_Services.Constants.JOIN_LIMIT,SKIP));
              
            ds_nonpublicRecs_recsHash := 
              PROJECT(ds_nonpublicRecs, MIDEX_Services.alert_calcs.xfm_calcMidexIncidentHashes(LEFT));
						   
            RETURN (IF(alert,ds_nonpublicRecs_recsHash,ds_nonpublicRecs));
          END; // end fn_nonPub_by_midexReportNumbers
        
    // TRANSFORM expanded nonpublic key layout into slimmed nonpublic layout output
      EXPORT fn_nonpublicLayoutRecs(DATASET (MIDEX_Services.Layouts.CompReport_TempLayout) ds_midexRptNumberPayloadRecs, STRING dobMask) := 
        FUNCTION 
          ds_resultsRaw :=
            PROJECT( ds_midexRptNumberPayloadRecs, 
                     TRANSFORM( iesp.midexcompreport.t_MIDEXCompNonPublicRecord, 
                                SELF.SubjectReported            := MIDEX_Services.Functions.fn_SubjectReported(LEFT, dobMask),
                                SELF.SourceInfo                 := MIDEX_Services.Functions.fn_SourceInfo(LEFT),
                                SELF.ModifiedDate               := iesp.ECL2ESP.toDatestring8(LEFT.modifiedDate),
                                SELF.LoadDate                   := iesp.ECL2ESP.toDateString8(LEFT.loadDate),
                                SELF.IncidentVerification       := LEFT.verification,
                                SELF.Professionals              := LEFT.incidentParties,
                                SELF.IncidentInfo               := LEFT.incidentText,       
                                SELF.RebuttalInfo               := LEFT.responseText, 
                                SELF                            := LEFT               
                              ));
          
          ds_results := SORT(ds_resultsRaw, MIDEXFileNumber);
          
          RETURN ds_results;
        END;  // end fn_nonpublicLayoutRecs
                                 
        
      EXPORT fn_freddieMacLayoutRecords(DATASET (MIDEX_Services.Layouts.CompReport_TempLayout) ds_midexRptNumberPayloadRecs, SET OF STRING1 set_nonPubAccess = [], STRING dobMask) := 
        FUNCTION
          ds_resultsRaw :=
            PROJECT( ds_midexRptNumberPayloadRecs, 
                     TRANSFORM( iesp.midexcompreport.t_MIDEXCompNonPublicExRecord, 
                                akas                 := LEFT.incidentParties; 
                                SELF.SubjectReported := MIDEX_Services.Functions.fn_SubjectReported(LEFT, dobMask),
                                SELF.SourceInfo      := MIDEX_Services.Functions.fn_SourceInfo(LEFT),
                                SELF.ReportDate      := iesp.ECL2ESP.toDate ( (UNSIGNED6)LEFT.incidentReportedOnDate ),
                                SELF.ModifiedDate    := iesp.ECL2ESP.toDate ((UNSIGNED6)LEFT.modifiedDate),
                                SELF.LoadDate        := iesp.ECL2ESP.toDateString8(LEFT.loadDate),
                                SELF.MIDEXFileNumber := LEFT.MIDEXFileNumber,
                                SELF.IncidentInfo    := LEFT.freddieIncidentText, 
                                SELF.Action          := LEFT.Action,
                                SELF.AKAs            := CHOOSEN(akas, iesp.Constants.MIDEX.MAX_COUNT_REPORT_PARTY),
                                SELF                 := LEFT
                              ));
                  
              ds_results := SORT(ds_resultsRaw, MIDEXFileNumber);
                                           
              RETURN ds_results; 
            END; // end fn_nonPubFreddieMac_RptView_by_midexReportNum

       END; // midex REPORT_VIEW module

       EXPORT SEARCH_VIEW := MODULE
                      
            EXPORT fn_by_midex_rpt_num(DATASET(MIDEX_Services.Layouts.rec_midex_payloadKeyField) ds_in_midex_rpt_nbrs,
                                        STRING ssnMask, UNSIGNED1 alertVersion = Midex_Services.Constants.AlertVersion.None,
                                        SET OF STRING1 set_nonPubAccess = [], STRING8 StartLoadDate = '' ) := 
              FUNCTION
                // 
                ds_dateFilterRecs :=
                  JOIN( ds_in_midex_rpt_nbrs,
                        SANCTN_Mari.key_Midex_NP_incident,
                        KEYED(LEFT.incident_num = RIGHT.incident_num) AND
                        LEFT.batch = RIGHT.batch AND
                        RIGHT.DBCODE IN set_nonPubAccess AND
                        RIGHT.batch_date >= StartLoadDate,
                        TRANSFORM( MIDEX_Services.Layouts.rec_temp_layout,
                                   SELF          := LEFT;  
                                   SELF.loadDate := RIGHT.batch_date; 
                                   SELF          := []
                                 ),
                        INNER,
                        KEEP(1));  
                        
                ds_payloadRecsRaw := 
                  JOIN( ds_dateFilterRecs, 
                        SANCTN_Mari.key_MIDEX_RPT_NBR,
                        KEYED(LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr) AND
                        RIGHT.DBCODE IN set_nonPubAccess,
                        TRANSFORM( MIDEX_Services.Layouts.rec_temp_layout,
																	 partyNum             := IF( (UNSIGNED)RIGHT.PARTY_NUM = 0, '0', TRIM(RIGHT.PARTY_NUM, LEFT, RIGHT));
																													 // DBCODE: F=>FreddieMac, N=>Non-public
																	 ssnMasked            := Suppress.ssn_Mask(RIGHT.SSN, ssnMask);
																	 SELF.RecordType      := IF( RIGHT.DBCODE = MIDEX_Services.Constants.DATASOURCE_CODE_FREDDIE,  
																															 MIDEX_Services.Constants.DATASOURCE_FREDDIE,
																															 MIDEX_Services.Constants.DATASOURCE_NON_PUB ),
																	 SELF.firstname       := RIGHT.fname,
																	 SELF.middlename      := RIGHT.mname,
																	 SELF.lastname        := RIGHT.lname,
																	 SELF.suffixname      := RIGHT.name_suffix,
																	 SELF.Prefixname      := RIGHT.title,
																	 SELF.CompanyName     := RIGHT.cname,
																	 SELF.UniqueId        := IF( RIGHT.DID = 0,
																															 (STRING)RIGHT.DID,
																															 INTFORMAT(RIGHT.DID,12,1)),
																	 SELF.BusinessId      := IF( RIGHT.BDID = 0,
																															 (STRING)RIGHT.BDID,
																															 INTFORMAT(RIGHT.BDID,12,1)),
																	 SELF.BusinessIds			:= RIGHT,
																	 SELF.SSN             := IF( (UNSIGNED) ssnMasked = 0,
                                                               '',
                                                               ssnMasked
                                                             ),
                                   SELF.city				    := RIGHT.v_city_name,
                                   SELF.DBCODE          := LEFT.DBCODE,
                                   SELF                 := RIGHT,
                                   SELF                 := LEFT,
                                   SELF                 := []
                                 ),
                        INNER,
                        LIMIT(MIDEX_Services.Constants.JOIN_LIMIT,SKIP));  
                
                census_data.MAC_Fips2County_Keyed(ds_payloadRecsRaw,st,fips_county,county,ds_payloadRecs); 
                
                ds_payloadLic := 
                    JOIN(ds_payloadRecs,
                         SANCTN_Mari.key_license_midex,
                         KEYED(LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr),
                         TRANSFORM( MIDEX_Services.Layouts.rec_temp_layout,
                                    SELF.licenseIssueState := RIGHT.license_state,
                                    SELF.licenseType       := RIGHT.std_type_desc,
                                    SELF.licenseNumber     := RIGHT.cln_license_number,
                                    SELF.isLicenseCurrent  := TRUE; // NonPublic sanctions data is full file replacement and hence, always current
                                    SELF                   := LEFT,
                                    SELF                   := []
                                   ),
                         LEFT OUTER,
                         LIMIT(MIDEX_Services.Constants.JOIN_LIMIT,SKIP));  
                         
                ds_payloadLicNmls := 
                  JOIN( ds_payloadLic,
                        SANCTN_Mari.key_nmls_midex,
                        KEYED(LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr),
                        TRANSFORM( MIDEX_Services.Layouts.rec_temp_layout,
                                   SELF.nmlsInfo := DATASET([{RIGHT.license_type, RIGHT.nmls_id}],MIDEX_Services.Layouts.rec_nmlsInfo),
                                   SELF          := LEFT,
                                 ),
                        LEFT OUTER,
                        LIMIT(MIDEX_Services.Constants.JOIN_LIMIT,SKIP));
                
                ds_payloadLicNmlsSorted := SORT(ds_payloadLicNmls, midex_rpt_nbr);
                
                ds_payloadNmlsRolled := 
                  ROLLUP( ds_payloadLicNmlsSorted, 
                          LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr,
                          TRANSFORM( MIDEX_Services.Layouts.rec_temp_layout,
                                     SELF.nmlsInfo := IF( COUNT( LEFT.nmlsInfo ) < iesp.Constants.MIDEX.MAX_COUNT_REPORT_LICENSES,
                                                          LEFT.nmlsInfo + RIGHT.nmlsInfo,
                                                          LEFT.nmlsInfo
                                                        ), 
                                     SELF          := LEFT,
                                   ) ); 
                                   
                recsHash := PROJECT(ds_payloadNmlsRolled,MIDEX_Services.alert_calcs.calcMidexSrchHashes(LEFT));
 
                RETURN(IF(alertVersion != Midex_Services.Constants.AlertVersion.None,recsHash,ds_payloadNmlsRolled));
            END;  //  fn_by_midex_rpt_num
      END; // midex search view module
 
    END; // Midex module
  
  END;