import doxie;

f := File_2020_Trade_Payment_Trends_Base_bdid(bdid <> 0);

export Key_2020_Trade_Payment_Trends_BDID := index(f,{bdid},{f},KeyName_2020_Trade_Payment_Trends_BDID + '_' + doxie.Version_SuperKey);
