import doxie;
f := File_7000_SNP_Parent_Name_Address_Base_bdid(bdid <> 0);
export Key_7000_SNP_Parent_Name_Address_BDID := index(f,{bdid},{f},KeyName_7000_SNP_Parent_Name_Address_BDID + '_' + doxie.Version_SuperKey);
