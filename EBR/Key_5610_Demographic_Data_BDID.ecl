import doxie;
f := File_5610_Demographic_Data_Base_bdid(bdid <> 0);
export Key_5610_Demographic_Data_BDID := index(f,{bdid},{f},KeyName_5610_Demographic_Data_BDID + '_' + doxie.Version_SuperKey);
