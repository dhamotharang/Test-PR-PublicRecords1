// Aliases
LayoutDocSegAlias := Text_Search.Layout_DocSeg;
SourceId := Text_Search.Types.SourceID;

// ---------------------
EXPORT LayoutDocSegAlias Pipe_2_DocSeg(STRING inFile,
																			 SourceId srcId,
																			 UNSIGNED2 segLen) := FUNCTION
	// Defs
	MAX_STRLEN := 40000;
	LargeString := STRING40000;

	// For parsing
	PATTERN DATE := 'DATE:';
	PATTERN HEADLINE := 'HEADLINE:';
	PATTERN BODY := 'BODY:';
	PATTERN non_ws := PATTERN('[^ .:;,"|\t\r\n]');
	PATTERN word := non_ws+;
	RULE r1 := DATE OR HEADLINE OR BODY or word;

	RawInput := RECORD
		LargeString line;
	END;

	LayoutDocSegAlias toDocSeg(RawInput l) := TRANSFORM
		STRING matchedStr := MATCHTEXT(word);
		SELF.segment := MAP(MATCHED(DATE) => 3,
												MATCHED(HEADLINE) => 1,
												MATCHED(BODY) => 2,
												0);
		SELF.content := CASE(SELF.segment,
												 0 => matchedStr, '');
		SELF.docRef.src := srcId;
		SELF := [];
	END;

	LayoutDocSegAlias setDocNum(LayoutDocSegAlias l, LayoutDocSegAlias r) := TRANSFORM
		BOOLEAN isTag := r.segment <> 0;
		UNSIGNED llen := LENGTH(l.content);
		BOOLEAN fits := llen + LENGTH(r.content) < segLen;
		STRING concatStr := IF(fits AND llen > 0, l.content + ' ' + r.content, r.content);
		SELF.docRef.doc := IF(~isTag AND l.segment = 3, l.docRef.doc + 1, l.docRef.doc);
		SELF.segment := IF(isTag, r.segment, l.segment);
		SELF.sect := IF(isTag, 0, IF(fits, l.sect, l.sect + 1));
		SELF.content := IF(isTag, '', concatStr);
		SELF := r;
	END;

	input := DATASET(inFile, RawInput, CSV(separator('\000'), MAXLENGTH(MAX_STRLEN)));
	manyWords := PARSE(input, line, r1, toDocSeg(LEFT), BEST, MANY, MAXLENGTH(MAX_STRLEN));
	smallerSet := ITERATE(manyWords, setDocNum(LEFT, RIGHT));
	return ROLLUP(smallerSet, TRANSFORM(RIGHT), segment, sect);
END;

// Change these
STRING inFile := '~THOR::REGRESSION::in::SIMPLE_DOC::SMALL_TEST';
//STRING inFile := '~THOR::JDH::in::SIMPLE_DOC::SMALL_TEST';
STRING qual := 'SMALL_TEST';
STRING stem := '~THOR::REGRESSION';
STRING srcType := 'SIMPLE';
info := Text_Search.FileName_Info_Instance(stem, srcType, qual);

whatever := Pipe_2_DocSeg(inFile, 1, 1000);
d := SORT(DISTRIBUTE(whatever, HASH32(docRef.doc)), 
					docRef.src, docRef.doc, segment, sect, LOCAL);
fName := Text_Search.FileName(info, Text_Search.Types.FileTypeEnum.DocSeg, TRUE);
sfName := Text_Search.FileName(info, Text_Search.Types.FileTypeEnum.DocSeg);
SEQUENTIAL(
	IF(NOT FileServices.SuperFileExists(sfName),
			FileServices.CreateSuperFile(sfName)),
	FileServices.ClearSuperFile(sfName),
	OUTPUT(d,, fname, OVERWRITE),
	FileServices.StartSuperFileTransaction(),
	FileServices.AddSuperFIle(sfName, fName),
	FileServices.FinishSuperFileTransaction() );

