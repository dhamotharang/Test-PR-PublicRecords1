export Layout_Segment_Definition := RECORD
	Types.SegmentName 	segName{MAXLENGTH(128)};
	Types.SegmentType		segType;
	SET OF UNSIGNED2 		segList{MAXCOUNT(64)};	// Change me, bug #20315
END;