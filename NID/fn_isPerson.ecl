import STD, lib_stringlib, Address;
export fn_isPerson := MODULE

shared boolean ProbableFirstName(string name) :=
	$.NameTester.IsFirstName(name) AND NOT $.NameTester.IsLastName(name);
	

shared boolean RepeatedLetters(string name) :=
	REGEXFIND('\\b([A-Z])\\1{2,}\\b', name);
	
shared rgxLastReversed := 	// VAN DELA DOS LE DU LA
	'^([A-Z]+) +(DI|DA|DEL|DES|DE|MC|VON|ST|EL)$';
		
shared rgxConsonants := '\\b([B-DF-HJ-NP-TVWXZ]{3,})\\b';	

shared string NameOrGen(string rgx, string s, integer2 pos, boolean getgen) := FUNCTION
		name := TRIM(REGEXFIND(rgx, s, pos, NOCASE),LEFT,RIGHT);
		RETURN IF (getgen, IF($.NameTester.IsSureGen(name),name,''),
							IF($.NameTester.IsSureGen(name),'',name));
END;



shared rgxHyphenatedSimplename := '^([A-Z]{2,})-([A-Z]{2,})$';
shared rgxCompoundFirstName := '^([A-Z]{2,})(ANN|ANNE|BETH|ELLEN|MAE|LYN|LYNN)$';
			
// check for hyphenated first names
shared boolean IsFirstNamePart(string name, string partname) :=
	NameTester.IsFirstNameBasic(partname) and ~NameTester.IsLastName(name)
		and (partname not in ['MAC','HAM','AB','AM','HEM','LAP','NORM']);

	
shared boolean IsFirstNameSlammed(string name) := MAP(
	$.NameTester.IsFirstNameEx(name) => true,
	LENGTH(name) > 3 AND $.NameTester.IsFirstNameBasic(name[1..LENGTH(name)-1]) => true,	// name & MI slammed
	false);

shared boolean IsPossibleFirstName(string name) := MAP(
	$.NameTester.IsFirstNameEx(name) => true,
	name in ['NFN','NMN', 'NMI'] => true,	// placeholder for name
	REGEXFIND('^[B-DF-HJ-NP-TVWXZ]{3,}$',name) =>	// three consonants
			NOT Address.SpecialNames.IsAbbreviation(REGEXFIND('^([B-DF-HJ-NP-TVWXZ]{3})$', name, 1)),
	false
	);
	
shared boolean InvalidFirstName(string name) := name in ['NFN','NMN','NMI','NT','ASS','BASTARD'];
	


shared boolean IsNickName(string name) := NOT $.NameTester.IsLastNameEx(name);

	
// for test only		



shared titles :=
 '\\b(MR|MRS|MS|MMS|MISS|DR|REV|RABBI|REVEREND|MSGR|PROF|FR|LT COL|COL|LCOL|LTCOL|LTC|CH|LT GEN|LT CDR|LCDR|LT CMDR|MAJ|SFC|SRTA|APCO|CAPT|CPT|SGT|SSG|MSG|MGR|CPL|CPO|SHRF|SMSG|SMSGT|SIR)\\b';
export string Title (string s, NameFormat n, string1 clue='U', string fullname='') := FUNCTION
	clnname := FormatName(s, n);
	return MAP(
		n = NameFormat.LcTF =>		REGEXFIND(rgxLcTF, s, 4),
		REGEXFIND(titles, fullname) => REGEXFIND(titles, fullname, 1),
		REGEXFIND(rgxMrMrs, fullname) => REGEXFIND(rgxMrMrs, fullname, 2),
		CASE(NameTester.genderEx(clnname[6..25],clnname[26..45]),
			'M' => 'MR',
			'F' => 'MS',
		'')
	);
END;

// first title of dual name
export string Title1 (string s, NameFormat n, string1 clue='U', string fullname='') := FUNCTION
	clnname := FormatName1(s, n);
	return MAP(
		REGEXFIND(titles, fullname) => REGEXFIND(titles, fullname, 1),
		REGEXFIND(rgxMrMrs, fullname) => REGEXFIND(rgxMrMrs, fullname, 2),
		CASE(NameTester.genderEx(clnname[6..25],clnname[26..45]),
			'M' => 'MR',
			'F' => 'MS',
		'')
	);
END;
export string Title2 (string s, NameFormat n, string fullname='') := FUNCTION
	clnname := FormatName2(s, n);
	return	CASE(NameTester.genderEx(clnname[6..25],clnname[26..45]),
			'M' => 'MR',
			'F' => 'MS',
			'');
END;

