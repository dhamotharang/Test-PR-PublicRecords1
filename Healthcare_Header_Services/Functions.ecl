import AMS,Address,AutoStandardI,DEA,iesp,doxie,suppress,deathv2_Services,NPPES,STD,Healthcare_Affiliations;
EXPORT Functions := MODULE
	shared gm := AutoStandardI.GlobalModule();
	//Cleaning Functions
	Export cleanOnlyNumbers (string inStr) := function
		return STD.Str.filter(inStr,'0123456789');
	end;
	Export cleanOnlyCharacters (string inStr) := function
		return STD.Str.filter(inStr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	end;
	Export cleanOnlyNames (string inStr) := function
		return STD.Str.filter(inStr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ ');
	end;
	Export cleanLicenses (string inStr) := function
		return STD.Str.filter(inStr,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ.-');
	end;
	Export cleanWord (string inStr) := function
		return STD.Str.filter(STD.Str.ToUpperCase(inStr),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	end;
  Export BusName_SplitAndSequenceWords(STRING s) := FUNCTION
		//Needs OSS implement later
		r10 := DATASET(Std.Str.SplitWords(s, ' '), layouts.BusName_WordRec);
		r20 := PROJECT(r10,TRANSFORM(layouts.BusName_SeqWordRec,
																	SELF.seq := COUNTER,
																	SELF.word := LEFT.word));
		RETURN r20;
	END;
  Export BusName_ResequenceWords(DATASET(Layouts.BusName_SeqWordRec) ds) := FUNCTION
    resultDS := PROJECT(SORT(ds, seq),TRANSFORM(Layouts.BusName_SeqWordRec,
																									SELF.seq := COUNTER,
																									SELF.word := LEFT.word));
    RETURN resultDS;
  END;
  // Removes certain prefix and suffix whole words from the argument
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
	Export BusName_TranslateSequencedWords(DATASET(Layouts.BusName_SeqWordRec) seqNameWords) := FUNCTION
		TranslationRec := RECORD
			STRING      origWord;
			STRING      newWord;
		END;
		// Adapted from HealthCareFacility.Constants.Conv_Table
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
	Export BusName_MakeInitialism(DATASET(Layouts.BusName_SeqWordRec) ds) := FUNCTION
			tempDS := PROJECT(ds,TRANSFORM(Layouts.BusName_SeqWordRec,
											SELF.word := LEFT.word[1],
											SELF := LEFT));
			resultDS := ROLLUP(SORT(tempDS, seq),TRUE,TRANSFORM(Layouts.BusName_SeqWordRec,
											SELF.word := LEFT.word + RIGHT.word,
											SELF := RIGHT));
			finalWord := resultDS[1].word;
		RETURN finalWord;
	END;
	Export BusName_ScorePrefixMatch(STRING name1, STRING name2) := FUNCTION
			maxNameLength := MAX(LENGTH(name1), LENGTH(name2));
			matchCount := Functions_C.BusName_PrefixMatchCount(name1, name2);
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
			// output(seqNameWords);
			// output(translatedWords);
			// output(noiselessWords);
			// output(resequencedWords);
			RETURN resequencedWords;
	END;
	EXPORT CompareBusinessNameConfidence(STRING inputName, STRING candidateName) := FUNCTION
			inputNameWords := dedup(sort(BusName_CleanAndSplitCompanyName(inputName),word,seq),word);
			candidateNameWords := dedup(sort(BusName_CleanAndSplitCompanyName(candidateName),word,seq),word);
			inputNameInitialism := BusName_MakeInitialism(inputNameWords);
			candidateNameInitialism := BusName_MakeInitialism(candidateNameWords);
	// Compare every word in input vs. candidate strings
			wordsCombined1 := JOIN(inputNameWords,candidateNameWords,TRUE,TRANSFORM(Layouts.BusName_WordsScoredRec,
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
		// splitStr := stringLib.splitWords(inStr,' ',false);
		splitStr := Std.Str.SplitWords(inStr,' ');
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
	//Did Frequency Logic
	Export processDids(dataset(Layouts.layout_did) ds) := Function  
		grp:=sort(ds,did);
		tmprec := record
			did:=grp.did;
			freq:=count(group);
		end;
		t:=table(grp,tmprec,did,few);
		f:=sort(project(t,Layouts.layout_did),-freq);
		return f;
	end;
	// BDid Frequency Logic
	Export processBDids(dataset(Layouts.layout_bdid) ds) := Function  
		grp:=sort(ds,bdid);
		tmprec := record
			bdid:=grp.bdid;
			freq:=count(group);
		end;
		t:=table(grp,tmprec,bdid,few);
		f:=sort(project(t,Layouts.layout_bdid),-freq);
		return f;
	end;
	// BIP Frequency Logic
	Export processBIPKeys(dataset(Layouts.layout_bipkeys) ds) := Function  
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
		f:=sort(project(t,Layouts.layout_bipkeys),-freq);
		return f;
	end;
	export buildAddress (string prim_range, string predir, string prim_name, string addr_suffix, string postdir, string unit_desig, string sec_range) := function
		addr := prim_range+ ' ' +predir+ ' ' +prim_name+ ' ' +addr_suffix+ ' ' +postdir+' ' +unit_desig+ ' ' +sec_range;
		return STD.str.cleanspaces(addr);
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
	Shared calcStLicPenalty(String rawLicenseState, String rawLicense, dataset(layouts.layout_licenseinfo) recs) := Function
		validdata := rawLicense<>'';
		missingState := rawLicenseState='';
		tmpRec := project(recs,transform(matchData,
														self.matchFieldOptional:=left.LicenseState;
														self.matchFieldClnNumber:= (integer)cleanOnlyNumbers(left.LicenseNumber);
														self.matchFieldClnString:= cleanOnlyNumbers(left.LicenseNumber);
														self.matchFieldRaw:= left.LicenseNumber;));
		checkRaw := tmpRec(matchFieldRaw=rawLicense);
		checkClnString := tmpRec(matchFieldClnString=cleanOnlyNumbers(rawLicense));
		checkClnNumber := tmpRec(matchFieldClnNumber=(integer)cleanOnlyNumbers(rawLicense));
		finalRaw := if(missingstate,checkRaw,checkRaw(matchFieldOptional=rawLicenseState));
		finalClnString := if(missingstate,checkClnString,checkClnString(matchFieldOptional=rawLicenseState));
		finalClnNumber := if(missingstate,checkClnNumber,checkClnNumber(matchFieldOptional=rawLicenseState));
		penaltyVal := map(validdata and exists(recs) and exists(finalRaw) => 0,
											validdata and exists(recs) and exists(finalClnString) => 1,
											validdata and exists(recs) and exists(finalClnNumber) => 1,
											validdata and exists(recs) => 2,
											validdata and not exists(recs) => 0,
											0);
		return penaltyVal;
	end;
	Shared calcTaxIdPenalty(String rawInput, dataset(layouts.layout_taxid) recs) := Function
		validdata := rawinput <> '';
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
	Shared calcFeinPenalty(String rawInput, dataset(layouts.layout_fein) recs) := Function
		validdata := rawinput <> '';
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
	Shared calcUpinPenalty(String rawInput, dataset(layouts.layout_upin) recs) := Function
		validdata := rawinput <> '';
		tmpRec := project(recs,transform(matchData,
														self.matchFieldClnNumber:= (integer)cleanOnlyNumbers(left.upin);
														self.matchFieldClnString:= cleanOnlyNumbers(left.upin);
														self.matchFieldRaw:= left.upin;));
		checkRaw := tmpRec(matchFieldRaw=rawInput);
		checkClnString := tmpRec(matchFieldClnString=cleanOnlyNumbers(rawInput));
		checkClnNumber := tmpRec(matchFieldClnNumber=(integer)cleanOnlyNumbers(rawInput));
		penaltyVal := map(validdata and exists(recs) => if(exists(checkRaw) or exists(checkClnString) or Exists(checkClnNumber),0,2),
											validdata and not exists(recs) => 1,
											0);
		return penaltyVal;
	end;
	Shared calcNpiPenalty(String rawInput, dataset(layouts.layout_npi) recs) := Function
		validdata := rawinput <> '';
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
	Shared calcDeaPenalty(String rawInput, dataset(layouts.layout_dea) recs) := Function
		validdata := rawinput <> '';
		tmpRec := project(recs,transform(matchData,
														self.matchFieldClnNumber:= (integer)cleanOnlyNumbers(left.dea);
														self.matchFieldClnString:= cleanOnlyNumbers(left.dea);
														self.matchFieldRaw:= left.dea;));
		checkRaw := tmpRec(matchFieldRaw=rawInput);
		checkClnString := tmpRec(matchFieldClnString=cleanOnlyNumbers(rawInput));
		checkClnNumber := tmpRec(matchFieldClnNumber=(integer)cleanOnlyNumbers(rawInput));
		penaltyVal := map(validdata and exists(recs) => if(exists(checkRaw) or exists(checkClnString) or Exists(checkClnNumber),0,4),
											validdata and not exists(recs) => 1,
											0);
		return penaltyVal;
	end;	
	Shared calcCLIAPenalty(String rawInput, dataset(layouts.layout_clianumber) recs) := Function
		validdata := rawinput <> '';
		checkString := recs((integer)cleanOnlyNumbers(clianumber)=(integer)cleanOnlyNumbers(rawInput));
		penaltyVal := map(validdata and exists(recs) => if(exists(checkString),0,4),
											0);
		return penaltyVal;
	end;	
	Shared calcNCPDPPenalty(String rawInput, dataset(iesp.ncpdp.t_PharmacyReport) recs) := Function
		validdata := rawinput <> '';
		RecsRaw := project(recs,Transform(iesp.ncpdp.t_PharmacyInformation,self:=left.EntityInformation;self:=[]));
		checkString := RecsRaw(PharmacyProviderId=rawInput);
		penaltyVal := map(validdata and exists(recs) => if(exists(checkString),0,4),
											0);
		return penaltyVal;
	end;	
	export getAddrPenalty (string inStreetNbr, string inStreet, string inCity, string inState, string inZip, string rawStreetNbr ,string rawStreet, string rawCity, string rawState, string rawZip, integer zip_Radius):=function
			tempaddrmod := MODULE(PROJECT(gm, AutoStandardI.LIBIN.PenaltyI_Addr.full, opt))					
					EXPORT predir         := '1'; //Force Value of Input and output to match so we do not get extra added penalty for not supplying it.
					EXPORT prim_name      := inStreet;
					EXPORT prim_range     := '1';//Force Value of Input and output to match so we do not get extra added penalty for not supplying it.
					EXPORT postdir        := '1';//Force Value of Input and output to match so we do not get extra added penalty for not supplying it.
					EXPORT addr_suffix    := '1';//Force Value of Input and output to match so we do not get extra added penalty for not supplying it.
					EXPORT sec_range      := '1';//Force Value of Input and output to match so we do not get extra added penalty for not supplying it.
					EXPORT p_city_name    := inCity;
					EXPORT st             := inState;
					EXPORT z5             := inZip;											
					EXPORT zipradius      := zip_Radius;											
					//	The address in the matching record:						
					EXPORT allowwildcard   := FALSE;															
					EXPORT allow_wildcard  := FALSE;															
					EXPORT city_field      := rawCity;
					EXPORT city2_field     := rawCity;										
					EXPORT pname_field     := rawStreet;									
					EXPORT prange_field    := '1';//Force Value of Input and output to match so we do not get extra added penalty for not supplying it.										
					EXPORT postdir_field   := '1';//Force Value of Input and output to match so we do not get extra added penalty for not supplying it.																				
					EXPORT predir_field    := '1';//Force Value of Input and output to match so we do not get extra added penalty for not supplying it.									
					EXPORT state_field     := rawState;										
					EXPORT suffix_field    := '1';//Force Value of Input and output to match so we do not get extra added penalty for not supplying it.										
					EXPORT zip_field       := rawZip;											
					EXPORT sec_range_field := '1';//Force Value of Input and output to match so we do not get extra added penalty for not supplying it.
					EXPORT zipradius_value := zip_Radius;											
					EXPORT useGlobalScope  := FALSE;
			end;
			
			addrPenalty:=AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempaddrmod);
			foundHouse := STD.Str.Contains(rawStreetNbr,inStreetNbr,true);//Add in custom penalty for house number
			// output(addrPenalty+'->'+inStreetNbr+' '+inStreet+' '+inCity+' '+inState+' '+inZip+' RAW '+rawStreetNbr+' '+rawStreet+' '+rawCity+' '+rawState+' '+rawZip+' '+zip_Radius);
			return If(foundHouse,addrPenalty,addrPenalty+2);
	end;
	Export getBestAddrPenalty (dataset(layouts.layout_addressinfo) inAddrs, layouts.autokeyInput input, integer zipradius) := function
			bestValues := project(inAddrs,transform(layouts.layout_addressinfo,
															getPenalty := getAddrPenalty(input.prim_range,input.prim_name,input.p_city_name,input.st,input.z5,
																								STD.Str.ToUpperCase(left.prim_range),STD.Str.ToUpperCase(left.prim_name),STD.Str.ToUpperCase(left.p_city_name),STD.Str.ToUpperCase(left.st),left.z5,zipradius);
															self.addrPenalty:=getPenalty;self:=left));


			return min(bestValues,addrpenalty);
	end;
	export getNamePenalty (string inFirst, string inMiddle, string inLast, string inCompany, string rawFirst ,string rawMiddle, string rawLast, string rawCompany):=function
			tempNameMod := MODULE(PROJECT(gm, AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, opt))					
				EXPORT lastname       := inLast;       // the 'input' last name
				EXPORT middlename     := inMiddle;     // the 'input' middle name
				EXPORT firstname      := inFirst;      // the 'input' first name
				EXPORT allow_wildcard := FALSE;
				EXPORT useGlobalScope := FALSE;									
				EXPORT lname_field    := rawLast;			// matching record name information			                          
				EXPORT mname_field    := rawMiddle; 
				EXPORT fname_field    := rawFirst;	
			END;	
			foundName := inLast <> '' and rawLast <> '';
			namePenalty := map(foundName=>AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempNameMod),
												 // inLast <> '' => 10,
												 0);	
			foundCompany := inCompany<> '' and rawCompany <> ''; // we found a business
			Confidence := CompareBusinessNameConfidence(rawCompany,inCompany);
			busPenalty := map(foundCompany => if(Confidence>=Constants.BUS_NAME_BIPMATCH_THRESHOLD,(100-Confidence)/10,(100-Confidence)/5),
												// inCompany <> '' => 10,
												0);

			return namePenalty+busPenalty;
	end;
	Export getBestNamePenalty (dataset(layouts.layout_nameinfo) inNames, layouts.autokeyInput input) := function
			bestValues := project(inNames(LastName<>'' or CompanyName <>''),transform(layouts.layout_nameinfo,
															getPenalty := getNamePenalty(input.name_first,input.name_middle,input.name_last,input.comp_name,
																							 STD.Str.ToUpperCase(left.FirstName),STD.Str.ToUpperCase(left.MiddleName),STD.Str.ToUpperCase(left.LastName),STD.Str.ToUpperCase(left.CompanyName));
															self.namePenalty:=getPenalty;self:=left));

			return min(bestValues,namePenalty);
	end;
	Export doPenalty (dataset(layouts.CombinedHeaderResults) inRecs, dataset(layouts.autokeyInput) input, integer maxPenalty, integer zipradius = Constants.ZIP_RADIUS) := function
		//Custom penalty logic
		outRec := layouts.CombinedHeaderResults;
		outRec xform(outRec l, layouts.autokeyInput r) := transform
						//Collect Addresses and apply penalty to get lowest
						allAddrs := l.addresses + project(l.affiliates,transform(layouts.layout_addressinfo, self:=left;self:=[])) + project(l.hospitals,transform(layouts.layout_addressinfo, self:=left;self:=[]));
						hasAddressInput := r.prim_range<>'' or r.prim_name <> '' or r.p_city_name <> '' or r.st <> '' or r.z5 <>'';
						hasNameInput := r.name_first <> '' or r.name_middle <> '' or r.name_last <> '' or r.comp_name <>'';
						addrPen := if(hasAddressInput,getBestAddrPenalty(allAddrs,r,zipradius),0);
						namePen :=  if(hasNameInput,getBestNamePenalty(l.names,r),0);
						stlicPen := if(r.license_state<>'',calcStLicPenalty(r.license_state, r.license_number, l.StateLicenses),0);
						taxidPen := if(r.TaxID<>'',calcTaxIdPenalty(r.TaxID, l.taxids),0);
						feinPen := if(r.FEIN<>'',calcFeinPenalty(r.FEIN, l.feins),0);
						upinPen := if(r.UPIN<>'',calcUpinPenalty(r.UPIN, l.upins),0);
						npiPen := if(r.NPI<>'',calcNpiPenalty(r.NPI, l.npis),0);
						deaPen := if(r.DEA<>'',calcDeaPenalty(r.DEA, l.deas),0);
						cliaPen := if(r.CLIANumber<>'',calcCLIAPenalty(r.CLIANumber, l.clianumbers),0);
						ncpdpPen := if(r.NcpdpNumber<>'',calcNCPDPPenalty(r.NcpdpNumber, l.NCPDPRaw),0);
						isLNIDMatch := (exists(l.dids(did=r.did)) and r.did>0) or (exists(l.bdids(bdid=r.bdid)) and r.bdid>0);
						isDEAMatch := exists(l.deas(dea=r.DEA)) and r.DEA<>'';
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
						isLNPIDMatch := r.ProviderID > 0 and r.derivedInputRecord = false and (l.lnpid > 0 and l.lnpid = r.ProviderID);
						isExactSSN := exists(l.ssns(ssn=r.SSN)) and r.SSN <> '';
						isDeepDiveSSNMatch := exists(l.ssns(ssn=r.SSN)) and r.SSN <> '' and l.src = Constants.SRC_BOCA_PERSON_HEADER;
						isDeepDiveFEINMatch := exists(l.feins(fein=r.fein)) and r.fein <> '' and l.src = Constants.SRC_BOCA_BUS_HEADER;
						adjustAddrPenalty := isDEAMatch or isNPIMatch or isUPINMatch or isExactCLIA or isExactNCPDP or isStateLicenseMatch;
						addrPenalty :=if(adjustAddrPenalty,truncate(addrPen/10),addrPen);//Address penalty could be very high and should not count as much as other penalties divide by 10
						totalPen := namePen+addrPenalty+stlicPen+taxidPen+feinPen+upinPen+npiPen+deaPen+cliaPen+ncpdpPen;
						//If the user supplied a DID, Bdid or other identifier exactly, go ahead and return that record.
						self.LNPID := if(l.LNPID = 0, l.SrcId, l.LNPID);
						self.facilitytype:=l.facilitytype;
						self.OrganizationType:=l.OrganizationType;
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
		recsWithPenalty := join(inRecs(penalty_applied=false),input,left.acctno=right.acctno,xform(left,right),keep(Constants.MAX_RECS_ON_JOIN), limit(0));
    removeOverPenalty := recsWithPenalty(record_penalty<=if(src=Constants.SRC_BOCA_PERSON_HEADER,maxPenalty*Constants.DEEPDIVE_PENALTY_MULTIPLIER,maxPenalty) or isExactLNID or isExactDEA or isExactNPI or isExactUPIN or isExactCLIA or isExactNCPDP or isExactStateLicense  or isExactLNPID or isExactSSN or isautokeysresult or isDeepDiveSSNMatch or isDeepDiveFEINMatch or isSearchFailed);					
		//remove derived records if we have a non derived input records with the same acctno.
		recsNotDerivedInput := removeOverPenalty(isDerivedSource=false);
		recsDerivedInput := join(removeOverPenalty,recsNotDerivedInput, left.acctno=right.acctno, all, left only);
		inrecsPenaltyTrue := inRecs(penalty_applied=true);
		finalRecs := recsNotDerivedInput+recsDerivedInput+inRecs(penalty_applied=true);
		sortRecs := sort(finalRecs,acctno,srcid,src,record_penalty);
		dedupRecs := sort(dedup(sortRecs, acctno,srcid,src),record_penalty);












				return dedupRecs;
	end;
	//AMS Specific Functions
	export getAmsGroupAffiliations(dataset(Layouts.searchKeyResults_plus_input) provs) := function
			getGroupsIDs := join(provs,ams.keys().Affiliation.AMSID.qa,keyed(if (left.vendorid <> '',(string)left.vendorid,(string)left.prov_id) = right.ams_id) and 
												keyed(right.record_type = AMS._Constants().CURRENT) and 
												right.rawfields.affil_status = AMS._Constants().ACTIVE AND 
												right.isparent = FALSE and 
												right.rawfields.affil_type != AMS._Constants().PROVIDER_TO_HOSPITAL,keep(Constants.MAX_RECS_ON_JOIN), limit(0));
			getActualAffiliations := JOIN(getGroupsIDs,ams.keys().main.amsid.qa,
												KEYED(LEFT.ams_other_id = RIGHT.ams_id),
												transform(layouts.layout_affiliateHospital, 
															self.acctno := left.acctno;
															SELF.providerid := (unsigned6)left.ams_id;
															self.BDID := right.BDID;
															self.name := RIGHT.rawdemographicsfields.acct_name;
															self.addrPenalty := getHospitalAffiliationPenalty(left.prim_name, left.p_city_name, left.St, left.Z5, RIGHT.clean_company_address.prim_name, RIGHT.clean_company_address.p_city_name, RIGHT.clean_company_address.st, RIGHT.clean_company_address.zip);
															self.address1 := Address.Addr1FromComponents(RIGHT.clean_company_address.prim_range, RIGHT.clean_company_address.predir, RIGHT.clean_company_address.prim_name, RIGHT.clean_company_address.addr_suffix, RIGHT.clean_company_address.postdir, RIGHT.clean_company_address.unit_desig, RIGHT.clean_company_address.sec_range);
															self.prim_range := RIGHT.clean_company_address.prim_range;
															self.predir := RIGHT.clean_company_address.predir;
															self.prim_name := RIGHT.clean_company_address.prim_name;
															self.addr_suffix := RIGHT.clean_company_address.addr_suffix;
															self.postdir := RIGHT.clean_company_address.postdir;
															self.unit_desig := RIGHT.clean_company_address.unit_desig;
															self.sec_range := RIGHT.clean_company_address.sec_range;
															self.p_city_name := RIGHT.clean_company_address.p_city_name;
															self.st := RIGHT.clean_company_address.st;
															self.z5 := RIGHT.clean_company_address.zip;
															self.zip4 := RIGHT.clean_company_address.zip4;
															self:=[]),keep(Constants.MAX_RECS_ON_JOIN), limit(0));
			layouts.layout_Child_affiliateHospital doRollup(layouts.layout_affiliateHospital l, 
																									dataset(layouts.layout_affiliateHospital) r) := TRANSFORM
				SELF.acctno := l.acctno;
				self.ProviderID := l.ProviderID;
				self.childinfo := choosen(r,Constants.MAX_GROUP_AFFILIATIONS);
			END;
			results_rolled := rollup(group(sort(getActualAffiliations,acctno,ProviderID),acctno,ProviderID),group,doRollup(left,rows(left)));
		return results_rolled;
	End;
	export getAmsHospitalInfo(dataset(layouts.searchKeyResults_plus_input) provs) := function
			getGroupsIDs := join(provs,ams.keys().Affiliation.AMSID.qa,keyed(if (left.vendorid <> '',(string)left.vendorid,(string)left.prov_id) = right.ams_id) and 
												keyed(right.record_type = AMS._Constants().CURRENT) and 
												right.rawfields.affil_status = AMS._Constants().ACTIVE AND 
												right.isparent = FALSE and 
												right.rawfields.affil_type = AMS._Constants().PROVIDER_TO_HOSPITAL,keep(Constants.MAX_RECS_ON_JOIN), limit(0));
			getActualAffiliations := JOIN(getGroupsIDs,ams.keys().main.amsid.qa,
												KEYED(LEFT.ams_other_id = RIGHT.ams_id),
												transform(layouts.layout_affiliateHospital, 
															self.acctno := left.acctno;
															SELF.providerid := (unsigned6)left.ams_id;
															self.BDID := right.BDID;
															self.name := RIGHT.rawdemographicsfields.acct_name;
															self.addrPenalty := getHospitalAffiliationPenalty(left.prim_name, left.p_city_name, left.St, left.Z5, RIGHT.clean_company_address.prim_name, RIGHT.clean_company_address.p_city_name, RIGHT.clean_company_address.st, RIGHT.clean_company_address.zip);
															self.address1 := Address.Addr1FromComponents(RIGHT.clean_company_address.prim_range, RIGHT.clean_company_address.predir, RIGHT.clean_company_address.prim_name, RIGHT.clean_company_address.addr_suffix, RIGHT.clean_company_address.postdir, RIGHT.clean_company_address.unit_desig, RIGHT.clean_company_address.sec_range);
															self.prim_range := RIGHT.clean_company_address.prim_range;
															self.predir := RIGHT.clean_company_address.predir;
															self.prim_name := RIGHT.clean_company_address.prim_name;
															self.addr_suffix := RIGHT.clean_company_address.addr_suffix;
															self.postdir := RIGHT.clean_company_address.postdir;
															self.unit_desig := RIGHT.clean_company_address.unit_desig;
															self.sec_range := RIGHT.clean_company_address.sec_range;
															self.p_city_name := RIGHT.clean_company_address.p_city_name;
															self.st := RIGHT.clean_company_address.st;
															self.z5 := RIGHT.clean_company_address.zip;
															self.zip4 := RIGHT.clean_company_address.zip4;
															self:=[]),keep(Constants.MAX_RECS_ON_JOIN), limit(0));
			layouts.layout_Child_affiliateHospital doRollup(layouts.layout_affiliateHospital l, dataset(layouts.layout_affiliateHospital) r) := TRANSFORM
				SELF.acctno := l.acctno;
				self.ProviderID := l.ProviderID;
				self.childinfo := choosen(r,Constants.MAX_HOSPITAL_AFFILIATIONS);
			END;
			results_rolled := rollup(group(sort(getActualAffiliations,acctno,ProviderID),acctno,ProviderID),group,doRollup(left,rows(left)));
		return results_rolled;
	End;
	Export getAmsNpis(dataset(layouts.searchKeyResults_plus_input) provs) := function
		result := join(provs,ams.keys().IDNumber.AMSID.qa, 
									 keyed(if (left.vendorid <> '',(string)left.vendorid,(string)left.prov_id) = right.ams_id) 
									 and keyed(right.record_type = AMS._Constants().CURRENT)
									 and right.src_cd_desc = 'NPI',
									 transform(layouts.layout_npi,
														 self.acctno:=left.acctno;
														 SELF.providerid := (unsigned6)right.ams_id;
														 self.npi:=right.rawfields.indy_id),
									 keep(Constants.MAX_RECS_ON_JOIN), limit(0));
		layouts.layout_child_npi doRollup(layouts.layout_npi l, dataset(layouts.layout_npi) r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.ProviderID := l.ProviderID;
			self.childinfo := r;
		END;
		results_rolled := rollup(group(sort(result,acctno,ProviderID),acctno,ProviderID),group,doRollup(left,rows(left)));
		return results_rolled;
	End;
	Export getAmsDeas(dataset(layouts.searchKeyResults_plus_input) provs) := function
		result := join(provs,ams.keys().IDNumber.AMSID.qa, 
									 keyed(if (left.vendorid <> '',(string)left.vendorid,(string)left.prov_id) = right.ams_id)
									 and keyed(right.record_type = AMS._Constants().CURRENT)
									 and right.src_cd_desc = 'DEA',
									 transform(layouts.layout_dea,
														 self.acctno:=left.acctno;
														 SELF.providerid := (unsigned6)right.ams_id;
														 self.dea:=right.rawfields.indy_id, 
														 self.expiration_date:=right.rawfields.indy_id_end_date),
								   keep(Constants.MAX_RECS_ON_JOIN), limit(0));
		f_deas2 := dedup(sort(JOIN(result,dea.Key_dea_reg_num,keyed(left.dea=right.dea_registration_number),transform(layouts.layout_dea, self.expiration_date:=right.Expiration_Date;self :=left),keep(Constants.MAX_RECS_ON_JOIN), limit(0)),acctno,providerid,dea,-Expiration_Date),acctno,providerid,dea,Expiration_Date);
		f_deas := result+f_deas2;
		f_deas_srt := sort(f_deas(DEA<>''), record);
		f_deas_dep := sort(dedup(f_deas_srt, acctno,providerid,dea,Expiration_Date),acctno,providerid,dea,-Expiration_Date);
		layouts.layout_child_dea doRollup(layouts.layout_dea l, dataset(layouts.layout_dea) r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.ProviderID := l.ProviderID;
			self.childinfo := r;
		END;
		results_rolled := rollup(group(sort(f_deas_dep,acctno,ProviderID),acctno,ProviderID),group,doRollup(left,rows(left)));
		return results_rolled;
	End;
	Export getAmsDegrees(dataset(layouts.searchKeyResults_plus_input) provs) := function
		result := join(provs,ams.keys().Degree.amsid.qa, 
									 keyed(if (left.vendorid <> '',(string)left.vendorid,(string)left.prov_id) = right.ams_id),
												transform(layouts.layout_degree, 
																	self.acctno:=left.acctno;
																	self.providerid:=(unsigned6)right.ams_id;
																	self.Degree := right.rawfields.degree;self:=[]),
								   keep(Constants.MAX_RECS_ON_JOIN), limit(0));
		layouts.layout_child_degree doRollup(layouts.layout_degree l, dataset(layouts.layout_degree) r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.ProviderID := l.ProviderID;
			self.childinfo := r;
		END;
		results_rolled := rollup(group(sort(result,acctno,ProviderID),acctno,ProviderID),group,doRollup(left,rows(left)));
		return results_rolled;
	End;
	Export getAmsSpecialty(dataset(layouts.searchKeyResults_plus_input) provs) := function
		result := join(provs,ams.keys().specialty.amsid.qa, 
									 keyed(if (left.vendorid <> '',(string)left.vendorid,(string)left.prov_id) = right.ams_id),
												transform(layouts.layout_specialty, 
																	self.acctno:=left.acctno;
																	self.providerid:=(unsigned6)right.ams_id;
																	self.SpecialtyName := right.specialty_desc;self:=[]),
								   keep(Constants.MAX_RECS_ON_JOIN), limit(0));
		layouts.layout_child_specialty doRollup(layouts.layout_specialty l, dataset(layouts.layout_specialty) r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.ProviderID := l.ProviderID;
			self.childinfo := r;
		END;
		results_rolled := rollup(group(sort(result,acctno,ProviderID),acctno,ProviderID),group,doRollup(left,rows(left)));
		return results_rolled;
	End;
	Export getAmsLicenses(dataset(layouts.searchKeyResults_plus_input) provs) := function
		result := dedup(sort(join(provs,ams.keys().StateLicense.amsid.qa, 
									 keyed(if (left.vendorid <> '',(string)left.vendorid,(string)left.prov_id) = right.ams_id)
									 and keyed(right.record_type = AMS._Constants().CURRENT),
									 transform(layouts.layout_licenseinfo,
												self.licenseAcctno := left.acctno;
												SELF.providerid := (unsigned6)right.ams_id;
												self.licenseSeq := 1;
												self.LicenseState := right.rawfields.st_lic_state;
												self.LicenseNumber := removeLeadingZeros(cleanLicenses(right.rawfields.st_lic_num));
												self.LicenseStatus := right.rawfields.st_lic_status;
												self.Effective_Date := right.rawfields.st_lic_issue_date;
												self.Termination_Date:=right.rawfields.st_lic_exp_date),
										keep(Constants.MAX_RECS_ON_JOIN), limit(0)),LicenseState,-Termination_Date, LicenseNumber),all);
		layouts.layout_child_licenseinfo doRollup(layouts.layout_licenseinfo l, dataset(layouts.layout_licenseinfo) r) := TRANSFORM
			SELF.acctno := l.licenseAcctno;
			self.ProviderID := l.ProviderID;
			self.childinfo := r;
		END;
		results_rolled := rollup(group(sort(result,licenseAcctno,ProviderID),licenseAcctno,ProviderID),group,doRollup(left,rows(left)));
		// output(result);
		// output(results_rolled);
		return results_rolled;
	End;
	//Enclarity specific Functions
		Export buildLegacySanctionRecord(layouts.CombinedHeaderResults parent, dataset(layouts.layout_sanctions) sanc) := Function
			outlayout := layouts.layout_LegacySanctions;
			results := project(choosen(sanc,iesp.Constants.HPR.MAX_SANCTIONS),transform(outlayout,
											self.acctno := trim(left.acctno,left,right);
											self.ProviderID:= left.ProviderID;
											self.group_key:=left.group_key;
											//GenerateID
											sancid:= (string)left.ProviderID+intformat(left.GroupSortOrder,3,1);
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
																								self.SANC_FINES:=left.specialnotes;
											self := left;
											self := [];//All other fields are no longer valid via Enclarity conversion from Ingenix
											));
			// output(sanc,named('sanc'),extend);
			// output(results,named('fmtlegacy'),extend);
			return results;
		end;
	//Append Data lookups
	Export getSlimHdrRecords (dataset(layouts.CombinedHeaderResults) resultRecs, 
													dataset(layouts.autokeyInput) inputRecs) := function
		basedata := join(resultRecs,inputRecs,left.acctno=right.acctno,
											transform(Layouts.layout_slim,
															self.acctno := right.acctno;
															self.ProviderID:=left.LNPID;
															self.VendorID:='';
															self.FirstName := left.Names[1].FirstName;
															self.LastName := left.Names[1].LastName;
															self.UserCompanyName := right.comp_name;
															self.CompanyName := left.Names[1].CompanyName;
															self.UserSSN := right.ssn;
															self.UserDOB := right.dob;
															self.UserDOBFound := exists(left.dobs(dob[1..6]=right.dob[1..6]));
															self.UserFEIN := right.fein;
															self.UserCity := right.p_city_name;
															self.UserState := right.st;
															self.UserZip := right.z5;
															self.dids := left.dids;
															self.clianumbers := dataset([{right.CLIANumber}],layouts.layout_clianumber);
															self.npis := left.npis;),
												keep(Constants.MAX_RECS_ON_JOIN), limit(0));
		return basedata;
	end;
	Export getSSN(dataset(layouts.layout_slim) input,
								dataset(Layouts.common_runtime_config) cfg) := Function
	  ssn_mask_val := AutoStandardI.InterfaceTranslator.ssn_mask_val.val(project(gm,AutoStandardI.InterfaceTranslator.ssn_mask_val.params)); 
		byDids := dedup(normalize(input,left.dids,transform(Layouts.layout_sanc_DID,self.acctno := left.acctno;self.ProviderID:=left.ProviderID;self.did:=right.did;self.freq:=right.freq;self:=[])),all);
		
		doxie.mac_best_records(byDids,
													 did,
													 outfile,
													 cfg[1].dppa_ok,
													 cfg[1].glb_ok, 
													 ,
													 cfg[1].DRM,
													 include_dod := false);	// Athough this is the default value, we include it to remark the fact that DOD is not been fetched from here.
													 
		layouts.layout_ssns_freq get_provider_ssns(layouts.layout_sanc_DID l, recordof(outfile) r) := transform
			self.ssn := r.ssn;
			self := l;
		end;
													 
		f_ssns := join(byDids, outfile,
										(left.did = right.did) and (RIGHT.Valid_SSN = 'G' or RIGHT.Valid_SSN = ' ' or RIGHT.Valid_SSN = ''),
										get_provider_ssns(left, right),keep(Constants.MAX_RECS_ON_JOIN),limit(0))(ssn<>'');
									
		//Check to see if we have a match to user criteria
		f_ssns_best := join(input,f_ssns,left.acctno=right.acctno and left.ProviderID= right.ProviderID,
														transform(layouts.layout_ssns_bestHit,
															self.besthit:=if(trim(left.UserSSN,all)=trim(right.ssn,all) and left.UserSSN<>'',true,false);
															self:=left;
															self:=right),keep(Constants.MAX_RECS_ON_JOIN),limit(0));
			
		
		//Group and Dedupe
		f_ssns_BestOnly := project(f_ssns_best(besthit=true),layouts.layout_ssns);
		f_ssns_GetOthers := join(f_ssns,f_ssns_BestOnly,left.acctno=right.acctno and left.ProviderID= right.ProviderID,left only);
		//If we are not returning the user value, then base the best on frequence and only return the highest one.
		f_ssns_OthersWithFreq := dedup(sort(f_ssns_GetOthers,acctno,ProviderID,-freq),acctno,ProviderID);
		f_ssns_OthersWithHighestFreq := project(f_ssns_OthersWithFreq,layouts.layout_ssns);
		f_ssns_final := sort(f_ssns_BestOnly+f_ssns_OthersWithHighestFreq,acctno,ProviderID);
		//Masking for SSN 
		doxie.MAC_PruneOldSSNs(f_ssns_final, out_ssn_pruned, ssn, providerid);
		suppress.MAC_Mask(out_ssn_pruned, f_ssns_masked, ssn, blank, true, false,,,,ssn_mask_val);
		layouts.layout_child_ssns doRollup(layouts.layout_ssns l, dataset(layouts.layout_ssns) r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.ProviderID := l.ProviderID;
			self.childinfo := r;
		END;
		results_rolled := rollup(group(sort(f_ssns_masked(ssn<>''),acctno,ProviderID),acctno,ProviderID),group,doRollup(left,rows(left)));
		// output(input,named('input_ssns'));
		// output(f_ssns,named('f_ssns'));
		// output(f_ssns_best,named('f_ssns_best'));
		// output(f_ssns_BestOnly,named('f_ssns_BestOnly'));
		// output(f_ssns_OthersWithHighestFreq,named('f_ssns_OthersWithHighestFreq'));
		// output(f_ssns_final,named('f_ssns_final'));
		return results_rolled;
	end;
	Export appendSSN (dataset(layouts.layout_slim) inputSlim, 
										dataset(layouts.CombinedHeaderResultsDoxieLayout) inputRecs,
										dataset(Layouts.common_runtime_config) cfg) := function
		fmtRec_SSN := getSSN(inputSlim, cfg);
		results := join(inputRecs,fmtRec_SSN, left.acctno=right.acctno and left.LNPID=(integer)right.providerid,
																		transform(layouts.CombinedHeaderResultsDoxieLayout,
																							self.SSNs := project(right.childinfo,transform(Layouts.layout_ssn, self.SSN:=left.SSN));
																							self.SSNLookups := right.childinfo;
																							self := left),left outer);
		return results;
	end;
	Export doCheckDeath(dataset(layouts.layout_slim) input) := Function
			deathparams := DeathV2_Services.IParam.GetDeathRestrictions(gm);
			glb_ok := deathparams.isValidGlb();
			byDids := normalize(input,left.dids,transform(Layouts.layout_death_DID,self.acctno := left.acctno;self.ProviderID:=left.ProviderID;self.did:=right.did;self.ssn:=if(left.UserSSNFound,left.UserSSN,'');self.freq:=right.freq;self.dob:=if(left.UserDOBFound,left.UserDOB[1..6],'');self.UserSSNFound:=left.UserSSNFound;self:=[]));
			byDids_BestFreq := dedup(sort(byDids,acctno,ProviderID,-freq),acctno,ProviderID);
			deathRecs := join(byDids(SSN<>''),doxie.Key_Death_MasterV2_ssa_Did,
									keyed(left.did = right.l_did)
									and	not DeathV2_Services.Functions.Restricted(right.src, right.glb_flag, glb_ok, deathparams),
									transform(layouts.layout_death_BestHit,
										matchbyDOB := left.dob <> '' and left.dob[1..6]=right.dob8[1..6];
										matchbySSN := left.UserSSNFound and left.SSN = right.ssn;
										keepRecord := map(matchbyDOB or matchbySSN => true,
																		 left.dob <> '' and not matchbyDOB => false,
																		 left.ssn <> '' and not matchbySSN => false,
																		 true);
										self.acctno:=if(keepRecord,left.acctno,skip); self.providerid :=left.providerid;self.death_ind:=true;self.dod:=right.dod8;self.besthit:=if(left.UserSSNFound and left.SSN=right.SSN,true,false)),
									keep(1), limit(0));
			death_BestHit := project(deathRecs(besthit=true),layouts.layout_death);
			//if you don't have the best record based on a match to user input, use the best freq.
			death_NotBestHit := join(byDids_BestFreq,death_BestHit,left.acctno=right.acctno and left.ProviderID= right.ProviderID,left only);
			death_BestFreq := join(death_NotBestHit,doxie.Key_Death_MasterV2_ssa_Did,
									keyed(left.did = right.l_did)
									and	not DeathV2_Services.Functions.Restricted(right.src, right.glb_flag, glb_ok, deathparams),
									transform(layouts.layout_death, 
										matchbyDOB := left.dob <> '' and left.dob[1..6]=right.dob8[1..6];
										matchbySSN := left.UserSSNFound and left.SSN = right.ssn;
										keepRecord := map(matchbyDOB or matchbySSN => true,
																		 left.dob <> '' and not matchbyDOB => false,
																		 left.ssn <> '' and not matchbySSN => false,
																		 true);
										self.acctno:=if(keepRecord,left.acctno,skip); self.providerid :=left.providerid;self.death_ind:=true;self.dod:=right.dod8),
									keep(1), limit(0));
			death_final := sort(death_BestHit+death_BestFreq,acctno,ProviderID);

			// output(input);
			// output(death_final);
		return death_final;
	end;
	Export appendDeath (dataset(layouts.layout_slim) inputSlim, 
											dataset(layouts.CombinedHeaderResultsDoxieLayout) inputRecs) := function
		updateSSN := join(inputRecs,inputSlim,left.acctno=right.acctno and left.lnpid=(integer)right.providerid,
													transform(layouts.layout_slim,self.UserSSNFound:=exists(left.ssns(ssn=right.userSSN));self:=right),
													keep(Constants.MAX_RECS_ON_JOIN), limit(0));
		fmtRec_Death := sort(doCheckDeath(updateSSN),acctno,providerid,-dod);
		results := join(inputRecs,fmtRec_Death, left.acctno=right.acctno and left.lnpid=(integer)right.providerid,
																		transform(layouts.CombinedHeaderResultsDoxieLayout,
																							self.DeathLookup := right.death_ind;
																							self.DateofDeath := right.dod;
																							self := left),left outer);





		// output(inputSlim);
		// output(inputRecs);
		// output(updateSSN);
		return results;
	end;
	//Validation Functions
	EXPORT getNPPESByNPI(dataset(Layouts.NPPES_Layouts.layout_npiid) NPIRec) := FUNCTION
		npi_key := NPPES.Key_NPPES_npi;
		nppes_ids_bynpi := join(NPIRec, npi_key, Keyed(left.npi_id = right.npi),
														transform(recordof(Layouts.NPPES_Layouts.temp_layout), self := right),keep(Constants.MAX_RECS_ON_JOIN), limit(0));
		RETURN nppes_ids_bynpi;
	END;
	
	
	
	export AppendAffiliations(dataset(Healthcare_Header_Services.Layouts.CombinedHeaderResultsDoxieLayout) resultRecs,dataset(Layouts.common_runtime_config) cfg):=function 
	  affiliates:= PROJECT(resultRecs(srcBusinessHeader),TRANSFORM(Healthcare_Affiliations.Layouts.batch_in,
																																	self.acctno:=(integer)left.acctno;
																																	self.entityid:=(string)left.lnpid;
																																	self.EntityIDType :='F';));
	  cfg1:=project(cfg[1],transform(Healthcare_Affiliations.Layouts.RunTimeConfig,
				                           self.maxAddressesPerMatch:=Healthcare_Affiliations.Constants.MaxAddressesPerMatch,self:=[];));
	  rawrecaffialites:=Healthcare_Affiliations.Raw.getRecords(affiliates, cfg1);//Rollup
	  fmtrawrecaffialites := project(rawrecaffialites ,transform(Layouts.layout_newaffiliates,
																																 self.acctno:=(string)left.acctno;
																																 self.providerid:=(integer)left.SourceID;
																																 self.effective := iesp.ECL2ESP.t_DateToString8(left.Effective);
																																 self.Expiration := iesp.ECL2ESP.t_DateToString8(left.Expiration);
																																 self.entityid:=left.id;
																																 self.EntityIDType:=left.idtype;
																																 self.ProviderFull:=left.Practitionername.full;
																																 self.ProviderFirst:=left.Practitionername.first;
																																 self.ProviderLast:=left.Practitionername.last;
																																 self.ProviderSuffix:=left.Practitionername.suffix;
																																 self.ProviderPrefix:=left.Practitionername.prefix;
																																 self.FacilityStreetNumber:=left.address.streetnumber;
																																 self.FacilityStreetPreDirection:=left.address.StreetPreDirection;
																																 self.FacilityStreetName:=left.address.StreetName;
																																 self.FacilityStreetSuffix:=left.address.StreetSuffix;
																																 self.FacilityStreetPostDirection:=left.address.StreetPostDirection;
																																 self.FacilityUnitDesignation:=left.address.UnitDesignation;
																																 self.FacilityUnitNumber:=left.address.UnitNumber;
																																 self.FacilityStreetAddress1:=left.address.StreetAddress1;
																																 self.FacilityStreetAddress2:=left.address.StreetAddress2;
																																 self.FacilityCity:=left.address.City;
																																 self.FacilityState:=left.address.State;
																																 self.FacilityZip5:=left.address.Zip5;
																																 self.FacilityZip4:=left.address.Zip4;
																																 self.FacilityPhone:=left.phone;
																																 self.Facilityfax:=left.fax;
																																// self.Specialty1:=left.Specialties.Specialty;
																																 self:=left;));
						
	  layouts.layout_child_newaffiliates doRollup(Layouts.layout_newaffiliates l, dataset(Layouts.layout_newaffiliates) r) := TRANSFORM
		         SELF.acctno := l.acctno;
		         self.ProviderID :=l.ProviderID;
		         self.childinfo := choosen(r,iesp.constants.HPR.MAX_AFFILIATIONS);//fix to right constant
	  END;
	  results_rolled := rollup(group(sort(fmtrawrecaffialites,acctno,ProviderID),acctno,ProviderID),group,doRollup(left,rows(left)));
    final_affrecs:=Join(resultRecs,results_rolled, left.acctno=(string)right.acctno and 
																								   left.lnpid = (integer)right.ProviderID, 
																								   transform(layouts.CombinedHeaderResultsDoxieLayout,
	                                                           self.newaffiliations := right.childinfo;
										                                         self := left), 
																														 left outer,keep(Constants.MAX_RECS_ON_JOIN), limit(0));//keep and limit
    return final_affrecs;
	end;
end;