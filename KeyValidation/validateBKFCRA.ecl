EXPORT validateBKFCRA(__buildVersion, __isDev=true) := functionmacro
	
	import KeyValidation;
	
	dsName := 'Bankruptcy';
		////BDID Key
		bdidFCRAKeySummary := KeyValidation.validateKeysMacrov2( dsName, 'bdid_FCRA','Search Key', 
																																			KeyValidation.BKMappings.bdidParentName, __buildVersion, 
																																			KeyValidation.BKParentFiles.eligibleBKSearchFCRA((unsigned6)bdid != 0), 
																																			KeyValidation.BKKeyFiles.bdidFCRAKey, 
																																			KeyValidation.BKMappings.bdidKeySet, KeyValidation.BKMappings.bdidParentSet, 
																																			KeyValidation.BKMappings.bdidIgnoredFields, 
																																			KeyValidation.BKMappings.bdidUniqueField, __isDev );
																																			
		////Case_number key
		caseNumberFCRASummary := KeyValidation.validateKeysMacrov2( dsName, 'Case_Number_FCRA', 'Search Key', 
																															KeyValidation.BKMappings.CaseNumberParentName, __buildVersion,
																															KeyValidation.BKParentFiles.BKMainForCaseNumberFCRA, 
																															KeyValidation.BKKeyFiles.caseNumberFCRAKey, 
																															KeyValidation.BKMappings.caseNumberKey, 
																															KeyValidation.BKMappings.caseNumberParent, 
																															KeyValidation.BKMappings.caseNumberIgnoredFields, 
																															KeyValidation.BKMappings.caseNumberUniqueField, __isDev);


		//////DID Key
		didFCRAKeySummary := KeyValidation.applyValidationJoins(dsName,'did_FCRA','Search Key', 
																																		KeyValidation.BKMappings.DIDParentName, __buildVersion, 
																																		KeyValidation.BKParentFiles.bkSearchForDIDKeyFCRA +
																																			KeyValidation.BKParentFiles.bkMainForDIDKeyFCRA, 
																																		KeyValidation.BKKeyFiles.projectedDIDFCRAKey, 
																																		KeyValidation.BKMappings.DIDKey, 
																																		KeyValidation.BKMappings.DIDUniqueField, __isDev );	
																																		

  
	//////SSN4St Key
  ssn4StFCRAKeySummary :=  KeyValidation.validateKeysMacrov2( dsName,'ssn4st_FCRA','Search Key', 
																												KeyValidation.BKMappings.ssn4stParentName, __buildVersion, 
																												KeyValidation.BKParentFiles.BKSearchForSSN4StFCRA, 
																												KeyValidation.BKKeyFiles.ssn4stFCRAKey, 
																												KeyValidation.BKMappings.ssn4stKey, 
																												KeyValidation.BKMappings.ssn4stParent, 
																												KeyValidation.BKMappings.ssn4stIgnoredFields, 
																												KeyValidation.BKMappings.ssn4stUniqueField, __isDev );
											
		////Supp Key
		suppFCRAKeySummary :=  KeyValidation.validateKeysMacrov2( dsName,'Supp_FCRA','Search Key', 
																												KeyValidation.BKMappings.SuppParentName, __buildVersion, 
																												KeyValidation.BKParentFiles.bkMainBaseFCRA, 
																												KeyValidation.BKKeyFiles.suppFCRAKey, 
																												KeyValidation.BKMappings.SuppKey, 
																												KeyValidation.BKMappings.SuppParent, 
																												KeyValidation.BKMappings.SuppIgnoredFields, 
																												KeyValidation.BKMappings.SuppUniqueField, __isDev );
																									

																														
	////Full Payload keys
		//Payload Autokey
		payloadAutoKeyFCRASummary := KeyValidation.validateKeysMacrov2(dsName, 'PayloadAK_FCRA','Payload Key', 
																												KeyValidation.BKMappings.PayloadAKParentName, __buildVersion, 
																												KeyValidation.BKParentFiles.FlattenedBKSearchForPayloadAKFCRA, 
																												KeyValidation.BKKeyFiles.FlattenedPayloadAKFCRA, 
																												KeyValidation.BKMappings.PayloadAKKeySet, 
																												KeyValidation.BKMappings.PayloadAKParentSet, 
																												KeyValidation.BKMappings.PayloadAKignoredFields, 
																												KeyValidation.BKMappings.PayloadAKUniqueField, __isDev);

		//TMSID_linkids Key																	
   	tmsIDFCRABKSearchKeySummary := KeyValidation.validateKeysMacrov2( dsName, 'tmsid_linkids_FCRA', 'Payload Key', 
																																		KeyValidation.BKMappings.TMSIDBKSearchParentName, __buildVersion,
																																		KeyValidation.BKParentFiles.eligibleBKSearchBIPFCRA, 
																																		KeyValidation.BKKeyFiles.tmsIDFCRAKey, 
																																		KeyValidation.BKMappings.TMSIDBKSearchKey, 
																																		KeyValidation.BKMappings.TMSIDBKSearchParent,
																																		KeyValidation.BKMappings.TMSIDBKSearchIgnoredFields, 
																																		KeyValidation.BKMappings.TMSIDBKSearchUniqueField, __isDev);
																																		
		//TrusteeIDName Key
		trusteeIDNameFCRAKeySummary := KeyValidation.validateKeysMacrov2(dsName, 'TrusteeIDName_FCRA','Search Key', 
																												KeyValidation.BKMappings.TrusteeIDNameParentName, __buildVersion, 
																												KeyValidation.BKParentFiles.eligibleBKMainFCRA, 
																												KeyValidation.BKKeyFiles.trusteeIDNameFCRAKey, 
																												KeyValidation.BKMappings.TrusteeIDNameKeySet, 
																												KeyValidation.BKMappings.TrusteeIDNameParentSet, 
																												KeyValidation.BKMappings.TrusteeIDNameIgnoredFields, 
																												KeyValidation.BKMappings.TrusteeIDNameUniqueField, __isDev);
																																		
		//TMSID Key for BKMain
	tmsIDFCRABKMainKeySummary := KeyValidation.validateKeysMacrov2(dsName, 'tmsid_FCRA','PayloadKey', 
																												KeyValidation.BKMappings.TMSIDBKMainParentName, __buildVersion, 
																												KeyValidation.BKParentFiles.BKMainForTMSIDKeyFCRA, 
																												KeyValidation.BKKeyFiles.tmsIDBKMainFCRAKey, 
																												KeyValidation.BKMappings.TMSIDBKMainKeySet, 
																												KeyValidation.BKMappings.TMSIDBKMainParentSet, 
																												KeyValidation.BKMappings.TMSIDBKMainIgnoredFields, 
																												KeyValidation.BKMappings.TMSIDBKMainUniqueField, __isDev);
																																		
	//Autokeys
		////autokeyValidationSummary holds the output summary
		 KeyValidation.validateAutoKeysForBK_FCRA(KeyValidation.BKKeyFiles.normalizedPayloadAKFCRA, __buildVersion, 
																						FCRAautokeyValidationSummary, 
																						KeyValidation.BKKeyFiles.addressFCRAAutoKey, KeyValidation.BKKeyFiles.addressb2FCRAAutoKey, 
																						KeyValidation.BKKeyFiles.cityStNameFCRAAutoKey, KeyValidation.BKKeyFiles.cityStNameb2FCRAAutoKey, 
																						KeyValidation.BKKeyFiles.fein2FCRAAutoKey, KeyValidation.BKKeyFiles.nameFCRAAutoKey, 
																						KeyValidation.BKKeyFiles.nameWords2FCRAAutokey, KeyValidation.BKKeyFiles.phone2FCRAAutoKey, 
																						KeyValidation.BKKeyFiles.phoneb2FCRAAutoKey, KeyValidation.BKKeyFiles.ssn4nameFCRAAutokey, 
																						KeyValidation.BKKeyFiles.ssn2FCRAAutoKey, KeyValidation.BKKeyFiles.stNameFCRAAutoKey, 
																						KeyValidation.BKKeyFiles.stNameb2FCRAAutoKey, KeyValidation.BKKeyFiles.zipFCRAAutoKey, 
																						KeyValidation.BKKeyFiles.zipb2FCRAAutoKey, __isDev);
																						

		 bkFCRAKeysSummary := FCRAautokeyValidationSummary + bdidFCRAKeySummary  + 
																		caseNumberFCRASummary + didFCRAKeySummary + 
																		payloadAutoKeyFCRASummary + ssn4StFCRAKeySummary + 
																		suppFCRAKeySummary + tmsIDFCRABKMainKeySummary +
																		tmsIDFCRABKSearchKeySummary + trusteeIDNameFCRAKeySummary;
										
  return bkFCRAKeysSummary;
endmacro;