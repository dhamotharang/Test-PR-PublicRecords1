EXPORT validateBKNon_FCRA(__buildVersion, __isDev=true) := functionmacro
	
	import KeyValidation;
	
	dsName := 'Bankruptcy';
		////BDID Key
		bdidKeySummary := KeyValidation.validateKeysMacrov2( dsName, 'bdid','Search Key', 
																																			KeyValidation.BKMappings.bdidParentName, __buildVersion, 
																																			KeyValidation.BKParentFiles.eligibleBKSearch((unsigned6)bdid != 0), 
																																			KeyValidation.BKKeyFiles.bdidKey, 
																																			KeyValidation.BKMappings.bdidKeySet, KeyValidation.BKMappings.bdidParentSet, 
																																			KeyValidation.BKMappings.bdidIgnoredFields, 
																																			KeyValidation.BKMappings.bdidUniqueField, __isDev );
		////Case_number key
		caseNumberSummary := KeyValidation.validateKeysMacrov2( dsName, 'Case_Number', 'Search Key', 
																															KeyValidation.BKMappings.CaseNumberParentName, __buildVersion,
																															KeyValidation.BKParentFiles.BKMainForCaseNumber, 
																															KeyValidation.BKKeyFiles.caseNumberKey, 
																															KeyValidation.BKMappings.caseNumberKey, 
																															KeyValidation.BKMappings.caseNumberParent, 
																															KeyValidation.BKMappings.caseNumberIgnoredFields, 
																															KeyValidation.BKMappings.caseNumberUniqueField, __isDev);
		//////DID Key
		didKeySummary := KeyValidation.applyValidationJoins(dsName,'did','Search Key', 
																																		KeyValidation.BKMappings.DIDParentName, __buildVersion, 
																																		KeyValidation.BKParentFiles.bkSearchForDIDKey +
																																			KeyValidation.BKParentFiles.bkMainForDIDKey, 
																																		KeyValidation.BKKeyFiles.projectedDIDKey, 
																																		KeyValidation.BKMappings.DIDKey, 
																																		KeyValidation.BKMappings.DIDUniqueField, __isDev );		
		////Supp Key
		suppKeySummary :=  KeyValidation.validateKeysMacrov2( dsName,'Supp','Search Key', 
																												KeyValidation.BKMappings.SuppParentName, __buildVersion, 
																												KeyValidation.BKParentFiles.bkMainBase, 
																												KeyValidation.BKKeyFiles.suppKey, 
																												KeyValidation.BKMappings.SuppKey, 
																												KeyValidation.BKMappings.SuppParent, 
																												KeyValidation.BKMappings.SuppIgnoredFields, 
																												KeyValidation.BKMappings.SuppUniqueField, __isDev );
		////SSN Key		
		ssnKeySummary := KeyValidation.applyValidationJoins(dsName,'ssn','Search Key', 
																																		KeyValidation.BKMappings.SSNParentName, 
																																		__buildVersion, 
																																		(KeyValidation.BKParentFiles.bkSearchForSSNKey + 
																																				KeyValidation.BKParentFiles.bkMainForSSNKey)(ssn <> ''), 
																																		KeyValidation.BKKeyFiles.projectedSSNKey, 
																																		KeyValidation.BKMappings.SSNKey, 
																																		KeyValidation.BKMappings.SSNUniqueField , __isDev );																												

		////SSNMatch Key
		ssnMatchKeySummary := KeyValidation.validateKeysMacrov2( dsName,'ssnMatch','Search Key', 
																															KeyValidation.BKMappings.SSNMatchParentName, __buildVersion, 
																															KeyValidation.BKParentFiles.eligibleBKSearch(ssnmatch <> ''), 
																															KeyValidation.BKKeyFiles.ssnMatchKey, 
																															KeyValidation.BKMappings.SSNMatchKey, 
																															KeyValidation.BKMappings.SSNMatchParent, 
																															KeyValidation.BKMappings.SSNMatchIgnoredFields, 
																															KeyValidation.BKMappings.SSNMatchUniqueField, __isDev );
																														
	////Full Payload keys
		//Payload Autokey
		payloadAutoKeySummary := KeyValidation.validateKeysMacrov2(dsName, 'PayloadAK','Payload Key', 
																												KeyValidation.BKMappings.PayloadAKParentName, __buildVersion, 
																												KeyValidation.BKParentFiles.FlattenedBKSearchForPayloadAK, 
																												KeyValidation.BKKeyFiles.FlattenedPayloadAK, 
																												KeyValidation.BKMappings.PayloadAKKeySet, 
																												KeyValidation.BKMappings.PayloadAKParentSet, 
																												KeyValidation.BKMappings.PayloadAKignoredFields, 
																												KeyValidation.BKMappings.PayloadAKUniqueField, __isDev);
		//LinkIDSBKSearch Key
		linkidsKeySummary := KeyValidation.validateKeysMacrov2(dsName, 'Linkids','Payload Key', 
																												KeyValidation.BKMappings.LinkIDSBKSearchParentName, __buildVersion, 
																												KeyValidation.BKParentFiles.bkSearchForLinkidsKey, 
																												KeyValidation.BKKeyFiles.BKSearchLinkidsKey, 
																												KeyValidation.BKMappings.LinkIDSBKSearchKeySet, 
																												KeyValidation.BKMappings.LinkIDSBKSearchParentSet, 
																												KeyValidation.BKMappings.LinkIDSBKSearchIgnoredFields, 
																												KeyValidation.BKMappings.LinkIDSBKSearchUniqueField, __isDev);
																												

		//TMSID_linkids Key	
		tmsIDBKSearchKeySummary := KeyValidation.validateKeysMacrov2( dsName, 'tmsid_linkids', 'Payload Key', 
																																		KeyValidation.BKMappings.TMSIDBKSearchParentName, __buildVersion,
																																		KeyValidation.BKParentFiles.eligibleBKSearchBIP, 
																																		KeyValidation.BKKeyFiles.tmsIDKey, 
																																		KeyValidation.BKMappings.TMSIDBKSearchKey, 
																																		KeyValidation.BKMappings.TMSIDBKSearchParent,
																																		KeyValidation.BKMappings.TMSIDBKSearchIgnoredFields, 
																																		KeyValidation.BKMappings.TMSIDBKSearchUniqueField, __isDev);
																																		
		//TrusteeIDName Key
		 trusteeIDNameKeySummary := KeyValidation.validateKeysMacrov2(dsName, 'TrusteeIDName','Search Key', 
																												KeyValidation.BKMappings.TrusteeIDNameParentName, __buildVersion, 
																												KeyValidation.BKParentFiles.eligibleBKMain, 
																												KeyValidation.BKKeyFiles.trusteeIDNameKey, 
																												KeyValidation.BKMappings.TrusteeIDNameKeySet, 
																												KeyValidation.BKMappings.TrusteeIDNameParentSet, 
																												KeyValidation.BKMappings.TrusteeIDNameIgnoredFields, 
																												KeyValidation.BKMappings.TrusteeIDNameUniqueField, __isDev);
		//TMSID Key for BKMain
	tmsIDBKMainKeySummary := KeyValidation.validateKeysMacrov2(dsName, 'tmsid','PayloadKey', 
																												KeyValidation.BKMappings.TMSIDBKMainParentName, __buildVersion, 
																												KeyValidation.BKParentFiles.BKMainForTMSIDKey, 
																												KeyValidation.BKKeyFiles.tmsIDBKMainKey, 
																												KeyValidation.BKMappings.TMSIDBKMainKeySet, 
																												KeyValidation.BKMappings.TMSIDBKMainParentSet, 
																												KeyValidation.BKMappings.TMSIDBKMainIgnoredFields, 
																												KeyValidation.BKMappings.TMSIDBKMainUniqueField, __isDev);
																																		
	//Autokeys
		////autokeyValidationSummary holds the output summary
		 KeyValidation.validateAutoKeysForBK(KeyValidation.BKKeyFiles.normalizedPayloadAK, __buildVersion, 
																								autokeyValidationSummary, 
																								KeyValidation.BKKeyFiles.addressAutoKey, KeyValidation.BKKeyFiles.addressb2AutoKey, 
																								KeyValidation.BKKeyFiles.cityStNameAutoKey, KeyValidation.BKKeyFiles.cityStNameb2AutoKey, 
																								KeyValidation.BKKeyFiles.fein2AutoKey, KeyValidation.BKKeyFiles.nameAutoKey, 
																								KeyValidation.BKKeyFiles.nameWords2Autokey, KeyValidation.BKKeyFiles.phone2AutoKey, 
																								KeyValidation.BKKeyFiles.phoneb2AutoKey, KeyValidation.BKKeyFiles.ssn4nameAutokey, 
																								KeyValidation.BKKeyFiles.ssn2AutoKey, KeyValidation.BKKeyFiles.stNameAutoKey, 
																								KeyValidation.BKKeyFiles.stNameb2AutoKey, KeyValidation.BKKeyFiles.zipAutoKey, 
																								KeyValidation.BKKeyFiles.zipb2AutoKey, __isDev);

		 bkNonFCRAKeysSummary :=	autokeyValidationSummary + bdidKeySummary  + 
																		caseNumberSummary + didKeySummary + linkidsKeySummary + 
																		payloadAutoKeySummary + ssnKeySummary + 
																		suppKeySummary + ssnMatchKeySummary + tmsIDBKMainKeySummary +
																		tmsIDBKSearchKeySummary + trusteeIDNameKeySummary;
										
  return bkNonFCRAKeysSummary;
endmacro;