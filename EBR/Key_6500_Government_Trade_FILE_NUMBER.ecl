import doxie;
f := File_6500_Government_Trade_Base_bdid(FILE_NUMBER <> '');
export Key_6500_Government_Trade_FILE_NUMBER := index(f,{FILE_NUMBER},{f},KeyName_6500_Government_Trade_FILE_NUMBER + '_' + doxie.Version_SuperKey);
