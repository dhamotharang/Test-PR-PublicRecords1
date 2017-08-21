EXPORT utils := MODULE
	import STD, ut;
	EXPORT Decode_source_bit_mask(unsigned bitmap_int) := function
		boolean  fFlagIsOn(unsigned pValue, unsigned bitmap_rules) := pValue & bitmap_rules = bitmap_rules;
		string  translated_value  := if(bitmap_int = 0
							, ''
							, if(fFlagIsOn(bitmap_int, ut.bit_set(0,15)),   'LN ','')
							+ if(fFlagIsOn(bitmap_int, ut.bit_set(0,14)),   'ENC ','')
							+ if(fFlagIsOn(bitmap_int, ut.bit_set(0,13)),   'HMS ','')
						 );
	return translated_value;
	end;

	EXPORT Decode_field_bit_mask(unsigned bitmap_int) := function
		boolean  fFlagIsOn(unsigned pValue, unsigned bitmap_rules) := pValue & bitmap_rules = bitmap_rules;
		string  translated_value  := if(bitmap_int = 0
							, ''
							, if(fFlagIsOn(bitmap_int, ut.bit_set(0,63)),   'UPIN ','')
							+ if(fFlagIsOn(bitmap_int, ut.bit_set(0,62)),   'SSN ','')
							+ if(fFlagIsOn(bitmap_int, ut.bit_set(0,61)),   'DOB ','')
							+ if(fFlagIsOn(bitmap_int, ut.bit_set(0,60)),   'MNAME ','')
							+ if(fFlagIsOn(bitmap_int, ut.bit_set(0,59)),   'SNAME ','')
							+ if(fFlagIsOn(bitmap_int, ut.bit_set(0,58)),   'PNAME ','')
							+ if(fFlagIsOn(bitmap_int, ut.bit_set(0,57)),   'CNAME ','')
							+ if(fFlagIsOn(bitmap_int, ut.bit_set(0,56)),   'GENDER ','')
							+ if(fFlagIsOn(bitmap_int, ut.bit_set(0,55)),   'TAXONOMY ','')
							+ if(fFlagIsOn(bitmap_int, ut.bit_set(0,54)),   'MEDSCHOOL ','')
							+ if(fFlagIsOn(bitmap_int, ut.bit_set(0,53)),   'MEDSCHOOL_YEAR ','')
							+ if(fFlagIsOn(bitmap_int, ut.bit_set(0,52)),   'TAX_ID ','')
							+ if(fFlagIsOn(bitmap_int, ut.bit_set(0,51)),   'BILLING_NPI ','')
							+ if(fFlagIsOn(bitmap_int, ut.bit_set(0,50)),   'DEATH_IND ','')
							+ if(fFlagIsOn(bitmap_int, ut.bit_set(0,49)),   'DOD ','')
							+ if(fFlagIsOn(bitmap_int, ut.bit_set(0,48)),   'PRAC_PHONE ','')
							+ if(fFlagIsOn(bitmap_int, ut.bit_set(0,47)),   'PRAC_FAX ','')
							+ if(fFlagIsOn(bitmap_int, ut.bit_set(0,46)),   'EMAIL ','')
							+ if(fFlagIsOn(bitmap_int, ut.bit_set(0,45)),   'WEB_SITE ','')
							+ if(fFlagIsOn(bitmap_int, ut.bit_set(0,44)),   'BILL_PHONE ','')
							+ if(fFlagIsOn(bitmap_int, ut.bit_set(0,43)),   'BILL_FAX ','')
							+ if(fFlagIsOn(bitmap_int, ut.bit_set(0,42)),   'CNSMR_SSN ','')
							+ if(fFlagIsOn(bitmap_int, ut.bit_set(0,41)),   'CNSMR_DOB ','')
						 );
	return translated_value;
	end;


	import ut;
	EXPORT isValidDate (STRING8 InDate,
											INTEGER low_year = 1900, INTEGER high_year = 2100,
											STRING minMonth = '01', STRING minDay = '01') := FUNCTION
		
		LEN_DATE							:= LENGTH(TRIM(InDate,LEFT,RIGHT));
		Int_Year 					    := (INTEGER)(InDate[1..4]);
		Current_Year					:= (INTEGER)(((STRING8)STD.Date.Today())[1..4]);
		BOOLEAN isValidYear 	:= Int_Year >= low_year AND Int_Year <= high_year;
		BOOLEAN isValidMonth	:= InDate[5..6] BETWEEN minMonth AND '12';
		BOOLEAN isValidDay 		:= MAP ((InDate[5..6] = '01') AND (InDate[7..8] BETWEEN minDay AND '31') => TRUE,
																	(STD.Date.IsLeapYear(Int_Year) AND InDate[5..6] = '02') AND (InDate[7..8] BETWEEN minDay AND '29') => TRUE,
																	(~STD.Date.IsLeapYear(Int_Year) AND InDate[5..6] = '02') AND (InDate[7..8] BETWEEN minDay AND '28') => TRUE,
																	(InDate[5..6] = '03') AND (InDate[7..8] BETWEEN minDay AND '31') => TRUE,
																	(InDate[5..6] = '04') AND (InDate[7..8] BETWEEN minDay AND '30') => TRUE,
																	(InDate[5..6] = '05') AND (InDate[7..8] BETWEEN minDay AND '31') => TRUE,
																	(InDate[5..6] = '06') AND (InDate[7..8] BETWEEN minDay AND '30') => TRUE,
																	(InDate[5..6] = '07') AND (InDate[7..8] BETWEEN minDay AND '31') => TRUE,
																	(InDate[5..6] = '08') AND (InDate[7..8] BETWEEN minDay AND '31') => TRUE,
																	(InDate[5..6] = '09') AND (InDate[7..8] BETWEEN minDay AND '30') => TRUE,
																	(InDate[5..6] = '10') AND (InDate[7..8] BETWEEN minDay AND '31') => TRUE,
																	(InDate[5..6] = '11') AND (InDate[7..8] BETWEEN minDay AND '30') => TRUE,
																	(InDate[5..6] = '12') AND (InDate[7..8] BETWEEN minDay AND '31') => TRUE,
																	FALSE
																	); 
		BogusDOBs		:= ['19000101'];
		IsValidDate := IsValidYear AND IsValidMonth AND IsValidDay AND LEN_DATE = 8 AND InDate NOT IN BogusDOBs;
		RETURN IsValidDate;
	END;

	EXPORT isValidDOB (STRING8 InDate) := FUNCTION
		Current_Year					:= (INTEGER)(((STRING8)STD.Date.Today())[1..4]);
		l_range 							:= Current_Year - 120;
		h_range								:= Current_Year;
		RETURN isValidDate(InDate, l_range, h_range, '00', '00');
	END;
	
	EXPORT FixDateLength (UNSIGNED InDate) := FUNCTION
		dateFix	:= MAP((LENGTH((STRING)InDate)=8 AND ((STRING)InDate)[7..8]<>'00')  => (STRING)InDate,
									 (LENGTH((STRING)InDate)=4 OR ((STRING)InDate)[5..8]='0000')  => ((STRING)InDate)[1..4] + '0101',
									 (LENGTH((STRING)InDate)=6 OR ((STRING)InDate)[7..8]='00')  => ((STRING)InDate)[1..6] + '01',
									  ''
									 );
	
		RETURN (UNSIGNED) dateFix;
	END;

	EXPORT CleanAddressComponent(STRING addressComponent) := FUNCTION
		replaceNonAscii			:= REGEXREPLACE(Constants.NonAsciiChar, addressComponent, '');
		upperCleanSpaces		:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(replaceNonAscii));
		RETURN upperCleanSpaces;
	END;

	EXPORT CleanDOB(STRING8 inDate) := FUNCTION
		RETURN IF(isValidDOB(inDate), (UNSIGNED4)inDate, 0);
	END;

	IMPORT HealthCareFacility;
	EXPORT CleanFacilityName(STRING facilityName) := FUNCTION
		 stdClean := StringLib.StringToUpperCase(StringLib.StringCleanSpaces(HealthCareFacility.clean_facility_name(facilityName)));
		 removeBad := IF(REGEXFIND(Constants.regexBadCname, stdClean), '', stdClean);
		 RETURN removeBad;
	END;

	EXPORT CleanLicenseNumber(STRING lic_in) := FUNCTION
		toUpper						:= TRIM(StringLib.StringToUpperCase(lic_in), ALL);
		removeNonAlphaNum := REGEXREPLACE(Constants.NonAlphaNumChar, toUpper, '');
		RETURN IF(removeNonAlphaNum IN Constants.setBogusLicense, '', removeNonAlphaNum);
	END;

	EXPORT CleanLicenseState(STRING state_in) := FUNCTION
		upperTrim := StringLib.StringToUpperCase(StringLib.StringCleanSpaces(state_in));
		RETURN upperTrim;
	END;

	EXPORT CleanLicenseType(STRING type_in) := FUNCTION
		RemoveNonWordChar	:= REGEXREPLACE(Constants.NonWordChar, type_in, '');
		upperTrim					:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(RemoveNonWordChar));
		RETURN upperTrim;
	END;
	
	EXPORT CleanDEANumber(STRING dea_in) := FUNCTION
		toUpper						:= TRIM(StringLib.StringToUpperCase(dea_in), ALL);
		removeNonAlphaNum := REGEXREPLACE(Constants.NonAlphaNumChar, toUpper, '');
		RETURN removeNonAlphaNum;
	END;

	IMPORT STD, lib_StringLib;
	EXPORT CleanMedSchoolName (STRING iMedSchool) := FUNCTION
			RawDataRec := RECORD
					STRING120   medschool;
			END;
			WordRec := RECORD
					STRING          word;
			END;
			SeqWordRec := RECORD
					UNSIGNED1       seq;
					WordRec;
			END;

			DATASET(SeqWordRec) SplitAndSequenceWords(STRING s) := FUNCTION
					INVALID_WORDS := ['OTHER'];
					r10 := DATASET(Std.Str.SplitWords(s, ' '), WordRec);
					r15 := r10 (WORD NOT IN INVALID_WORDS);
					r20 := PROJECT
							(
									r15,
									TRANSFORM
											(
													SeqWordRec,
													SELF.seq := COUNTER,
													SELF.word := LEFT.word
											)
							);

					RETURN r20;
			END;

			STRING RecombineWords(DATASET(SeqWordRec) ds) := FUNCTION
					resultDS := ROLLUP
							(
									SORT(ds, seq),
									TRUE,
									TRANSFORM
											(
													SeqWordRec,
													SELF.word := LEFT.word + IF(LEFT.word != '', ' ', '') + RIGHT.word,
													SELF := RIGHT
											)
							);

					RETURN TRIM(resultDS[1].word, LEFT, RIGHT);
			END;

			UNSIGNED4 PrefixMatchCount(STRING a, STRING b) := BEGINC++
					unsigned int    minLength = lenA < lenB ? lenA : lenB;
					unsigned int    numMatched = 0;

					for (numMatched = 0; numMatched < minLength; numMatched++)
					{
							if (a[numMatched] != b[numMatched])
							{
									break;
							}
					}

					return numMatched;
			ENDC++;

			DATASET(SeqWordRec) CleanPrefixAndSuffixFromSequencedWords(DATASET(SeqWordRec) seqNameWords) := FUNCTION
					NoiseRec := RECORD
							STRING      word;
							UNSIGNED1   word_type;  // 1 = suffix, 2 = prefix
					END;

					noiseWords := DATASET
							(
									[
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
											{'THE', 2},
											{'AFTER', 2}
									],
									NoiseRec
							);

					r10 := JOIN
							(
									seqNameWords,
									noiseWords,
									LEFT.word = RIGHT.word,
									LOOKUP, LEFT OUTER
							);

					firstWordSeq := MIN(r10(word_type != 2), seq);
					lastWordSeq := MAX(r10(word_type != 1), seq);

					r20 := r10(seq BETWEEN firstWordSeq AND lastWordSeq);

					noiselessWordsDS := PROJECT
							(
									SORT(r20, seq),
									TRANSFORM
											(
													SeqWordRec,
													SELF.seq := COUNTER,
													SELF := LEFT
											)
							);

					RETURN noiselessWordsDS;
			END;

			DATASET(SeqWordRec) TranslateSequencedWords(DATASET(SeqWordRec) seqNameWords) := FUNCTION
					TranslationRec := RECORD
							STRING      origWord;
							STRING      newWord;
					END;

					// Adapted from HealthCareFacility.Constants.Conv_Table
					translationWords := DATASET
							(
									[
											{'1','ONE'},
											{'2','TWO'},
											{'3','THREE'},
											{'4','FOUR'},
											{'5','FIVE'},
											{'6','SIX'},
											{'7','SEVEN'},
											{'8','EIGHT'},
											{'9','NINE'},
											{'N','NORTH'},
											{'S','SOUTH'},
											{'E','EAST'},
											{'W','WEST'},
											{'AB','AMERICAN BOARD'},
											{'ACAD','ACADEMY'},
											{'ACPUNCTURE','ACUPUNCTURE'},
											{'ACUP','ACUPUNCTURE'},
											{'ACUPPUNCTURE','ACUPUNCTURE'},
											{'ACUPPRESSURE','ACUPRESSURE'},
											{'ACUPPRESURE','ACUPRESSURE'},
											{'ACUPU','ACUPUNCTURE'},
											{'AGR','AGRICULTURAL'},
											{'AGRI','AGRICULTURAL'},
											{'CHIN','CHINESE'},
											{'CLG','COLLEGE'},
											{'COL','COLLEGE'},
											{'COLEGE','COLLEGE'},
											{'COLL','COLLEGE'},
											{'COLLE','COLLEGE'},
											{'COLLEG','COLLEGE'},
											{'CLLEGE','COLLEGE'},
											{'CLLEDGE','COLLEGE'},
											{'CULT','CULTURE'},
											{'CTR','CENTER'},
											{'ED','EDUCATION'},
											{'EDU','EDUCATION'},
											{'EDUC','EDUCATION'},
											{'EDUCL','EDUCATIONAL'},
											{'ELEM','ELEMENTARY'},
											{'FAC','FACULTY'},
											{'GRAD','GRADUATE'},
											{'HEAL','HEALTH'},
											{'HLG','HEALING'},
											{'HLT','HEALTH'},
											{'HYG','HYGIENE'},
											{'IM','INTERNAL MEDICINE'},
											{'INST','INSTITUTE'},
											{'MED','MEDICINE'},
											{'MEDI','MEDICINE'},
											{'MEDIC','MEDICINE'},
											{'MEDICIN','MEDICINE'},
											{'MEDICA','MEDICAL'},
											{'NATL','NATIONAL'},
											{'PHARM','PHARMACY'},
											{'PRACT','PRACTITIONER'},
											{'PSY','PSYCHOLOGY'},
											{'PSYCH','PSYCHOLOGY'},
											{'SCH','SCHOOL'},
											{'SCHL','SCHOOL'},
											{'SCHOL','SCHOOL'},
											{'SCI','SCIENCE'},
											{'SOC','SOCIAL'},
											{'TECH','TECHNICAL'},
											{'TH','THE'},
											{'U','UNIVERSITY'},
											{'UNI','UNIVERSITY'},
											{'UNIVER','UNIVERSITY'},
											{'UNIVERSITET','UNIVERSITY'},
											{'UNIVAESITY','UNIVERSITY'},
											{'UNIVERISTY','UNIVERSITY'},
											{'UNIVERSISTY','UNIVERSITY'},
											{'UNIVERISY','UNIVERSITY'},
											{'UNIVERSTY','UNIVERSITY'},
											{'UNV','UNIVERSITY'},
											{'UNIVERSI','UNIVERSITY'},
											{'UNIVERSIT','UNIVERSITY'},
											{'UNIV','UNIVERSITY'},
											{'UNIVOF','UNIVERSITY OF'},
											{'UNIVOF','UNIVERSITY OF'},
											{'VILLARRE','VILLARREAL'},
											{'UOF','UNIVERSITY OF'},
											{'ALABAMA','AL'},
											{'ALASKA','AK'}, 
											{'ARKANSAS','AR'}, 
											{'AMERICAN SAMOA','AS'}, 
											{'ARIZONA','AZ'}, 
											{'CALIFORNIA','CA'}, 
											{'COLORADO','CO'}, 
											{'CONNECTICUT','CT'}, 
											{'DISTRICT OF COLUMBIA','DC'}, 
											{'DELAWARE','DE'}, 
											{'FLORIDA','FL'}, 
											{'FLA','FL'}, 
											{'GEORGIA','GA'}, 
											{'GUAM, SAMOA, OR THE PHILIPPINES','GS'},
											{'GUAM OR SAMOA OR THE PHILIPPINES','GS'},
											{'GUAM','GU'}, 
											{'HAWAII','HI'}, 
											{'IOWA','IA'}, 
											{'IDAHO','ID'}, 
											{'ILLINOIS','IL'}, 
											{'INDIANA','IN'}, 
											{'KANSAS','KS'}, 
											{'KENTUCKY','KY'}, 
											{'LOUISIANA','LA'}, 
											{'MASSACHUSETTS','MA'}, 
											{'MARYLAND','MD'}, 
											{'MAINE','ME'}, 
											{'MICHIGAN','MI'}, 
											{'MINNESOTA','MN'}, 
											{'MISSOURI','MO'}, 
											{'MISSISSIPPI','MS'}, 
											{'MONTANA','MT'}, 
											{'NORTH CAROLINA','NC'}, 
											{'NORTH DAKOTA','ND'}, 
											{'NEBRASKA','NE'}, 
											{'NEW HAMPSHIRE','NH'}, 
											{'NEW JERSEY','NJ'}, 
											{'NEW MEXICO','NM'}, 
											{'NEVADA','NV'}, 
											{'NEW MEXICO OR UTAH','NU'}, 
											{'NEW YORK','NY'}, 
											{'OHIO','OH'}, 
											{'OKLAHOMA','OK'}, 
											{'OREGON','OR'}, 
											{'PENNSYLVANIA','PA'}, 
											{'PUERTO RICO','PR'}, 
											{'RHODE ISLAND','RI'}, 
											{'ASIAN REFUGEE NUMBER','RN'}, 
											{'ASIAN REFUGEE','RN'},
											{'SOUTH CAROLINA','SC'}, 
											{'SOUTH DAKOTA','SD'}, 
											{'TENNESSEE','TN'}, 
											{'TEXAS','TX'}, 
											{'UTAH','UT'}, 
											{'VIRGINIA','VA'}, 
											{'VIRGIN ISLANDS','VI'}, 
											{'VERMONT','VT'}, 
											{'WASHINGTON','WA'}, 
											{'WISCONSIN','WI'}, 
											{'WEST VIRGINIA','WV'}, 
											{'WYOMING','WY'},
											{'UTAH OR ARIZONA','AZ'},
											{'THE RAIL ROAD PROGRAM','RR'},
											{'WEST VIRGINIA OR NORTH CAROLINA','WV'},
											{'VIRGIN ISLANDS OR PUERTO RICO','PR'},
											{'ENUMERATION AT ENTRY','EE'}
									],
									TranslationRec
							);

					r10 := JOIN
							(
									seqNameWords,
									translationWords,
									LEFT.word = RIGHT.origWord,
									TRANSFORM
											(
													RECORDOF(seqNameWords),
													SELF.word := IF(RIGHT.newWord != '', RIGHT.newWord, LEFT.word),
													SELF := LEFT
											),
									LOOKUP, LEFT OUTER
							);

					zeroWords := DATASET
							(
									[
											'OPTIONSCASHCHECKMASTERCARDVISALOCATIONSA',
											'EXPRESSCASHCHECKDISCOVERMA',
											'OPTIONSAMERICAN'
									],
									WordRec
							);

					r20 := JOIN
							(
									r10,
									zeroWords,
									LEFT.word = RIGHT.word,
									TRANSFORM
											(
													RECORDOF(r10),
													SELF := LEFT
											),
									LOOKUP, LEFT ONLY
							);

					RETURN r20(word != '');
			END;

			STRING TranslatePhrases1(STRING s) := FUNCTION
					Swap(STRING s, STRING x, STRING y) := REGEXREPLACE('\\b' + x + '\\b', s, y);

					s1 := Swap(s, 'A EINSTEIN', 'ALBERT EINSTEIN');

					RETURN s1;
			END;

			STRING TranslatePhrases2(STRING s) := FUNCTION
					Swap(STRING s, STRING x, STRING y) := REGEXREPLACE('\\b' + x + '\\b', s, y);

					SeparateWord(STRING s, STRING x, STRING allowedSuffixChars = '') := FUNCTION
							r1 := REGEXREPLACE('([^ ])' + x, s, '$1 ' + x);
							r2 := REGEXREPLACE(x + '([^' + allowedSuffixChars + ' ])', r1, x + ' $1');

							RETURN r2;
					END;

					a1 := REGEXREPLACE('([A-Z])(\\d+)\\b', s, '$1 $2');
					a2 := REGEXREPLACE('\\b([A-Z]+)(\\d+)([A-Z]+)\\b', a1, '$1 $2 $3');
					a3 := REGEXREPLACE('\\b(\\d\\d+)([A-Z]+)\\b', a2, '$1 $2');

					s1 := Swap(a3, 'SCHOOL OF HEALTH SCIENCE', 'SCHOOL OF HEALTH SCIENCES');
					s2 := Swap(s1, 'SCHOOL OF MEDICAL', 'SCHOOL OF MEDICINE');
					s3 := Swap(s2, 'COLLEGE OF MEDICAL', 'COLLEGE OF MEDICINE');
					s4 := Swap(s3, 'FACULTY OF MEDICAL', 'FACULTY OF MEDICINE');
					s5 := Swap(s4, 'OSTROW2BSCHOOL2BOF2BDENTISTRY2BOF2B', 'OSTROW SCHOOL OF DENTISTRY OF');
					s6 := Swap(s5, 'SUNYUPSTATEHEALTHSCIENCECENTERMEDSCHOOL', 'SUNY UPSTATE HEALTH SCIENCE CENTER MEDICAL SCHOOL');
					s7 := Swap(s6, 'JOHNMALINOWSKISLSPORTSTHERAPYCOM', 'JOHN MALINOWSKI SL SPORTSTHERAPY.COM');
					s8 := Swap(s7, 'ALBERTEINSTEINCOLLOFMED', 'ALBERT EINSTEIN COLLEGE OF MEDICINE');
					s9 := Swap(s8, 'OBAFEMIAWOLOWOUNIVERS', 'OBAFEMI AWOLOWO UNIVERSITY');
					s10 := Swap(s9, 'BRIGHTCOVECREATEEXPERIENCES', 'BRIGHT COVE CREATE EXPERIENCES');
					s11 := Swap(s10, 'NETWORKSAVESHARELIKE', 'NETWORK SAVE SHARE LIKE');
					s12 := Swap(s11, 'EXPRESSCASHCHEC', 'EXPRESS CASH CHECK');
					s13 := Swap(s12, 'CAYETANO HER', 'CAYETANO HEREDIA');
					s14 := Swap(s13, 'CAYETANO HEREDI', 'CAYETANO HEREDIA');
					s15 := Swap(s14, 'CAYETANO HEREDIIA', 'CAYETANO HEREDIA');
					s16 := Swap(s15, 'COLLEB GE', 'COLLEGE');
					s17 := Swap(s16, 'ADI CHUNCHANAGIRI', 'ADICHUNCHANAGIRI');
					s18 := Swap(s17, 'ADI CHUNCHANAGIRL' , 'ADICHUNCHANAGIRI');
					s19 := Swap(s18, 'ADI CHUNCHANGIRI', 'ADICHUNCHANAGIRI');
					s20 := Swap(s19, 'ADI CHUNCHUNAGIRI' , 'ADICHUNCHANAGIRI');
					s21 := Swap(s20, 'ADICHUNCHANAGARI' , 'ADICHUNCHANAGIRI');
					s22 := Swap(s21, 'ADICHUNCHANAGIE' , 'ADICHUNCHANAGIRI');
					s23 := Swap(s22, 'ADICHUNCHANAGIRE', 'ADICHUNCHANAGIRI');

					f1 := REGEXREPLACE('PENNSLVANIA', s23, 'PENNSYLVANIA');
					f2 := REGEXREPLACE('PENNSLYVANIA', f1, 'PENNSYLVANIA');
					f3 := REGEXREPLACE('(\\w+)MD\\b', f2, '$1 MD');
					f4 := REGEXREPLACE('\\w+EDU\\b', f3, '');   // Remove school email addresses

					s100 := SeparateWord(f4, 'OSTEOPATHIC');
					s101 := SeparateWord(s100, 'WASHINGTON');
					s102 := SeparateWord(s101, 'EDUCATIONAL');
					s103 := SeparateWord(s102, 'DEPARTMENT');
					s104 := SeparateWord(s103, 'UNDERGRADUATE');
					s105 := SeparateWord(s104, 'BOSTON');
					s106 := SeparateWord(s105, 'UNIVERSITY');
					s107 := SeparateWord(s106, 'INTERNSHIP');
					s108 := SeparateWord(s107, 'COLLEGE', 'S');
					s109 := SeparateWord(s108, 'REHABILITATION');
					s110 := SeparateWord(s109, 'MEDICAL');
					s111 := SeparateWord(s110, 'INSTITUTE');
					s112 := SeparateWord(s111, 'MEDICINE');
					s113 := SeparateWord(s112, 'ALABAMA');
					s114 := SeparateWord(s113, 'ALASKA');
					s115 := SeparateWord(s114, 'ARIZONA');
					s116 := SeparateWord(s115, 'ARKANSAS');
					s117 := SeparateWord(s116, 'CALIFORNIA');
					s118 := SeparateWord(s117, 'COLORADO');
					s119 := SeparateWord(s118, 'CONNECTICUT');
					s120 := SeparateWord(s119, 'DELAWARE');
					s121 := SeparateWord(s120, 'FLORIDA');
					s122 := SeparateWord(s121, 'GEORGIA');
					s123 := SeparateWord(s122, 'HAWAII');
					s124 := SeparateWord(s123, 'IDAHO');
					s125 := SeparateWord(s124, 'ILLINOIS');
					s126 := SeparateWord(s125, 'INDIANA');
					s127 := SeparateWord(s126, 'IOWA');
					s128 := SeparateWord(s127, 'KANSAS');
					s129 := SeparateWord(s128, 'KENTUCKY');
					s130 := SeparateWord(s129, 'LOUISIANA');
					s131 := SeparateWord(s130, 'MAINE');
					s132 := SeparateWord(s131, 'MARYLAND');
					s133 := SeparateWord(s132, 'MASSACHUSETTS');
					s134 := SeparateWord(s133, 'MICHIGAN');
					s135 := SeparateWord(s134, 'MINNESOTA');
					s136 := SeparateWord(s135, 'MISSISSIPPI');
					s137 := SeparateWord(s136, 'MISSOURI');
					s138 := SeparateWord(s137, 'MONTANA');
					s139 := SeparateWord(s138, 'NEBRASKA');
					s140 := SeparateWord(s139, 'NEVADA');
					s141 := SeparateWord(s140, 'HAMPSHIRE');
					s142 := SeparateWord(s141, 'JERSEY');
					s143 := SeparateWord(s142, 'MEXICO');
					s144 := SeparateWord(s143, 'YORK');
					s145 := SeparateWord(s144, 'CAROLINA');
					s146 := SeparateWord(s145, 'DAKOTA');
					s147 := SeparateWord(s146, 'OHIO');
					s148 := SeparateWord(s147, 'OKLAHOMA');
					s149 := SeparateWord(s148, 'OREGON');
					s150 := SeparateWord(s149, 'PENNSYLVANIA');
					s151 := SeparateWord(s150, 'ISLAND');
					s152 := SeparateWord(s151, 'TENNESSEE');
					s153 := SeparateWord(s152, 'TEXAS');
					s154 := SeparateWord(s153, 'UTAH');
					s155 := SeparateWord(s154, 'VERMONT');
					s156 := SeparateWord(s155, 'VIRGINIA');
					s157 := SeparateWord(s156, 'WASHINGTON');
					s158 := SeparateWord(s157, 'WISCONSIN');
					s159 := SeparateWord(s158, 'WYOMING');
					s160 := SeparateWord(s159, 'VENEZUELA');
					s161 := SeparateWord(s160, 'GUADALAJARA');
					s162 := SeparateWord(s161, 'GENERAL');
					s163 := SeparateWord(s162, 'PAKISTAN');
					s164 := SeparateWord(s163, 'HEALTH');
					s165 := SeparateWord(s164, 'GRADUATE', 'DS');
					s166 := SeparateWord(s165, 'CHINA');
					s167 := SeparateWord(s166, 'CHEMISTRY');
					s168 := SeparateWord(s167, 'COUNSELING');
					s169 := SeparateWord(s168, 'FELLOWSHIP');
					s170 := SeparateWord(s169, 'EDUCATION', 'A');
					s171 := SeparateWord(s170, 'RESEARCH', 'E');
					s172 := SeparateWord(s171, 'HOSPITAL', 'S');
					s173 := SeparateWord(s172, 'SCHOOL', 'S');
					s174 := SeparateWord(s173, 'LOCATION', 'S');
					s175 := SeparateWord(s174, 'PHILADELPHIA');
					s176 := SeparateWord(s175, 'NEUROPROTECTION');
					s177 := SeparateWord(s176, 'NURSING');
					s178 := SeparateWord(s177, 'CENTER', 'ES');
					s179 := SeparateWord(s178, 'METROPOLITAN');
					s180 := SeparateWord(s179, 'ACADEMY');
					s181 := SeparateWord(s180, 'SCOTLAND');
					s182 := SeparateWord(s181, 'DENTISTRY');
					s183 := SeparateWord(s182, 'ANESTHESIOLOGY');
					s184 := SeparateWord(s183, 'INTERNATIONAL');
					s185 := SeparateWord(s184, 'PHYSICIAN', 'S');
					s186 := SeparateWord(s185, 'MILWAUKEE');
					s187 := SeparateWord(s186, 'BIOSCIENCE', 'S');
					s188 := SeparateWord(s187, 'MARQUETTE');
					s189 := SeparateWord(s188, 'ENVIRONMENT', 'SA');
					s190 := SeparateWord(s189, 'PROFESSIONAL', 'S');
					s191 := SeparateWord(s190, 'PROFESSION', 'AS');
					s192 := SeparateWord(s191, 'MINNEAPOLIS');
					s193 := SeparateWord(s192, 'SPRINGFIELD');
					s194 := SeparateWord(s193, 'TECHNOLOGY');
					s195 := SeparateWord(s194, 'UNIVERSITATE');
					s196 := SeparateWord(s195, 'CHARLOTTE');
					s197 := SeparateWord(s196, 'SOUTHWESTERN');
					s198 := SeparateWord(s197, 'SOUTHEASTERN');
					s199 := SeparateWord(s198, 'NORTHWESTERN');
					s200 := SeparateWord(s199, 'NORTHEASTERN');
					s201 := SeparateWord(s200, 'UNIVERSIDAD');
					s202 := SeparateWord(s201, 'DOCTORAL');
					s203 := SeparateWord(s202, 'PSYCHOLOGY');
					s204 := SeparateWord(s203, 'REQUIRED');
					s205 := SeparateWord(s204, 'NICARAGUA');
					s206 := SeparateWord(s205, 'THIRUVANANTHAPURAM');
					s207 := SeparateWord(s206, 'CHIROPRACTIC');
					s208 := SeparateWord(s207, 'SASKATCHEWAN');
					s209 := SeparateWord(s208, 'UNIVERSITAET');
					s210 := SeparateWord(s209, 'PREVIOUSLY');
					s211 := SeparateWord(s210, 'MIDWESTERN');
					s212 := SeparateWord(s211, 'MIDEASTERN');
					s213 := SeparateWord(s212, 'CERTIFICATE');
					s214 := SeparateWord(s213, 'INSTITUTION', 'S');
					s215 := SeparateWord(s214, 'DUBLIN');
					s216 := SeparateWord(s215, 'IMMUNIZATION', 'S');
					s217 := SeparateWord(s216, 'DANNINGEN');
					s218 := SeparateWord(s217, 'GRADUATES');
					s219 := SeparateWord(s218, 'VANCOUVER');
					s220 := SeparateWord(s219, 'CINCINNATI');
					s221 := SeparateWord(s220, 'JESUITS');
					s222 := SeparateWord(s221, 'ADIRONDACK');
					s223 := SeparateWord(s222, 'CZECHOSLOVAKIA');
					s224 := SeparateWord(s223, 'OPHTHALMOLOGY');
					s225 := SeparateWord(s224, 'CLEARINGHOUSE');
					s226 := SeparateWord(s225, 'BLOOMINGTON');
					s227 := SeparateWord(s226, 'OSTEOPATHY');
					s228 := SeparateWord(s227, 'BIRMINGHAM');
					s229 := SeparateWord(s228, 'LOUISVILLE');
					s230 := SeparateWord(s229, 'FOUNDATION', 'S');
					s231 := SeparateWord(s230, 'ANTILLES');
					s232 := SeparateWord(s231, 'PEDIATRIC', 'S');
					s233 := SeparateWord(s232, 'FOUNDATIONS');
					s234 := SeparateWord(s233, 'INTERESTS');
					s235 := SeparateWord(s234, 'GEORGETOWN');
					s236 := SeparateWord(s235, 'AMERICA', 'NS');
					s237 := SeparateWord(s236, 'AMERICAN', 'AS');
					s238 := SeparateWord(s237, 'AMERICANA', 'S');
					s239 := SeparateWord(s238, 'AMERICANAS');
					s240 := SeparateWord(s239, 'AMERICANS');
					s241 := SeparateWord(s240, 'AMERICAS');
					s242 := SeparateWord(s241, 'ROCHESTER');
					s243 := SeparateWord(s242, 'SURGERY');
					s244 := SeparateWord(s243, 'BUCARAMANGA');
					s245 := SeparateWord(s244, 'KUMARAMANGALAM');
					s246 := SeparateWord(s245, 'THERAPY');
					s247 := SeparateWord(s246, 'EDWARDSVILLE');
					s248 := SeparateWord(s247, 'GERMANY');
					s249 := SeparateWord(s248, 'CARIBBEAN');
					s250 := SeparateWord(s249, 'DOCTORATE');
					s251 := SeparateWord(s250, 'CATHERINE');
					s252 := SeparateWord(s251, 'TRAINING');
					s253 := SeparateWord(s252, 'LOCATIONS');
					s254 := SeparateWord(s253, 'THEOLOGICAL');
					s255 := SeparateWord(s254, 'PHILIPPINE', 'S');
					s256 := SeparateWord(s255, 'PHILIPPINES');
					s257 := SeparateWord(s256, 'SACRAMENTO');
					s258 := SeparateWord(s257, 'PEDIATRICS');
					s259 := SeparateWord(s258, 'MANILLA');
					s260 := SeparateWord(s259, 'WESTERN');

					RETURN s260;
			END;

			STRING CleanName(STRING s) := FUNCTION
					Special_CHAR					:=	'|\\Â¦|@|\\$|%|Â¬||\\*|\\(|\\)|_|=|:|;|!|Â¢|\\}|\\.|\\{|\\?|\\|<|>|"|`|~|&|0x00|0xFF|0xBA|0xBB|0x5B|0x5D|\'';
					UC := lib_StringLib.StringLib.StringCleanSpaces(lib_StringLib.StringLib.StringToUpperCase(s));
					RemoveUnprinChar	:=	REGEXREPLACE ('[^[:print:]]', UC, '');
					Spec_Char := REGEXREPLACE (Special_CHAR,RemoveUnprinChar,'');
					replacedPunctuation := REGEXREPLACE('[,/\\#:\\(\\)*-+]', Spec_Char, ' ');
					spaceCleaned := Std.Str.CleanSpaces(replacedPunctuation);
					singleCharWordsCollapsed := REGEXREPLACE('(?<=(?<!\\pL)\\pL) (?=\\pL(?!\\pL))', spaceCleaned, '', NOCASE);
					removedEndingNumbers := REGEXREPLACE(' \\d+$', singleCharWordsCollapsed, '');
					removedEndingSingleLetters := REGEXREPLACE(' \\w$', removedEndingNumbers, '');

					RETURN TRIM(removedEndingSingleLetters, LEFT, RIGHT);
			END;

			cleanedString := CleanName(TRIM(iMedSchool,LEFT,RIGHT));
			initialTranslatedPhrases := TranslatePhrases1(cleanedString);
			words := SplitAndSequenceWords(initialTranslatedPhrases);
			withoutPrefixAndSuffix := CleanPrefixAndSuffixFromSequencedWords(words);
			translatedWords := TranslateSequencedWords(withoutPrefixAndSuffix);
			recombinedWords := RecombineWords(translatedWords);
			translatedPhrases := TranslatePhrases2(recombinedWords);
			recleanedName := CleanName(translatedPhrases);
			removeBad := IF(REGEXFIND(Constants.regexBadMedschool, recleanedName), '', recleanedName);
		 RETURN removeBad;
	END;

	import STD, ut;
	EXPORT CleanMedschoolName_Year(STRING120 iMedSchool) := FUNCTION
			RawDataRec := RECORD
					STRING120   medschool;
			END;
			WordRec := RECORD
					STRING          word;
			END;
			SeqWordRec := RECORD
					UNSIGNED1       seq;
					WordRec;
			END;

			DATASET(SeqWordRec) SplitAndSequenceWords(STRING s) := FUNCTION
					r10 := DATASET(Std.Str.SplitWords(s, ' '), WordRec);
					r20 := PROJECT
							(
									r10,
									TRANSFORM
											(
													SeqWordRec,
													SELF.seq := COUNTER,
													SELF.word := LEFT.word
											)
							);

					RETURN r20;
			END;

			Lowest_Year	 := '1900';
			Current_Year := ((STRING8)STD.Date.Today())[1..4];
			
			In_ds := DATASET(Std.Str.SplitWords(iMedSchool, ' '), WordRec);
			
			Year_DS := In_DS (LENGTH(TRIM(WORD,LEFT,RIGHT)) = 4 AND WORD BETWEEN LOWEST_YEAR AND Current_Year);
			
			Med_Year := Year_DS [1].word;
			
			RETURN Med_Year;
	END;

	IMPORT STD;
	EXPORT CleanNameComponent(STRING namePiece) := FUNCTION
		replaceInvalidName	:= REGEXREPLACE(Constants.NonNameChar, StringLib.StringCleanSpaces(namePiece), '');
		upperCleanSpaces		:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(replaceInvalidName));
		RETURN upperCleanSpaces;
	END;

	IMPORT ut;
	EXPORT CleanPhone(STRING in_phone) := FUNCTION
		BadPhones	:= ['2147483647', '9999999999'];
		GoodPhone	:= if(ut.CleanPhone(in_phone) IN BadPhones OR LENGTH(ut.CleanPhone(in_phone)) <> 10, '', ut.CleanPhone(in_phone));
		RETURN GoodPhone;
	END;

	import LIB_Word, STD;
	EXPORT STRING15 CleanProfessionalName (STRING100 Name) := FUNCTION
		Name_DS := DATASET ([{Name}],{STRING100 Name});
		w_rec := record
			string40 business_word;
		end;
		out_rec := record
			w_rec;
			integer word_count;
		end;
		d := record
			dataset (w_rec) ds {maxlength(20)};
		end; 
		w_rec getParts (recordof (Name_DS) l, integer c) := TRANSFORM,skip (LIB_Word.Word(L.Name,C) = '') // or std.str.countwords(l.cname, ' ') > 1)
			self.business_word := LIB_Word.Word(l.name,c);
		end;

		dsn := normalize (Name_DS,STD.STR.COUNTWORDS(LEFT.Name, ' '),getParts(LEFT,COUNTER));	
		PName_DS := JOIN (DSN,Constants.Prof_Name,TRIM(LEFT.Business_Word,ALL) = RIGHT.PNAME,TRANSFORM(W_REC, SELF := LEFT;));
		RETURN IF (EXISTS(PName_DS),PName_DS[1].Business_Word,'');
	END;

	EXPORT CleanTaxonomy(STRING taxonomy_in) := FUNCTION
		cleanTaxonomy := IF(taxonomy_in IN Constants.setTaxonomyIgnore, '', taxonomy_in);
		RETURN cleanTaxonomy;
	END;

	EXPORT CleanUPIN(STRING upin_in) := FUNCTION
		upperTrim := StringLib.StringToUpperCase(TRIM(upin_in ,ALL));
		removeNonAlphaNum := REGEXREPLACE(healthcare_provider_header_asHeader.Constants.NonAlphaNumChar, upperTrim, '');
		// valid upins are 1 letter, A-I, P-V, followed by 5 numbers
		isNotBogus := IF((REGEXFIND('[A-I,P-V]', removeNonAlphaNum[1]) AND (REGEXFIND('[0-9]{5}$', removeNonAlphaNum[2..]))),removeNonAlphaNum,'');  
		isValidUPIN := REGEXFIND('[A-Z0-9]{6}$', isNotBogus);
		RETURN IF(isValidUPIN, isNotBogus, '');
	END;
	
	EXPORT CleanEmail(STRING email_in)	:= FUNCTION
		cleanEmail := IF(REGEXFIND('[@]', TRIM(email_in)), TRIM(email_in), '');
		RETURN cleanEmail;
	END;

END;