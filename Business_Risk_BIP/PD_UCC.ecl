IMPORT BIPV2, Business_Risk_BIP, UCCv2_Services, UCCV2, MDR;

EXPORT PD_UCC(DATASET(Business_Risk_BIP.Layouts.Shell) LinkIDsFound, 
									DATASET(BIPV2.IDlayouts.l_xlink_ids2) kFetchLinkIDs, 
									STRING1 kFetchLinkSearchLevel, 
									BIPV2.mod_sources.iParams linkingOptions, 
									Business_Risk_BIP.LIB_Business_Shell_LIBIN options, 
									SET OF STRING2 AllowedSourcesSet) := FUNCTION

	// --------------- UCC - Uniform Commercial Code ----------------
	// Get the TMSID/RMSID results for UCC data
	UCCTMSIDRaw := UCCV2.Key_LinkIds.kFetch2(kFetchLinkIDs,
																						 kFetchLinkSearchLevel,
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq2(UCCTMSIDRaw, LinkIDsFound, UCCTMSIDSeq);
	
	// Filter out records after our history date
	UCCTMSID := Business_Risk_BIP.Common.FilterRecords(UCCTMSIDSeq, dt_first_seen, dt_vendor_first_reported, MDR.SourceTools.src_UCCV2, AllowedSourcesSet);
	
	// ---- Get the raw data based on the unique TMSID codes - this is simlar to code adopted from TopBusiness_Services.UCCSource_Records ----
	UCCKeys := PROJECT(UCCTMSID (TRIM(TMSID) != ''), TRANSFORM(UCCv2_Services.layout_tmsid, SELF.TMSID := LEFT.TMSID, SELF := LEFT));
	
	// Only pass in the unique TMSID's, we will join back to Seq later
	UniqueUCCTMSID := DEDUP(SORT(UCCKeys, TMSID), TMSID);
	
	// Grab the raw UCC data by the appropriate view
  UCCData := UCCv2_Services.UCCRaw.Source_View.By_TMSID(UniqueUCCTMSID, '' /*SSNMask*/, FALSE /*MultiplePages*/, '' /*ApplicationType - IE: GOV*/);
  
	// Append our input Seq back
	UCCDataSeq := JOIN(DEDUP(SORT(UCCTMSID, Seq, TMSID), Seq, TMSID), UCCData, LEFT.TMSID = RIGHT.TMSID, TRANSFORM({RECORDOF(RIGHT), UNSIGNED4 Seq}, SELF.Seq := LEFT.Seq; SELF := RIGHT));
	
	RETURN(UCCDataSeq);
END;