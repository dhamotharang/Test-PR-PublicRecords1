import doxie;

f := File_4500_Collateral_Accounts_Base_bdid(bdid <> 0);

export Key_4500_Collateral_Accounts_BDID := index(f,{bdid},{f},KeyName_4500_Collateral_Accounts_BDID + '_' + doxie.Version_SuperKey);
