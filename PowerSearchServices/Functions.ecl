IMPORT Text_Search;

EXPORT Functions := MODULE

	EXPORT Layouts.scoreRec rpn2Score(DATASET(Text_Search.Layout_Search_RPN_Set) rpn_srch) := FUNCTION
		scoreFamily := RECORD
			Layouts.scoreRec;
			DATASET(Layouts.scoreRec) children{MAXCOUNT(Text_Search.Limits.Max_Wild)};
		END;
		Layouts.scoreRec bearChildren(Text_Search.Layout_RPN_Oprnd L,INTEGER ndx,INTEGER termCnt) := TRANSFORM
			SELF.searcharg := stringLib.stringToUpperCase(L.terms[ndx]);
			SELF.freq := L.freq / termCnt;
			SELF := [];
		END;
		scoreFamily createFamily(Text_Search.Layout_RPN_Oprnd L) := TRANSFORM
			termCnt := COUNT(L.terms);
			SELF.key := IF(L.freq=0,SKIP,0);
			SELF.searcharg := stringLib.stringToUpperCase(L.searcharg);
			SELF.freq := L.freq / termCnt;
			SELF.children := NORMALIZE(DATASET(ROW(L,Text_Search.Layout_RPN_Oprnd)),termCnt,bearChildren(LEFT,COUNTER,termCnt));
			SELF := [];
		END;
		inputs := DEDUP(SORT(NORMALIZE(rpn_srch(opCode=Text_Search.Map_Search_Operands.code_GET),
			LEFT.inputs,TRANSFORM(Text_Search.Layout_RPN_Oprnd,SELF:=RIGHT)),freq,searcharg),freq,searcharg);
		family := PROJECT(inputs,createFamily(LEFT));
		parents := PROJECT(family,Layouts.scoreRec);
		children := NORMALIZE(family,LEFT.children,TRANSFORM(Layouts.scoreRec,SELF:=RIGHT));
		scoreRecs := DEDUP(SORT(parents+children,freq,searcharg),freq,searcharg);
		REAL sumFreq := SUM(scoreRecs,freq);
		Layouts.scoreRec calcRatios(Layouts.scoreRec L) := TRANSFORM
			SELF.ratio := sumFreq / L.freq;
			SELF := L;
		END;
		ratios := PROJECT(scoreRecs,calcRatios(LEFT));
		REAL sumRatio := SUM(ratios,ratio);
		Layouts.scoreRec calcScores(Layouts.scoreRec L) := TRANSFORM
			score := (L.ratio / sumRatio) * Constants.MAX_SCORE;
			SELF.score := IF(score>Constants.MIN_SCORE,TRUNCATE(score),Constants.MIN_SCORE);
			SELF := L;
		END;
		RETURN PROJECT(ratios,calcScores(LEFT)); 
	END;

	EXPORT Layouts.answerRec assignScores(DATASET(Layouts.answerRec) answerHits,
			DATASET(Text_Search.Layout_Search_RPN_Set) rpn_srch) := FUNCTION
		scoreRecs := rpn2Score(rpn_srch);
		answerRecs :=	PROJECT(answerHits,Transforms.assignAnswers(LEFT,COUNTER));
		answerScoreRecs := JOIN(answerRecs,scoreRecs,LEFT.key=RIGHT.key,Transforms.scoreAnswers(LEFT,RIGHT),ALL);
	RETURN ROLLUP(answerScoreRecs,LEFT.seq=Right.seq,Transforms.rollupAnswers(LEFT,RIGHT));
	END;
	
END;