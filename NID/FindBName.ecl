IMPORT STD;

// The function isn't supposed to be called directly, only through the NID/PrefferedFirst[New]
// (I can't declare it "shared" at that point due to some issues with syntax check). 
EXPORT string20 FindBName(DICTIONARY({STRING21 Nickname => STRING20 name}) nameDictionary, string20 name) := 
FUNCTION
  str := STD.STR.ToUpperCase(TRIM(name,LEFT,RIGHT));
	RETURN IF (str in nameDictionary, nameDictionary[str].name, name);
END;
