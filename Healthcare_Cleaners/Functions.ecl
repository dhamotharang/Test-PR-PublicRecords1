Import Address,HealthCareProvider,STD,BatchServices,Advo_Services,Autokey_batch;
EXPORT Functions := MODULE
	Export getPreName(String inRec):= function
		checkName := STD.Str.Filter(STD.Str.ToUpperCase(inRec[1..10]),Healthcare_Cleaners.Constants.FilterWithSpace);
		firstSpace := STD.Str.Find(checkName, Healthcare_Cleaners.Constants.SpaceVal, 1);
		preName := trim(checkName[1..firstSpace],right);
		hasVal := preName in Healthcare_Cleaners.Constants.nameSet;
		hasDrVal := preName in Healthcare_Cleaners.Constants.drSet;
		moveToPreName :=  if(hasVal,inRec[1..firstSpace],Healthcare_Cleaners.Constants.EmptyVal);
		firstpass := if(hasVal,inRec[firstSpace+1..],inRec);
		doubleCheck :=  trim(firstpass,left,right);
		checkName2 := STD.Str.Filter(STD.Str.ToUpperCase(doubleCheck[1..10]),Healthcare_Cleaners.Constants.FilterWithSpace);
		firstSpace2 := STD.Str.Find(checkName2, Healthcare_Cleaners.Constants.SpaceVal, 1);
		preName2 := trim(checkName2[1..firstSpace2],right);
		hasVal2 := preName2 in Healthcare_Cleaners.Constants.nameSet;
		hasDrVal2 := preName2 in Healthcare_Cleaners.Constants.drSet;
		leaveInWorkString :=  if(hasVal2,doubleCheck[firstSpace2+1..],firstpass);
		Healthcare_Cleaners.Layouts.prenameResult getPreName():=transform
			self.preName := if(hasDrVal,Healthcare_Cleaners.Constants.strDr, moveToPreName);
			self.remainingName := leaveInWorkString;
			self:=[];
		end;
		// output(moveToPreName);
		// output(leaveInWorkString);
		return dataset([getPreName()]);
	End;
	Export buildWorkRec(String rawRec):= function
		raw := trim(rawRec,left,right);
		getTitle := getPreName(raw);
		wrkStr := trim(getTitle[1].remainingName,right);
		clnRaw := if(length(trim(wrkStr,right))=0,rawRec,wrkStr);
		splitPos := (integer)(length(clnRaw)-Healthcare_Cleaners.Constants.masterLength);
		wholeRec := length(clnRaw)<=Healthcare_Cleaners.Constants.masterLength;
		spaceAtSplit := clnRaw[splitPos] = Healthcare_Cleaners.Constants.SpaceVal;
		spaceBeforeSplit := clnRaw[splitPos-1] = Healthcare_Cleaners.Constants.SpaceVal and splitPos>1;
		spaceAfterSplit := clnRaw[splitPos+1] = Healthcare_Cleaners.Constants.SpaceVal and splitPos<length(clnRaw);
		Healthcare_Cleaners.Layouts.workRec getRec():=transform
			self.rawInput := rawRec;
			self.preName := getTitle[1].preName;
			self.hasPreName := getTitle[1].preName<>Healthcare_Cleaners.Constants.EmptyVal;
			self.namePart := clnRaw[1..splitPos];
			self.namePartAddSpace := spaceAtSplit or spaceAfterSplit;
			self.namePartEqualsWorkstring := wholeRec;
			self.workstring := if(wholeRec,clnRaw,clnRaw[splitPos+1..]);
			self.profSuffix := Healthcare_Cleaners.Constants.EmptyVal;
			self:=[]
		end;
		// output(raw,named('raw'));
		// output(clnRaw,named('clnRaw'));
		// output(splitPos,named('splitpos'));
		// output(spaceAtSplit,named('spaceAtSplit'));
		// output(spaceBeforeSplit,named('spaceBeforeSplit'));
		// output(spaceAfterSplit,named('spaceAfterSplit'));
		// output(spaceAtSplit or spaceBeforeSplit or spaceAfterSplit,named('splitvalflag'));
		return dataset([getRec()]);
	End;
	Export getLostTerm(String rawRec, String cleanRec):= function
		//Tokenize clean input so each token can be removed from rawRec
		rawWords := dataset(STD.Str.SplitWords(rawRec,Healthcare_Cleaners.Constants.SpaceVal),Healthcare_Cleaners.Layouts.splitRec);
		clnWords := dataset(STD.Str.SplitWords(cleanRec,Healthcare_Cleaners.Constants.SpaceVal),Healthcare_Cleaners.Layouts.splitRec);
		missing := join(rawWords(word<>Healthcare_Cleaners.Constants.SpaceVal), clnWords,left.word=right.word,transform(Healthcare_Cleaners.Layouts.splitRec, self:=left),left only);
		// output(rawWords,named('rawWords'));
		// output(clnWords,named('clnWords'));
		// output(missing,named('missing'));
		return missing[1].word;
	End;
	Export getRepeatedPeriods(Healthcare_Cleaners.Layouts.workRec inRec):= function
		wrkstr := trim(inRec.workstring,right,left);
		cntPeriods1 := if(inRec.namePartEqualsWorkstring,0,STD.Str.FindCount(wrkstr[1..10],Healthcare_Cleaners.Constants.PeriodVal));
		cntPeriods2 := STD.Str.FindCount(wrkstr[11..],Healthcare_Cleaners.Constants.PeriodVal);
		repeatingPeriods := cntPeriods1+cntPeriods2>1;
		startPeriod :=  STD.Str.Find(inRec.workstring,Healthcare_Cleaners.Constants.PeriodVal,if(repeatingPeriods and cntPeriods2>cntPeriods1,2,1));
		startPeriodLoc :=  map(repeatingPeriods and startPeriod>2 => startPeriod-2,
														repeatingPeriods => startPeriod, 0);
		findSpaceBefore := STD.Str.Find(inRec.workstring[1..startPeriodLoc],Healthcare_Cleaners.Constants.SpaceVal,STD.Str.FindCount(inRec.workstring[1..startPeriodLoc],Healthcare_Cleaners.Constants.SpaceVal));
		moveToProflic :=  inRec.workstring[findSpaceBefore..];
		leaveInWorkString :=  STD.Str.FindReplace(inRec.workstring[1..findSpaceBefore],Healthcare_Cleaners.Constants.CommaVal,Healthcare_Cleaners.Constants.EmptyVal);//Remove Comma's from Prof Lic string
		Healthcare_Cleaners.Layouts.workRec getRecPeriod():=transform
			self.workstring := if(repeatingPeriods,leaveInWorkString,inRec.workstring);
			self.profSuffix := if(repeatingPeriods,moveToProflic,Healthcare_Cleaners.Constants.EmptyVal);
			self:=inRec;
		end;
		// output(startPeriodLoc);
		// output(findSpaceBefore);
		return dataset([getRecPeriod()]);
	End;
	Export getKnownProfSuffixes(Healthcare_Cleaners.Layouts.workRec inRec):= function
		wrkStr := trim(inRec.workstring,left,right);
		removePeriods := STD.Str.FilterOut(wrkStr,Healthcare_Cleaners.Constants.PeriodVal);
		clnPossibleSuffix := STD.Str.FilterOut(removePeriods,Healthcare_Cleaners.Constants.CommaVal);
		possibleSuffix := STD.Str.ToUpperCase(clnPossibleSuffix);
		cleanMedicalTerms := HealthCareProvider.CleanMedicalWords.CleanMedicalName(possibleSuffix);
		foundMedicalTerms := trim(possibleSuffix,left,right)<>trim(cleanMedicalTerms,left,right);
		findLostTermRaw := getLostTerm(possibleSuffix,cleanMedicalTerms);
		findLostTermLen := length(findLostTermRaw);
		findLostTerm := trim(findLostTermRaw,left,right);
		multipleTerms := STD.Str.FindCount(possibleSuffix,findLostTerm);
		findPossibleLocation := STD.Str.Find(possibleSuffix,findLostTerm,multipleTerms);
		isFoundAtEnd := STD.Str.Find(possibleSuffix[findPossibleLocation-3..],trim(findLostTerm,right,left),1)>0;
		findStrippedLocation := map(foundMedicalTerms and isFoundAtEnd => findPossibleLocation,
																foundMedicalTerms => STD.Str.Find(trim(possibleSuffix,right),trim(findLostTerm,right),1)-1,
																1000);
		cntPeriodsBefore := STD.Str.FindCount(wrkStr[1..findStrippedLocation],Healthcare_Cleaners.Constants.PeriodVal);
		cntCommasBefore := STD.Str.FindCount(wrkStr[1..findStrippedLocation],Healthcare_Cleaners.Constants.CommaVal);
		cntCommasTotal := STD.Str.FindCount(wrkStr,Healthcare_Cleaners.Constants.CommaVal);
		//Special case where there are no commas and the last name might be getting interpreted as a professional Suffix
		PossibleLastNameSplit := dataset(STD.Str.SplitWords(wrkStr,Healthcare_Cleaners.Constants.SpaceVal),Healthcare_Cleaners.Layouts.splitRec);
		countPossibleLastSplit := count(PossibleLastNameSplit(word<>Healthcare_Cleaners.Constants.SpaceVal));
		largeMiddleName := length(trim(PossibleLastNameSplit[2].word,left,right))>5 and countPossibleLastSplit = 3;
		FixSuffixesReallyLastNames := trim(findLostTerm,left,right) in Healthcare_Cleaners.Constants.possibleLastNameSet and cntCommasTotal = 0 and countPossibleLastSplit in [2,3] and not largeMiddleName;
		findRealLocation := findStrippedLocation+cntPeriodsBefore+cntCommasBefore;
		MoveToProflic := if(FixSuffixesReallyLastNames,Healthcare_Cleaners.Constants.EmptyVal,wrkStr[findRealLocation..]);
		leaveInWorkString := if(FixSuffixesReallyLastNames,wrkStr,wrkStr[1..findRealLocation-1]);
		Healthcare_Cleaners.Layouts.workRec getRecSuffix():=transform
			srcName := trim(inRec.namepart,right) + if(inRec.namePartAddSpace,Healthcare_Cleaners.Constants.SpaceVal,Healthcare_Cleaners.Constants.EmptyVal);
			profSuffix := STD.Str.ToUpperCase(trim(moveToProflic+inRec.profSuffix,left,right));
			self.namepart := if(foundMedicalTerms,srcName+leaveInWorkString,srcName+wrkStr);
			self.workstring := Healthcare_Cleaners.Constants.EmptyVal;
			self.profSuffix := if(profSuffix[1] in [Healthcare_Cleaners.Constants.CommaVal,Healthcare_Cleaners.Constants.PeriodVal],profSuffix[2..],profSuffix);//Remove period or , if they are the first character.
			self:=inRec;
		end;
		// output(inRec,Named('ProfSuffix_inRec'));
		// output(removePeriods,Named('ProfSuffix_removePeriods'));
		// output(possibleSuffix,Named('ProfSuffix_possibleSuffix'));
		// output(cleanMedicalTerms,Named('cleanMedicalTerms'));
		// output(foundMedicalTerms,Named('foundMedicalTerms'));
		// output(findLostTerm,Named('findLostTerm'));
		// output(findPossibleLocation,Named('ProfSuffix_findPossibleLocation'));
		// output(PossibleLastNameSplit,named('PossibleLastNameSplit'));
		// output(FixSuffixesReallyLastNames,named('FixSuffixesReallyLastNames'));
		// output(isFoundAtEnd,Named('ProfSuffix_isFoundAtEnd'));
		// output(findRealLocation,Named('ProfSuffix_findRealLocation'));
		// output(MoveToProflic,Named('ProfSuffix_MoveToProflic'));
		// output(leaveInWorkString,Named('ProfSuffix_leaveInWorkString'));
		return dataset([getRecSuffix()]);
	End;
	Export doTrySomething(Healthcare_Cleaners.Layouts.workRec inRec):= function
		Healthcare_Cleaners.Layouts.splitRec2 cleanit(Healthcare_Cleaners.Layouts.splitRec l, INTEGER c) :=	TRANSFORM
			SELF.loc := c;
			SELF.word := l.word;
			self.hasComma := STD.Str.Find(l.word,Healthcare_Cleaners.Constants.CommaVal,1)>0;
		END;
		//Tokenize clean input so each token can be removed from rawRec
		rawRec := trim(inRec.namepart,left,right);
		rawWords := dataset(STD.Str.SplitWords(rawRec,Healthcare_Cleaners.Constants.SpaceVal),Healthcare_Cleaners.Layouts.splitRec);
		checkRec := project(rawWords,cleanit(left,counter));
		hasComma := exists(checkRec(hasComma=true));
		totalTerms := count(checkRec);
		isLastTermSuffix := STD.Str.ToUpperCase(STD.Str.FilterOut(checkRec[totalTerms].word,Healthcare_Cleaners.Constants.CommaVal)) in Healthcare_Cleaners.Constants.possibleSuffixSet;
		locationOfPostCommaTerm := checkRec(hasComma=true)[1].loc+1;
		beyondMax := locationOfPostCommaTerm>totalTerms;
		countTerms := count(checkRec)-if(isLastTermSuffix or (hasComma and not beyondMax),1,0);
		Address.Layout_Clean_Name_Enclarity getTrySomthing():=transform
			self.name_prefix 	:=Healthcare_Cleaners.Constants.EmptyVal;//[1..15];
			self.fname				:=if(countTerms in [2,3],checkRec[1].word,Healthcare_Cleaners.Constants.EmptyVal);//[16..65];
			self.mname				:=if(countTerms in [3],checkRec[2].word,Healthcare_Cleaners.Constants.EmptyVal);//[66..115];
			self.lname				:=map(countTerms = 2 => STD.Str.FilterOut(checkRec[2].word,Healthcare_Cleaners.Constants.CommaVal),
															countTerms = 3 => STD.Str.FilterOut(checkRec[3].word,Healthcare_Cleaners.Constants.CommaVal),
															STD.Str.FilterOut(inRec.namepart,Healthcare_Cleaners.Constants.CommaVal));//[116..165];
			self.name_prof		:=if(hasComma,STD.Str.FilterOut(checkRec[locationOfPostCommaTerm].word,Healthcare_Cleaners.Constants.CommaVal),Healthcare_Cleaners.Constants.EmptyVal);//[166..180];
			self.name_suffix	:=if(isLastTermSuffix,STD.Str.FilterOut(checkRec[locationOfPostCommaTerm-1].word,Healthcare_Cleaners.Constants.CommaVal),Healthcare_Cleaners.Constants.EmptyVal);//[181..195];
			self.name_title		:=Healthcare_Cleaners.Constants.EmptyVal;//[196..210];
			self.name_score		:='99';//[211..215];
			self.name_gender	:='0';//[216];
			self.name_prefered:=Healthcare_Cleaners.Constants.EmptyVal;//[217..266];
		end;
		ds := dataset([getTrySomthing()]);
		// output(rawWords,named('rawWords'));
		// output(checkRec,named('checkRec'));
		// output(locationOfPostCommaTerm,named('locationOfPostCommaTerm'));
		// output(countTerms,named('countTerms'));
		return ds;
	End;
	Export doNameClean(Healthcare_Cleaners.Layouts.rawNameInput inRec):= function
		outRec := Healthcare_Cleaners.Layouts.cleanNameOutput;
		strParsedName := Trim(trim(inRec.namePrefix,left,right)+Healthcare_Cleaners.Constants.SpaceVal+
													 trim(inRec.nameFirst,left,right)+Healthcare_Cleaners.Constants.SpaceVal+
													 trim(inRec.nameMiddle,left,right)+Healthcare_Cleaners.Constants.SpaceVal+
													 trim(inRec.nameLast,left,right)+Healthcare_Cleaners.Constants.SpaceVal+
													 trim(inRec.nameSuffix,left,right)+Healthcare_Cleaners.Constants.SpaceVal+
													 trim(inRec.nameProfessionalSuffix,left,right),left,right);
		Healthcare_Cleaners.Layouts.splitRec2 cleanBus(Healthcare_Cleaners.Layouts.splitRec l, INTEGER c) :=	TRANSFORM
			SELF.loc := c;
			SELF.word := STD.Str.FindReplace(l.word,Healthcare_Cleaners.Constants.PeriodVal,Healthcare_Cleaners.Constants.EmptyVal);
			SELF.origword := l.word;
			self.hasComma := false;
		END;
		Healthcare_Cleaners.Layouts.splitRec2 reassemble(Healthcare_Cleaners.Layouts.splitRec2 l,Healthcare_Cleaners.Layouts.splitRec2 r) :=	TRANSFORM
			SELF.origword := l.origword+ ' '+r.origword;
			self := r;
		END;
		worknameRaw := if(inRec.nameFull <> Healthcare_Cleaners.Constants.EmptyVal,trim(inRec.nameFull,left,right)+Healthcare_Cleaners.Constants.SpaceVal+trim(inRec.nameProfessionalSuffix,left,right),strParsedName);
		PossibleBusNameSplit := project(dataset(STD.Str.SplitWords(worknameRaw,Healthcare_Cleaners.Constants.SpaceVal),Healthcare_Cleaners.Layouts.splitRec)(word<>Healthcare_Cleaners.Constants.EmptyVal),cleanBus(left,counter));
		removeBusTerms := join(PossibleBusNameSplit,Healthcare_Cleaners.Constants.BusinessWordsDS,STD.Str.ToUpperCase(left.word)=STD.Str.ToUpperCase(right.word),left only);
		rebuildString := iterate(sort(removeBusTerms,loc),reassemble(left,right));
		workname := sort(rebuildString,-loc)[1].origword;
		workRec := buildWorkRec(workname);
		workRecHandleRepeatingPeriods := getRepeatedPeriods(workRec[1]);
		workRecHandleKnownProfSuffixes := getKnownProfSuffixes(workRecHandleRepeatingPeriods[1]);
		KnownPreName := workRecHandleKnownProfSuffixes[1].hasPreName;
		PossiblebadParseSplit := dataset(STD.Str.SplitWords(trim(workRecHandleKnownProfSuffixes[1].namepart,right),Healthcare_Cleaners.Constants.SpaceVal),Healthcare_Cleaners.Layouts.splitRec);
		badParse := count(PossiblebadParseSplit)=1;
		name2Clean := if(badParse,workRecHandleKnownProfSuffixes[1].rawInput,workRecHandleKnownProfSuffixes[1].namepart);
		DrInStringLoc := STD.Str.Find(STD.Str.ToUpperCase(name2Clean), Healthcare_Cleaners.Constants.strFullDr, 1);
		DrInStringClean := name2Clean[1..DrInStringLoc-1]+name2clean[DrInStringLoc+6..];
		name2cleanFinal := if(DrInStringLoc>0 and length(trim(DrInStringClean,left,right))>10,DrInStringClean,name2Clean);
		cleanedRaw := map(inRec.isLFM => Address.CleanPersonLFMEnclarityParse(name2cleanFinal).CleanNameRecord,
										 Address.CleanPersonFMLEnclarityParse(name2cleanFinal).CleanNameRecord);
		OverRideReclean := length(trim(STD.Str.Filter(STD.Str.ToUpperCase(cleanedRaw.lname),Healthcare_Cleaners.Constants.FilterWithSpace),left,right))=1 or (DrInStringLoc>3 and length(trim(DrInStringClean,left,right))>10);//If we clean to a last name with a single character it is probably wrong. Reclean using lfm
		reclean := Address.CleanPersonLFMEnclarityParse(name2cleanFinal).CleanNameRecord;
		rawcleaned := if(OverRideReclean,reclean,cleanedRaw); 
		//Special case where there are no commas and the last name might be getting interpreted as a professional Suffix
		cntCommasTotal := STD.Str.FindCount(inRec.nameFull,Healthcare_Cleaners.Constants.CommaVal);
		PossibleLastNameSplit := dataset(STD.Str.SplitWords(trim(inRec.nameFull,left,right),Healthcare_Cleaners.Constants.SpaceVal),Healthcare_Cleaners.Layouts.splitRec);
		PossibleBadNameSplit := dataset(STD.Str.SplitWords(trim(name2Clean,left,right),Healthcare_Cleaners.Constants.SpaceVal),Healthcare_Cleaners.Layouts.splitRec);
		FixSuffixesReallyLastNames := trim(rawcleaned.name_prof,left,right) in Healthcare_Cleaners.Constants.possibleLastNameSet and cntCommasTotal = 0 and count(PossibleLastNameSplit(word<>Healthcare_Cleaners.Constants.SpaceVal)) in [2,3];
		DualLastNameSplit := dataset(STD.Str.SplitWords(trim(rawcleaned.lname,left,right),Healthcare_Cleaners.Constants.SpaceVal),Healthcare_Cleaners.Layouts.splitRec);
		MultiPartLastName := Count(DualLastNameSplit)=2 and length(DualLastNameSplit[1].word)>3 and count(PossibleLastNameSplit) in [0,3];
		badClean := (rawcleaned.fname = Healthcare_Cleaners.Constants.EmptyVal and rawcleaned.mname = Healthcare_Cleaners.Constants.EmptyVal and rawcleaned.lname = Healthcare_Cleaners.Constants.EmptyVal) or
								(rawcleaned.fname = Healthcare_Cleaners.Constants.EmptyVal and rawcleaned.name_prefix <> Healthcare_Cleaners.Constants.EmptyVal) or 
								(rawcleaned.lname = Healthcare_Cleaners.Constants.EmptyVal and rawcleaned.name_title <> Healthcare_Cleaners.Constants.EmptyVal) or
								(OverRideReclean and length(trim(STD.Str.FilterOut(rawcleaned.fname,Healthcare_Cleaners.Constants.PeriodVal),left,right))=1) or 
								(STD.Str.ToUpperCase(rawcleaned.name_prof) in Healthcare_Cleaners.Constants.possibleLastNameProfSuffixSet and count(PossibleBadNameSplit)>1) or
								(rawcleaned.lname = Healthcare_Cleaners.Constants.EmptyVal and count(PossibleBadNameSplit)=1) or 
								FixSuffixesReallyLastNames or MultiPartLastName;
		// output(rawcleaned.lname = Healthcare_Cleaners.Constants.EmptyVal);
		// output(PossibleBadNameSplit);
		// output(count(PossibleBadNameSplit));
		secondTryClean := doTrySomething(workRecHandleKnownProfSuffixes[1]);
		cleaned := if(badClean,secondTryClean[1],rawcleaned); 
		hasOddFirstName := STD.Str.ToUpperCase(inRec.nameFull[1..4]) in Healthcare_Cleaners.Constants.oddFirstNamesSet;
		outRec setResults():=transform
			self.acctno := inRec.acctno;
			self.rawNameFull := inRec.nameFull;
			self.rawIsLFM := inRec.isLFM;
			self.rawNamePrefix := inRec.namePrefix;
			self.rawNameFirst := inRec.nameFirst;
			self.rawNameMiddle := inRec.nameMiddle;
			self.rawNameLast := inRec.nameLast;
			self.rawNameSuffix := inRec.nameSuffix;
			self.rawNameProfessionalSuffix := inRec.nameProfessionalSuffix;
			self.name_prefix :=	 map(DrInStringLoc>0 and length(trim(DrInStringClean,left,right))>10 => Healthcare_Cleaners.Constants.strDr,
																KnownPreName and workRecHandleKnownProfSuffixes[1].preName <> Healthcare_Cleaners.Constants.EmptyVal => workRecHandleKnownProfSuffixes[1].preName,
																inRec.namePrefix<>Healthcare_Cleaners.Constants.EmptyVal or KnownPreName => cleaned.name_prefix,
																Healthcare_Cleaners.Constants.EmptyVal);//Only return prename if one is supplied
			self.fname :=	if(hasOddFirstName,inRec.nameFull[1..4]+cleaned.fname,cleaned.fname);
			self.mname :=	cleaned.mname;
			self.lname :=	cleaned.lname;
			self.name_prof :=	STD.Str.ToUpperCase(map(badParse => STD.Str.FilterOut(trim(cleaned.name_prof,left,right),Healthcare_Cleaners.Constants.PeriodVal),
														cleaned.name_prof<>Healthcare_Cleaners.Constants.EmptyVal => STD.Str.FilterOut(trim(cleaned.name_prof,left,right),Healthcare_Cleaners.Constants.PeriodVal)+Healthcare_Cleaners.Constants.SpaceVal+trim(workRecHandleKnownProfSuffixes[1].profSuffix,left,right),
														trim(workRecHandleKnownProfSuffixes[1].profSuffix,left,right)));
			self.name_suffix :=	cleaned.name_suffix;
			self.name_title :=	cleaned.name_title;
			self.name_score :=	cleaned.name_score;
			self.name_gender :=	cleaned.name_gender;
			self.name_prefered :=	if(cleaned.name_prefered<>Healthcare_Cleaners.Constants.EmptyVal,cleaned.name_prefered,cleaned.fname);//If different use different, otherwise use first
			self:=[]
		end;
		// output(worknameRaw,named('worknameRaw'));
		// output(PossibleBusNameSplit,named('PossibleBusNameSplit'));
		// output(removeBusTerms,named('removeBusTerms'));
		// output(rebuildString,named('rebuildString'));
		// output(workname,named('Workname'));
		// output(workRec,named('workRec'));
		// output(workRecHandleRepeatingPeriods,named('workRecHandleRepeatingPeriods'));
		// output(workRecHandleKnownProfSuffixes,named('workRecHandleKnownProfSuffixes'));
		// output(name2Clean,named('name2Clean'));
		// output(DrInStringLoc,named('DrInStringLoc'));
		// output(DrInStringClean,named('DrInStringClean'));
		// output(cleanedRaw,named('cleanedRaw'));
		// output(OverRideReclean,named('OverRideReclean'));
		// output(reclean,named('reclean'));
		// output(badClean,named('badClean'));
		// output(secondTryClean,named('secondTryClean'));
		// output(badParse,named('PossiblebadParseSplit'));
		ds:=dataset([setResults()]);
		return ds;
	end;
	Export appendHRI(String s1, String s2):= function
		return  trim(s1,left,right)+'|'+s2;
	end;
	Export getHRIData(String s1, String s2, String s3, String s4, String s5):= function
		r1 := s1;
		r2 := appendHRI(r1,s2);
		r3 := appendHRI(r2,s3);
		r4 := appendHRI(r3,s4);
		r5 := appendHRI(r4,s5);
		return trim(r5,left,right);
	end;
	Export doAddressClean(Healthcare_Cleaners.Layouts.rawAddressInput inRec, boolean IncludeHRI = false, boolean IncludeFlags = false):= function
		outRec := Healthcare_Cleaners.Layouts.cleanAddressOutput;
		strParsedAddr := Trim(trim(inRec.prim_range,left,right)+' '+
										 trim(inRec.predir,left,right)+' '+
										 trim(inRec.prim_name,left,right)+' '+
										 trim(inRec.addr_suffix,left,right)+' '+
										 trim(inRec.postdir,left,right)+' '+
										 trim(inRec.unit_desig,left,right)+' '+
										 trim(inRec.sec_range,left,right),left,right);
		strCityStateZip := Trim(trim(inRec.p_city_name,left,right)+' '+
										 trim(inRec.st,left,right)+' '+
										 trim(inRec.z5,left,right),left,right);
		addrLine2 := if(inRec.addressLine2 <> '',inRec.addressLine2,strCityStateZip);
		cleaned := map(inRec.addressLine1 <> '' => Address.CleanAddressEnclarityParsed(inRec.addressLine1,addrLine2).CleanAddressRecord,
												Address.CleanAddressEnclarityParsed(strParsedAddr,addrLine2).CleanAddressRecord);
		//IncludeHRI
		// test case 18201 SW 12th Street
		// Miami, FL 33194
		Autokey_batch.Layouts.rec_inBatchMaster setHRIinput():=transform
			self.prim_range:=STD.Str.ToUpperCase(Cleaned.prim_range);
			self.predir:=STD.Str.ToUpperCase(Cleaned.predir);
			self.prim_name:=STD.Str.ToUpperCase(Cleaned.prim_name);
			self.addr_suffix:=STD.Str.ToUpperCase(Cleaned.addr_suffix);
			self.postdir:=STD.Str.ToUpperCase(Cleaned.postdir);
			self.unit_desig:=STD.Str.ToUpperCase(Cleaned.unit_desig);
			self.sec_range:=STD.Str.ToUpperCase(Cleaned.sec_range);
			self.p_city_name:=STD.Str.ToUpperCase(Cleaned.p_city_name);
			self.st:=STD.Str.ToUpperCase(Cleaned.st);
			self.z5:=Cleaned.zip;
			self.zip4:=Cleaned.zip4;
			self:=[];
		end;
		ds_HRI:=dataset([setHRIinput()]);
		HRI := BatchServices.HRI_Address_Records(ds_HRI);
		//IncludeFlags
		Advo_services.Advo_Batch_Service_Layouts.Batch_In setAdvoinput():=transform
			self.acctno:=inRec.acctno;
			self.addr:=inRec.addressLine1;
			self.city:=inRec.p_city_name;
			self.state:=inRec.st;
			self.zip:=inRec.z5;
			self:=[]
		end;
		ds_advo:=dataset([setAdvoinput()]);
		advo := Advo_Services.Advo_Batch_Service_Records(ds_advo,true,true)[1];

		outRec setResults():=transform
			self.acctno := inRec.acctno;
			self.rawAddressLine1 := inRec.addressLine1;
			self.rawAddressLine2 := inRec.addressLine2;
			self.rawPrim_range := inRec.prim_range;
			self.rawPredir := inRec.predir;
			self.rawPrim_name := inRec.prim_name;
			self.rawAddr_suffix := inRec.addr_suffix;
			self.rawPostdir := inRec.postdir;
			self.rawUnit_desig := inRec.unit_desig;
			self.rawSec_range := inRec.sec_range;
			self.rawP_city_name := inRec.p_city_name;
			self.rawSt := inRec.st;
			self.rawZ5 := inRec.z5;
			self.err_type := cleaned.err_stat[1];
			self.err_code := if(cleaned.err_stat[1] = 'E',cleaned.err_stat[2..],'');
			self.warn_code := if(cleaned.err_stat[1] <> 'E',cleaned.err_stat[2..],'');
			self.cleanfailure := cleaned.err_stat='';
			self.sic_code := if(IncludeHRI,getHRIData(HRI[1].sic_code,HRI[2].sic_code,HRI[3].sic_code,HRI[4].sic_code,HRI[5].sic_code),'');        
			self.sic_code_desc := if(IncludeHRI,getHRIData(HRI[1].sic_code_desc,HRI[2].sic_code_desc,HRI[3].sic_code_desc,HRI[4].sic_code_desc,HRI[5].sic_code_desc),'');           
			self.addr_fraud_alert_flag := if(IncludeHRI,getHRIData(HRI[1].addr_fraud_alert_flag,HRI[2].addr_fraud_alert_flag,HRI[3].addr_fraud_alert_flag,HRI[4].addr_fraud_alert_flag,HRI[5].addr_fraud_alert_flag),'');      
			self.addr_fraud_alert_description := IF(IncludeHRI,getHRIData(HRI[1].addr_fraud_alert_description,HRI[2].addr_fraud_alert_description,HRI[3].addr_fraud_alert_description,HRI[4].addr_fraud_alert_description,HRI[5].addr_fraud_alert_description),'');
			self.correctionalfacility := if(IncludeHRI,exists(HRI(sic_code[1..4] = '9223')),false);
			self.msa:=advo.msa;
			self.cbsa := Healthcare_Cleaners.FIPS2CBSA.getCBSA(advo.fips_county+advo.county);
			self.Route_Num := if(IncludeFlags,advo.Route_Num,'');
			self.Walk_Sequence	:=if(IncludeFlags,advo.Walk_Sequence,'');
			self.Address_Vacancy_Indicator	:=if(IncludeFlags,advo.Address_Vacancy_Indicator,'');
			self.Throw_Back_Indicator :=if(IncludeFlags,advo.Throw_Back_Indicator,'');
			self.Seasonal_Delivery_Indicator :=if(IncludeFlags,advo.Seasonal_Delivery_Indicator,'');
			self.Seasonal_Start_Suppression_Date :=if(IncludeFlags,advo.Seasonal_Start_Suppression_Date,'');
			self.Seasonal_End_Suppression_Date :=if(IncludeFlags,advo.Seasonal_End_Suppression_Date,'');
			self.DND_Indicator :=if(IncludeFlags,advo.DND_Indicator,'');
			self.College_Indicator :=if(IncludeFlags,advo.College_Indicator,'');
			self.College_Start_Suppression_Date :=if(IncludeFlags,advo.College_Start_Suppression_Date,'');
			self.College_End_Suppression_Date :=if(IncludeFlags,advo.College_End_Suppression_Date,'');
			self.Address_Style_Flag :=if(IncludeFlags,advo.Address_Style_Flag,'');
			self.Simplify_Address_Count :=if(IncludeFlags,advo.Simplify_Address_Count,'');
			self.Drop_Indicator :=if(IncludeFlags,advo.Drop_Indicator,'');
			self.Residential_or_Business_Ind :=if(IncludeFlags,advo.Residential_or_Business_Ind,'');
			self.County_Num :=if(IncludeFlags,advo.County_Num,'');
			self.County_Name :=if(IncludeFlags,advo.County_Name,'');
			self.Congressional_District_Number :=if(IncludeFlags,advo.Congressional_District_Number,'');
			self.OWGM_Indicator :=if(IncludeFlags,advo.OWGM_Indicator,'');
			self.Record_Type_Code :=if(IncludeFlags,advo.Record_Type_Code,'');
			self.Address_Type :=if(IncludeFlags,advo.Address_Type,'');
			self.Mixed_Address_Usage :=if(IncludeFlags,advo.Mixed_Address_Usage,'');
			self.Vac_BegDT :=if(IncludeFlags,advo.Vac_BegDT,'');
			self.Vac_EndDT :=if(IncludeFlags,advo.Vac_EndDT,'');
			self.Months_Vac_Curr :=if(IncludeFlags,advo.Months_Vac_Curr,'');
			self.Months_Vac_Max :=if(IncludeFlags,advo.Months_Vac_Max,'');                
			self.Vac_Count :=if(IncludeFlags,advo.Vac_Count,'');
			self := cleaned;
			self:=[];
		end;
		ds:=dataset([setResults()]);
		return ds;
	end;
End;