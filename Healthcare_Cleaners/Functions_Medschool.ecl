import std,Healthcare_Cleaners,Medschool_standardization;
EXPORT Functions_Medschool := module

unsigned CampusBonus := 50;
unsigned BeginsWithBonus := 60;
unsigned InternationalBonus := 30;
unsigned RegionBonus := 15;
unsigned ScoreBonus := 15;
unsigned ScoreBonusThreshold := 30;
unsigned StrongWordBonus := 2;
unsigned PracStateBonus := 15;

tmpLayout := record
	Medschool_standardization.layouts.layoutmedicalschoolword1;
	string20 beginswith :='';
	string20 inputval :='';
	string20 state :='';
	boolean	SchoolTypeConflict := false;
	boolean	StateConflict := false;
end;

Medschool_standardization.layouts.layoutMedicalSchoolWord1 FinalRollup (tmpLayout rslt, dataset(tmpLayout) allrows,unsigned parsedCnt, string inPracStateBonus) := transform
				schoolTypeConflict := exists(allrows(SchoolTypeConflict=true));
				StateConflict := exists(allrows(StateConflict=True and State<>''));
				cntMatch := count(allrows(region=false and campus=false));
				cntAll := count(allrows);
				cntOtherMatch := count(allrows(region=true or campus=true));
				cntTotal := cntAll-cntOtherMatch;
				isInternationalRec := exists(allrows(length(trim(state,right))>2));
				NonMedicalSchool := rslt.msid > Healthcare_Cleaners.Constants.NonMedicalSchool;
				MedicalSchool := rslt.msid < Healthcare_Cleaners.Constants.NonMedicalSchool;
				CampusData := allrows(campus=true and STD.Str.ToUppercase(words) not in ['COLLEGE','UNIVERSITY','LOS','NEW','SAN','CITY','MOUNT','EAST','ST','SAINT','AM','YORK']);
				CampusMatch := exists(CampusData) and parsedCnt>=3;//Is there a matching word to a campus name
				CampusMatchMediumConfidence := exists(CampusData) and exists(CampusData(Score between 2 and 5));
				CampusMatchHighConfidence := exists(CampusData) and exists(CampusData(Score>5));
				RegionMatch := exists(allrows(region=true and words in Healthcare_Cleaners.Constants.stateList));//Is there a matching word to a regional identifier that is a State
				RegionMatchInternational := exists(allrows(region=true and words not in Healthcare_Cleaners.Constants.stateList)) or (isInternationalRec and CampusMatch);//Is there a matching word to a regional identifier that is a country
				BeginLength := length(trim(allrows(inputval<>'')[1].inputval,left,right));
				BeginsWithLength := if(BeginLength>=16,BeginLength,20);
				BeginsWith := dedup(sort(allrows(beginswith[1..BeginLength]=inputval[1..BeginLength] and MedicalSchool and STD.Str.ToUppercase(inputval) <> 'MEDICAL COLLEGE OF '),msid),msid);
				BeginsWithNon := dedup(sort(allrows(beginswith[1..BeginLength]=inputval[1..BeginLength] and NonMedicalSchool),msid),msid);
				BeginsWithMatch := (exists(BeginsWith) or exists(BeginsWithNon)) and not schoolTypeConflict;
				percentMatch := (cntMatch/cntTotal)*100;//Percentage of words that are matching
				theScore := sum(dedup(sort(allrows(words<>'AT'),words),words),score);//Specificity score of the matching terms
				strongWordMatch := exists(allrows(score>=10 and not words in ['DENTISTRY','MEDICINE','CHIROPRACTIC','PSYCHOLOGY','OPTOMETRY','PODIATRIC','OSTEOPATHIC']));//Is there a high level of specificity in one or more of the words
				strongWordMatchNonMedical := exists(allrows(score>10));//Is there a high level of specificity in one or more of the words
				slimMatch := map(NonMedicalSchool and cntMatch < 4 and not strongWordMatchNonMedical => true,
												 MedicalSchool and cntMatch < 4 and not strongWordMatch => true,
												 false);//If we matches on at least three words and none are highly spcific this is a slim match adjust the percentMatch
				PracStateMatch := exists(allrows(state <> '' and state=inPracStateBonus));
				PracStateBonusAddon := if(PracStateMatch,PracStateBonus,0);
				CampusAddon := map(CampusMatch and CampusMatchHighConfidence => CampusBonus,
													 CampusMatch and CampusMatchMediumConfidence => CampusBonus-10,
													 CampusMatch =>	CampusBonus-20,0);//You matches on a campus name that is pretty much a sure thing 
				BeginsWithAddon := map(isInternationalRec and BeginsWithMatch => BeginsWithBonus*.5,
															 BeginsWithMatch and (count(beginswith) = 1 or count(BeginsWithNon) = 1)  => BeginsWithBonus,
															 BeginsWithMatch and (count(beginswith) between 2 and 4 or count(BeginsWithNon) between 2 and 4) => BeginsWithBonus*.5,
															 BeginsWithMatch and (count(beginswith) > 4 or count(BeginsWithNon) > 4) => BeginsWithBonus*.1,
															 0); //You matched the first 20 characters of a school that is pretty good
				InternationalAddon := if(RegionMatchInternational,InternationalBonus,0); //You matched the country name in the name of the school most countrys ony have a few entries
				RegionAddon := if(RegionMatch,RegionBonus,0); //You matched the state in the name
				ScoreAddon := if(theScore >= ScoreBonusThreshold,ScoreBonus,0); //You had a very high score pump up the confidence
				adjustedMatch:= map(schoolTypeConflict => percentMatch*.4,//Make the score a slight bit higher to give preference to medical schools versus regular universities
														StateConflict => percentMatch*.5,//Make the score a slight bit higher to give preference to medical schools versus regular universities
														MedicalSchool and slimMatch and percentMatch > 60 and theScore < 25 => percentMatch*.501,//Make the score a slight bit higher to give preference to medical schools versus regular universities
														NonMedicalSchool and strongWordMatch and percentMatch >= 50 and theScore >= 25 => percentMatch*1.05,
														NonMedicalSchool and slimMatch and percentMatch > 60 and theScore < 25 => percentMatch*.5,
														percentMatch);//Eventhough you might have a high match percentage, if it is only on a very few word that are not very specific not really a good match
				compositeScore := adjustedMatch+CampusAddon+BeginsWithAddon+InternationalAddon+RegionAddon+ScoreAddon+PracStateBonusAddon+if(strongWordMatchNonMedical,1,0)+if(strongWordMatch,StrongWordBonus,0);//Add a Strong word match as it means it is likely university name match
				scoreFlags := ('P'+(string)adjustedMatch)[1..6]+
											if(CampusMatch,'C'+(string)CampusAddon,'')+
											if(BeginsWithMatch,'B'+(string)BeginsWithAddon,'')+
											if(RegionMatchInternational,'I'+(string)InternationalAddon,'')+
											if(RegionMatch,'R'+(string)RegionAddon,'')+
											if(theScore >= ScoreBonusThreshold,'S'+(string)ScoreAddon,'')+
											if(PracStateMatch,'PS'+(string)PracStateBonusAddon,'')+
											map(NonMedicalSchool and strongWordMatchNonMedical =>'SW',
													MedicalSchool and strongWordMatch => 'SW'+(string)StrongWordBonus,'')+
											if(slimMatch,'SM','')+if(schoolTypeConflict,'X','')+if(StateConflict,'Z','');
				self.MSID:=rslt.msid;
				self.words:=rslt.words;
				self.WordCountMatch := cntMatch;
				self.WordCountTotal := cntTotal;
				self.ConfidenceScore := map(compositeScore >100 and (BeginsWithMatch or RegionMatchInternational) => 100,
																		compositeScore >99 => 99,
																		compositeScore);
				self.Score:=theScore;
				self.ConfidenceScoreFlags := trim(scoreFlags,all);
	 end;

