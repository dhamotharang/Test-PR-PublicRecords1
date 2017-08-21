IMPORT prte2;

EXPORT fSpray  := FUNCTION
	RETURN prte2.SprayFiles.Spray_Raw_Data('DEADCOKeys','deadco','infousa');
END;