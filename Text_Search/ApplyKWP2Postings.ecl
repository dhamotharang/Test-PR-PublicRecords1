IMPORT LIB_Word;
// Apply local keyword numbers, Postings must be in sequence so that data is contiguous within
//segments and within concatenation groups if keyword position ranges are to be continuous.
//If postings for a segment are not contiguous, the keyword position ranges will not be 
//continuous.
//
// NOTE: This function sets the type of the term.
// NOTE: This function has not been written to work with free text segments.
//
EXPORT ApplyKWP2Postings(DATASET(Layout_Posting) fieldData, 
												 DATASET(Layout_Segment_ComposeDef) segDefs) := FUNCTION
	// Mark pos information when 0
  Layout_Posting c0(Layout_Posting prev, Layout_Posting curr) := TRANSFORM
    SELF.pos := MAP(curr.pos>0              => curr.pos,
                    prev.rid=curr.rid       => prev.pos + prev.len,
                    1);
    SELF := curr;
  END;
  with_pos := ITERATE(fieldData, c0(LEFT,RIGHT), LOCAL);
  // Split fileds into posting, generate equivalence postings
	postings := SplitCompoundPostings.TypeAndSplit(with_pos, segDefs);
	
	// Determine concat segs
	w_defs := segDefs(segType=Types.SegmentType.ConcatSeg);
	Flat_Def := RECORD
		Types.ShortSegName def;
		Types.ShortSegName seg;
	END;
	Flat_Def flattenDef(Layout_Segment_ComposeDef l, INTEGER c) := TRANSFORM
		SELF.seg := l.nameList[c];
		SELF.def := l.shortName;
	END;
	f0 := NORMALIZE(w_defs, COUNT(LEFT.nameList), flattenDef(LEFT, COUNTER));
	
	f_defs := DEDUP(SORT(f0, seg, def), LEFT);
	
	Work_Posting := RECORD(Layout_Posting)
    UNSIGNED8 rel_pos;
    UNSIGNED4 kwp_adj;
		Text_Search.Types.SourceID srx;
		Text_Search.Types.DocID		 doc;
		Types.SegmentType	 segType;
		Types.ShortSegName def;
	END;
	Work_Posting applyConcat(Layout_Posting l, Flat_def r) := TRANSFORM
		SELF.def := r.def;
		SELF.srx := l.docRef.src;
		SELF.doc := l.docRef.doc;
		SELF := l;
		SELF := [];
	END;
	d0 := JOIN(postings, f_defs, LEFT.segName=RIGHT.seg,
							applyConcat(LEFT,RIGHT), LEFT OUTER, LOOKUP, FEW);
	Work_Posting applyType(Work_Posting l, Layout_Segment_ComposeDef r) := TRANSFORM
		SELF.segType := r.segType;
		SELF := l;
	END;
	d_inv := JOIN(d0, segDefs, LEFT.segName=RIGHT.shortName,
							applyType(LEFT, RIGHT), LEFT OUTER, LOOKUP, FEW);
	
	// number keywords
	Work_Posting c1(Work_Posting l, Work_Posting r) := TRANSFORM
		SELF.kwp := MAP(l.doc <> r.doc					=> 1,
										l.srx <> r.srx					=> 1,
										l.rid <> r.rid					=> l.kwp + Constants.InterSubSegDistance,
										l.segName = r.segName		=> IF(l.typ = Types.WordType.MultiEquiv,l.kwp,l.kwp + 1),
										l.def = ' '							=> l.kwp + Constants.InterSubSegDistance,
										l.def <> r.def					=> l.kwp + Constants.InterSubSegDistance,
										l.kwp + 1);
    SELF.rel_pos := l.rel_pos + IF(l.doc<>r.doc OR l.srx<>r.srx, 1, 0);
		SELF := r;
	END;
	inv_0	:= ITERATE(d_inv, c1(LEFT, RIGHT), LOCAL);
  
	RETURN PROJECT(inv_0, Layout_Posting);
END;