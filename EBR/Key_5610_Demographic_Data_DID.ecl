import doxie;
f := File_5610_Demographic_Data_Base_bdid(did <> 0);
export Key_5610_Demographic_Data_DID := index(f,{did},{f},KeyName_5610_Demographic_Data_DID + '_' + doxie.Version_SuperKey);
