IMPORT ut, std, prte2;

EXPORT fSpray := FUNCTION
	RETURN 	prte2.SprayFiles.Spray_Raw_Data('prte_phonefinder_update_rules','PhoneFinderUpdateRules','PhoneFinderUpdate');
END;