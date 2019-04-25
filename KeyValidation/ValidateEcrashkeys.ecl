EXPORT ValidateEcrashkeys(buildVersion, isDev=true ) := functionmacro
  

DatasetName := 'ECrash';	

// Key vin
	vinSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.ECrashMappings.vinParentName,
																																				KeyValidation.ECrashMappings.vinKeyType,
																																				KeyValidation.ECrashMappings.vinKeyName,
																																				buildVersion,
																																			  KeyValidation.ECrashParentFiles.ParentFile_Keyecrash_vin,
																																				KeyValidation.ECrashKeyFiles.Key_vin,
																																				KeyValidation.ECrashMappings.vinKeySet,
																																				KeyValidation.ECrashMappings.vinParentSet,
																																				KeyValidation.ECrashMappings.vinIgnoredFields ,
																																				KeyValidation.ECrashMappings.vinUniqueField , isdev);		
// key vin7
		vin7Summary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.ECrashMappings.vin7ParentName,
																																				KeyValidation.ECrashMappings.vin7KeyType,
																																				KeyValidation.ECrashMappings.vin7KeyName,
																																				buildVersion,
																																			  KeyValidation.ECrashParentFiles.ParentFile_Ecrash_vin7, 
																																				KeyValidation.ECrashKeyFiles.Key_vin7,
																																				KeyValidation.ECrashMappings.vin7KeySet,
																																				KeyValidation.ECrashMappings.vin7ParentSet,
																																				KeyValidation.ECrashMappings.vin7IgnoredFields ,
																																				KeyValidation.ECrashMappings.vin7UniqueField, isdev);


//key tagnbr
		tagnbrSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.ECrashMappings.tagnbrParentName,
																																				KeyValidation.ECrashMappings.tagnbrKeyType,
																																				KeyValidation.ECrashMappings.tagnbrKeyName,
																																				buildVersion,
																																			  KeyValidation.ECrashParentFiles.ParentFile_Keyecrash_tagnbr, 
																																				KeyValidation.ECrashKeyFiles.Key_tagnbr,
																																				KeyValidation.ECrashMappings.tagnbrKeySet,
																																				KeyValidation.ECrashMappings.tagnbrParentSet,
																																				KeyValidation.ECrashMappings.tagnbrIgnoredFields ,
																																				KeyValidation.ECrashMappings.tagnbrUniqueField, isdev);


// supplemental
		SupSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.ECrashMappings.SupParentName,
																																				KeyValidation.ECrashMappings.SupKeyType,
																																				KeyValidation.ECrashMappings.SupKeyName,
																																				buildVersion,
																																			  KeyValidation.ECrashParentFiles.ParentFile_Keyecrash_Supplemental, 
																																				KeyValidation.ECrashKeyFiles.Key_supplemental ,
																																				KeyValidation.ECrashMappings.SupKeySet,
																																				KeyValidation.ECrashMappings.SupParentSet,
																																				KeyValidation.ECrashMappings.SupIgnoredFields ,
																																				KeyValidation.ECrashMappings.SupUniqueField, isdev);



// standlocation
		standlocationSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.ECrashMappings.stdParentName,
																																				KeyValidation.ECrashMappings.stdKeyType,
																																				KeyValidation.ECrashMappings.stdKeyName,
																																				buildVersion,
																																			  KeyValidation.ECrashParentFiles.ParentFile_Keyecrash_StandLocation, 
																																				KeyValidation.ECrashKeyFiles.Key_standlocation,
																																				KeyValidation.ECrashMappings.stdKeySet,
																																				KeyValidation.ECrashMappings.stdParentSet,
																																				KeyValidation.ECrashMappings.stdIgnoredFields ,
																																				KeyValidation.ECrashMappings.stdUniqueField, isdev);




