import doxie;

f := File_2015_Trade_Payment_Totals_Base_bdid(FILE_NUMBER <> '');

export Key_2015_Trade_Payment_Totals_FILE_NUMBER := index(f,{FILE_NUMBER},{f},KeyName_2015_Trade_Payment_Totals_FILE_NUMBER + '_' + doxie.Version_SuperKey);
