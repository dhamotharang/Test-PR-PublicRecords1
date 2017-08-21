/********************************************************************************************************** 
	Name: 			BusinessNameCleaner
	Created On: 06/10/2013
	By: 				ssivasubramanian
	Desc: 			Used for cleaning a string based on the configuration set in BusinessNameCleaner_Config. 	
							Any changes you need can be done in the configuration (BusinessNameCleaner_Config).
							Do not change this file. The helper functions converts the string to upper case for all 
							matches. So the resulting string will be upper case.
***********************************************************************************************************/

IMPORT HealthCareFacility.FacilityNameCleaner_Config as Config;
IMPORt Std;

EXPORT FacilityNameCleaner := MODULE
		
		/********************************************************************************************************** 
			 INTERNAL FUNCTION - fnRemoveWrappingChar
			 To remove any wrapping characters for a string
			 This will also remove if the starting character does not have a corresponding ending character
			 Certified Case Agnostic
		***********************************************************************************************************/
		SHARED STRING fnRemoveWrappingChar(STRING sInput, STRING sCharToRemove, BOOLEAN bRemoveUnpairedWrap) := FUNCTION
			sCleanInput := STD.Str.CleanSpaces(sInput);			
			ucInput	:= STD.Str.ToUpperCase(sCleanInput);
			ucCharToRemove := STD.Str.ToUpperCase(sCharToRemove);
			bIsInvalidWrapChar := (LENGTH(ucCharToRemove) = 0);
			ucPrefixToRemove := ucCharToRemove[1];
			ucSuffixToRemove := IF(LENGTH(ucCharToRemove) = 1,ucCharToRemove[1],ucCharToRemove[2]);
			iInputLength := LENGTH(ucInput);
			
			bScopeForCleaningNonPair := (bRemoveUnpairedWrap AND LENGTH(STD.Str.Filter(ucInput,ucCharToRemove))%2 != 0);
			bFoundStartPos := IF(STD.STr.StartsWith(ucInput,ucPrefixToRemove),TRUE,FALSE);
			bFoundEndPos := IF(STD.Str.EndsWith(ucInput,ucSuffixToRemove),TRUE,FALSE);
					
			RETURN MAP(bIsInvalidWrapChar OR iInputLength < 2 => ucInput,
								 bFoundStartPos AND bFoundEndPos => ucInput[2..iInputLength-1],
								 ~bFoundStartPos AND ~bFoundEndPos => ucInput,
								 bScopeForCleaningNonPair AND bFoundStartPos => ucInput[2..iInputLength],
								 bScopeForCleaningNonPair AND bFoundEndPos => ucInput[1..iInputLength-1],
								 ucInput);
		END;
		
		/********************************************************************************************************** 
			 HELPER FUNCTION - fnRemoveWrappingCharList
			 To remove a set of Wrapping Chars from a string.
			 Certified Case Agnostic
		***********************************************************************************************************/
		SHARED STRING fnRemoveWrappingCharList(STRING sInput, SET OF STRING lWrapCharsList, BOOLEAN bRemoveUnpairedWrap) := FUNCTION
			
			//The single quotes is  added to the end because of the way rollup works
			dsWrapCharsList := DATASET(lWrapCharsList + [''],{STRING WrapChars});
			ConvertedRec := RECORD
				STRING ucWrapChar := STD.Str.ToUpperCase(dsWrapCharsList.WrapChars);
				STRING ucInput := STD.Str.ToUpperCase(sInput);
				STRING ucOutput := STD.Str.ToUpperCase(sInput);
			END;

			InputExpanded := TABLE(dsWrapCharsList,ConvertedRec);
	
			ds := ROLLUP(InputExpanded, 
				LEFT.ucInput = RIGHT.ucInput,
				TRANSFORM(ConvertedRec,
										SELF.ucOutput := fnRemoveWrappingChar(LEFT.ucOutput,LEFT.ucWrapChar,bRemoveUnpairedWrap);
										SELF.ucWrapChar :=RIGHT.ucWrapChar;
										SELF := LEFT));
	
			RETURN Std.Str.CleanSpaces(ds[1].ucOutput);
		END;
		
		/********************************************************************************************************** 
		   HELPER FUNCTION - fnRemoveString
			 To remove a term from a string
			 Certified Case Agnostic
		***********************************************************************************************************/
		SHARED STRING fnRemoveString(STRING sInput, STRING sFindStr, BOOLEAN bTruncateAfter, BOOLEAN bTruncateBefore) := FUNCTION	
			ucInput	:= STD.Str.ToUpperCase(sInput);
			ucFindStr := STD.Str.ToUpperCase(sFindStr);
			iLocation := Std.Str.Find(ucInput,ucFindStr,1);
				
			RETURN MAP(iLocation = 0 => ucInput,
								(bTruncateAfter = TRUE AND bTruncateBefore = FALSE AND iLocation > 1) => ucInput[1..iLocation -1],
								(bTruncateAfter = FALSE AND bTruncateBefore = TRUE AND iLocation <LENGTH(ucInput)) => ucInput[(iLocation + LENGTH(ucFindStr))..LENGTH(ucInput)],
								(bTruncateAfter = TRUE AND bTruncateBefore = TRUE AND LENGTH(TRIM(ucInput,LEFT,RIGHT))> LENGTH(TRIM(ucFindStr,LEFT,RIGHT))) => ucFindStr,
								STD.Str.FindReplace(ucInput,ucFindStr,' '));
		END;
		
		/********************************************************************************************************** 
		   HELPER FUNCTION - fnRemoveStringList
			 To remove a set of terms from a string.
			 Certified Case Agnostic
		***********************************************************************************************************/
		SHARED STRING fnRemoveStringList(STRING sInput, DATASET({STRING Term}) dsTermList, BOOLEAN bTruncateAfter,BOOLEAN bTruncateBefore) := FUNCTION
			ConvertedRec := RECORD
				STRING ucTerm := STD.Str.ToUpperCase(dsTermList.Term);
				STRING ucInput := ' ' + STD.Str.ToUpperCase(sInput) + ' ';
				STRING ucOutput := ' ' + STD.Str.ToUpperCase(sInput) + ' ';
			END;

			InputSorted := TABLE(dsTermList,ConvertedRec);

			ds := ROLLUP(InputSorted, 
				LEFT.ucInput = RIGHT.ucInput,
				TRANSFORM(ConvertedRec,
										SELF.ucOutput := fnRemoveString(LEFT.ucOutput,LEFT.ucTerm,bTruncateAfter,bTruncateBefore);
										SELF.ucTerm :=RIGHT.ucTerm;
										SELF := LEFT));

			RETURN Std.Str.CleanSpaces(ds[1].ucOutput);
		END;
		
		/********************************************************************************************************** 
		   INTERNAL FUNCTION
			 To remove noise words from a string
			 Certified Case Agnostic - Transitive
		***********************************************************************************************************/
		SHARED STRING fnRemoveNoiseWords(STRING sInput,SET OF STRING lNoiseWords) := FUNCTION
				lNoiseWordsSorted := SORT(DATASET(lNoiseWords + [''],{STRING Term}),-Std.Str.Find(Term,'.'),length(Term))		;		
				RETURN fnRemoveStringList(sInput,lNoiseWordsSorted,FALSE,FALSE);
		END;
		
		/********************************************************************************************************** 
		   INTERNAL FUNCTION
			 To remove invalid first char
			 Certified Case Agnostic
		***********************************************************************************************************/
		SHARED STRING fnRemoveInvalidFirstChar(STRING sInput,STRING sAcceptableSet, BOOLEAN bRecursive) := FUNCTION
				sRegexPattern := '(^[^' + sAcceptableSet + ']'+ IF(bRecursive,'+','') + ')';
				RETURN REGEXREPLACE(sRegexPattern,STD.Str.CleanSpaces(sInput),'',NOCASE);
		END;
		
		/********************************************************************************************************** 
		   INTERNAL FUNCTION
			 To remove invalid Last char
			 Certified Case Agnostic - Transitive
		***********************************************************************************************************/
		SHARED STRING fnRemoveInvalidLastChar(STRING sInput,STRING sAcceptableSet, BOOLEAN bRecursive) := FUNCTION
				RETURN Std.Str.Reverse(fnRemoveInvalidFirstChar(Std.Str.Reverse(sInput),sAcceptableSet,bRecursive));
		END;
		
		/********************************************************************************************************** 
		   INTERNAL FUNCTION
			 To truncate after terms
			 Certified Case Agnostic - Transitive
		***********************************************************************************************************/
		SHARED STRING fnTruncateAfterTerms(STRING sInput,SET OF STRING lTerms) := FUNCTION
				lTermsSorted := SORT(DATASET(lTerms + [''],{STRING Term}),-Std.Str.Find(Term,'.'),length(Term));	
				RETURN fnRemoveStringList(sInput,lTermsSorted,TRUE,FALSE);
		END;
		
		/********************************************************************************************************** 
		   INTERNAL FUNCTION
			 To truncate before terms
			 Certified Case Agnostic - Transitive
		***********************************************************************************************************/
		SHARED STRING fnTruncateBeforeTerms(STRING sInput,SET OF STRING lTerms) := FUNCTION
				lTermsSorted := SORT(DATASET(lTerms + [''],{STRING Term}),-Std.Str.Find(Term,'.'),length(Term)): PERSIST('Sorted TruncateBefore Terms List');
				RETURN fnRemoveStringList(sInput,lTermsSorted,FALSE,TRUE);				
		END;
		
		/********************************************************************************************************** 
		   INTERNAL FUNCTION
			 To remove special characters for the last time
			 Certified Case Agnostic
		***********************************************************************************************************/
		SHARED STRING fnCleanStrOfSpecialChars(STRING sInput,STRING sSpecialChars, BOOLEAN bReplaceWithSpace) := FUNCTION
				ucInput := STD.Str.ToUpperCase(sInput);
				ucSpecialChars := STD.Str.ToUpperCase(sSpecialChars);
				ucCleanedInput := IF(bReplaceWithSpace,
														STD.Str.SubstituteIncluded(ucInput,ucSpecialChars,' '),
														STD.Str.FilterOut(ucInput,ucSpecialChars));
				RETURN ucCleanedInput;
		END;
		
		
		/********************************************************************************************************** 
		   Only public function in this module
			 Cleans up the input string as configured in SriniS.CCLUE_Cleaner_Config file
			 All comparisons are case insensitive. The input string will be returned in UPPER CASE after cleaning  
		***********************************************************************************************************/
		EXPORT STRING fnCleanAsConfigured(STRING sInput):= FUNCTION 
			
			sCleanInput := STD.Str.CleanSpaces(sInput);
								
			// Cleans out any unwanted characters	if the flag is set to true	
			sAcceptableInput 	:= IF(Config.bCleanForAcceptableSetOfChars,
																STD.Str.SubstituteExcluded(STD.Str.ToUpperCase(sCleanInput),STD.Str.ToUpperCase(Config.sAcceptableSetOfChars),' '),
																STD.Str.ToUpperCase(sCleanInput));
			
			// Removes enclosing chars if they are present
			sRemovedWraps := fnRemoveWrappingCharList(sAcceptableInput,Config.lWrappingCharSet,Config.bRemoveUnpairedWrappingQuotes);
			
			// Delete all noise words	
			sNoiselessInput 	:= IF(Config.bRemoveNoiseWords,
																fnRemoveNoiseWords(sRemovedWraps,Config.lNoiseWordsSet),
																sRemovedWraps);
			
			// Truncate after the term
			sTruncatedAfter :=  IF(Config.bTruncateAfterTerm,
																fnTruncateAfterTerms(sNoiselessInput,Config.lTruncateAfterTerms),
																sNoiselessInput);
																
			// Truncate before the term
			sTruncatedBefore :=  IF(Config.bTruncateBeforeTerm,
																fnTruncateBeforeTerms(sTruncatedAfter,Config.lTruncateBeforeTerms),
																sTruncatedAfter);
		
			// Remove unwanted first character
			sFirstCharCleaned := IF(Config.bValidateFirstChar,
																fnRemoveInvalidFirstChar(sTruncatedBefore,Config.sAcceptableSetOfFirstChars,Config.bRemoveInvalidFirstCharRecursively),
																sTruncatedBefore);
			
			//Remove unwanted last character
			sLastCharCleaned := IF(Config.bValidateLastChar,
																fnRemoveInvalidLastChar(sFirstCharCleaned,Config.sAcceptableSetOfLastChars,Config.bRemoveInvalidLastCharRecursively),
																sFirstCharCleaned);
					
				
			// Remove special characters - Post Processing
			sPostProcessedInputRemoved := IF(Config.bRemoveSpecialCharPostProcessing,
																fnCleanStrOfSpecialChars(sTruncatedBefore,Config.sRemoveSpecialCharPostProcessing,FALSE),
																sLastCharCleaned);	
			
			// Replace special characters - Post Processing
			sPostProcessedInputReplaced := STD.Str.CleanSpaces(IF(Config.bReplaceSpecialCharWithSpacePostProcessing,
																fnCleanStrOfSpecialChars(sPostProcessedInputRemoved,Config.sReplaceSpecialCharPostProcessing,TRUE),
																sPostProcessedInputRemoved));	
			
			
			// Check if the string got cleared or does it still have data
			sReturnValue := IF((LENGTH(sPostProcessedInputReplaced) > 0 OR Config.bIsOkayToReturnEmptyString),sPostProcessedInputReplaced,sCleanInput);

			/* Write outputs at each stage for debugging */
			// IF(Config.bDEBUG,STD.System.Log.addWorkunitInformation('Here is the input string : ' + sInput,0));    
			// IF(Config.bDEBUG,STD.System.Log.addWorkunitInformation('THE START: After Clearing Input of spaces: ' + sCleanInput,1));    
			// IF(Config.bDEBUG,STD.System.Log.addWorkunitInformation('After Cleaning out any unwanted characters: ' + sAcceptableInput,2));    
			// IF(Config.bDEBUG,STD.System.Log.addWorkunitInformation('After Removing Wrapping Chars: ' + sRemovedWraps,3));  
			// IF(Config.bDEBUG,STD.System.Log.addWorkunitInformation('After Removing Noise Words: ' + sNoiselessInput,4));  	
			// IF(Config.bDEBUG,STD.System.Log.addWorkunitInformation('Truncated after specific terms: ' + sTruncatedAfter,5));  
			// IF(Config.bDEBUG,STD.System.Log.addWorkunitInformation('Truncated before specific terms: ' + sTruncatedBefore,6));  
			// IF(Config.bDEBUG,STD.System.Log.addWorkunitInformation('After Removing Unwanted First Char: ' + sFirstCharCleaned,7));  
			// IF(Config.bDEBUG,STD.System.Log.addWorkunitInformation('After Removing Unwanted Last Char: ' + sLastCharCleaned,8));  
			// IF(Config.bDEBUG,STD.System.Log.addWorkunitInformation('After Removing Special Chars - Post Processing: ' + sPostProcessedInputRemoved,9));  
			// IF(Config.bDEBUG,STD.System.Log.addWorkunitInformation('THE END: After replacing Special Chars - Post Processing: ' + sPostProcessedInputReplaced,10));  
			// IF(Config.bDEBUG,STD.System.Log.addWorkunitInformation('Here is the output string after checking if empty: ' + sReturnValue,11));  			

			RETURN sReturnValue;
		END;

END;



		
		
