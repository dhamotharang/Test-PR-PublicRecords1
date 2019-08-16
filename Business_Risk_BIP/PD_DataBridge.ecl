IMPORT BIPV2, Business_Risk_BIP, dx_databridge, MDR;


EXPORT PD_DataBridge(DATASET(Business_Risk_BIP.Layouts.Shell) LinkIDsFound, 
									DATASET(BIPV2.IDlayouts.l_xlink_ids2) kFetchLinkIDs, 
									STRING1 kFetchLinkSearchLevel, 
									SET OF STRING2 AllowedSourcesSet) := FUNCTION

	// --------------- Bankruptcy Data ----------------
	DataBridgeRaw := dx_DataBridge.Key_LinkIds.kFetch(kFetchLinkIDs, ,
																						  kFetchLinkSearchLevel,
																							0, /*ScoreThreshold --> 0 = Give me everything*/);

	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq(	DataBridgeRaw, LinkIDsFound, DataBridgeSeq, (INTEGER)kFetchLinkSearchLevel);


	// Filter out records after our history date
	DataBridge := Business_Risk_BIP.Common.FilterRecords(DataBridgeSeq, dt_first_seen, dt_vendor_first_reported, MDR.SourceTools.src_DataBridge, AllowedSourcesSet);

	RETURN(DataBridge);
END;