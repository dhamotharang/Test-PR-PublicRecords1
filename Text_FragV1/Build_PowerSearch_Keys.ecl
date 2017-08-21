//
IMPORT Text_Search;
EXPORT Build_PowerSearch_Keys(STRING filedate) := FUNCTION

	Frag := Text_FragV1.Fragment_Builder();

	STRING stem := '~THOR_DATA400::FULL';
	STRING sourceType := 'FRAGS';
	STRING qual := filedate;
	info := Text_Search.FileName_Info_Instance(stem, sourceType, qual);

	ansIndxName := Text_FragV1.FileName(info, Text_FragV1.Types.FileType.AnswerDocX, TRUE);
	ansIndxAlias:= Text_FragV1.FileName(info, Text_FragV1.Types.FileType.AnswerDocX);

	posting := Frag.postings;
	segList := Frag.SegmentMetaData;
	ansList := Frag.SelectedAnswerRecords;

	kwd  := Text_Search.KeywordingFunc(info);
	bld1 := Text_Search.Build_From_Inversion(info, posting, kwd, FALSE, FALSE, TRUE, segList);

	bld2 := BUILD(Text_FragV1.Indx_AnsRec(ansIndxName, ansList));

	MakeAXAlias := SEQUENTIAL(
		IF(NOT FileServices.SuperFileExists(ansIndxAlias), 
				FileServices.CreateSuperFile(ansIndxAlias)),
		FileServices.ClearSuperFile(ansIndxAlias, TRUE),
		FileServices.AddSuperFile(ansIndxAlias, ansIndxName)  );

	ex := SEQUENTIAL(
		bld1,
		bld2,
		Frag.Cleanup_Persist,
		MakeAXAlias);
	RETURN ex;
END;