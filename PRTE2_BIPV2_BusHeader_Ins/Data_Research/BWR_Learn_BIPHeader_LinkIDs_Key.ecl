/* ************************************************************************************************
PRTE2_BIPV2_BusHeader_Ins.Data_Research.BWR_Learn_BIPHeader_LinkIDs_Key
************************************************************************************************ */

IMPORT PRTE2_BIPV2_BusHeader_Ins, PRTE2_BIPV2_BusHeader_Ins.Data_Research, PRTE2_Common_DevOnly, PRTE2_Common;

// DSFull := Files.BIPHeaderKeyLinkIDsPRCTDS;
DSFull := Files.BIPHeaderKeyLinkIDsLiveDS;
OUTPUT(DSFull,NAMED('DSFull'));
OUTPUT(COUNT(DSFull),NAMED('C_DSFull'));
// DSAll := Files.BIPHeaderKeyLinkIDsPRCTView;
DSAll := Files.BIPHeaderKeyLinkIDsLiveView;
OUTPUT(DSAll,NAMED('DSAll'));
OUTPUT(COUNT(DSAll),NAMED('C_DSAll'));

DS1stSeen := DSAll(dt_first_seen>20170101);
OUTPUT(COUNT(DS1stSeen),NAMED('C_DS1stSeen'));
OUTPUT(DS1stSeen,NAMED('DS1stSeen'));

DataIn := DSAll;
RepTable0 := PRTE2_Common_DevOnly.MAC_CrossTabCount(DataIn,st);
OUTPUT(SORT(RepTable0,-GroupCount),NAMED('DistributionStates'));

DataIn2 := DataIn(dt_vendor_last_reported<>0);
RepTable1 := PRTE2_Common_DevOnly.MAC_CrossTabCount(DataIn2,dt_vendor_last_reported[1..4]);
OUTPUT(SORT(RepTable1,-GroupCount),NAMED('DistributionLastSeenYr'));

