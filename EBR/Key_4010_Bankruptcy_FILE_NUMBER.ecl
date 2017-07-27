import doxie;

f := File_4010_Bankruptcy_Base_bdid(FILE_NUMBER <> '');

export Key_4010_Bankruptcy_FILE_NUMBER := index(f,{FILE_NUMBER},{f},KeyName_4010_Bankruptcy_FILE_NUMBER + '_' + doxie.Version_SuperKey);
