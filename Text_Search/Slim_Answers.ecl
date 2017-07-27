export Slim_Answers(DATASET(Layout_AIS) recs, 
										BOOLEAN keepHits) := FUNCTION
	Layout_AIS cvt(Layout_AIS l) := TRANSFORM
		SELF.docRef := l.docRef;
		SELF.seg		:= IF(keepHits, l.seg, 0);
		SELF.subSeg	:= 0;
		SELF.kwp		:= IF(keepHits, l.kwp, 0);
		SELF.wip		:= IF(keepHits, l.wip, 0);
		SELF.termID	:= IF(keepHits, l.termID, 0);
	END;
	rslt := DEDUP(PROJECT(recs, cvt(LEFT)), RECORD);
	RETURN rslt;
END;
	