standardizeState(string inStr) := FUNCTION
	strR1  := STD.Str.FindReplace(inStr ,' AL ',' Alabama ');
	strR2  := STD.Str.FindReplace(StrR1 ,' AK ',' Alaska '); 
	strR3  := STD.Str.FindReplace(StrR2 ,' AR ',' Arkansas '); 
	strR4  := STD.Str.FindReplace(StrR3 ,' AS ',' American Samoa '); 
	strR5  := STD.Str.FindReplace(StrR4 ,' AZ ',' Arizona '); 
	strR6  := STD.Str.FindReplace(StrR5 ,' CA ',' California '); 
	strR7  := STD.Str.FindReplace(StrR6 ,' CO ',' Colorado '); 
	strR8  := STD.Str.FindReplace(StrR7 ,' CT ',' Connecticut '); 
	strR9  := STD.Str.FindReplace(StrR8 ,' DC ',' District of Columbia '); 
	strR10 := STD.Str.FindReplace(StrR9 ,' DE ',' Delaware '); 
	strR11 := STD.Str.FindReplace(StrR10,' FL ',' Florida '); 
	strR12 := STD.Str.FindReplace(StrR11,' GA ',' Georgia '); 
	strR13 := STD.Str.FindReplace(StrR12,' GU ',' Guam '); 
	strR14 := STD.Str.FindReplace(StrR13,' HI ',' Hawaii '); 
	strR15 := STD.Str.FindReplace(StrR14,' IA ',' Iowa '); 
	strR16 := STD.Str.FindReplace(StrR15,' ID ',' Idaho '); 
	strR17 := STD.Str.FindReplace(StrR16,' IL ',' Illinois '); 
	strR18 := STD.Str.FindReplace(StrR17,' IN ',' Indiana '); 
	strR19 := STD.Str.FindReplace(StrR18,' KS ',' Kansas '); 
	strR20 := STD.Str.FindReplace(StrR19,' KY ',' Kentucky '); 
	strR21 := STD.Str.FindReplace(StrR20,' LA ',' Louisiana '); 
	strR22 := STD.Str.FindReplace(StrR21,' MA ',' Massachusetts '); 
	strR23 := STD.Str.FindReplace(StrR22,' MD ',' Maryland '); 
	strR24 := STD.Str.FindReplace(StrR23,' ME ',' Maine '); 
	strR25 := STD.Str.FindReplace(StrR24,' MI ',' Michigan '); 
	strR26 := STD.Str.FindReplace(StrR25,' MN ',' Minnesota '); 
	strR27 := STD.Str.FindReplace(StrR26,' MO ',' Missouri '); 
	strR28 := STD.Str.FindReplace(StrR27,' MS ',' Mississippi '); 
	strR29 := STD.Str.FindReplace(StrR28,' MT ',' Montana '); 
	strR30 := STD.Str.FindReplace(StrR29,' NC ',' North Carolina '); 
	strR31 := STD.Str.FindReplace(StrR30,' ND ',' North Dakota '); 
	strR32 := STD.Str.FindReplace(StrR31,' NE ',' Nebraska '); 
	strR33 := STD.Str.FindReplace(StrR32,' NH ',' New Hampshire '); 
	strR34 := STD.Str.FindReplace(StrR33,' NJ ',' New Jersey '); 
	strR35 := STD.Str.FindReplace(StrR34,' NM ',' New Mexico '); 
	strR36 := STD.Str.FindReplace(StrR35,' NV ',' Nevada '); 
	strR37 := STD.Str.FindReplace(StrR36,' NY ',' New York '); 
	strR38 := STD.Str.FindReplace(StrR37,' OH ',' Ohio '); 
	strR39 := STD.Str.FindReplace(StrR38,' OK ',' Oklahoma '); 
	strR40 := STD.Str.FindReplace(StrR39,' OR ',' Oregon '); 
	strR41 := STD.Str.FindReplace(StrR40,' PA ',' Pennsylvania '); 
	strR42 := STD.Str.FindReplace(StrR41,' PR ',' Puerto Rico '); 
	strR43 := STD.Str.FindReplace(StrR42,' RI ',' Rhode Island '); 
	strR44 := STD.Str.FindReplace(StrR43,' SC ',' South Carolina '); 
	strR45 := STD.Str.FindReplace(StrR44,' SD ',' South Dakota '); 
	strR46 := STD.Str.FindReplace(StrR45,' TN ',' Tennessee '); 
	strR47 := STD.Str.FindReplace(StrR46,' TX ',' Texas '); 
	strR48 := STD.Str.FindReplace(StrR47,' US ',' United States '); 
	strR49 := STD.Str.FindReplace(StrR48,' UT ',' Utah '); 
	strR50 := STD.Str.FindReplace(StrR49,' VA ',' Virginia '); 
	strR51 := STD.Str.FindReplace(StrR50,' VI ',' Virgin Islands '); 
	strR52 := STD.Str.FindReplace(StrR51,' VT ',' Vermont '); 
	strR53 := STD.Str.FindReplace(StrR52,' WA ',' Washington '); 
	strR54 := STD.Str.FindReplace(StrR53,' WI ',' Wisconsin '); 
	strR55 := STD.Str.FindReplace(StrR54,' WV ',' West Virginia '); 
	strR56 := STD.Str.FindReplace(StrR55,' WY ',' Wyoming ');
	return strR56;
