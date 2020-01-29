IMPORT PRTE2_X_Ins_DataGathering, PRTE2_Common_DevOnly;

// DS := PRTE2_X_Ins_DataGathering.Files.VIN_Data_DS;
DS5 := PRTE2_X_Ins_DataGathering.Files.VIN_Data_5yr_DS;
// COUNT(DS);
COUNT(DS5);
// DS;
DS5;

// RepTable := PRTE2_Common_DevOnly.MAC_CrossTabCount(DS,vina_make_desc);
// OUTPUT(sort(RepTable,groupby),all);

RepTable5 := PRTE2_Common_DevOnly.MAC_CrossTabCount(DS5,vina_make_desc);
OUTPUT(sort(RepTable5,groupby),all);