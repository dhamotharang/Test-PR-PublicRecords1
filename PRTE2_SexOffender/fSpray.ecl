IMPORT ut, std, prte2;

EXPORT fSpray := FUNCTION
	
	RETURN PARALLEL(prte2.SprayFiles.Spray_Raw_Data('SexOffenders__base_','sexoffender_main','SexOffender'),
									prte2.SprayFiles.Spray_Raw_Data('SexOffenses__base_','sexoffense','SexOffender')
									);
END;