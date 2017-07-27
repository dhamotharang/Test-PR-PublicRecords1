export Documents2DocSeg(DATASET(Layout_Document) ds) := FUNCTION
	Layout_DocSeg flat1(Layout_Document l, Layout_Segment r) := TRANSFORM
		SELF.docRef := l.docRef;
		SELF := r;
	END;
	fs := NORMALIZE(ds, LEFT.segs, flat1(LEFT,RIGHT));
	RETURN fs;
END;