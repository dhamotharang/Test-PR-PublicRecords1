import doxie;

f := File_4020_Tax_Liens_Base_bdid(bdid <> 0);

export Key_4020_Tax_Liens_BDID := index(f,{bdid},{f},KeyName_4020_Tax_Liens_BDID + '_' + doxie.Version_SuperKey);