end;

BeginsWithState(string inStr) := FUNCTION
	strR1  := If(inStr[1..3]='AL ','Alabama '+inStr[4..],inStr);
	strR2  := If(StrR1[1..3]='AK ','Alaska '+strR1[4..],strR1); 
	strR3  := If(StrR2[1..3]='AR ','Arkansas '+strR2[4..],strR2); 
	strR4  := If(StrR3[1..3]='AS ','American Samoa '+strR3[4..],strR3); 
	strR5  := If(StrR4[1..3]='AZ ','Arizona '+strR4[4..],strR4); 
	strR6  := If(StrR5[1..3]='CA ','California '+strR5[4..],strR5); 
	strR7  := If(StrR6[1..3]='CO ','Colorado '+strR6[4..],strR6); 
	strR8  := If(StrR7[1..3]='CT ','Connecticut '+strR7[4..],strR7); 
	strR9  := If(StrR8[1..3]='DC ','District of Columbia '+strR8[4..],strR8); 
	strR10 := If(StrR9[1..3]='DE ','Delaware '+strR9[4..],strR9); 
	strR11 := If(StrR10[1..3]='FL ','Florida '+strR10[4..],strR10); 
	strR12 := If(StrR11[1..3]='GA ','Georgia '+strR11[4..],strR11); 
	strR13 := If(StrR12[1..3]='GU ','Guam '+strR12[4..],strR12); 
	strR14 := If(StrR13[1..3]='HI ','Hawaii '+strR13[4..],strR13); 
	strR15 := If(StrR14[1..3]='IA ','Iowa '+strR14[4..],strR14); 
	strR16 := If(StrR15[1..3]='ID ','Idaho '+strR15[4..],strR15); 
	strR17 := If(StrR16[1..3]='IL ','Illinois '+strR16[4..],strR16); 
	strR18 := If(StrR17[1..3]='IN ','Indiana '+strR17[4..],strR17); 
	strR19 := If(StrR18[1..3]='KS ','Kansas '+strR18[4..],strR18); 
	strR20 := If(StrR19[1..3]='KY ','Kentucky '+strR19[4..],strR19); 
	strR21 := If(StrR20[1..3]='LA ','Louisiana '+strR20[4..],strR20); 
	strR22 := If(StrR21[1..3]='MA ','Massachusetts '+strR21[4..],strR21); 
	strR23 := If(StrR22[1..3]='MD ','Maryland '+strR22[4..],strR22); 
	strR24 := If(StrR23[1..3]='ME ','Maine '+strR23[4..],strR23); 
	strR25 := If(StrR24[1..3]='MI ','Michigan '+strR24[4..],strR24); 
	strR26 := If(StrR25[1..3]='MN ','Minnesota '+strR25[4..],strR25); 
	strR27 := If(StrR26[1..3]='MO ','Missouri '+strR26[4..],strR26); 
	strR28 := If(StrR27[1..3]='MS ','Mississippi '+strR27[4..],strR27); 
	strR29 := If(StrR28[1..3]='MT ','Montana '+strR28[4..],strR28); 
	strR30 := If(StrR29[1..3]='NC ','North Carolina '+strR29[4..],strR29); 
	strR31 := If(StrR30[1..3]='ND ','North Dakota '+strR30[4..],strR30); 
	strR32 := If(StrR31[1..3]='NE ','Nebraska '+strR31[4..],strR31); 
	strR33 := If(StrR32[1..3]='NH ','New Hampshire '+strR32[4..],strR32); 
	strR34 := If(StrR33[1..3]='NJ ','New Jersey '+strR33[4..],strR33); 
	strR35 := If(StrR34[1..3]='NM ','New Mexico '+strR34[4..],strR34); 
	strR36 := If(StrR35[1..3]='NV ','Nevada '+strR35[4..],strR35); 
	strR37 := If(StrR36[1..3]='NY ','New York '+strR36[4..],strR36); 
	strR38 := If(StrR37[1..3]='OH ','Ohio '+strR37[4..],strR37); 
	strR39 := If(StrR38[1..3]='OK ','Oklahoma '+strR38[4..],strR38); 
	strR40 := If(StrR39[1..3]='OR ','Oregon '+strR39[4..],strR39); 
	strR41 := If(StrR40[1..3]='PA ','Pennsylvania '+strR40[4..],strR40); 
	strR42 := If(StrR41[1..3]='PR ','Puerto Rico '+strR41[4..],strR41); 
	strR43 := If(StrR42[1..3]='RI ','Rhode Island '+strR42[4..],strR42); 
	strR44 := If(StrR43[1..3]='SC ','South Carolina '+strR43[4..],strR43); 
	strR45 := If(StrR44[1..3]='SD ','South Dakota '+strR44[4..],strR44); 
	strR46 := If(StrR45[1..3]='TN ','Tennessee '+strR45[4..],strR45); 
	strR47 := If(StrR46[1..3]='TX ','Texas '+strR46[4..],strR46); 
	strR48 := If(StrR47[1..3]='US ','United States '+strR47[4..],strR47); 
	strR49 := If(StrR48[1..3]='UT ','Utah '+strR48[4..],strR48); 
	strR50 := If(StrR49[1..3]='VA ','Virginia '+strR49[4..],strR49); 
	strR51 := If(StrR50[1..3]='VI ','Virgin Islands '+strR50[4..],strR50); 
	strR52 := If(StrR51[1..3]='VT ','Vermont '+strR51[4..],strR51); 
	strR53 := If(StrR52[1..3]='WA ','Washington '+strR52[4..],strR52); 
	strR54 := If(StrR53[1..3]='WI ','Wisconsin '+strR53[4..],strR53); 
	strR55 := If(StrR54[1..3]='WV ','West Virginia '+strR54[4..],strR54); 
	strR56 := If(StrR55[1..3]='WY ','Wyoming '+strR55[4..],strR55);
	return strR56;
