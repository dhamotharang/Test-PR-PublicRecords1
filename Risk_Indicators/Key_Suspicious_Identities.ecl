import doxie, ut;

f := Risk_Indicators.Suspicious_Identities_Base;

export Key_Suspicious_Identities := index(f,{did},{f},
	// ut.foreign_dataland+'thor_data400::key::death_master::'+doxie.Version_SuperKey+'::suspicious_identities');
	'~thor_data400::key::death_master::'+doxie.Version_SuperKey+'::suspicious_identities');

