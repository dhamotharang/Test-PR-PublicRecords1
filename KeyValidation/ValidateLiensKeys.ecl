/*
Validating Liens keys using validateKeysMacrov2 function
*/
EXPORT ValidateLiensKeys(buildVersion, isDev) := FUNCTIONMACRO

IMPORT KeyValidation;

DatasetName := 'LiensV2Keys';	
NONFCRA := ':NONFCRA';
FCRA := ':FCRA';

	//Summary report for FCRA BDID key validation		
	searchBDIDFileLeinsSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.BDIDParentName + FCRA,KeyValidation.LSMappings.BDIDKeyType,
																																				 KeyValidation.LSMappings.BDIDKeyName,buildVersion,
																																			   KeyValidation.LSParentFiles.parentFileKeyBDID, KeyValidation.LSKeyFiles.keyFileBDID,
																																				 KeyValidation.LSMappings.BDIDKeySet,KeyValidation.LSMappings.BDIDParentSet,
																																				 KeyValidation.LSMappings.BDIDIgnoredFields,KeyValidation.LSMappings.BDIDUniqueField, isDev); 
	//Summary report for NON FCRA BDID key validation		
	searchBDIDNFFileLeinsSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.BDIDParentName + NONFCRA,KeyValidation.LSMappings.BDIDKeyType,
																																				 KeyValidation.LSMappings.BDIDKeyName,buildVersion,
																																			   KeyValidation.LSParentFiles.parentFileKeyBDIDNF, KeyValidation.LSKeyFiles.keyFileBDID_NF,
																																				 KeyValidation.LSMappings.BDIDKeySet,KeyValidation.LSMappings.BDIDParentSet,
																																				 KeyValidation.LSMappings.BDIDIgnoredFields,KeyValidation.LSMappings.BDIDUniqueField, isDev); 

	// Summary report for FCRA Case Number key validation		
	searchNFCaseNumberFileLeinsSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.CNParentName + FCRA,KeyValidation.LSMappings.CNKeyType,
																																				 KeyValidation.LSMappings.CNKeyName,buildVersion,
																																			   KeyValidation.LSParentFiles.parentFileKeyCaseNumberNF, KeyValidation.LSKeyFiles.keyFileCaseNumberNF,
																																				 KeyValidation.LSMappings.CNKeySet,KeyValidation.LSMappings.CNParentSet,
																																				 KeyValidation.LSMappings.CNIgnoredFields,KeyValidation.LSMappings.CNUniqueField, isDev); 
	// Summary report for NON FCRA Case Number key validation		
	searchCaseNumberFileLeinsSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.CNParentName + NONFCRA,KeyValidation.LSMappings.CNKeyType,
																																				 KeyValidation.LSMappings.CNKeyName,buildVersion,
																																			   KeyValidation.LSParentFiles.parentFileKeyCaseNumber, KeyValidation.LSKeyFiles.keyFileCaseNumber,
																																				 KeyValidation.LSMappings.CNKeySet,KeyValidation.LSMappings.CNParentSet,
																																				 KeyValidation.LSMappings.CNIgnoredFields,KeyValidation.LSMappings.CNUniqueField, isDev); 
	// Summary report for FCRA DID key validation		
	searchDIDFileLeinsSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.didParentName + FCRA,KeyValidation.LSMappings.didKeyType,
																																				 KeyValidation.LSMappings.didKeyName,buildVersion,
																																			   KeyValidation.LSParentFiles.parentFileKeyDID, KeyValidation.LSKeyFiles.keyFileDID,
																																				 KeyValidation.LSMappings.didKeySet,KeyValidation.LSMappings.didParentSet,
																																				 KeyValidation.LSMappings.didIgnoredFields,KeyValidation.LSMappings.didUniqueField, isDev); 
	// Summary report for NON FCRA DID key validation		
	searchNFDIDFileLeinsSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.didParentName + NONFCRA,KeyValidation.LSMappings.didKeyType,
																																				 KeyValidation.LSMappings.didKeyName,buildVersion,
																																			   KeyValidation.LSParentFiles.parentFileKeyDIDNF, KeyValidation.LSKeyFiles.keyFileDIDNF,
																																				 KeyValidation.LSMappings.didKeySet,KeyValidation.LSMappings.didParentSet,
																																				 KeyValidation.LSMappings.didIgnoredFields,KeyValidation.LSMappings.didUniqueField, isDev); 
	//Summary report for FCRA Filing key validation		
	searchFilingFileLeinsSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.FNParentName + FCRA,KeyValidation.LSMappings.FNKeyType,
																																				 KeyValidation.LSMappings.FNKeyName,buildVersion,
																																			   KeyValidation.LSParentFiles.parentFileKeyfiling, KeyValidation.LSKeyFiles.keyFileFiling,
																																				 KeyValidation.LSMappings.FNKeySet,KeyValidation.LSMappings.FNParentSet,
																																				 KeyValidation.LSMappings.FNIgnoredFields,KeyValidation.LSMappings.FNUniqueField, isDev); 
	//Summary report for NON FCRA Filing key validation		
	searchNFFilingFileLeinsSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.FNParentName + NONFCRA,KeyValidation.LSMappings.FNKeyType,
																																				 KeyValidation.LSMappings.FNKeyName,buildVersion,
																																			   KeyValidation.LSParentFiles.parentFileKeyfilingNF, KeyValidation.LSKeyFiles.keyFileFilingNF,
																																				 KeyValidation.LSMappings.FNKeySet,KeyValidation.LSMappings.FNParentSet,
																																				 KeyValidation.LSMappings.FNIgnoredFields,KeyValidation.LSMappings.FNUniqueField, isDev); 
	// Summary report for NON FCRA CTN key validation		
	searchNFCTNFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.CTNParentName + NONFCRA,KeyValidation.LSMappings.CTNKeyType,
																																				 KeyValidation.LSMappings.CTNKeyName,buildVersion,
																																			   KeyValidation.LSParentFiles.parentFileKeyCTNNF, KeyValidation.LSKeyFiles.keyFileCTNNF,
																																				 KeyValidation.LSMappings.CTNKeySet,KeyValidation.LSMappings.CTNParentSet,
																																				 KeyValidation.LSMappings.CTNIgnoredFields,KeyValidation.LSMappings.CTNUniqueField, isDev); 
	// Summary report for FCRA CTN key validation		
	searchCTNFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.CTNParentName + FCRA,KeyValidation.LSMappings.CTNKeyType,
																																				 KeyValidation.LSMappings.CTNKeyName,buildVersion,
																																			   KeyValidation.LSParentFiles.parentFileKeyCTN, KeyValidation.LSKeyFiles.keyFileCTN,
																																				 KeyValidation.LSMappings.CTNKeySet,KeyValidation.LSMappings.CTNParentSet,
																																				 KeyValidation.LSMappings.CTNIgnoredFields,KeyValidation.LSMappings.CTNUniqueField, isDev); 
	// Summary report for NON FCRA SN key validation		
	searchNFSNFileLiensSummaryNF := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.SNParentName + NONFCRA,KeyValidation.LSMappings.SNKeyType,
																																				 KeyValidation.LSMappings.SNKeyName,buildVersion,
																																			   KeyValidation.LSParentFiles.parentFileKeySNNF, KeyValidation.LSKeyFiles.keyFileSNNF,
																																				 KeyValidation.LSMappings.SNKeySet,KeyValidation.LSMappings.SNParentSet,
																																				 KeyValidation.LSMappings.SNIgnoredFields,KeyValidation.LSMappings.SNUniqueField, isDev); 
