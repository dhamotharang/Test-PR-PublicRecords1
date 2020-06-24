import dx_Gong, data_services, vault, _control;

#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca

  export Key_Phone_Table_v2 := vault.risk_indicators.Key_Phone_Table_v2;

#ELSE

  export Key_Phone_Table_v2 := dx_Gong.key_phone_table();

#END;
