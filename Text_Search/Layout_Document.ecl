EXPORT Layout_Document := RECORD
	Types.DocRef	docRef;
	DATASET(Layout_Segment) segs {MAXLENGTH(1000000)};
END;