import doxie;

f := File_2025_Trade_Quarterly_Averages_Base_bdid(FILE_NUMBER <> '');

export Key_2025_Trade_Quarterly_Averages_FILE_NUMBER := index(f,{FILE_NUMBER},{f},KeyName_2025_Trade_Quarterly_Averages_FILE_NUMBER + '_' + doxie.Version_SuperKey);
