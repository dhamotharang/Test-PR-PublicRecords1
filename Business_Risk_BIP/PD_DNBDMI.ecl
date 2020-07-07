IMPORT BIPV2, Business_Risk_BIP, DNB_DMI, MDR;

EXPORT PD_DNBDMI(DATASET(Business_Risk_BIP.Layouts.Shell) LinkIDsFound, 
									DATASET(BIPV2.IDlayouts.l_xlink_ids2) kFetchLinkIDs, 
									STRING1 kFetchLinkSearchLevel, 
									BIPV2.mod_sources.iParams linkingOptions, 
									Business_Risk_BIP.LIB_Business_Shell_LIBIN options, 
									SET OF STRING2 AllowedSourcesSet) := FUNCTION

	// ---------------- DNB DMI - Dunn Bradstreet DMI ------------------
	DNBDMIRaw := IF(StringLib.StringFind(Options.AllowedSources, Business_Risk_BIP.Constants.AllowDNBDMI, 1) > 0, // Only grab DNB DMI data if it is explicitly passed in as allowed
									DNB_DMI.Key_LinkIds.kFetch2(kFetchLinkIDs, ,
																						 kFetchLinkSearchLevel,
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses));
	
	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq2(DNBDMIRaw, LinkIDsFound, DNBDMISeq);
	
	// Filter out records after our history date
	DNBDMI := Business_Risk_BIP.Common.FilterRecords(DNBDMISeq, date_first_seen, date_vendor_first_reported, MDR.SourceTools.src_Dunn_Bradstreet, AllowedSourcesSet);
	
	RETURN(DNBDMI);
END;