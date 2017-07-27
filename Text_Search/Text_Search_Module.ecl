// Prototypical text search function.  Returns list of hits

emptyBk := DATASET([], Layout_Bookmark);

export Text_Search_Module(FileName_Info info, STRING srch, 
											    BOOLEAN scoreResults = FALSE,
											    BOOLEAN keepHits=FALSE,
											    DATASET(Layout_Bookmark) bkmarks = emptyBk, 
													INTEGER docs=2000, BOOLEAN runSrch = TRUE,
													BOOLEAN expEqv = TRUE,
													BOOLEAN expDrctWildcard = FALSE) := MODULE
													
	
  EXPORT ndx_name := FileName(info, Types.FileTypeEnum.NominalNdx3);
	EXPORT dct_name := FileName(info, Types.FileTypeEnum.DictIndx3);
	EXPORT DictVersion := Dict_Version(info);

	// Parse request
	kwdMod := KeywordingFunc(info, TRUE);
	SHARED rqst := Search_Request_Module(info, kwdMod, srch, expEqv, expDrctWildcard);
	EXPORT rpn_srch := rqst.RPN_Search_Request;
	
	// Resolve search
	rslv := Resolve_v3(rpn_srch, info, bkmarks, scoreResults, keephits, docs);
	SHARED rslt := IF(runSrch, rslv) : GLOBAL;

	// Information about the answers
	EXPORT totalCount := SUM(rslt,totalCount);
	EXPORT selCount := SUM(rslt,thisCount);
	
	SHARED Layout_DocHitNorm := RECORD
		Layout_Result.totalCount;
		Layout_Result.thisCount;
		Layout_Result.channel;
		Layout_Result.start;
		Layout_ScoredFlat;
	END;
	SHARED Layout_DocList := RECORD
		Layout_Result.totalCount;
		Layout_Result.thisCount;
		Layout_Result.channel;
		Layout_Result.start;
		Types.DocRef 		docRef;
		Types.Score 		score;
	END;
	
	Layout_DocHitNorm getAnswers(Layout_ScoredFlat doc, 
															 Layout_Result parent) := TRANSFORM
		SELF := doc;
		SELF := parent;
	END;
	
	SHARED flatRslt := NORMALIZE(rslt, LEFT.docs, getAnswers(RIGHT,LEFT));
	rawList := DEDUP(PROJECT(flatRslt, Layout_DocList), RECORD);
	limitedList := LIMIT(rawList, docs, FAIL(Limits.AnsLim_Code, Limits.AnsLim_Msg));
	useList := SORT(IF(scoreResults,rawList,limitedList), -score, docRef);
  SHARED ansList := CHOOSEN(useList, docs);
	
	EXPORT resultCount := COUNT(ansList);
	
	selDocs := JOIN(flatRslt, ansList, LEFT.docRef=RIGHT.docRef,
												TRANSFORM(Layout_ScoredFlat, SELF:=LEFT),
												LOOKUP);
	flatAnswers := SORT(selDocs, -score, docRef, seg, kwp, wip);
	EXPORT answers := Rollup_DocRefs(flatAnswers);
	
	used_chan_cnts := TABLE(ansList, {channel, totalCount, 
													cnt := COUNT(GROUP)}, channel, totalCount);
	
	used_chan_cnts getChans(rslt L, used_chan_cnts R) := TRANSFORM
		SELF.cnt := R.cnt;
		SELF := L;
	END;
  SHARED all_chan_cnts := JOIN(rslt, used_chan_cnts, LEFT.channel = RIGHT.channel, 
																getChans(LEFT,RIGHT), LEFT OUTER);
	
	Layout_Bookmark getBkmarks(all_chan_cnts L, bkmarks R) := TRANSFORM
		SELF.channel := L.channel;
		SELF.totalCount := L.totalCount;
		SELF.pos := R.pos + L.cnt + 1;
	END;
  EXPORT bookmarks := JOIN(all_chan_cnts, bkmarks, LEFT.channel = RIGHT.channel, 
														getBkmarks(LEFT,RIGHT), LEFT OUTER);

	// Message
	SHARED INTEGER MessageBase	:= 10000;
	SHARED STRING	Bad_Srch_Msg 		:= 'Search request could not be parsed';
	SHARED INTEGER Bad_Srch_Code	:= MessageBase + 1;
	
	SHARED parseFail := ~EXISTS(rpn_srch) AND srch<>'';
  EXPORT error_code := IF(parseFail, Bad_Srch_Code, 0);
	EXPORT error_msg := IF(parseFail, Bad_Srch_Msg, '');
END;