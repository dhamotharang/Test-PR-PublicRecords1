EXPORT Layout_Segment_Display_Item := RECORD
	Types.Segment			segment;
	Types.SegmentName name{MAXLENGTH(128)};
	UNSIGNED2					siblings;
END;