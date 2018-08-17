IMPORT PRTE2_BIPV2_BusHeader_Ins.Data_Research, PRTE2_Common_DevOnly;

DSFull := Files.BIPHeaderKeyLinkIDsPRCTDS;
// DSFull := Files.BIPHeaderKeyLinkIDsLiveDS;
DSFull;
DSAll := Files.BIPHeaderKeyLinkIDsPRCTView;
// DSAll := Files.BIPHeaderKeyLinkIDsLiveView;
DSAll;

DS := DSAll(dt_first_seen>20170101);
COUNT(DS);
DS;
DS1 := DSAll(TRIM(sic_code)<>'' AND TRIM(naics_code)<>'');
COUNT(DS1);
DS1;
// Error:    System error: 10084: Graph graph1[16], sort[18]: SORT failed. Graph graph1[16], sort[18]: Exceeded skew limit: 0.002500, estimated skew: 0.019761 (0, 0), 10084, 
// need to distribute!
// DS1D := DEDUP(SORT(DS1,sic_code,naics_code),sic_code,naics_code);
// COUNT(DS1D);
// DS1D;
OUTPUT(COUNT(DSAll));

DataIn := DSAll;
RepTable0 := PRTE2_Common_DevOnly.MAC_CrossTabCount(DataIn,st);
OUTPUT(SORT(RepTable0,-GroupCount));

DataIn2 := DataIn(dt_vendor_last_reported<>0);
RepTable1 := PRTE2_Common_DevOnly.MAC_CrossTabCount(DataIn2,dt_vendor_last_reported[1..4]);
OUTPUT(SORT(RepTable1,-GroupCount));