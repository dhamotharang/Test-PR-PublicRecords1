//
IMPORT Text_Search, RoxieKeybuild;
EXPORT proc_build_boolean_keys(STRING filedate, Boolean pDelta=true) := FUNCTION

	Frag := bair_boolean.Fragment_Builder(,,pDelta);

	info := bair_boolean.constants(filedate).fileinfo;

	ansIndxName := bair_boolean.FileName(info, bair_boolean.Types.FileType.AnswerDocX, TRUE);
	ansIndxAlias:= bair_boolean.FileName(info, bair_boolean.Types.FileType.AnswerDocX);
  // If you want this key to be managed in same superkey transaction, place names in 
  // Text_Search.Layouts_Key_Filenames record and pass to Text_Search.Build_From_Postings

	posting := Frag.postings;
	segList := Frag.SegmentDefinitions;
  ansList := Frag.AnswerRecords;
	
  //resolve collisions, not incremental
	bld1 := Text_Search.Build_From_Postings(info, posting, segList, TRUE, pDelta); 

	bld2 := BUILD(bair_boolean.Indx_AnsRec(ansIndxName, ansList));

	RoxieKeybuild.Mac_SK_Move_V3(regexreplace('::qa::',ansIndxAlias,'::@version@::',nocase),'D',mvansIndxAlias,filedate,'2');
	
	/*
	MakeAXAlias := SEQUENTIAL(
		IF(NOT FileServices.SuperFileExists(ansIndxAlias), 
				FileServices.CreateSuperFile(ansIndxAlias)),
		FileServices.ClearSuperFile(ansIndxAlias, TRUE),
		FileServices.AddSuperFile(ansIndxAlias, ansIndxName)  );*/

	ex := SEQUENTIAL(
		bld1,
		bld2,
		//Frag.Cleanup_Persist,
		mvansIndxAlias);
	RETURN ex;
END;