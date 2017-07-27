EXPORT Segment_Metadata(Filename_Info info, BOOLEAN online=FALSE) := MODULE

	EXPORT version := IF(online, Meta_Version(info), Constants.CurrSegmentBuild);

	onlineDefs := PROJECT(NOFOLD(LIMIT(Indx_Segment_Definition(info),
																			Limits.max_Segments, 
																			FAIL(Limits.Segments_Code, Limits.Segments_Msg))), 
												Layout_Segment_Definition);
	offlineDefs := PROJECT(File_Segment_Definition(info), Layout_Segment_Definition);
	SHARED segDefs := CHOOSEN(IF(online, onlineDefs, offlineDefs), Limits.Max_Segments);
	// Locate ExternalKey segment (if defined)
	KeySegs := SORT(SegDefs(segType=Types.SegmentType.ExternalKey),segList[1]);
	EXPORT KeySeg := IF(exists(KeySegs),KeySegs[1].segList[1],0);											

	EXPORT Flat_SegDef := RECORD
		Types.Segment 			seg;
		Types.Segment				attrID;
		INTEGER2						sibs;
		Types.SegmentType 	segType;
		Types.SegmentName 	segName{MAXLENGTH(128)};
	END;

	// flat single segments
	SET OF Types.SegmentType sl := [Types.SegmentType.TextType, 
																	Types.SegmentType.DateType,
																	Types.SegmentType.NumericType,
																	Types.SegmentType.SSN,
																	Types.SegmentType.FieldDataType,
																	Types.SegmentType.Phone];
	Flat_SegDef makeSegTab(segDefs l) := TRANSFORM
		SELF.segName := StringLib.StringToUpperCase(l.segName);
		SELF.segType := l.segType;
		SELF.seg 		 := l.segList[1];		// always just 1
		SELF.attrID  := 0;
		SELF.sibs		 := 0;
	END;
	s1 := PROJECT(segDefs(COUNT(seglist)=1 AND segType IN sl), makeSegTab(LEFT));
	SHARED singles := DEDUP(SORT(s1, seg, segType, segName),seg);

	// Assign identities to Concatenated Segments and mod table
	Last_Seg := MAX(singles, seg);	
	Work_Def := RECORD(Layout_Segment_Definition)
		Types.Segment concat;
	END;
	Work_Def cvtCGrp(segDefs l, INTEGER c) := TRANSFORM
		SELF.concat := c + Last_Seg;
		SELF.segName:= STRINGLIB.StringToUpperCase(l.segname);
		SELF := l;
	END;
	SHARED w_defs  := PROJECT(segDefs(segType=Types.SegmentType.ConcatSeg), 
														cvtCGrp(LEFT, COUNTER));
	Flat_SegDef flattenDef(w_defs l, INTEGER c) := TRANSFORM
		SELF.attrID := l.segList[c];
		SELF.seg 		:= l.concat;
		SELF.sibs		:= COUNT(l.segList) - 1;
		SELF				:= l;
	END;
	f0 := NORMALIZE(w_defs, COUNT(LEFT.segList), flattenDef(LEFT, COUNTER));

	f1 := DEDUP(SORT(f0, seg, attrID), seg, attrID);
	f_defs := JOIN(f1, singles, LEFT.attrID=RIGHT.seg,
								TRANSFORM(Flat_SegDef, SELF.segName:=RIGHT.segName, SELF:=LEFT),
								LEFT OUTER);
	remList := TABLE(f_defs, {attrID}, attrID, FEW, UNSORTED);
	f_sing := JOIN(singles, remList, LEFT.seg=RIGHT.attrID,
								 TRANSFORM(Flat_SegDef, SELF:=LEFT),
								 LEFT ONLY, LOOKUP);
	list1 := IF(version > 1, f_defs + f_sing, singles);
	Flat_SegDef fixBrk(Flat_SegDef l, STRING1 s, STRING1 t) := TRANSFORM
		SELF.segName := StringLib.StringFindReplace(l.segName, s, t);
		SELF := l;
	END;
	l_h := PROJECT(list1, fixBrk(LEFT, '-', '_'));
	l_u := PROJECT(list1, fixBrk(LEFT, '_', '-'));
	EXPORT Flat_SegTab := DEDUP(SORT(l_h+l_u, segname, seg, attrID), segName, seg, attrID);


	// Fixup the original format
	Layout_Segment_Definition fixSeg(w_defs l) := TRANSFORM
		SELF.segList := [l.concat];
		SELF := l;
	END;
	csegs := PROJECT(w_defs, fixSeg(LEFT));
	list2 := IF(version > 1, csegs + segDefs(segType<>Types.SegmentType.ConcatSeg), segDefs);
	Layout_Segment_Definition cvtSegList(segDefs l, STRING1 s, STRING1 t) := TRANSFORM
		SELF.segName := StringLib.StringFindReplace(StringLib.StringToUpperCase(l.segName), s, t);
		SELF := l;
	END;
	segN_h := PROJECT(list2, cvtSegList(LEFT, '-', '_'));
	segN_u := PROJECT(list2, cvtSegList(LEFT, '_', '-'));

	EXPORT Norm_SegTab := DEDUP(SORT(segN_h + segN_u, segName, -segType), segName);

	typeSet(Types.SegmentType typ) := SET(singles(segType=typ), seg);
	Work1 := RECORD
		Types.SegmentName 	segName{MAXLENGTH(128)};
	END;
	Work1 n1(Layout_Segment_Definition l, INTEGER c, 
					SET OF Types.Segment SegsOfType) := TRANSFORM
		SELF.segName := IF(l.segList[c] IN SegsOfType, l.segName, SKIP);
	END;
	EXPORT typeNames(Types.SegmentType typ) := NORMALIZE(Norm_SegTab, 
																								COUNT(LEFT.segList), 
																								n1(LEFT, COUNTER, typeSet(typ)));
	EXPORT BOOLEAN isType(STRING name, Types.SegmentType typ) 
		:= StringLib.StringToUpperCase(name) IN SET(typeNames(typ), segName);
		
	EXPORT BOOLEAN isSegName(STRING name) 
		:= StringLib.StringToUpperCase(name) IN SET(Norm_SegTab, segName);

	EXPORT getDef(STRING name) 
		:= Norm_SegTab(segName = name)[1].segList;

END;