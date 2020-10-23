EXPORT FNValidationWithRC := MODULE
	//Read the input file
	EXPORT MAC_inputFile(FileName, pRawSetOut, inputLayouts, HD = 1, isCSV=TRUE, SEPRT = '\',\'', QOT = '\'"\'', includeOutput = TRUE) := MACRO
   	// EXPORT MAC_inputFile(FileName, pRawSetOut, inputLayouts, isCSV=TRUE, SEPRT = '|') := MACRO
		#uniquename(Inputset0)
		// %Inputset0% := IF(isCSV, DATASET(FileName, inputLayouts, CSV(HEADING(1), QUOTE('\"'), SEPARATOR([ SEPRT]),TERMINATOR('\n'),MAXLENGTH(4096))), DATASET(FileName, inputLayouts, THOR));
		// %Inputset0% := IF(isCSV, DATASET(FileName, inputLayouts, CSV(HEADING(1), QUOTE('\"'), SEPARATOR([ '|']),TERMINATOR('\n'),MAXLENGTH(4096))), DATASET(FileName, inputLayouts, THOR));
		%Inputset0% := IF(isCSV, DATASET(FileName, inputLayouts, CSV(HEADING(HD), QUOTE([QOT]), SEPARATOR([ SEPRT]), MAXLENGTH(1000000000))), DATASET(FileName, inputLayouts, THOR));
		SHARED pRawSetOut := DISTRIBUTE(%Inputset0%, HASH32(TransactionID));
		#IF(includeOutput)
        	OUTPUT(pRawSetOut, named('RawInput'));
        #END
	ENDMACRO;

	//Standardizes the file read in
	EXPORT MAC_STDInputFile(pRawSetOut, StandLayouts, finalRawSCField, finalSCField, StdFile, checkRC1 = FALSE, includeOutput = TRUE, numRC = 4, numRC1 = 4) := MACRO
		#DECLARE(SetRCSet);
		#DECLARE(Ix);
		#SET(Ix, 1);
		#SET(SetRCSet, 'SET(DATASET([');
		#LOOP
			#IF (%Ix% > numRC)
				#BREAK
			#ELSEIF (%Ix% = 1)
				#APPEND(SetRCSet, '{L.ReasonCode1}');
			#ELSE
				#APPEND(SetRCSet, ', {L.ReasonCode' + %'Ix'% + '}');
			#END
			#SET(Ix, %Ix% + 1);
		#END
		#APPEND(SetRCSet, '], {STRING5 ReasonCode})(reasoncode<>\'\'), ReasonCode)');

		#IF(checkRC1)
		#DECLARE(SetRC1Set);
		#SET(Ix, 1);
		#SET(SetRC1Set, 'SET(DATASET([');
		#LOOP
			#IF (%Ix% > numRC1)
				#BREAK
			#ELSEIF (%Ix% = 1)
				#APPEND(SetRC1Set, '{L.Reason1Code1}');
			#ELSE
				#APPEND(SetRC1Set, ', {L.Reason1Code' + %'Ix'% + '}');
			#END
			#SET(Ix, %Ix% + 1);
		#END
		#APPEND(SetRC1Set, '], {STRING5 ReasonCode})(reasoncode<>\'\'), ReasonCode)');
		#END

		StandLayouts xStandardizeInput(pRawSetOut L):= TRANSFORM
		    SELF.SOURCE := 'STD';
			SET OF STRING5 STDfromFile_RC := #EXPAND(%'SetRCSet'%);
			SELF.STD_RC := STDfromFile_RC;
			#IF(checkRC1)
			SET OF STRING5 STDfromFile_RC1 := #EXPAND(%'SetRC1Set'%);
			SELF.STD_RC1 := STDfromFile_RC1;
			#END
			SELF.STD_scr := (STRING)L.finalSCField;
			SELF.STDRawScore := (STRING)L.finalRawSCField;
			SELF := L;
		END;
		SHARED StdFile := PROJECT(RawInputSet, xStandardizeInput(LEFT));
		#IF(includeOutput)
		OUTPUT(StdFile, NAMED('ModelerSTDFile'));
        #END
   	ENDMACRO;

   	EXPORT MAC_STDInputFile_NoRC(pRawSetOut, StandLayouts, finalRawSCField, finalSCField, StdFile, includeOutput = TRUE) := MACRO
		StandLayouts xStandardizeInput(pRawSetOut L):= TRANSFORM
			SELF.SOURCE := 'STD';
			// STDfromFile_RC := [L.ReasonCode1, L.ReasonCode2, L.ReasonCode3, L.ReasonCode4];
			// SET OF STRING5 STDfromFile_RC := SET( DATASET([{L.ReasonCode1}, {L.ReasonCode2}, {L.ReasonCode3}, {L.ReasonCode4}], {STRING5 ReasonCode})(reasoncode<>''), ReasonCode);
			// STDfromFile_RC := SET( DATASET([{L.ReasonCode1}, {L.ReasonCode2}, {L.ReasonCode3}, {L.ReasonCode4}], {STRING5 ReasonCode})(reasoncode<>''), ReasonCode);
			// SELF.STD_RC := STDfromFile_RC;
			SELF.STD_scr := (STRING)L.finalSCField;
			SELF.STDRawScore := (STRING)L.finalRawSCField;
			SELF := L;
		END;
		SHARED StdFile := PROJECT(RawInputSet, xStandardizeInput(LEFT));
		#IF(includeOutput)
        	OUTPUT(StdFile, NAMED('ModelerSTDFile'));
        #END
	ENDMACRO;

	//Compare the Modeler vs. LUCI scores and reason codes
	EXPORT MAC_CompareScore(pLUCIset, pRawInput, Check_Result, pOutputSet, checkRC1 = FALSE, includeOutput = TRUE) := MACRO
		SHARED rec_checkmatches := RECORD
			STRING   TransactionID;
		  	STRING   STDRawScore;
			STRING   STDScore;
      		STRING   LUCIRawScore;
      		STRING20 LUCIScore;
      		SET OF STRING5 STD_RC  := [];
      		SET OF STRING5 HPCC_RC := [];
      		Boolean  Score_Match;
      		Boolean  RC_Match;
      		#IF(checkRC1)
      		SET OF STRING5 STD_RC1  := [];
      		SET OF STRING5 HPCC_RC1 := [];
      		Boolean  RC1_Match;
      		#END
     	END;

		rec_checkmatches tr_checkMatches(pLUCIset L, pRawInput R ) := TRANSFORM
			SELF.TransactionID     := L.TransactionID;
			SELF.STDScore          := (string)(real)R.STD_scr;
			SELF.STDRawScore       := (string)(real)R.STDRawScore;
			SELF.LUCIScore         := (string)(real)L.score;
			SELF.LUCIRawScore      := (string)(real)L.raw_score; //calc_temp_score
			SELF.Score_Match   	   := IF(SELF.LUCIScore = SELF.STDScore, TRUE, FALSE);
			SELF.STD_RC        	   := R.STD_RC;
			SET OF STRING5 HPCC_RC := SET( L.Messages,TRIM(L.Messages.code));
			SELF.HPCC_RC           := HPCC_RC;
			SELF.RC_Match          := IF(SELF.STD_RC = SELF.HPCC_RC, TRUE, FALSE);
			#IF(checkRC1)
			SELF.STD_RC1       	   := R.STD_RC1;
			SET OF STRING5 HPCC_RC1 := SET( L.Messages1,TRIM(L.Messages1.code));
			SELF.HPCC_RC1           := HPCC_RC1;
			SELF.RC1_Match          := IF(SELF.STD_RC1 = SELF.HPCC_RC1, TRUE, FALSE);
			#END
		END;

     	SHARED Check_Result := JOIN(pLUCIset,pRawInput,LEFT.TransactionID = RIGHT.TransactionID,tr_checkMatches(LEFT, RIGHT), LOCAL);

      	#IF(includeOutput)
        	output(CHOOSEN(Check_Result, 500), NAMED('CheckResult'));
        #END
      	SHARED pOutputSet := dataset([
			  					{'Total',count(Check_Result), (real4)100*count( Check_Result )/count( Check_Result ) +'%'},
								{'Score_Match',count( Check_Result (Score_Match=TRUE)), (real4)100*count( Check_Result (Score_Match=TRUE))/count( Check_Result ) +'%'},
								{'Score_Mismatch',count( Check_Result (Score_Match=FALSE)), (real4)100*count( Check_Result (Score_Match=FALSE))/count( Check_Result )+'%'},
								{'RC_Match',count( Check_Result (RC_Match=TRUE)), (real4)100*count( Check_Result (RC_Match=TRUE))/count( Check_Result ) +'%'},
								{'RC_Mismatch',count( Check_Result (RC_Match=FALSE)), (real4)100*count( Check_Result (RC_Match=FALSE))/count( Check_Result )+'%'}
								#IF(checkRC1)
								,{'RC1_Match',count( Check_Result (RC1_Match=TRUE)), (real4)100*count( Check_Result (RC1_Match=TRUE))/count( Check_Result ) +'%'}
								,{'RC1_Mismatch',count( Check_Result (RC1_Match=FALSE)), (real4)100*count( Check_Result (RC1_Match=FALSE))/count( Check_Result )+'%'}
                                #END
							],
          					{ string Datasets, unsigned CNT, string Percentage }
							);

    	#IF(includeOutput)
        	output(pOutputSet, , named('CheckResultStats'));
        #END
   	ENDMACRO;
END;
