EXPORT Layout_Segment_ComposeDef := RECORD
	Types.ShortSegName	shortName;
	Types.SegmentName 	segName{MAXLENGTH(128)};
	Types.SegmentType		segType;
	SET OF Types.ShortSegName 	nameList{MAXCOUNT(64)};
END;