end;

RemovePunct(string inStr) := FUNCTION
	strR := STD.Str.FindReplace(inStr,'`','');
	strR0 := STD.Str.FindReplace(strR,'.',' ');
	strR1 := STD.Str.FindReplace(strR0,'/',' ');
	strR2 := STD.Str.FindReplace(strR1,'-',' ');
	strR3 := STD.Str.FindReplace(strR2,':',' ');
	strR4 := STD.Str.FindReplace(strR3,',' ,'');
	strR5 := STD.Str.FindReplace(strR4,'(' ,'');
	strR6 := STD.Str.FindReplace(strR5,')' ,'');
	strR7 := STD.Str.FindReplace(strR6,'  ' ,' ');
	return STD.Str.FindReplace(strR7,'  ' ,' ');
end;

findStateInString(string inStr) := FUNCTION
	uString := STD.Str.ToUppercase(inStr);
	return map (STD.Str.Find(uString,'ALABAMA',1)>0 => 'AL',
							STD.Str.Find(uString,'ALASKA',1)>0 => 'AK',
							STD.Str.Find(uString,'ARKANSAS',1)>0 => 'AR',
							STD.Str.Find(uString,'ARIZONA',1)>0 => 'AZ',
							STD.Str.Find(uString,'CALIFORNIA',1)>0 => 'CA',
							STD.Str.Find(uString,'COLORADO',1)>0 => 'CO',
							STD.Str.Find(uString,'CONNECTICUT',1)>0 => 'CT',
							STD.Str.Find(uString,'DELAWARE',1)>0 => 'DE',
							STD.Str.Find(uString,'FLORIDA',1)>0 => 'FL',
							STD.Str.Find(uString,'GEORGIA',1)>0 => 'GA',
							STD.Str.Find(uString,'GUAM',1)>0 => 'GU',
							STD.Str.Find(uString,'HAWAII',1)>0 => 'HI',
							STD.Str.Find(uString,'IOWA',1)>0 => 'IA',
							STD.Str.Find(uString,'IDAHO',1)>0 => 'ID',
							STD.Str.Find(uString,'ILLINOIS',1)>0 => 'IL',
							STD.Str.Find(uString,'INDIANA',1)>0 => 'IN',
							STD.Str.Find(uString,'KANSAS',1)>0 => 'KS',
							STD.Str.Find(uString,'KENTUCKY',1)>0 => 'KY',
							STD.Str.Find(uString,'LOUISIANA',1)>0 => 'LA',
							STD.Str.Find(uString,'MASSACHUSETTS',1)>0 => 'MA',
							STD.Str.Find(uString,'MARYLAND',1)>0 => 'MD',
							STD.Str.Find(uString,'MAINE',1)>0 => 'ME',
							STD.Str.Find(uString,'MICHIGAN',1)>0 => 'MI',
							STD.Str.Find(uString,'MINNESOTA',1)>0 => 'MN',
							STD.Str.Find(uString,'MISSOURI',1)>0 => 'MO',
							STD.Str.Find(uString,'MISSISSIPPI',1)>0 => 'MS',
							STD.Str.Find(uString,'MONTANA',1)>0 => 'MT',
							STD.Str.Find(uString,'NORTH CAROLINA',1)>0 => 'NC',
							STD.Str.Find(uString,'NORTH DAKOTA',1)>0 => 'ND',
							STD.Str.Find(uString,'NEBRASKA',1)>0 => 'NE',
							STD.Str.Find(uString,'NEW HAMPSHIRE',1)>0 => 'NH',
							STD.Str.Find(uString,'NEW JERSEY',1)>0 => 'NJ',
							STD.Str.Find(uString,'NEW MEXICO',1)>0 => 'NM',
							STD.Str.Find(uString,'NEVADA',1)>0 => 'NV',
							STD.Str.Find(uString,'NEW YORK',1)>0 => 'NY',
							STD.Str.Find(uString,'OHIO',1)>0 => 'OH',
							STD.Str.Find(uString,'OKLAHOMA',1)>0 => 'OK',
							STD.Str.Find(uString,'OREGON',1)>0 => 'OR',
							STD.Str.Find(uString,'PENNSYLVANIA',1)>0 => 'PA',
							STD.Str.Find(uString,'PUERTO RICO',1)>0 => 'PR',
							STD.Str.Find(uString,'RHODE ISLAND',1)>0 => 'RI',
							STD.Str.Find(uString,'SOUTH CAROLINA',1)>0 => 'SC',
							STD.Str.Find(uString,'SOUTH DAKOTA',1)>0 => 'SD',
							STD.Str.Find(uString,'TENNESSEE',1)>0 => 'TN',
							STD.Str.Find(uString,'TEXAS',1)>0 => 'TX',
							STD.Str.Find(uString,'UTAH',1)>0 => 'UT',
							STD.Str.Find(uString,'VIRGINIA',1)>0 => 'VA',
							STD.Str.Find(uString,'VIRGIN ISLANDS',1)>0 => 'VI',
							STD.Str.Find(uString,'VERMONT',1)>0 => 'VT',
							STD.Str.Find(uString,'WASHINGTON',1)>0 => 'WA',
							STD.Str.Find(uString,'WISCONSIN',1)>0 => 'WI',
							STD.Str.Find(uString,'WEST VIRGINIA',1)>0 => 'WV',
							STD.Str.Find(uString,'WYOMING',1)>0 => 'WY',
							STD.Str.Find(uString,'UNITED STATES',1)>0 => 'US',
							STD.Str.Find(uString,'DISTRICT OF COLUMBIA',1)>0 => 'DC',
							STD.Str.Find(uString,'AMERICAN SAMOA',1)>0 => 'AS',
							'');
