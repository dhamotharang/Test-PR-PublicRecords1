// The default keywording routine
IMPORT lib_StringLib;

EXPORT KeywordingFunc(FileName_Info info, BOOLEAN onLine=FALSE, UNSIGNED ver=0,
											Types.SegmentType segType=0) := MODULE(IKeywording)
	EXPORT Types.SegmentType defaultSegType := IF(segType=0, Types.SegmentType.TextType, segType);
	Work_SegDef := RECORD
		Types.Segment 			seg;
		Types.SegmentType 	segType;
		Types.SegmentName 	segName{MAXLENGTH(128)};
	END;
	SegListX := NOFOLD(LIMIT(Indx_Segment_Definition(info), 
													 Limits.max_Segments, FAIL(Limits.Segments_Code, Limits.Segments_Msg))
							(COUNT(seglist)=1));
	Work_SegDef makeSegTab(SegListX l, BOOLEAN u2h) := TRANSFORM
		STRING segName := StringLib.StringToUpperCase(l.segName);
	SELF.segType := l.segType;
		SELF.seg := l.segList[1];		// always just 1
		SELF.segName := IF(u2h, 
												StringLib.StringFindReplace(segName, '_', '-'),
												StringLib.StringFindReplace(segName, '-', '_'));
	END;
	s1 := PROJECT(SegListX, makeSegTab(LEFT, TRUE));
	s2 := PROJECT(SegListX, makeSegTab(LEFT, FALSE));
	SHARED SegTab := DEDUP(SORT(s1 + s2, segName, -segType), segName);

	EXPORT Types.SegmentType getSegType(Types.SegmentName name) :=
					IF(EXISTS(SegTab(segName=name)), 
						 EVALUATE(SegTab(segName=name)[1], segType),
						 defaultSegType);

	// Locate ExternalKey segment (if defined)
	KeySegs := SORT(SegTab(segType=Types.SegmentType.ExternalKey),seg);
	EXPORT KeySeg := IF(exists(KeySegs),KeySegs[1].seg,0);
						 
	bldVer := IF(ver = 0, Constants.CurrDictVer, ver);
	EXPORT dictVersion := IF(onLine, Dict_Version(info), bldVer);

	EXPORT Types.WordStr typeWord(Types.WordStr str, Types.SegmentType segType, 
															 Types.Segment seg=-1, BOOLEAN equivalent=FALSE) := FUNCTION
		Types.WordStr textStr := TRIM(StringLib.StringToUpperCase(str));
		Types.WordStr stemStr := Stem_Word(str);
		Types.WordStr rslt := MAP(
														dictVersion < 2												 => stemStr,
														equivalent														 => textStr,
														segType=Types.SegmentType.FreeTextType => stemStr, 
														textStr);
		RETURN rslt;
	END;

	EXPORT Types.WordStr defaultWord(Types.WordStr str) 
			:= typeWord(str, Types.SegmentType.TextType);

  EXPORT Types.WordStr segWord(Types.WordStr str, Types.SegmentName segName) := FUNCTION
		RETURN typeWord(str, getSegType(segName));
	END;

END;