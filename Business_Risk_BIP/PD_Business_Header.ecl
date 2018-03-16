IMPORT BIPV2, Business_Risk_BIP, MDR;

EXPORT PD_Business_Header(DATASET(Business_Risk_BIP.Layouts.Shell) LinkIDsFound, 
									DATASET(BIPV2.IDlayouts.l_xlink_ids2) kFetchLinkIDs, 
									STRING1 kFetchLinkSearchLevel, 
									BIPV2.mod_sources.iParams linkingOptions, 
									Business_Risk_BIP.LIB_Business_Shell_LIBIN options, 
									SET OF STRING2 AllowedSourcesSet) := FUNCTION

	// --------------- Business Header ----------------
	BusinessHeaderRaw1 := BIPV2.Key_BH_Linking_Ids.kFetch2(kFetchLinkIDs,
																						 kFetchLinkSearchLevel,
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							linkingOptions,
																							Business_Risk_BIP.Constants.Limit_BusHeader,
																							FALSE, /* dnbFullRemove */
																							TRUE, /* bypassContactSuppression */
																							Options.KeepLargeBusinesses);
	// clean up the business header before doing anything else
	Business_Risk_BIP.Common.mac_slim_header(BusinessHeaderRaw1, BusinessHeaderRaw);	
		
	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq2(BusinessHeaderRaw, LinkIDsFound, BusinessHeaderSeq);
	
	// Filter out records after our history date and sources that aren't allowed - pass in AllowedSources to possibly turn on DNB DMI data
	BusinessHeader := Business_Risk_BIP.Common.FilterRecords(BusinessHeaderSeq, dt_first_seen, dt_vendor_first_reported, Source, AllowedSourcesSet);
	
	RETURN(BusinessHeader);
END;