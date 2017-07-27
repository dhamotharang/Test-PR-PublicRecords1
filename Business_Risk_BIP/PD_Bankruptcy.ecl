IMPORT BIPV2, Business_Risk_BIP, BankruptcyV3, MDR;

EXPORT PD_Bankruptcy(DATASET(Business_Risk_BIP.Layouts.Shell) LinkIDsFound, 
									DATASET(BIPV2.IDlayouts.l_xlink_ids2) kFetchLinkIDs, 
									STRING1 kFetchLinkSearchLevel, 
									BIPV2.mod_sources.iParams linkingOptions, 
									Business_Risk_BIP.LIB_Business_Shell_LIBIN options, 
									SET OF STRING2 AllowedSourcesSet) := FUNCTION

	// --------------- Bankruptcy Data ----------------
	BankruptcyRaw := BankruptcyV3.Key_BankruptcyV3_LinkIDs.kFetch2(kFetchLinkIDs,
																						  kFetchLinkSearchLevel,
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq2(BankruptcyRaw, LinkIDsFound, BankruptcySeq);
	
	// Filter out records after our history date
	Bankruptcy := Business_Risk_BIP.Common.FilterRecords(BankruptcySeq, date_first_seen, date_vendor_first_reported, MDR.SourceTools.src_Bankruptcy, AllowedSourcesSet);
	
	RETURN(Bankruptcy);
END;