import doxie;

f := File_2000_Trade_Base_bdid(FILE_NUMBER <> '');

export Key_2000_Trade_FILE_NUMBER := index(f,{FILE_NUMBER},{f},KeyName_2000_Trade_FILE_NUMBER + '_' + doxie.Version_SuperKey);
