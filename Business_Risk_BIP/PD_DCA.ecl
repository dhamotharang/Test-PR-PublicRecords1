IMPORT BIPV2, Business_Risk_BIP, DCAV2, MDR;

EXPORT PD_DCA(DATASET(Business_Risk_BIP.Layouts.Shell) LinkIDsFound, 
									DATASET(BIPV2.IDlayouts.l_xlink_ids2) kFetchLinkIDs, 
									STRING1 kFetchLinkSearchLevel, 
									BIPV2.mod_sources.iParams linkingOptions, 
									Business_Risk_BIP.LIB_Business_Shell_LIBIN options, 
									SET OF STRING2 AllowedSourcesSet) := FUNCTION

	// ---------------- DCA - Directory of Corporate Affiliations AKA LNCA ------------------
	DCARaw := DCAV2.Key_LinkIds.kFetch2(kFetchLinkIDs, ,
																						 kFetchLinkSearchLevel,
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
	
	Business_Risk_BIP.Common.AppendSeq2(DCARaw, LinkIDsFound, DCASeq);
	
	DCA := Business_Risk_BIP.Common.FilterRecords(DCASeq, date_first_seen, date_vendor_first_reported, MDR.SourceTools.src_DCA, AllowedSourcesSet);
	
	RETURN(DCA);
END;