shared boolean IsHyphenatedFirstName(string s) := MAP(
	REGEXFIND('([A-Z]+)-([A-Z]+)', s) => NameTester.IsFirstName(s) OR
											NameTester.IsFirstName(REGEXFIND('([A-Z]+)-([A-Z]+)', s, 1)),
	NameTester.IsFirstname(s));
	

shared set of NameFormat ValidatedDualNameFormats := [
				NameFormat.FLSaFM,
				NameFormat.FLSaIFI,
				NameFormat.FLaFL,
				NameFormat.FLaFM,
				NameFormat.FMLSaFML,
				NameFormat.FMLaFL,
				NameFormat.FMLaFML,
				NameFormat.FMLaFML2,
				NameFormat.FMLaIFI,
				NameFormat.FMLcFML,
				NameFormat.FMSaFML,
				NameFormat.FMaFMLS,
				NameFormat.FMiaFMiL,
				NameFormat.LFaFMiS,
				NameFormat.FMiaFMiMiL,
				NameFormat.LFMaLFMS,
				NameFormat.FaFLS,
				NameFormat.FaFMLS,
				NameFormat.FiMiaFiL,
				NameFormat.FiaFiL,
				NameFormat.LFMSaFML,
				NameFormat.LFMaFML,
				NameFormat.LFMaFMS,
				NameFormat.LFMaFMiI,
				NameFormat.LFMaFiMiI,
				NameFormat.LFMaFiMiL,
				NameFormat.LFMaLFM,
				NameFormat.LFMaLFM2,
				NameFormat.LFMaLFM2S,
				NameFormat.LFMiaF,
				NameFormat.LFMiaFM,
				NameFormat.LFMiaFMiL,
				NameFormat.LFMiaIFI,
				NameFormat.LFaFL,
				NameFormat.LFaFMS,
				NameFormat.LFaFS,
				NameFormat.FSaFL,
				NameFormat.LFaLF,
				NameFormat.LFaLF1,
				NameFormat.LFaLFM,
				NameFormat.LFaLFM2,
				NameFormat.LFaLcF,
				NameFormat.LFiMiaFiMi,
				NameFormat.LFiaFi,
				NameFormat.LFiaFiL,
				NameFormat.LFiaFiMi,
				NameFormat.LSFMaFM,
				NameFormat.LSFaFM,
				NameFormat.LcFMSaLcFM,
				NameFormat.LcFMaF,
				NameFormat.LcFMaFMM,
				NameFormat.LcSFaFMM,
				NameFormat.LcFMaFMS,
				NameFormat.LcFMaLcF,
				NameFormat.LcFMaLcFM,
				NameFormat.LcFMaLcFS,
				NameFormat.LcFMiMiaFMM,
				NameFormat.LcFaFM,
				NameFormat.LcFaLcF,
				NameFormat.LcFaLcFM,
				NameFormat.LcFMSaLcFM,
				NameFormat.FMaFLS,
				NameFormat.MrMrs,
				NameFormat.LFMaFM,
				NameFormat.LFMSaFMM
			];


shared boolean IsDualFmtValid(string s) := MAP(
	//REGEXFIND('\\b[B-DF-HJ-NP-TVWXZ]+Q\\b', s) => false,
	//REGEXFIND('\\b[B-DF-HJ-NP-TVWXZ]{4,}\\b', s) => false,
	//REGEXFIND('\\b(PT|LT|FT|DL|JT|ERROR|EST)\\b',s) => false,  // unprocessed abbreviations
	REGEXFIND('\\b([B-DF-HJ-NP-TVWXZ]+Q|[B-DF-HJ-NP-TVWXZ]{4,}|PT|LT|FT|DL|JT|ERROR|EST)\\b',s) => false,

	REGEXFIND('\\b[A-Z] +OR +(JR|SR)$', s) => false,
	REGEXFIND('^[A-Z]+ +(JR|SR) *' + rgxConnector + ' *[A-Z]+$', s) => false,
	REGEXFIND('\\b(AND|OR)$', s) => false,
	REGEXFIND('^[A-Z]+ +[A-Z] +OR +[A-Z]+$', s) => false,	// LEE O OR DEES
	REGEXFIND('^[A-Z] *& *[A-Z]$', s) => false,
	REGEXFIND('^[A-Z] *& *[A-Z] +(RET|NLN|NMN)$', s) => false,
	REGEXFIND(rgxConnector + ' *(GUEST(S)?|PARENT(S)?|CHILD(REN?))\\b', s) => false,
	REGEXFIND(rgxLScFMM, s) => false,
	REGEXFIND('\\b([B-DF-HJ-NP-TVWXZ]{3})\\b', s) => 
					~SpecialNames.IsAbbreviation(REGEXFIND('\\b([B-DF-HJ-NP-TVWXZ]{3})\\b', s, 1)),
	true
);