end;

getMedschoolState(string inStr, string inPracStateBonusRaw) := Function
	foundState := findStateInString(inStr);
	newState := if(foundState<>'' and foundState <> inPracStateBonusRaw,foundState, inPracStateBonusRaw);
	return newState;
end;
FindUniversityAt (string inStr) := FUNCTION
		strRaw := STD.Str.ToUppercase(inStr);
		positionAt := STD.Str.Find(strRaw,' AT ',1);
		positionUniv := STD.Str.Find(strRaw,'UNIVERSITY',1);
		hasATBeforeUniv := positionAt < positionUniv and positionAt > 0;
		Refmt := if(hasATBeforeUniv,inStr[positionAt+4..]+' '+ inStr[1..positionAt],inStr);
	return Refmt;
end;

standardizeIt(string inStr) := FUNCTION
	strReplace1 := STD.Str.ToUppercase(RemovePunct(inStr));
	strReplace2 := STD.Str.FindReplace(strReplace1,'UNIV ','University ');
	strReplace3 := STD.Str.FindReplace(strReplace2,'LSU ','Louisiana State University ');
	strReplace4 := STD.Str.FindReplace(strReplace3,'SUNY','State University of New York');
	strReplace5 := STD.Str.FindReplace(strReplace4,'UC ','University of California ');
	strReplace6 := STD.Str.FindReplace(strReplace5,' HOSPS ',' Hospitals ');
	strReplace7 := STD.Str.FindReplace(strReplace6,' HOSP ',' Hospital ');
	strReplace8 := STD.Str.FindReplace(strReplace7,' TRAD CHI MED ',' Traditional Chinese Medicine ');
	strReplace9 := STD.Str.FindReplace(strReplace8,' FAC ',' FACULTY ');
	strReplace10 := STD.Str.FindReplace(strReplace9,'NSU ','Northeastern State University ');
	strReplace11 := STD.Str.FindReplace(strReplace10,' MED COLL ',' Medical College ');
	strReplace11a := STD.Str.FindReplace(strReplace11,' MED ',' Medicine ');
	strReplace12 := STD.Str.FindReplace(strReplace11a,' PROGRAM IN ',' School of ');
	strReplace13 := STD.Str.FindReplace(strReplace12,' COMM ',' Community ');
	strReplace14 := STD.Str.FindReplace(strReplace13,' LAXMIBAI ',' Laxmi Bai ');
	strReplace15 := STD.Str.FindReplace(strReplace14,' ST ',' State ');
	strReplace16 := STD.Str.FindReplace(strReplace15,' COL ',' College ');
	strReplace17 := STD.Str.FindReplace(strReplace16,' INST  ',' Institute ');
	strReplace18 := STD.Str.FindReplace(strReplace17,' HLTH ',' Health ');
	strReplace19 := STD.Str.FindReplace(strReplace18,' U ',' University ');
	strReplace20 := STD.Str.FindReplace(strReplace19,'UMDNJ','Rutgers ');
	strReplace21 := STD.Str.FindReplace(strReplace20,'RFUMS','Rosalind Franklin University of Medicine and Science ');
	strReplace22 := STD.Str.FindReplace(strReplace21,'NEOMED','Northeast Ohio Medical University ');
	strReplace23 := STD.Str.FindReplace(strReplace22,'COLL ','College ');
	strReplace24 := STD.Str.FindReplace(strReplace23,'PENN STATE','Pennsylvania State');
	strReplace25 := STD.Str.FindReplace(strReplace24,'PHYSICIANS AND SURGEONS','Physicians and Surgeons Medical School');
	strReplace26 := STD.Str.FindReplace(strReplace25,' COM ',' College of Medicine ');
	strReplace27 := STD.Str.FindReplace(strReplace26,' SO CALIF',' Southern California ');
	strReplace28 := STD.Str.FindReplace(strReplace27,' NYC',' New York City');
	strReplace29 := STD.Str.FindReplace(strReplace28,' SINAITULANE',' Sinai Tulane');
	strReplace30 := STD.Str.FindReplace(strReplace29,'UCLA ',' University of California David Geffen School of Medicine');
	strReplace31 := STD.Str.FindReplace(strReplace30,' AT LA',' Los Angeles');
	strReplace32 := STD.Str.FindReplace(strReplace31,' IN LA',' Los Angeles');
	strReplace33 := STD.Str.FindReplace(strReplace32,'UP STATE','Upstate');
	strReplace34 := STD.Str.FindReplace(strReplace33,' LIU',' Long Island University');
	strReplace35 := STD.Str.FindReplace(strReplace34,' PHARM ',' Pharmacy ');
	strReplace36 := STD.Str.FindReplace(strReplace35,' UNIVERSITYOLD ',' University Old ');
	strReplace37 := STD.Str.FindReplace(strReplace36,' TENNESSE ',' Tennessee ');
	strReplace38 := STD.Str.FindReplace(strReplace37,'INST ','Institute ');
	strReplace39 := STD.Str.FindReplace(strReplace38,' SCH ',' School ');
	strReplace40 := STD.Str.FindReplace(strReplace39,' CHRISTOPHERS ',' Christopher ');
	strReplace41 := STD.Str.FindReplace(strReplace40,' HSC',' Health Science Center');
	strReplace42 := STD.Str.FindReplace(strReplace41,'PCP NUMBER','');//Remove bad input
	strReplace43 := STD.Str.FindReplace(strReplace42,' BIO',' Biomedical');
	strReplace44 := STD.Str.FindReplace(strReplace43,' DENTAL BRANCH',' School of Dentistry');
	strReplace45 := STD.Str.FindReplace(strReplace44,' OSTEO ',' Osteopathic ');
	strReplace46 := STD.Str.FindReplace(strReplace45,'USPHS ','United State Public Health Service ');
	strReplace47 := STD.Str.FindReplace(strReplace46,'UNIVESITY ','University ');
	strReplace48 := STD.Str.FindReplace(strReplace47,' POD ',' Podiatric ');
	StdState := standardizeState(strReplace48);
	stdBeginState := BeginsWithState(StdState);
	strFinal := FindUniversityAt(stdBeginState);
	return strFinal;
