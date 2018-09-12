EXPORT macComputeSearchString(searchStr, searchEngine = 0) := FUNCTIONMACRO

	engineURL := CASE(searchEngine,
		ComputeSearchString.Constants.SearchEngineOptions.Google => ComputeSearchString.Constants.GoogleURL,
		ComputeSearchString.Constants.SearchEngineOptions.Bing => ComputeSearchString.Constants.BingURL,
		ComputeSearchString.Constants.SearchEngineOptions.Yahoo => ComputeSearchString.Constants.YahooURL,
		ComputeSearchString.Constants.GoogleURL); //default to Google search
		
	LOCAL searchURL := '<a href="' + TRIM(engineURL)
		+ Std.Str.FindReplace(Std.Str.FindReplace(searchStr, ' ', '+'), '<BR/>', '+') 
		+ '" target="_blank">' + searchStr + '</a>';
		
	RETURN searchURL;
ENDMACRO;