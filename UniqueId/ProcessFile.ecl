EXPORT ProcessFile(integer i) := FUNCTION

	listName := SetOfLists[i];
//	watchlist := SORT(PROJECT(File_AllData(WatchListName = SetOfLists[i]), Layout_Watchlist.routp),(integer)id);
	watchlist := SORT(
									PROJECT(File_AllData(WatchListName = listName), TRANSFORM(Layout_Watchlist.routp,
													self.comments := IF(LEFT.comments = '', GetDisclaimer(listName),
																						LEFT.comments +
																							IF(GetDisclaimer(listName)='','',
																								' || ' + GetDisclaimer(listName)));
													self := LEFT;)),
								(integer)id);
	return MakeHdr.OutputDataXMLFile(watchlist, SetOfLists[i], Conversions.SourceCodeToFileName(SetOfLists[i]));

END;