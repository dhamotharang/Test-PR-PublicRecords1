import doxie,Data_Services, vault, _control;
f := File_Telcordia_tds;

#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export Key_Telcordia_tds := vault.Risk_Indicators.Key_Telcordia_tds;

#ELSE
export Key_Telcordia_tds := INDEX(f,{npa,nxx},{f},Data_Services.Data_Location.Prefix('Telcordia')+ 'thor_data400::key::telcordia_tds_' + doxie.Version_SuperKey);


#END;

