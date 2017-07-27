export Norm_DocSeg(DATASET(Layout_MergeRec) ans) := FUNCTION
	
	Layout_MergeRec normOuter(Layout_MergeRec l, Layout_MergeEntry r) := TRANSFORM
		SELF.entries := r;
		SELF := l;
	END;
	rslt := NORMALIZE(ans, LEFT.entries, normOuter(LEFT,RIGHT));
	
	RETURN rslt;
END;