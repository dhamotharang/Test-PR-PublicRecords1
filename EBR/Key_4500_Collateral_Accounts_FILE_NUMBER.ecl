import doxie;

f := File_4500_Collateral_Accounts_Base_bdid(FILE_NUMBER <> '');

export Key_4500_Collateral_Accounts_FILE_NUMBER := index(f,{FILE_NUMBER},{f},KeyName_4500_Collateral_Accounts_FILE_NUMBER + '_' + doxie.Version_SuperKey);
