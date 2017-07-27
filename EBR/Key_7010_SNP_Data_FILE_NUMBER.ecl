import doxie;
f := File_7010_SNP_Data_Base_bdid(FILE_NUMBER <> '');
export Key_7010_SNP_Data_FILE_NUMBER := index(f,{FILE_NUMBER},{f},KeyName_7010_SNP_Data_FILE_NUMBER + '_' + doxie.Version_SuperKey);
