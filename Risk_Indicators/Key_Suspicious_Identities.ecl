import doxie,Data_Services;

f := Risk_Indicators.Suspicious_Identities_Base;

export Key_Suspicious_Identities := index(f,{did},{f},
	// Data_Services.foreign_dataland+'thor_data400::key::death_master::'+doxie.Version_SuperKey+'::suspicious_identities');
	Data_Services.Data_Location.Prefix('DeathMaster')+'thor_data400::key::death_master::'+doxie.Version_SuperKey+'::suspicious_identities');

