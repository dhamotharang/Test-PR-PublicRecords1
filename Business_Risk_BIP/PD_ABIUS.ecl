IMPORT BIPV2, Business_Risk_BIP, InfoUSA, MDR;

EXPORT PD_ABIUS(DATASET(Business_Risk_BIP.Layouts.Shell) LinkIDsFound, 
									DATASET(BIPV2.IDlayouts.l_xlink_ids2) kFetchLinkIDs, 
									STRING1 kFetchLinkSearchLevel, 
									BIPV2.mod_sources.iParams linkingOptions, 
									Business_Risk_BIP.LIB_Business_Shell_LIBIN options, 
									SET OF STRING2 AllowedSourcesSet) := FUNCTION

	// ---------------- ABIUS ------------------
	ABIUSRaw := InfoUSA.Key_ABIUS_LinkIds.kFetch2(kFetchLinkIDs,
																						 kFetchLinkSearchLevel,
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
	
	Business_Risk_BIP.Common.AppendSeq2(ABIUSRaw, LinkIDsFound, ABIUSSeq);
	
	ABIUS := Business_Risk_BIP.Common.FilterRecords(ABIUSSeq, date_added, process_date, MDR.SourceTools.src_INFOUSA_ABIUS_USABIZ, AllowedSourcesSet);
	
	RETURN(ABIUS);
END;