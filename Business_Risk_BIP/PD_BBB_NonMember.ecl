IMPORT BIPV2, Business_Risk_BIP, BBB2, MDR;

EXPORT PD_BBB_NonMember(DATASET(Business_Risk_BIP.Layouts.Shell) LinkIDsFound, 
									DATASET(BIPV2.IDlayouts.l_xlink_ids2) kFetchLinkIDs, 
									STRING1 kFetchLinkSearchLevel, 
									BIPV2.mod_sources.iParams linkingOptions, 
									Business_Risk_BIP.LIB_Business_Shell_LIBIN options, 
									SET OF STRING2 AllowedSourcesSet) := FUNCTION

	// ---------------- Better Business Bureau ------------------
	BBBNonMemberRaw := BBB2.Key_BBB_Non_Member_LinkIds.kFetch2(kFetchLinkIDs,
																						 kFetchLinkSearchLevel,
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
																							
	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq2(BBBNonMemberRaw, LinkIDsFound, BBBNonMemberSeq);
	
	// Filter out records after our history date
	BBBNonMember := Business_Risk_BIP.Common.FilterRecords(BBBNonMemberSeq, date_first_seen, dt_vendor_first_reported, MDR.SourceTools.src_BBB_Non_Member, AllowedSourcesSet);
	
	RETURN(BBBNonMember);
END;