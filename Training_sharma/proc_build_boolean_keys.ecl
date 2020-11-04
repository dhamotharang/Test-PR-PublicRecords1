IMPORT Text_Search, RoxieKeybuild;

EXPORT proc_build_boolean_keys(STRING fdate, Boolean pDelta=true) := FUNCTION

	filedate:=if(pDelta,fdate+'_delta',fdate);
	Frag := Training_sharma.Fragment_Builder(,,pDelta);

	info := Training_sharma.constants(filedate).fileinfo;

	ansIndxName := Training_sharma.FileName(info, Training_sharma.Types.FileType.AnswerDocX, TRUE);
	ansIndxAlias:= Training_sharma.FileName(info, Training_sharma.Types.FileType.AnswerDocX);
  // If you want this key to be managed in same superkey transaction, place names in 
  // Text_Search.Layouts_Key_Filenames record and pass to Text_Search.Build_From_Postings

	posting := Frag.postings;
	segList := Frag.SegmentDefinitions;
	ansList := Frag.AnswerRecords;
	
	Text_Search.Layout_Key_Filenames makeKNR(STRING pname, STRING aname) := TRANSFORM
    SELF.physical := pname;
    SELF.alias := aname;
    SELF.backup := REGEXREPLACE('::QA::', aname, '::FATHER::', NOCASE);
    SELF.past_backup := REGEXREPLACE('::QA::', aname, '::GRANDFATHER::', NOCASE);
    SELF.obsolete_backup := REGEXREPLACE('::QA::', aname, '::DELETE::', NOCASE);
    SELF.delete_obsolete := TRUE;
  END;
  ans_keys := DATASET([makeKNR(ansIndxName, ansIndxAlias)]);

	bld0 := BUILD(Training_sharma.Indx_AnsRec(ansIndxName, ansList));
  	build_type := IF(pDelta, Text_Search.Types.BuildType.CumulativeIncrement, Text_Search.Types.BuildType.Regular);
	bld1 := Text_Search.Build_From_Postings(info, posting, segList, TRUE, build_type, ans_keys); 

	ex := SEQUENTIAL(
	    bld0,
		bld1
		);
	RETURN ex;
END;