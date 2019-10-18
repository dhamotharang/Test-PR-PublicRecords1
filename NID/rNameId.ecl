EXPORT rNameId := RECORD

	string100		rawName;
	string100		preProcessed;
	string100		preCleaned;
	string73		CleanedName;
	integer			nameType := 0;
	integer			nameFormat := 0;
	integer			nameQuality := 0;
	boolean			isDualName := false;

END;