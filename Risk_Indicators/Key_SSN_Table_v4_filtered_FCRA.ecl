import doxie, Data_Services, _Control, Vault;

isFCRA := true;
r := risk_indicators.SSN_Table_v4(isFCRA);  

#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
	export 	Key_SSN_Table_v4_filtered_FCRA := vault.Risk_Indicators.Key_SSN_Table_v4_filtered_FCRA;
#ELSE
	export Key_SSN_Table_v4_filtered_FCRA := index (r, {ssn}, {r}, 
		Data_Services.Data_Location.Prefix('DeathMaster') + 'thor_data400::key::death_master::fcra::'+doxie.Version_SuperKey+'::ssn_table_v4_filtered');
#END;



