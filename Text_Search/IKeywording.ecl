EXPORT IKeywording := INTERFACE
	EXPORT Search_Term := RECORD
		Types.WordType		typ;
		Types.WordStr			word;
	END;
	EXPORT Types.NominalSuffix dictVersion := 0;		
	EXPORT Types.SegmentType defaultSegType := Types.SegmentType.TextType;
	EXPORT Types.SegmentType getSegType(Types.SegmentName name) := defaultSegType;
	// Single string
	EXPORT Types.WordStr defaultWord(Types.WordStr str) := str;
	EXPORT Types.WordStr typeWord(Types.WordStr str, Types.SegmentType segType,
																	 Types.Segment seg=-1, BOOLEAN equivalent=FALSE) := str;
	EXPORT Types.WordStr segWord(Types.WordStr str, Types.SegmentName segName):=str;
	// use multi-part keywording
	EXPORT BOOLEAN useSequence	:= FALSE;	// sequence using keyword positions
	EXPORT BOOLEAN useBag				:= FALSE; // bag of terms, single keyword position
	// sequence or bag for keywords
	EXPORT DATASET(Search_Term) defaultSeq(Types.WordStr str) 
									:= DATASET([{Types.WordType.TextStr, str}], Search_Term);
	EXPORT DATASET(Search_Term) typeSeq(Types.WordStr str, Types.Segment seg, 
															 Types.SegmentType segType) 
									:= DATASET([{Types.WordType.TextStr, str}], Search_Term);
	EXPORT DATASET(Search_Term) segSeq(Types.WordStr str, Types.SegmentName segName) 
									:= DATASET([{Types.WordType.TextStr, str}], Search_Term);
END;