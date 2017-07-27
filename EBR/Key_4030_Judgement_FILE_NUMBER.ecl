import doxie;

f := File_4030_Judgement_Base_bdid(FILE_NUMBER <> '');

export Key_4030_Judgement_FILE_NUMBER := index(f,{FILE_NUMBER},{f},KeyName_4030_Judgement_FILE_NUMBER + '_' + doxie.Version_SuperKey);
