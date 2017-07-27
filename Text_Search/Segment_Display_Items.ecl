EXPORT DATASET(Layout_Segment_Display_Item) Segment_Display_Items(Filename_Info info) 
						:= FUNCTION
	defs := LIMIT(Indx_Segment_Definition(info), 
									Limits.Max_Segments,
									FAIL(Limits.Segments_Code, Limits.Segments_Msg));
	Layout_Segment_Display_Item norm(defs l, INTEGER c) := TRANSFORM
		SELF.siblings := COUNT(l.segList);
		SELF.segment  := l.segList[c];
		SELF.name			:= l.segName;
	END;
	i0 := NORMALIZE(defs, COUNT(LEFT.segList), norm(LEFT, COUNTER));
	t0 := TABLE(i0, {segment, m:=MAX(GROUP,siblings)}, segment, FEW);
	i1 := JOIN(i0, t0, 
						 LEFT.segment=RIGHT.segment AND LEFT.siblings=RIGHT.m, 
						 TRANSFORM(Layout_Segment_Display_Item, SELF:=LEFT), LOOKUP);
	RETURN i1;
END;