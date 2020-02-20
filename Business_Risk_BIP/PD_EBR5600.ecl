IMPORT BIPV2, Business_Risk_BIP, EBR, MDR;

EXPORT PD_EBR5600(DATASET(Business_Risk_BIP.Layouts.Shell) LinkIDsFound, 
									DATASET(BIPV2.IDlayouts.l_xlink_ids2) kFetchLinkIDs, 
									STRING1 kFetchLinkSearchLevel, 
									BIPV2.mod_sources.iParams linkingOptions, 
									Business_Risk_BIP.LIB_Business_Shell_LIBIN options, 
									SET OF STRING2 AllowedSourcesSet) := FUNCTION

	// ---------------- EBR - Experian Business Records ------------------
	EBR5600Raw := EBR.Key_5600_Demographic_Data_linkids.kFetch2(kFetchLinkIDs, ,
																						  kFetchLinkSearchLevel,
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							linkingOptions,
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses
																							);
	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq2(EBR5600Raw, LinkIDsFound, EBR5600Seq);
	
	// Filter out records after our history date
	EBR5600 := Business_Risk_BIP.Common.FilterRecords(EBR5600Seq, date_first_seen, (UNSIGNED)Business_Risk_BIP.Constants.MissingDate, MDR.SourceTools.src_EBR, AllowedSourcesSet);
	
	RETURN(EBR5600);
END;