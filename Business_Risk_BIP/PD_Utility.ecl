IMPORT BIPV2, Business_Risk_BIP, Doxie, UtilFile, MDR;

EXPORT PD_Utility(DATASET(Business_Risk_BIP.Layouts.Shell) LinkIDsFound,
									DATASET(BIPV2.IDlayouts.l_xlink_ids2) kFetchLinkIDs,
									STRING1 kFetchLinkSearchLevel,
									BIPV2.mod_sources.iParams linkingOptions,
									Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
									SET OF STRING2 AllowedSourcesSet) := FUNCTION

	// ---------------- Utility Data ---------------------
	UtilRaw := IF(~Doxie.Compliance.isUtilityRestricted(Options.industry_class), UtilFile.Key_LinkIds.kFetch2(kFetchLinkIDs,
																						 kFetchLinkSearchLevel,
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses));

	Business_Risk_BIP.Common.AppendSeq2(UtilRaw, LinkIDsFound, UtilSeq);

	// Filter out records after our history date
	Util := Business_Risk_BIP.Common.FilterRecords(UtilSeq, date_first_seen, date_added_to_exchange, MDR.SourceTools.src_Utilities, AllowedSourcesSet);

	RETURN(Util);
END;
