
MakeCountryId(integer i, Unicode countryName) :=
		'LC' + IntFormat(i,2,1) + IntFormat(ISO_CountryToNumeric(countryName),4,1);
		

EXPORT ProcessGeoFile(integer i) := FUNCTION

	watchlist := PROJECT(UniqueId.Files.country(WatchListName = SetOfGeoLists[i]),
									TRANSFORM(Layout_Watchlist.rgeo,
											SELF.Entity_Unique_Id := MakeCountryId(i, LEFT.Country_Name);
											SELF := LEFT;));

	return MakeHdr.OutputGeoXMLFile(watchlist, SetOfGeoLists[i], Conversions.SourceCodeToFileName(SetOfGeoLists[i]));

END;