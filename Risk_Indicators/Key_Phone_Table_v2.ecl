import doxie,data_services, vault, _control;

r := risk_indicators.Phone_Table_v2();

#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
  
  export Key_Phone_Table_v2 := vault.risk_indicators.Key_Phone_Table_v2;

#ELSE

  export Key_Phone_Table_v2 := index(r,{phone10},{r},data_services.data_location.prefix() + 'thor_data400::key::phone_table_v2_'+doxie.Version_SuperKey);

#END;