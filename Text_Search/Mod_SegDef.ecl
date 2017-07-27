// Segment definition conversion
EXPORT Mod_SegDef(DATASET(Layout_Segment_ComposeDef) in_defs) := MODULE
	// Add generic sequence key segment for binary sequence key
	STRING SeqSegmentName := Constants.SeqKeyField;
  STRING DelSegmentName := Constants.DelKeyField;
	Types.ShortSegName SeqSegName:= MakeShortSeg(SeqSegmentName);
  Types.ShortSegName DelSegName:= MakeShortSeg(DelSegmentName);
	ExtCompDef := DATASET([{SeqSegName, SeqSegmentName, Types.SegmentType.SequenceKey,
                          [SeqSegName]}
                        ,{DelSegName, DelSegmentName, Types.SegmentType.DeleteKey,
                          [DelSegName]}
                        ], Text_Search.Layout_Segment_ComposeDef);
  SHARED defs := in_defs + extCompDef : INDEPENDENT;
	// Collisions
	t0 := TABLE(defs, {shortName}, shortName, 
							StringLib.StringToUpperCase(segName), segType, FEW);
	t1 := TABLE(t0, {shortName, INTEGER c:=COUNT(GROUP)}, shortName, FEW);
	badShort := t1(c>1);
	c0 := JOIN(defs, badShort, LEFT.shortName=RIGHT.shortName,
										TRANSFORM(Layout_Segment_ComposeDef, SELF:=LEFT),
										MANY LOOKUP);
	EXPORT collisions := SORT(c0, shortName, segName);
	
	EXPORT BOOLEAN hasCollision := EXISTS(collisions);
	
	// Make Composite Segment Definitions
	// Enumerate entries for merge
	SHARED Work1 := RECORD(Layout_Segment_ComposeDef) 
		UNSIGNED2		pos;
	END;
	Work1 mark1(Layout_Segment_ComposeDef l, INTEGER c) := TRANSFORM
		SELF.pos := c;
		SELF := l;
	END;
	d0 := PROJECT(defs, mark1(LEFT, COUNTER));	
	d1 := SORT(d0, shortName, pos);
	Work1 prop(Work1 l, Work1 r) := TRANSFORM
		SELF.pos := IF(l.shortName=r.shortName, l.pos, r.pos);
		SELF := r;
	END;
	SHARED enumDefs := ITERATE(d1, prop(LEFT,RIGHT));	// keep lowest position
	SHARED Work2 := RECORD
		Types.SegmentName 	segName{MAXLENGTH(128)};
		Types.SegmentType		segType;
		UNSIGNED2 					segListEntry;
		Types.ShortSegName	shortName;
		Types.ShortSegName 	nameListEntry;
		UNSIGNED2						pos;
		INTEGER2						segs;
		INTEGER2						listPos;
	END;
	Work2 norm1(Work1 l, INTEGER c) := TRANSFORM
		SELF.nameListEntry := l.nameList[c];
		SELF.segs := COUNT(l.nameList);
		SELF.listPos := c;
		SELF := l;
		SELF := [];
	END;
	e0 := NORMALIZE(enumDefs, COUNT(LEFT.nameList), norm1(LEFT, COUNTER));
	e1 := SORT(e0, shortName, nameListEntry, segs, listPos);
	e2 := DEDUP(e1, shortname, nameListEntry, RIGHT);
	SHARED flatlist1 := SORT(e2, pos);
		
	//catch the nested concepts
	e3 := JOIN(flatlist1, flatlist1, LEFT.nameListEntry = RIGHT.shortName,
									TRANSFORM(Work2,
														SELF.segName := LEFT.segName,
														SELF.shortName := LEFT.shortName,
														SELF.nameListEntry :=RIGHT.nameListEntry,
														SELF.segs := LEFT.segs,
														SELF.listPos := LEFT.listPos,
														SELF.segType := LEFT.segType,
														SELF.segListEntry := LEFT.segListEntry,
														SELF.Pos := LEFT.Pos														
														));
	SHARED flatlist2 :=SORT(e3, pos):INDEPENDENT;
		
	SHARED Work3 := RECORD
		Types.ShortSegName	shortName;
		UNSIGNED2						pos;
	END;
	SHARED realSegs := DEDUP(SORT(PROJECT(flatlist2(segs=1), Work3), shortName, pos), shortName);
	
	//find concept which are over 2 levels
	SHARED flatlist3 := JOIN(flatlist2, realSegs, LEFT.nameListEntry = RIGHT.shortName, 
																				transform(Work2, self := left), left only);
	SHARED BOOLEAN hasLevel3Concept := EXISTS(flatlist3);
	
	Work2 getSeg(Work2 l, Work3 r) := TRANSFORM
		SELF.segListEntry := r.pos;
		SELF := l;
	END;
	d4 := JOIN(flatlist2, realSegs, LEFT.nameListEntry=RIGHT.shortName, getSeg(LEFT,RIGHT), LOOKUP, FEW);
	d5 := GROUP(SORT(d4, pos, segListEntry), pos);
	
	Layout_Segment_Definition cvtSegDef(Work2 l, DATASET(Work2) r) := TRANSFORM
		SELF.segName := l.segName;
		SELF.segType := l.segType;
		SELF.segList := SET(r, segListEntry);
	END;
	
	EXPORT SegmentDef := MAP(hasCollision => FAIL(Layout_Segment_Definition,'Segment short name collisions'),
													hasLevel3Concept => FAIL(Layout_Segment_Definition,'Segment definition violate two level constrains'),
													ROLLUP(d5, GROUP, cvtSegDef(LEFT, ROWS(LEFT)))
													);
	
	EXPORT Get_Seg(DATASET(Layout_Posting) p) := IF(NOT hasCollision,
								JOIN(p,realSegs, LEFT.segName=RIGHT.shortName,
											TRANSFORM(Layout_Posting, SELF.seg:=RIGHT.pos, SELF:=LEFT), LOOKUP, FEW),
								FAIL(Layout_Posting, 'Segment short name collisions'));

  EXPORT SetSegs(DATASET(Layout_Posting) p) := Get_Seg(p) 
                : DEPRECATED('Replace with Build_From_Posting');
END;