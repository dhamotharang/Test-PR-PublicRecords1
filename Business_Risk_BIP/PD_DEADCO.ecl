IMPORT BIPV2, Business_Risk_BIP, InfoUSA, MDR;

EXPORT PD_DEADCO(DATASET(Business_Risk_BIP.Layouts.Shell) LinkIDsFound, 
									DATASET(BIPV2.IDlayouts.l_xlink_ids2) kFetchLinkIDs, 
									STRING1 kFetchLinkSearchLevel, 
									BIPV2.mod_sources.iParams linkingOptions, 
									Business_Risk_BIP.LIB_Business_Shell_LIBIN options, 
									SET OF STRING2 AllowedSourcesSet) := FUNCTION

	// ---------------- DEADCO ------------------
	DEADCORaw := InfoUSA.Key_DEADCO_LinkIds.kFetch2(kFetchLinkIDs, ,
																						 kFetchLinkSearchLevel,
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
	
	Business_Risk_BIP.Common.AppendSeq2(DEADCORaw, LinkIDsFound, DEADCOSeq);
	
	DEADCO := Business_Risk_BIP.Common.FilterRecords(DEADCOSeq, dt_first_seen, dt_vendor_first_reported, MDR.SourceTools.src_INFOUSA_DEAD_COMPANIES, AllowedSourcesSet);
	
	RETURN(DEADCO);
END;