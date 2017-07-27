import doxie;
f := File_7010_SNP_Data_Base_bdid(bdid <> 0);
export Key_7010_SNP_Data_BDID := index(f,{bdid},{f},KeyName_7010_SNP_Data_BDID + '_' + doxie.Version_SuperKey);

