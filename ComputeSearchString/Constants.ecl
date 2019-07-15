EXPORT Constants := MODULE
	EXPORT GoogleURL := 'https://www.google.com/?gws_rd=ssl#q=';
	EXPORT BingURL := 'http://www.bing.com/search?q=';
	EXPORT YahooURL := 'https://search.yahoo.com/search?p=';
	EXPORT SearchEngineOptions := ENUM(Google,Bing,Yahoo);
END;