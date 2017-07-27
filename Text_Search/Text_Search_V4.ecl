//  Unified Text Search function
//	Replaces Text_Search_Module and Focus_Search_Module
emptyBookMarks := DATASET([], Text_Search.Layout_Bookmark);
emptyFocusList := DATASET([],Text_Search.Layout_ExternalKey);

EXPORT Text_Search_V4(Text_Search.FileName_Info info, Text_Search.StandardSearchArgs args):= MODULE
	// Standard identifiers for display
	EXPORT ndx_name := Text_Search.FileName(info, Text_Search.Types.FileTypeEnum.NominalNdx3);
	EXPORT dct_name := Text_Search.FileName(info, Text_Search.Types.FileTypeEnum.DictIndx3);
	EXPORT DictVersion := Text_Search.Dict_Version(info);
	
	// Parse Boolean request
	kwdMod := Text_Search.KeywordingFunc(info, TRUE);
	BOOLEAN expEqv := args.EqvExp;
	rqstMod := Text_Search.Search_Request_Module_V2(info, kwdMod, args.srchString, expEqv);
	rpnBoolean := rqstMod.RPN_Search_Request;
	// Freestyle not currently being supported in Text_Search_V4
	// rpnFreestyle := Text_Search.Freestyle_Parse(info, kwdMod, args.srchString);
	// SHARED rpn0 := IF(args.runBoolean, rpnBoolean, rpnFreestyle);
	ASSERT(args.runBoolean,'Freestyle currently not supported by Text_Search_V4',FAIL); 

	SHARED rpn0 := rpnBoolean;
	EXPORT parsetype := args.runBoolean;
	rpn_srch_focus := IF(EXISTS(args.focusList), Text_Search.Focus_RPN_Add(rpn0), rpn0);
	
	EXPORT rpn_srch := IF(args.isAlert,Text_Search.Alert_RPN_Add(info,rpn_srch_focus,args),rpn_srch_focus);
		
	LimitedFocusList := LIMIT(args.focusList, Text_Search.Limits.Max_Focus,
	                          FAIL(Text_Search.Limits.FocusLim_Code, Text_Search.Limits.FocusLim_Msg));
	
	// Convert Focus Keys

	Text_Search.Layout_FocusHash gethash(Text_Search.Layout_ExternalKey l) := TRANSFORM
	  self.HashKey := HASH64(l.ExternalKey);
	END;
	HashedFocusList := PROJECT( LimitedFocusList, gethash(LEFT) ) : GLOBAL;
	
	// rpn_srch2 := DATASET([],Layout_Search_RPN_Set);
	
	// Resolve search
	rslv := Text_Search.Resolve_v6(rpn_srch, info, args.bookMarks, args.rankResult, 
											args.showHits, args.ansLimit, HashedFocusList, 
											args.LAFN, args.valueLAFN, args.SourceList);
	SHARED rslt := IF(args.runSearch, rslv) : GLOBAL;

	// Information about the answers
	EXPORT totalCount := SUM(rslt,totalCount);
	EXPORT selCount := SUM(rslt,thisCount);
	
	SHARED Layout_DocHitNorm := RECORD
		Text_Search.Layout_Result.totalCount;
		Text_Search.Layout_Result.thisCount;
		Text_Search.Layout_Result.channel;
		Text_Search.Layout_Result.start;
		Text_Search.Layout_ScoredFlat;
	END;
	SHARED Layout_DocList := RECORD
		Text_Search.Layout_Result.totalCount;
		Text_Search.Layout_Result.thisCount;
		Text_Search.Layout_Result.channel;
		Text_Search.Layout_Result.start;
		Text_Search.Types.DocRef 		docRef;
		Text_Search.Types.Score 		score;
		Text_Search.Types.SequenceKeyType seq;
	END;
	
	Layout_DocHitNorm getAnswers(Text_Search.Layout_ScoredFlat doc, 
																						Text_Search.Layout_Result parent) := TRANSFORM
		SELF := doc;
		SELF := parent;
	END;
	
	SHARED flatRslt := NORMALIZE(rslt, LEFT.docs, getAnswers(RIGHT,LEFT));
	rawList := DEDUP(PROJECT(flatRslt, Layout_DocList), RECORD);
	
	limitedList := IF(totalCount < args.valueLAFN, 
										rawList, 
										FAIL(Layout_DocList, Text_Search.Limits.AnsLim_Code, Text_Search.Limits.AnsLim_Msg));
	useList := IF(args.LAFN,limitedList,rawList);
  SHARED ansList := TOPN(useList, args.ansLimit, -score, seq, docRef);
	
	EXPORT resultCount := COUNT(ansList);
	
	selDocs := JOIN(flatRslt, ansList, LEFT.docRef=RIGHT.docRef,
												TRANSFORM(Text_Search.Layout_ScoredFlat, SELF:=LEFT),
												LOOKUP);
	flatAnswers := SORT(selDocs, -score, seq, docRef, seg, kwp, wip);
	EXPORT answers := Text_Search.Rollup_DocRefs(flatAnswers);
	
	// Make answers with external keys available
	Text_Search.Layout_DocHitsKeys AddKeys( Text_Search.Layout_DocHits l, RECORDOF(Text_Search.Indx_ExtKeyOut2(info)) r) := TRANSFORM
	  SELF.ExternalKey := r.ExternalKey;
		SELF := l;
	END;
	ExternalKeys := JOIN(answers, Text_Search.Indx_ExtKeyOut2(info), 
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
	
	Text_Search.Layout_Bookmark getBkmarks(all_chan_cnts L, Text_Search.Layout_Bookmark R) := TRANSFORM
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