end;

standardizeFmt(string inStr) := FUNCTION
	Healthcare_Cleaners.Layouts_MedSchool.layoutMedicalSchoolFinal fmtIt() := transform
		SELF.MSID := 0;
		SELF.Score := 0;
		SELF.ConfidenceScore := 1;
		SELF.ConfidenceScoreFlags:='STD';
		SELF.State := '';
		SELF.Name 	:= inStr;
		SELF.CampusLocation := '';
		SELF.YrEstablished := '';
		SELF.YrFirstGradClass := '';
		SELF.YrClosed := '';
		SELF.Degree := '';
	end;
	return dataset([fmtIt()]);
end;

findPossibleConflict(string inStrSrc, string inStringType) := FUNCTION
			hasDental := STD.Str.Find(inStrSrc,'DENTAL',1)>0;
			hasDentistry := STD.Str.Find(inStrSrc,'DENTISTRY',1)>0;
			hasMedicine := STD.Str.Find(inStrSrc,'MEDICINE',1)>0;
			hasMedical := STD.Str.Find(inStrSrc,'MEDICAL',1)>0;
			hasOpto := STD.Str.Find(inStrSrc,'OPTOMETRY',1)>0;
			hasChrio := STD.Str.Find(inStrSrc,'CHIROPRACTIC',1)>0;
			hasNurse := STD.Str.Find(inStrSrc,'NURSES',1)>0;
			hasPod := STD.Str.Find(inStrSrc,'PODIATRIC',1)>0;
			hasOsteo := STD.Str.Find(inStrSrc,'OSTEOPATHIC',1)>0;
			hasPsych := STD.Str.Find(inStrSrc,'PSYCHOLOGY',1)>0;
			hasMedicineOnly := not hasDental and not hasDentistry and not hasOpto and not hasChrio and not hasNurse and not hasPod and not hasOsteo and not hasPsych and hasMedicine;
			return map(inStringType = '' => false,//No Key word exists no conflict
					STD.Str.Find(inStrSrc,inStringType,1)>0 => false,//Key word match no conflict
					(hasDental and inStringType not in['DENTAL','DENTISTRY']) or
					(hasDentistry and inStringType not in['DENTAL','DENTISTRY']) or
					(hasMedicineOnly and inStringType not in ['MEDICAL','MEDICINE']) or
					(hasMedical and inStringType not in ['MEDICAL','MEDICINE']) or
					(hasOpto and inStringType<> 'OPTOMETRY') or
					(hasChrio and inStringType<> 'CHIROPRACTIC') or
					(hasNurse and inStringType<> 'NURSES') or
					(hasPod and inStringType<> 'PODIATRIC') or
					(hasOsteo and inStringType<> 'OSTEOPATHIC') or
					(hasPsych and inStringType<> 'PSYCHOLOGY') => true,//Key word match found so conflict since it did not match above
					false);// No key word found so no conflict