// reportlinkid
		reportlinkidSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.ECrashMappings.reportlinkidParentName,
																																				KeyValidation.ECrashMappings.reportlinkidKeyType,
																																				KeyValidation.ECrashMappings.reportlinkidKeyName,
																																				buildVersion,
																																			  KeyValidation.ECrashParentFiles.ParentFile_Keyecrash_ReportLink, 
																																				KeyValidation.ECrashKeyFiles.Key_reportlinkid,
																																				KeyValidation.ECrashMappings.reportlinkidKeySet,
																																				KeyValidation.ECrashMappings.reportlinkidParentSet,
																																				KeyValidation.ECrashMappings.reportlinkidIgnoredFields ,
																																				KeyValidation.ECrashMappings.reportlinkidUniqueField, isdev);
																																				
																																				
																																				
	// reportid
		reportidSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.ECrashMappings.report_idParentName,
																																				KeyValidation.ECrashMappings.report_idKeyType,
																																				KeyValidation.ECrashMappings.report_idKeyName,
																																				buildVersion,
																																			  KeyValidation.ECrashParentFiles.ParentFile_Keyecrash_Report_id, 
																																				KeyValidation.ECrashKeyFiles.Key_reportid,
																																				KeyValidation.ECrashMappings.report_idKeySet,
																																				KeyValidation.ECrashMappings.report_idParentSet,
																																				KeyValidation.ECrashMappings.report_idIgnoredFields ,
																																				KeyValidation.ECrashMappings.report_idUniqueField, isdev);
																																																																							
	// prefname_state
		prefname_stateSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.ECrashMappings.prefname_stateParentName,
																																				KeyValidation.ECrashMappings.prefname_stateKeyType,
																																				KeyValidation.ECrashMappings.prefname_stateKeyName,
																																				buildVersion,
																																			  KeyValidation.ECrashParentFiles.ParentFile_Keyecrash_prefname_state, 
																																				KeyValidation.ECrashKeyFiles.Key_prefname_state,
																																				KeyValidation.ECrashMappings.prefname_stateKeySet,
																																				KeyValidation.ECrashMappings.prefname_stateParentSet,
																																				KeyValidation.ECrashMappings.prefname_stateIgnoredFields ,
																																				KeyValidation.ECrashMappings.prefname_stateUniqueField, isdev);	
	
	// Photoid 
		PhotoidSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.ECrashMappings.Photoid_ParentName,
																																				KeyValidation.ECrashMappings.Photoid_KeyType,
																																				KeyValidation.ECrashMappings.Photoid_KeyName,
																																				buildVersion,
																																			  KeyValidation.ECrashParentFiles.ParentFile_Keyecrash_Photoid	, 
																																				KeyValidation.ECrashKeyFiles.Key_photoid,
																																				KeyValidation.ECrashMappings.Photoid_KeySet,
																																				KeyValidation.ECrashMappings.Photoid_ParentSet,
																																				KeyValidation.ECrashMappings.Photoid_IgnoredFields ,
																																				KeyValidation.ECrashMappings.Photoid_UniqueField, isdev);		

	// partial_report_nbr
		partial_report_nbrSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.ECrashMappings.partial_report_nbrParentName,
																																				KeyValidation.ECrashMappings.partial_report_nbrKeyType,
																																				KeyValidation.ECrashMappings.partial_report_nbrKeyName,
																																				buildVersion,
																																			  KeyValidation.ECrashParentFiles.ParentFile_Keyecrash_partnbr , 
																																				KeyValidation.ECrashKeyFiles.Key_partialaccnbr,
																																				KeyValidation.ECrashMappings.partial_report_nbrKeySet,
																																				KeyValidation.ECrashMappings.partial_report_nbrParentSet,
																																				KeyValidation.ECrashMappings.partial_report_nbrIgnoredFields ,
																																				KeyValidation.ECrashMappings.partial_report_nbrUniqueField, isdev);		

	// Linkids
		LinkidsSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.ECrashMappings.LinkidsParentName,
																																				KeyValidation.ECrashMappings.LinkidsKeyType,
																																				KeyValidation.ECrashMappings.LinkidsKeyName,
																																				buildVersion,
																																			  KeyValidation.ECrashParentFiles.ParentFile_Keyecrash_Linksid   , 
																																				KeyValidation.ECrashKeyFiles.Key_linkids,
																																				KeyValidation.ECrashMappings.LinkidsKeySet,
																																				KeyValidation.ECrashMappings.LinkidsParentSet,
																																				KeyValidation.ECrashMappings.LinkidsIgnoredFields ,
																																				KeyValidation.ECrashMappings.LinkidsUniqueField, isdev);		

	// Lastname_State
		Lastname_StateSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.ECrashMappings.Lastname_StateParentName,
																																				KeyValidation.ECrashMappings.Lastname_StateKeyType,
																																				KeyValidation.ECrashMappings.Lastname_StateKeyName,
																																				buildVersion,
																																			  KeyValidation.ECrashParentFiles.ParentFile_Keyecrash_LastName, 
																																				KeyValidation.ECrashKeyFiles.Key_lastname_state,
																																				KeyValidation.ECrashMappings.Lastname_StateKeySet,
																																				KeyValidation.ECrashMappings.Lastname_StateParentSet,
																																				KeyValidation.ECrashMappings.Lastname_StateIgnoredFields ,
																																				KeyValidation.ECrashMappings.Lastname_StateUniqueField, isdev);		

	// dol
		dolSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.ECrashMappings.dolParentName,
																																				KeyValidation.ECrashMappings.dolKeyType,
																																				KeyValidation.ECrashMappings.dolKeyName,
																																				buildVersion,
																																			  KeyValidation.ECrashParentFiles.ParentFile_Keyecrash_dol, 
																																				KeyValidation.ECrashKeyFiles.Key_dol,
																																				KeyValidation.ECrashMappings.dolKeySet,
																																				KeyValidation.ECrashMappings.dolParentSet,
																																				KeyValidation.ECrashMappings.dolIgnoredFields ,
																																				KeyValidation.ECrashMappings.dolUniqueField, isdev);		
																																				
	// DLNBR 
		DLNBRSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.ECrashMappings.DLNBRParentName,
																																				KeyValidation.ECrashMappings.DLNBRKeyType,
																																				KeyValidation.ECrashMappings.DLNBRKeyName,
																																				buildVersion,
																																			  KeyValidation.ECrashParentFiles.ParentFile_Keyecrash_DLNBR , 
																																				KeyValidation.ECrashKeyFiles.Key_DLNBR ,
																																				KeyValidation.ECrashMappings.DLNBRKeySet,
																																				KeyValidation.ECrashMappings.DLNBRParentSet,
																																				KeyValidation.ECrashMappings.DLNBRIgnoredFields ,
																																				KeyValidation.ECrashMappings.DLNBRUniqueField, isdev);


