IMPORT doxie,iesp,MIDEX_Services;

EXPORT MidexReport_Records ( MIDEX_Services.Iparam.reportrecords in_mod,
                             doxie.IDataAccess mod_access ) := 
  FUNCTION

    BOOLEAN   enableAlert            := in_mod.EnableAlert;    
    BOOLEAN   include_SourceDocs     := in_mod.includeSourceDocs;
    DATASET   ds_midexReportNumberIn := in_mod.MidexReportNumbers;
    
    in_did  		:= (UNSIGNED6)in_mod.did;
    in_bdid 		:= (UNSIGNED6)in_mod.bdid;
		in_linkids	:= in_mod.linkids;
		fetchLevel	:= in_mod.BusinessIDFetchLevel;
    setNonpubAccess := MIDEX_Services.Functions.fn_GetNonPubDataSources( mod_access.DataPermissionMask );                
            
    // Search Type requested
    isLinkIdsSearch := EXISTS(in_linkids(ProxID != 0 OR SeleID != 0 OR OrgID != 0 OR UltID != 0));
    
    STRING MidexReportSearchType := MAP( in_mod.did  != '' 		 	=> MIDEX_SERVICES.Constants.PERSON_REPORT,
                                         in_mod.bdid != ''  		=> MIDEX_SERVICES.Constants.BUSINESS_REPORT,
                                         isLinkIdsSearch      	=> MIDEX_SERVICES.Constants.NEW_BUSINESS_REPORT,
                                                     	 MIDEX_SERVICES.Constants.MIDEX_REPORT );
    
     // --------------------------------------------------------------------------------------------------------------
    //              Get All MIDEX Non-Public Sanctions Data
    // --------------------------------------------------------------------------------------------------------------
    ds_nonPubDidRecs  		:= MIDEX_Services.Raw_Nonpublic.fn_get_nonPublicDidData( in_did );
    ds_nonPubBdidRecs 		:= MIDEX_Services.Raw_Nonpublic.fn_get_nonPublicBdidData( in_bdid );
    ds_nonPubLinkidRecs 	:= MIDEX_Services.Raw_Nonpublic.fn_get_nonPublicLinkIdData( in_linkids, FetchLevel );
		ds_nonPubBusinessRecs	:= if(MidexReportSearchType = MIDEX_SERVICES.Constants.NEW_BUSINESS_REPORT, ds_nonPubLinkidRecs, ds_nonPubBdidRecs);
		
    ds_nonPubMidexReportNumbersAll := ds_nonPubDidRecs + ds_nonPubBusinessRecs + ds_midexReportNumberIn;
    
    // Calling macro to get all components for the nonpublic data so that midex report numbers that come from the did/bdid keys can be parsed as well.
    MIDEX_Services.Macros.MAC_getIncidentNumFromMidexReportNum( ds_nonPubMidexReportNumbersAll, ds_nonPubMidexReportNumbers );  
    
    ds_nonPubMidexPayloadRecs_all := MIDEX_Services.Raw_Nonpublic.MIDEX.REPORT_VIEW.fn_nonPub_by_midexReportNumbers( ds_nonPubMidexReportNumbers, setNonpubAccess, in_mod.EnableAlert, in_mod.searchType, mod_access.SSN_Mask, mod_access.dob_Mask, in_mod.StartLoadDate ); //DATASET([], MIDEX_Services.Layouts.CompReport_TempLayout); 
    
    // --------------------------------------------------------------------------------------------------------------
    //              MIDEX Non-Public Freddie Mac Sanctions Data
    // --------------------------------------------------------------------------------------------------------------
    ds_MidexFreddieMacPayloadRecs := ds_nonPubMidexPayloadRecs_all(dataSource = MIDEX_Services.Constants.DATASOURCE_FREDDIE );
    ds_MidexFreddieMacResults_all := MIDEX_Services.Raw_Nonpublic.MIDEX.REPORT_VIEW.fn_freddieMacLayoutRecords( ds_MidexFreddieMacPayloadRecs, setNonpubAccess, mod_access.dob_Mask );
    ds_MidexFreddieMacResults     := IF( MIDEX_Services.Constants.DATASOURCE_CODE_FREDDIE IN setNonpubAccess,
                                         CHOOSEN(ds_MidexFreddieMacResults_all, iesp.Constants.MIDEX.MAX_COUNT_REPORT_RESPONSE_FMRECS),
                                         DATASET([], iesp.midexcompreport.t_MIDEXCompNonPublicExRecord));

    // --------------------------------------------------------------------------------------------------------------
    //              MIDEX Non-Public Sanctions Data
    // --------------------------------------------------------------------------------------------------------------
    ds_MidexNonpublicPayloadRecs   := ds_nonPubMidexPayloadRecs_all(dataSource = MIDEX_Services.Constants.DATASOURCE_NON_PUB);
    ds_nonPubSanctnMariResults_all := MIDEX_Services.Raw_Nonpublic.MIDEX.REPORT_VIEW.fn_nonpublicLayoutRecs( ds_MidexNonpublicPayloadRecs, mod_access.dob_mask );
    ds_MidexNonpublicResults       := IF( MIDEX_Services.Constants.DATASOURCE_CODE_NONPUB IN setNonpubAccess, 
                                          CHOOSEN(ds_nonPubSanctnMariResults_all, iesp.Constants.MIDEX.MAX_COUNT_REPORT_RESPONSE_NPRECS),
                                          DATASET( [], iesp.midexcompreport.t_MIDEXCompNonPublicRecord ));

    // --------------------------------------------------------------------------------------------------------------
    //              Get MIDEX Public Sanctions Data
    // --------------------------------------------------------------------------------------------------------------
