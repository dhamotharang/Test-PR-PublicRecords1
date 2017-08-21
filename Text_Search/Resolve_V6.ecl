IMPORT AutoStandardI,MDR;
EXPORT Resolve_V6(DATASET(Text_Search.Layout_Search_RPN_Set) rpn_srch,
										Text_Search.FileName_Info info, 
										DATASET(Text_Search.Layout_Bookmark) bookmarks, 
										BOOLEAN score=FALSE,
										BOOLEAN keepHits=FALSE,
										INTEGER answers=2000,
										DATASET(Text_Search.Layout_FocusHash) FocusList = DATASET([],Text_Search.Layout_FocusHash),
										BOOLEAN hardLimit=TRUE,
										INTEGER hardLimitValue=Text_Search.Limits.Max_Remote,
										Types.SourceList sources=ALL
										) := FUNCTION

	initR := DATASET([], Text_Search.Layout_MergeWork);
	//Make GLOBAL so evaluated once in the farmer
	executionPlan := GLOBAL(Text_Search.ManipulateRPN.chopOffTerms(rpn_srch), FEW);
	dictStats := CHOOSEN(Text_Search.Indx_DictStat(info), 1); 
	INTEGER8 avgDoc		:= EVALUATE(dictStats[1], meanDocSize) : GLOBAL;
	INTEGER8 docCount := EVALUATE(dictStats[1], docCount) 	 : GLOBAL;
	freqs := Text_Search.Get_Term_Freqs(rpn_srch) : GLOBAL;	
	idx3 := Text_Search.Indx_Nominal3(info);
	p0 := idx3(KEYED(typ=Text_Search.Types.WordType.MetaData 
									AND nominal=Text_Search.Constants.PartitionIDNominal));
	BOOLEAN hasSeq := EXISTS(Text_Search.Indx_Nominal3(info)(KEYED(typ=Text_Search.Types.WordType.SeqKey
																	AND nominal=Constants.SequenceKeyNominal)));
	partitionRecords := LIMIT(p0, Text_Search.Limits.Max_Parts, 
							FAIL(Text_Search.Limits.Parts_Code, Text_Search.Limits.Parts_Msg), KEYED);
	partList := SET(partitionRecords, part);
	INTEGER thisChannel := partitionRecords[1].part;
	
	ex1(Text_Search.Layout_Search_RPN_Set s, SET OF DATASET(Text_Search.Layout_MergeWork) d)
			:= Text_Search.Merge_v6(info, s, d, partList, FocusList, sources);
			
	ais := GRAPH(initR, COUNT(executionPlan), 
									ex1(executionPlan[NOBOUNDCHECK COUNTER], ROWSET(LEFT)), PARALLEL);
	scored   := Text_Search.Score_Docs(ais,freqs,info,partList,avgDoc,docCount,keepHits);
	no_score := Text_Search.Roll2DocHits(ais, keepHits);
	thisLimit:= IF(Text_Search.Limits.Max_Remote<hardLimitValue, Text_Search.Limits.Max_Remote, hardLimitValue);
	limited  := LIMIT(no_score, thisLimit, 
										FAIL(Text_Search.Limits.Remote_Code, Text_Search.Limits.Remote_Msg));
	// lower limit makes searches fail sooner, gamble that distribution of answers
	//is not extremely skewed to a few nodes.
	needSeq  := MAP(hardLimit	=> limited,
									score 	  => scored,
									no_score);
	Text_Search.Layout_DocResolve getSeq(Text_Search.Layout_DocResolve l, idx3 r) := TRANSFORM
		SELF.seq := Text_Search.SequenceKey.Fields2SeqOrdinal(r.seg, r.kwp, r.wip);
		SELF := l;
	END;
	seqAdded := JOIN(needSeq, idx3,
							 KEYED(RIGHT.typ=Text_Search.Types.wordType.SeqKey 
										 AND RIGHT.nominal = Text_Search.Constants.SequenceKeyNominal  
										 AND RIGHT.lseg=0 AND LEFT.part=RIGHT.part
										 AND LEFT.docRef.src=RIGHT.src AND LEFT.docRef.doc=RIGHT.doc),
								getSeq(LEFT, RIGHT), ATMOST(1));
	docs := IF(hasSeq, seqAdded, needSeq);

	// GLB and DPPA Purpose
	glbMod := AutoStandardI.GlobalModule();
	AllowGLB := AutoStandardI.InterfaceTranslator.glb_ok.val(PROJECT(glbMod,AutoStandardI.InterfaceTranslator.glb_ok.params));
	AllowDPPA := AutoStandardI.InterfaceTranslator.dppa_ok.val(PROJECT(glbMod,AutoStandardI.InterfaceTranslator.dppa_ok.params)); 
	Text_Search.Layout_DocResolve filterGlbDppa(Text_Search.Layout_DocResolve l) := TRANSFORM
		STRING2 src := ASSTRING(l.docRef.src);
		SELF.score  := IF(NOT AllowGLB AND (src IN MDR.sourceTools.set_GLB),SKIP,l.score);
		SELF.seq    := IF(NOT AllowDPPA AND (src IN MDR.sourceTools.set_DPPA_sources),SKIP,l.seq);
		SELF				:= l;
	END;
	
	docsFiltered := project(docs, filterGlbDppa(LEFT));

	selList := TOPN(docsFiltered, answers, -score, seq, docRef);
	ansCount:= COUNT(docsFiltered);
	selCount:= COUNT(selList);
	start   := 1;  // KLL -- hardcoding 'start' to 1 until bookmarks are fully integrated
	Text_Search.Layout_ScoredFlat flatDocHits(Text_Search.Layout_DocHits l, Text_Search.Layout_SegHit r) := TRANSFORM
		SELF := l;
		SELF := r;
		SELF.subseg := 0;
	END;
	Text_Search.Layout_ScoredFlat clearDetail(Text_Search.Layout_ScoredFlat l) := TRANSFORM
		SELF.docRef := l.docRef;
		SELF.score  := l.score;
		SELF.seq    := l.seq;
		SELF				:= [];
	END;
	s0 := NORMALIZE(selList, LEFT.entries, flatDocHits(LEFT, RIGHT));
	s1 := PROJECT(DEDUP(s0, docRef.src, docRef.doc), clearDetail(LEFT));
	selected := IF(COUNT(s0)>Limits.Max_Hits, s1, s0);
	
	// Make result record
	channel_rslt := DATASET([{ansCount, selCount, start, thisChannel, selected}], 
													Text_Search.Layout_Result);
	// 
	results := ALLNODES(LOCAL((channel_rslt)));
	
	RETURN results;
END;
