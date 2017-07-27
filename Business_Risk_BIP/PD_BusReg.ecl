IMPORT BIPV2, Business_Risk_BIP, BusReg, MDR;

EXPORT PD_BusReg(DATASET(Business_Risk_BIP.Layouts.Shell) LinkIDsFound, 
									DATASET(BIPV2.IDlayouts.l_xlink_ids2) kFetchLinkIDs, 
									STRING1 kFetchLinkSearchLevel, 
									BIPV2.mod_sources.iParams linkingOptions, 
									Business_Risk_BIP.LIB_Business_Shell_LIBIN options, 
									SET OF STRING2 AllowedSourcesSet) := FUNCTION

	// ---------------- BusReg - Business Registration ------------------
	BusRegRaw := BusReg.key_busreg_company_linkids.kFetch2(kFetchLinkIDs,
																						 kFetchLinkSearchLevel,
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
	
	Business_Risk_BIP.Common.AppendSeq2(BusRegRaw, LinkIDsFound, BusRegSeq);
	
	BusReg := Business_Risk_BIP.Common.FilterRecords(BusRegSeq, dt_first_seen, dt_vendor_first_reported, MDR.SourceTools.src_Business_Registration, AllowedSourcesSet);
	
	RETURN(BusReg);
END;