import doxie;

f := File_4020_Tax_Liens_Base_bdid(FILE_NUMBER <> '');

export Key_4020_Tax_Liens_FILE_NUMBER := index(f,{FILE_NUMBER},{f},KeyName_4020_Tax_Liens_FILE_NUMBER + '_' + doxie.Version_SuperKey);
