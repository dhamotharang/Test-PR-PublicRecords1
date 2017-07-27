export Resolve_v3(DATASET(Layout_Search_RPN_Set) rpn_srch,
										FileName_Info info, 
										DATASET(Layout_Bookmark) bookmarks, 
										BOOLEAN score=FALSE,
										BOOLEAN keepHits=FALSE,
										INTEGER answers=2000) := FUNCTION

	initR := DATASET([], Layout_MergeWork);
	//Make GLOBAL so evaluated once in the farmer
	executionPlan := GLOBAL(ManipulateRPN.chopOffTerms(rpn_srch), FEW);
	dictStats := CHOOSEN(Indx_DictStat(info), 1); 
	INTEGER8 avgDoc		:= EVALUATE(dictStats[1], meanDocSize) : GLOBAL;
	INTEGER8 docCount := EVALUATE(dictStats[1], docCount) 	 : GLOBAL;
	freqs := Get_Term_Freqs(rpn_srch) : GLOBAL;	
	p0 := Indx_Nominal3(info)(KEYED(typ=Types.WordType.MetaData 
																	AND nominal=Constants.PartitionIDNominal));
	partitionRecords := LIMIT(p0, Limits.Max_Parts, 
							FAIL(Limits.Parts_Code, Limits.Parts_Msg), KEYED);
	partList := SET(partitionRecords, part);
	INTEGER thisChannel := partitionRecords[1].part;
	
	ex1(Layout_Search_RPN_Set s, SET OF DATASET(Layout_MergeWork) d)
			:= Merge_v3(info, s, d, partList);
			
	resolve := GRAPH(initR, COUNT(executionPlan), 
									ex1(executionPlan[NOBOUNDCHECK COUNTER], ROWSET(LEFT)), PARALLEL);
	Layout_AIS cvt2AIS(Layout_MergeWork l) := TRANSFORM
		SELF.docRef.src := l.src;
		SELF.docRef.doc := l.doc;
		SELF := l;
	END;
	ais		 := PROJECT(resolve, cvt2AIS(LEFT));
	scored := Score_Answers(ais, freqs, info, partList, avgDoc, docCount, keepHits);
	allDocs := LIMIT(PROJECT(Slim_Answers(ais, FALSE), 
										TRANSFORM(Layout_DocScore, SELF.score:=0.0, SELF:=LEFT)), 
									Limits.Max_Remote, FAIL(Limits.Remote_Code, Limits.Remote_Msg));
	docList := IF(score, scored, allDocs);
	slim    := Slim_Answers(ais, keepHits);
	selList := Select_Docs(docList, bookMarks, answers);
	ansCount:= COUNT(docList);
	selCount:= COUNT(selList);
	start   := 1;  // KLL -- hardcoding 'start' to 1 until bookmarks are fully integrated
	selected := Filter_AIS(slim, selList);
	// Make result record
	channel_rslt := DATASET([{ansCount, selCount, start, thisChannel, selected}], 
													Layout_Result);
	// 
	results := ALLNODES(LOCAL((channel_rslt)));
		
	RETURN results;
END;