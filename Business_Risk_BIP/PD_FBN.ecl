IMPORT BIPV2, Business_Risk_BIP, FBNv2, MDR;

EXPORT PD_FBN(DATASET(Business_Risk_BIP.Layouts.Shell) LinkIDsFound, 
									DATASET(BIPV2.IDlayouts.l_xlink_ids2) kFetchLinkIDs, 
									STRING1 kFetchLinkSearchLevel, 
									BIPV2.mod_sources.iParams linkingOptions, 
									Business_Risk_BIP.LIB_Business_Shell_LIBIN options, 
									SET OF STRING2 AllowedSourcesSet) := FUNCTION

	// ---------------- Ficticious Business Name ---------------------
	FBNRaw := FBNv2.Key_LinkIds.kFetch2(kFetchLinkIDs,
																						 kFetchLinkSearchLevel,
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
																							
	Business_Risk_BIP.Common.AppendSeq2(FBNRaw, LinkIDsFound, FBNSeq);
	
	// Filter out records after our history date
	FBN := Business_Risk_BIP.Common.FilterRecords(FBNSeq, dt_first_seen, dt_vendor_first_reported, MDR.SourceTools.src_FBNV2_BusReg, AllowedSourcesSet);
	
	RETURN(FBN);
END;