// Summary report for SN key validation		
	searchSNFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.SNParentName + NONFCRA,KeyValidation.LSMappings.SNKeyType,
																																				 KeyValidation.LSMappings.SNKeyName,buildVersion,
																																			   KeyValidation.LSParentFiles.parentFileKeySN, KeyValidation.LSKeyFiles.keyFileSN,
																																				 KeyValidation.LSMappings.SNKeySet,KeyValidation.LSMappings.SNParentSet,
																																				 KeyValidation.LSMappings.SNIgnoredFields,KeyValidation.LSMappings.SNUniqueField, isDev); 
	// Summary report for NON FCRA RMSID key validation		
	searchNFRMSIDFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.rmsidParentName + NONFCRA,KeyValidation.LSMappings.rmsidKeyType,
																																				 KeyValidation.LSMappings.rmsidKeyName,buildVersion,
																																			   KeyValidation.LSParentFiles.parentFileKeyRMSNF, KeyValidation.LSKeyFiles.keyFileRMSNF,
																																				 KeyValidation.LSMappings.rmsidKeySet,KeyValidation.LSMappings.rmsidParentSet,
																																				 KeyValidation.LSMappings.rmsidIgnoredFields,KeyValidation.LSMappings.rmsidUniqueField, isDev);
	// Summary report for FCRA RMSID key validation		
	searchRMSIDFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.rmsidParentName + FCRA,KeyValidation.LSMappings.rmsidKeyType,
																																				 KeyValidation.LSMappings.rmsidKeyName,buildVersion,
																																			   KeyValidation.LSParentFiles.parentFileKeyRMS, KeyValidation.LSKeyFiles.keyFileRMS,
																																				 KeyValidation.LSMappings.rmsidKeySet,KeyValidation.LSMappings.rmsidParentSet,
																																				 KeyValidation.LSMappings.rmsidIgnoredFields,KeyValidation.LSMappings.rmsidUniqueField, isDev);																																				  
	// Summary report for NON FCRA TMSID RMSID key validation		
	searchNFTRDFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.TRParentName + NONFCRA,KeyValidation.LSMappings.TRKeyType,
																																				 KeyValidation.LSMappings.TRKeyName,buildVersion,
																																			   KeyValidation.LSParentFiles.parentFileKeyTRSIDNF, KeyValidation.LSKeyFiles.keyFileTRDNF,
																																				 KeyValidation.LSMappings.TRKeySet,KeyValidation.LSMappings.TRParentSet,
																																				 KeyValidation.LSMappings.TRIgnoredFields,KeyValidation.LSMappings.TRUniqueField, isDev); 
	// Summary report for FCRA TMSID RMSID key validation		
	searchTRDFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.TRParentName + FCRA,KeyValidation.LSMappings.TRKeyType,
																																				 KeyValidation.LSMappings.TRKeyName,buildVersion,
																																			   KeyValidation.LSParentFiles.parentFileKeyTRSID, KeyValidation.LSKeyFiles.keyFileTRD,
																																				 KeyValidation.LSMappings.TRKeySet,KeyValidation.LSMappings.TRParentSet,
																																				 KeyValidation.LSMappings.TRIgnoredFields,KeyValidation.LSMappings.TRUniqueField, isDev); 																																				 
	//Summary report for NON FCRA SourceRecId key validation		
	searchSRIDFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.sridParentName + NONFCRA,KeyValidation.LSMappings.sridKeyType,
																																				 KeyValidation.LSMappings.sridKeyName,buildVersion,
																																			   KeyValidation.LSParentFiles.parentFileKeysrid, KeyValidation.LSKeyFiles.keyFilesrid,
																																				 KeyValidation.LSMappings.sridKeySet,KeyValidation.LSMappings.sridParentSet,
																																				 KeyValidation.LSMappings.sridIgnoredFields,KeyValidation.LSMappings.sridUniqueField, isDev); 

	//Summary report for NON FCRA TMSID RMSID LINKSID key validation		
	searchTRLFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.trlParentName + NONFCRA,KeyValidation.LSMappings.trlKeyType,
																																				 KeyValidation.LSMappings.trlKeyName,buildVersion,
																																			   KeyValidation.LSParentFiles.parentFileKeyTRL, KeyValidation.LSKeyFiles.keyFilesTRL,
																																				 KeyValidation.LSMappings.trlKeySet,KeyValidation.LSMappings.trlParentSet,
																																				 KeyValidation.LSMappings.trlIgnoredFields,KeyValidation.LSMappings.trlUniqueField, isDev); 

	//Summary report for NON FCRA TMSID RMSID Party key validation		
	searchNFTRPFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.trpParentName + NONFCRA,KeyValidation.LSMappings.trpKeyType,
																																				 KeyValidation.LSMappings.trpKeyName,buildVersion,
																																			   KeyValidation.LSParentFiles.parentFileKeyTRPNF, KeyValidation.LSKeyFiles.keyFilesTRPNF,
																																				 KeyValidation.LSMappings.trpKeySet,KeyValidation.LSMappings.trpParentSet,
																																				 KeyValidation.LSMappings.trpIgnoredFields,KeyValidation.LSMappings.trpUniqueField, isDev); 
	//Summary report for FCRA TMSID RMSID Party key validation		
	searchTRPFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.trpParentName + FCRA,KeyValidation.LSMappings.trpKeyType,
																																				 KeyValidation.LSMappings.trpKeyName,buildVersion,
																																			   KeyValidation.LSParentFiles.parentFileKeyTRP, KeyValidation.LSKeyFiles.keyFilesTRP,
																																				 KeyValidation.LSMappings.trpKeySet,KeyValidation.LSMappings.trpParentSet,
																																				 KeyValidation.LSMappings.trpIgnoredFields,KeyValidation.LSMappings.trpUniqueField, isDev); 
	//Summary report for NON-FCRA LinksID key validation		
	searchLinksIFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.linksidParentName + NONFCRA,KeyValidation.LSMappings.linksidKeyType,
																																				 KeyValidation.LSMappings.linksidKeyName,buildVersion,
																																			   KeyValidation.LSParentFiles.parentFileKeysrid, KeyValidation.LSKeyFiles.keyFilesLinksId,
																																				 KeyValidation.LSMappings.linksidKeySet,KeyValidation.LSMappings.linksidParentSet,
																																				 KeyValidation.LSMappings.linksidIgnoredFields,KeyValidation.LSMappings.linksidUniqueField, isDev); 
		//Summary report for NON-FCRA AK Zip key validation		
	searchAutokeyZipNFFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.ZipAKParentName + NONFCRA,KeyValidation.LSMappings.ZipAKKeyType,
																																				 KeyValidation.LSMappings.linksidKeyName,buildVersion,
																																			   KeyValidation.LSKeyFiles.keyFilesAutoKeyPayloadNFCRA, KeyValidation.LSKeyFiles.keyFile_AutoKeyZipNONFCRA,
																																				 KeyValidation.LSMappings.ZipAKKeySet,KeyValidation.LSMappings.ZipAKParentSet,
																																				 KeyValidation.LSMappings.ZipAKIgnoredFields,KeyValidation.LSMappings.ZipAKUniqueField, isDev); 
		//Summary report for FCRA AK Zip key validation																																						 
		searchAutokeyZipFFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.ZipAKParentName + FCRA,KeyValidation.LSMappings.ZipAKKeyType,
																																				 KeyValidation.LSMappings.linksidKeyName,buildVersion,
																																			   KeyValidation.LSKeyFiles.keyFilesAutoKeyPayloadFCRA, KeyValidation.LSKeyFiles.keyFile_AutoKeyZipFCRA,
																																				 KeyValidation.LSMappings.ZipAKKeySet,KeyValidation.LSMappings.ZipAKParentSet,
																																				 KeyValidation.LSMappings.ZipAKIgnoredFields,KeyValidation.LSMappings.ZipAKUniqueField, isDev); 
		//Summary report for FCRA AK Zipb2 key validation																																						 
		searchAutokeyZipb2FFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.Zipb2AKParentName + FCRA,KeyValidation.LSMappings.Zipb2AKKeyType,
																																				 KeyValidation.LSMappings.Zipb2AKKeyName,buildVersion,
																																			   KeyValidation.LSKeyFiles.keyFilesAutoKeyPayloadFCRA, KeyValidation.LSKeyFiles.keyFile_AutoKeyZipb2FCRA,
																																				 KeyValidation.LSMappings.Zipb2AKKeySet,KeyValidation.LSMappings.Zipb2AKParentSet,
																																				 KeyValidation.LSMappings.Zipb2AKIgnoredFields,KeyValidation.LSMappings.Zipb2AKUniqueField, isDev); 
		//Summary report for NON FCRA AK Zipb2 key validation																																						 
		searchAutokeyZipb2NFFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.Zipb2AKParentName + NONFCRA,KeyValidation.LSMappings.Zipb2AKKeyType,
																																				 KeyValidation.LSMappings.Zipb2AKKeyName,buildVersion,
																																			   KeyValidation.LSKeyFiles.keyFilesAutoKeyPayloadNFCRA, 
																																				 KeyValidation.LSKeyFiles.keyFile_AutoKeyZipb2NONFCRA,
																																				 KeyValidation.LSMappings.Zipb2AKKeySet,KeyValidation.LSMappings.Zipb2AKParentSet,
																																				 KeyValidation.LSMappings.Zipb2AKIgnoredFields,KeyValidation.LSMappings.Zipb2AKUniqueField, isDev); 																																	 
		//Summary report for NON FCRA AK Stname key validation																																						 
		searchAutokeyStNameNFFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.StNameAKParentName + NONFCRA,KeyValidation.LSMappings.StNameAKKeyType,
																																				 KeyValidation.LSMappings.StNameAKKeyName,buildVersion,
																																			   KeyValidation.LSKeyFiles.keyFilesAutoKeyPayloadNFCRA, 
																																				 KeyValidation.LSKeyFiles.keyFile_AutoKeyStnameNONFCRA,
																																				 KeyValidation.LSMappings.StNameAKKeySet,KeyValidation.LSMappings.StNameAKParentSet,
																																				 KeyValidation.LSMappings.StNameAKIgnoredFields,KeyValidation.LSMappings.StNameAKUniqueField, isDev); 																																	 
		//Summary report for FCRA AK Stname key validation																																						 
		searchAutokeyStNameFFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.StNameAKParentName + FCRA,KeyValidation.LSMappings.StNameAKKeyType,
																																				 KeyValidation.LSMappings.StNameAKKeyName,buildVersion,
																																			   KeyValidation.LSKeyFiles.keyFilesAutoKeyPayloadFCRA, KeyValidation.LSKeyFiles.keyFile_AutoKeyStnameFCRA,
																																				 KeyValidation.LSMappings.StNameAKKeySet,KeyValidation.LSMappings.StNameAKParentSet,
																																				 KeyValidation.LSMappings.StNameAKIgnoredFields,KeyValidation.LSMappings.StNameAKUniqueField, isDev); 
		//Summary report for NON FCRA AK Stnameb2 key validation																																						 
		searchAutokeyStNameb2NFFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.StNameb2AKParentName + NONFCRA,KeyValidation.LSMappings.StNameb2AKKeyType,
																																				 KeyValidation.LSMappings.StNameb2AKKeyName,buildVersion,
																																			   KeyValidation.LSKeyFiles.keyFilesAutoKeyPayloadNFCRA, 
																																				 KeyValidation.LSKeyFiles.keyFile_AutoKeyStnameb2NONFCRA,
																																				 KeyValidation.LSMappings.StNameb2AKKeySet,KeyValidation.LSMappings.StNameb2AKParentSet,
																																				 KeyValidation.LSMappings.StNameb2AKIgnoredFields,KeyValidation.LSMappings.StNameb2AKUniqueField, isDev); 																																	 
		//Summary report for FCRA AK Stnameb2 key validation																																						 
		searchAutokeyStNameb2FFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.StNameb2AKParentName + FCRA,KeyValidation.LSMappings.StNameb2AKKeyType,
																																				 KeyValidation.LSMappings.StNameb2AKKeyName,buildVersion,
																																			   KeyValidation.LSKeyFiles.keyFilesAutoKeyPayloadFCRA, KeyValidation.LSKeyFiles.keyFile_AutoKeyStnameb2FCRA,
																																				 KeyValidation.LSMappings.StNameb2AKKeySet,KeyValidation.LSMappings.StNameb2AKParentSet,
 																																				 KeyValidation.LSMappings.StNameb2AKIgnoredFields,KeyValidation.LSMappings.StNameb2AKUniqueField, isDev); 
    //Summary report for NON FCRA AK SSN2 key validation																																						 
		searchAutokeySSN2NFFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.SSN2AKParentName + NONFCRA,KeyValidation.LSMappings.SSN2AKKeyType,
																																				 KeyValidation.LSMappings.SSN2AKKeyName,buildVersion,
																																			   KeyValidation.LSKeyFiles.keyFilesAutoKeyPayloadNFCRA, 
																																				 KeyValidation.LSKeyFiles.keyFile_AutoKeySSN2NONFCRA,
																																				 KeyValidation.LSMappings.SSN2AKKeySet,KeyValidation.LSMappings.SSN2AKParentSet,
																																				 KeyValidation.LSMappings.SSN2AKIgnoredFields,KeyValidation.LSMappings.SSN2AKUniqueField, isDev); 																																	 
		//Summary report for FCRA AK SSN2 key validation																																						 
		searchAutokeySSN2FFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.SSN2AKParentName + FCRA,KeyValidation.LSMappings.SSN2AKKeyType,
																																				 KeyValidation.LSMappings.SSN2AKKeyName,buildVersion,
																																			   KeyValidation.LSKeyFiles.keyFilesAutoKeyPayloadFCRA, KeyValidation.LSKeyFiles.keyFile_AutoKeySSN2FCRA,
																																				 KeyValidation.LSMappings.SSN2AKKeySet,KeyValidation.LSMappings.SSN2AKParentSet,
																																				 KeyValidation.LSMappings.SSN2AKIgnoredFields,KeyValidation.LSMappings.SSN2AKUniqueField, isDev); 
    //Summary report for NON FCRA AK Address key validation																																						 
		searchAutokeyAddressNFFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.AddressAKParentName + NONFCRA,KeyValidation.LSMappings.AddressAKKeyType,
																																				 KeyValidation.LSMappings.AddressAKKeyName,buildVersion,
																																			   KeyValidation.LSKeyFiles.keyFilesAutoKeyPayloadNFCRA, 
																																				 KeyValidation.LSKeyFiles.keyFile_AutoKeyaddressNONFCRA,
																																				 KeyValidation.LSMappings.AddressAKKeySet,KeyValidation.LSMappings.AddressAKParentSet,
																																				 KeyValidation.LSMappings.AddressAKIgnoredFields,KeyValidation.LSMappings.AddressAKUniqueField, isDev); 																																	 
		//Summary report for FCRA AK Address key validation																																						 
		searchAutokeyaddressFFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.AddressAKParentName + FCRA,KeyValidation.LSMappings.AddressAKKeyType,
																																				 KeyValidation.LSMappings.AddressAKKeyName,buildVersion,
																																			   KeyValidation.LSKeyFiles.keyFilesAutoKeyPayloadFCRA, KeyValidation.LSKeyFiles.keyFile_AutoKeyaddressFCRA,
																																				 KeyValidation.LSMappings.AddressAKKeySet,KeyValidation.LSMappings.AddressAKParentSet,
																																				 KeyValidation.LSMappings.AddressAKIgnoredFields,KeyValidation.LSMappings.AddressAKUniqueField, isDev); 
    //Summary report for NON FCRA AK Addressb2 key validation																																						 
		searchAutokeyaddressb2NFFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.Addressb2AKParentName + NONFCRA,KeyValidation.LSMappings.Addressb2AKKeyType,
																																				 KeyValidation.LSMappings.Addressb2AKKeyName,buildVersion,
																																			   KeyValidation.LSKeyFiles.keyFilesAutoKeyPayloadNFCRA, 
																																				 KeyValidation.LSKeyFiles.keyFile_AutoKeyaddressb2NONFCRA,
																																				 KeyValidation.LSMappings.Addressb2AKKeySet,KeyValidation.LSMappings.Addressb2AKParentSet,
																																				 KeyValidation.LSMappings.Addressb2AKIgnoredFields,KeyValidation.LSMappings.Addressb2AKUniqueField, isDev); 																																	 
		//Summary report for FCRA AK Addressb2 key validation																																						 
		searchAutokeyaddressb2FFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.Addressb2AKParentName + FCRA,KeyValidation.LSMappings.Addressb2AKKeyType,
																																				 KeyValidation.LSMappings.Addressb2AKKeyName,buildVersion,
																																			   KeyValidation.LSKeyFiles.keyFilesAutoKeyPayloadFCRA, KeyValidation.LSKeyFiles.keyFile_AutoKeyaddressb2FCRA,
																																				 KeyValidation.LSMappings.Addressb2AKKeySet,KeyValidation.LSMappings.Addressb2AKParentSet,
																																				 KeyValidation.LSMappings.Addressb2AKIgnoredFields,KeyValidation.LSMappings.Addressb2AKUniqueField, isDev); 

		//Summary report for FCRA AK Fein2 key validation																																						 
		 searchAutokeyfein2FFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.FEIN2AKParentName + FCRA,KeyValidation.LSMappings.Fein2AKKeyType,
																																				 KeyValidation.LSMappings.Fein2AKKeyName,buildVersion,
																																			   KeyValidation.LSKeyFiles.keyFilesAutoKeyPayloadFCRA, KeyValidation.LSKeyFiles.keyFile_AutoKeyfeins2FCRA,
																																				 KeyValidation.LSMappings.FEIN2AKKeySet,KeyValidation.LSMappings.FEIN2AKParentSet,
																																				 KeyValidation.LSMappings.FEIN2AKIgnoredFields,KeyValidation.LSMappings.FEIN2AKUniqueField, isDev); 

    //Summary report for NON FCRA AK Fein2 key validation																																						 
		 searchAutokeyfein2NFFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.FEIN2AKParentName + NONFCRA,KeyValidation.LSMappings.Fein2AKKeyType,
																																				 KeyValidation.LSMappings.Fein2AKKeyName,buildVersion,
																																			   KeyValidation.LSKeyFiles.keyFilesAutoKeyPayloadNFCRA, 
																																				 KeyValidation.LSKeyFiles.keyFile_AutoKeyfeins2NONFCRA,
																																				 KeyValidation.LSMappings.FEIN2AKKeySet,KeyValidation.LSMappings.FEIN2AKParentSet,
																																				 KeyValidation.LSMappings.FEIN2AKIgnoredFields,KeyValidation.LSMappings.FEIN2AKUniqueField, isDev); 																																	 
		//Summary report for FCRA AK name key validation																																						 
		 searchAutokeyNameFFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.NameAKParentName + FCRA,KeyValidation.LSMappings.NameAKKeyType,
																																				 KeyValidation.LSMappings.NameAKKeyName,buildVersion,
																																			   KeyValidation.LSKeyFiles.keyFilesAutoKeyPayloadFCRA, KeyValidation.LSKeyFiles.keyFile_AutoKeynmeFCRA,
																																				 KeyValidation.LSMappings.NameAKKeySet,KeyValidation.LSMappings.NameAKParentSet,
																																				 KeyValidation.LSMappings.NameAKIgnoredFields,KeyValidation.LSMappings.NameAKUniqueField, isDev); 

    //Summary report for NON FCRA AK name key validation																																						 
		 searchAutokeyNameNFFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.NameAKParentName + NONFCRA,KeyValidation.LSMappings.NameAKKeyType,
																																				 KeyValidation.LSMappings.NameAKKeyName,buildVersion,
																																			   KeyValidation.LSKeyFiles.keyFilesAutoKeyPayloadNFCRA, 
																																				 KeyValidation.LSKeyFiles.keyFile_AutoKeynmeNONFCRA,
																																				 KeyValidation.LSMappings.NameAKKeySet,KeyValidation.LSMappings.NameAKParentSet,
																																				 KeyValidation.LSMappings.NameAKIgnoredFields,KeyValidation.LSMappings.NameAKUniqueField, isDev); 																																	 
		//Summary report for FCRA AK namewords2 key validation																																						 
		 searchAutokeynw2FFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.NameWords2AKParentName + FCRA,KeyValidation.LSMappings.Namewords2AKKeyType,
																																				 KeyValidation.LSMappings.Namewords2AKKeyName,buildVersion,
																																			   KeyValidation.LSKeyFiles.keyFilesAutoKeyPayloadFCRA, KeyValidation.LSKeyFiles.keyFile_AutoKeynamewords2FCRA,
																																				 KeyValidation.LSMappings.NameWords2AKKeySet,KeyValidation.LSMappings.NameWords2AKParentSet,
																																				 KeyValidation.LSMappings.NameWords2AKIgnoredFields,KeyValidation.LSMappings.NameWords2AKUniqueField, isDev); 

    //Summary report for NON FCRA AK namewords2 key validation																																						 
		 searchAutokeynw2NFFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.NameWords2AKParentName + NONFCRA,KeyValidation.LSMappings.Namewords2AKKeyType,
																																				 KeyValidation.LSMappings.Namewords2AKKeyName,buildVersion,
																																			   KeyValidation.LSKeyFiles.keyFilesAutoKeyPayloadNFCRA, 
																																				 KeyValidation.LSKeyFiles.keyFile_AutoKeynamewords2NONFCRA,
																																				 KeyValidation.LSMappings.NameWords2AKKeySet,KeyValidation.LSMappings.NameWords2AKParentSet,
																																				 KeyValidation.LSMappings.NameWords2AKIgnoredFields,KeyValidation.LSMappings.NameWords2AKUniqueField, isDev); 																																	 
		//Summary report for FCRA AK citystatename key validation																																						 
		 searchAutokeycitystatenameFFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.CityStNameAKParentName + FCRA,KeyValidation.LSMappings.CityStnameAKKeyType,
																																				 KeyValidation.LSMappings.CityStNameAKKeyName,buildVersion,
																																			   KeyValidation.LSKeyFiles.keyFilesAutoKeyPayloadFCRA, KeyValidation.LSKeyFiles.keyFile_AutoKeycitystnameFCRA,
																																				 KeyValidation.LSMappings.CityStNameAKKeySet,KeyValidation.LSMappings.CityStNameAKParentSet,
																																				 KeyValidation.LSMappings.CityStNameAKIgnoredFields,KeyValidation.LSMappings.CityStNameAKUniqueField, isDev); 

    //Summary report for NON FCRA AK citystatename key validation																																						 
		 searchAutokeycitystatenameNFFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.CityStNameAKParentName + NONFCRA,KeyValidation.LSMappings.CityStnameAKKeyType,
																																				 KeyValidation.LSMappings.CityStNameAKKeyName,buildVersion,
																																			   KeyValidation.LSKeyFiles.keyFilesAutoKeyPayloadNFCRA, 
																																				 KeyValidation.LSKeyFiles.keyFile_AutoKeycitystatenameNONFCRA,
																																				 KeyValidation.LSMappings.CityStNameAKKeySet,KeyValidation.LSMappings.CityStNameAKParentSet,
																																				 KeyValidation.LSMappings.CityStNameAKIgnoredFields,KeyValidation.LSMappings.CityStNameAKUniqueField, isDev); 																																	 
		//Summary report for FCRA AK citystatename2 key validation																																						 
		 searchAutokeycitystatename2FFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.CityStNameb2AKParentName + FCRA,KeyValidation.LSMappings.CityStname2AKKeyType,
																																				 KeyValidation.LSMappings.CityStName2AKKeyName,buildVersion,
																																			   KeyValidation.LSKeyFiles.keyFilesAutoKeyPayloadFCRA, KeyValidation.LSKeyFiles.keyFile_AutoKeycitystnameb2FCRA,
																																				 KeyValidation.LSMappings.CityStNameb2AKKeySet,KeyValidation.LSMappings.CityStNameb2AKParentSet,
																																				 KeyValidation.LSMappings.CityStNameb2AKIgnoredFields,KeyValidation.LSMappings.CityStNameb2AKUniqueField, isDev); 

    //Summary report for NON FCRA AK citystatename2 key validation																																						 
		 searchAutokeycitystatename2NFFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.CityStNameb2AKParentName + NONFCRA,KeyValidation.LSMappings.CityStname2AKKeyType,
																																				 KeyValidation.LSMappings.CityStName2AKKeyName,buildVersion,
																																			   KeyValidation.LSKeyFiles.keyFilesAutoKeyPayloadNFCRA, 
																																				 KeyValidation.LSKeyFiles.keyFile_AutoKeycitystatenameb2NONFCRA,
																																				 KeyValidation.LSMappings.CityStNameb2AKKeySet,KeyValidation.LSMappings.CityStNameb2AKParentSet,
																																				 KeyValidation.LSMappings.CityStNameb2AKIgnoredFields,KeyValidation.LSMappings.CityStNameb2AKUniqueField, isDev); 																																	 
		// Summary report for FCRA AK nameb2 key validation																																						 
		 // searchAutokeynameb2FFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.Nameb2AKParentName + FCRA,KeyValidation.LSMappings.Nameb2AKKeyType,
																																				 // KeyValidation.LSMappings.Nameb2AKKeyName,buildVersion,
																																			   // KeyValidation.LSKeyFiles.keyFilesAutoKeyPayloadFCRA, KeyValidation.LSKeyFiles.keyFile_AutoKeynmeb2FCRA,
																																				 // KeyValidation.LSMappings.Nameb2AKKeySet,KeyValidation.LSMappings.Nameb2AKParentSet,
																																				 // KeyValidation.LSMappings.Nameb2AKIgnoredFields,KeyValidation.LSMappings.Nameb2AKUniqueField, isDev); 

    // Summary report for NON FCRA AK nameb2 key validation																																						 
		 // searchAutokeynameb2NFFileLiensSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.LSMappings.Nameb2AKParentName + NONFCRA,KeyValidation.LSMappings.Nameb2AKKeyType,
																																				 // KeyValidation.LSMappings.Nameb2AKKeyName,buildVersion,
																																			   // KeyValidation.LSKeyFiles.keyFilesAutoKeyPayloadNFCRA, 
																																				 // KeyValidation.LSKeyFiles.keyFile_AutoKeynmeb2NONFCRA,
																																				 // KeyValidation.LSMappings.Nameb2AKKeySet,KeyValidation.LSMappings.Nameb2AKParentSet,
																																				 // KeyValidation.LSMappings.Nameb2AKIgnoredFields,KeyValidation.LSMappings.Nameb2AKUniqueField, isDev); 																																	 