ds_pubDidRecs  			:= MIDEX_Services.Raw_Public.fn_get_PublicSanctnDidData( in_did );
    ds_pubBdidRecs 			:= MIDEX_Services.Raw_Public.fn_get_PublicSanctnBdidData( in_bdid );
    ds_pubLinkIdRecs 		:= MIDEX_Services.Raw_Public.fn_get_PublicSanctnLinkIdData( in_linkids, mod_access, FetchLevel);
		ds_pubBusinessRecs	:= if(MidexReportSearchType = MIDEX_SERVICES.Constants.NEW_BUSINESS_REPORT, ds_pubLinkIdRecs, ds_pubBdidRecs);
		
    ds_PubMidexReportNumbers := ds_PubDidRecs + ds_pubBusinessRecs + ds_midexReportNumberIn;
    
    ds_MidexPublicResults_temp := MIDEX_Services.Raw_Public.MIDEX.REPORT_VIEW.fn_pub_RptView_by_midex_rpt_num(ds_pubMidexReportNumbers, mod_access, in_mod.EnableAlert, in_mod.StartLoadDate); 
    ds_MidexPublicResults_all  := MIDEX_Services.Raw_Public.MIDEX.REPORT_VIEW.fn_PublicLayoutRecords(ds_MidexPublicResults_temp, mod_access.dob_Mask );
    ds_MidexPublicResults := CHOOSEN(ds_MidexPublicResults_all, iesp.Constants.MIDEX.MAX_COUNT_REPORT_RESPONSE_PUBRECS);
                               
    // --------------------------------------------------------------------------------------------------------------
    //              Get MIDEX License Data
    // --------------------------------------------------------------------------------------------------------------
    // combine pub and nonpub midex report numbers to make one call to the get the license data
	 ds_publicAndNonpublicMidexNumbers := DEDUP( SORT((ds_nonPubMidexReportNumbers + ds_pubMidexReportNumbers + ds_midexReportNumberIn), midex_rpt_nbr), midex_rpt_nbr);
    ds_mari_rids := CASE( MidexReportSearchType, MIDEX_SERVICES.Constants.PERSON_REPORT   		=> MIDEX_Services.Raw_ProfessionalLicenses.fn_get_ProfLicMari_DidData  ( in_did ),
                                                 MIDEX_SERVICES.Constants.BUSINESS_REPORT 		=> MIDEX_Services.Raw_ProfessionalLicenses.fn_get_ProfLicMari_BdidData ( in_bdid ), 
                                                 MIDEX_SERVICES.Constants.NEW_BUSINESS_REPORT => MIDEX_Services.Raw_ProfessionalLicenses.fn_get_ProfLicMari_LinkIdData ( in_linkids, mod_access, fetchLevel ), 
                                                                               		 DATASET( [], MIDEX_Services.Layouts.rec_profLicMari_payloadKeyField )
                        );
    
    licenseMod := MODULE(PROJECT(in_mod,Midex_Services.Iparam.reportrecords,OPT));
      EXPORT DATASET MidexReportNumbers   := ds_publicAndNonpublicMidexNumbers;
      EXPORT DATASET MariRidNumbers       := ds_mari_rids;
      EXPORT BOOLEAN TrackNameChanges     := FALSE;
      EXPORT BOOLEAN TrackAddressChanges  := FALSE;
      EXPORT BOOLEAN TrackIncidentChanges := FALSE;
      EXPORT BOOLEAN TrackLienJudgment    := FALSE;
      EXPORT BOOLEAN TrackBankruptcy      := FALSE;
      EXPORT BOOLEAN TrackCriminal        := FALSE;
    END;

    ds_MidexLicenseRecordsOut := MIDEX_Services.LicenseReport_Records(licenseMod,mod_access);
    
    // Format to the license iesp response output - not to deviate too much from the existing code to account for alerts
    ds_MidexLicenseRecordsOutIesp := MIDEX_Services.Functions.Format_licenseReport_iespResponse(ds_MidexLicenseRecordsOut);
    
    ds_MidexLicenseResultsAll := PROJECT(ds_MidexLicenseRecordsOutIesp[1].Records, iesp.midexlicensereport.t_MIDEXLicenseReportRecord);
    
    ds_MidexLicenseResults    := IF( MidexReportSearchType != MIDEX_SERVICES.Constants.MIDEX_REPORT, 
                                     CHOOSEN(ds_MidexLicenseResultsAll,iesp.Constants.MIDEX.MAX_COUNT_REPORT_RESPONSE_LICENSES), 
                                     DATASET([], iesp.midexlicensereport.t_MIDEXLicenseReportRecord)
                                   );
    // --------------------------------------------------------------------------------------------------------------
    //              Business SmartLinx Data
    // --------------------------------------------------------------------------------------------------------------
    rec_smartLinxBusinessRecs_raw	:= IF(MidexReportSearchType = MIDEX_SERVICES.Constants.BUSINESS_REPORT, MIDEX_Services.SmartLinx_Business_Sections(in_mod.bdid, mod_access, include_SourceDocs, in_mod.includeVendorSourceB)); 
    rec_smartLinxBusinessRecs			:= PROJECT( rec_smartLinxBusinessRecs_raw, MIDEX_Services.Functions.xfm_setSmartLinxBusinessFormat( LEFT ));

    // --------------------------------------------------------------------------------------------------------------
    //              TopBusiness Data
    // --------------------------------------------------------------------------------------------------------------
		rec_topBusinessRecs_bip_raw := IF(MidexReportSearchType = MIDEX_SERVICES.Constants.NEW_BUSINESS_REPORT, MIDEX_Services.TopBusiness_Sections(in_linkids, mod_access, in_mod.BusinessIDFetchLevel, in_mod.includeVendorSourceB,in_mod.IncludeAssignmentsAndReleases)); 
    rec_topBusinessRecs 				:= PROJECT(rec_topBusinessRecs_bip_raw, iesp.midexcompreport.t_MIDEXCompTopBusinessRecord)[1];

    // --------------------------------------------------------------------------------------------------------------
    //              Person Smartlinx Data
    // --------------------------------------------------------------------------------------------------------------
		smartLinx_pers_options	:= MODULE(PROJECT(in_mod,Midex_Services.Iparam.smartLinxPersonIncludeOptions))	END;
    
		rec_smartLinxPersonRecs_raw := IF(MidexReportSearchType = MIDEX_SERVICES.Constants.PERSON_REPORT, 
                                      PROJECT(MIDEX_Services.SmartLinx_Person_Sections(in_mod.did, include_SourceDocs, smartLinx_pers_options/*, in_mod.includeVendorSourceB*/), 
                                              MIDEX_Services.Layouts.rec_SmartLinxPersonWithSources ));

    // since this is a single record coming back, but send only first row to function for layout transform
		rec_smartLinxPersonRecs := MIDEX_Services.Functions.fn_setSmartLinxPersonFormat ( rec_smartLinxPersonRecs_raw[1], mod_access.dob_mask, smartLinx_pers_options); 
    // in the function call, not sure why we have to send the first row because it's a record, not a 
    // dataset, but sending the first row clears the error.
    
    // --------------------------------------------------------------------------------------------------------------
    //              Source Doc ID Section
    // --------------------------------------------------------------------------------------------------------------
    
    ds_PersonSources   := rec_smartLinxPersonRecs_raw.Sources;
    ds_BusinessSources := rec_smartLinxBusinessRecs_raw.Sources;
    
    // --------------------------------------------------------------------------------------------------------------
    //              Combine Public and Nonpublic Incident Hashes 
    // --------------------------------------------------------------------------------------------------------------
    incidentHashCombined := SUM(ds_nonPubMidexPayloadRecs_all + ds_MidexPublicResults_temp,incident_hash);   // double check
    
    // --------------------------------------------------------------------------------------------------------------
    //              Calculate and Combine License Hashes 
    // --------------------------------------------------------------------------------------------------------------
    // a single hash value is needed for the license status to determine if there are any changes.
    // since the data_source field is always populated, using this as the condition ensures
    // that all records are included in the hash value.
    
     ds_licenseProject := 
         PROJECT( ds_MidexLicenseRecordsOut, 
                  TRANSFORM(Midex_Services.Layouts.hash_layout,
                            SELF := LEFT));

    // Here it's preferred to combine the hash values in a rollup instead of the sum as above because there are several hash values being calculated.           
    ds_licenseHashRollup := 
      ROLLUP( ds_licenseProject, 
              TRUE,
              TRANSFORM(Midex_Services.Layouts.hash_layout,
                        combinedPrevLicenseStatusHash    := (UNSIGNED8)LEFT.prev_license_status_hash + (UNSIGNED8)RIGHT.prev_license_status_hash;
                        combinedLicenseStatusHash        := (UNSIGNED8)LEFT.license_status_hash + (UNSIGNED8)RIGHT.license_status_hash;
                        combinedNameHash                 := (UNSIGNED8)LEFT.name_hash + (UNSIGNED8)RIGHT.name_hash;
                        combinedAddressHash              := (UNSIGNED8)LEFT.address_hash + (UNSIGNED8)RIGHT.address_hash;
                        combinedNMLSIdHash               := (UNSIGNED8)LEFT.nmls_id_hash + (UNSIGNED8)RIGHT.nmls_id_hash;
                        combinedDisciplinaryHash         := (UNSIGNED8)LEFT.disciplinary_hash + (UNSIGNED8)RIGHT.disciplinary_hash;
                        combinedRegistrationHash         := (UNSIGNED8)LEFT.registration_hash + (UNSIGNED8)RIGHT.registration_hash;
                        combinedRepresentsHash           := (UNSIGNED8)LEFT.represent_hash + (UNSIGNED8)RIGHT.represent_hash;
                        combinedPhoneHash                := (UNSIGNED8)LEFT.phone_hash + (UNSIGNED8)RIGHT.phone_hash;
												// AKANameVariation hash currently not returned in the Midex report
												// combinedAKANameVariationHash		 := (UNSIGNED8)LEFT.AKA_and_name_variation_hash + (UNSIGNED8)RIGHT.AKA_and_name_variation_hash;
                 
                        SELF.prev_license_status_hash   := combinedPrevLicenseStatusHash,
                        SELF.license_status_hash    	 	:= combinedLicenseStatusHash,
                        SELF.name_hash              	  := combinedNameHash,
                        SELF.address_hash           	  := combinedAddressHash,
                        SELF.phone_hash             	  := combinedPhoneHash,
                        SELF.nmls_id_hash            	  := combinedNMLSIdHash,
                        SELF.disciplinary_hash  	      := combinedDisciplinaryHash,
                        SELF.registration_hash  	      := combinedRegistrationHash,
                        SELF.represent_hash    	        := combinedRepresentsHash,
												// SELF.AKA_and_name_variation_hash	:= combinedAKANameVariationHash,
                        SELF                            := [],
                       ));

    // --------------------------------------------------------------------------------------------------------------
    //              Smartlinx Alert Calculations
    // --------------------------------------------------------------------------------------------------------------
    // smartlinx Alerts: name, address (& phone)
    SmartlinxAlertCalc := MAP( MidexReportSearchType = MIDEX_SERVICES.Constants.BUSINESS_REPORT 		=> PROJECT(rec_smartLinxBusinessRecs[1], MIDEX_Services.alert_calcs.xfm_calcMidexSmartlinxBusinessHashes(LEFT)),
															 MidexReportSearchType = MIDEX_SERVICES.Constants.NEW_BUSINESS_REPORT => PROJECT(rec_topBusinessRecs, MIDEX_Services.alert_calcs.xfm_calcMidexTopBusinessHashes(LEFT)),
                               MidexReportSearchType = MIDEX_SERVICES.Constants.PERSON_REPORT   		=> PROJECT(rec_smartLinxPersonRecs, MIDEX_Services.alert_calcs.xfm_calcMidexSmartlinxPersonHashes(LEFT)),
                                                                             		 ROW([],MIDEX_Services.Layouts.hash_layout)
                             );

    // --------------------------------------------------------------------------------------------------------------
    //            Combine Sections in Final Layout Output  
    // --------------------------------------------------------------------------------------------------------------
    
    iesp.midexcompreport.t_MIDEXCompReportRecord xfm_formatInto_t_MIDEXCompReportRecordLayout ( ) :=
      TRANSFORM
        SELF.PublicRecords            := ds_MidexPublicResults;         
        SELF.NonPublicRecords         := ds_MidexNonpublicResults;      
        SELF.NonPublicEXRecords       := ds_MidexFreddieMacResults;     
        SELF.Licenses                 := ds_MidexLicenseResults;        
        SELF.SourceSummary            := MAP( MidexReportSearchType = MIDEX_SERVICES.Constants.PERSON_REPORT   AND
                                              include_SourceDocs                                                   => ds_PersonSources,
                                              MidexReportSearchType = MIDEX_SERVICES.Constants.BUSINESS_REPORT AND
                                              include_SourceDocs                                                   => ds_BusinessSources,   
                                                                                                 DATASET([], iesp.share.t_SourceSection)
                                            );                   
        SELF.BusinessSmartLinxRecord  := IF( MidexReportSearchType = MIDEX_SERVICES.Constants.BUSINESS_REPORT, 
																							rec_smartLinxBusinessRecs[1]);  
        SELF.PersonSmartLinxRecord    := IF( MidexReportSearchType = MIDEX_SERVICES.Constants.PERSON_REPORT,
																							rec_smartLinxPersonRecs ); 
				SELF.TopBusinessRecord 				:= IF(MidexReportSearchType = MIDEX_SERVICES.Constants.NEW_BUSINESS_REPORT,
																							rec_topBusinessRecs);
				SELF := [];
      END;

    ds_MIDEXCompReportRecordLayout := DATASET([xfm_formatInto_t_MIDEXCompReportRecordLayout()]) ;

    // --------------------------------------------------------------------------------------------------------------
    //              Combine Alert Calculations
    // --------------------------------------------------------------------------------------------------------------
    reportNumber := 
      CASE( MidexReportSearchType, MIDEX_SERVICES.Constants.PERSON_REPORT   => in_mod.did,
                                   MIDEX_SERVICES.Constants.BUSINESS_REPORT => in_mod.bdid,
                                                 ds_midexReportNumberIn[1].midex_rpt_nbr
          );

    MIDEX_Services.Layouts.monitor_layout xfm_hashTemp := 
      TRANSFORM
        SELF.report_number                 := reportNumber;
           SELF.address_hash                  := SmartlinxAlertCalc.address_hash;
           SELF.all_hash                      := 0;
           SELF.bankruptcy_hash               := smartlinxAlertCalc.bankruptcy_hash;
           SELF.criminal_hash                 := smartlinxAlertCalc.criminal_hash;
           SELF.incident_hash                 := incidentHashCombined;
           SELF.prev_license_status_hash      := (UNSIGNED8)ds_licenseHashRollup[1].prev_license_status_hash;
           SELF.license_status_hash           := (UNSIGNED8)ds_licenseHashRollup[1].license_status_hash;
           SELF.lien_judgment_hash            := smartlinxAlertCalc.lien_judgment_hash;
           SELF.name_hash                     := smartlinxAlertCalc.name_hash;
           SELF.nmls_id_hash                  := (UNSIGNED8)ds_licenseHashRollup[1].nmls_id_hash;
           SELF.Disciplinary_hash             := (UNSIGNED8)ds_licenseHashRollup[1].Disciplinary_hash;
           SELF.Registration_hash             := (UNSIGNED8)ds_licenseHashRollup[1].Registration_hash;
           SELF.Represent_hash                := (UNSIGNED8)ds_licenseHashRollup[1].Represent_hash;
   				// SELF.AKA_and_name_variation_hash	 := (UNSIGNED8)ds_licenseHashRollup[1].AKA_and_name_variation_hash;
           SELF.phone_hash                    := smartlinxAlertCalc.phone_hash;
   				SELF.email_hash										 := smartlinxAlertCalc.email_hash;
   				SELF.property_hash								 := smartlinxAlertCalc.property_hash;
   				SELF.relative_hash								 := smartlinxAlertCalc.relative_hash;
   				SELF.bus_associate_hash						 := smartlinxAlertCalc.bus_associate_hash;
   				SELF.employer_hash								 := smartlinxAlertCalc.employer_hash;
   				SELF.name_variation_hash					 := smartlinxAlertCalc.name_variation_hash;
   				SELF.executive_hash								 := smartlinxAlertCalc.executive_hash;
   				SELF.SOS_hash											 := smartlinxAlertCalc.SOS_hash;
           SELF.passed_all_hash               := '0';
           SELF.passed_address_hash           := in_mod.addressHash;
           SELF.passed_license_hash           := '0';
           SELF.passed_license_status_hash    := in_mod.licenseStatHash;
           SELF.passed_name_hash              := in_mod.nameHash;
           SELF.passed_incident_hash          := in_mod.incidentHash;
           SELF.passed_phone_hash             := in_mod.phoneHash;  
           SELF.passed_bankruptcy_hash        := in_mod.bankruptcyHash;
           SELF.passed_criminal_hash          := in_mod.criminalHash;
           SELF.passed_lien_judgment_hash     := in_mod.lienJudgmentHash;
           SELF.passed_nmls_ID_hash           := in_mod.nmlsIdHash;
           SELF.passed_Represent_hash         := in_mod.RepresentHash;
           SELF.passed_Registration_hash      := in_mod.RegistrationHash;
           SELF.passed_Disciplinary_hash      := in_mod.DisciplinaryHash;
   				SELF.passed_email_hash						 := in_mod.EmailHash;
   				SELF.passed_property_hash					 := in_mod.PropertyHash;
   				SELF.passed_relative_hash					 := in_mod.RelativeHash;
   				SELF.passed_bus_associate_hash		 := in_mod.BusAssociateHash;
   				SELF.passed_employer_hash					 := in_mod.EmployerHash;
   				SELF.passed_name_variation_hash		 := in_mod.NameVariationHash;
   				SELF.passed_executive_hash				 := in_mod.ExecutiveHash;
   				SELF.passed_SOS_hash							 := in_mod.SOSHash;
        SELF                               := [];    
      END;
                     
    ds_hash_temp  := DATASET([xfm_hashTemp]);
    
    ds_hash_calcs := MIDEX_Services.alert_calcs.calcChanges(ds_hash_temp,in_mod);	
    
    MIDEX_Services.Layouts.Monitor_layout xfm_formatInto_Monitor_layout ( BOOLEAN isDeleted ) :=
      TRANSFORM
        SELF.report_number              := reportNumber;
        SELF.name_hash                  := 0;
        SELF.license_status_hash        := 0;
        SELF.address_hash               := 0;
        SELF.phone_hash                 := 0;
        SELF.license_hash               := 0;
        SELF.incident_hash              := 0;
        SELF.nmls_id_hash               := 0;
        SELF.nmls_status_hash           := 0;
        SELF.represent_hash             := 0;
        SELF.disciplinary_hash          := 0;
        SELF.registration_hash          := 0;
        SELF.bankruptcy_hash            := 0;
        SELF.criminal_hash              := 0;
        SELF.lien_judgment_hash         := 0;
				SELF.email_hash									:= 0;
				SELF.property_hash							:= 0;
				SELF.relative_hash							:= 0;
				SELF.bus_associate_hash					:= 0;
				SELF.employer_hash							:= 0;
				SELF.name_variation_hash				:= 0;
				SELF.executive_hash							:= 0;
				SELF.SOS_hash										:= 0;
        // SELF.AKA_and_name_variation_hash:= 0;
				SELF.all_hash                   := 0;
        SELF.nameChanged                := FALSE;
        SELF.addresschanged             := FALSE;
        SELF.bankruptcyChanged          := FALSE;
        SELF.criminalChanged            := FALSE;
        SELF.incidentChanged            := FALSE;
        SELF.licenseStatusChanged       := FALSE;
        SELF.lienJudgmentChanged        := FALSE;
        SELF.nmlsIDChanged              := FALSE;
        SELF.phoneChanged               := FALSE;
        SELF.RepresentChanged           := FALSE;
        SELF.RegistrationChanged        := FALSE;
        SELF.DisciplinaryChanged        := FALSE;
        SELF.AnyChanged                 := FALSE;  // Not used at development time
        SELF.licenseChanged             := FALSE;   // Not used at development time
				SELF.emailChanged             	:= FALSE;
				SELF.propertyChanged            := FALSE;
				SELF.relativeChanged            := FALSE;
				SELF.BusinessAssociateChanged		:= FALSE;
				SELF.employerChanged						:= FALSE;
				SELF.NameVariationChanged				:= FALSE;
				SELF.executiveChanged						:= FALSE;
				SELF.SecretaryOfStateFilingChanged	:= FALSE;
				// SELF.AKAAndNameVariationChanged	:= FALSE;
        SELF.deleted                    := isDeleted;
        SELF.passed_name_hash           := in_mod.nameHash;
        SELF.passed_license_status_hash := in_mod.licenseStatHash;
        SELF.passed_address_hash        := in_mod.addressHash;
        SELF.passed_phone_hash          := in_mod.phoneHash;
        SELF.passed_license_hash        := '';
        SELF.passed_incident_hash       := in_mod.incidentHash;
        SELF.passed_all_hash            := '';
        SELF.passed_bankruptcy_hash     := in_mod.bankruptcyHash;
        SELF.passed_criminal_hash       := in_mod.criminalHash;
        SELF.passed_lien_judgment_hash  := in_mod.lienJudgmentHash;
        SELF.passed_nmls_ID_hash        := in_mod.nmlsIDHash;
        SELF.passed_Represent_hash      := in_mod.RepresentHash;
        SELF.passed_Registration_hash   := in_mod.RegistrationHash;
        SELF.passed_Disciplinary_hash   := in_mod.DisciplinaryHash;
				SELF.passed_email_hash					:= in_mod.EmailHash;
				SELF.passed_property_hash				:= in_mod.PropertyHash;
				SELF.passed_relative_hash				:= in_mod.RelativeHash;
				SELF.passed_bus_associate_hash	:= in_mod.BusAssociateHash;
				SELF.passed_employer_hash				:= in_mod.EmployerHash;
				SELF.passed_name_variation_hash	:= in_mod.NameVariationHash;
				SELF.passed_executive_hash			:= in_mod.ExecutiveHash;
				SELF.passed_SOS_hash						:= in_mod.SOSHash;
				// SELF.passed_AKA_and_name_variation_hash	:= in_mod.AKAAndNameVariationHash;
				SELF := [];
      END;

    ds_blankHash   := DATASET([xfm_formatInto_Monitor_layout(FALSE)]);
    ds_deletedHash := DATASET([xfm_formatInto_Monitor_layout(TRUE)]);
    sanctionsExist := ( EXISTS(ds_MidexPublicResults)     OR 
                           EXISTS(ds_MidexNonpublicResults)  OR
                           EXISTS(ds_MidexFreddieMacResults) OR
                           EXISTS(ds_MidexLicenseResults) );
                       
    ds_hashCalcWithDelete := MAP( in_mod.EnableAlert AND sanctionsExist     => ds_hash_calcs,
                                        in_mod.EnableAlert AND NOT sanctionsExist => ds_deletedHash,
                                        ds_blankHash
                                     );                                                                                                                                                                                                            

    // If an alert report request is made and the document/report isn't found anymore, then return
    // a record with the record deleted flag set to true.
    alertVersion := IF(in_mod.enableAlert,Midex_Services.Constants.AlertVersion.Current,Midex_Services.Constants.AlertVersion.None);
    ds_results := MIDEX_Services.Functions.fn_formatMidexCompReport_iespResponse(ds_MIDEXCompReportRecordLayout, ds_hashCalcWithDelete[1], alertVersion);
		
    // Debug statements
    // OUTPUT(ds_nonPubBusinessRecs,named('ds_nonPubBusinessRecs'));
    // OUTPUT(ds_nonPubMidexPayloadRecs_all,named('ds_nonPubMidexPayloadRecs_all'));
    // OUTPUT(ds_pubBusinessRecs,named('ds_pubBusinessRecs'));
    // OUTPUT(ds_MidexPublicResults_all,named('ds_MidexPublicResults_all'));
    // OUTPUT(ds_MidexLicenseRecordsOut,named('ds_MidexLicenseRecordsOut'));
    // OUTPUT(rec_smartLinxBusinessRecs_raw,named('rec_smartLinxBusinessRecs_raw'));
    // OUTPUT(ds_hashCalcWithDelete,named('ds_hashCalcWithDelete'));
    
    RETURN ds_results;

  END; // end of MidexReport_Records function
