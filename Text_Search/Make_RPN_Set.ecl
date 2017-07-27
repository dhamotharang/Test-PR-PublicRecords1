// Convert unary/binary RPN Stack into n-ary RPN stack
//
export Make_RPN_Set(DATASET(Layout_Search_RPN) rpnInput) := FUNCTION

	SET OF Types.OpCode unaryOps := [Map_Search_Operands.code_GET,
																	 Map_Search_Operands.code_RNGGET];
	SET OF Types.OpCode binaryOps:= [Map_Search_Operands.code_BUTNOT,
																	 Map_Search_Operands.code_NOTW,
																	 Map_Search_Operands.code_NOTPRE,
																	 Map_Search_Operands.code_NOTWSEG];

	// mark and reorder the operations
	Work1 := RECORD(Layout_Search_RPN)
		INTEGER newStage;
		INTEGER cls;
	END;
	Work1 classify(Layout_Search_RPN l) := TRANSFORM
		SELF.newStage := 0;
		SELF.cls := CASE(l.opCode,
											Map_Search_Operands.code_GET			=> 0,
											Map_Search_Operands.code_RNGGET		=> 0,
											Map_Search_Operands.code_Phrase		=> 1,
											9);
		SELF := l;
	END;
	d1 := PROJECT(rpnInput, classify(LEFT));
	d2 := SORT(d1, cls, stage);

	// determine the new stage numbers
	Work1 assignNewStage(Work1 l, Work1 r) := TRANSFORM
		SELF.newStage := MAP(
					r.cls=0									=> l.newStage + 1,
					l.opCode<>r.opCode			=> l.newStage + 1,
					l.stage<>r.st 					=> l.newStage + 1,
					r.opCode IN binaryOps		=> l.newStage + 1,
					l.newStage);
		SELF := r;
	END;
	d3 := ITERATE(d2, assignNewStage(LEFT,RIGHT));

	// Update the operands
	Work1 getIn(Work1 l, Work1 r, INTEGER opernd) := TRANSFORM
		SELF.st := IF(opernd<>1, l.st, r.newStage);
		SELF.en := IF(opernd=1, l.en, r.newStage);
		SELF.A := l.A;
		SELF := l;
	END;
	d4 := JOIN(d3, d3, LEFT.st=RIGHT.stage, getIn(LEFT,RIGHT,1), LEFT OUTER);
	d5 := JOIN(d4, d3, LEFT.en=RIGHT.stage, getIn(LEFT,RIGHT,2), LEFT OUTER);

	// Update the stage and sequence operations
	Work1 setStage(Work1 l) := TRANSFORM
		SELF.stage := l.newStage;
		SELF := l;
	END;
	d6 := PROJECT(SORT(d5, newStage, stage), setStage(LEFT));

	// Now convert to new format
	Layout_Search_RPN_Set cvtOp(Layout_Search_RPN l) := TRANSFORM
		Layout_RPN_Oprnd cvtOprnd(Layout_Search_operand opr) := TRANSFORM
			SELF.leftWindow := l.leftWindow;
			SELF.rightWindow := l.leftWindow;
			SELF := opr;
		END;

		makeInputsForPhrase(Layout_Search_operand opr) := FUNCTION
			Layout_RPN_Oprnd makeFake(Layout_Search_operand opr, UNSIGNED2 cnt) := TRANSFORM
				SELF.stageIn := cnt + l.st - 1;
				SELF.leftWindow := l.leftWindow;
				SELF.rightWindow := l.rightWindow;
				// SELF.id := 0;
				SELF.id := opr.id + cnt;
				SELF := opr;
			END;

			UNSIGNED2 num := l.en - l.st + 1;

			RETURN NORMALIZE(DATASET(opr), num, makeFake(LEFT, COUNTER));
		END;

		makeInputs(Layout_Search_operand opr) := FUNCTION
			Layout_RPN_Oprnd makeFake(Layout_Search_operand opr,
																Types.Stage stg,
																Types.TermID id) := TRANSFORM
				SELF.stageIn := stg;
				// SELF.id := 0;
				SELF.id := id;
				SELF.leftWindow := l.leftWindow;
				SELF.rightWindow := l.rightWindow;
				SELF := opr;
			END;

			Types.TermID tmpId := opr.id;

			RETURN DATASET(ROW(makeFake(opr, l.st, tmpId))) &
							DATASET(ROW(makeFake(opr, l.en, tmpId + 1)));
		END;

		BOOLEAN isUnary := l.opCode IN unaryOps;
		BOOLEAN isPhrase := l.opCode = Map_Search_Operands.code_Phrase;

		SELF.opCode := l.opCode;
		SELF.maxLeftWindow := l.leftWindow;
		SELF.maxRightWindow := l.rightWindow;
		SELF.stage := l.stage;
		SELF.phraseLength := IF(isPhrase, l.numOprnds, 0);
		SELF.inputs := MAP(isUnary => DATASET(ROW(cvtOprnd(l.A))),
											 isPhrase => makeInputsForPhrase(l.A),
											 makeInputs(l.A));
		SELF.maxPhraseLength := SELF.phraseLength;
	END;
	d7 := PROJECT(d6, cvtOp(LEFT));

	// Rollup to n-ary operations
	Layout_Search_RPN_Set r1(Layout_Search_RPN_Set l, Layout_Search_RPN_Set r):=TRANSFORM
		SELF.inputs := l.inputs & CHOOSEN(r.inputs, 1, 2);
		SELF.phraseLength := l.phraseLength + r.phraseLength;
		SELF.maxLeftWindow := MAX(l.maxLeftWindow, r.maxLeftWindow);
		SELF.maxRightWindow := MAX(l.maxRightWindow, r.maxRightWindow);
		SELF := l;
	END;
	d8 := ROLLUP(d7, r1(LEFT,RIGHT), stage);

	// Update "Max" values
	Layout_Search_RPN_Set m1(Layout_Search_RPN_Set l, Layout_Search_RPN_Set r):=TRANSFORM
		SELF.maxPhraseLength := MAX(l.maxPhraseLength, r.maxPhraseLength);
		SELF := r;
	END;
	d9 := ITERATE(d8, m1(LEFT,RIGHT));

	RETURN d9;

END;