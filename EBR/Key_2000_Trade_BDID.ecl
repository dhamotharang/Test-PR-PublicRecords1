import doxie;

f := File_2000_Trade_Base_bdid(bdid <> 0);

export Key_2000_Trade_BDID := index(f,{bdid},{f},KeyName_2000_Trade_BDID + '_' + doxie.Version_SuperKey);
