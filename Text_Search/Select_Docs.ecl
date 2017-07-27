// Select the documents from the list and subset the AIS records.
EXPORT Select_Docs(DATASET(Layout_DocScore) docs,
									 DATASET(Layout_Bookmark) marks,
									 INTEGER docCount) := FUNCTION
	//Select the document subset
	selected := TOPN(docs, docCount, -score, docRef);// alter when processing marks
	RETURN selected;
END;