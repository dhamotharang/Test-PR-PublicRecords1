IMPORT Text_Search;

EXPORT IParam := MODULE
	
	EXPORT searchParams := INTERFACE(Text_Search.StandardSearchArgs)
		EXPORT UNSIGNED maxResults := 0;
		EXPORT STRING6 ssnMask := '';
	END;
	
END;