IsLoQualityFirstName(string s) :=
	NameTester.IsLoPctFirstName(s)
	OR IsHyphenatedFirstName(s)
	OR LENGTH(s) = 1;

			
export boolean TestDualName(string lname, string fname1, string fname2) := FUNCTION
			segs := GetNameType(lname)+GetNameType(fname1)+GetNameType(fname2);

			return MAP(
					segs IN ['LLL','LLX',	// vary 3
									//'LBL',	// vary 2
									'LXL',	// vary 2
									'XLL','XLB','XLX',	// vary 1
									'XXL',				// 'XXX' let's assume XXX is a person
									'BLL','BLB','BLX',	// vary 1
									'BXL']							//'BXB','BXX'],
								=> IF(IsLoQualityFirstName(fname1) OR IsLoQualityFirstName(fname2), true, false),
					//segs = 'LLB' => NameTester.IsLoQualityFirstName(fname1),
					true);
							// removed 11/5: 'LBX','LXB',
//				segs IN ['FFL','FBL','BFL','BBL','XXX','FBL','FXL','BXL','XBL','BFB'] => 'F',
//				segs IN ['LFF','LFB','LFX','LBF','LBB','LBX','LXL','LXX','LXF','BFF','BBF','XBX','XFX'] => 'L',
//				segs in ['LLF','XLF','BLF'] => 'U',
END;

boolean TestLastName(string lname) := FUNCTION
			seg := GetNameType(lname);
			return (seg in ['L','B']) or ~NameTester.LikelyBizWord(lname);
END;
	


export boolean ValidDualName(string s, integer2 format) := FUNCTION
	fullname := FormatName1(s, format) + FormatName2(s, format);
	fname := TRIM(fullname[6..25]);
	fname2 := TRIM(fullname[76..95]);
	lname := TRIM(fullname[46..65]);
	lname2 := TRIM(fullname[116..135]);
//	segs := ExtractNameTypes4(rgxFaFML, s, 1, 4, 5, 6);
//	ord := GetNameOrderNNaNN(segs);
/*OUTPUT('Format: ' + WhichFormat(format));
OUTPUT('Fullname: ' + fullname);
OUTPUT('ValidDualName: fname ' + fname + ' lname ' + lname + ' name2: ' + fname2 + ' * ' + lname2);
//OUTPUT('segs ' + segs + ' order ' + ord);
OUTPUT(NameTester.IsFirstName(FName) OR NameTester.IsFirstName(FName2) 
				OR IsLastNameConfirmed(LName));*/
	return MAP (
			format = NameFormat.NoName OR NOT IsNameFormatDual(format) =>	false,
		$.NameTester.InvalidLastName(lname) => false,
		$.NameTester.InvalidLastName(lname2) => false,
			format IN ValidatedDualNameFormats =>	true,		// this is a validated format
			format = NameFormat.FiaFiL => TestLastName(lname),
			//format = NameFormat.FMLaFM  =>	(NameTester.IsFirstName(fname) OR NameTester.IsFirstName(TRIM(fullname[26..45])))
			//							OR NameTester.IsFirstName(fname2),
			format = NameFormat.FMLaFM => TestDualName(lname, fname, fname2),
			//format = NameFormat.LcFaF => NameTester.IsFirstName(FName) OR IsHyphenatedFirstName(FName2),
			format = NameFormat.LcFaF => TestDualName(lname, fname, fname2),
			//format = NameFormat.LFaF => IsLastNameExOrHyphenated(LName) OR 
			//					NameTester.IsFirstName(FName) OR
			//					NameTester.IsFirstName(FName2),
			format = NameFormat.LFaF => TestDualName(lname, fname, fname2),
			format = NameFormat.FaFL => true,
			format = NameFormat.LFaFM => IsLastNameExOrHyphenated(LName) OR 
								IsFirstNameOrInitial(FName) OR
								IsFirstNameOrInitial(FName2) OR
								IsFirstNameOrInitial(TRIM(fullname[96..115])), // middle name 2
			IsFirstNameOrInitial(FName) OR IsFirstNameOrInitial(FName2) 
				OR IsLastNameConfirmed(LName)
			);
END;
			
