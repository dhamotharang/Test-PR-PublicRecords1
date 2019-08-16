IMPORT BIPV2, Business_Risk_BIP, Doxie, Inquiry_AccLogs;

EXPORT PD_Inquiries(DATASET(Business_Risk_BIP.Layouts.Shell) LinkIDsFound_pre,
									DATASET(BIPV2.IDlayouts.l_xlink_ids2) kFetchLinkIDs,
									STRING1 kFetchLinkSearchLevel,
									Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
									SET OF STRING2 AllowedSourcesSet,
                  Doxie.IDataAccess mod_access) := FUNCTION

	// Add fifteen minutes to the historydatetime to accommodate for delays in
	// the real time database information being available in production runs
	LinkIDsFound :=
		PROJECT(
			LinkIDsFound_pre,
			TRANSFORM( Business_Risk_BIP.Layouts.Shell,
				SELF.Clean_Input.HistoryDateTime := IF( ((STRING)LEFT.Clean_Input.HistoryDateTime)[1..6] = Business_Risk_BIP.Constants.NinesDate, LEFT.Clean_Input.HistoryDateTime, Business_Risk_BIP.Common.getFutureTime(LEFT.Clean_Input.HistoryDateTime, 15) ),
				SELF := LEFT
			)
		);

	// --------------- Business Inquiries ----------------
	InquiriesRaw := IF(Options.MarketingMode = 0, Inquiry_AccLogs.Key_Inquiry_LinkIds.kFetch2(kFetchLinkIDs,
                                              mod_access,
																						  kFetchLinkSearchLevel,
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses));
	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq2(InquiriesRaw, LinkIDsFound, InquiriesSeq);

	// Filter out records after our history date
	Inquiries := Business_Risk_BIP.Common.FilterRecords2(InquiriesSeq, (TRIM(Search_Info.DateTime,ALL))[1..12], '', AllowedSourcesSet);

	InquiriesUpdateRaw := IF(Options.MarketingMode = 0, Inquiry_AccLogs.Key_Inquiry_LinkIds_Update.kFetch2(kFetchLinkIDs,
    mod_access,
    kFetchLinkSearchLevel,
    0, /*ScoreThreshold --> 0 = Give me everything*/
    Business_Risk_BIP.Constants.Limit_Default,
    Options.KeepLargeBusinesses));
	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq2(InquiriesUpdateRaw, LinkIDsFound, InquiriesUpdateSeq);

	// Filter out records after our history date
	InquiriesUpdate := Business_Risk_BIP.Common.FilterRecords2(InquiriesUpdateSeq, (TRIM(Search_Info.DateTime,ALL))[1..12], '', AllowedSourcesSet);

	// Keep the unique inquiries between the historical and update keys
	InquiriesAll := DEDUP(SORT((Inquiries + InquiriesUpdate), Seq, Search_Info.Transaction_ID, -Search_Info.DateTime[1..8], -Search_Info.DateTime[10..15]), Seq, Search_Info.Transaction_ID, Search_Info.DateTime[1..8], Search_Info.DateTime[10..15]);

	RETURN(InquiriesAll);
END;