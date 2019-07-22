import doxie, Data_Services;

isFCRA := true;
r := risk_indicators.SSN_Table_v4(isFCRA);  

export Key_SSN_Table_v4_filtered_FCRA := index (r, {ssn}, {r}, 
	// Data_Services.Data_Location.Prefix('DeathMaster')+'thor_data400::key::death_master::'+doxie.Version_SuperKey+'::ssn_table_v4_filtered');
	Data_Services.Data_Location.Prefix('DeathMaster') + 'thor_data400::key::death_master::fcra::'+doxie.Version_SuperKey+'::ssn_table_v4_filtered');