export boolean IsDualName(string s) := FUNCTION
	fmt := DualNameFormat(s);

	return MAP(
		fmt = NameFormat.NoName =>	false,
		NameTester.InvalidNameFormat(s) => false,
		/*NOT REGEXFIND(rgxConnector, s) AND NOT REGEXFIND(rgxFMLcFML,s) => false,
		REGEXFIND(rgxLScFMM, s) => false,
		REGEXFIND(rgxLcFMM, s) => false,
		REGEXFIND(rgxFMLcIII, s) => false,*/
		//REGEXFIND('\\b[B-DF-HJ-NP-TVWXZ]+Q\\b', s) => false,
		//REGEXFIND('\\b[B-DF-HJ-NP-TVWXZ]{4,}\\b', s) => false,
		//REGEXFIND('\\b(PT|LT|FT|DL|JT|ERROR|EST)\\b',s) => false,  // unprocessed abbreviations
		REGEXFIND('^[A-Z] +AND +[A-Z] +[A-Z]$',s) => false,
		REGEXFIND('\\b([B-DF-HJ-NP-TVWXZ]+Q|[B-DF-HJ-NP-TVWXZ]{5,}|PT|LT|FT|DL|JT|ERROR|EST)\\b',s) => false,
		REGEXFIND('^[A-Z] +(AND|&) +[A-Z]+ +[A-Z]$',s) => false,

		REGEXFIND('\\b[A-Z]+ *( AND | OR |&) *(JR|SR|II|III|IV)$', s) => false,
		REGEXFIND('^[A-Z]+ +(JR|SR) *' + rgxConnector + ' *[A-Z]+$', s) => false,
		REGEXFIND('^[A-Z]+ +[A-Z] +OR +[A-Z]+$', s) => false,	// LEE O OR DEES
		REGEXFIND('^[A-Z] *' + rgxConnector + ' *[A-Z]$', s) => false,
		REGEXFIND('^[A-Z] *& *[A-Z] +(RET|NLN|NMN|COL|REV|ESQ|ESQUIRE|MAJ)$', s) => false,
		REGEXFIND('^FIRM +', s) => false,
		//REGEXFIND('\\bAND GUEST(S)?$', s) => false,
		REGEXFIND(rgxConnector + ' *(GUEST(S)?|PARENT(S)?|CHILD(REN?)|TREASURER|DIRECTOR)\\b', s) => false,
		REGEXFIND(' *& *NT\\b', s) => false,
		SpecialNames.IsAbbreviation(REGEXFIND('\\b([B-DF-HJ-NP-TVWXZ]{3})\\b', s, 1)) => false,
		ValidDualName(s, fmt)
	);
END;

// check for a last name in the expected place
rgx_any := '([A-Z\'-]+)([^A-Z]+)?([A-Z\'-]+)?([^A-Z]+)?([A-Z\'-]+)?([^A-Z]+)?([A-Z\'-]+)?([^A-Z]+)?([A-Z\'-]+)?([^A-Z]+)?([A-Z]+)?([^A-Z]+)?([A-Z]+)?([^A-Z]+)?([A-Z]+)?';


// check for a first name in the expected place
//shared	titles := '^MMS\\b(.+)';

shared set of NameFormat LikelyNameFormats := [
	NameFormat.FL, NameFormat.LF, NameFormat.LFM, NameFormat.FLcS, NameFormat.FLS, NameFormat.LFS, NameFormat.FLSorLFS,
	NameFormat.FMLLS, NameFormat.FMSL, NameFormat.FiL,NameFormat.FiMLS,NameFormat.FiLS, //NameFormat.FiMiL,
	NameFormat.FMiL, NameFormat.FMiLS, NameFormat.LSFM, NameFormat.FMLSorLFMS,
	/*NameFormat.LFi,*/ NameFormat.LFiS, NameFormat.LFMS, NameFormat.LFMiS,	NameFormat.ILI,
	NameFormat.LcFMS, NameFormat.LcFMcS,NameFormat.LcFcMS,NameFormat.LcFcMcS,
	NameFormat.LScFM, NameFormat.LScFMM, NameFormat.LcScFM, NameFormat.LcScF, NameFormat.FcMcL, NameFormat.LScF,
	NameFormat.LcF, NameFormat.LFMi, NameFormat.LcFhF, NameFormat.FiIIL, NameFormat.SFL, NameFormat.FSL,
	NameFormat.FMMLS, NameFormat.LcFM, NameFormat.LcFMM, NameFormat.LcSFM, NameFormat.LcFS, NameFormat.LcFcS, NameFormat.LcTF,
	NameFormat.LFMicS, NameFormat.LFMiMi, NameFormat.FMLcIII, NameFormat.FMcSL, NameFormat.FMLcS,
	NameFormat.FccL,NameFormat.LLcFM
	];
	
