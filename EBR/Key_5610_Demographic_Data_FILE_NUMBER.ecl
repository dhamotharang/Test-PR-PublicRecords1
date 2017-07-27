import doxie;
f := File_5610_Demographic_Data_Base_bdid(FILE_NUMBER <> '');
export Key_5610_Demographic_Data_FILE_NUMBER := index(f,{FILE_NUMBER},{f},KeyName_5610_Demographic_Data_FILE_NUMBER + '_' + doxie.Version_SuperKey);
