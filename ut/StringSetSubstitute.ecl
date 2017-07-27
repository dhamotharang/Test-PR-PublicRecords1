EXPORT StringSetSubstitute := MODULE

	EXPORT RecOfStrings := RECORD
		STRING sentence;
	END;
	
	EXPORT ReplacementEntry := RECORD
		STRING			wd;
		STRING   		replaceWd;
	END;

	SHARED defaultLookupSet := DATASET([
			{'Capitol', 'Capital'},
			{'Capital', 'Capitol'},
			{'Ft', 'Fort'},
			{'Fort', 'Ft'},
			{'Mt', 'Mount'},
			{'Mount', 'Mt'},
			{'St', 'Saint'},
			{'Saint', 'St'}],  ReplacementEntry) : GLOBAL;
				
	SHARED fieldRec := RECORD
			STRING 		pword;
			UNSIGNED2 stringStartPos;
			UNSIGNED2 wordPos := 0;
			STRING 		origWord := '';
			BOOLEAN   equivalent := FALSE;
	END;
	
	SHARED SlimFieldRec := RECORD
	    UNSIGNED6 iteration;
			UNSIGNED2 wordPos;
			STRING 		origWord;
			STRING		replWord;
	END;
	
	SHARED fieldRec SplitWords(STRING stringToParse) := FUNCTION
		PATTERN validChars 		:= PATTERN('[^ \t\r\n]');
		TOKEN 	field_tok 		:= validChars+;
		RULE 		wordRule 			:= field_tok;
		
		parseRec := RECORD
			pword		:= MATCHTEXT(wordRule);
			stringStartPos := MATCHPOSITION(wordRule);
		END;
		
		// Split input string into a record set for each identified word
		tempDataset := DATASET([stringToParse], {STRING line});		
		wordSet := PARSE(tempDataset,line,wordrule,parseRec, MAX, MANY);
		retWordSet := PROJECT(wordset,TRANSFORM(fieldRec,SELF:=LEFT));
		RETURN(retWordSet);
	END;
	
	/* The following function will take in a string and a set of replacement strings and replace all 
     occurances within the string. If no replacement set is passed, the default is used.
     For example, String 'ST JOHNS MOUNT HOPKINS CORP' will be converted to 'SAINT JOHNS MT HOPKINS CORP'
		 Example call: replacedString := ut.StringSetSubstitute.replaceAllSingle('ST JOHNS MOUNT HOPKINS CORP');
*/
	EXPORT STRING replaceAllSingle(STRING inString, 
													 DATASET(ReplacementEntry) pLookupSet = defaultLookupSet) := FUNCTION
		
		// Call function to split string into words
		wordSet := SplitWords(inString);
		
		fieldRec replaceWord(fieldRec l, ReplacementEntry r) := TRANSFORM
				SELF.pword := IF (r.replaceWd != '', r.replaceWd, l.pword);
				SELF := l;
		END;
		
		// Join against lookup table and replace matched word with replacement value
		replWordSet := JOIN (wordSet,pLookupSet,
															StringLib.StringToUpperCase(LEFT.pword) = StringLib.StringToUpperCase(RIGHT.wd), 
															replaceWord(LEFT,RIGHT), 
															LEFT OUTER, LIMIT(1));

		// Rollup record set of words into one record word
		wordString := ROLLUP(SORT(replWordSet,stringStartPos),
		                     TRUE,
												 TRANSFORM(fieldrec, 
												   SELF.pword := LEFT.pword + ' ' + RIGHT.pword, 
													 SELF := []));
		RETURN(wordstring[1].pword);
	END;
	
	/* The following function will take in a string and a set of replacement strings and replace all 
    occurances within the string. It assumed the passed string is not wanted in the return, if wanted
    set inclOrig param to TRUE.
		If no replacement set is passed, the default is used.
		This function differs from the replaceSingle function in that all possible combinations will be returned.

    For example, if string 'ST JOHNS MOUNT HOPKINS CORP' is passed and the default replacement table is used
		the Following strings will be returned: 
					SAINT JOHNS MOUNT HOPKINS CORP
					SAINT JOHNS MT HOPKINS CORP
					ST JOHNS MOUNT HOPKINS CORP
					ST JOHNS MT HOPKINS CORP
		Example call: replacedString := ut.StringSetSubstitute.replaceAllComb('ST JOHNS MOUNT HOPKINS CORP');
*/
	EXPORT SET OF STRING replaceAllComb(STRING inString, BOOLEAN inclOrig = FALSE,
													 DATASET(ReplacementEntry) pLookupSet = defaultLookupSet) := FUNCTION
		
		// Call function to split string into words
		wordSet := SplitWords(inString);
		UNSIGNED2 numWords := COUNT(wordset);

		fieldRec replaceWord(fieldRec l, ReplacementEntry r) := TRANSFORM
				SELF.pword := IF (r.replaceWd != '', r.replaceWd, l.pword);
				SELF.origword := l.pword;
				SELF.equivalent := r.replaceWd != '';
				SELF := l;
		END;
		
		// Join against lookup table and replace matched word with replacement value
		replWordSet := JOIN (wordSet,pLookupSet,
															StringLib.StringToUpperCase(LEFT.pword) = StringLib.StringToUpperCase(RIGHT.wd), 
															replaceWord(LEFT,RIGHT), 
															LEFT OUTER, LIMIT(1));
		
		UNSIGNED2 numEquivs := COUNT(replWordSet(equivalent));
		
		// Add word position within passed sentence
		SlimFieldRec AddWordPos(fieldRec l, UNSIGNED2 cnt) := TRANSFORM
				SELF.wordPos 	:= Cnt;
				SELF.origWord := l.origWord;
				SELF.replWord := l.pword;
				SELF.iteration := 0;
		END;
		seqWordSet := PROJECT(replWordSet,AddWordPos(LEFT,COUNTER));
		
		/* Each possible word and its replacement value in the sentence is represented by a record within the recordset. 
				For example, if the input string is "Mt Saint Helens", the wordset will look as follows:
        wordpos  OrigWord   ReplWord
				  1				MT					MOUNT
					2				SAINT				ST
					3				HELENS			HELENS  Note: In cases where there isn't a replacement value the origanal word is used.
			The logic normalize each row of the recordset to create a "pattern" of the individual words that
			will then be used to roll into all of the possible sentences. 
      For the example string, after the "normalize", the record set will look as follows:
				iteration   wordpos    word
					1						1					Mt
					2						1					MOUNT
					3						1					Mt
					4						1					MOUNT
					5						1					Mt
					6						1					MOUNT
					7						1					Mt
					8						1					MOUNT
					1						2					ST
					2						2					ST
					3						2					Saint
					4						2					Saint
					5						2					ST
					6						2					ST
					7						2					Saint
					8						2					Saint
					1						3					Helens
					2						3					Helens
					3						3					Helens
					4						3					Helens
					5						3					Helens
					6						3					Helens
					7						3					Helens
					8						3					Helens
			The pattern iteration/wordpos/word is very important for creating all of the possible combinations.
      Each recordset's values are based on the iteration and the word position.
	    Once the records are created, they are sorted on iteration and wordpos, and then rolled into
      sentences on iteration. The resulting recordset is as follows:
      iteration   wordpos(n/a)   Sentence
				1						0							Mt ST Helens
				2						0							MOUNT ST Helens
				3						0							Mt Saint Helens
				4						0							MOUNT Saint Helens
				5						0							Mt ST Helens
				6						0							MOUNT ST Helens
				7						0							Mt Saint Helens
				8						0							MOUNT Saint Helens

    */
		tmpRec := RECORD
			unsigned6 iteration;
			unsigned2 wordpos;
			STRING word;
		END;

		tmpRec expandWords(SlimFieldRec l, integer cnt) := TRANSFORM
			SELF.iteration := cnt;
			SELF.word := IF(((cnt+1) DIV POWER(2,l.wordpos-1)) % 2 = 0, l.origWord, l.replWord);
			SELF.wordpos := l.wordpos;
		END;

		wordsExp := NORMALIZE(seqWordSet,POWER(2,numWords),expandWords(left,counter));

		// Pull the words together by the iteration value
		wordsExpSort := SORT(wordsExp,iteration,wordpos);

		tmpRec RollIntoSent(tmpRec l, tmpRec r) := TRANSFORM
				SELF.word := l.word + ' ' + r.word;
				SELF.iteration := l.iteration;
				SELF := [];
		END;

		// Roll them up into a "sentence"
		sents := ROLLUP(wordsExpSort,RollIntoSent(LEFT,RIGHT),iteration);
		
		// Dedup records, this removes the dupes that occur when replacement words don't exist, "Helens"
		// in this example.
		sentsDedup := DEDUP(SORT(sents,word,RECORD),EXCEPT iteration);
		
		sentsWoutOrig := sentsDedup(StringLib.StringToUpperCase(word) != StringLib.StringToUpperCase(inString));
		


		RESULTS := IF(inclOrig,SET(sentsDedup,word),
													 SET(sentsWoutOrig,word));
													 
		RETURN(RESULTS);
	END;
	
END;