shared set of NameFormat PossibleNameFormats := [
	NameFormat.FMiMiL		//,NameFormat.LcFcM
	];
	
/*export boolean IsLikelyPersonalNameFormat(NameFormat fmt) := 
	MAP(
		NOT validPersonNameFormat(fmt) => FALSE,
		fmt in LikelyNameFormats => TRUE,
		FALSE);
*/
//export boolean IsSomewhatLikelyPersonalNameFormat(NameFormat fmt) := 
//		fmt in [NameFormat.FLorLF,NameFormat.FMLorLFM,NameFormat.FMLL];


//shared boolean IsActualFirstName(string s) :=
//	IF(LENGTH(s) > 1, IsFirstNameEx(s), false);


shared set of NameFormat FirstNameFirst := [
	NameFormat.FL, NameFormat.FLcS, NameFormat.FLS, NameFormat.FMLLS, 
	NameFormat.FiML, NameFormat.FiL,NameFormat.FiMLS,NameFormat.FiLS,	//NameFormat.FiMiL,
	NameFormat.FMLcS, NameFormat.FMcSL, NameFormat.FMLcIII, NameFormat.FMiLS, NameFormat.FLL, NameFormat.FMiLI,NameFormat.ILI,
	NameFormat.FxL, NameFormat.FxLS, NameFormat.FxLL,	NameFormat.FSL, NameFormat.FML,NameFormat.FMSL,
	NameFormat.FMLL, NameFormat.FMiMiL, NameFormat.FMML, NameFormat.FMMLS, NameFormat.FiIIL, NameFormat.FMLyL,
	NameFormat.FccL, NameFormat.FcMcL
	];

shared set of NameFormat LastNameFirst := [
	NameFormat.LF, NameFormat.LFM, NameFormat.LFi, NameFormat.LFiS, NameFormat.LFMS, NameFormat.LFMiS, 
	NameFormat.LcFMS, NameFormat.LcFMcS, NameFormat.LScF, NameFormat.LScFM, NameFormat.LScFMM,
	NameFormat.LcScFM,NameFormat.LcScF,	NameFormat.LxFM,
	NameFormat.LcFMM, NameFormat.LcSFM, NameFormat.LFMi, NameFormat.LFiMi,
	/*NameFormat.LFMMi,*/ NameFormat.LFcMi, NameFormat.LSFM,
	NameFormat.LcF, NameFormat.LcFM, NameFormat.LcFcM, NameFormat.LcFcMS,NameFormat.LcFcMcS,
	NameFormat.LcFcS, NameFormat.LcFS, NameFormat.LLcFM, NameFormat.LLcFS, NameFormat.LcFhF,
	NameFormat.LFMiM, NameFormat.LFMiMi, NameFormat.LFMicS
	];
shared set of NameFormat NameFML := [
	NameFormat.FL, NameFormat.FLcS, NameFormat.FLS, NameFormat.FMLLS, 
	NameFormat.FiML, NameFormat.FiL,NameFormat.FiMLS,NameFormat.FiLS,	//NameFormat.FiMiL,
	NameFormat.FMLcS, NameFormat.FMcSL, NameFormat.FMLcIII, NameFormat.FMiLS, NameFormat.FLL, NameFormat.FMiLI,
	NameFormat.FxL, NameFormat.FxLS, NameFormat.FxLL, NameFormat.FML, NameFormat.FMSL,
	NameFormat.FMLL, NameFormat.FMiMiL, NameFormat.FMML, NameFormat.FMMLS,	NameFormat.FiIIL, NameFormat.FMLyL,
	NameFormat.FccL, NameFormat.FcMcL
	];

shared set of NameFormat NameLFM := [
	NameFormat.LF, NameFormat.LFM, NameFormat.LFi, NameFormat.LFMS, NameFormat.LFMiS, 
	NameFormat.LcFMS, NameFormat.LcFMcS, NameFormat.LScFM, NameFormat.LScFMM,
	NameFormat.LcFMM, NameFormat.LFMi, NameFormat.LFiMi,/*NameFormat.LFMMi,*/ NameFormat.LFcMi, 
	NameFormat.LcF, NameFormat.LcFM, NameFormat.LcFcM, NameFormat.LcFcMS,NameFormat.LcFcMcS,
	NameFormat.LcFcS, NameFormat.LLcFM, NameFormat.LLcFS, NameFormat.LxFM, NameFormat.LcFhF,
	NameFormat.LFMiM, NameFormat.LFMiMi, NameFormat.LFMicS
	];

