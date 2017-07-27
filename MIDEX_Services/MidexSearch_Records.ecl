IMPORT AutoStandardI, Business_Header, doxie, ERO_Services, iesp, Prof_License_Mari, SANCTN, SANCTN_Mari, 
       SANCTN_Services, lib_stringlib, BIPV2, MIDEX_Services;

EXPORT MidexSearch_Records (MIDEX_Services.Iparam.searchrecords in_mod) := 
  FUNCTION


    // For the search preceeding the creation of the Midex Comprehensive Report; this is the 
    // main function to search all the appropriate autokeys and other key data based upon the  
    // input, retreive the data needed for the search results, penalize the results and then 
    // format the data into the iesp layouts.
    // The types of data being searched are:
    // 1. "Non-Public" mortgage industry & Freddie Mac reported incidents/sanctions.
    //    (data related attributes are found in the "SANCTN_Mari" module/folder.)
    // 2. "Public"ly reported mortgage industry incidents/sanctions.
    //    (data related attributes are found in the "SANCTN" module/folder.)
    // 3. "License", real estate industry related professional license information.
    //    (data related attributes are found in the "Prof_License_Mari" module/folder.)


        // set all input variables to upper case for searching against the key files.
        STRING20  in_lic_num           := StringLib.StringToUpperCase(in_mod.license_number);         
        STRING40  in_lic_state         := StringLib.StringToUpperCase(in_mod.license_state);
        UNSIGNED2 in_ssn_last4         := (UNSIGNED2)in_mod.ssn_last4;
        STRING26  in_midex_rpt_num     := StringLib.StringToUpperCase(in_mod.midex_rpt_num);
        STRING    in_tin               := StringLib.StringToUpperCase(in_mod.tin);  
        
        setNonpubAccess := MIDEX_Services.Functions.fn_GetNonPubDataSources( in_mod.DataPermissionMask );  

        STRING8 MidexSearchType  := IF( AutoStandardI.InterfaceTranslator.lname_value.val(in_mod) != '' OR in_mod.DID != '',
                                        MIDEX_SERVICES.Constants.PERSON_REPORT,
                                        MIDEX_SERVICES.Constants.BUSINESS_REPORT
                                       );

        // ***** Main processing

        // 1. Non-public info, sanctions & Freddie Mac(?) data from SANCTN_Mari module
        // 2. Public info, sanctions data from SANCTN module
        // 3. License info, Real Estate license data from Prof_License_Mari module
        
        // =============================================================================
        // 1. Get "Non-Public" (Sanctions & Freddie Mac) info from "SANCTN_Mari" data.
        // =============================================================================
        //
        // each of the non-payload keys contain the keyed fields plus the three pieces of the 
        // Midex Report Number (batch, incident number and party number). 
        // Mortgage Industry Data Exchange(MIDEX) from Mortgage Asset Research Institute(MARI)
        
        ds_all_nonPub_midexRptNums := MIDEX_Services.Search_IDs.Mari_NonPublic_Sanct_val(in_mod);
        ds_all_nonPub_midexRptNums_sorted := DEDUP( SORT( ds_all_nonPub_midexRptNums, midex_rpt_nbr ), midex_rpt_nbr );
     
        ds_all_nonPubSanctnMari_recs := IF( COUNT(setNonpubAccess) > 0,
                                            MIDEX_Services.Raw_Nonpublic.MIDEX.SEARCH_VIEW.fn_by_midex_rpt_num(ds_all_nonPub_midexRptNums_sorted, in_mod.ssnMask, in_mod.AlertVersion, setNonpubAccess, in_mod.StartLoadDate), 
                                            DATASET([],MIDEX_Services.Layouts.rec_temp_layout)
                                          );

       
        // =================================================================================
        // 2.  Get "Public" (sanctions) info from "SANCTN" data using an existing 
        //     SANCTN_Services" attribute for autokeys as well as the new keys created
        //     in the SANCTN folder.
        // ==================================================================================
       
       
       ds_pubSanctn_midexRptNums := MIDEX_Services.Search_IDs.Mari_Public_Sanct_val(in_mod);
       ds_pubSanctn_midexRptNum_sorted := DEDUP( SORT( ds_pubSanctn_midexRptNums, midex_rpt_nbr ), midex_rpt_nbr );

       ds_all_pubSanctnMari_recs := MIDEX_Services.Raw_Public.MIDEX.SEARCH_VIEW.fn_by_midex_rpt_nums(ds_pubSanctn_midexRptNum_sorted,  in_mod.ssnMask, in_mod.AlertVersion, in_mod.StartLoadDate);
       
       // per product -- (Bonnie Taepakdee & Dawn Hill), the midex report number should be included in the 
       // deduping process because the comprehensive report uses the midex report number as the unique id to 
       // populate the report.
       ds_recs_raw_dedup := 
          DEDUP( SORT( ds_all_nonPubSanctnMari_recs + ds_all_pubSanctnMari_recs, 
                       midex_rpt_nbr, DID, BDID, lastName, firstName, middleName, suffixName, 
                       prefixName, companyname, SSN, prim_name, prim_range, predir, prim_name, 
                       addr_suffix, postdir, unit_desig, sec_range, city, st, Zip5, Zip4, 
                       phone, county, DateFirstSeen, DateLastSeen, tin),
                 midex_rpt_nbr, DID, BDID, lastName, firstName, middleName, suffixName, 
                 prefixName, companyname, SSN, prim_name, prim_range, predir, prim_name, 
                 addr_suffix, postdir, unit_desig, sec_range, city, st, Zip5, Zip4, 
                 phone, county, DateFirstSeen, DateLastSeen, tin);
                 