completesummaryLiens :=  searchBDIDFileLeinsSummary + searchBDIDNFFileLeinsSummary + searchCaseNumberFileLeinsSummary + searchNFCaseNumberFileLeinsSummary +
												 searchDIDFileLeinsSummary + searchNFDIDFileLeinsSummary + searchFilingFileLeinsSummary + searchNFFilingFileLeinsSummary + 
												 searchCTNFileLiensSummary + searchNFCTNFileLiensSummary + searchSNFileLiensSummary + searchNFSNFileLiensSummaryNF + searchNFRMSIDFileLiensSummary +
												 searchRMSIDFileLiensSummary + searchNFTRDFileLiensSummary + searchTRDFileLiensSummary + searchSRIDFileLiensSummary + searchTRLFileLiensSummary + 
												 searchNFTRPFileLiensSummary + searchTRPFileLiensSummary + searchLinksIFileLiensSummary + searchAutokeyZipNFFileLiensSummary + 
												 searchAutokeyZipFFileLiensSummary + searchAutokeyZipb2FFileLiensSummary + searchAutokeyZipb2NFFileLiensSummary + searchAutokeyStNameFFileLiensSummary +
												 searchAutokeyStNameNFFileLiensSummary + searchAutokeyStNameb2FFileLiensSummary + searchAutokeyStNameb2NFFileLiensSummary +
												 searchAutokeySSN2FFileLiensSummary + searchAutokeySSN2NFFileLiensSummary + searchAutokeyAddressFFileLiensSummary + searchAutokeyaddressNFFileLiensSummary +
												 searchAutokeyaddressb2FFileLiensSummary + searchAutokeyaddressb2NFFileLiensSummary + searchAutokeyfein2NFFileLiensSummary + searchAutokeyfein2FFileLiensSummary +
												 searchAutokeyNameFFileLiensSummary + searchAutokeyNameNFFileLiensSummary + searchAutokeynw2FFileLiensSummary + searchAutokeynw2NFFileLiensSummary +
												 searchAutokeycitystatenameFFileLiensSummary + searchAutokeycitystatenameNFFileLiensSummary + searchAutokeycitystatename2FFileLiensSummary +
												 searchAutokeycitystatename2NFFileLiensSummary;// + searchAutokeynameb2FFileLiensSummary + searchAutokeynameb2NFFileLiensSummary;

RETURN completesummaryLiens;

ENDMACRO;