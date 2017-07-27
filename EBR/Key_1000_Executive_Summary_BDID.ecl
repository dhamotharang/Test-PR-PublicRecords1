import doxie;

f := File_1000_Executive_Summary_Base_bdid(bdid <> 0);

export Key_1000_Executive_Summary_BDID := index(f,{bdid},{f},KeyName_1000_Executive_Summary_BDID + '_' + doxie.Version_SuperKey);
