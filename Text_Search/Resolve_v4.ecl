export Resolve_v4(DATASET(Layout_Search_RPN_Set) rpn_srch,
										FileName_Info info, 
										DATASET(Layout_Bookmark) bookmarks, 
										BOOLEAN score=FALSE,
										BOOLEAN keepHits=FALSE,
										INTEGER answers=2000,
										DATASET(Layout_FocusHash) FocusList = DATASET([],Layout_FocusHash),
										BOOLEAN hardLimit=TRUE
										) := FUNCTION

	initR := DATASET([], Layout_MergeWork);
	//Make GLOBAL so evaluated once in the farmer
	executionPlan := GLOBAL(ManipulateRPN.chopOffTerms(rpn_srch), FEW);
	dictStats := CHOOSEN(Indx_DictStat(info), 1); 
	INTEGER8 avgDoc		:= EVALUATE(dictStats[1], meanDocSize) : GLOBAL;
	INTEGER8 docCount := EVALUATE(dictStats[1], docCount) 	 : GLOBAL;
	freqs := Get_Term_Freqs(rpn_srch) : GLOBAL;	
	idx3 := Indx_Nominal3(info);
	p0 := idx3(KEYED(typ=Types.WordType.MetaData 
									AND nominal=Constants.PartitionIDNominal));
	BOOLEAN hasSeq := EXISTS(Indx_Nominal3(info)(KEYED(typ=Types.WordType.SeqKey
																	AND nominal=Constants.SequenceKeyNominal)));
	partitionRecords := LIMIT(p0, Limits.Max_Parts, 
							FAIL(Limits.Parts_Code, Limits.Parts_Msg), KEYED);
	partList := SET(partitionRecords, part);
	INTEGER thisChannel := partitionRecords[1].part;
	
	ex1(Layout_Search_RPN_Set s, SET OF DATASET(Layout_MergeWork) d)
			:= Merge_v4(info, s, d, partList, FocusList);
			
	ais := GRAPH(initR, COUNT(executionPlan), 
									ex1(executionPlan[NOBOUNDCHECK COUNTER], ROWSET(LEFT)), PARALLEL);
	scored   := Score_Docs(ais,freqs,info,partList,avgDoc,docCount,keepHits);
	no_score := Roll2DocHits(ais, keepHits);
	limited  := LIMIT(no_score, Limits.Max_Remote, 
										FAIL(Limits.Remote_Code, Limits.Remote_Msg));
	needSeq  := MAP(hardLimit	=> limited,
									score 	  => scored,
									no_score);
	Layout_DocResolve getSeq(Layout_DocResolve l, idx3 r) := TRANSFORM
		SELF.seq := SequenceKey.Fields2SeqOrdinal(r.seg, r.kwp, r.wip);
		SELF := l;
	END;
	seqAdded := JOIN(needSeq, idx3,
							 KEYED(RIGHT.typ=Types.wordType.SeqKey 
										 AND RIGHT.nominal = Constants.SequenceKeyNominal  
										 AND RIGHT.lseg=0 AND LEFT.part=RIGHT.part
										 AND LEFT.docRef.src=RIGHT.src AND LEFT.docRef.doc=RIGHT.doc),
								getSeq(LEFT, RIGHT), ATMOST(1));
	docs := IF(hasSeq, seqAdded, needSeq);
	selList := TOPN(docs, answers, -score, seq, docRef);
	ansCount:= COUNT(docs);
	selCount:= COUNT(selList);
	start   := 1;  // KLL -- hardcoding 'start' to 1 until bookmarks are fully integrated
	Layout_ScoredFlat flatDocHits(Layout_DocHits l, Layout_SegHit r) := TRANSFORM
		SELF := l;
		SELF := r;
		SELF.subseg := 0;
	END;
	Layout_ScoredFlat clearDetail(Layout_ScoredFlat l) := TRANSFORM
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
													Layout_Result);
	// 
	results := ALLNODES(LOCAL((channel_rslt)));
		
	RETURN results;
END;