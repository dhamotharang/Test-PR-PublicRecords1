import doxie;

df := govdata.File_SEC_Broker_Dealer_BDID(bdid != 0);

export key_sec_broker_dealer_BDID := index(df,{bdid},{df},'~thor_data400::key::sec_broker_dealer_bdid_' + doxie.Version_SuperKey);