// these names could be in any order
shared set of NameFormat FlippedNames := [NameFormat.FLorLF, NameFormat.FLSorLFS,NameFormat.FMLSorLFMS,
				NameFormat.FMiL, NameFormat.FSL];
// to replace IsProbableName
		//Persons.InvalidNameFormat(name) => MatchType.Inv,
		//Persons.IsJustLastName(name) => MatchType.Unclass,
export NameStatus := enum(UNSIGNED2, NotAName = 0, InvalidNameFormat = 1,
				StandaloneName = 2, 
				ProbableName = 3, PossibleName = 4, ImprobableName = 5,
				PossibleDualName = 6);
//types := ['X','F','L','B'];
string1 GetNameClass(string nm) :=
	types[IF (IsFirstNameOrInitial(nm),1,0) +
	//IF (IsLastNameConfirmed(nm),2,0) + 1];
	IF (IsValidLastName(nm),2,0) + 1];
	

NameStatus VerifyNameOrder(string2 s, string fname, string lname) := FUNCTION

	return MAP(
		s in ['FL','BL','FB','BB','LF','LB','BF'] => NameStatus.ProbableName,
		s in ['FF','LL','LB','FX','XF','BX','XB'] => NameStatus.PossibleName,
		s = 'XL' => IF(NameTester.LikelyBizWord(fname),NameStatus.ImprobableName,NameStatus.PossibleName),
		s = 'LX' => IF(NameTester.LikelyBizWord(lname),NameStatus.ImprobableName,NameStatus.PossibleName),
		NameStatus.ImprobableName
		);
END;


NameStatus VerifyName(string fname, string lname) := FUNCTION
	s := GetNameClass(fname) + GetNameClass(lname);
//OUTPUT('VerifyName: ' + s + ' fname: ' + fname + ' lname: ' + lname) ;
	return VerifyNameOrder(s, fname, lname);
END; 

NameStatus VerifyNameFL(string rgx, string s, integer f, integer l) :=
							VerifyName(REGEXFIND(rgxFLoLF, s, f), REGEXFIND(rgxFLoLF, s, l));


/*
NameStatus VerifyName2(string fname, string lname, string mname) := FUNCTION
	s := If(length(fname) > 1, GetNameClass(fname), GetNameClass(mname)) 
			+ GetNameClass(REGEXFIND('^([A-Z]+)\\b',lname, 1));
	return IF(REGEXFIND('^(BEN|AL) [A-Z]+$', lname), NameStatus.ProbableName,
					VerifyNameOrder(s,If(length(fname) > 1, fname, mname), lname));
END;
*/
NameStatus VerifyHyphenatedName(string fname, string lname) := FUNCTION
	s := IF(NameTester.IsFirstname(fname), 'F', 'X') +
		IF(IsLastNameEx(REGEXFIND(rgxDoubleName, lname, 1)) OR
			IsLastNameEx(REGEXFIND(rgxDoubleName, lname, 3)),'L','X');
	return IF(s='XX',NameStatus.PossibleName,NameStatus.ProbableName);
	//return VerifyNameOrder(s);
END;

NameStatus VerifyPossibleName(string fname, string lname) := 
	IF(NameTester.IsFirstname(fname) and IsLastNameEx(lname),NameStatus.ProbableName,NameStatus.PossibleName);


NameStatus VerifyNameFML(string fname, string mname, string lname) := FUNCTION
	segs := GetNameTypes(fname, lname, mname);
	segsFL := segs[1] + segs[3];		// FML
	segM := segs[2];

	return MAP(
//		segs = 'XXX' => NameStatus.ImprobableName,
		segs in ['FFX','FFL','FFB','FBX','FBL','FLL','FXL',
		         'BFX','BFB','BBX','BFL','BBL','BXL',
							'XFL','XBL','LLF','LFF','XBF'] => NameStatus.ProbableName,
		segs in ['FXX','FBX','FLX','LFX','LXX','LLB','LBX','LBF','BFX','BLX','BXX','XLX','XFX','XFB','XXL','LLX','XLX','XXF','XFF','XBB','XLL'] => NameStatus.PossibleName,
		segsFL = 'BB' => NameStatus.ProbableName,
		//segsFL = 'XX' => NameStatus.ImprobableName,
		segsFL in ['FF','LL','LB','BF'] => NameStatus.PossibleName,
		segsFL in ['BB','FL','FB','BL','LF'] => NameStatus.ProbableName,
		segsFL in ['BX','FX'] => IF(NameTester.LikelyBizWord(lname),NameStatus.ImprobableName,NameStatus.PossibleName),
		segsFL in ['XB','XL'] => IF(NameTester.LikelyBizWord(fname),NameStatus.ImprobableName,NameStatus.PossibleName),
		//segsFL in ['LX'] => NameStatus.ImprobableName,
		segM in ['F','B'] => NameStatus.PossibleName,
		IF(NameTester.LikelyBizWord(fname),NameStatus.ImprobableName,NameStatus.PossibleName)
	);
