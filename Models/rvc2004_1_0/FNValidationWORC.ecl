EXPORT FNValidationWORC := MODULE
  //Read the input file
  EXPORT MAC_inputFile(FileName, pRawSetOut, inputLayouts, HD = 1, isCSV=TRUE, SEPRT = '\',\'', QOT = '\'"\'', includeOutput = TRUE) := MACRO
    #uniquename(Inputset0)
		%Inputset0% := IF(isCSV, DATASET(FileName, inputLayouts, CSV(HEADING(HD), QUOTE([QOT]), SEPARATOR([SEPRT]), MAXLENGTH(1000000000))), DATASET(FileName, inputLayouts, THOR));
		SHARED pRawSetOut := DISTRIBUTE(%Inputset0%, HASH32(TransactionID));
		#IF(includeOutput)
        	OUTPUT(pRawSetOut, named('RawInput'));
        #END
  ENDMACRO;

	//Standardizes the file read in
  EXPORT MAC_STDInputFile(pRawSetOut, StandLayouts, finalRawSCField, finalSCField, StdFile, includeOutput = TRUE) := MACRO
	    StandLayouts xStandardizeInput(pRawSetOut L):= TRANSFORM
            SELF.SOURCE := 'STD';
			SELF.STD_scr := (STRING)(REAL)L.finalSCField;
			SELF.STDRawScore := (STRING)(REAL)L.finalRawSCField;
			SELF := L;
		END;
		SHARED StdFile := PROJECT(RawInputSet, xStandardizeInput(LEFT));
		#IF(includeOutput)
        	OUTPUT(StdFile, NAMED('ModelerSTDFile'));
        #END
  ENDMACRO;

	//Compare the Modeler vs. LUCI scores and reason codes
	EXPORT MAC_CompareScore(pLUCIset, pRawInput, Check_Result, pOutputSet, scoreDiffAsPercDS, includeOutput = TRUE) := MACRO
    SHARED rec_checkmatches := RECORD
      STRING   TransactionID;
	  STRING   STDRawScore;
      STRING   STDScore;
      STRING   LUCIRawScore;
      STRING20 LUCIScore;
      Boolean  Score_Match;
    END;

    rec_checkmatches tr_checkMatches(pLUCIset L, pRawInput R ) := TRANSFORM
      SELF.TransactionID:= L.TransactionID;
      SELF.STDScore     := (string)(real)R.STD_scr;
      SELF.STDRawScore  := (string)(real)R.STDRawScore;
      SELF.LUCIScore    := (string)(real)L.score;
      SELF.LUCIRawScore := (string)(real)L.raw_score;
      SELF.Score_Match  := IF(SELF.LUCIScore = SELF.STDScore, TRUE, FALSE);
    END;

    SHARED Check_Result := JOIN(pLUCIset,pRawInput,LEFT.TransactionID = RIGHT.TransactionID,tr_checkMatches(LEFT, RIGHT), LOCAL);
    #IF(includeOutput)
        output(CHOOSEN(Check_Result, 500), NAMED('CheckResult'));
    #END
    SHARED pOutputSet := dataset([
                            {'Total',count(Check_Result), (real4)100*count( Check_Result )/count( Check_Result ) +'%'},
                            {'Score_Match',count( Check_Result (Score_Match=TRUE)), (real4)100*count( Check_Result (Score_Match=TRUE))/count( Check_Result ) +'%'},
                            {'Score_Mismatch',count( Check_Result (Score_Match=FALSE)), (real4)100*count( Check_Result (Score_Match=FALSE))/count( Check_Result )+'%'}
          				      	],
          								{ string10 Datasets, unsigned CNT, string Percentage }
                          );
    #IF(includeOutput)
        output(pOutputSet, ,named('CheckResultStats'));
    #END

    dsRawScoreMismatch := PROJECT(Check_Result(Score_Match=FALSE), TRANSFORM({REAL ScoreDiff}, SELF.ScoreDiff := ABS((real)LEFT.STDRawScore - (real)LEFT.LUCIRawScore)));
    dsRawScoreMismatch_sort := SORT(dsRawScoreMismatch, ScoreDiff);
    dsFinalScoreMismatch := PROJECT(Check_Result(Score_Match=FALSE), TRANSFORM({REAL ScoreDiff}, SELF.ScoreDiff := ABS((real)LEFT.STDScore - (real)LEFT.LUCIScore)));
    dsFinalScoreMismatch_sort := SORT(dsFinalScoreMismatch, ScoreDiff);

    dsPercentiles := DATASET([{1},{5},{25},{50},{75},{95},{99}], {UNSIGNED2 Percentile});

    scoreDiffAsPercRec := RECORD
        UNSIGNED2 Percentile;
        REAL RawScoreDiff;
        REAL FinalScoreDiff;
    END;

    scoreDiffAsPercRec xScoreDiffToPercentile(dsPercentiles le) := TRANSFORM
        SELF.Percentile := le.Percentile;
        SELF.RawScoreDiff := dsRawScoreMismatch_sort[ROUNDUP(COUNT(dsRawScoreMismatch_sort) * le.Percentile/100.0)].ScoreDiff;
        SELF.FinalScoreDiff := dsFinalScoreMismatch_sort[ROUNDUP(COUNT(dsFinalScoreMismatch_sort) * le.Percentile/100.0)].ScoreDiff;
    END;

    SHARED scoreDiffAsPercDS := PROJECT(dsPercentiles, xScoreDiffToPercentile(LEFT));
  ENDMACRO;
END;
