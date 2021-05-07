IMPORT BIPV2, Business_Risk_BIP, dx_Cortera, MDR, STD; 

EXPORT PD_Cortera(DATASET(Business_Risk_BIP.Layouts.Shell) LinkIDsFound, 
                  DATASET(BIPV2.IDlayouts.l_xlink_ids2) kFetchLinkIDs, 
                  STRING1 kFetchLinkSearchLevel, 
                  Business_Risk_BIP.LIB_Business_Shell_LIBIN options, 
                  SET OF STRING2 AllowedSourcesSet) := MODULE
                  
  CorteraRaw := dx_Cortera.Key_LinkIds.kfetch2(kFetchLinkIDs,
    kFetchLinkSearchLevel,
    0, // ScoreThreshold --> 0 = Give me everything
    Business_Risk_BIP.Constants.Limit_Default,
    Options.KeepLargeBusinesses
  );

  // Add back our Seq numbers.
  Business_Risk_BIP.Common.AppendSeq2(CorteraRaw, LinkIDsFound, CorteraSeq);

  // Filter out records that aren't from the most recent build as of the historydate, since we only want to look at the most recent Cortera records when calculating the attriubtes.
  EXPORT CorteraRecs := Business_Risk_BIP.Common.FilterCorteraRecords(CorteraSeq, dt_first_seen, dt_vendor_first_reported, dt_vendor_last_reported, Current, MDR.SourceTools.src_Cortera, AllowedSourcesSet);
  
  CorteraRecs_DD := DEDUP(SORT(CorteraRecs, Seq, ultimate_linkid), Seq, ultimate_linkid);

  CorteraAttributes_InHouse_Raw_pre := JOIN(CorteraRecs_DD, dx_Cortera.Key_Attributes_Link_Id,
    KEYED( LEFT.ultimate_linkid = RIGHT.ultimate_linkid) AND LEFT.Ultid=RIGHT.UltID AND LEFT.OrgID=RIGHT.OrgID AND LEFT.SeleID=RIGHT.SeleID , 
          TRANSFORM({RECORDOF(RIGHT), UNSIGNED4 Seq, UNSIGNED6 HistoryDate},
                      SELF.Seq := LEFT.Seq;
                      SELF.HistoryDate := LEFT.HistoryDate; 
                      // SELF.HistoryDateTime := (UNSIGNED)(((STRING)LEFT.HistoryDateTime + '01')[1..8]); 
                      // SELF.HistoryDateLength := LEFT.HistoryDateLength;  
                      SELF := RIGHT), 
          ATMOST(Business_Risk_BIP.Constants.Limit_Default));

  dx_Cortera.mac_incremental_rollup(CorteraAttributes_InHouse_Raw_pre, CorteraAttributes_InHouse_Raw, current_rec);
          
  // Filter down to Cortera Attribute Records that are either marked current or have been seen in the last build (within a week of the history date)
  EXPORT Cortera_Attribute_recs := Business_Risk_BIP.Common.FilterCorteraRecords(CorteraAttributes_InHouse_Raw, dt_first_seen, dt_vendor_first_reported, dt_vendor_last_reported, Current_Rec, MDR.SourceTools.src_Cortera, AllowedSourcesSet);

END; 
