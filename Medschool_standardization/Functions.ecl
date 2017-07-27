Import STD;
EXPORT Functions := Module
	export Name_TranslateWords(DATASET(Medschool_standardization.layouts.layoutMedicalSchoolword) nameWords) := FUNCTION
		TranslationRec := RECORD
			STRING      origWord;
			STRING      newWord;
		END;
		translationWords := DATASET([
								{'ACAD','ACADEMY'},
								{'BEHAV','BEHAVIORAL'},
								{'BHVRAL','BEHAVIORAL'},
								{'BHVRL','BEHAVIORAL'},
								{'BLDG','BUILDING'},
								{'CENTERS','CENTER'},
								{'CULT','CULTURAL'},
								{'COL','COLLEGE'},
								{'COLL','COLLEGE'},
								{'CLGE','COLLEGE'},
								{'CLLG','COLLEGE'},
								{'CNTR','CENTER'},
								{'CNTRL','CENTRAL'},
								{'CNTY','COUNTY'},
								{'COMM','COMMUNITY'},
								{'CTR','CENTER'},
								{'CTY','COUNTY'},
								{'FAC','FACULTY'},
								{'HEALT','HEALTHCARE'},
								{'HLTH','HEALTH'},
								{'HLTHCARE','HEALTHCARE'},
								{'MED','MEDICINE'},
								{'MEM','MEMORIAL'},
								{'PHAMACY','PHARMACY'},
								{'PHAR','PHARMACY'},
								{'PHARM','PHARMACY'},
								{'PHARMA','PHARMACY'},
								{'PHARMAC','PHARMACY'},
								{'PHARMACIES','PHARMACY'},
								{'PHARMCY','PHARMACY'},
								{'PHCY','PHARMACY'},
								{'PHY','PHARMACY'},
								{'PHYS','PHYSICIANS'},
								{'PULMONOL','PULMONOLOGY'},
								{'RADIATI','RADIATION'},
								{'REG','REGIONAL'},
								{'UNIV','UNIVERSITY'},
								{'SCI','SCIENCE'},
								{'SO','SOUTH'},
								{'OSTEO','OSTEOPATHIC'},
								{'VCTIONAL','VOCATIONAL'}
						],TranslationRec);
		t1 := JOIN(nameWords,translationWords,LEFT.words = RIGHT.origWord,
													TRANSFORM(RECORDOF(nameWords),
														SELF.words := IF(RIGHT.newWord != '', RIGHT.newWord, LEFT.words),
														SELF := LEFT),LOOKUP, LEFT OUTER);
		RETURN t1;
	END;


	export	 ScoreScale(string word, unsigned wordcount) := FUNCTION
		scoreVal := map(word = 'DENTISTRY' => 20,
										word = 'MEDICINE' => 20,
										word = 'CHIROPRACTIC' => 20,
										word = 'PSYCHOLOGY' => 20,
										word = 'OPTOMETRY' => 20,
										wordcount <= 1 => 20,
										wordcount <= 2 => 15,
										wordcount <= 5 => 10,
										wordcount <= 10 => 5,
										wordcount <= 50 => 2,
										wordcount > 100 => 1,1);
		RETURN scoreVal;
	END;
	export BusName_SplitAndSequenceWords(string s, unsigned msid) := FUNCTION
		 upperStr := STD.Str.ToUppercase(s);
	   //Special Handling for initials with and without periods
		 makePeriodConsistent := STD.Str.FindReplace(upperStr, '.', '. ');
		 cleanSpacing := STD.Str.CleanSpaces(makePeriodConsistent);
		 ReverseString := STD.Str.Reverse(cleanSpacing);
		 getPosCnt := STD.Str.FindCount(ReverseString, ' .'); 
		 getPos := if(getPosCnt>1,STD.Str.Find(ReverseString, ' .', 2),0); 
		 replaceLastPeriod := if(getPosCnt>1,ReverseString[1..getpos-1] + STD.Str.FindReplace(ReverseString[getpos..], ' .', ''),ReverseString);
		 ReverseStringBack := STD.Str.Reverse(replaceLastPeriod);
		 RemoveAllOtherPeriods := STD.Str.FindReplace(ReverseStringBack, '.', '');
		 singleCharWordsCollapsed := REGEXREPLACE('(?<=(?<!\\pL)\\pL) (?=\\pL(?!\\pL))', RemoveAllOtherPeriods, '', NOCASE);
		 cleanStr := STD.Str.FindReplace(singleCharWordsCollapsed, '/', ' ');
		 cleanStr2 := STD.Str.FindReplace(cleanStr, '-', ' ');
		 filterStr := STD.STR.Filter(cleanStr2,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ ');
		 r10 := DATASET(Std.Str.SplitWords(filterStr,' '), Medschool_standardization.layouts.layoutMedicalSchoolWordParse);
		 removeCommonTerms := project(r10,transform(Medschool_standardization.layouts.layoutMedicalSchoolword,
																								rawWord := trim(left.words,left,right);
																								skipit := rawWord in ['OF','THE','AND','IN'];
																								tooShort := length(rawWord)<2;
																								self.words:=if(skipit or tooShort,skip,left.words);self:=[];));
		 fixCommonAbbreviations := Name_TranslateWords(removeCommonTerms);
		RETURN fixCommonAbbreviations;
	END;
End;