END;

NameStatus VerifyNameL(string lname) := CASE(
	GetNameType(lname),
	'F' => IF(NameTester.IsFirstNameBasic(lname),NameStatus.ImprobableName,NameStatus.PossibleName),
	'X' => NameStatus.PossibleName,
	NameStatus.ProbableName
	);

NameStatus VerifyNameFLL(string s) := FUNCTION
	segs := ExtractNameTypesFML(rgxFLL, s, 1, 2, 5);

	return MAP(
//		segs = 'XXX' => NameStatus.ImprobableName,
		segs[1] IN ['F','B'] AND (segs[2] IN ['B','L'] OR segs[2] IN ['B','L']) => NameStatus.ProbableName,
		segs[1] IN ['F','B'] OR segs[2] IN ['B','L'] OR segs[2] IN ['B','L'] => NameStatus.PossibleName,
		IF(NameTester.LikelyBizWord(s),NameStatus.ImprobableName,NameStatus.PossibleName)
	);
END;

rgxStreet := '^[0-9]+.+ (ROAD|RD|STREET|ST|AVE|AVENUE|DRIVE|DR|PLACE|PATH|LANE|LN|WAY|WY)$';		// street address only

export NameStatus ValidatePersonalName(string name,string1 hint='U') := FUNCTION
	//n := PersonalNameFormat(name);
	n := SingleNameFormat(name);
	fullname := FormatName(name, n);
	fname := TRIM(fullname[6..25]);
	mname := TRIM(fullname[26..45]);
	lname := TRIM(fullname[46..65]);

	return MAP (
		n = $.mod_NameFormat.NameFormat.NoName => NameStatus.NotAName,
		$.NameTester.InvalidLastName(lname) AND lname<>'' => NameStatus.InvalidNameFormat,
		$.NameTester.InvalidFirstName(fname) AND fname<>'' => NameStatus.InvalidNameFormat,
		$.NameTester.IsBusinessWord(fname) OR NameTester.IsBusinessWord(mname) OR NameTester.IsBusinessWord(lname) => NameStatus.ImprobableName,
		n in LikelyNameFormats => NameStatus.ProbableName,		
		REGEXFIND(rgxFLhL, name) => VerifyHyphenatedName(REGEXFIND(rgxFLhL, name, 1),REGEXFIND(rgxFLhL, name,2)),
		REGEXFIND(rgxStreet, name) => NameStatus.InvalidNameFormat,
		n = NameFormat.LFi => VerifyNameL(lname),
		n IN PossibleNameFormats => VerifyPossibleName(fname,lname),
		n = NameFormat.FMLL => VerifyNameFML(fname,mname,lname),
					//VerifyName2(fname,mname,lname),
		n = NameFormat.FLorLF => VerifyNameFL(rgxFLoLF, name, 1, 3),
		/*n in [NameFormat.FLorLF, NameFormat.FLSorLFS,NameFormat.FMLSorLFMS,
				NameFormat.FMiL, NameFormat.FSL] =>
					VerifyName(FirstName(name, n, hint),LastName(name, n, hint)),*/
		n = NameFormat.LFiMi => IF(IsLastNameEx(lname),
									NameStatus.ProbableName,NameStatus.PossibleName),
		//n = NameFormat.FMLorLFM => VerifyNameFML(REGEXFIND(rgxFMLorLFM, name, 1),
		//									REGEXFIND(rgxFMLorLFM, name, 4),REGEXFIND(rgxFMLorLFM, name, 5)),
		n in [NameFormat.FMLorLFM,NameFormat.LcFcM] => VerifyNameFML(fname,mname,lname),
		n = NameFormat.FLL => VerifyNameFLL(name),
		n = NameFormat.LFMMi => VerifyNameFML(fname,mname,lname),
		n = NameFormat.FiML => VerifyPossibleName(mname,lname),
		n = NameFormat.L => CASE(GetNameType(lname),
								'F' => NameStatus.ImprobableName,
								NameStatus.StandaloneName),
		n = NameFormat.LS => NameStatus.StandaloneName,
		VerifyName(fname,lname)
	);

END;

