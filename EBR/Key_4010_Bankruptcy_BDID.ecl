import doxie;

f := File_4010_Bankruptcy_Base_bdid(bdid <> 0);

export Key_4010_Bankruptcy_BDID := index(f,{bdid},{f},KeyName_4010_Bankruptcy_BDID + '_' + doxie.Version_SuperKey);
