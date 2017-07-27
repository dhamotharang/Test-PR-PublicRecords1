import doxie;

f := File_2020_Trade_Payment_Trends_Base_bdid(FILE_NUMBER <> '');

export Key_2020_Trade_Payment_Trends_FILE_NUMBER := index(f,{FILE_NUMBER},{f},KeyName_2020_Trade_Payment_Trends_FILE_NUMBER + '_' + doxie.Version_SuperKey);