// did
		didSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.ECrashMappings.didParentName,
																																				KeyValidation.ECrashMappings.didKeyType,
																																				KeyValidation.ECrashMappings.didKeyName,
																																				buildVersion,
																																			  KeyValidation.ECrashParentFiles.ParentFile_Keyecrash_did, 
																																				KeyValidation.ECrashKeyFiles.Key_did,
																																				KeyValidation.ECrashMappings.didKeySet,
																																				KeyValidation.ECrashMappings.didParentSet,
																																				KeyValidation.ECrashMappings.didIgnoredFields ,
																																				KeyValidation.ECrashMappings.didUniqueField, isdev);

	// bdid
		// bdidSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				// KeyValidation.ECrashMappings.bdidParentName,
																																				// KeyValidation.ECrashMappings.bdidKeyType,
																																				// KeyValidation.ECrashMappings.bdidKeyName,
																																				// buildVersion,
																																			  // KeyValidation.ECrashParentFiles.ParentFile_Keyecrash_bdid, 
																																				// KeyValidation.ECrashKeyFiles.Key_bdid,
																																				// KeyValidation.ECrashMappings.bdidKeySet,
																																				// KeyValidation.ECrashMappings.bdidParentSet,
																																				// KeyValidation.ECrashMappings.bdidIgnoredFields ,
																																				// KeyValidation.ECrashMappings.bdidUniqueField, isdev);
																																				
		// agencyid_sentdate
		agencyid_sentdateSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.ECrashMappings.agencyid_sentdateParentName,
																																				KeyValidation.ECrashMappings.agencyid_sentdateKeyType,
																																				KeyValidation.ECrashMappings.agencyid_sentdateKeyName,
																																				buildVersion,
																																			  KeyValidation.ECrashParentFiles.ParentFile_Keyecrash_agencyid_sentdate, 
																																				KeyValidation.ECrashKeyFiles.Key_agencyid_sentdate,
																																				KeyValidation.ECrashMappings.agencyid_sentdateKeySet,
																																				KeyValidation.ECrashMappings.agencyid_sentdateParentSet,
																																				KeyValidation.ECrashMappings.agencyid_sentdateIgnoredFields ,
																																				KeyValidation.ECrashMappings.agencyid_sentdateUniqueField, isdev);
																																				
detailedsummary := vinSummary +vin7Summary +tagnbrsummary +Supsummary +standlocationSummary  + reportlinkidSummary + reportidSummary + 	prefname_stateSummary
										+ PhotoidSummary +partial_report_nbrSummary +Linkidssummary + Lastname_StateSummary + dolsummary + DLNBRsummary +didsummary //+ bdidsummary
										+ agencyid_sentdateSummary


						;
						
return detailedsummary;


ENDMACRO;