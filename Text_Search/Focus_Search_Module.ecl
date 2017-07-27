// Prototypical text search function.  Returns list of hits

emptyBk := DATASET([], Layout_Bookmark);

export Focus_Search_Module(FileName_Info info, STRING srch, 
											    BOOLEAN scoreResults = FALSE,
											    BOOLEAN keepHits=FALSE,
											    DATASET(Layout_Bookmark) bkmarks = emptyBk, 
													INTEGER docs=1000, BOOLEAN runSrch = TRUE,
													BOOLEAN expEqv = TRUE,
													DATASET(Layout_ExternalKey) FocusList = DATASET([],Layout_ExternalKey),
													Text_Search.Alert_Info.AlertParams AlertInfo = Text_Search.Alert_Info.SetAlertParams()
													) := MODULE
													
	
  EXPORT ndx_name := FileName(info, Types.FileTypeEnum.NominalNdx3);
	EXPORT dct_name := FileName(info, Types.FileTypeEnum.DictIndx3);
	EXPORT DictVersion := Dict_Version(info);
	
	// Parse request
	kwdMod := KeywordingFunc(info, TRUE);
	SHARED rqst := Search_Request_Module(info, kwdMod, srch, expEqv);
	rpn_srch_focus := IF(EXISTS(FocusList),
												Focus_RPN_Add(rqst.RPN_Search_Request),
												rqst.RPN_Search_Request);
	
	EXPORT rpn_srch := IF(AlertInfo.isAlert,
													Text_Search.Alert_RPN_Add(info,rpn_srch_focus,AlertInfo),
													rpn_srch_focus);
	
	LimitedFocusList := LIMIT(FocusList, Limits.Max_Focus,
	                                FAIL(Limits.FocusLim_Code, Limits.FocusLim_Msg));
	
	// Convert Focus Keys

	Layout_FocusHash gethash(FocusList l) := TRANSFORM
	  self.HashKey := HASH64(l.ExternalKey);
	END;
	HashedFocusList := PROJECT( LimitedFocusList, gethash(LEFT) ) : GLOBAL;
	
	
	// Resolve search
	rslv := Resolve_v4(rpn_srch, info, bkmarks, scoreResults, keephits, docs, HashedFocusList);
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
	
	// Make answers with external keys available
	Layout_DocHitsKeys AddKeys( Layout_DocHits l, RECORDOF(Indx_ExternalKeyOut(info)) r) := TRANSFORM
	  SELF.ExternalKey := r.ExternalKey;
		SELF := l;
	END;
	ExternalKeys := JOIN(answers, Indx_ExternalKeyOut(info), 
	                             KEYED(left.docref.src=right.src and
															 left.docref.doc=right.doc),
															 AddKeys(LEFT,RIGHT), LIMIT(Limits.Max_Join));
	
	MatchedKeys := JOIN( ExternalKeys, FocusList,
	                     left.ExternalKey = right.ExternalKey,
											 TRANSFORM( RECORDOF(ExternalKeys), self := left ),
											 LOOKUP );
											 
	EXPORT ExtKeyAnswers := IF( EXISTS(FocusList),
	                            MatchedKeys,
															ExternalKeys );
	
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