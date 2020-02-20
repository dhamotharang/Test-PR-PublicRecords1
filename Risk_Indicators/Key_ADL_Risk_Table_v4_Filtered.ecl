import doxie, Data_Services, vault, _control;

isfcra := true;
f := risk_indicators.ADL_Risk_Table_v4(isfcra);

#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export Key_ADL_Risk_Table_v4_Filtered := vault.Risk_Indicators.Key_ADL_Risk_Table_v4_Filtered;
#ELSE
export Key_ADL_Risk_Table_v4_Filtered := index(f,{did},{f},
	// Data_Services.Data_Location.Prefix('DeathMaster')+'thor_data400::key::death_master::'+doxie.Version_SuperKey+'::adl_risk_table_v4_filtered');
	data_services.data_location.prefix() + 'thor_data400::key::death_master::'+doxie.Version_SuperKey+'::adl_risk_table_v4_filtered');
#END;

