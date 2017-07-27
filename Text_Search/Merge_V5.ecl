EXPORT Merge_V5(FileName_Info info,
										Layout_Search_RPN_Set sr,
										SET OF DATASET(Layout_MergeWork) workSets,
										SET OF Types.PartitionID partList,
										DATASET(Layout_FocusHash) FocusList = DATASET([],Layout_FocusHash)
										):= FUNCTION
	code_GET 			:= Map_Search_Operands.code_GET;
	code_RNGGET 	:= Map_Search_Operands.code_RNGGET;
	code_AND			:= Map_Search_Operands.code_AND;
	code_ANDNOT		:= Map_Search_Operands.code_ANDNOT;
	code_OR				:= Map_Search_Operands.code_OR;
	code_Phrase		:= Map_Search_Operands.code_Phrase;
	code_WSEG			:= Map_Search_Operands.code_WSEG;
	code_NOTWSEG	:= Map_Search_Operands.code_NOTWSEG;
	code_PRE			:= Map_Search_Operands.code_PRE;
	code_NOTPRE		:= Map_Search_Operands.code_NOTPRE;
	code_W				:= Map_Search_Operands.code_W;
	code_NOTW			:= Map_Search_Operands.code_NOTW;
	code_BUTNOT		:= Map_Search_Operands.code_BUTNOT;
	code_FOCGET		:= Map_Search_Operands.code_FOCGET;
	code_ANDOR		:= Map_Search_Operands.code_ANDOR;
	code_ANY2			:= Map_Search_Operands.code_ANY2;
	code_ALLBUT1	:= Map_Search_Operands.code_ALLBUT1;
	code_HALF			:= Map_Search_Operands.code_HALF;
	Indx 					:= Indx_Nominal3(info);
  Indx_Focus    := Indx_ExternalKeyIn(info);
	
	
	// Helpers for nominal/suffix tests
	deferred 			:= sr.inputs[1].deferWildCard;
	wd2 					:= Wild_Lookup2(info, sr.inputs[1].searchArg);
	defSuffixes 	:= wd2.Get_Suffix_List;
	defNominals		:= wd2.Get_Nominal_List;
	OprndSuffix   := sr.inputs[1].suffixes[1];
	OprndSuffix2  := sr.inputs[1].suffixes[2];
	OprndSuffixes	:= IF(deferred, defSuffixes, sr.inputs[1].suffixes);
	OprndTyp			:= sr.inputs[1].typ;
	OprndNominal	:= sr.inputs[1].nominals[1];
	OprndNominal2	:= sr.inputs[1].nominals[2];
	OprndNominals := IF(deferred, defNominals, sr.inputs[1].nominals);
	OprndFilter		:= sr.inputs[1].filterType;
	OprndTermID		:= sr.inputs[1].id;
	OprndSegList	:= sr.inputs[1].seglist;
	inputCount		:= MAX(COUNT(sr.inputs), 3);
	halfCount			:= MAX((inputCount + 1) DIV 2, 2);
	
	
	// Helpers for operation access
	maxPhrase			:= sr.maxPhraseLength;
	maxLeft				:= sr.maxLeftWindow;
	maxRight			:= sr.maxRightWindow;
	
	// Filter attributes for index read, only done on GET unary operation
	d_IN(Types.Nominal nom) := nom IN OprndNominals;
	d_GT(Types.Nominal nom) := nom >  OprndNominal;		
	d_GE(Types.Nominal nom) := nom >= OprndNominal;
	d_LT(Types.Nominal nom) := nom <  OprndNominal;	
	d_LE(Types.Nominal nom) := nom <= OprndNominal;
	d_EQ(Types.Nominal nom) := nom =  OprndNominal;
	d_RG(Types.Nominal nom) := nom >= OprndNominal AND nom <= OprndNominal2;
	fd(Types.Nominal nom) := 
			(OprndFilter=Types.NominalFilter.IN_Filter  AND d_IN(nom)) OR
			(OprndFilter=Types.NominalFilter.GT_Filter  AND d_GT(nom)) OR
			(OprndFilter=Types.NominalFilter.GE_Filter  AND d_GE(nom)) OR
			(OprndFilter=Types.NominalFilter.LT_Filter  AND d_LT(nom)) OR
			(OprndFilter=Types.NominalFilter.LE_Filter  AND d_LE(nom)) OR
			(OprndFilter=Types.NominalFilter.EQ_Filter  AND d_EQ(nom)) OR
			(OprndFilter=Types.NominalFilter.RNG_Filter AND d_RG(nom));
			
	g_IN(Types.NominalSuffix v) := v  IN OprndSuffixes;
	g_GE(Types.NominalSuffix v) := v 	>= OprndSuffix;
	g_GT(Types.NominalSuffix v) := v  >  OprndSuffix;
	g_LE(Types.NominalSuffix v) := v  <= OprndSuffix;
	g_LT(Types.NominalSuffix v) := v  <  OprndSuffix;
	g_EQ(Types.NominalSuffix v) := v  =  OprndSuffix;
	g_RG(Types.NominalSuffix v) := v >=  OprndSuffix AND v <= OprndSuffix2;
	gd(Types.NominalSuffix s) := CASE(OprndFilter,
												Types.NominalFilter.IN_Filter  => g_IN(s),
												Types.NominalFilter.GT_Filter  => g_GT(s),
												Types.NominalFilter.GE_Filter  => g_GE(s),
												Types.NominalFilter.LT_Filter  => g_LT(s),
												Types.NominalFilter.LE_Filter  => g_LE(s),
												Types.NominalFilter.EQ_Filter  => g_EQ(s),
												Types.NominalFilter.RNG_Filter => g_RG(s),
												FALSE);
	// Pickup inputs
	SET OF Types.Stage inputSet := SET(sr.inputs, stageIn);
	inputs := RANGE(workSets, inputSet);
	// Transforms for get and merges
	Layout_MergeWork copyAIS(Indx x) := TRANSFORM
		SELF.src				:= x.src;
		SELF.doc				:= x.doc;
		SELF.kwp 				:= x.kwp;
		SELF.wip				:= x.wip;
		SELF.termID			:= OprndTermID;
		SELF.seg				:= x.seg;
		SELF.subSeg			:= 0;
		SELF.part				:= x.part;
		SELF.stage 			:= sr.stage;
	END;
	Layout_MergeWork mrgAIS(Layout_MergeWork l, 
												DATASET(Layout_MergeWork) allrows) := TRANSFORM
		SELF.wip := SUM(allrows, wip);
		SELF.kwp := MIN(allrows, kwp);
		SELF.stage := sr.stage;
		SELF := l;
	END;
	Layout_MergeWork fltOlap(Layout_MergeWork l,
												DATASET(Layout_MergeWork) allrows) := TRANSFORM
		rhs := allrows[2..];		// All but this LEFT
		BOOLEAN olap := EXISTS(rhs(l.kwp>=kwp AND l.kwp<=kwp+wip));
		SELF.subseg := IF(olap, SKIP, 0);
		SELF := l;
	END;
	W_Hits := RECORD
		Types.stage 		stage;
		Types.Distance	leftWindow;
		Types.Distance	rightWindow;
		Layout_MergeHit;
		BOOLEAN 				failThis;
	END;
	W_Hits mrgControl(Layout_MergeWork l, Layout_RPN_Oprnd r) := TRANSFORM
		SELF.stage := l.stage;
		SELF.leftWindow := r.leftWindow;
		SELF.rightWindow := r.rightWindow;
		SELF.failThis := FALSE;
		SELF := l;
	END;
	
	BOOLEAN dTest(Layout_MergeWork l, Layout_MergeWork r, INTEGER ld, INTEGER rd)
			:= l.kwp + maxPhrase + ld >= r.kwp
				AND r.kwp + maxPhrase + rd >= l.kwp;
	
	W_Hits chkDistance(W_Hits l, W_Hits r, BOOLEAN bothSides) := TRANSFORM
		SELF.failThis := MAP(
				l.stage=0																					=> FALSE,		//first time
				l.kwp<r.kwp AND l.kwp+l.wip+r.leftWindow>r.kwp		=> FALSE,
				bothSides=FALSE																		=> TRUE,		// PRE/n
				r.kwp<l.kwp AND r.kwp+r.wip+r.rightWindow>l.kwp		=> FALSE,
				TRUE);
		SELF := r;
	END;
			
	Layout_MergeWork chkMPC(Layout_MergeWork l, 
												DATASET(Layout_MergeWork) allrows,
												BOOLEAN bothSides, BOOLEAN includeRight) := TRANSFORM
		w1 := JOIN(allrows, sr.inputs, LEFT.stage=RIGHT.stageIn,
							mrgControl(LEFT, RIGHT), LOOKUP);
		w2 := ITERATE(w1, chkDistance(LEFT, RIGHT, bothSides));
		BOOLEAN anyFail := EXISTS(w2(failThis));
		BOOLEAN anyGood := EXISTS(w2(NOT failThis AND stage<>l.stage));
		SELF.subseg := IF(includeRight, IF(anyFail, SKIP, 0), IF(anyGood, SKIP, 0));
		SELF.kwp := IF(includeRight, MIN(allrows, kwp), l.kwp);
		SELF.wip := IF(includeRIght, MAX(allrows, kwp+wip) - SELF.kwp, l.wip);
		SELF := l;
	END;

	// ***************************************************************************
	// Get operation with segment filtering
	p2 := Indx(KEYED(typ=OprndTyp AND fd(nominal))
						 AND seg IN OprndSegList AND suffix=0);
	p3 := STEPPED(SORTED(p2, part, src, doc, seg, kwp), part, src, doc, seg, kwp);
	p4 := PROJECT(p3, copyAIS(LEFT));
	Proj_NDX := SORTED(p4, part, src, doc, seg, kwp);
	
	// Range filtering get operation
	q2 := Indx(KEYED(typ=OprndTyp AND nominal=0 AND lseg IN OprndSegList)
						 AND gd(suffix));
	q3 := STEPPED(SORTED(q2, part, src, doc, seg, kwp), part, src, doc, seg, kwp);
	q4 := PROJECT(q3, copyAIS(LEFT));
	Proj_RNG := SORTED(q4, part, src, doc, seg, kwp);
	
	// AND operation
	and_1 := MERGEJOIN(inputs, 
						 STEPPED(LEFT.part=RIGHT.part AND LEFT.src=RIGHT.src AND LEFT.doc=RIGHT.doc),
						 part, src, doc, seg, kwp, DEDUP);
	AND_Stages := SORTED(and_1, part, src, doc, seg, kwp);
	// ANY2 operation (2 of N)
	any2_1  := MERGEJOIN(inputs,
							STEPPED(LEFT.part=RIGHT.part AND LEFT.src=RIGHT.src AND LEFT.doc=RIGHT.doc),
							part, src, doc, seg, kwp, MOFN(2), DEDUP);
	ANY2_Stages := SORTED(any2_1, part, src, doc, seg, kwp);
	// All but 1 merge
	ab_1		:= MERGEJOIN(inputs, 
							STEPPED(LEFT.part=RIGHT.part AND LEFT.src=RIGHT.src AND LEFT.doc=RIGHT.doc),
							part, src, doc, seg, kwp, MOFN(inputCount-1), DEDUP);
	ALLBUT1_Stages := SORTED(ab_1, part, src, doc, seg, kwp);
	// Half the inputs present
	half_1 	:= MERGEJOIN(inputs,
							STEPPED(LEFT.part=RIGHT.part AND LEFT.src=RIGHT.src AND LEFT.doc=RIGHT.doc),
							part, src, doc, seg, kwp, MOFN(halfCount), DEDUP);
	HALF_Stages := SORTED(half_1, part, src, doc, seg, kwp);
	// ANDOR operation  
	andor_1 := MERGEJOIN(inputs,
							STEPPED(LEFT.part=RIGHT.part AND LEFT.src=RIGHT.src AND LEFT.doc=RIGHT.doc),
							part, src, doc, seg, kwp, LEFT OUTER, DEDUP);
	ANDOR_Stages := SORTED(andor_1, part, src, doc, seg, kwp);
	// And NOT operation
	andnot_1 := MERGEJOIN(inputs, 
						STEPPED(LEFT.part=RIGHT.part AND LEFT.src=RIGHT.src AND LEFT.doc=RIGHT.doc),
						part, src, doc, seg, kwp, LEFT ONLY, DEDUP);
	ANDNOT_Stages := SORTED(andnot_1, part, src, doc, seg, kwp);
	// Phrase AND operation
	phrase_1 := JOIN(inputs, 
					 STEPPED(LEFT.part=RIGHT.part AND LEFT.src=RIGHT.src AND LEFT.doc=RIGHT.doc) 
						AND RIGHT.kwp = LEFT.kwp + LEFT.wip,
						mrgAIS(LEFT,ROWS(LEFT)), SORTED(part, src, doc, seg, kwp));
	Phrase_Stages := SORTED(phrase_1, part, src, doc, seg, kwp);
	// OR operation
	or_1 := MERGE(inputs, part, src, doc, seg, kwp, 
								SORTED(part, src, doc, seg, kwp), DEDUP);
	OR_Stages := SORTED(or_1, part, src, doc, seg, kwp);
	// BUT NOT Operation
	butnot_1 := JOIN(inputs,
					 STEPPED(LEFT.part=RIGHT.part AND LEFT.src=RIGHT.src AND LEFT.doc=RIGHT.doc)
					 AND LEFT.kwp BETWEEN RIGHT.kwp AND RIGHT.kwp+RIGHT.wip,
					 fltOlap(LEFT, ROWS(LEFT)), LEFT OUTER,
					 SORTED(part, src, doc, seg, kwp));
	ButNot_Stages := SORTED(butnot_1, part, src, doc, seg, kwp);
	// Within Segment operator
	wseg_1 := MERGEJOIN(inputs, 
						STEPPED(LEFT.part=RIGHT.part AND LEFT.src=RIGHT.src AND LEFT.doc=RIGHT.doc)
						AND LEFT.seg=RIGHT.seg,
						part, src, doc, seg, kwp, DEDUP);
	WSeg_Stages := SORTED(wseg_1, part, src, doc, seg, kwp);
	// Not Within Segment operator	
	notwseg_1 := MERGEJOIN(inputs, 
						STEPPED(LEFT.part=RIGHT.part AND LEFT.src=RIGHT.src AND LEFT.doc=RIGHT.doc)
						AND LEFT.seg=RIGHT.seg,
						part, src, doc, seg, kwp, LEFT ONLY, DEDUP);
	NotWSeg_Stages := SORTED(notwseg_1, part, src, doc, seg, kwp);
	// Within Merge and PRE/n Merge
	wn_1	:= JOIN(inputs,
						STEPPED(LEFT.part=RIGHT.part AND LEFT.src=RIGHT.src AND LEFT.doc=RIGHT.doc) 
						AND dTest(LEFT, RIGHT, maxLeft, maxRight),
						chkMPC(LEFT, ROWS(LEFT), sr.opCode=code_W, TRUE), 
						SORTED(part, src, doc, seg, kwp));
	W_Stages := SORTED(wn_1, part, src, doc, seg, kwp);
	// NOT W/n and NOT PRE/n
	notwn_1 := JOIN(inputs,
						STEPPED(LEFT.part=RIGHT.part AND LEFT.src=RIGHT.src AND LEFT.doc=RIGHT.doc)
						AND LEFT.seg=RIGHT.seg AND dTest(LEFT, RIGHT, maxLeft, maxRight),
						chkMPC(LEFT, ROWS(LEFT), sr.opCode=code_NOTW, FALSE),
						LEFT OUTER, SORTED(part, src, doc, seg, kwp));
	NOTW_Stages := SORTED(notwn_1, part, src, doc, seg, kwp);
	// Focus Get

	Layout_MergeWork makeFocusAIS(Indx_Focus x) := TRANSFORM
		SELF.src				:= x.src;
		SELF.doc				:= x.doc;
		SELF.part				:= x.part;
		SELF 		      	:= [];
	END;

	HashSet := SET(FocusList, HashKey);

	foc1 := Indx_Focus(KEYED(HashKey in  HashSet));
	foc2 := STEPPED(SORTED(foc1, part, src, doc), part, src, doc);
	foc3 := PROJECT(foc2, makeFocusAIS(LEFT));
	Proj_FOCUS := SORTED(foc3, part, src, doc, seg, kwp); 
	
	
	//***************************************************************
	// Run merge
	rslt := CASE(sr.opCode,
		code_GET 			=>	Proj_NDX,
		code_RNGGET		=>  Proj_RNG,
		code_AND			=>	AND_Stages,
		code_ANDOR		=>	ANDOR_Stages,
		code_ANDNOT		=>	ANDNOT_Stages,
		code_OR				=>	OR_Stages,
		code_Phrase		=>	Phrase_Stages,
		code_BUTNOT		=>	ButNot_Stages,
		code_WSEG			=>  WSeg_Stages,
		code_NOTWSEG	=>	NotWSeg_Stages,
		code_W				=>	W_Stages,
		code_PRE			=>	W_Stages,		
		code_NOTW			=>	NOTW_Stages,
		code_NOTPRE		=> 	NOTW_Stages,
		code_FOCGET   =>  Proj_FOCUS,
		code_ANY2			=>  ANY2_Stages,
		code_ALLBUT1	=>	ALLBUT1_Stages,
		code_HALF			=>	HALF_Stages,
		DATASET([], Layout_MergeWork));
		
	RETURN rslt;
END;
