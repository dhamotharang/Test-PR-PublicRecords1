IMPORT lib_date, lib_timelib, STD;

// Add a GET for the alert Date and AND it into the rest of the search request
EXPORT Alert_RPN_Add(Text_Search.FileName_Info info,
											DATASET(Text_Search.Layout_Search_RPN_Set) InRPN,
											Text_Search.Alert_Info.AlertParams AlertInfo
											) := FUNCTION

	// Find max stage in RPN
	mystage := MAX(InRPN, stage);
  

  Text_Search.Layout_RPN_Oprnd build_inputs() := TRANSFORM
			STRING verDtStr := IF(AlertInfo.envVerName <> '', thorlib.getenv(AlertInfo.envVerName, ''), '');
			STRING todayStr := (STRING) timelib.CurrentDate(TRUE); // Local time, not Zulu
			UNSIGNED2 diffDays := IF(verDtStr <> '', (UNSIGNED2) lib_date.DaysApart(verDtStr, todayStr) + 7, 0);
			STRING segPart := getDate(-MAX(diffDays, AlertInfo.lastXDays));
			alertSegDate := Text_Search.ConvertDate(segPart,true);	
			segMeta := Text_Search.Segment_Metadata(info, TRUE);
			dateSegInfo := segMeta.getDef(STD.Str.touppercase(AlertInfo.dateSegName));

			dictStats := CHOOSEN(Text_Search.Indx_DictStat(info), 1); 
			INTEGER8 docCount := EVALUATE(dictStats[1], maxDocFreq) 	: GLOBAL;
			INTEGER8 wrdCount := EVALUATE(dictStats[1], maxFreq)			: GLOBAL;
	
			SELF.searchArg := (STRING) alertSegDate;
			SELF.terms := (SET OF Text_Search.Types.WordStr) [(STRING) alertSegDate];
			SELF.nominals := (SET OF Text_Search.Types.Nominal) [0];
			SELF.suffixes := (SET OF Text_Search.Types.NominalSuffix) [alertSegDate];
			SELF.typ := Text_Search.Types.WordType.DateRange;
			SELF.id := mystage +1;
			SELF.segList := (SET OF Text_Search.Types.Segment) [dateSegInfo];
			SELF.filterType := Text_Search.Types.NominalFilter.GE_Filter;
			SELF.freq := wrdCount;
			SELF.docFreq := docCount;
			SELF := [];
	END;
	
	 // Build the alert date GET oper 
	Text_Search.Layout_Search_RPN_Set build_date_rpn() := TRANSFORM
			SELF.OpCode := Text_Search.Map_Search_Operands.code_RNGGET;
			SELF.Stage := mystage+1;
			SELF.Inputs := DATASET([build_inputs()]);
			SELF := [];
	END;
	
	// Build the AND oper for alert date and the 
	Text_Search.Layout_Search_RPN_Set build_and_rpn() := TRANSFORM
			Stub_Input := RECORD
				 Types.Stage						   stageIn;
			END;
			InputsForAnd := DATASET( [{mystage},{mystage+1}], Stub_Input);
			AInputs := PROJECT(InputsForAnd,TRANSFORM(Text_Search.Layout_RPN_Oprnd,SELF := LEFT, SELF := []));
			
			SELF.OpCode := Text_Search.Map_Search_Operands.code_AND;
			SELF.Stage := mystage+2;
			SELF.Inputs := PROJECT(InputsForAnd,TRANSFORM(Text_Search.Layout_RPN_Oprnd,SELF := LEFT, SELF := []));
			SELF := [];
	END;
	
  OperandForDateGet := DATASET ([build_date_rpn()]);
	OperandForAnd := DATASET ([build_and_rpn()]);
	RETURN InRPN + OperandForDateGet + OperandForAnd;
END;