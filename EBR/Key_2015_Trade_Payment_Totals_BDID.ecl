import doxie;

f := File_2015_Trade_Payment_Totals_Base_bdid(bdid <> 0);

export Key_2015_Trade_Payment_Totals_BDID := index(f,{bdid},{f},KeyName_2015_Trade_Payment_Totals_BDID + '_' + doxie.Version_SuperKey);
