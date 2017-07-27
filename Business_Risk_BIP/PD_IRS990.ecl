IMPORT BIPV2, Business_Risk_BIP, GovData, MDR;

EXPORT PD_IRS990(DATASET(Business_Risk_BIP.Layouts.Shell) LinkIDsFound, 
									DATASET(BIPV2.IDlayouts.l_xlink_ids2) kFetchLinkIDs, 
									STRING1 kFetchLinkSearchLevel, 
									BIPV2.mod_sources.iParams linkingOptions, 
									Business_Risk_BIP.LIB_Business_Shell_LIBIN options, 
									SET OF STRING2 AllowedSourcesSet) := FUNCTION

	// ---------------- IRS 990/IRS Non-Profit ------------------------
	IRS990Raw := GovData.key_IRS_NonProfit_linkIDs.kFetch2(kFetchLinkIDs,
																						 kFetchLinkSearchLevel,
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
																							
	Business_Risk_BIP.Common.AppendSeq2(IRS990Raw, LinkIDsFound, IRS990Seq);
	
	// Filter out records after our history date
	IRS990 := Business_Risk_BIP.Common.FilterRecords(IRS990Seq, process_date, (UNSIGNED)Business_Risk_BIP.Constants.MissingDate, MDR.SourceTools.src_IRS_Non_Profit, AllowedSourcesSet);
	
	RETURN(IRS990);
END;