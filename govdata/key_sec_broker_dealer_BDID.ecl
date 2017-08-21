import doxie, BIPV2;

df := project(govdata.File_SEC_Broker_Dealer_BDID(bdid != 0),transform(layout_sec_broker_dealer_BDID - BIPV2.IDlayouts.l_xlink_IDs,self:=left;));

export key_sec_broker_dealer_BDID := index(df,{bdid},{df},govdata.keynames().Sec_broker_dealerBdid.qa);