// Add 230 fail statement here -- using ds_recs_raw_dedup?

        // Call a function to assign the penalty and filter out recs with too high a penalty.
        // ds_penalized := MIDEX_Services.Functions.fn_penalize_ss_results(ds_recs_raw, in_mod);
        ds_penalized_raw := MIDEX_Services.Macros.fnMac_penalize_results(ds_recs_raw_dedup, in_mod, 
                                                                         MIDEX_Services.Layouts.rec_temp_layout,
                                                                         firstname, middlename, lastname, CompanyName,
                                                                         licenseNumber, licenseIssueState, tin, penalt,  
                                                                         midex_rpt_nbr, ssn, uniqueId, prim_range, predir, 
                                                                         prim_name, postdir, addr_suffix, sec_range,
                                                                         city, st, zip5, phone);

        ds_recsKept := ds_penalized_raw((penalt DIV 1000) < MIDEX_Services.Constants.penaltyThreshold);
        
        // add population penalty to kept records
        ds_penalized := PROJECT(ds_recsKept, MIDEX_Services.Functions.xfm_addPopulationPenalt(LEFT, MidexSearchType));
        
         
				//------------------------------------------------------------------------------------------
        //
        //   Process Person Data
        //
        //------------------------------------------------------------------------------------------
        
        
        // Keeping DID in layout to use for faster sorting
        ds_personRecsFinalLayoutRaw := 
          PROJECT( ds_penalized,
                   TRANSFORM( MIDEX_Services.Layouts.Midex_RecordSearch_hash_layout_plus,
                              SELF.Details        := MIDEX_Services.Functions.fn_setMIDEXSearchRecordDetail(LEFT);
                              SELF.PrevSearchHash	:= LEFT.prev_all_hash;
                              SELF.SearchHash		  := LEFT.all_hash;
                              SELF                := LEFT; 
                            ));
                            
        ds_personRecsDidSorted := SORT(ds_personRecsFinalLayoutRaw, DID, penalt);
       
        ds_didRecsRolled := 
          ROLLUP( ds_personRecsDIDSorted, 
                  LEFT.DID = RIGHT.DID AND
                  LEFT.DID != 0,
                  TRANSFORM (MIDEX_Services.Layouts.Midex_RecordSearch_hash_layout_plus, 
                             // per Bonnie Taepakdee 10/18/2013 we are no longer limiting the number of records returned. Commenting out the code in case this changes back.
                             // countLeftDetails  := COUNT(LEFT.Details);
                             // details_raw       := IF( countLeftDetails < iesp.Constants.MIDEX.MAX_COUNT_SEARCH_RESPONSE_REPORTNUMBERS,
                                                      // LEFT.Details + RIGHT.Details,
                                                      // LEFT.Details);
                             // SELF.Details      := details_raw;
														 SELF.Details          := LEFT.Details + RIGHT.Details,
														 SELF.UniqueId         := LEFT.UniqueId,
                             SELF.penalt           := MIN( LEFT.penalt, RIGHT.penalt),
                             SELF.populationPenalt := MAX(LEFT.populationPenalt, RIGHT.populationPenalt),
                             SELF.SearchHash	     := LEFT.SearchHash + RIGHT.SearchHash,
                             SELF.PrevSearchHash	 := LEFT.PrevSearchHash + RIGHT.PrevSearchHash,
                             SELF                  := LEFT,
                           ));
        
        ds_didRecsSortedByPenalt := SORT( ds_didRecsRolled, penalt, -populationPenalt );

        //------------------------------------------------------------------------------------------
        //
        //   Process Business Data
        //            -- Rollup business data by bdid or BIP ids
        //------------------------------------------------------------------------------------------
       
        ds_BusinessRecsFinalLayoutRaw := 
          PROJECT( ds_penalized,
                   TRANSFORM( MIDEX_Services.Layouts.Midex_RecordSearch_hash_layout_plus,
                              SELF.BusinessId     := (STRING)LEFT.BDID;
															SELF.BusinessIds    := LEFT.BusinessIds;
                              SELF.Details        := MIDEX_Services.Functions.fn_setMIDEXSearchRecordDetail(LEFT);
                              // SELF.penalt      := LEFT.penalt;
                              // SELF.BDID        := LEFT.BDID; 
															SELF.PrevSearchHash	:= LEFT.prev_all_hash;
															SELF.SearchHash	    := LEFT.all_hash;
                              SELF                := LEFT; 
                            ));
                            
        ds_businessRecsBdidSorted := SORT(ds_BusinessRecsFinalLayoutRaw(BDID <> 0), BDID);
				ds_businessRecsLinkIdSorted := SORT(ds_BusinessRecsFinalLayoutRaw(BDID = 0), #expand(BIPV2.IDmacros.mac_ListAllLinkids()));
        
				MIDEX_Services.Layouts.Midex_RecordSearch_hash_layout_plus xform_business(MIDEX_Services.Layouts.Midex_RecordSearch_hash_layout_plus L, MIDEX_Services.Layouts.Midex_RecordSearch_hash_layout_plus R) 
					:= TRANSFORM
					// per Bonnie 10/18/2013 we are no longer limiting the number of records returned. Commenting out the code in case this changes back.
					// countLeftDetails := COUNT(LEFT.Details);
					// details_raw      := IF( countLeftDetails < iesp.Constants.MIDEX.MAX_COUNT_REPORT_RESPONSE_RECORDS,
														 // LEFT.Details + RIGHT.Details,
														 // LEFT.Details);
					// SELF.Details     := details_raw;
					SELF.Details          := IF(COUNT(L.Details) < iesp.Constants.MIDEX.MAX_COUNT_SEARCH_RESPONSE_REPORTNUMBERS,
																			L.Details + R.Details, 
																			L.Details);
					SELF.PrevSearchHash   := L.PrevSearchHash + R.PrevSearchHash;
					SELF.SearchHash	      := L.SearchHash + R.SearchHash;
					SELF.penalt           := MIN(L.penalt, R.penalt);
					SELF.populationPenalt := MAX(L.populationPenalt, R.populationPenalt);
					SELF                  := L;
				END;
				
        ds_bdidRecsRolled := 
          ROLLUP( ds_businessRecsBdidSorted, 
                  LEFT.BDID = RIGHT.BDID AND
                  LEFT.BDID != 0,
                  xform_business(LEFT, RIGHT));
        ds_linkIdRecsRolled := 
					ROLLUP( ds_businessRecsLinkIdSorted,
									BIPV2.IDmacros.mac_JoinTop3Linkids() AND
									LEFT.UltID != 0,
									xform_business(LEFT, RIGHT));
									
        ds_busRecsSortedByPenalt := SORT( ds_bdidRecsRolled + ds_linkIdRecsRolled, penalt, -populationPenalt );
        
        ds_ResultRecs_raw := IF( MidexSearchType = MIDEX_SERVICES.Constants.PERSON_REPORT,
                                 ds_didRecsSortedByPenalt,
                                 ds_busRecsSortedByPenalt );
				
        /*
        // Since we moved to a different alert version, we don't need to make use of the "ReturnAllRecords" flag
				// Only keep search records that do not match the previous search hash values.
				alertOnly_recs := 
          JOIN( ds_ResultRecs_raw,in_mod.searchHashes,
								LEFT.SearchHash = RIGHT.all_hash,
								TRANSFORM(LEFT),
								LEFT ONLY );
        
				ds_final_results := IF(~in_mod.EnableAlert OR in_mod.ReturnAllRecords,ds_ResultRecs_raw,alertOnly_recs);
        */
        alertUpdateHash_recs := 
          PROJECT( ds_ResultRecs_raw,
								   TRANSFORM( MIDEX_Services.Layouts.hash_layout,
													    SELF.all_hash      := LEFT.SearchHash,
													    SELF.prev_all_hash := LEFT.PrevSearchHash,
													    SELF               := [] ));
        
        iesp.midexrecordsearch.t_MIDEXRecordSearchRecord  xfm_addCounter (  MIDEX_Services.Layouts.Midex_RecordSearch_hash_layout_plus in_dataset, INTEGER c ) :=
          TRANSFORM
            SELF.RecordNumber   := (STRING)c;
            SELF.UniqueID       := IF( MidexSearchType = MIDEX_SERVICES.Constants.PERSON_REPORT,
                                       in_dataset.UniqueId,
                                       '' );
            SELF.BusinessID     := IF( MidexSearchType = MIDEX_SERVICES.Constants.BUSINESS_REPORT,
                                       in_dataset.BusinessId,
                                       '' );
						SELF.BusinessIDS    := IF( MidexSearchType = MIDEX_SERVICES.Constants.BUSINESS_REPORT,
                                       in_dataset.BusinessIds );
            SELF.Details        := in_dataset.Details;
          END;
				
        ds_recs_with_recCounter := PROJECT( ds_ResultRecs_raw, xfm_addCounter ( LEFT, COUNTER ));
				
				finalresults := MIDEX_Services.Functions.Format_midexSearch_iesp(ds_recs_with_recCounter,alertUpdateHash_recs,in_mod);

        RETURN finalresults; 

  END; // end of MidexSearch_Records function