export NameStatus NameQuality(string name,string1 hint='U') := 
	MAP(
		TRIM(name) = '' => NameStatus.NotAName,
		NameTester.InvalidNameFormat(name) => NameStatus.InvalidNameFormat,
//		REGEXFIND(rgxConnector, name) => IF(IsDualName(name),	NameStatus.PossibleDualName,
//									NameStatus.InvalidNameFormat),
//		REGEXFIND(rgxConnector, name) => NameStatus.PossibleDualName,
		REGEXFIND(rgxConnector, name) => If(DualNameFormat(name) = 0, NameStatus.InvalidNameFormat, NameStatus.PossibleDualName),
		IsJustLastName(name) => NameStatus.StandaloneName,
		ValidatePersonalName(name,hint)
		);

// for test purposes
export string3 NameQualityText(string s,string1 hint='U') :=
	CASE(NameQuality(s,hint),
		NameStatus.NotAName => 'NAN',
		NameStatus.InvalidNameFormat => 'INV',
		NameStatus.StandaloneName => 'STA',
		NameStatus.ProbableName => 'YES',
		NameStatus.PossibleName => 'MAY',
		NameStatus.ImprobableName => 'NO ',
		NameStatus.PossibleDualName => 'DUL',
		'?');
		


// matches a supported name format
export boolean IsPossibleName(string name) := IF(
		TRIM(name) = '' OR
		REGEXFIND(rgxConnector, name) OR
		NameTester.InvalidNameFormat(name) OR
		IsJustLastName(name) OR
		SingleNameFormat(name) = NameFormat.NoName,
		false, true);
		
// matches a likely name format

export boolean IsLikelyNameFormat(string name) := IF(
		TRIM(name) = '' OR
		REGEXFIND(rgxConnector, name) OR
		NameTester.InvalidNameFormat(name) OR
		IsJustLastName(name),
		false,
			SingleNameFormat(name) IN (LikelyNameFormats + [NameFormat.FLorLF]));
	
//export boolean IsLikelyName(string name) := 
		//IF (NameQuality(name) = NameStatus.ProbableName, true, false);
		
export boolean IsLikelyName(string name) := 
	IF(ValidatePersonalName(name) in [NameStatus.ProbableName,NameStatus.PossibleName], true, false);



export boolean IsPossibleDualName(string name) := IF(
		TRIM(name) = '' OR
		~REGEXFIND(rgxConnector, name) OR
		~IsDualFmtValid(name) OR
		DualNameFormat(name) = NameFormat.NoName,
		false, true);





string FixGen(string suffix) :=
		CASE(suffix,
			//'1' => '',	//'SR',
			//'2' => 'JR',
			//'3' => 'III',
			//'4' => 'IV',
			//'5' => 'V',
			//'6' => 'VI',
			//'7' => 'VII',
			//'8' => 'VIII',
			//'9' => 'IX',
			'JR' => 'JR',
			'JR,' => 'JR',
			'SR' => 'SR',
			'I' => 'I',
			'II' => 'II',
			'II,' => 'II',
			'III' => 'III',
			'IV' => 'IV',
			'IIII' => 'IV',
			'V' => 'V',
			//'1ST' => 'I',
			'2N' => 'II',
			//'2ND' => 'II',
			'ND' => 'II',
			//'3RD' => 'III',
			'RD' => 'III',
			'3 I' => 'III',
			//'4TH' => 'IV',
			//'5TH' => 'V',
			'000' => '',
			suffix);

/***
	assumes that last word is a suffix and convert to alphs
***/
export string SuffixToAlpha(string name) := FUNCTION
	suffix := REGEXFIND('^.+[ ,]([A-Z0-9]+)$', name, 1);
	return IF (suffix = '', name,
			TRIM(REGEXREPLACE('^(.+)([ ,])([A-Z0-9]+)$', name,
			'$1$2') + FixGen(suffix)));	
END;


export string140 CleanName(string name, string1 hint='U') := FUNCTION
	s := PrecleanName(name);
	
	NameFormat fmt := IF(hint = 'U',SingleNameFormat(s),NameFormat.NoName);
	clue := MAP(
		fmt = NameFormat.NoName => Std.str.ToUpperCase(hint),
		fmt IN NameFML	=> 'F',
		fmt IN NameLFM	=> 'L',
		'U'
	);

	RETURN CASE(clue,
		'F'	=> CleanPersonFML73(s)[1..70],
		'L'	=> CleanPersonLFM73(s)[1..70],
		'D' => CleanDualName140(s),
		CleanPerson73(s)[1..70]
	);

END;


END;
//EXPORT fn_isPerson := 'todo';