end;

export processRow(healthcare_cleaners.Layouts_MedSchool.layoutmedschoolbatchin inRec, unsigned2 fail2NonMedicalThreshold = 0, unsigned returnCnt = 1, boolean SkipMedSchools=false) := FUNCTION
		s1:=if(STD.Str.ToUppercase(inRec.medSchoolName)[1..2]='U ','University '+inRec.medSchoolName[3..],inRec.medSchoolName);//Fix Abbreviations people might put in that are also considered connecting words
		s2:=if(STD.Str.ToUppercase(s1)[length(s1)-1..]=' U',s1[1..length(s1)-1]+'University ',s1);//Fix Abbreviations people might put in that are also considered connecting words
		s3:=if(STD.Str.ToUppercase(s2)[1..3]='NE ','Northeast '+s2[4..],s2);//Fix Abbreviations people might put in that are also considered connecting words
		s4:=if(STD.Str.ToUppercase(s3)[length(s3)-3..]=' MED',s3[1..length(s3)-3]+' Medicine',s3);//Fix Abbreviations people might put in that are also considered connecting words
		s:=standardizeIt(s4);//Fix Abbreviations people might put in that are also considered connecting words
		inPracStateBonus := getMedschoolState(inRec.medSchoolName,STD.Str.ToUppercase(inRec.state));
		k_wl := Medschool_standardization.Keys(,Healthcare_Cleaners.Constants.useProd).medschool_wordlist_word_key.QA();
		k_msid := Medschool_standardization.Keys(,Healthcare_Cleaners.Constants.useProd).medschool_msid_key.QA();
		k_wl_non := Medschool_standardization.Keys(,Healthcare_Cleaners.Constants.useProd).non_medschool_wordlist_word_key.QA();
		k_msid_non := Medschool_standardization.Keys(,Healthcare_Cleaners.Constants.useProd).non_medschool_msid_key.QA();
    parseit := Medschool_standardization.Functions.BusName_SplitAndSequenceWords(s,0);
		ConflictTypePossible := parseit(words in ['DENTAL','DENTISTRY','MEDICAL','MEDICINE','NURSES','OPTOMETRY','CHIROPRACTIC','PSYCHOLOGY','PODIATRIC','OSTEOPATHIC'])[1].Words;
		hasInternationalWord := exists(parseit(words in ['ACADEMICA','UNIVERSITAT','MEDECINE','UNIVERSIDAD','MEDICINA','MEDICAS','CIENCIAS']));
		// wordlist:=Healthcare_Cleaners.medschool_db.wordlist;
		cntParse := count(dedup(parseit,record,all));
		linkit := join(parseit,k_wl,left.words=right.words,
										transform(Medschool_standardization.layouts.layoutmedicalschoolword1, 
										self.region:=right.region or left.words in Healthcare_Cleaners.Constants.stateList;
										self.campus:=right.campus;self:=left;self:=right;),keep(20000),limit(0));
		joinit := dedup(join(linkit,k_msid,left.msid=right.msid and left.score >= 2,
										transform(tmpLayout,
										UpperName := STD.Str.ToUppercase(right.name);
										self.SchoolTypeConflict := findPossibleConflict(UpperName,ConflictTypePossible);
										self.StateConflict := inPracStateBonus <> '' and inPracStateBonus <> right.state[1..2];
										self.beginswith:=UpperName[1..20];self.inputval:=STD.Str.ToUppercase(s[1..20]);self.State:=right.state;self:=left),left outer,keep(20000),limit(0)),record,all);
		groupit := group(sort(joinit,msid),msid);
		countit := choosen(sort(rollup(groupit,group,FinalRollup(left,rows(left),cntParse,inPracStateBonus)),-ConfidenceScore,-score,msid),returnCnt);
		goodMedical := exists(countit(ConfidenceScore>=fail2NonMedicalThreshold));
		getResults := sort(join(countit,k_msid,left.msid=right.msid,transform(Healthcare_Cleaners.Layouts_MedSchool.layoutMedicalSchoolFinal,
																				self:=left;self:=right;),keep(10000),limit(0)),-ConfidenceScore);
		BeginsWithMedical := exists(getResults(STD.Str.Find(ConfidenceScoreFlags,'B',1)>0 and ConfidenceScore >= getResults[1].ConfidenceScore));
		CampusWithMedical := exists(getResults(STD.Str.Find(ConfidenceScoreFlags,'C',1)>0));
		//If we have a threshold remove things under the thershold and search Non-Medical Schools
		linkit2 := join(parseit,k_wl_non,left.words=right.words,
										transform(Medschool_standardization.layouts.layoutmedicalschoolword1, 
										self.region:=right.region or left.words in Healthcare_Cleaners.Constants.stateList;
										self.campus:=right.campus;self:=left;self:=right;),keep(20000),limit(0));
		joinit2 := join(linkit2,k_msid_non,left.msid=right.msid and left.score > 2,
										transform(tmpLayout,
										UpperName := STD.Str.ToUppercase(right.name);
										self.SchoolTypeConflict := findPossibleConflict(UpperName,ConflictTypePossible);
										self.StateConflict := inPracStateBonus <> '' and inPracStateBonus <> trim(right.state,left,right);
										self.beginswith:=UpperName[1..20];self.inputval:=STD.Str.ToUppercase(s[1..20]);self.State:=right.state;self:=left),left outer,keep(20000),limit(0));
		groupit2 := group(sort(joinit2,msid),msid);
		countit2 := choosen(sort(rollup(groupit2,group,FinalRollup(left,rows(left),cntParse,inPracStateBonus)),-ConfidenceScore,-score,msid),returnCnt);
		goodNonMedical := exists(countit2(ConfidenceScore>=fail2NonMedicalThreshold));
		getResults2 := sort(join(countit2,k_msid_non,left.msid=right.msid,transform(Healthcare_Cleaners.Layouts_MedSchool.layoutMedicalSchoolFinal,
																				self:=left;self:=right;),keep(10000),limit(0)),-ConfidenceScore);
		BeginsWithNonMedical := exists(getResults2(STD.Str.Find(ConfidenceScoreFlags,'B',1)>0 and ConfidenceScore >= getResults[1].ConfidenceScore));
		CampusNonMedical := STD.Str.Find(getResults2[1].ConfidenceScoreFlags,'C',1)>0;
		RegionMatchInternational := STD.Str.Find(getResults[1].ConfidenceScoreFlags,'I',1)>0;
		finalResults := map(SkipMedSchools and goodNonMedical => getResults2,
												SkipMedSchools => standardizeFmt(s),
												hasInternationalWord => getResults,
												goodMedical and not BeginsWithNonMedical and getResults2[1].ConfidenceScore < 80 => getResults,
												goodMedical and goodNonMedical and getResults[1].ConfidenceScore > getResults2[1].ConfidenceScore => getResults,
												goodMedical and goodNonMedical and getResults[1].ConfidenceScore = getResults2[1].ConfidenceScore 
														and BeginsWithMedical and BeginsWithNonMedical and CampusWithMedical => getResults,
												goodMedical and goodNonMedical and getResults[1].ConfidenceScore = getResults2[1].ConfidenceScore 
														and BeginsWithMedical and BeginsWithNonMedical and CampusNonMedical => getResults2,
												goodMedical and goodNonMedical and getResults[1].ConfidenceScore = getResults2[1].ConfidenceScore and BeginsWithMedical => getResults,
												goodMedical and goodNonMedical and getResults[1].ConfidenceScore = getResults2[1].ConfidenceScore and RegionMatchInternational => getResults,
												goodMedical and goodNonMedical and getResults[1].ConfidenceScore = getResults2[1].ConfidenceScore and BeginsWithNonMedical => getResults2,
												goodMedical and goodNonMedical and getResults[1].ConfidenceScore = getResults2[1].ConfidenceScore 
														and BeginsWithMedical and BeginsWithNonMedical and getResults[1].score > getResults2[1].score => getResults,
												goodMedical and goodNonMedical and getResults[1].ConfidenceScore = getResults2[1].ConfidenceScore 
														and BeginsWithMedical and BeginsWithNonMedical and getResults[1].score < getResults2[1].score => getResults2,
												goodMedical and goodNonMedical and getResults[1].ConfidenceScore = getResults2[1].ConfidenceScore 
														 and getResults[1].score > getResults2[1].score => getResults,
												goodMedical and goodNonMedical and getResults[1].ConfidenceScore = getResults2[1].ConfidenceScore  
														 and getResults[1].score < getResults2[1].score => getResults2,
												goodMedical and goodNonMedical and getResults[1].ConfidenceScore < getResults2[1].ConfidenceScore => getResults2,
												goodMedical => getResults,
												goodNonMedical => getResults2,
												standardizeFmt(s));
		// output(inPracStateBonus);
		// output(goodMedical);
		// output(goodNonMedical);
		// output(getResults[1].ConfidenceScore = getResults2[1].ConfidenceScore);
		// output(BeginsWithMedical);
		// output(BeginsWithNonMedical);
		// output(CampusWithMedical);
		// output(CampusNonMedical);
		// output(s);
		// output(cntParse);
		// output(parseit);
		// output(cntParse);
		// output(linkit);
		// output(joinit);
		// output(groupit);
		// output(countit);
		// output(hasInternationalWord);
		// output(getResults);
		// output(inPracStateBonus);
		// output(linkit2);
		// output(joinit2);
		// output(groupit2);
		// output(countit2);
		// output(getResults2);
		// output(BeginsWithNonMedical);
		// output(finalResults);
		RETURN project(sort(finalResults,-ConfidenceScore,-(integer)ConfidenceScoreFlags[2..5]),
							transform(Healthcare_Cleaners.Layouts_MedSchool.layoutMedicalSchoolFinal,
												self.acctno := inRec.acctno;
												self.raw_medSchoolName := inRec.medSchoolName;
												self.raw_state := STD.Str.ToUppercase(inRec.state);
												self:=left;));
end;

export getBestMatch(dataset(healthcare_cleaners.Layouts_MedSchool.layoutmedschoolbatchin) inRecs, unsigned2 fail2NonMedicalThreshold = 0, unsigned returnCnt = 1, boolean SkipMedSchools=false) := FUNCTION
		recs := project(inRecs,Transform(Healthcare_Cleaners.Layouts_MedSchool.layoutMedicalSchoolTmp,
																			self.acctno := left.acctno;
																			self.rawRecs:=processRow(left,fail2NonMedicalThreshold,returnCnt,SkipMedSchools)));
		recsFinal := normalize(recs,left.rawRecs,Transform(Healthcare_Cleaners.Layouts_MedSchool.layoutMedicalSchoolFinal,
																			self := right));
		RETURN recsFinal;
	END;
end;