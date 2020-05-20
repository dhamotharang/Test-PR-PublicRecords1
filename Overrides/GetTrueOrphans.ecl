IMPORT Overrides;

	//GONG
	GongTrueOrphans := Overrides.Gong_Override_Findings;
	// PAW
	
	// ALLOY
	
	BaseTrueOrphans := (
					GongTrueOrphans
					//+ Paw
	): PERSIST('~thor_data400::persist::override_trueorphans');
	
	EXPORT GetTrueOrphans := BaseTrueOrphans;
