reconstruct := UniqueId.File_AllData;

rPubDates := RECORD
	string		WatchListName;
	string		WatchListDate;
	unsigned	cnt;
END;

EntityLists := PROJECT(
				TABLE(reconstruct, {reconstruct.WatchListName, reconstruct.WatchListDate, cnt := COUNT(GROUP)}, WatchListName,WatchListDate),
				rPubDates);
				
countries := UniqueId.Files.country;
CountryLists := PROJECT(
				TABLE(countries, {countries.WatchListName, countries.WatchListDate, cnt := COUNT(GROUP)}, WatchListName,WatchListDate),
				rPubDates);

EXPORT PubDates := SORT(
			EntityLists&CountryLists,
		WatchListName) : GLOBAL(FEW);