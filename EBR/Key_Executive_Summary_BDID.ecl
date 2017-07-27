import doxie;

f := File_Executive_Summary_Base(bdid <> 0);

export Key_Executive_Summary_BDID := index(f,{bdid},{f},KeyName_Executive_Summary_BDID + '_' + doxie.Version_SuperKey);
