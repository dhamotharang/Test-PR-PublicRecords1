import AutoStandardI,iesp,watchdog,doxie,suppress,deathv2_Services,STD,ut,dx_BestRecords;

EXPORT Functions := MODULE
	shared gm := AutoStandardI.GlobalModule();
	
	//Cleaning Functions
	Export cleanOnlyNumbers (string inStr) := function
		return STD.Str.Filter(inStr,'0123456789');
	end;
	
	Export cleanAlpha (string inStr) := function
		return STD.Str.Filter(STD.Str.ToUpperCase(inStr),'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	end;
	
	Export cleanOnlyCharacters (string inStr) := function
		return STD.Str.Filter(inStr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	end;
	
	
	Export cleanOnlyNames (string inStr) := function
		return STD.Str.Filter(inStr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ ');
	end;
	
	
	Export cleanLicenses (string inStr) := function
		return STD.Str.Filter(inStr,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ.-');
	end;
	
	Export cleanAlphaNumeric (string inStr) := function
		return STD.Str.Filter(STD.Str.ToUpperCase(inStr),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	end;
	
	Export cleanWord (string inStr) := function
		return STD.Str.Filter(STD.Str.ToUpperCase(inStr),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	end;
	
	
	EXPORT cleanValue(STRING inputValue) := FUNCTION
		RETURN STD.Str.Filter(STD.Str.ToUpperCase(inputValue),'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
	END;
	
	
	EXPORT cleanValueNumbers(STRING inputValue) := FUNCTION
		RETURN STD.Str.Filter(STD.Str.ToUpperCase(inputValue),'0123456789');
	END;
	
	
	EXPORT removeLeadingZeros(String inputStr) := FUNCTION
		removeZero := STD.Str.Filter(STD.Str.ToUpperCase(inputStr),'123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
		findStart := STD.Str.Find(STD.Str.ToUpperCase(inputStr),removeZero[1],1);
		result := inputStr[findStart..];
		RETURN result;
	END;
	
	Export IsRoyaltySource(string filesource, string filecode) := function 
		return	map(filesource = Healthcare_Shared.Constants.Src_DefinitiveHealthcare => true,
								false);
	end;
	Export loadFileSource(string filesource, string filecode) := function 
		return	row({filesource,filecode},Healthcare_Shared.Layouts.layout_FileSource);
	end;
	Export upinPractitionerType (string inStr) := function // We don't return this, but...
		return	map(inStr between 'A' and 'M' => 'MD/DO',
								inStr between 'R' and 'S' => 'Non-Physician',
								inStr between 'T' and 'V' => 'Other Doctor',
								inStr between 'W' and 'Z' => 'Group UPIN','');
	end;
	
  Export convertSpecialty2Int(STRING s, string sub = '') := FUNCTION
		//2 character entries are Enclarity customers take what they give us, everyone else map as best possible.
		returnVal := map(length(trim(s,right))<=2 => s,
											trim(s,right) = 'ALLERGY AND IMMUNOLOGY' => '03',
											trim(s,right) = 'ANESTHESIOLOGY' => '05',
											trim(s,right) = 'COLON AND RECTAL SURGERY' => '28',
											trim(s,right) = 'DERMATOLOGY' => '07',
											trim(s,right) = 'EMERGENCY MEDICINE' => '93',
											trim(s,right) = 'FAMILY MEDICINE' => '01',//could also be 08  
											trim(s,right) = 'INTERNAL MEDICINE' => '11',
											trim(s,right) = 'MEDICAL GENETICS' => '',
											trim(s,right) = 'MEDICAL GENETICS AND GENOMICS' => '',
											trim(s,right) = 'NEUROLOGICAL SURGERY' => '14',
											trim(s,right) = 'NUCLEAR MEDICINE' => '36',
											trim(s,right) = 'OBSTETRICS AND GYNECOLOGY' => '16',
											trim(s,right) = 'OPHTHALMOLOGY' => '18',
											trim(s,right) = 'ORTHOPAEDIC SURGERY' => '20',
											trim(s,right) = 'OTOLARYNGOLOGY' => '04',
											trim(s,right) = 'PATHOLOGY' => '22',
											trim(s,right) = 'PEDIATRICS' => '37',
											trim(s,right) = 'PHYSICAL MEDICINE AND REHABILITATION' => '25',
											trim(s,right) = 'PLASTIC SURGERY' => '24',
											trim(s,right) = 'PREVENTIVE MEDICINE' => '84',
											trim(s,right) = 'PSYCHIATRY AND NEUROLOGY' and trim(sub,right) = 'PSYCHIATRY' => '26',
											trim(s,right) = 'PSYCHIATRY AND NEUROLOGY' and trim(sub,right) = 'NEUROLOGY' => '13',
											trim(s,right) = 'PSYCHIATRY AND NEUROLOGY' => '13',//Could also be 26
											trim(s,right) = 'RADIOLOGY' => '30',
											trim(s,right) = 'SURGERY' => '02',
											trim(s,right) = 'THORACIC SURGERY' => '33',
											trim(s,right) = 'UROLOGY' => '34',
											'');
		return returnVal;
	end;
	
	EXPORT isValidTINPrefix(STRING TIN_IN) := FUNCTION 
					return TIN_IN <> '999999999';
	END;
  Export BusName_SplitAndSequenceWords(STRING s) := FUNCTION
		r10 := DATASET(Std.Str.SplitWords(s, ' '), Healthcare_Shared.Layouts.BusName_WordRec);
		r20 := PROJECT(r10,TRANSFORM(Healthcare_Shared.Layouts.BusName_SeqWordRec,
																	SELF.seq := COUNTER,
																	SELF.word := LEFT.word));
		RETURN r20;
	END;
	
	
  Export BusName_ResequenceWords(DATASET(Healthcare_Shared.Layouts.BusName_SeqWordRec) ds) := FUNCTION
    resultDS := PROJECT(SORT(ds, seq),TRANSFORM(Healthcare_Shared.Layouts.BusName_SeqWordRec,
																									SELF.seq := COUNTER,
																									SELF.word := LEFT.word));
    RETURN resultDS;
  END;
	
	
  Export BusName_getNoiseWords() := FUNCTION
		NoiseRec := RECORD
			STRING      word;
			UNSIGNED1   word_type;  // 1 = suffix, 2 = prefix
		END;
    return DATASET([
							{'ASSOC', 1},
							{'ASSOCIATION', 1},
							{'CO', 1},
							{'COMPANY', 1},
							{'CORP', 1},
							{'CORPORATION', 1},
							{'INC', 1},
							{'INCORPORATED', 1},
							{'LC', 1},
							{'LIMITED', 1},
							{'LLC', 1},
							{'LLLP', 1},
							{'LLP', 1},
							{'LP', 1},
							{'LTD', 1},
							{'PC', 1},
							{'PLLC', 1},
							{'A', 2},
							{'AN', 2},
							{'THE', 2}
                ],NoiseRec);
  END;
  // Removes certain prefix and suffix whole words from the argument
  Export BusName_CleanPrefixAndSuffixFromSequencedWords(DATASET(Layouts.BusName_SeqWordRec) seqNameWords) := FUNCTION
        r10 := JOIN(seqNameWords,BusName_getNoiseWords(),LEFT.word = RIGHT.word,LOOKUP, LEFT OUTER);
        firstWordSeq := MIN(r10(word_type != 2), seq);
        lastWordSeq := MAX(r10(word_type != 1), seq);
        r20 := r10(seq BETWEEN firstWordSeq AND lastWordSeq);
        noiselessWordsDS := PROJECT(SORT(r20, seq),TRANSFORM(Layouts.BusName_SeqWordRec,
																															SELF.seq := COUNTER,
																															SELF := LEFT));
    RETURN noiselessWordsDS;
  END;
	
	
	// Translates certain whole words in the argument
	Export BusName_TranslateSequencedWords(DATASET(Healthcare_Shared.Layouts.BusName_SeqWordRec) seqNameWords) := FUNCTION
		TranslationRec := RECORD
			STRING      origWord;
			STRING      newWord;
		END;
		// Adapted from HealthCareFacility.Healthcare_Shared.Constants.Conv_Table
		translationWords := DATASET([
								{'1ENTRAL','CENTRAL'},
								{'ACQUISTION','ACQUISITION'},
								{'ASSOCIATES','ASSOC'},
								{'ASSOCIATION','ASSOC'},
								{'ASSOCITES','ASSOC'},
								{'ASSOCS','ASSOC'},
								{'BEHAV','BEHAVIORAL'},
								{'BHVRAL','BEHAVIORAL'},
								{'BHVRL','BEHAVIORAL'},
								{'BLDG','BUILDING'},
								{'CENTERS','CENTER'},
								{'CHILDRENTS','CHILDRENS'},
								{'CLGE','COLLEGE'},
								{'CLIN','CLINICS'},
								{'CLLG','COLLEGE'},
								{'CLNC','CLINIC'},
								{'CNTR','CENTER'},
								{'CNTRL','CENTRAL'},
								{'CNTY','COUNTY'},
								{'COMM','COMMUNITY'},
								{'COMPA','COMPANY'},
								{'CORR','CORRECTIONAL'},
								{'CROP','CORP'},
								{'CTR','CENTER'},
								{'CTY','COUNTY'},
								{'D/B/A','DBA'},
								{'DEPT','DEPARTMENT'},
								{'DERMATOLOTY','DERMATOLOGY'},
								{'DIST','DISTRICT'},
								{'EQUIP','EQUIPMENTS'},
								{'FAMILI','FAMILY'},
								{'FCLTY','FACILITY'},
								{'FNDTION','FOUNDATION'},
								{'FT','FORT'},
								{'GEN','GENERAL'},
								{'GNRL','GENERAL'},
								{'GRP','GROUP'},
								{'HEALT','HEALTHCARE'},
								{'HLTH','HEALTH'},
								{'HLTHCARE','HEALTHCARE'},
								{'HOSP','HOSPITAL'},
								{'HOSPI','HOSPITAL'},
								{'HOSPITALS','HOSPITAL'},
								{'HOSPS','HOSPITAL'},
								{'HSPTL','HOSPITAL'},
								{'INDPLS','INDIANAPOLIS'},
								{'LABORATORY','LAB'},
								{'MED','MEDICAL'},
								{'MEM','MEMORIAL'},
								{'METROPOLITAN','METRO'},
								{'MGMT','MANAGEMENT'},
								{'MKT','MARKET'},
								{'MRT','MART'},
								{'MTNVIEW','MOUNTAIN VIEW'},
								{'NORTHWESTERN','NW'},
								{'NTWRK','NETWORK'},
								{'OUTP','OUTPATIENT'},
								{'OUTPETIENT','OUTPATIENT'},
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
								{'PKWY','PARKWAY'},
								{'PREMIERE','PREMIER'},
								{'PROF','PROFESSIONAL'},
								{'PROFESSIONALS','PROFESSIONAL'},
								{'PULMONOL','PULMONOLOGY'},
								{'RADIATI','RADIATION'},
								{'REG','REGIONAL'},
								{'REGIONCARE','REGION CARE'},
								{'REHABILITAION','REHAB'},
								{'REHABILITATION','REHAB'},
								{'RESOUR','RESOURCE'},
								{'RGNAL','REGIONAL'},
								{'SPECIALIST','SPECIALISTS'},
								{'SRGRY','SURGERY'},
								{'SRVS','SERVICES'},
								{'SURG','SURGEONS'},
								{'SVCS','SERVICES'},
								{'TRI-VALLEY','TRI VALLEY'},
								{'TWP','TOWNSHIP'},
								{'UNIV','UNIVERSITY'},
								{'VCTIONAL','VOCATIONAL'},
								{'WILMED','WILSON MEDICAL'}
						],TranslationRec);
		r10 := JOIN(seqNameWords,translationWords,LEFT.word = RIGHT.origWord,
													TRANSFORM(RECORDOF(seqNameWords),
														SELF.word := IF(RIGHT.newWord != '', RIGHT.newWord, LEFT.word),
														SELF := LEFT),LOOKUP, LEFT OUTER);
		RETURN r10;
	END;
	
	
	// Returns a string composed of the first character of each word in the argument
	Export BusName_MakeInitialism(DATASET(Healthcare_Shared.Layouts.BusName_SeqWordRec) ds) := FUNCTION
			tempDS := PROJECT(ds,TRANSFORM(Healthcare_Shared.Layouts.BusName_SeqWordRec,
											SELF.word := LEFT.word[1],
											SELF := LEFT));
			resultDS := ROLLUP(SORT(tempDS, seq),TRUE,TRANSFORM(Healthcare_Shared.Layouts.BusName_SeqWordRec,
											SELF.word := LEFT.word + RIGHT.word,
											SELF := RIGHT));
			finalWord := resultDS[1].word;
		RETURN finalWord;
	END;
	
	
	Export BusName_ScorePrefixMatch(STRING name1, STRING name2) := FUNCTION
			maxNameLength := MAX(LENGTH(name1), LENGTH(name2));
			matchCount := Healthcare_Shared.Functions_C.BusName_PrefixMatchCount(name1, name2);
			score := matchCount / maxNameLength * 100;
			RETURN score;
	END;
	
	
	Export BusName_CleanAndSplitCompanyName(STRING name) := FUNCTION
		// Influenced by BIP name cleaning code
			withoutQuotes := REGEXREPLACE('[\'"]', name, '');
			withoutPunctuation := REGEXREPLACE('[\\.]', withoutQuotes, '');
			replacedPunctuation := REGEXREPLACE('[,/\\#:\\(\\)*-]', withoutPunctuation, ' ');
			printableOnly := REGEXREPLACE('[^[:print:]]', replacedPunctuation , '');
			separatedAmpersand := REGEXREPLACE('([&])([^ ])', REGEXREPLACE('([^ ])([&])', printableOnly, '$1 $2'), '$1 $2');
			uppercased := STD.Str.ToUpperCase(separatedAmpersand);
			spaceCleaned := STD.Str.CleanSpaces(uppercased);
			singleCharWordsCollapsed := REGEXREPLACE('(?<=(?<!\\pL)\\pL) (?=\\pL(?!\\pL))', spaceCleaned, '', NOCASE);
	// Split name string and perform word-oriented work
			seqNameWords := BusName_SplitAndSequenceWords(singleCharWordsCollapsed);
			translatedWords := BusName_TranslateSequencedWords(seqNameWords);
			noiselessWords := BusName_CleanPrefixAndSuffixFromSequencedWords(translatedWords);
			resequencedWords := BusName_ResequenceWords(noiselessWords);
			RETURN resequencedWords;
	END;
	
	
	EXPORT CompareBusinessNameConfidence(STRING inputName, STRING candidateName) := FUNCTION
			inputNameWords := dedup(sort(BusName_CleanAndSplitCompanyName(inputName),word,seq),word);
			candidateNameWords := dedup(sort(BusName_CleanAndSplitCompanyName(candidateName),word,seq),word);
			inputNameInitialism := BusName_MakeInitialism(inputNameWords);
			candidateNameInitialism := BusName_MakeInitialism(candidateNameWords);
	// Compare every word in input vs. candidate strings
			wordsCombined1 := JOIN(inputNameWords,candidateNameWords,TRUE,TRANSFORM(Healthcare_Shared.Layouts.BusName_WordsScoredRec,
														word1InitialsPos := STD.Str.Find(candidateNameInitialism, LEFT.word, 1);
														word2InitialsPos := STD.Str.Find(inputNameInitialism, RIGHT.word, 1);
														SELF.seq1 := LEFT.seq,
														SELF.word1 := LEFT.word,
														SELF.seq2 := RIGHT.seq,
														SELF.word2 := RIGHT.word,
														SELF.prefixMatchScore := BusName_ScorePrefixMatch(LEFT.word, RIGHT.word),
														SELF.initialismLeft := IF(word1InitialsPos > 0 AND RIGHT.seq BETWEEN word1InitialsPos AND (word1InitialsPos + LENGTH(LEFT.word) - 1), 100, 0),
														SELF.initialismRight := IF(word2InitialsPos > 0 AND LEFT.seq BETWEEN word2InitialsPos AND (word2InitialsPos + LENGTH(RIGHT.word) - 1), 100, 0),
														SELF.totalScore := MAX(SELF.prefixMatchScore,SELF.initialismLeft,SELF.initialismRight)),ALL);
	// Keep the top scoring words from candidate name
			wordsCombined2 := GROUP(SORT(wordsCombined1, seq2, -totalScore, seq1),seq2);
			wordsCombined3 := TOPN(wordsCombined2, 1, -totalScore, seq1);
			wordsCombined4 := UNGROUP(wordsCombined3);
	// Find the maximum score for each input word
			tempMax := ROLLUP(SORT(wordsCombined4, seq1, -totalScore),seq1,TRANSFORM(RECORDOF(wordsCombined4),SELF := LEFT));
	// Retain only the top scoring input word; note that input words
	// may be duplicated in the case of initialisms
			wordsCombined5 := JOIN(wordsCombined4,tempMax,LEFT.seq1 = RIGHT.seq1 AND LEFT.totalScore = RIGHT.totalScore,
																	TRANSFORM(RECORDOF(wordsCombined4),SELF := LEFT),LOOKUP);
		 removeNoisewordsCombined5 := join(wordsCombined5,BusName_getNoiseWords(),left.word1=right.Word,transform(left),left only);
		 removeNoiseinputNameWords := join(inputNameWords,BusName_getNoiseWords(),left.word=right.Word,transform(left),left only);
	// Normalize the scores
			maxScore := MAX(COUNT(removeNoisewordsCombined5), COUNT(removeNoiseinputNameWords)) * 100;
			calcScore := SUM(removeNoisewordsCombined5, totalScore) / maxScore * 100;
			finalScore := if (calcScore>100,100,calcScore);
			// output(inputNameWords);
			// output(candidateNameWords);
			// output(wordsCombined5);
			// output(maxScore);
			// output(calcScore);
			// output(finalScore);
			RETURN finalScore;
	END;
	
	
	Export cleanBusinessWord (string inStr) := function
		getActualName := cleanOnlyCharacters(inStr);
		getStartPosition := STD.Str.Find(inStr,getActualName[1..3],1);
		cleanFirstPart := cleanWord(inStr[0..getStartPosition-1]);
		cleanSecondPart := cleanOnlyCharacters(inStr[getStartPosition..]);
		returnVal := cleanFirstPart+cleanSecondPart;
		return returnVal;
	end;
	
	
	EXPORT getCleanHealthCareName(string inStr) := FUNCTION
		wordpart := RECORD
			string wordVal;
		END;
		words := RECORD
			string wordVal;
			boolean isInitial;
		END;
			
		HealthCareFilterWords := dataset([{'MEDICAL'},{'CORPORATION'},{'COUNTY'},{'HEALTHCARE'},{'HEALTH'},{'CLINIC'},{'HOSPITAL'},{'UNIVERSITY'},{'OF'},
																			{'AND'},{'THE'},{'SCHOOL'},{'COMMUNITY'},{'CENTER'},{'CENTERS'},{'GROUP'},{'GRP'},{'INC'},{'ASSOCIATES'},{'ASSOC'},
																			{'CORP'},{'LLC'},{'LTD'},{'LLP'},{'INCORPORATION'},{'INCORPORATED'},{'MED'},{'LABORATORY'},{'AUTHORITY'}],wordpart);
		splitStr := STD.Str.SplitWords(inStr,' ');
		ds := dataset(splitStr,wordpart);
		dsClean := project(ds,transform(words,self.wordVal:=cleanWord(left.wordVal);self.isInitial:=length(left.wordVal)=1));
		cleanDS := join(dsClean,HealthCareFilterWords,left.wordVal=right.wordVal,left only);

		words recombine(words L, words R) := TRANSFORM
			SELF.wordVal := L.wordVal + if(L.isInitial and R.isInitial,'',' ')+ R.wordVal;
			self.isInitial := R.isInitial;
		END;

		mergeWords := ITERATE(cleanDS,recombine(LEFT,RIGHT));
		maxRow := count(mergeWords);
		returnVal := trim(mergeWords[maxRow].wordVal,left,right);
		return returnVal;
	END;
	
	
	// EXPORT CompareCliaToState (STRING CliaNumber, STRING2 State) := FUNCTION 
			// CliaStateCode := CliaNumber[1..2]; 
			
			// CliaState := MAP(CliaStateCode = '01' => 'AL',
									  // CliaStateCode = '02' => 'AK',
									  // CliaStateCode = '03' => 'AZ',
										// CliaStateCode = '04' => 'AR',
										// CliaStateCode = '05' or CliaStateCode = '55' or CliaStateCode = '75' => 'CA',
										// CliaStateCode = '06' => 'CO',
										// CliaStateCode = '07' => 'CT',
										// CliaStateCode = '08' => 'DE',
										// CliaStateCode = '09' => 'DC',
										// CliaStateCode = '10' or CliaStateCode = '68' or CliaStateCode = '69' => 'FL',
										// CliaStateCode = '11' => 'GA',
										// CliaStateCode = '12' => 'HI',
										// CliaStateCode = '13' => 'ID',
										// CliaStateCode = '14' or CliaStateCode = '78' => 'IL',
										// CliaStateCode = '15' => 'IN',
										// CliaStateCode = '16' or CliaStateCode = '76' => 'IA',
										// CliaStateCode = '17' => 'KS',
										// CliaStateCode = '18' => 'KY',
										// CliaStateCode = '19' or CliaStateCode = '71' => 'LA',
										// CliaStateCode = '20' => 'ME',
										// CliaStateCode = '21' or  CliaStateCode = '80' => 'MD',
										// CliaStateCode = '22' => 'MA',
										// CliaStateCode = '23' => 'MI',
										// CliaStateCode = '24' or CliaStateCode = '77' => 'MN',
										// CliaStateCode = '25' => 'MS',
										// CliaStateCode = '26' => 'MO',
										// CliaStateCode = '27' => 'MT',
										// CliaStateCode = '28' => 'NE',
										// CliaStateCode = '29' => 'NV',
										// CliaStateCode = '30' => 'NH',
										// CliaStateCode = '31' => 'NJ',
										// CliaStateCode = '32' => 'NM',
										// CliaStateCode = '33' => 'NY',
										// CliaStateCode = '34' => 'NC',
										// CliaStateCode = '35' => 'ND',
										// CliaStateCode = '36' or CliaStateCode = '72' => 'OH',
										// CliaStateCode = '37' => 'OK',
										// CliaStateCode = '38' => 'OR',
										// CliaStateCode = '39' or CliaStateCode = '73' => 'PA',
										// CliaStateCode = '40' => 'PR',
										// CliaStateCode = '41' => 'RI',
										// CliaStateCode = '42' => 'SC',
										// CliaStateCode = '43' => 'SD',
										// CliaStateCode = '44' => 'TN',
										// CliaStateCode = '45' or CliaStateCode = '67' or CliaStateCode = '74' => 'TX',
										// CliaStateCode = '46' => 'UT',
										// CliaStateCode = '47' => 'VT',
										// CliaStateCode = '48' => 'VI',
										// CliaStateCode = '49' => 'VA',
										// CliaStateCode = '50' => 'WA',
										// CliaStateCode = '51' => 'WV',
										// CliaStateCode = '52' => 'WI',
										// CliaStateCode = '53' => 'WY',
										// CliaStateCode = '64' => 'AS',
										// CliaStateCode = '65' => 'GU',
										// CliaStateCode = '66' => 'MP',
										// '');
										
			// return CliaState = State;
	// END;
	//Did Frequency Logic
	Export processDids(dataset(Healthcare_Shared.Layouts.layout_did) ds) := Function  
		grp:=sort(ds,did);
		tmprec := record
			did:=grp.did;
			freq:=count(group);
		end;
		t:=table(grp,tmprec,did,few);
		f:=sort(project(t,Healthcare_Shared.Layouts.layout_did),-freq);
		return f;
	end;
	
	
	// BDid Frequency Logic
	Export processBDids(dataset(Healthcare_Shared.Layouts.layout_bdid) ds) := Function  
		grp:=sort(ds,bdid);
		tmprec := record
			bdid:=grp.bdid;
			freq:=count(group);
		end;
		t:=table(grp,tmprec,bdid,few);
		f:=sort(project(t,Healthcare_Shared.Layouts.layout_bdid),-freq);
		return f;
	end;
	
	
	// BIP Frequency Logic
	Export processBIPKeys(dataset(Healthcare_Shared.Layouts.layout_bipkeys) ds) := Function  
		grp:=group(sort(ds,UltID,UltScore,UltWeight,OrgID,OrgScore,OrgWeight,SELEID,SELEScore,SELEWeight,ProxID,ProxScore,ProxWeight),UltID,OrgID,SELEID,ProxID);
		tmprec := record
			UltID:=grp.UltID;
			UltScore:=max(grp.UltScore);
			UltWeight:=max(grp.UltWeight);
			OrgID:=grp.OrgID;
			OrgScore:=max(grp.OrgScore);
			OrgWeight:=max(grp.OrgWeight);
			SELEID:=grp.SELEID;
			SELEScore:=max(grp.SELEScore);
			SELEWeight:=max(grp.SELEWeight);
			ProxID:=grp.ProxID;
			ProxScore:=max(grp.ProxScore);
			ProxWeight:=max(grp.ProxWeight);
			freq:=count(group);
		end;
		t:=table(grp,tmprec,few);
		f:=sort(project(t,Healthcare_Shared.Layouts.layout_bipkeys),-freq);
		return f;
	end;
	
	
	export buildFullName (string pre_name, string first_name, string middle_name, string last_name, string maturity_suffix, string other_suffix) := function
		n1 := pre_name;
		n2 := trim(n1,right) + ' ' +first_name;
		n3 := trim(n2,right) + ' ' +middle_name;
		n4 := trim(n3,right) + ' ' +last_name;
		n5 := trim(n4,right) + ' ' +maturity_suffix;
		n6 := trim(n5,right) + ' ' +other_suffix;
		return trim(n6,right);
	end;

	export buildAddress (string prim_range, string predir, string prim_name, string addr_suffix, string postdir, string unit_desig, string sec_range) := function
		addr1 := prim_range;
		addr2 := trim(addr1,right) + ' ' +predir;
		addr3 := trim(addr2,right) + ' ' +prim_name;
		addr4 := trim(addr3,right) + ' ' +addr_suffix;
		addr5 := trim(addr4,right) + ' ' +postdir;
		addr6 := trim(addr5,right) + ' ' +unit_desig;
		return trim(trim(addr6,right)+ ' ' +sec_range,right);
	end;
	
	
	//Penalty Functions
	export getHospitalAffiliationPenalty (string inStreet, string inCity, string inState, string inZip, string rawStreet, string rawCity, string rawState, string rawZip):=function
			tempaddrmod := MODULE(PROJECT(gm, AutoStandardI.LIBIN.PenaltyI_Addr.full, opt))					
					EXPORT predir         := '';
					EXPORT prim_name      := '';
					EXPORT prim_range     := '';
					EXPORT postdir        := '';
					EXPORT addr_suffix    := '';
					EXPORT sec_range      := '';
					EXPORT p_city_name    := inCity;
					EXPORT st             := inState;
					EXPORT z5             := inZip;											
					//	The address in the matching record:						
					EXPORT allow_wildcard  := FALSE;															
					EXPORT city_field      := rawCity;
					EXPORT city2_field     := '';										
					EXPORT pname_field     := '';									
					EXPORT prange_field    := '';										
					EXPORT postdir_field   := '';																				
					EXPORT predir_field    := '';									
					EXPORT state_field     := rawState;										
					EXPORT suffix_field    := '';										
					EXPORT zip_field       := rawZip;											
					EXPORT sec_range_field := '';
					EXPORT useGlobalScope  := FALSE;
			end;
			
			addrPenalty:=AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempaddrmod);
			foundStreet := STD.Str.Contains(rawStreet,inStreet,true);
			return If(foundStreet,addrPenalty,addrPenalty+5);
	end;
	
	
	Shared matchData := record
		string		matchFieldRaw := '';
		string		matchFieldClnString := '';
		unsigned	matchFieldClnNumber := 0;
		string		matchFieldOptional := '';
	End;
	
	
	Shared calcStLicPenalty(String rawLicenseState, String rawLicense, dataset(Healthcare_Shared.Layouts.layout_licenseinfo) recs) := Function
		validdata := rawLicense<>'';
		missingState := rawLicenseState='';
		tmpRec := project(recs,transform(matchData,
														self.matchFieldOptional:=left.LicenseState;
														self.matchFieldClnNumber:= (integer)cleanOnlyNumbers(left.LicenseNumber);
														self.matchFieldClnString:= cleanOnlyNumbers(left.LicenseNumber);
														self.matchFieldRaw:= left.LicenseNumber;));
		checkRaw := tmpRec(STD.Str.ToUpperCase(matchFieldRaw)=rawLicense);
		checkClnString := tmpRec(matchFieldClnString=cleanOnlyNumbers(rawLicense));
		checkClnNumber := tmpRec(matchFieldClnNumber=(integer)cleanOnlyNumbers(rawLicense));
		finalRaw := if(missingstate,checkRaw,checkRaw(STD.Str.ToUpperCase(matchFieldOptional)=rawLicenseState));
		finalClnString := if(missingstate,checkClnString,checkClnString(STD.Str.ToUpperCase(matchFieldOptional)=rawLicenseState));
		finalClnNumber := if(missingstate,checkClnNumber,checkClnNumber(STD.Str.ToUpperCase(matchFieldOptional)=rawLicenseState));
		penaltyVal := map(validdata and exists(recs) and exists(finalRaw) => 0,
											validdata and exists(recs) and exists(finalClnString) => 1,
											validdata and exists(recs) and exists(finalClnNumber) => 1,
											validdata and exists(recs) => 2,
											validdata and not exists(recs) => 0,
											0);
		return penaltyVal;
	end;
	
	
	Shared calcTaxIdPenalty(String rawInput, dataset(Healthcare_Shared.Layouts.layout_taxid) recs) := Function
		validdata := length(trim(rawInput,all))>0;
		tmpRec := project(recs,transform(matchData,
														self.matchFieldClnNumber:= (integer)cleanOnlyNumbers(left.taxid);
														self.matchFieldClnString:= cleanOnlyNumbers(left.taxid);
														self.matchFieldRaw:= left.taxid;));
		checkRaw := tmpRec(matchFieldRaw=rawInput);
		checkClnString := tmpRec(matchFieldClnString=cleanOnlyNumbers(rawInput));
		checkClnNumber := tmpRec(matchFieldClnNumber=(integer)cleanOnlyNumbers(rawInput));
		penaltyVal := map(validdata and exists(recs) => if(exists(checkRaw) or exists(checkClnString) or Exists(checkClnNumber),0,2),
											validdata and not exists(recs) => 1,
											0);
		return penaltyVal;
	end;
	
	
	Shared calcFeinPenalty(String rawInput, dataset(Healthcare_Shared.Layouts.layout_fein) recs) := Function
		validdata := length(trim(rawInput,all))>0;
		tmpRec := project(recs,transform(matchData,
														self.matchFieldClnNumber:= (integer)cleanOnlyNumbers(left.fein);
														self.matchFieldClnString:= cleanOnlyNumbers(left.fein);
														self.matchFieldRaw:= left.fein;));
		checkRaw := tmpRec(matchFieldRaw=rawInput);
		checkClnString := tmpRec(matchFieldClnString=cleanOnlyNumbers(rawInput));
		checkClnNumber := tmpRec(matchFieldClnNumber=(integer)cleanOnlyNumbers(rawInput));
		penaltyVal := map(validdata and exists(recs) => if(exists(checkRaw) or exists(checkClnString) or Exists(checkClnNumber),0,2),
											validdata and not exists(recs) => 1,
											0);
		return penaltyVal;
	end;
	
	
	Shared calcUpinPenalty(String rawInput, dataset(Healthcare_Shared.Layouts.layout_upin) recs) := Function
		validdata := length(trim(rawInput,all))>0;
		tmpRec := project(recs,transform(matchData,
														self.matchFieldClnNumber:= (integer)cleanOnlyNumbers(left.upin);
														self.matchFieldClnString:= cleanOnlyNumbers(left.upin);
														self.matchFieldRaw:= left.upin;));
		checkRaw := tmpRec(STD.Str.ToUpperCase(matchFieldRaw)=rawInput);
		checkClnString := tmpRec(STD.Str.ToUpperCase(matchFieldClnString)=cleanOnlyNumbers(rawInput));
		checkClnNumber := tmpRec(matchFieldClnNumber=(integer)cleanOnlyNumbers(rawInput));
		penaltyVal := map(validdata and exists(recs) => if(exists(checkRaw) or exists(checkClnString) or Exists(checkClnNumber),0,2),
											validdata and not exists(recs) => 1,
											0);
		return penaltyVal;
	end;
	
	
	Shared calcNpiPenalty(String rawInput, dataset(Healthcare_Shared.Layouts.layout_npi) recs) := Function
		validdata := length(trim(rawInput,all))>0;
		tmpRec := project(recs,transform(matchData,
														self.matchFieldClnNumber:= (integer)cleanOnlyNumbers(left.npi);
														self.matchFieldClnString:= cleanOnlyNumbers(left.npi);
														self.matchFieldRaw:= left.npi;));
		checkRaw := tmpRec(matchFieldRaw=rawInput);
		checkClnString := tmpRec(matchFieldClnString=cleanOnlyNumbers(rawInput));
		checkClnNumber := tmpRec(matchFieldClnNumber=(integer)cleanOnlyNumbers(rawInput));
		penaltyVal := map(validdata and exists(recs) => if(exists(checkRaw) or exists(checkClnString) or Exists(checkClnNumber),0,4),
											validdata and not exists(recs) => 1,
											0);
		return penaltyVal;
	end;
	
	
	Shared calcDeaPenalty(String rawInput, dataset(Healthcare_Shared.Layouts.layout_dea) recs) := Function
		validdata := length(trim(rawInput,all))>0;
		tmpRec := project(recs,transform(matchData,
														self.matchFieldClnNumber:= (integer)cleanOnlyNumbers(left.dea_num);
														self.matchFieldClnString:= cleanOnlyNumbers(left.dea_num);
														self.matchFieldRaw:= left.dea_num;));
		checkRaw := tmpRec(STD.Str.ToUpperCase(matchFieldRaw)=rawInput);
		checkClnString := tmpRec(matchFieldClnString=cleanOnlyNumbers(rawInput));
		checkClnNumber := tmpRec(matchFieldClnNumber=(integer)cleanOnlyNumbers(rawInput));
		penaltyVal := map(validdata and exists(recs) => if(exists(checkRaw) or exists(checkClnString) or Exists(checkClnNumber),0,4),
											validdata and not exists(recs) => 1,
											0);
		return penaltyVal;
	end;	
	
	
	Shared calcCLIAPenalty(String rawInput, dataset(Healthcare_Shared.Layouts.layout_clianumber) recs) := Function
		validdata := length(trim(rawInput,all))>0;
		checkString := recs((integer)cleanOnlyNumbers(clianumber)=(integer)cleanOnlyNumbers(rawInput));
		penaltyVal := map(validdata and exists(recs) => if(exists(checkString),0,4),
											0);
		return penaltyVal;
	end;	
	
	
	Shared calcNCPDPPenalty(String rawInput, dataset(iesp.ncpdp.t_PharmacyReportConsolidatedSearch) recs) := Function
		validdata := length(trim(rawInput,all))>0;
		RecsRaw := project(recs,Transform(iesp.ncpdp.t_PharmacyInformation,self:=left.EntityInformation;self:=[]));
		checkString := RecsRaw(PharmacyProviderId=rawInput);
		penaltyVal := map(validdata and exists(recs) => if(exists(checkString),0,4),
											0);
		return penaltyVal;
	end;	
	
	
	export getAddrPenalty (string inStreetNbr, string inStreet, string inCity, string inState, string inZip, string rawStreetNbr ,string rawStreet, string rawCity, string rawState, string rawZip, integer zip_Radius):=function
			tempaddrmod := MODULE(PROJECT(gm, AutoStandardI.LIBIN.PenaltyI_Addr.full, opt))					
					EXPORT predir         := '';
					EXPORT prim_name      := inStreet;
					EXPORT prim_range     := '';
					EXPORT postdir        := '';
					EXPORT addr_suffix    := '';
					EXPORT sec_range      := '';
					EXPORT p_city_name    := inCity;
					EXPORT st             := inState;
					EXPORT z5             := inZip;											
					EXPORT zipradius      := zip_Radius;											
					//	The address in the matching record:						
					EXPORT allow_wildcard  := FALSE;															
					EXPORT city_field      := rawCity;
					EXPORT city2_field     := '';										
					EXPORT pname_field     := rawStreet;									
					EXPORT prange_field    := '';										
					EXPORT postdir_field   := '';																				
					EXPORT predir_field    := '';									
					EXPORT state_field     := rawState;										
					EXPORT suffix_field    := '';										
					EXPORT zip_field       := rawZip;											
					EXPORT sec_range_field := '';
					EXPORT zipradius_value := zip_Radius;											
					EXPORT useGlobalScope  := FALSE;
			end;
			
			addrPenalty:=AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempaddrmod);
			foundHouse := STD.Str.Contains(rawStreetNbr,inStreetNbr,true);
			return If(foundHouse,addrPenalty,addrPenalty+2);
	end;
	
	
	Export getBestAddrPenalty (dataset(Healthcare_Shared.Layouts.layout_addressinfo) inAddrs, Healthcare_Shared.Layouts.userInputCleanMatch input, integer zipradius) := function
			bestValues := project(inAddrs,transform(Healthcare_Shared.Layouts.layout_addressinfo,
															getPenalty := getAddrPenalty(STD.Str.ToUpperCase(input.prim_range),STD.Str.ToUpperCase(input.prim_name),STD.Str.ToUpperCase(input.p_city_name),STD.Str.ToUpperCase(input.st),input.z5,
																															 STD.Str.ToUpperCase(left.prim_range),STD.Str.ToUpperCase(left.prim_name),STD.Str.ToUpperCase(left.p_city_name),STD.Str.ToUpperCase(left.st),left.z5,zipradius);
															self.addrPenalty:=getPenalty;self:=left));
			return min(bestValues,addrpenalty);
	end;
	
	
	export getNamePenalty (string inFirst, string inMiddle, string inLast, string inCompany, string rawFirst ,string rawMiddle, string rawLast, string rawCompany):=function
			tempNameMod := MODULE(PROJECT(gm, AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, opt))					
				EXPORT lastname       := rawLast;       // the 'input' last name
				EXPORT middlename     := rawMiddle;     // the 'input' middle name
				EXPORT firstname      := rawFirst;      // the 'input' first name
				EXPORT allow_wildcard := FALSE;
				EXPORT useGlobalScope := FALSE;									
				EXPORT lname_field    := inLast;			// matching record name information			                          
				EXPORT mname_field    := inMiddle; 
				EXPORT fname_field    := inFirst;	
			END;	
			foundName := inLast <> '' and rawLast <> '';
			namePenalty := map(foundName=>AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempNameMod),
												 inLast <> '' => 10,
												 0);	
			foundCompany := inCompany<> '' and rawCompany <> ''; // we found a business
			Confidence := CompareBusinessNameConfidence(rawCompany,inCompany);
			busPenalty := map(foundCompany => if(Confidence>=Healthcare_Shared.Constants.BUS_NAME_BIPMATCH_THRESHOLD,(100-Confidence)/10,100-Confidence),
												inCompany <> '' => 10,
												0);
			return namePenalty+busPenalty;
	end;
	
	
	Export getBestNamePenalty (dataset(Healthcare_Shared.Layouts.layout_nameinfo) inNames, Healthcare_Shared.Layouts.userInputCleanMatch input) := function
			bestValues := project(inNames(LastName<>'' or CompanyName <>''),transform(Healthcare_Shared.Layouts.layout_nameinfo,
															getPenalty := getNamePenalty(STD.Str.ToUpperCase(input.name_first),STD.Str.ToUpperCase(input.name_middle),STD.Str.ToUpperCase(input.name_last),STD.Str.ToUpperCase(input.comp_name),
																														STD.Str.ToUpperCase(left.FirstName),STD.Str.ToUpperCase(left.MiddleName),STD.Str.ToUpperCase(left.LastName),STD.Str.ToUpperCase(left.CompanyName));
															self.namePenalty:=getPenalty;self:=left));
			return min(bestValues,namePenalty);
	end;
	
	
	Export doPenalty (dataset(Healthcare_Shared.Layouts.CombinedHeaderResults) inRecs, dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input, Healthcare_Shared.Layouts.common_runtime_config cfg, integer zipradius = Healthcare_Shared.Constants.ZIP_RADIUS) := function
		//Custom penalty logic
		maxPenalty := cfg.penalty_threshold;
		EnhancedPenalty := cfg.MatchScoreThreshold;
		EnhancedBusPenalty := cfg.FacilityMatchScoreThreshold;
		outRec := Healthcare_Shared.Layouts.CombinedHeaderResults;
		outRec xform(outRec l, Healthcare_Shared.Layouts.userInputCleanMatch r) := transform
						//Collect Addresses and apply penalty to get lowest
						allAddrs := l.addresses + project(l.affiliates,transform(Healthcare_Shared.Layouts.layout_addressinfo, self:=left;self:=[])) + project(l.hospitals,transform(Healthcare_Shared.Layouts.layout_addressinfo, self:=left;self:=[]));
						hasAddressInput := r.prim_range<>'' or r.prim_name <> '' or r.p_city_name <> '' or r.st <> '' or r.z5 <>'';
						hasNameInput := r.name_first <> '' or r.name_middle <> '' or r.name_last <> '' or r.comp_name <>'';
						addrPen := if(hasAddressInput,getBestAddrPenalty(allAddrs,r,zipradius),0);
						namePen := if(hasNameInput,getBestNamePenalty(l.names,r),0);
						stlicPen := if(r.license_state<>'',calcStLicPenalty(STD.Str.ToUpperCase(r.license_state), STD.Str.ToUpperCase(r.license_number), l.StateLicenses),0);
						taxidPen := if(r.TaxID<>'',calcTaxIdPenalty(r.TaxID, l.taxids),0);
						feinPen := if(r.FEIN<>'',calcFeinPenalty(r.FEIN, l.feins),0);
						upinPen := if(r.UPIN<>'',calcUpinPenalty(STD.Str.ToUpperCase(r.UPIN), l.upins),0);
						npiPen := if(r.NPI<>'',calcNpiPenalty(r.NPI, l.npis),0);
						deaPen := if(r.DEA<>'',calcDeaPenalty(STD.Str.ToUpperCase(r.DEA), l.deas),0);
						cliaPen := if(r.CLIANumber<>'',calcCLIAPenalty(STD.Str.ToUpperCase(r.CLIANumber), l.clianumbers),0);
						ncpdpPen := if(r.NcpdpNumber<>'',calcNCPDPPenalty(r.NcpdpNumber, l.NCPDPRaw),0);
						isLNIDMatch := (exists(l.dids(did=r.did)) and r.did>0) or (exists(l.bdids(bdid=r.bdid)) and r.bdid>0);
						isDEAMatch := exists(l.deas(dea_num=r.DEA)) and r.DEA<>'';
						isNPIMatch := exists(l.npis(npi=r.NPI)) and r.NPI<>'';
						isUPINMatch := exists(l.upins(upin=r.UPIN)) and r.UPIN<>'';
						isExactCLIA := exists(l.clianumbers((integer)cleanOnlyNumbers(clianumber)=(integer)cleanOnlyNumbers(r.CLIANumber))) and r.CLIANumber<>'';
						isExactNCPDP := exists(l.NCPDPRaw(trim(EntityInformation.PharmacyProviderId,all)=Trim(r.NCPDPNumber,all))) and r.NCPDPNumber<>'';
						isStateLicenseMatch0 := exists(l.StateLicenses(LicenseNumber=r.license_number and r.license_number<>'' and (LicenseState=r.license_state or LicenseState=r.st or (r.license_state='' and r.st='')) and stlicPen = 0 and namePen <= 3)); 
						isStateLicenseMatch1 := exists(l.StateLicenses(LicenseNumber=r.StateLicense1Verification and r.StateLicense1Verification<>'' and (LicenseState=r.StateLicense1StateVerification or LicenseState=r.st or (r.StateLicense1StateVerification='' and r.st='')) and stlicPen = 0 and namePen <= 3));
						isStateLicenseMatch2 := exists(l.StateLicenses(LicenseNumber=r.StateLicense2Verification and r.StateLicense2Verification<>'' and (LicenseState=r.StateLicense2StateVerification or LicenseState=r.st or (r.StateLicense2StateVerification='' and r.st='')) and stlicPen = 0 and namePen <= 3)); 
						isStateLicenseMatch3 := exists(l.StateLicenses(LicenseNumber=r.StateLicense3Verification and r.StateLicense3Verification<>'' and (LicenseState=r.StateLicense3StateVerification or LicenseState=r.st or (r.StateLicense3StateVerification='' and r.st='')) and stlicPen = 0 and namePen <= 3)); 
						isStateLicenseMatch4 := exists(l.StateLicenses(LicenseNumber=r.StateLicense4Verification and r.StateLicense4Verification<>'' and (LicenseState=r.StateLicense4StateVerification or LicenseState=r.st or (r.StateLicense4StateVerification='' and r.st='')) and stlicPen = 0 and namePen <= 3));
						isStateLicenseMatch5 := exists(l.StateLicenses(LicenseNumber=r.StateLicense5Verification and r.StateLicense5Verification<>'' and (LicenseState=r.StateLicense5StateVerification or LicenseState=r.st or (r.StateLicense5StateVerification='' and r.st='')) and stlicPen = 0 and namePen <= 3)); 
						isStateLicenseMatch6 := exists(l.StateLicenses(LicenseNumber=r.StateLicense6Verification and r.StateLicense6Verification<>'' and (LicenseState=r.StateLicense6StateVerification or LicenseState=r.st or (r.StateLicense6StateVerification='' and r.st='')) and stlicPen = 0 and namePen <= 3)); 
						isStateLicenseMatch7 := exists(l.StateLicenses(LicenseNumber=r.StateLicense7Verification and r.StateLicense7Verification<>'' and (LicenseState=r.StateLicense7StateVerification or LicenseState=r.st or (r.StateLicense7StateVerification='' and r.st='')) and stlicPen = 0 and namePen <= 3)); 
						isStateLicenseMatch8 := exists(l.StateLicenses(LicenseNumber=r.StateLicense8Verification and r.StateLicense8Verification<>'' and (LicenseState=r.StateLicense8StateVerification or LicenseState=r.st or (r.StateLicense8StateVerification='' and r.st='')) and stlicPen = 0 and namePen <= 3)); 
						isStateLicenseMatch9 := exists(l.StateLicenses(LicenseNumber=r.StateLicense9Verification and r.StateLicense9Verification<>'' and (LicenseState=r.StateLicense9StateVerification or LicenseState=r.st or (r.StateLicense9StateVerification='' and r.st='')) and stlicPen = 0 and namePen <= 3)); 
						isStateLicenseMatch10 := exists(l.StateLicenses(LicenseNumber=r.StateLicense10Verification and r.StateLicense10Verification<>'' and (LicenseState=r.StateLicense10StateVerification or LicenseState=r.st or (r.StateLicense10StateVerification='' and r.st='')) and stlicPen = 0 and namePen <= 3));
						isStateLicenseMatch := isStateLicenseMatch0 or isStateLicenseMatch1 or isStateLicenseMatch2 or isStateLicenseMatch3 or
																		isStateLicenseMatch4 or isStateLicenseMatch5 or isStateLicenseMatch6 or isStateLicenseMatch7 or 
																		isStateLicenseMatch8 or isStateLicenseMatch9 or isStateLicenseMatch10;
						isLNPIDMatch := r.LNPID > 0 and r.derivedInputRecord = false and (l.lnpid > 0 and l.lnpid = r.LNPID);
						isLNFIDMatch := r.LNFID > 0 and r.derivedInputRecord = false and (l.lnfid > 0 and l.lnfid = r.LNFID);
						isExactSSN := exists(l.ssns(ssn=r.SSN)) and r.SSN <> '';
						isDeepDiveSSNMatch := exists(l.ssns(ssn=r.SSN)) and r.SSN <> '' and l.src = Healthcare_Shared.Constants.SRC_BOCA_PERSON_HEADER;
						isDeepDiveFEINMatch := exists(l.feins(fein=r.fein)) and r.fein <> '' and l.src = Healthcare_Shared.Constants.SRC_BOCA_BUS_HEADER;
						adjustAddrPenalty := isDEAMatch or isNPIMatch or isUPINMatch or isExactCLIA or isExactNCPDP or isStateLicenseMatch;
						addrPenalty :=if(adjustAddrPenalty,truncate(addrPen/10),addrPen);//Address penalty could be very high and should not count as much as other penalties divide by 10
						totalPen := namePen+addrPenalty+stlicPen+taxidPen+feinPen+upinPen+npiPen+deaPen+cliaPen+ncpdpPen;
						//If the user supplied a DID, Bdid or other identifier exactly, go ahead and return that record.
						self.LNPID := if(l.LNPID = 0, l.SrcId, l.LNPID);
						self.record_penalty :=totalPen;
						self.record_penalty_name :=namePen;
						self.record_penalty_addr :=addrPenalty;
						self.record_penalty_license :=stlicPen+taxidPen+feinPen+upinPen+npiPen+deaPen+cliaPen+ncpdpPen;
						self.penalty_applied := true;
						self.isExactLNID := isLNIDMatch;
						self.isExactDEA := isDEAMatch;
						self.isExactNPI := isNPIMatch;
						self.isExactUPIN := isUPINMatch;
						self.isExactCLIA := isExactCLIA;
						self.isExactNCPDP := isExactNCPDP;
						self.isExactSSN := isExactSSN;
						self.isDeepDiveSSNMatch := isDeepDiveSSNMatch;
						self.isDeepDiveFEINMatch := isDeepDiveFEINMatch;
						self.isExactStateLicense := isStateLicenseMatch;
						self.isExactLNPID := isLNPIDMatch;
						self.isDerivedSource := r.derivedInputRecord;
						self :=l;
						self:=[];
		end;
		recsWithPenalty := join(inRecs(penalty_applied=false),input,left.acctno=right.acctno,xform(left,right),keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0));
		// removeOverPenalty := recsWithPenalty(record_penalty<=if(src=Healthcare_Shared.Constants.SRC_BOCA_PERSON_HEADER,maxPenalty*Healthcare_Shared.Constants.DEEPDIVE_PENALTY_MULTIPLIER,maxPenalty) or isExactLNID or isExactDEA or isExactNPI or isExactUPIN or isExactCLIA or isExactNCPDP or isExactStateLicense  or isExactLNPID or isExactLNFID or isExactSSN or isautokeysresult or isDeepDiveSSNMatch or isDeepDiveFEINMatch);		
		removeOverPenalty := project(recsWithPenalty, transform(outRec, 
																					keepRec :=(left.record_penalty<=if(left.src=Healthcare_Shared.Constants.SRC_BOCA_PERSON_HEADER,maxPenalty*Healthcare_Shared.Constants.DEEPDIVE_PENALTY_MULTIPLIER,maxPenalty) or left.isExactLNID or left.isExactDEA or left.isExactNPI or left.isExactUPIN or left.isExactCLIA or left.isExactNCPDP or left.isExactStateLicense  or left.isExactLNPID or left.isExactLNFID or left.isExactSSN or left.isautokeysresult or left.isDeepDiveSSNMatch or left.isDeepDiveFEINMatch) and
																										((left.srcBusinessHeader and left.record_penalty_enhanced >= EnhancedBusPenalty) or
																										(left.srcIndividualHeader and left.record_penalty_enhanced >= EnhancedPenalty));
																					self.acctno := if(keepRec,left.acctno,skip); self:= left));
		//remove derived records if we have a non derived input records with the same acctno.
		recsNotDerivedInput := removeOverPenalty(isDerivedSource=false);
		recsDerivedInput := join(removeOverPenalty,recsNotDerivedInput, left.acctno=right.acctno, all, left only);
		finalRecs := recsNotDerivedInput+recsDerivedInput+inRecs(penalty_applied=true);
		sortRecs := sort(finalRecs,acctno,srcid,src,record_penalty);
		dedupRecs := sort(dedup(sortRecs, acctno,srcid,src),record_penalty);
		// output(recsWithPenalty,named('recsWithPenalty'),extend);
		// output(removeOverPenalty,named('removeOverPenalty'),extend);
		// output(maxPenalty,named('doPenalty_maxPenalty'),overwrite);
		// output(recsDerivedInput,named('doPenalty_recsDerivedInput'),extend);
		// output(finalRecs,named('doPenalty_finalRecs'),extend);
		// output(sortRecs,named('doPenalty_sortRecs'),extend);;
		// output(recsNotDerivedInput,named('doPenalty_recsNotDerivedInput'),extend);
		// output(dedupRecs,named('doPenalty_dedupRecs'),extend);
		// output(Healthcare_Shared.Constants.ZIP_RADIUS, named('zipradius'),overwrite);
		return dedupRecs;
	end;
	
	
	//Enclarity specific Functions
		Export buildLegacySanctionRecord(Healthcare_Shared.Layouts.CombinedHeaderResults parent, dataset(Healthcare_Shared.Layouts.layout_sanctions) sanc) := Function
			outlayout := Healthcare_Shared.Layouts.layout_LegacySanctions;
			results := project(choosen(sanc,iesp.Constants.HPR.MAX_SANCTIONS),transform(outlayout,
											self.acctno := trim(left.acctno,left,right);
											self.InternalID:= left.InternalID;
											self.group_key:=left.group_key;
											//GenerateID
											sancid:= (string)left.InternalID+intformat(left.GroupSortOrder,3,1);
											self.sanc_id:=(integer)sancid;
											self.SANC_DOB := parent.dobs[1].dob;
											self.SANC_TIN := parent.taxids[1].taxid;
											self.SANC_UPIN := parent.upins[1].upin;
											self.SANC_PROVTYPE := trim(left.prov_type_desc,left,right);
											self.SANC_BRDTYPE := left.StateOrFederal;
											self.SANC_SANCDTE_form := trim(left.sanc1_date,left,right);
											self.SANC_SANCDTE := if(length(trim(left.sanc1_date,left,right))=8 and (integer)left.sanc1_date>0,left.sanc1_date[5..6]+'/'+left.sanc1_date[7..8]+'/'+left.sanc1_date[1..4],'');
											reinstate_date := map((integer)left.sanc1_rein_date>0 => left.sanc1_rein_date,
																						(integer)left.clean_sanc1_rein_date > 0 => left.clean_sanc1_rein_date,
																						left.ln_derived_rein_date);
											self.LNDerivedReinstateDate := left.ln_derived_rein_flag;
											self.SANC_REINDTE_form := trim(reinstate_date,left,right);
											self.SANC_REINDTE := if(length(trim(reinstate_date,left,right))=8 and (integer)reinstate_date>0,reinstate_date[5..6]+'/'+reinstate_date[7..8]+'/'+reinstate_date[1..4],'');
											self.SANC_LICNBR := trim(LEFT.sanc1_lic_num,left,right);
											self.SANC_SANCST := left.sanc1_state;
											self.SANC_SRC_DESC := map(left.StateOrFederal='FEDERAL' and left.SancLevel='OIG' =>'OFFICE OF INSPECTOR GENERAL',
																								left.StateOrFederal='FEDERAL' and left.SancLevel='OPM' =>'OFFICE OF PERSONNEL MANAGEMENT',left.RegulatingBoard);
											self.SANC_COND := trim(left.SancCategory,left,right);
											self.SANC_REAS := trim(left.FullDesc,left,right);
											self.SANC_TYPE := trim(left.SancLegacyType,left,right);
											self.date_first_reported := (string)left.dt_vendor_first_reported;
											self.date_last_reported := (string)left.dt_vendor_last_reported;
											self.SANC_FAB := if(left.SancCategory='FRAUD/ABUSE','TRUE','FALSE');
											self.SANC_UNAMB_IND := left.SancLossOfLic;
											self.sanc_grouptype :=left.StateOrFederal;
											self.sanc_subgrouptype :=left.SancLevel;
											self.date_first_seen  := (string)left.dt_first_seen;
											self.date_last_seen := (string)left.dt_last_seen;
											self.process_date := (string)left.dt_last_seen;
											self.SANC_BUSNME := trim(parent.Names[1].CompanyName,left,right);
											self.Prov_Clean_title := parent.Names[1].Title;
											self.Prov_Clean_fname := parent.Names[1].FirstName;
											self.Prov_Clean_mname := parent.Names[1].MiddleName;
											self.Prov_Clean_lname := parent.Names[1].LastName;
											self.Prov_Clean_name_suffix := parent.Names[1].suffix;
											self.ProvCo_Address_Clean_prim_range := parent.Addresses[1].prim_range;
											self.ProvCo_Address_Clean_predir := parent.Addresses[1].predir;
											self.ProvCo_Address_Clean_prim_name := parent.Addresses[1].prim_name;
											self.ProvCo_Address_Clean_addr_suffix := parent.Addresses[1].addr_suffix;
											self.ProvCo_Address_Clean_postdir := parent.Addresses[1].postdir;
											self.ProvCo_Address_Clean_unit_desig := parent.Addresses[1].unit_desig;
											self.ProvCo_Address_Clean_sec_range := parent.Addresses[1].sec_range;
											self.ProvCo_Address_Clean_p_city_name := parent.Addresses[1].p_city_name;
											self.ProvCo_Address_Clean_st := parent.Addresses[1].st;
											self.ProvCo_Address_Clean_zip := parent.Addresses[1].z5;
											self.ProvCo_Address_Clean_geo_lat := parent.Addresses[1].geo_lat;
											self.ProvCo_Address_Clean_geo_long := parent.Addresses[1].geo_long;
											self.did := (string)parent.dids[1].did;
											self.bdid := (string)parent.bdids[1].bdid;
											sancType := left.SancLegacyType;
											self.sanc_priority := map(sancType = 'DEBARRED/EXCLUDED' => 1,
																								sancType = 'DEBARRED/SUSPENDED' => 2,
																								sancType = 'EXCLUDED' => 3,
																								sancType = 'EXCLUSION' => 4,
																								sancType = 'EXCLUDED/DELETED' => 5,
																								sancType = 'LICENSURE DENIED' => 6,
																								sancType = 'CANCELLED' => 7,
																								sancType = 'REVOCATION' => 8,
																								sancType = 'CEASE AND DESIST' => 9,
																								sancType = 'SURRENDER' => 10,
																								sancType = 'VOLUNTARY SURRENDER' => 11,
																								sancType = 'SUSPENSION' => 12,
																								sancType = 'RETIRED' => 13,
																								sancType = 'LIMITED LICENSE' => 14,
																								sancType = 'PROBATION' => 15,
																								sancType = 'REPRIMAND' => 16,
																								sancType = 'CONSENT ORDER' => 17,
																								sancType = 'FINE' => 18,
																								sancType = 'STATEMENT OF CHARGES' => 19,
																								sancType = 'LETTER OF CONCERN' => 20,
																								sancType = 'MODIFICATION OF PREVIOUS ORDER' => 21,
																								sancType = 'ACCUSATION' => 22,
																								sancType = 'OTHER' => 23,
																								sancType = 'NONE GIVEN' => 25,
																								sancType = '' => 25,99);
											self := left;
											self := [];//All other fields are no longer valid via Enclarity conversion from Ingenix
											));
			return results;
		end;
		
		
	//Append Data lookups
	// Export getSlimHdrRecords (dataset(Healthcare_Shared.Layouts.CombinedHeaderResults) resultRecs, 
													// dataset(Healthcare_Shared.Layouts.userInputCleanMatch) inputRecs) := function
		// basedata := join(resultRecs,inputRecs,left.acctno=right.acctno,
											// transform(Healthcare_Shared.Layouts.layout_slim,
															// self.acctno := right.acctno;
															// self.InternalID:=left.InternalID;
															// self.VendorID:='';
															// self.FirstName := STD.Str.ToUpperCase(left.Names[1].FirstName);
															// self.LastName := STD.Str.ToUpperCase(left.Names[1].LastName);
															// self.UserCompanyName := STD.Str.ToUpperCase(right.comp_name);
															// self.CompanyName := STD.Str.ToUpperCase(left.Names[1].CompanyName);
															// self.UserSSN := right.ssn;
															// self.UserDOB := right.dob;
															// self.UserDOBFound := exists(left.dobs(dob[1..6]=right.dob[1..6]));
															// self.UserFEIN := right.fein;
															// self.UserCity := STD.Str.ToUpperCase(right.p_city_name);
															// self.UserState := STD.Str.ToUpperCase(right.st);
															// self.UserZip := right.z5;
															// self.dids := left.dids;
															// self.npis := left.npis;),
												// keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0));
		// return basedata;
	// end;
	
	
	Export getSSN(dataset(Healthcare_Shared.Layouts.CombinedHeaderResults) input) := Function
		ssn_mask_val := AutoStandardI.InterfaceTranslator.ssn_mask_val.val(project(gm,AutoStandardI.InterfaceTranslator.ssn_mask_val.params)); 
		byDids := dedup(normalize(input,left.dids,transform(Healthcare_Shared.Layouts.layout_sanc_DID,self.acctno := left.acctno;self.InternalID:=left.InternalID;self.did:=right.did;self.freq:=right.freq;self:=[])),all);
		Healthcare_Shared.Layouts.layout_ssns_freq get_provider_ssns(Healthcare_Shared.Layouts.layout_sanc_DID l, dx_BestRecords.layout_best r) := transform
			self.ssn := if (r._valid and (r.valid_ssn = 'G' or r.valid_ssn = ' ' or r.valid_ssn = ''), r.ssn, '');
			self := l;
		end;

		best_recs := dx_BestRecords.append(byDids, did, dx_BestRecords.Constants.perm_type.glb);
		f_ssns := project(best_recs, get_provider_ssns(left, left._best))(ssn <> '');

		//Check to see if we have a match to user criteria
		f_ssns_best := join(input,f_ssns,left.acctno=right.acctno and left.InternalID= right.InternalID,
																			transform(Healthcare_Shared.Layouts.layout_ssns_bestHit,self.besthit:=if(trim(left.userinput.ssn,all)=trim(right.ssn,all) and left.userinput.ssn<>'',true,false);self:=left;self:=right),keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN),limit(0));
		//Group and Dedupe
		f_ssns_BestOnly := project(f_ssns_best(besthit=true),Healthcare_Shared.Layouts.layout_ssns);
		f_ssns_GetOthers := join(f_ssns,f_ssns_BestOnly,left.acctno=right.acctno and left.InternalID= right.InternalID,left only);
		//If we are not returning the user value, then base the best on frequence and only return the highest one.
		f_ssns_OthersWithFreq := dedup(sort(f_ssns_GetOthers,acctno,InternalID,-freq),acctno,InternalID);
		f_ssns_OthersWithHighestFreq := project(f_ssns_OthersWithFreq,Healthcare_Shared.Layouts.layout_ssns);
		f_ssns_final := sort(f_ssns_BestOnly+f_ssns_OthersWithHighestFreq,acctno,InternalID);
		//Masking for SSN 
		doxie.MAC_PruneOldSSNs(f_ssns_final, out_ssn_pruned, ssn, InternalID);
		suppress.MAC_Mask(out_ssn_pruned, f_ssns_masked, ssn, blank, true, false,,,,ssn_mask_val);
		Healthcare_Shared.Layouts.layout_child_ssns doRollup(Healthcare_Shared.Layouts.layout_ssns l, dataset(Healthcare_Shared.Layouts.layout_ssns) r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.InternalID := l.InternalID;
			self.childinfo := r;
		END;
		results_rolled := rollup(group(sort(f_ssns_masked(ssn<>''),acctno,InternalID),acctno,InternalID),group,doRollup(left,rows(left)));
		// output(input,named('input_ssns'));
		// output(f_ssns,named('f_ssns'));
		// output(f_ssns_best,named('f_ssns_best'));
		// output(f_ssns_BestOnly,named('f_ssns_BestOnly'));
		// output(f_ssns_OthersWithHighestFreq,named('f_ssns_OthersWithHighestFreq'));
		// output(f_ssns_final,named('f_ssns_final'));
		return results_rolled;
	end;
	Export appendSSN (dataset(Healthcare_Shared.Layouts.CombinedHeaderResults) inputRecs) := function
		fmtRec_SSN := getSSN(inputRecs);
		results := join(inputRecs,fmtRec_SSN, left.acctno=right.acctno and left.InternalID=(integer)right.InternalID,
																		transform(Healthcare_Shared.Layouts.CombinedHeaderResults,
																							self.SSNs := project(right.childinfo,transform(Healthcare_Shared.Layouts.layout_ssn, self.SSN:=left.SSN));
																							self.SSNLookups := right.childinfo;
																							self := left),left outer,keep(Healthcare_Shared.Constants.IDS_PER_DID), limit(0));
		return results;
	end;
		
/*	Export doCheckDeath(dataset(Healthcare_Shared.Layouts.layout_slim) input) := Function
			deathparams := project(gm,deathv2_Services.functions.death_restrictions);
			glb_ok := AutoStandardI.InterfaceTranslator.glb_ok.val(project(gm,AutoStandardI.InterfaceTranslator.glb_ok.params));  
			byDids := normalize(input,left.dids,transform(Healthcare_Shared.Layouts.layout_death_DID,self.acctno := left.acctno;self.InternalID:=left.InternalID;self.did:=right.did;self.ssn:=if(left.UserSSNFound,left.UserSSN,'');self.freq:=right.freq;self.dob:=if(left.UserDOBFound,left.UserDOB[1..6],'');self.UserSSNFound:=left.UserSSNFound;self:=[]));
			byDids_BestFreq := dedup(sort(byDids,acctno,InternalID,-freq),acctno,InternalID);
			deathRecs := join(byDids(SSN<>''),doxie.Key_Death_MasterV2_ssa_Did,
									keyed(left.did = right.l_did)
									and	not DeathV2_Services.Functions.Restricted(right.src, right.glb_flag, deathparams.datarestrictionmask,glb_ok, deathparams.datapermissionmask),
									transform(Healthcare_Shared.Layouts.layout_death_BestHit,
										matchbyDOB := left.dob <> '' and left.dob[1..6]=right.dob8[1..6];
										matchbySSN := left.UserSSNFound and left.SSN = right.ssn;
										keepRecord := map(matchbyDOB or matchbySSN => true,
																		 left.DOB <> '' and not matchbyDOB => false,
																		 left.SSN <> '' and not matchbySSN => false,
																		 true);
										self.acctno:=if(keepRecord,left.acctno,skip); self.InternalID :=left.InternalID;self.death_ind:=true;self.dod:=right.dod8;self.besthit:=if(left.UserSSNFound and left.SSN=right.SSN,true,false)),
									keep(1), limit(0));
			death_BestHit := project(deathRecs(besthit=true),Healthcare_Shared.Layouts.layout_death);
			//if you don't have the best record based on a match to user input, use the best freq.
			death_NotBestHit := join(byDids_BestFreq,death_BestHit,left.acctno=right.acctno and left.InternalID= right.InternalID,left only);
			death_BestFreq := join(death_NotBestHit,doxie.Key_Death_MasterV2_ssa_Did,
									keyed(left.did = right.l_did)
									and	not DeathV2_Services.Functions.Restricted(right.src, right.glb_flag, deathparams.datarestrictionmask,glb_ok, deathparams.datapermissionmask),
									transform(Healthcare_Shared.Layouts.layout_death, 
										matchbyDOB := left.dob <> '' and left.dob[1..6]=right.dob8[1..6];
										matchbySSN := left.UserSSNFound and left.SSN = right.ssn;
										keepRecord := map(matchbyDOB or matchbySSN => true,
																		 left.DOB <> '' and not matchbyDOB => false,
																		 left.SSN <> '' and not matchbySSN => false,
																		 true);
										self.acctno:=if(keepRecord,left.acctno,skip); self.InternalID :=left.InternalID;self.death_ind:=true;self.dod:=right.dod8),
									keep(1), limit(0));
			death_final := sort(death_BestHit+death_BestFreq,acctno,InternalID);
		return death_final;
	end;
	Export appendDeath (dataset(Healthcare_Shared.Layouts.layout_slim) inputSlim, 
											dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) inputRecs) := function
		updateSSN := join(inputRecs,inputSlim,left.acctno=right.acctno and left.InternalID=(integer)right.InternalID,
													transform(Healthcare_Shared.Layouts.layout_slim,self.UserSSNFound:=exists(left.ssns(ssn=right.userSSN));self:=right));
		fmtRec_Death := sort(doCheckDeath(updateSSN),acctno,InternalID,-dod);
		results := join(inputRecs,fmtRec_Death, left.acctno=right.acctno and left.InternalID=(integer)right.InternalID,
																		transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
																							self.DeathLookup := right.death_ind;
																							self.DateofDeath := right.dod;
																							self := left),left outer,keep(Healthcare_Shared.Constants.IDS_PER_DID), limit(0));
		return results;
	end;
	
	*/
	
	//Validate NPI Checksum
	EXPORT fn_NPICheckSum(string checkNPI):= FUNCTION
		NPILength := length(checkNPI);  // NPI is either 10 chars (most of the time) or 15 chars.
		x1 := if(NPILength = 10, (integer)checkNPI[1] * 2,(integer)checkNPI[6] * 2);
		x2 := if(NPILength = 10, (integer)checkNPI[3] * 2,(integer)checkNPI[8] * 2);
		x3 := if(NPILength = 10, (integer)checkNPI[5] * 2,(integer)checkNPI[10] * 2); 
		x4 := if(NPILength = 10, (integer)checkNPI[7] * 2,(integer)checkNPI[12] * 2);
		x5 := if(NPILength = 10, (integer)checkNPI[9] * 2,(integer)checkNPI[14] * 2);
		s1:=if( x1 >9,1+(integer)x1[2],x1);
		s2:=if( x2 >9,1+(integer)x2[2],x2);
		s3:=if( x3 >9,1+(integer)x3[2],x3);
		s4:=if( x4 >9,1+(integer)x4[2],x4);
		s5:=if( x5 >9,1+(integer)x5[2],x5);
		SignificantDigits := s1+s2+s3+s4+s5;
		Unaffected_Digits := CASE(NPILength,  10 => ((integer) checkNPI[2] + (integer) checkNPI[4]+ (integer) checkNPI[6] + (integer) checkNPI[8]),
																					15 => ((integer) checkNPI[7] + (integer) checkNPI[9]+ (integer) checkNPI[11] + (integer) checkNPI[13]), -99);
		CheckSumAllDigits := SignificantDigits + Unaffected_Digits + 24;
		CheckSumModInt := if ((boolean)(CheckSumAllDigits % 10), (integer)((CheckSumAllDigits + 10) / 10), (integer)(CheckSumAllDigits / 10));
		CheckSumFinal := ((CheckSumModInt * 10) - CheckSumAllDigits);
		isGoodCheckDigit := if(NPILength=10 and CheckSumFinal = (integer)checkNPI[10], true,
													if(NPILength=15 and CheckSumFinal = (integer)checkNPI[15], true,false));
		return isGoodCheckDigit;											
	end;
		
	//Enclarity Functions
	EXPORT Healthcare_Shared.Constants.MatchType CompareSoundex(STRING str1, STRING str2) :=  FUNCTION
		sndx1 := Healthcare_Shared.Functions_C.getSoundex(TRIM(str1,LEFT,RIGHT));
		sndx2 := Healthcare_Shared.Functions_C.getSoundex(TRIM(str2,LEFT,RIGHT));

		na := sndx1 = 'Z000' OR sndx2 = 'Z000';
		exactMatch := sndx1 = sndx2;
		// maybe we have a partial match (matches the shorter)?
		minLength := MIN(LENGTH(sndx1),LENGTH(sndx2));
		fuzzyMatch := sndx1[ ..minLength] = sndx2[ ..minLength];
		
		result := if (na, Healthcare_Shared.Constants.MatchType.MT_NA, if (exactMatch, Healthcare_Shared.Constants.MatchType.MT_EXACT, if (fuzzyMatch, Healthcare_Shared.Constants.MatchType.MT_FUZZY, Healthcare_Shared.Constants.MatchType.MT_NO_MATCH)));

		return result;
	end;
	
	
	EXPORT Healthcare_Shared.Constants.MatchType CompareMetaphone(STRING str1, STRING str2) := FUNCTION
		dm1str := Healthcare_Shared.Functions_C.getDoubleMetaphone(TRIM(str1,LEFT,RIGHT));
		dm1 := STD.Str.SplitWords(dm1str,'|');
		dm2str := Healthcare_Shared.Functions_C.getDoubleMetaphone(TRIM(str2,LEFT,RIGHT));
		dm2 := STD.Str.SplitWords(dm2str,'|');
		
		na := dm1[1] = '' OR dm2[1] = '';
		exactMatch := dm1[1] = dm2[1] OR dm1[2] = dm2[2] OR dm1[1] = dm2[2] OR dm1[2] = dm2[1];
		// maybe we have a partial match (matches the shorter)?
		minLength1 := MIN(LENGTH(dm1[1]),LENGTH(dm2[1]));
		fuzzyMatch1 := dm1[1][ ..minLength1] = dm2[1][ ..minLength1];
		minLength2 := MIN(LENGTH(dm1[2]),LENGTH(dm2[2]));
		fuzzyMatch2 := dm1[2][ ..minLength2] = dm2[2][ ..minLength2];
		minLength3 := MIN(LENGTH(dm1[1]),LENGTH(dm2[2]));
		fuzzyMatch3 := dm1[1][ ..minLength3] = dm2[2][ ..minLength3];
		minLength4 := MIN(LENGTH(dm1[2]),LENGTH(dm2[1]));
		fuzzyMatch4 := dm1[2][ ..minLength4] = dm2[1][ ..minLength4];
		fuzzyMatch := fuzzyMatch1 OR fuzzyMatch2 OR fuzzyMatch3 OR fuzzyMatch4;
		
		result := if (na, Healthcare_Shared.Constants.MatchType.MT_NA, if (exactMatch, Healthcare_Shared.Constants.MatchType.MT_EXACT, if (fuzzyMatch, Healthcare_Shared.Constants.MatchType.MT_FUZZY, Healthcare_Shared.Constants.MatchType.MT_NO_MATCH)));
		return result;
	END;


	EXPORT Healthcare_Shared.Constants.MatchType findFatFinger(STRING1 ch, STRING1 target) := FUNCTION
		na := false;
		exactMatch := ch = target;
		
		fuzzyMatch := ((ch='0' AND (target IN ['9','(','-','_'])) OR
									 (ch='1' AND (target IN ['`','~','2','@'])) OR
									 (ch='a' AND (target IN ['s','S'])) OR
									 (ch='A' AND (target IN ['s','S'])) OR
									 (ch='s' AND (target IN ['a','A','d','D'])) OR
									 (ch='S' AND (target IN ['a','A','d','D'])) OR
									 (ch='d' AND (target IN ['s','S','f','F'])) OR
									 (ch='D' AND (target IN ['s','S','f','F'])) OR
									 (ch='i' AND (target IN ['o','O'])) OR
									 (ch='I' AND (target IN ['o','O'])) OR
									 (ch='o' AND (target IN ['i','I'])) OR
									 (ch='O' AND (target IN ['i','I'])) OR
									 (ch='R' AND (target IN ['f','F'])) OR
									 (ch='F' AND (target IN ['r','R'])));
		
		result := if (na, Healthcare_Shared.Constants.MatchType.MT_NA, if (exactMatch, Healthcare_Shared.Constants.MatchType.MT_EXACT, if (fuzzyMatch, Healthcare_Shared.Constants.MatchType.MT_FUZZY, Healthcare_Shared.Constants.MatchType.MT_NA)));
		RETURN result;
	END;
	
	EXPORT unsigned1 getNumberScore(STRING astr1, STRING astr2) := FUNCTION
		STRING str1 := TRIM(astr1,LEFT,RIGHT);
		STRING str2 := TRIM(astr2,LEFT,RIGHT);
		minLength := MIN(LENGTH(str1),LENGTH(str2));
		maxLength := MAX(LENGTH(str1),LENGTH(str2));
		
		distance := Healthcare_Shared.Functions_C.getLevenshteinDistance(str1, str2);
		
		result := if(minLength=0 or distance>=minLength, 0, ((minLength - distance) * 100 ) / minLength);
		return result;
	END;
	
	EXPORT Healthcare_Shared.Layouts.MatchResult getMatchResult(STRING astr1, STRING astr2) := FUNCTION
		STRING str1 := TRIM(astr1,LEFT,RIGHT);
		STRING str2 := TRIM(astr2,LEFT,RIGHT);
		minLength := MIN(LENGTH(str1),LENGTH(str2));
		maxLength := MAX(LENGTH(str1),LENGTH(str2));
		
		ucStr1 := STD.Str.ToUpperCase(str1);
		ucStr2 := STD.Str.ToUpperCase(str2);
		
		bInitialMatch := (ucStr1[1] = ucStr2[1]) AND (((LENGTH(ucStr1) = 1) OR ((LENGTH(ucStr1) = 2) AND (ucStr1[2] = '.'))) OR ((LENGTH(ucStr2) = 1) OR ((LENGTH(ucStr2) = 2) AND (ucStr2[2] = '.'))));
		
		boolean na := str1 = '' OR str2 = '';
		boolean exactMatch := ucStr1 = ucStr2;
		
		soundexMatchResult := CompareSoundex(ucStr1, ucStr2);
		metaphoneMatchResult := CompareMetaphone(ucStr1, ucStr2);
		REAL8 oliverConfidence := Healthcare_Shared.Functions_C.getOliverConfidence(ucStr1, ucStr2);
		distance := Healthcare_Shared.Functions_C.getLevenshteinDistance(ucStr1, ucStr2);

		boolean bSoundexExact 	:= (soundexMatchResult = Healthcare_Shared.Constants.MatchType.MT_EXACT);
		boolean bMetaphoneExact := (metaphoneMatchResult = Healthcare_Shared.Constants.MatchType.MT_EXACT);
		
		soundexScore := map(	bSoundexExact AND bMetaphoneExact	=> 90,
													bSoundexExact => 80,
													soundexMatchResult = Healthcare_Shared.Constants.MatchType.MT_FUZZY => 50,
													0); // default
													
		metaphoneScore := map(bMetaphoneExact AND bSoundexExact	=> 90,
													bMetaphoneExact => 80,
													metaphoneMatchResult = Healthcare_Shared.Constants.MatchType.MT_FUZZY => 50,
													0); // default
													
		distanceScore := if ((REAL8)((maxLength - distance) / (REAL8)maxLength) > 0, (REAL8)(maxLength - distance) / (REAL8)maxLength, 0);
		
		finalScore := map(	
									exactMatch => 100, 
									((soundexScore + metaphoneScore) = 0 AND distanceScore > 0.8 AND oliverConfidence > 0.9) =>	(INTEGER4)(distanceScore * 100.0 + oliverConfidence * 100.0) / 3,
									(soundexScore + metaphoneScore + (INTEGER4)(distanceScore * 100.0) + (INTEGER4)(oliverConfidence * 100.0)) / 4 // default
									);
				
		
		boolean bStrStr := ((NOT bInitialMatch) AND (minLength > 3) AND ((STD.Str.Find(ucStr1, ucStr2) > 0) OR (STD.Str.Find(ucStr2, ucStr1) > 0)));
																					 
		mt := map (	na														=> Healthcare_Shared.Constants.MatchType.MT_NA,
								exactMatch 										=> Healthcare_Shared.Constants.MatchType.MT_EXACT,
								(finalScore > 50 or bStrStr)	=> Healthcare_Shared.Constants.MatchType.MT_FUZZY,
								Healthcare_Shared.Constants.MatchType.MT_NO_MATCH); // default
								
		fi := map (	finalScore = 100	=> Healthcare_Shared.Constants.FuzzyInfo.FI_NULL,
								finalScore > 80 	=> Healthcare_Shared.Constants.FuzzyInfo.FI_STRONG_POS_MATCH,
								finalScore > 50   => Healthcare_Shared.Constants.FuzzyInfo.FI_PARTIAL, 
								bStrStr						=> Healthcare_Shared.Constants.FuzzyInfo.FI_EXACT_STR_STR, 
								//TBD							=> Healthcare_Shared.Constants.FuzzyInfo.FI_SIMPLE_TRANSPOSITION,
								//TBD							=> Healthcare_Shared.Constants.FuzzyInfo.FI_EXACT_CORRECTED,
								Healthcare_Shared.Constants.FuzzyInfo.FI_NULL); // default
																					 
	//	cs1 := fatFingerCorrectedString(ucStr1, ucStr2);
	//	numPossibleFatFingers := getLevenshteinDistance(ucStr1, cs1);
	//	possibleFatFinger := (numPossibleFatFingers > (LENGTH(ucStr1) / 2));
	//	corSoundexMatchResult := CompareSoundex(cs1, ucStr2);
	//	corMetaphoneMatchResult := CompareMetaphone(cs1, ucStr2);
	//	corOliverConfidence := getOliverConfidence(cs1, ucStr2);
	//	corDistance := getLevenshteinDistance(cs1, str2);
	//	corSoundexScore := if (corSoundexMatchResult = Healthcare_Shared.Constants.MatchType.MT_EXACT, if (corMetaphoneMatchResult = Healthcare_Shared.Constants.MatchType.MT_EXACT, 90, 80), 0);
	//	corMetaphoneScore := if (corMetaphoneMatchResult = Healthcare_Shared.Constants.MatchType.MT_EXACT, if (corSoundexMatchResult = Healthcare_Shared.Constants.MatchType.MT_EXACT, 90, 80), 0);
	//	corDistanceScore := if ((REAL8)(minLength - corDistance) / (REAL8)minLength > 0, (REAL8)(minLength - corDistance) / (REAL8)minLength, 0);
	//	corFinalScore := ((corSoundexScore + corMetaphoneScore + corDistanceScore * 100.0 + corOliverConfidence * 100.0) / 4);
	//	realFinalScore := MAX(finalScore,corFinalScore);
	
		Healthcare_Shared.Layouts.MatchResult createRow := TRANSFORM
			SELF.s1											:= astr1;
			SELF.s2											:= astr2;
			SELF.score									:= finalScore;
			SELF.match_type							:= mt;
			SELF.fuzzy_info							:= fi;
			SELF.b_initial_match				:= bInitialMatch;
			//SELF.numPossibleFatFingers	:= 0;
			//SELF.extendedInfo 					:= 0;
		end;
		return row(createRow);
	END;
	
	
	EXPORT Healthcare_shared.Layouts.MatchStat getMatchStat(STRING astr1, STRING astr2) := FUNCTION
		match_result := getMatchResult(astr1, astr2);
		
		Healthcare_shared.Layouts.MatchStat createRow := TRANSFORM
			SELF.score									:= match_result.score;
			SELF.matchType							:= match_result.match_type;
			SELF.fuzzyInfo							:= match_result.fuzzy_info;
			SELF.numPossibleFatFingers	:= 0;
			SELF.extendedInfo 					:= 0;
		end;
		
		return row(createRow);
	END;
	
	EXPORT Healthcare_Shared.Layouts.NameScoreResult NameScoreMatch
												(STRING n1_pre_name='',STRING n1_first_name='',STRING n1_middle_name='',STRING n1_last_name='',
												 STRING n1_maturity_suffix='',STRING n1_preferred_name='',INTEGER1 n1_gender=-1,
												 STRING n2_pre_name='',STRING n2_first_name='',STRING n2_middle_name='',STRING n2_last_name='',
												 STRING n2_maturity_suffix='',STRING n2_preferred_name='',INTEGER1 n2_gender=-1):= FUNCTION
		thisFirstNameTokens   := STD.Str.SplitWords(n1_first_name,' ');
		thisMiddleNameTokens  := STD.Str.SplitWords(n1_middle_name,' ');
		thisLastNameTokens    := STD.Str.SplitWords(n1_last_name,' ');
		otherFirstNameTokens  := STD.Str.SplitWords(n2_first_name,' ');
		otherMiddleNameTokens := STD.Str.SplitWords(n2_middle_name,' ');
		otherLastNameTokens   := STD.Str.SplitWords(n2_last_name,' ');
		
		bMultipleTokensInThisFirstName   := COUNT(thisFirstNameTokens) > 1;
		bMultipleTokensInThisMiddleName  := COUNT(thisMiddleNameTokens) > 1;
		bMultipleTokensInThisLastName    := COUNT(thisLastNameTokens) > 1;
		bMultipleTokensInOtherFirstName  := COUNT(otherFirstNameTokens) > 1;
		bMultipleTokensInOtherMiddleName := COUNT(otherMiddleNameTokens) > 1;
		bMultipleTokensInOtherLastName   := COUNT(otherLastNameTokens) > 1;
		
		bMultipleTokensSomewhere := bMultipleTokensInThisFirstName OR bMultipleTokensInThisMiddleName OR bMultipleTokensInThisLastName OR bMultipleTokensInOtherFirstName OR bMultipleTokensInOtherMiddleName OR bMultipleTokensInOtherLastName;
		//OUTPUT(bMultipleTokensSomewhere);
		thisFullName  := n1_first_name  + ' ' + n1_middle_name  + ' ' + n1_last_name;
		otherFullName := n2_first_name + ' ' + n2_middle_name + ' ' + n2_last_name;
		
		thisFullNameTokens   := STD.Str.SplitWords(thisFullName,' ');
		otherFullNameTokens  := STD.Str.SplitWords(otherFullName,' ');
		
		tokenDifference := ABS(COUNT(otherFullNameTokens) - COUNT(thisFullNameTokens));
		minTokens := MIN(COUNT(otherFullNameTokens),COUNT(thisFullNameTokens));
		maxTokens := MAX(COUNT(otherFullNameTokens),COUNT(thisFullNameTokens));
		
		bNameRearrangementMatch1 := Healthcare_Shared.Functions_C.CompareTokens100(thisFullName,otherFullName) AND Healthcare_Shared.Functions_C.CompareTokens100(otherFullName,thisFullName);
		bNameRearrangementMatch := bNameRearrangementMatch1 AND (tokenDifference=0);
		bNameRearrangementFuzzyMatch1 := Healthcare_Shared.Functions_C.CompareTokens100(thisFullName,otherFullName) OR Healthcare_Shared.Functions_C.CompareTokens100(otherFullName,thisFullName);
		bNameRearrangementFuzzyMatch := bNameRearrangementFuzzyMatch1 AND (maxTokens>=3) AND (minTokens>=2) AND (tokenDifference=1);
		
		names := DATASET([{n1_first_name,n2_first_name},
											{n1_first_name,n2_middle_name},
											{n1_first_name,n2_last_name},
											{n1_middle_name,n2_first_name},
											{n1_middle_name,n2_middle_name},
											{n1_middle_name,n2_last_name},
											{n1_last_name,n2_first_name},
											{n1_last_name,n2_middle_name},
											{n1_last_name,n2_last_name}],
											{STRING name1,STRING name2});


		ds := PROJECT(names, TRANSFORM(Healthcare_Shared.Layouts.MatchResult,
														self := getMatchResult(LEFT.name1, LEFT.name2)));
																											
		// 1 - first to first
		// 2 - first to middle
		// 3 - first to last
		// 4 - middle to first
		// 5 - middle to middle
		// 6 - middle to last
		// 7 - last to first
		// 8 - last to middle
		// 9 - last to last
		
		// first name
		firstMatch := if (ds[1].match_type=Healthcare_Shared.Constants.MatchType.MT_EXACT,
										if (ds[1].b_initial_match, 2, 1),  // 1, 2
											if (ds[2].match_type=Healthcare_Shared.Constants.MatchType.MT_EXACT AND
													((ds[4].match_type&(Healthcare_Shared.Constants.MatchType.MT_EXACT|Healthcare_Shared.Constants.MatchType.MT_NA) > 0) OR
													 (ds[6].match_type&(Healthcare_Shared.Constants.MatchType.MT_EXACT|Healthcare_Shared.Constants.MatchType.MT_NA) > 0) OR
													 (ds[7].match_type&(Healthcare_Shared.Constants.MatchType.MT_EXACT|Healthcare_Shared.Constants.MatchType.MT_NA) > 0) OR
													 (ds[9].match_type&(Healthcare_Shared.Constants.MatchType.MT_EXACT|Healthcare_Shared.Constants.MatchType.MT_NA) > 0)), 3,  // 3
												if (ds[3].match_type=Healthcare_Shared.Constants.MatchType.MT_EXACT AND
														((ds[4].match_type&(Healthcare_Shared.Constants.MatchType.MT_EXACT|Healthcare_Shared.Constants.MatchType.MT_NA) > 0) OR
														 (ds[5].match_type&(Healthcare_Shared.Constants.MatchType.MT_EXACT|Healthcare_Shared.Constants.MatchType.MT_NA) > 0) OR
														 (ds[7].match_type&(Healthcare_Shared.Constants.MatchType.MT_EXACT|Healthcare_Shared.Constants.MatchType.MT_NA) > 0) OR
														 (ds[8].match_type&(Healthcare_Shared.Constants.MatchType.MT_EXACT|Healthcare_Shared.Constants.MatchType.MT_NA) > 0)), 4,  // 4
													if (LENGTH(TRIM(n1_preferred_name,LEFT,RIGHT))>0 AND
															LENGTH(TRIM(n2_preferred_name,LEFT,RIGHT))>0 AND
															TRIM(n1_preferred_name,LEFT,RIGHT)=TRIM(n2_preferred_name,LEFT,RIGHT), 5,  // 5
														if (ds[1].match_type=Healthcare_Shared.Constants.MatchType.MT_FUZZY, 6,  // 6
															if (ds[1].b_initial_match, 7,  // 7
																if (ds[1].match_type=Healthcare_Shared.Constants.MatchType.MT_NA,
																	if ((ds[2].match_type=Healthcare_Shared.Constants.MatchType.MT_EXACT OR
																			 ds[2].b_initial_match OR
																			 ds[3].match_type=Healthcare_Shared.Constants.MatchType.MT_EXACT OR
																			 ds[3].b_initial_match), 8,  // 8
																		if (ds[2].fuzzy_info=Healthcare_Shared.Constants.FuzzyInfo.FI_EXACT_STR_STR, 9,  // 9
																			if (ds[3].fuzzy_info=Healthcare_Shared.Constants.FuzzyInfo.FI_EXACT_STR_STR, 10, 0))), // 10													  
																	if (ds[2].match_type=Healthcare_Shared.Constants.MatchType.MT_EXACT OR
																			ds[2].b_initial_match OR
																			ds[3].match_type=Healthcare_Shared.Constants.MatchType.MT_EXACT OR
																			ds[3].b_initial_match, 11,  // 11
																		if (ds[2].fuzzy_info=Healthcare_Shared.Constants.FuzzyInfo.FI_EXACT_STR_STR OR
																				ds[3].fuzzy_info=Healthcare_Shared.Constants.FuzzyInfo.FI_EXACT_STR_STR, 12, 0)))))))));  // 12

		bFirstExtendedMatchInfo := case (firstMatch,
																	1  => Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_MATCH,
																	2  => Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_MATCH|
																				Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_INITIAL_MATCH,
																	3  => Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_MATCH|
																				Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_MIDDLE_TRANSPOSED|
																				Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED,
																	4  => Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_MATCH|
																				Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_LAST_TRANSPOSED|
																				Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED,
																	5  => Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.PREFERRED_NAME_MATCH,
																	6  => Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_FUZZY,
																	7  => Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_INITIAL_MATCH,
																	8  => 0,
																	9  => Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_FUZZY|
																				Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_MIDDLE_TRANSPOSED|
																				Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED,
																	10 => Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_FUZZY|
																				Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_LAST_TRANSPOSED|
																				Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED,
																	11 => Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_CONFLICT,
																	12 => Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_CONFLICT,
																				0);

		// first name
		middleMatch := if (ds[5].match_type=Healthcare_Shared.Constants.MatchType.MT_EXACT,
										 if (ds[5].b_initial_match, 2, 1),  // 1, 2
											 if (ds[4].match_type=Healthcare_Shared.Constants.MatchType.MT_EXACT AND
													 ((ds[2].match_type&(Healthcare_Shared.Constants.MatchType.MT_EXACT|Healthcare_Shared.Constants.MatchType.MT_NA) > 0) OR
														(ds[3].match_type&(Healthcare_Shared.Constants.MatchType.MT_EXACT|Healthcare_Shared.Constants.MatchType.MT_NA) > 0) OR
														(ds[8].match_type&(Healthcare_Shared.Constants.MatchType.MT_EXACT|Healthcare_Shared.Constants.MatchType.MT_NA) > 0) OR
														(ds[9].match_type&(Healthcare_Shared.Constants.MatchType.MT_EXACT|Healthcare_Shared.Constants.MatchType.MT_NA) > 0)), 3,  // 3
												 if (ds[6].match_type=Healthcare_Shared.Constants.MatchType.MT_EXACT AND
														 ((ds[1].match_type&(Healthcare_Shared.Constants.MatchType.MT_EXACT|Healthcare_Shared.Constants.MatchType.MT_NA) > 0) OR
															(ds[2].match_type&(Healthcare_Shared.Constants.MatchType.MT_EXACT|Healthcare_Shared.Constants.MatchType.MT_NA) > 0) OR
															(ds[7].match_type&(Healthcare_Shared.Constants.MatchType.MT_EXACT|Healthcare_Shared.Constants.MatchType.MT_NA) > 0) OR
															(ds[8].match_type&(Healthcare_Shared.Constants.MatchType.MT_EXACT|Healthcare_Shared.Constants.MatchType.MT_NA) > 0)), 4,  // 4
													 if (ds[5].match_type=Healthcare_Shared.Constants.MatchType.MT_FUZZY, 5,  // 5
														 if (ds[5].b_initial_match, 6,  // 6
															 if (ds[5].match_type=Healthcare_Shared.Constants.MatchType.MT_NA,
																 if (ds[4].b_initial_match AND
																		 ds[1].match_type!=Healthcare_Shared.Constants.MatchType.MT_EXACT AND
																		 ds[7].match_type!=Healthcare_Shared.Constants.MatchType.MT_EXACT, 7,  // 7
																	 if (ds[4].match_type=Healthcare_Shared.Constants.MatchType.MT_FUZZY AND
																			 ds[1].match_type!=Healthcare_Shared.Constants.MatchType.MT_EXACT AND
																			 ds[7].match_type!=Healthcare_Shared.Constants.MatchType.MT_EXACT, 8,  // 8
																		 if (ds[6].b_initial_match AND
																				 ds[9].match_type!=Healthcare_Shared.Constants.MatchType.MT_EXACT AND
																				 ds[3].match_type!=Healthcare_Shared.Constants.MatchType.MT_EXACT, 9,  // 9
																			 if (ds[6].match_type=Healthcare_Shared.Constants.MatchType.MT_FUZZY AND
																					 ds[9].match_type!=Healthcare_Shared.Constants.MatchType.MT_EXACT AND
																					 ds[3].match_type!=Healthcare_Shared.Constants.MatchType.MT_EXACT, 10, 0)))), // 10
																 if (ds[4].match_type=Healthcare_Shared.Constants.MatchType.MT_EXACT OR
																		 ds[4].b_initial_match OR
																		 ds[6].match_type=Healthcare_Shared.Constants.MatchType.MT_EXACT OR
																		 ds[6].b_initial_match, 11,  // 11
																	 if (ds[4].fuzzy_info=Healthcare_Shared.Constants.FuzzyInfo.FI_EXACT_STR_STR OR
																			 ds[6].fuzzy_info=Healthcare_Shared.Constants.FuzzyInfo.FI_EXACT_STR_STR, 12, 0))))))));  // 12

		bMiddleExtendedMatchInfo := case (middleMatch,
																	1  => Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_MATCH,
																	2  => Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_MATCH|
																				Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_INITIAL_MATCH,
																	3  => Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_MATCH|
																				Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_FIRST_TRANSPOSED|
																				Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED,
																	4  => Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_MATCH|
																				Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_FIRST_TRANSPOSED|
																				Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED,
																	5  => Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_FUZZY,
																	6  => Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_INITIAL_MATCH,
																	7  => Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_FUZZY|
																				Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_FIRST_TRANSPOSED|
																				Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED,
																	8  => Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_FUZZY|
																				Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_FIRST_TRANSPOSED|
																				Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED,
																	9  => Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_FUZZY|
																				Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_LAST_TRANSPOSED|
																				Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED,
																	10 => Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_FUZZY|
																				Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_LAST_TRANSPOSED|
																				Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED,
																	11 => Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_CONFLICT,
																	12 => Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_CONFLICT,
																				0);
		
		// last name
		lastMatch := if (ds[9].match_type=Healthcare_Shared.Constants.MatchType.MT_EXACT,
										if (ds[9].b_initial_match, 2, 1),  // 1, 2
											if (ds[8].match_type=Healthcare_Shared.Constants.MatchType.MT_EXACT AND
													((ds[1].match_type&(Healthcare_Shared.Constants.MatchType.MT_EXACT|Healthcare_Shared.Constants.MatchType.MT_NA) > 0) OR
													 (ds[3].match_type&(Healthcare_Shared.Constants.MatchType.MT_EXACT|Healthcare_Shared.Constants.MatchType.MT_NA) > 0) OR
													 (ds[4].match_type&(Healthcare_Shared.Constants.MatchType.MT_EXACT|Healthcare_Shared.Constants.MatchType.MT_NA) > 0) OR
													 (ds[6].match_type&(Healthcare_Shared.Constants.MatchType.MT_EXACT|Healthcare_Shared.Constants.MatchType.MT_NA) > 0)), 3,  // 3
												if (ds[7].match_type=Healthcare_Shared.Constants.MatchType.MT_EXACT AND
														((ds[2].match_type&(Healthcare_Shared.Constants.MatchType.MT_EXACT|Healthcare_Shared.Constants.MatchType.MT_NA) > 0) OR
														 (ds[3].match_type&(Healthcare_Shared.Constants.MatchType.MT_EXACT|Healthcare_Shared.Constants.MatchType.MT_NA) > 0) OR
														 (ds[5].match_type&(Healthcare_Shared.Constants.MatchType.MT_EXACT|Healthcare_Shared.Constants.MatchType.MT_NA) > 0) OR
														 (ds[6].match_type&(Healthcare_Shared.Constants.MatchType.MT_EXACT|Healthcare_Shared.Constants.MatchType.MT_NA) > 0)), 4,  // 4
													if (ds[9].match_type=Healthcare_Shared.Constants.MatchType.MT_FUZZY, 5,  // 5
														if (ds[9].match_type=Healthcare_Shared.Constants.MatchType.MT_NA,
															if (ds[8].match_type=Healthcare_Shared.Constants.MatchType.MT_EXACT OR
																	ds[8].b_initial_match OR
																	ds[7].match_type=Healthcare_Shared.Constants.MatchType.MT_EXACT OR
																	ds[7].b_initial_match, 6,  // 6
																if (ds[8].fuzzy_info=Healthcare_Shared.Constants.FuzzyInfo.FI_EXACT_STR_STR, 7,  // 7
																	if (ds[7].fuzzy_info=Healthcare_Shared.Constants.FuzzyInfo.FI_EXACT_STR_STR, 8, 0))), // 8													  
															if (ds[8].match_type=Healthcare_Shared.Constants.MatchType.MT_EXACT OR
																	ds[8].b_initial_match OR
																	ds[7].match_type=Healthcare_Shared.Constants.MatchType.MT_EXACT OR
																	ds[7].b_initial_match, 9,  // 9
																if (ds[8].fuzzy_info=Healthcare_Shared.Constants.FuzzyInfo.FI_EXACT_STR_STR OR
																		ds[7].fuzzy_info=Healthcare_Shared.Constants.FuzzyInfo.FI_EXACT_STR_STR, 10, 0)))))));  // 10

		bLastExtendedMatchInfo := case (lastMatch,
																	1  => Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_MATCH,
																	2  => Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_MATCH|
																				Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_INITIAL_MATCH,
																	3  => Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_MATCH|
																				Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_MIDDLE_TRANSPOSED|
																				Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED,
																	4  => Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_MATCH|
																				Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_FIRST_TRANSPOSED|
																				Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED,
																	5  => Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_FUZZY,
																	6  => 0,
																	7  => Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_FUZZY|
																				Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_MIDDLE_TRANSPOSED|
																				Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED,
																	8  => Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_FUZZY|
																				Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_FIRST_TRANSPOSED|
																				Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED,
																	9  => Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_CONFLICT,
																	10 => Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_CONFLICT,
																				0);
																				
																					
		bFirstTaken1 := firstMatch IN [1,2,5,6,7] OR middleMatch IN [3,5,6] OR lastMatch IN [4];																	
		bMiddleTaken1 := firstMatch IN [3] OR middleMatch IN [1,2] OR lastMatch IN [3];
		bLastTaken1 := firstMatch IN [4] OR middleMatch IN [4] OR lastMatch IN [1,2,5];
		
		// suspect transposition
		suspectTransposition := if (bMultipleTokensSomewhere, 1, 0) +
														if (firstMatch=3, 1, 0) +
														if (firstMatch=4, 1, 0) +
														if (firstMatch=8, 1, 0) +
														if (firstMatch=11, 1, 0) +
														if (middleMatch=3, 1, 0) +
														if (middleMatch=4, 1, 0) +
														if (middleMatch=7, 1, 0) +
														if (middleMatch=9, 1, 0) +
														if (middleMatch=11, 1, 0) +
														if (lastMatch=3, 1, 0) +
														if (lastMatch=4, 1, 0) +
														if (lastMatch=6, 1, 0) +
														if (lastMatch=9, 1, 0);
														
		// suspect aggregation
		suspectAggregation := if (firstMatch=9, 1, 0) +
													if (firstMatch=10, 1, 0) +
													if (firstMatch=12, 1, 0) +
													if (middleMatch=8, 1, 0) +
													if (middleMatch=10, 1, 0) +
													if (middleMatch=12, 1, 0) +
													if (lastMatch=7, 1, 0) +
													if (lastMatch=8, 1, 0) +
													if (lastMatch=10, 1, 0);

		// extended match info
		bExtendedMatchInfo1 := bFirstExtendedMatchInfo|bMiddleExtendedMatchInfo|bLastExtendedMatchInfo;
		
		// process transpositions
		suspectTranspositionFirstName := if ((suspectTransposition > 1) AND ((bExtendedMatchInfo1&Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_CONFLICT) > 0),
																			 if (NOT bMiddleTaken1 AND ds[2].match_type=Healthcare_Shared.Constants.MatchType.MT_EXACT, 1,
																				 if (NOT bLastTaken1 AND ds[3].match_type=Healthcare_Shared.Constants.MatchType.MT_EXACT, 2,
																					 if (NOT bMiddleTaken1 AND ds[2].match_type=Healthcare_Shared.Constants.MatchType.MT_FUZZY, 3,
																						 if (NOT bLastTaken1 AND ds[3].match_type=Healthcare_Shared.Constants.MatchType.MT_FUZZY, 4,
																							 if (NOT bMiddleTaken1 AND ds[2].b_initial_match, 5,
																								 if (NOT bLastTaken1 AND ds[3].b_initial_match, 6, 0)))))),0);

		bMiddleTaken2 := if (suspectTranspositionFirstName IN [1,3,5], true, false);
		bLastTaken2 := if (suspectTranspositionFirstName IN [2,4,6], true, false);
		bExtendedMatchInfo2 := case (suspectTranspositionFirstName,
																	1 => bExtendedMatchInfo1|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_MATCH|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_MIDDLE_TRANSPOSED|
																			 if (ds[2].b_initial_match,Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_INITIAL_MATCH,0)^
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_CONFLICT,
																	2 => bExtendedMatchInfo1|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_MATCH|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_LAST_TRANSPOSED|
																			 if (ds[3].b_initial_match,Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_INITIAL_MATCH,0)^
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_CONFLICT,
																	3 => bExtendedMatchInfo1|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_FUZZY|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_MIDDLE_TRANSPOSED^
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_CONFLICT,
																	4 => bExtendedMatchInfo1|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_FUZZY|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_LAST_TRANSPOSED^
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_CONFLICT,
																	5 => bExtendedMatchInfo1|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_INITIAL_MATCH|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_MIDDLE_TRANSPOSED^
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_CONFLICT,
																	6 => bExtendedMatchInfo1|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_INITIAL_MATCH|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_LAST_TRANSPOSED^
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_CONFLICT,
																			 bExtendedMatchInfo1);

		suspectTranspositionLastName := if ((suspectTransposition > 1) AND ((bExtendedMatchInfo1&Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_CONFLICT) > 0),
																			if (NOT bFirstTaken1 AND ds[7].match_type=Healthcare_Shared.Constants.MatchType.MT_EXACT, 1,
																				if (NOT bMiddleTaken2 AND ds[8].match_type=Healthcare_Shared.Constants.MatchType.MT_EXACT, 2,
																					if (NOT bFirstTaken1 AND ds[7].match_type=Healthcare_Shared.Constants.MatchType.MT_FUZZY, 3,
																						if (NOT bMiddleTaken2 AND ds[8].match_type=Healthcare_Shared.Constants.MatchType.MT_FUZZY, 4,
																							if (NOT bFirstTaken1 AND ds[7].b_initial_match, 5,
																								if (NOT bMiddleTaken2 AND ds[8].b_initial_match, 6, 0)))))),0);
																								
		bFirstTaken2 := if (suspectTranspositionLastName IN [1,3,5], true, false);
		bMiddleTaken3 := if (suspectTranspositionLastName IN [2,4,6], true, false);
		bExtendedMatchInfo3 := case (suspectTranspositionLastName,
																	1 => bExtendedMatchInfo2|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_MATCH|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_FIRST_TRANSPOSED|
																			 if (ds[7].b_initial_match,Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_INITIAL_MATCH,0)^
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_CONFLICT,
																	2 => bExtendedMatchInfo2|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_MATCH|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_MIDDLE_TRANSPOSED|
																			 if (ds[8].b_initial_match,Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_INITIAL_MATCH,0)^
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_CONFLICT,
																	3 => bExtendedMatchInfo2|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_FUZZY|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_FIRST_TRANSPOSED^
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_CONFLICT,
																	4 => bExtendedMatchInfo2|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_FUZZY|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_MIDDLE_TRANSPOSED^
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_CONFLICT,
																	5 => bExtendedMatchInfo2|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_INITIAL_MATCH|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_FIRST_TRANSPOSED^
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_CONFLICT,
																	6 => bExtendedMatchInfo2|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_INITIAL_MATCH|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_MIDDLE_TRANSPOSED^
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_CONFLICT,
																			 bExtendedMatchInfo2);
																							
		suspectTranspositionMiddleName := if ((suspectTransposition > 1) AND ((bExtendedMatchInfo1&Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_CONFLICT) > 0),
																				if (NOT bFirstTaken2 AND ds[4].match_type=Healthcare_Shared.Constants.MatchType.MT_EXACT, 1,
																					if (NOT bLastTaken2 AND ds[6].match_type=Healthcare_Shared.Constants.MatchType.MT_EXACT, 2,
																						if (NOT bFirstTaken2 AND ds[4].match_type=Healthcare_Shared.Constants.MatchType.MT_FUZZY, 3,
																							if (NOT bLastTaken2 AND ds[6].match_type=Healthcare_Shared.Constants.MatchType.MT_FUZZY, 4,
																								if (NOT bFirstTaken2 AND ds[4].b_initial_match, 5,
																									if (NOT bLastTaken2 AND ds[6].b_initial_match, 6, 0)))))),0);

		bFirstTaken3 := if (suspectTranspositionMiddleName IN [1,3,5], true, false);
		bLastTaken3 := if (suspectTranspositionMiddleName IN [2,4,6], true, false);
		bExtendedMatchInfo4 := case (suspectTranspositionMiddleName,
																	1 => bExtendedMatchInfo3|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_MATCH|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_FIRST_TRANSPOSED|
																			 if (ds[4].b_initial_match,Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_INITIAL_MATCH,0)^
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_CONFLICT,
																	2 => bExtendedMatchInfo3|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_MATCH|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_LAST_TRANSPOSED|
																			 if (ds[6].b_initial_match,Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_INITIAL_MATCH,0)^
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_CONFLICT,
																	3 => bExtendedMatchInfo3|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_FUZZY|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_FIRST_TRANSPOSED^
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_CONFLICT,
																	4 => bExtendedMatchInfo3|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_FUZZY|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_LAST_TRANSPOSED^
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_CONFLICT,
																	5 => bExtendedMatchInfo3|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_INITIAL_MATCH|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_FIRST_TRANSPOSED^
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_CONFLICT,
																	6 => bExtendedMatchInfo3|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_INITIAL_MATCH|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_LAST_TRANSPOSED^
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_CONFLICT,
																			 bExtendedMatchInfo3);

		// process aggregations
		suspectAggregationFirstName := if (suspectAggregation > 1,
																		 if ((bExtendedMatchInfo1&Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_CONFLICT) > 0,
																			 if (ds[2].fuzzy_info=Healthcare_Shared.Constants.FuzzyInfo.FI_EXACT_STR_STR, 1,
																				 if (ds[3].fuzzy_info=Healthcare_Shared.Constants.FuzzyInfo.FI_EXACT_STR_STR, 2, 0)),0),0);
																		
		suspectAggregationMiddleName := if (suspectAggregation > 1,
																			if ((bExtendedMatchInfo1&Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_CONFLICT) > 0,
																				if (ds[4].fuzzy_info=Healthcare_Shared.Constants.FuzzyInfo.FI_EXACT_STR_STR, 1,
																					if (ds[6].fuzzy_info=Healthcare_Shared.Constants.FuzzyInfo.FI_EXACT_STR_STR, 2, 0)),0),0);

		suspectAggregationLastName := if (suspectAggregation > 1,
																		if ((bExtendedMatchInfo1&Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_CONFLICT) > 0,
																			if (ds[2].fuzzy_info=Healthcare_Shared.Constants.FuzzyInfo.FI_EXACT_STR_STR, 1,
																				if (ds[3].fuzzy_info=Healthcare_Shared.Constants.FuzzyInfo.FI_EXACT_STR_STR, 2, 0)),0),0);

		bExtendedMatchInfo5 := case (suspectAggregationFirstName,
																	1 => bExtendedMatchInfo4|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_FUZZY|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_MIDDLE_TRANSPOSED^
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_CONFLICT,
																	2 => bExtendedMatchInfo4|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_FUZZY|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_LAST_TRANSPOSED^
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_CONFLICT,
																			 bExtendedMatchInfo4);

		bExtendedMatchInfo6 := case (suspectAggregationMiddleName,
																	1 => bExtendedMatchInfo5|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_FUZZY|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_FIRST_TRANSPOSED^
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_CONFLICT,
																	2 => bExtendedMatchInfo5|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_FUZZY|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_LAST_TRANSPOSED^
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_CONFLICT,
																			 bExtendedMatchInfo5);
																			 
		bExtendedMatchInfo7 := case (suspectAggregationLastName,
																	1 => bExtendedMatchInfo6|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_FUZZY|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_FIRST_TRANSPOSED^
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_CONFLICT,
																	2 => bExtendedMatchInfo6|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_FUZZY|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED|
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_MIDDLE_TRANSPOSED^
																			 Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_CONFLICT,
																			 bExtendedMatchInfo6);

		bExtendedMatchInfo8 := if (suspectTransposition=0 AND n1_gender!=0 AND n2_gender!=0 AND ((n1_gender<3 AND n2_gender>3) OR (n1_gender>3 AND n2_gender<3)), 
																bExtendedMatchInfo7|Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.GENDER_CONFLICT,bExtendedMatchInfo7);
																
		bProbablyFemale := (n1_gender>3 OR n2_gender>3);
		
		bExtendedMatchInfo9 := if (bExtendedMatchInfo8&Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_CONFLICT>0 AND bProbablyFemale AND bExtendedMatchInfo8&Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_CONFLICT=0,
															 bExtendedMatchInfo8|Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FEMALE_WITH_LAST_NAME_CONFLICT,
															 bExtendedMatchInfo8);

		bExtendedMatchInfo10 := if (n1_maturity_suffix!='' AND n2_maturity_suffix!='', 
																if (n1_maturity_suffix!=n2_maturity_suffix,
																		bExtendedMatchInfo9|Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MATURITY_SUFFIX_CONFLICT,
																		bExtendedMatchInfo9),
																if (n1_maturity_suffix!='' OR n2_maturity_suffix!='',
																		bExtendedMatchInfo9|Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MATURITY_SUFFIX_AMBIGUOUS,
																		bExtendedMatchInfo9));

		// first name score
		firstNameMax := 33.3;
		firstNameScore := if (bExtendedMatchInfo10&Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_MATCH>0,
												if (bExtendedMatchInfo10&Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_INITIAL_MATCH>0, firstNameMax * 0.5, firstNameMax),
												if (bExtendedMatchInfo10&Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.PREFERRED_NAME_MATCH>0, firstNameMax * 0.8,
													if (bExtendedMatchInfo10&Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_INITIAL_MATCH>0, firstNameMax * 0.3,
														if (bExtendedMatchInfo10&Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_FUZZY>0, firstNameMax * 0.3, 0))));
		firstNameScore2 := if (bExtendedMatchInfo10&(Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_MIDDLE_TRANSPOSED|Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_LAST_TRANSPOSED)>0,
												 if (bExtendedMatchInfo10&Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_INITIAL_MATCH>0, 0, firstNameScore * 0.7),
												 firstNameScore);

		// middle name score
		middleNameMax := 33.3;
		middleNameScore := if (bExtendedMatchInfo10&Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_MATCH>0,
												 if (bExtendedMatchInfo10&Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_INITIAL_MATCH>0, middleNameMax * 0.3, middleNameMax),
												 if (bExtendedMatchInfo10&Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_INITIAL_MATCH>0, middleNameMax * 0.3,
													 if (bExtendedMatchInfo10&Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_FUZZY>0, middleNameMax * 0.3, 0)));
		middleNameScore2 := if (bExtendedMatchInfo10&(Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_FIRST_TRANSPOSED|Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_LAST_TRANSPOSED)>0,
													if (bExtendedMatchInfo10&Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_INITIAL_MATCH>0, 0, middleNameScore * 0.7),
													middleNameScore);

		// last name score
		lastNameMax := 33.3;
		lastNameScore := if (bExtendedMatchInfo10&Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_MATCH>0,
											 if (bExtendedMatchInfo10&Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_INITIAL_MATCH>0, lastNameMax * 0.5, lastNameMax),
											 if (bExtendedMatchInfo10&Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_INITIAL_MATCH>0, lastNameMax * 0.3,
												 if (bExtendedMatchInfo10&Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_FUZZY>0, lastNameMax * 0.3, 0)));
		lastNameScore2 := if (bExtendedMatchInfo10&(Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_FIRST_TRANSPOSED|Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_MIDDLE_TRANSPOSED)>0,
												if (bExtendedMatchInfo10&Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_INITIAL_MATCH>0, 0, lastNameScore *0.7),
												lastNameScore);
												
		firstNameScore3 := if (bExtendedMatchInfo10&Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_CONFLICT>0, firstNameScore2 - firstNameMax, firstNameScore2);
		middleNameScore3 := if (bExtendedMatchInfo10&Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_CONFLICT>0, middleNameScore2 - middleNameMax, middleNameScore2);
		lastNameScore3 := if (bExtendedMatchInfo10&Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_CONFLICT>0, lastNameScore2 - lastNameMax, lastNameScore2);
		
		nConflicts := if (bExtendedMatchInfo10&Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_CONFLICT>0, 1, 0) + if (bExtendedMatchInfo10&Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_CONFLICT>0, 1, 0) + if (bExtendedMatchInfo10&Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_CONFLICT>0, 1, 0);
		nElementsMissing := if (firstNameScore2=0.0, 1, 0) + if (middleNameScore2=0.0, 1, 0) + if (lastNameScore2=0.0, 1, 0);
		nExactMatches :=  if (firstNameScore2=firstNameMax, 1, 0) + if (middleNameScore2=middleNameMax, 1, 0) + if (lastNameScore2=lastNameMax, 1, 0);
		nAnyMatches :=  if (firstNameScore2>0, 1, 0) + if (middleNameScore2>0, 1, 0) + if (lastNameScore2>0, 1, 0);
		
		// Compute a final modifier for the score.
		finalModifier := if (nConflicts=0,
											 if (nElementsMissing=1,
												 if (nExactMatches=2, firstNameMax * 0.1,
													 if (nExactMatches=1, firstNameMax * 0.05, 0)), 0),
											 if (suspectTransposition>0 AND bExtendedMatchInfo10&Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED>0 AND nConflicts=1 AND nExactMatches>0 AND
													 bExtendedMatchInfo10&Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_CONFLICT>0 AND ds[3].match_type&Healthcare_Shared.Constants.MatchType.MT_EXACT>0 AND
													 ds[3].b_initial_match, 0, 33.3));

		nameScore := MAX(0, firstNameScore3 + middleNameScore3 + lastNameScore3 + finalModifier);
		
		matchStat := if (nameScore=0, Healthcare_Shared.Constants.MatchType.MT_NO_MATCH,
									 if (nameScore=100, Healthcare_Shared.Constants.MatchType.MT_EXACT, Healthcare_Shared.Constants.MatchType.MT_FUZZY));
									 
		// set rearrangement bits
		bExtendedMatchInfo11 := bExtendedMatchInfo10 |
														if (bNameRearrangementMatch, Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.NAME_REARRANGEMENT_MATCH,0) |
														if (bNameRearrangementFuzzyMatch, Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.NAME_REARRANGEMENT_FUZZY_MATCH,0);
		
		return row({nameScore,matchStat,bExtendedMatchInfo11},Healthcare_Shared.Layouts.NameScoreResult);
		
	END;
	

	
	EXPORT INTEGER1 GetNameStrength(INTEGER4 extendedNameInfo) := FUNCTION
		missingFirst := if ((extendedNameInfo & Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_CONFLICT)=0 AND
												(extendedNameInfo & Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_MATCH)=0 AND
												(extendedNameInfo & Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_FUZZY)=0 AND
												(extendedNameInfo & Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_INITIAL_MATCH)=0 AND
												(extendedNameInfo & Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.PREFERRED_NAME_MATCH)=0, 1, 0);
		missingMiddle := if ((extendedNameInfo & Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_CONFLICT)=0 AND
												 (extendedNameInfo & Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_MATCH)=0 AND
												 (extendedNameInfo & Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_INITIAL_MATCH)=0, 1, 0);
		missingLast := if ((extendedNameInfo & Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_CONFLICT)=0 AND
											 (extendedNameInfo & Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_MATCH)=0 AND
											 (extendedNameInfo & Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_FUZZY)=0 AND
											 (extendedNameInfo & Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_INITIAL_MATCH)=0, 1, 0);
		nMissing := missingFirst + missingMiddle + missingLast;
		
		conflictFirst := if ((extendedNameInfo & Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_CONFLICT)>0, 1, 0);
		conflictMiddle := if ((extendedNameInfo & Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_CONFLICT)>0, 1, 0);
		conflictLast := if ((extendedNameInfo & Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_CONFLICT)>0, 1, 0);
		nConflicts := conflictFirst + conflictMiddle + conflictLast;
		
		exactFirst := if ((extendedNameInfo & Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_MATCH)>0 AND
											(extendedNameInfo & Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.FIRST_NAME_INITIAL_MATCH)=0, 1, 0);
		exactMiddle := if ((extendedNameInfo & Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_MATCH)>0 AND
											 (extendedNameInfo & Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.MIDDLE_NAME_INITIAL_MATCH)=0, 1, 0);
		exactLast := if ((extendedNameInfo & Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_MATCH)>0 AND
										 (extendedNameInfo & Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.LAST_NAME_INITIAL_MATCH)=0, 1, 0);
		nExact := exactFirst + exactMiddle + exactLast;
		
		nFuzzy := 3 - (nConflicts + nExact + nMissing);

		// Assess where there were no conflicts and some exact matching.
		strength := if (nConflicts=0 AND nExact>0,
									if (nExact=3,
										if ((extendedNameInfo & Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED)>0, Healthcare_Shared.Constants.NameScoreStrength.Strong, Healthcare_Shared.Constants.NameScoreStrength.VeryStrong),
										if (nExact=2,
											if ((extendedNameInfo & Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED)>0, Healthcare_Shared.Constants.NameScoreStrength.Weak, Healthcare_Shared.Constants.NameScoreStrength.Strong),
											if (nExact=1,
												if ((extendedNameInfo & Healthcare_Shared.Constants.NameScoreExtendedMatchInfo.STUFF_WAS_TRANSPOSED)>0, Healthcare_Shared.Constants.NameScoreStrength.VeryWeak, Healthcare_Shared.Constants.NameScoreStrength.Weak), Healthcare_Shared.Constants.NameScoreStrength.NotAssessed))), Healthcare_Shared.Constants.NameScoreStrength.NotAssessed);
		
		// Assess where there were no conflicts, but no exact matching.
		strength2 := if (strength!=Healthcare_Shared.Constants.NameScoreStrength.NotAssessed, strength,
									 if (nConflicts=0 AND nExact=0,
										 if (nFuzzy=3, Healthcare_Shared.Constants.NameScoreStrength.Weak,
											 if (nFuzzy=2, Healthcare_Shared.Constants.NameScoreStrength.VeryWeak, Healthcare_Shared.Constants.NameScoreStrength.NoWay)), Healthcare_Shared.Constants.NameScoreStrength.NotAssessed));

		// Assess where there were conflicts and exact matches.
		strength3 := if (strength2!=Healthcare_Shared.Constants.NameScoreStrength.NotAssessed, strength2,
									 if (nConflicts>0 AND nExact>0,
										 if (nExact=2, Healthcare_Shared.Constants.NameScoreStrength.Weak,
											 if (nExact=1, Healthcare_Shared.Constants.NameScoreStrength.VeryWeak, Healthcare_Shared.Constants.NameScoreStrength.NotAssessed)), Healthcare_Shared.Constants.NameScoreStrength.NotAssessed));
		
		// Assess where there were conflicts and fuzzy matches.
		strength4 := if (strength3!=Healthcare_Shared.Constants.NameScoreStrength.NotAssessed, strength3,
									 if (nConflicts>0 AND nFuzzy>0,
											if (nConflicts + nMissing >= 3, Healthcare_Shared.Constants.NameScoreStrength.NoWay,
												if (nFuzzy=3, Healthcare_Shared.Constants.NameScoreStrength.VeryWeak, Healthcare_Shared.Constants.NameScoreStrength.NotAssessed)), Healthcare_Shared.Constants.NameScoreStrength.NotAssessed));

		// To get here there was doody.
		strength5 := if (strength4!=Healthcare_Shared.Constants.NameScoreStrength.NotAssessed, strength4, Healthcare_Shared.Constants.NameScoreStrength.NoWay);

		RETURN strength5;
	END;
	
	
	EXPORT Healthcare_Shared.Layouts.NameExtendedMatchInfo GetNameExtendedMatchInfo(INTEGER4 extendedNameInfo) := FUNCTION
		// alias this for readability
		xmi := Healthcare_Shared.Constants.NameScoreExtendedMatchInfo;
		val := extendedNameInfo;
		
		Healthcare_Shared.Layouts.NameExtendedMatchInfo create_row := transform 
			self.stuff_was_transposed 						:= (val & xmi.STUFF_WAS_TRANSPOSED);
			self.first_middle_transposed 					:= (val & xmi.FIRST_MIDDLE_TRANSPOSED);
			self.first_last_transposed 						:= (val & xmi.FIRST_LAST_TRANSPOSED);
			self.middle_first_transposed 					:= (val & xmi.MIDDLE_FIRST_TRANSPOSED);
			self.middle_last_transposed 					:= (val & xmi.MIDDLE_LAST_TRANSPOSED);
			self.last_first_transposed 						:= (val & xmi.LAST_FIRST_TRANSPOSED);
			self.last_middle_transposed 					:= (val & xmi.LAST_MIDDLE_TRANSPOSED);
			self.other_match 											:= (val & xmi.OTHER_MATCH);
			self.gender_conflict 									:= (val & xmi.GENDER_CONFLICT);
			self.first_name_match 								:= (val & xmi.FIRST_NAME_MATCH);
			self.preferred_name_match							:= (val & xmi.PREFERRED_NAME_MATCH);
			self.first_name_fuzzy 								:= (val & xmi.FIRST_NAME_FUZZY);
			self.first_name_initial_match 				:= (val & xmi.FIRST_NAME_INITIAL_MATCH);
			self.first_name_conflict 							:= (val & xmi.FIRST_NAME_CONFLICT);
			self.female_with_last_name_conflict 	:= (val & xmi.FEMALE_WITH_LAST_NAME_CONFLICT);
			self.middle_name_match 								:= (val & xmi.MIDDLE_NAME_MATCH);
			self.middle_name_fuzzy 								:= (val & xmi.MIDDLE_NAME_FUZZY);
			self.middle_name_initial_match 				:= (val & xmi.MIDDLE_NAME_INITIAL_MATCH);
			self.middle_name_conflict 						:= (val & xmi.MIDDLE_NAME_CONFLICT);
			self.last_name_match 									:= (val & xmi.LAST_NAME_MATCH);
			self.last_name_fuzzy 									:= (val & xmi.LAST_NAME_FUZZY);
			self.last_name_conflict 							:= (val & xmi.LAST_NAME_CONFLICT);
			self.last_name_initial_match 					:= (val & xmi.LAST_NAME_INITIAL_MATCH);
			self.maturity_suffix_match 						:= (val & xmi.MATURITY_SUFFIX_MATCH);
			self.maturity_suffix_conflict 				:= (val & xmi.MATURITY_SUFFIX_CONFLICT);
			self.maturity_suffix_ambiguous 				:= (val & xmi.MATURITY_SUFFIX_AMBIGUOUS);
			self.name_rearrangement_match 				:= (val & xmi.NAME_REARRANGEMENT_MATCH);
			self.name_rearrangement_fuzzy_match 	:= (val & xmi.NAME_REARRANGEMENT_FUZZY_MATCH);
			self.fka_name_match 									:= (val & xmi.FKA_NAME_MATCH);
			self.strength													:= GetNameStrength(extendedNameInfo);
		end;
		return row(create_row);
	END;
	
	// Check to see if date is expired, given a grace period in months
	EXPORT boolean isExpiredWithGraceMonths(string8 date, integer4 graceMonths) := function
		myDate := STD.Date.FromStringToDate(date, '%Y%m%d');

		unsigned1 myMonth := STD.Date.Month(myDate) + graceMonths - 1;	
		
		integer2 year := if (myMonth >= 12, STD.Date.Year(myDate) + myMonth DIV 12, STD.Date.Year(myDate));
		unsigned1 month := myMonth % 12 + 1;
		unsigned1 day := STD.Date.Day(myDate);
		
		isLeap :=	if ((((year % 4)=0 and (year % 100)!= 0) or (year % 400)=0), true, false);
		monthDayCount := if (isLeap, [31,29,31,30,31,30,31,31,30,31,30,31], [31,28,31,30,31,30,31,31,30,31,30,31]);
		// if we have a date that is not real, back up to last day of month
		fixedDay := if (day > monthDayCount[month], monthDayCount[month], day);
		
		return if (STD.Date.DateFromParts(year, month, fixedDay) < STD.Date.Today(), true, false);
	end;

	EXPORT unsigned4 addGraceToDate(string8 date, integer4 graceAmt, string graceType = 'D') := function
		//Function takes in a date (CCYYMMDD) and adds a grace period (graceAmt) to that date based on the graceType (D = Days, M = Months, Y = Years).
		//It compares the current date to the grace period adjusted input date and dtermines if the new adjusted date is in the future or is expired.
		myDate := STD.Date.FromStringToDate(date, '%Y%m%d');
		myCompareYear := STD.Date.Year(myDate);
		myCompareMonth := STD.Date.Month(myDate);
		myCompareDay := STD.Date.Day(myDate);
		myGregorianDate := STD.Date.FromGregorianYMD((integer)myCompareYear,(integer)myCompareMonth,(integer)myCompareDay);
		myAdjustedGregorianDate := if(graceType = 'D', myGregorianDate+graceAmt, myGregorianDate);
		myAdjustedDay := map(graceType = 'D' => STD.Date.ToGregorianYMD(myAdjustedGregorianDate).Day,
												 myCompareDay);
		myAdjustedMonth := map(graceType = 'D' => STD.Date.ToGregorianYMD(myAdjustedGregorianDate).Month,
													 graceType = 'M' and graceAmt+myCompareMonth > 12 => graceAmt+myCompareMonth-12,
													 graceType = 'M' and graceAmt+myCompareMonth < 12 => graceAmt+myCompareMonth,
													 myCompareMonth);
		myAdjustedYear := map(graceType = 'D' => STD.Date.ToGregorianYMD(myAdjustedGregorianDate).Year,
													graceType = 'M' and graceAmt+myCompareMonth > 12 => myCompareYear+1,
													graceType = 'Y' => myCompareYear+graceAmt,
													myCompareYear);
		myGraceDate := STD.Date.DateFromParts(MyAdjustedYear, MyAdjustedMonth, MyAdjustedDay);
		return myGraceDate;
	end;
	EXPORT boolean isExpiredWithGrace(string8 date, integer4 graceAmt, string graceType = 'D') := function
		myGraceDate := addGraceToDate(date,graceAmt,graceType);
		return  myGraceDate < STD.Date.Today();
	end;

	EXPORT isValidState(STRING2 state_in) := function
					states_ds := DATASET([{'AL'},{'AK'},{'AR'},{'AS'},{'AZ'},{'CA'},{'CO'},{'CT'},{'DC'},{'DE'},{'FL'},{'FL'},{'GA'},{'GS'},{'GU'},{'HI'},{'IA'},{'ID'},{'IL'},
																{'IN'},{'KS'},{'KY'},{'LA'},{'MA'},{'MD'},{'ME'},{'MI'},{'MN'},{'MO'},{'MS'},{'MT'},{'NC'},{'ND'},{'NE'},{'NH'},{'NJ'},{'NM'},{'NV'},
																{'NU'},{'NY'},{'OH'},{'OK'},{'OR'},{'PA'},{'PR'},{'RI'},{'RN'},{'SC'},{'SD'},{'TN'},{'TX'},{'UT'},{'VA'},{'VI'},{'VT'},{'WA'},{'WI'},
																{'WV'},{'WY'},{'AZ'},{'RR'},{'WV'},{'PR'},{'EE'}],{STRING state});
					isValidState := IF(state_in in set(states_ds,state),TRUE,FALSE);
				return isValidState;
	END;
	
	EXPORT getCountryCode (string inStr) := function //inStr will be a state that gets translated to a country code
		clnStr := STD.Str.ToUpperCase(inStr);
		return map(clnStr = 'AS' => 'ASM',
							 clnStr = 'FM' => 'FSM',
							 clnStr = 'GU' => 'GUM',
							 clnStr = 'MH' => 'MHL',
							 clnStr = 'MP' => 'MNP',
							 clnStr = 'PW' => 'PLW',
							 clnStr = 'PR' => 'PRI',
							 clnStr = 'UM' => 'UMI',
							 clnStr = 'VI' => 'VIR',
							 'USA');
	end;	
	
	Export convertInt2Specialty(STRING sp) := FUNCTION
			s := sp[1..2];
			returnVal := map(s = '01' => 'General Practice',
										 s = '02' => 'General Surgery',
										 s = '03' => 'Allergy and Immunology',
										 s = '04' => 'Otolaryngology',
										 s = '05' => 'Anesthesiology',
										 s = '06' => 'Cardiology',
										 s = '07' => 'Dermatology',
										 s = '08' => 'Family Practice',
										 s = '09' => 'Interventional Pain Management',
										 s = '10' => 'Gastroenterology',
										 s = '11' => 'Internal Medicine',
										 s = '12' => 'Osteopathic Manipulative Treatment',
										 s = '13' => 'Neurology',
										 s = '14' => 'Neurosurgery',
										 s = '16' => 'Obsterics & Gynecology',
										 s = '18' => 'Ophthalmology',
										 s = '19' => 'Oral Surgery',
										 s = '20' => 'Orthopedic Surgery',
										 s = '22' => 'Pathology',
										 s = '24' => 'Plastic and Reconstructive Surgery',
										 s = '25' => 'Physical MEdicine and Rehabilitation',
										 s = '26' => 'Psychiatry',
										 s = '28' => 'Colorectal Surgery',
										 s = '29' => 'Pulmonary Disease',
										 s = '30' => 'Diagnostic Radiology',
										 s = '33' => 'Thoracic Surgery',
										 s = '34' => 'Urology',
										 s = '35' => 'Chiropractic',
										 s = '36' => 'Nuclear Medicine',
										 s = '37' => 'Pediatric Medicine',
										 s = '38' => 'Geriatric Medicine',
										 s = '39' => 'Nephrology',
										 s = '40' => 'Hand Surgery',
										 s = '41' => 'Optometry',
										 s = '44' => 'Infectious Disease',
										 s = '46' => 'Endocrinology',
										 s = '48' => 'Podiatry',
										 s = '50' => 'Nurse Practitioner',
										 s = '62' => 'Psychologist',
										 s = '64' => 'Audiologist',
										 s = '65' => 'Physical Therapist',
										 s = '66' => 'Rheumatology',
										 s = '67' => 'Occupational Therapist',
										 s = '68' => 'Clinical Psychologist',
										 s = '71' => 'Registered Dietitian',
										 s = '72' => 'Pain Management',
										 s = '76' => 'Peripheral Vascular Disease',
										 s = '77' => 'Vascular Surgery',
										 s = '78' => 'Cardiac Surgery',
										 s = '79' => 'Addiction Medicine',
										 s = '81' => 'Critical Care',
										 s = '82' => 'Hematology',
										 s = '83' => 'Hematology-Oncology',
										 s = '84' => 'Preventive',
										 s = '85' => 'Maxillofacial Surgery',
										 s = '86' => 'Neuropsychiatry',
										 s = '90' => 'Medical Oncology',
										 s = '91' => 'Surgical Oncology',
										 s = '92' => 'Radiation Oncology',
										 s = '93' => 'Emergency Medicine',
										 s = '94' => 'Interventional Radiology',
										 s = '96' => 'Optician',
										 s = '98' => 'Gynecological Oncology',
										 s = '99' => 'Undefined Physician Type',
											'');
		return returnVal;
	end;
	
	EXPORT CleanTaxids(string15 taxid) := FUNCTION 
		CleanedTin := cleanOnlyNumbers(Trim(taxid, left,right));
		IsInvalid := TaxID = '999999999' or CleanedTin = '999999999';
		IsCorrectLength := length(CleanedTin) = 9;
		Typo := IFF(length(CleanedTin) > 9 and CleanedTin[9] = CleanedTin[10], CleanedTin[1..9], '');
		EditedVal := map(
									length(CleanedTin) = 1  => '00000000' + CleanedTin,
									length(CleanedTin) = 2 => '0000000' + CleanedTin,
									length(CleanedTin) = 3 => '000000' + CleanedTin,
									length(CleanedTin) = 4 => '00000' + CleanedTin,
									length(CleanedTin) = 5 => '0000' + CleanedTin,
									length(CleanedTin) = 6 => '000' + CleanedTin,
									length(CleanedTin) = 7 => '00' + CleanedTin,
									length(CleanedTin) = 8 => '0' + CleanedTin,
									'');
		return map(IsInvalid => '',
							 Typo <> '' => Typo, 
							 NOT IsCorrectLength and length(CleanedTin) = 9 => CleanedTin,
							 NOT IsCorrectLength => EditedVal,
							 IsCorrectLength => CleanedTin,
							 '');
	end;
	Export getDateStat(string10 InDate) := Function
			TodayIs 									:= ut.GetDate;
			InDateOnlyNumbers					:= cleanOnlyNumbers(InDate);
			InDateLength 							:= length(trim(InDate));
			InDateOnlyNumbersLength 	:= length(trim(InDateOnlyNumbers));
			DateYear 									:= trim(InDateOnlyNumbers[1..4]);
			DateMonth 								:= trim(InDateOnlyNumbers[5..6]);
			DateDay 									:= trim(InDateOnlyNumbers[7..8]);
			boolean IsTooLong 				:= InDateOnlyNumbersLength > 8;
			boolean IsInvalidDate 		:= NOT ut.ValidDate(InDateOnlyNumbers);
			boolean IsNonNumeric 			:= InDateOnlyNumbersLength <> InDateLength;
			boolean IsMonthInvalid 		:= (integer)DateMonth < 1 or (integer) DateMonth > 12;
			boolean IsYearBefore1900 	:= (integer) DateYear < 1900;
			boolean IsDateinFuture 		:= InDateOnlyNumbers > TodayIs;
		  boolean IsYearInvalid 		:= IsYearBefore1900 or (integer) DateYear > (integer) TodayIs[1..4];
			boolean IsMonthMissing 		:= DateMonth = '';
			boolean IsDayMissing 			:= DateDay='';
			// st_Missing 						:= map(isMissing				=> Healthcare_Shared.Constants.stat_Core_Missing,0); 				//2  in calling func Transform_Commonized.setStandardizedInput
			st_TooLong 								:= map(IsTooLong 				=> Healthcare_Shared.Constants.stat_Core_Truncated,0);			//8
			st_InvalidDate 						:= map(IsInvalidDate 		=> Healthcare_Shared.Constants.stat_Base_InvalidDate,0);	  //256
			st_NonNumeric							:= map(IsNonNumeric 		=> Healthcare_Shared.Constants.stat_Date_NonNumeric,0);			//512
			st_MonthInvalid						:= map(IsMonthInvalid 	=> Healthcare_Shared.Constants.stat_Date_InvalidMonth,0); 	//1024
			st_YearBefore1900					:= map(IsYearBefore1900	=> Healthcare_Shared.Constants.stat_Date_YearBefore1900,0); //2048
			st_DateinFuture						:= map(IsDateinFuture		=> Healthcare_Shared.Constants.stat_Date_Future,0); 				//4096
			st_YearInvalid						:= map(IsYearInvalid		=> Healthcare_Shared.Constants.stat_Date_InvalidYear,0); 		//16384
			st_MonthMissing						:= map(IsMonthMissing		=> Healthcare_Shared.Constants.stat_Date_MissingMonth,0); 	//32768
			st_DayMissing							:= map(IsDayMissing			=> Healthcare_Shared.Constants.stat_Date_MissingDay,0); 		//65536
			date_st 									:= (st_TooLong + st_InvalidDate + st_NonNumeric + st_MonthInvalid + st_YearBefore1900 + 
																		st_DateinFuture + st_YearInvalid + st_MonthMissing + st_DayMissing);
			// output(st_Missing, Named('datestat_st_Missing'),overwrite);
			// output(st_TooLong, Named('datestat_st_TooLong'),overwrite);
			// output(st_InvalidDate, Named('datestat_st_InvalidDate'),overwrite);
			// output(st_NonNumeric, Named('datestat_st_NonNumeric'),overwrite);
			// output(st_MonthInvalid, Named('datestat_st_MonthInvalid'),overwrite);
			// output(st_YearBefore1900, Named('datestat_st_YearBefore1900'),overwrite);
			// output(st_DateinFuture, Named('datestat_st_DateinFuture'),overwrite);
			// output(st_YearInvalid, Named('datestat_st_YearInvalid'),overwrite);
			// output(st_MonthMissing, Named('datestat_st_MonthMissing'),overwrite);
			// output(st_DayMissing, Named('datestat_st_DayMissing'),overwrite);
			// output(date_st, Named('datestat_date_st'),overwrite);
			return date_st;
	end;

        EXPORT CleanLicenseNumber(STRING lic_in) := FUNCTION
		toUpper						:= TRIM(StringLib.StringToUpperCase(lic_in), ALL);
		removeNonAlphaNum := REGEXREPLACE(Healthcare_Shared.Constants.NonAlphaNumChar, toUpper, '');
		RETURN IF(removeNonAlphaNum IN Healthcare_Shared.Constants.setBogusLicense, '', removeNonAlphaNum);
	END;
End;
