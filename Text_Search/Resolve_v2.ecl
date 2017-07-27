export Resolve_v2(DATASET(Layout_Search_RPN_Set) rpn_srch,
										FileName_Info info, 
										DATASET(Layout_Bookmark) bookmarks, 
										BOOLEAN score=FALSE,
										BOOLEAN keepHits=FALSE,
										INTEGER answers=2000) := FUNCTION

	initR := DATASET([], Layout_MergeWork);
	//Make GLOBAL so evaluated once in the farmer
	executionPlan := GLOBAL(rpn_srch, FEW);
	dictStats := PROJECT(CHOOSEN(Indx_DictStat(info), 1), Layout_DictStats); 
	UNSIGNED8 maxFreq := max_Freq_Term(dictStats) : GLOBAL;
	SET OF UNSIGNED8 freqs := Get_Term_Freqs(rpn_srch) : GLOBAL;
	p0 := Indx_Nominal2(info)(KEYED(typ=Types.WordType.MetaData 
																	AND nominal=Constants.PartitionIDNominal)
														AND WILD(lpart));
	partitionRecords := LIMIT(p0, Limits.Max_Parts, 
							FAIL(Limits.Parts_Code, Limits.Parts_Msg), KEYED);
	partList := SET(partitionRecords, part);
	INTEGER thisChannel := partitionRecords[1].part;
	
	ex1(Layout_Search_RPN_Set s, SET OF DATASET(Layout_MergeWork) d)
			:= Merge_v2(info, s, d, partList);
			
	resolve := GRAPH(initR, COUNT(executionPlan), 
									ex1(executionPlan[NOBOUNDCHECK COUNTER], ROWSET(LEFT)), PARALLEL);
	Layout_AIS cvt2AIS(Layout_MergeWork l) := TRANSFORM
		SELF.docRef.src := l.src;
		SELF.docRef.doc := l.doc;
		SELF := l;
	END;
	ais		 := PROJECT(resolve, cvt2AIS(LEFT));
	scored := Score_Answers(ais, freqs, info, partList, maxFreq, keepHits);
	allDocs := LIMIT(PROJECT(Slim_Answers(ais, FALSE), 
										TRANSFORM(Layout_DocScore, SELF.score:=0.0, SELF:=LEFT)), 
									Limits.Max_Remote, FAIL(Limits.Remote_Code, Limits.Remote_Msg));
	docList := IF(score, scored, allDocs);
	slim   := Slim_Answers(ais, keepHits);
	selList := Select_Docs(docList, bookMarks, answers);
	docCount := COUNT(docList);
	selCount := COUNT(selList);
	start := 1;  // KLL -- hardcoding 'start' to 1 until bookmarks are fully integrated
	selected := Filter_AIS(slim, selList);
	// Make result record
	channel_rslt := DATASET([{docCount, selCount, start, thisChannel, selected}], 
													Layout_Result);
	// 
	results := ALLNODES(LOCAL((channel_rslt)));
		
	RETURN results;
END;