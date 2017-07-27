import doxie;
f := File_7000_SNP_Parent_Name_Address_Base_bdid(FILE_NUMBER <> '');
export Key_7000_SNP_Parent_Name_Address_FILE_NUMBER := index(f,{FILE_NUMBER},{f},KeyName_7000_SNP_Parent_Name_Address_FILE_NUMBER + '_' + doxie.Version_SuperKey);
