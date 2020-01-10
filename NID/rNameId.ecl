EXPORT rNameId := RECORD
	unsigned8		__nid := 0;
	string1			__nType := '';
	string100		__rawName := '';
	string100		__preProcessed := '';
	string100		__preCleaned := '';
	string73		__CleanedName := '';
	string73		__CleanedName2 := '';
	unsigned2		__nameType := 0;
	unsigned2		__nameFormat := 0;
	unsigned2		__nameQuality := 0;
	unsigned2		__nameInd := 0;
	string1			__gender;
	boolean			__isDualName := false;
END;
