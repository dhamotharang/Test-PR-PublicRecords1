IMPORT AutoKeyI, AutoStandardI, iesp, BIPV2;

EXPORT IParam := MODULE
	
	EXPORT autokey_search := INTERFACE(AutoKeyI.AutoKeyStandardFetchBaseInterface)
		EXPORT BOOLEAN workHard := TRUE;
		EXPORT BOOLEAN noFail   := FALSE;
		EXPORT BOOLEAN isdeepDive := FALSE;
	END;
	
	EXPORT searchIds := INTERFACE(autokey_search)
		EXPORT STRING20  license_number := '';
		EXPORT STRING20  license_state := '';
		EXPORT STRING40  tin := '';
    EXPORT STRING26  midex_rpt_num := '';
    EXPORT STRING4   ssn_last4 :=  '';
    EXPORT STRING    DataPermissionMask := AutoStandardI.Constants.DataPermissionMask_default;
		EXPORT STRING40  nmls_id := '';
		EXPORT UNSIGNED8 dob_filter := 0;  // Used for penalization only
    EXPORT STRING8   StartLoadDate := '';
  END;
  
	EXPORT searchAlertOptions := INTERFACE
			EXPORT BOOLEAN   EnableAlert  := FALSE;
      EXPORT UNSIGNED1 AlertVersion := Midex_Services.Constants.AlertVersion.None;
			EXPORT DATASET   searchHashes := DATASET([], MIDEX_Services.Layouts.hash_layout);
			EXPORT BOOLEAN   ReturnAllRecords := FALSE;
	END;
	
	EXPORT searchrecords := INTERFACE(
    searchIds,
    AutoStandardI.LIBIN.PenaltyI_Indv.base,
    AutoStandardI.LIBIN.PenaltyI_Biz.base,
    AutoStandardI.InterfaceTranslator.glb_purpose.params,
    AutoStandardI.InterfaceTranslator.dppa_purpose.params,
    AutoStandardI.InterfaceTranslator.ssn_mask_value.params,
    AutoStandardI.InterfaceTranslator.dob_mask_value.params,
    AutoStandardI.InterfaceTranslator.application_type_val.params,
    AutoStandardI.InterfaceTranslator.penalt_threshold_value.params,
		searchAlertOptions)
	END;
	
	EXPORT reportAlertOptions := INTERFACE
			EXPORT BOOLEAN   EnableAlert                  := FALSE;
      EXPORT UNSIGNED1 AlertVersion                 := Midex_Services.Constants.AlertVersion.None;
      EXPORT BOOLEAN   TrackAll 										:= FALSE;
			EXPORT BOOLEAN   TrackName 									  := FALSE;
			EXPORT BOOLEAN   TrackAddress 								:= FALSE;
			EXPORT BOOLEAN   TrackIncident 							  := FALSE;
      EXPORT BOOLEAN   TrackLicenseStatus 					:= FALSE;
      EXPORT BOOLEAN   TrackLienJudgment 					  := FALSE;
      EXPORT BOOLEAN   TrackBankruptcy 						  := FALSE;
      EXPORT BOOLEAN   TrackCriminal 							  := FALSE;
			EXPORT BOOLEAN   TrackNMLSId 								  := FALSE;
      EXPORT BOOLEAN   TrackPhone 									:= FALSE;
      EXPORT BOOLEAN   TrackRepresent 							:= FALSE;
			EXPORT BOOLEAN   TrackRegistration 					  := FALSE;
			EXPORT BOOLEAN   TrackDisciplinary 					  := FALSE;
			EXPORT BOOLEAN   TrackEmail 									:= FALSE;
			EXPORT BOOLEAN   TrackProperty 							  := FALSE;
			EXPORT BOOLEAN   TrackBusinessAssociate 			:= FALSE;
			EXPORT BOOLEAN   TrackRelative 							  := FALSE;
			EXPORT BOOLEAN   TrackEmployer 							  := FALSE;
			EXPORT BOOLEAN   TrackNameVariation 					:= FALSE;
			EXPORT BOOLEAN   TrackExecutive 							:= FALSE;
			EXPORT BOOLEAN   TrackSecretaryOfStateFiling  := FALSE;
			EXPORT BOOLEAN   TrackAKAAndNameVariation 	  := FALSE;
      EXPORT STRING25  allHash 								  := '';
			EXPORT STRING25  nameHash 								:= '';
			EXPORT STRING25  addressHash 						  := '';
			EXPORT STRING25  phoneHash 							  := '';
			EXPORT STRING25  licenseStatHash 				  :='';
			EXPORT STRING25  incidentHash 						:= '';
      EXPORT STRING25  LienJudgmentHash			 	  := '';
      EXPORT STRING25  BankruptcyHash 					:= '';
      EXPORT STRING25  CriminalHash 						:= '';
      EXPORT STRING25  NMLSIdHash 							:= '';
      EXPORT STRING25  RepresentHash 					  := '';
			EXPORT STRING25  RegistrationHash 				:= '';
		  EXPORT STRING25  DisciplinaryHash 				:= '';
			EXPORT STRING25  EmailHash								:= '';
			EXPORT STRING25  PropertyHash						  := '';
			EXPORT STRING25  RelativeHash						  := '';
			EXPORT STRING25  BusAssociateHash				  := '';
			EXPORT STRING25  EmployerHash						  := '';
			EXPORT STRING25  NameVariationHash				:= '';
			EXPORT STRING25  ExecutiveHash						:= '';
			EXPORT STRING25  SOSHash									:= '';
			EXPORT STRING25  AKAAndNameVariationHash	:= '';
	END;
	
	EXPORT smartLinxPersonIncludeOptions := INTERFACE
		EXPORT BOOLEAN	IncludeRelatives 								:= FALSE;
		EXPORT BOOLEAN	IncludeSexualOffenses 					:= FALSE;
		EXPORT BOOLEAN	IncludePersonBusinessAssociates	:= FALSE;
		EXPORT BOOLEAN	IncludeCorporateAffiliations 		:= FALSE;
		EXPORT BOOLEAN	IncludeNoticeOfDefault 					:= FALSE;
		EXPORT BOOLEAN	IncludeForeclosures 						:= FALSE;
	END;
	
	EXPORT reportrecords := INTERFACE(
    AutoStandardI.InterfaceTranslator.glb_purpose.params,
    AutoStandardI.InterfaceTranslator.dppa_purpose.params,
    AutoStandardI.InterfaceTranslator.ssn_mask_value.params,
    AutoStandardI.InterfaceTranslator.dob_mask_value.params,
    AutoStandardI.InterfaceTranslator.application_type_val.params,
    AutoStandardI.InterfaceTranslator.penalt_threshold_value.params,
		AutoStandardI.InterfaceTranslator.did_value.params,
		AutoStandardI.InterfaceTranslator.bdid_value.params,
		reportAlertOptions,
		smartLinxPersonIncludeOptions)
    EXPORT DATASET  MidexReportNumbers := DATASET([], MIDEX_Services.Layouts.rec_midex_payloadKeyField) ;
		EXPORT DATASET  MariRidNumbers := DATASET([], MIDEX_Services.Layouts.rec_profLicMari_payloadKeyField) ;
    EXPORT BOOLEAN  includeSourceDocs := FALSE;
    EXPORT STRING1  searchType := 'I';
    EXPORT STRING   DataPermissionMask  := AutoStandardI.Constants.DataPermissionMask_default;
    EXPORT STRING   DataRestrictionMask := '11111111111111111111';
    EXPORT STRING8  StartLoadDate := '';
		EXPORT DATASET 	LinkIds								:= DATASET([], BIPV2.IDlayouts.l_xlink_ids);
		EXPORT STRING1  BusinessIDFetchLevel 	:= BIPV2.IDconstants.Fetch_Level_SELEID;
    EXPORT BOOLEAN  isLicenseOnlyReport := FALSE; // defaulting to false so other services (Midex Comp Report & 
                                                  // Relationship Identifier Report) calling the 
                                                  // MIDEX_Services.LicenseReport_Records attribute are not impacted
  END;

  
END;