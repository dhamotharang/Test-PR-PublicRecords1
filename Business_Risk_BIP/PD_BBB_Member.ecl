IMPORT BIPV2, Business_Risk_BIP, BBB2, MDR;

EXPORT PD_BBB_Member(DATASET(Business_Risk_BIP.Layouts.Shell) LinkIDsFound, 
									DATASET(BIPV2.IDlayouts.l_xlink_ids2) kFetchLinkIDs, 
									STRING1 kFetchLinkSearchLevel, 
									BIPV2.mod_sources.iParams linkingOptions, 
									Business_Risk_BIP.LIB_Business_Shell_LIBIN options, 
									SET OF STRING2 AllowedSourcesSet) := FUNCTION

	// ---------------- Better Business Bureau ------------------
	BBBMemberRaw := BBB2.Key_BBB_LinkIds.kFetch2(kFetchLinkIDs,
																						 kFetchLinkSearchLevel,
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
																							
	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq2(BBBMemberRaw, LinkIDsFound, BBBMemberSeq);
	
	// Filter out records after our history date
	BBBMember := Business_Risk_BIP.Common.FilterRecords(BBBMemberSeq, date_first_seen, dt_vendor_first_reported, MDR.SourceTools.src_BBB_Member, AllowedSourcesSet);
	
	RETURN(BBBMember);
END;