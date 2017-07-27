//  Unified Text Search function
//	Replaces Text_Search_Module and Focus_Search_Module
emptyBookMarks := DATASET([], Layout_Bookmark);
emptyFocusList := DATASET([],Layout_ExternalKey);

EXPORT Text_Search_V3(FileName_Info info, StandardSearchArgs args):= MODULE
	// Standard identifiers for display
	EXPORT ndx_name := FileName(info, Types.FileTypeEnum.NominalNdx3);
	EXPORT dct_name := FileName(info, Types.FileTypeEnum.DictIndx3);
	EXPORT DictVersion := Dict_Version(info);
	
	// Parse Boolean request
	kwdMod := KeywordingFunc(info, TRUE);
	BOOLEAN expEqv := args.EqvExp;
	rqstMod := Search_Request_Module(info, kwdMod, args.srchString, expEqv);
	rpnBoolean := rqstMod.RPN_Search_Request;
	rpnFreestyle := Freestyle_Parse(info, kwdMod, args.srchString);
	SHARED rpn0 := IF(args.runBoolean, rpnBoolean, rpnFreestyle);
	EXPORT rpn_srch := IF(EXISTS(args.focusList), Focus_RPN_Add(rpn0), rpn0);
	
	LimitedFocusList := LIMIT(args.focusList, Limits.Max_Focus,
	                          FAIL(Limits.FocusLim_Code, Limits.FocusLim_Msg));
	
	// Convert Focus Keys

	Layout_FocusHash gethash(Layout_ExternalKey l) := TRANSFORM
	  self.HashKey := HASH64(l.ExternalKey);
	END;
	HashedFocusList := PROJECT( LimitedFocusList, gethash(LEFT) ) : GLOBAL;
	
	
	// Resolve search
	rslv := Resolve_v5(rpn_srch, info, args.bookMarks, args.rankResult, 
											args.showHits, args.ansLimit, HashedFocusList, 
											args.LAFN, args.valueLAFN);
	SHARED rslt := IF(args.runSearch, rslv) : GLOBAL;

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
		Types.SequenceKeyType seq;
	END;
	
	Layout_DocHitNorm getAnswers(Layout_ScoredFlat doc, 
															 Layout_Result parent) := TRANSFORM
		SELF := doc;
		SELF := parent;
	END;
	
	SHARED flatRslt := NORMALIZE(rslt, LEFT.docs, getAnswers(RIGHT,LEFT));
	rawList := DEDUP(PROJECT(flatRslt, Layout_DocList), RECORD);
	
	limitedList := IF(totalCount < args.valueLAFN, 
										rawList, 
										FAIL(Layout_DocList, Limits.AnsLim_Code, Limits.AnsLim_Msg));
	useList := IF(args.LAFN,limitedList,rawList);
  SHARED ansList := TOPN(useList, args.ansLimit, -score, seq, docRef);
	
	EXPORT resultCount := COUNT(ansList);
	
	selDocs := JOIN(flatRslt, ansList, LEFT.docRef=RIGHT.docRef,
												TRANSFORM(Layout_ScoredFlat, SELF:=LEFT),
												LOOKUP);
	flatAnswers := SORT(selDocs, -score, seq, docRef, seg, kwp, wip);
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
	
	MatchedKeys := JOIN( ExternalKeys, args.focusList,
	                     left.ExternalKey = right.ExternalKey,
											 TRANSFORM( RECORDOF(ExternalKeys), self := left ),
											 LOOKUP );
											 
	EXPORT ExtKeyAnswers := IF( EXISTS(args.focusList),
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
	
	Layout_Bookmark getBkmarks(all_chan_cnts L, Layout_Bookmark R) := TRANSFORM
		SELF.channel := L.channel;
		SELF.totalCount := L.totalCount;
		SELF.pos := R.pos + L.cnt + 1;
	END;
  EXPORT bookmarks := JOIN(all_chan_cnts, args.bookMarks, LEFT.channel = RIGHT.channel, 
														getBkmarks(LEFT,RIGHT), LEFT OUTER);

	// Message
	SHARED INTEGER MessageBase	:= 10000;
	SHARED STRING	Bad_Srch_Msg 		:= 'Search request could not be parsed';
	SHARED INTEGER Bad_Srch_Code	:= MessageBase + 1;
	
	SHARED parseFail := ~EXISTS(rpn_srch) AND args.srchString<>'';
  EXPORT error_code := IF(parseFail, Bad_Srch_Code, 0);
	EXPORT error_msg := IF(parseFail, Bad_Srch_Msg, '');
END;