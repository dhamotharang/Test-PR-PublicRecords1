import doxie;
f := File_5600_Demographic_Data_Base_bdid(FILE_NUMBER <> '');
export Key_5600_Demographic_Data_FILE_NUMBER := index(f,{FILE_NUMBER},{f},KeyName_5600_Demographic_Data_FILE_NUMBER + '_' + doxie.Version_SuperKey);
