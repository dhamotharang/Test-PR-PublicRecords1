IMPORT BIPV2, Business_Risk_BIP, dx_OSHAIR, MDR;

EXPORT PD_OSHA(DATASET(Business_Risk_BIP.Layouts.Shell) LinkIDsFound,
									DATASET(BIPV2.IDlayouts.l_xlink_ids2) kFetchLinkIDs,
									STRING1 kFetchLinkSearchLevel,
									BIPV2.mod_sources.iParams linkingOptions,
									Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
									SET OF STRING2 AllowedSourcesSet) := FUNCTION

	// ---------------- OSHA - Occupational Safety and Health Administration ------------------
	OSHARaw := dx_OSHAIR.Key_LinkIds.kFetch2(kFetchLinkIDs,
																						 kFetchLinkSearchLevel,
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq2(OSHARaw, LinkIDsFound, OSHASeq);

	// Filter out records after our history date
	OSHA := Business_Risk_BIP.Common.FilterRecords(OSHASeq, inspection_opening_date, inspection_close_date, MDR.SourceTools.src_OSHAIR, AllowedSourcesSet);

	RETURN(OSHA);
END;
