/*****
 This attribute is used by the name repository
 to preclean a name before cleaning it
 it removes punctuation and tokens that are not part of a name
******/
import STD, Nid;
rgxGen := '(JR|SR|I|II|III|IV|V|VI|2ND|3RD|4TH|5TH|6TH|1|2|3|4|5|6|7|8|9)';
rgxSureGen := '(JR|SR|II|III|IV|2ND|3RD|4TH|5TH|6TH)';
rgxHonor := 
 '(MD|DMD|DDS|CNFP|CNM|CNP|CPA|CSW|DR|PHD|ESQ|RN|RPN|LPN|LN|DO|DC|DPM|DPC|DD|LMT|DVM|PSYD|ASID|CLU|JD|OD|CFP|AA|AS|NP|FNP|ARNP|MSW|LCSW|LSW|ACSW|LMHC|LMFT|CMT|LPCC|MA|SJ|OP|MBA|MSD|CTM|DTM|CPS|ADJ|DWP|SEC|VDM|VMD|PA-C|PA|RPA-C|RPA|APA-C|CSJ|SSJ|BVM|CSC|MSN|CPNP|FNP|CRNP|PBLN|PMLN|RLTR|LRCP|CRNA|MBBS|PNP|RNP|CNS|CMS|CMRS|LMHP|LIMHP|PLMHP|MDIV|CEO|CFO)';
rgxSureHonor := 	// no oriental names
 '(MD|DMD|DDS|CNFP|CNM|CNP|CPA|CSW|DR|PHD|ESQ|RN|RPN|LPN|LN|DC|DPM|DPC|DD|LMT|DVM|PSYD|ASID|CLU|JD|OEmergency Medical D|CFP|AA|NP|ARNP|MSW|LCSW|LSW|ACSW|LMHC|LMFT|CMT|LPCC|SJ|OP|MBA|MSD|CTM|DTM|CPS|ADJ|DWP|SEC|VDM|VMD|PA-C|PA|RPA-C|RPA|APA-C|CSJ|SSJ|BVM|CSC|MSN|CPNP|FNP|CRNP|PBLN|PMLN|RLTR|LRCP|CRNA|MBBS|PNP|RNP|CNS|CMS|C<RS|LMHP|LIMHP|PLMHP|MDIV|CEO|CFO)';
rgxSuffix := '(' + rgxGen + '|' + rgxHonor + ')';
rgxSureSuffix := '(' + rgxSureGen + '|' + rgxSureHonor + ')';
rgxLast := '(DI |DA |DEL |DE LA |DE LOS |DES |DE |DELLA |DELLO |DOS |DU |LA |MC |VON |VAN DER |VAN |VANDER |VANDEN |ST |EL |LE |[ODANL]\')?([A-Z]+[A-Z\'-]+)';
rgxFccL := '^([A-Z]+),,(' + rgxLast + ')$';	// missing middle name
rgxMrMrs := '\\b((MR|MRS|DR|REV) *(&| AND ) *(MR|MRS|MS))\\b';
titles :=		
 '\\b(MR|MRS|MS|MMS|MISS|DR|RABBI|REVEREND|MSGR|PROF|PROFESSOR|FR|LT COL|COL|LCOL|LTCOL|LTC|CH|LT GEN|LT CDR|LCDR|LT CMDR|CDR|MAJ GEN|MAJ|RADM|SFC|SRTA|APCO|CAPT|LT|CPT|SGT|MSGT|SSG|MSG|MGR|CPL|CPO|SHRF|SMSG|SMSGT|SIR)\\b';
rgxConnector := 	'( AND |&| OR | AND/OR |&/OR |\\+)';
rgxDegreesBracketed := 
 '\\((M\\.D\\.|D\\.M\\.D\\.|D\\.D\\.S\\.|D\\.P\\.M\\.|D\\.V\\.M\\.|R\\.N\\.|C\\.P\\.A\\.|J\\.D\\.|PH\\.D\\.|D\\.O\\.|M\\.S\\.N\\.)\\)$';
 //'\\((M.D.|D.M.D.|D.D.S.|D.P.M.|D.V.M.|R.N.|C.P.A.|J.D.|PH.D.|D.O.|M.S.N.)\\)$';
rgxDegreesSpread := '([, ]+(D\\. M\\. D\\.|M\\. D\\.) *)$';
rgxDegreeException := '^[A-Z]+, *[A-Z]\\. +[A-Z]\\.$';

string SlamPeriods(string s) := FUNCTION
	t := MAP(
		REGEXFIND(rgxDegreesBracketed, s) => REGEXREPLACE(rgxDegreesBracketed, s, ''),
		REGEXFIND(rgxDegreesSpread, s) AND NOT REGEXFIND(rgxDegreeException,s) => REGEXREPLACE(rgxDegreesSpread, s, ''),
		REGEXFIND('[ ,][A-Z]\\.[A-Z]\\.[A-Z]\\.?$', s) =>
			REGEXREPLACE('([ ,])([A-Z])\\.([A-Z])\\.([A-Z])\\.?$',s,'$1$2$3$4'),
		REGEXFIND('[ ,](J\\.R\\.?)$', s) =>
			REGEXREPLACE('([ ,])(J\\.R\\.?)$',s,'$1J R'),
		REGEXFIND('[ ,][A-Z]{1,2}\\.[A-Z]\\.?$', s) =>
			REGEXREPLACE('([ ,])([A-Z]{1,2})\\.([A-Z])\\.?$',s,'$1$2$3'),
		REGEXFIND('[ ,][A-Z]\\.[A-Z]\\.[A-Z]\\.? +', s) =>
			REGEXREPLACE('([ ,])([A-Z])\\.([A-Z])\\.([A-Z])\\.?', s, '$1$2$3$4 '),
		s
		);
	return IF(REGEXFIND('^[A-Z]\\.[A-Z]\\. ', t), t[1] + ' ' + t[3..], t);
END;
string RemoveNickname(string s) :=
	REGEXREPLACE('([("][A-Z]+[)"])$',s,'');
//	REGEXREPLACE('(\\([A-Z]+\\))$',s,'');
	
rgxSpouse := rgxConnector + ' *(WIFE|WF|HUSBAND|HUSB|SPOUSE)[ ,]+[A-Z]+';
rgxHusbandWife := '^.+[, ]HUSBAND .+WIFE$';
rgxHusbandWifeAtEnd := '\\b(HUSBAND|WIFE|HUSBAND WIFE)[)]?$';
string RemoveMrMrs(string s1) := FUNCTION
 s := TRIM(s1);
	return MAP(
	REGEXFIND(rgxMrMrs, s) => REGEXREPLACE(rgxMrMrs, s, ''),
	REGEXFIND('^SW ', s) => TRIM(s[4..],LEFT),
	REGEXFIND('^ML ', s) => TRIM(s[4..],LEFT),
	REGEXFIND('^EST ', s) => TRIM(s[5..],LEFT),
	REGEXFIND('\\b(HUSBAND|WIFE) *( AND |&) *(WIFE|HUSBAND)$',s) => REGEXREPLACE('\\b(HUSBAND|WIFE) *( AND |&) *(WIFE|HUSBAND)$',s, ''),
	REGEXFIND('( AND |&) *(HIS|HER) +(HUSBAND|WIFE)\\b',s) => REGEXREPLACE('\\b(HIS|HER) +(HUSBAND|WIFE)\\b',s, ''),
	REGEXFIND('(' + rgxConnector + ' *(ANO|WIFE|WF|JLRS|GUEST(S)?|PARENT(S)?|CHILD(REN?)))$', s) => // ANO = ANOther (i.e. anonymous)
		REGEXREPLACE('(' + rgxConnector + ' *(ANO|WIFE|WF|JLRS|GUEST(S)?|PARENT(S)?|CHILD(REN?)))$', s,''),
	REGEXFIND(rgxSpouse, s) => REGEXREPLACE('\\b(WIFE|WF|HUSBAND|HUSB|SPOUSE)\\b', s, ''),
	REGEXFIND(rgxHusbandWife, s) => REGEXREPLACE('\\b(WIFE)$', REGEXREPLACE('\\b(HUSBAND)\\b', s, '&'), ''),
	REGEXFIND(rgxHusbandWifeAtEnd, s) => REGEXREPLACE(rgxHusbandWifeAtEnd, s, ''),
	s);
END;	

rgxIsHonor := '[ /,-]+' + rgxHonor + '\\b';
rgxHonorFirst := '^' + rgxHonor + ' +([A-Z-]+ +.+)$';
rgxMAException := '^MA +(' + rgxLast + ')$';	// so ^MA does not get stripped out by HonorFirst
//rgxExtractHonor := '^(.+) +' + rgxHonor + ' *(.*)$';
rgxDegrees := 
 '^(MD|DMD|DDS|DPM|DVM|RN|CPA|BSC|BTR|SPC)\\b';	// removed JD cuz it is a name
rgxDegreesAtEnd := 
	'\\b(C\\. P\\. A\\.|M\\. D\\.|D\\. D\\. S\\.|D\\. M\\. D\\.|D\\. V\\. M\\.|D\\. P\\. M\\.)$'; 
	//'\\b(C. P. A.|M. D.|D. D. S.|D. M. D.|D. V. M.|D. P. M.)$'; 

string FixAndOr(string s) :=
	IF(REGEXFIND('\\bAND OR\\b',s),
		REGEXREPLACE('\\bAND OR\\b',s, ' AND/OR '), s);
		
string FixNMN(string s) :=
	IF(s[1..4] in ['NFN','NMI ','NMN '],s[5..],s);
	
rgxGenFirst := '^' + rgxSureGen + ' +(.+)$';
rgxStreet1 := '^[0-9] .+ (ROAD|RD|STREET|ST|AVE|AVENUE|DRIVE|DR|PLACE|PATH|LANE|LN|WAY|WY)\\b';		// street address only
string ReverseGen(string s) := 
	MAP(
			REGEXFIND(rgxGenFirst, s) => REGEXREPLACE(rgxGenFirst, s, '$2 $1'),
			REGEXFIND('^[0-9] [0-9]', s) => s,	
			REGEXFIND('^[0-9] *& *[0-9]', s) => s,	
			REGEXFIND(rgxStreet1, s) => s,	
			REGEXFIND('^ *"?(\\d"? *, *"?OFFICER"?)\\b', s) => REGEXREPLACE('^ *"?(\\d"? *, *"?OFFICER"?)\\b', s, ''),	// yes, this is a special case
			REGEXFIND('^[0-9] ', s) => TRIM(s[2..],LEFT,RIGHT),	
			REGEXFIND('^(0)\'[A-Z]', s) => 'O'+s[2..],	
	s);

	rgxAKA0 := '^([A-Z]+), ([A-Z]+) (AKA|FKA|NKA) +(.+)$';
	rgxAKA1 := '^([A-Z]+) +(AKA|FKA|NKA) +[^,]+, *(.+)$';
	rgxAKA2 := '^([^,]+), *([A-Z]+) +(AKA|FKA|NKA) +(.+)$';
	rgxAKA3 := '^([A-Z]+) +(AKA|FKA|NKA), +(.+)$';
	rgxAKA4 := '^([A-Z]+), ([A-Z]+ [A-Z]+) (AKA|FKA|NKA) +(.+)$';
	rgxAKA5 := '^([A-Z]+), ([A-Z]+ [A-Z]+ [A-Z]+) (AKA|FKA|NKA) +(.+)$';
	rgxAKA6 := '^([A-Z ,]+)([(/](AKA|FKA|NKA)[ ,][^)]+\\)?)$';
	rgxAKA7 := '\\b(AKA|FKA|NKA)[ ,]*$';
	rgxAKA8 := '^([A-Z]+ [A-Z]+( [A-Z]+)?) (AKA|FKA|NKA) ([A-Z]+ [A-Z]+( [A-Z]+)?)$';
	rgxJohnDoe1 := '^(JOHN|JANE) DOE AKA +(.+)$';
string RemoveAKA(string s) := MAP(
	s[1..4] in ['AKA ','FKA ','NKA '] => s[5..],
	s[1..4] in ['AKA,','FKA,','NKA,'] => TRIM(s[5..],LEFT),
	// 'JOHN DOE AKA BARSHEE, M JOHNSON';
	REGEXFIND(rgxJohnDoe1, s) => REGEXREPLACE(rgxJohnDoe1, s, '$2'),
	// ORTEGA, ROBERT JOE AKA BOBB
	REGEXFIND(rgxAKA0, s) => REGEXREPLACE(rgxAKA0, s, '$1, $2'),
	//STONE AKA GRAVEEN, BETTY JANE
	REGEXFIND(rgxAKA1, s) => REGEXREPLACE(rgxAKA1, s, '$1, $3'),
	//ORTIZ, RAYMOND AKA (BOZO)
	REGEXFIND(rgxAKA2, s) => REGEXREPLACE(rgxAKA2, s, '$1, $2'),
	//'ORTIZ AKA, BOZO';
	REGEXFIND(rgxAKA3, s) => REGEXREPLACE(rgxAKA3, s, '$1, $3'),
	//'ORTIZ, RAYMOND JAMES AKA BOZO';
	REGEXFIND(rgxAKA4, s) => REGEXREPLACE(rgxAKA4, s, '$1, $2'),
	//DELEE, OTIS D THOMPSON AKA DORO
	REGEXFIND(rgxAKA5, s) => REGEXREPLACE(rgxAKA4, s, '$1, $2'),
	// 'BRADFORD, JAMES S (AKA, JIMBO BRADFORD)';
	REGEXFIND(rgxAKA6, s) => REGEXREPLACE(rgxAKA6, s, '$1'),
	// 'BRADFORD, JAMES S (AKA)';
	REGEXFIND(rgxAKA7, s) => Std.Str.ExcludeLastWord(s),
	// LAURIA A AQUILINA FKA LAURIE A. DABNEY                                                                                                                
	REGEXFIND(rgxAKA8, s) => REGEXREPLACE(rgxAKA8, s, '$1 & $4'),

	REGEXFIND('( (AKA|FKA|NKA) )', s) => REGEXREPLACE('( (AKA|FKA|NKA) )', s, ' '),
	//StringLib.StringFind(s, ' AKA ', 1) > 0 => StringLib.StringFindReplace(s, ' AKA ', ' '),
	StringLib.StringFind(s, '-AKA-', 1) > 0 => StringLib.StringFindReplace(s, '-AKA-', '-'),
	REGEXFIND('(/AKA)$', s) => REGEXREPLACE('(/AKA)$', s, ''),
	REGEXFIND('([A-Z])/AKA\\b', s) => REGEXREPLACE('([A-Z])/AKA\\b', s, '$1 '),
	REGEXFIND('^(ALSO KNOWN AS)\\b', s) => REGEXREPLACE('(ALSO KNOWN AS)', s, ' '),
	REGEXFIND('( [AF]KA)$',s) => REGEXREPLACE('( [AF]KA)$',s,''),
	s);
	
rgxTrustees := '\\b((AS |JOINT )?TRUSTEE(S)?|AS (JT|JTWRS|TRUS|MOTHER|FATHER|PARENT)|TRUSTE|TTEE|TTEES|TRS JJS TR|TRS|TRSTE|TRST|TRSTES|TRSTEE|TRU|TTE|REV TRT|TE|JT TR|TR|COTR|TRUST OFFICER|EXECUT(OR|RIX)|ASSIGNEE|JT/RS|JTRS|JT SUR|JT SURV|JT LIVES|JT TEN|JT TNTS|JT WROS|TNTS|LESSEE)\\b';
rgxCoTrustees := '\\b(CO[ -]+(TRUSTEE|TRUSTE|TRUSTEES|TRSTEE|TTEE|TRS|TRSTE|TRU|TTE|TR|EXECUT(OR|RIX)))\\b';
//rgxEtAl := '\\b(ET UM|ETAL|ET AL|ET ALS|ETALS|ET UX|ET-UX|ETUX|ET VIR|ET)\\b';
rgxEtAl := '\\b(ETAL|ET AL|ET ALS|ETALS)\\b';
rgxEtuxInterjected := '(JR|SR|II|III|IV) (ETUX|ET UX|ET-UX|ET UM|ETUM|ET VIR|ETVIR) [A-Z]+';
rgxEtuxDual := '[A-Z]+ (ETUX|ET UX|ET-UX|ET UM|ETUM|ET VIR|ETVIR|& ETUX|(AND |&) *(HIS |HER )? *(HUSBAND|WIFE)) [A-Z]+';
rgxEtux := '\\b(ETUX|ET UX|ET-UX|ET UM|ETUM|ET VIR|ETVIR)\\b';
rgxEtuxAtEnd := '\\b(ET ?UX ET ?AL|ET ?AL ET ?UX|ETUX|ET UX|ET-UX|ET UM|ETUM|ET VIR|ETVIR|UX|ET|AND|OR|LTR(S)?|MKD|MCC|VLB|RF|TRT|MB|HRS|TST|TLT|RTS|TTS|TRSRS|HSB|JP|FC|FST|LW|HWJT|HWLP|RLT|RVT|LVG|DTD|MGP|JTV|RVC|PMB|COC|CPRS|CPWR(S)?|JTS|JTWRS|JT/ROS|[JKD]/REF|TRU ST|HUSBAND *( AND |&) *WIFE)$';
rgxEtuxAtFront := '^(&? *(ETUX|ET UX|ET-UX|ET UM|ETUM|ET VIR|ETVIR))\\b';
rgxEtuxAtFrontDbl := '^(&? *(ETUX|ET UX|ET-UX|ET UM|ETUM|ETAL|ET VIR|ETVIR) *& *(ETUX|ET UX|ET-UX|ET UM|ETUM|ETAL|ET AL|ET VIR|ETVIR|ET|H&W))';
rgxEtuxAssumed := '^[A-Z]+ +(ETVIR|ET VIR|ETUX|ET UX) +[A-Z]+$';	// man and/or wife

rgxRT := '\\b(RT|JT)$';
rgxSlashTrustee := '(/(TE|TR|JT))\\b';
rgxInmate := '\\b(INMATE # *[A-Z0-9]+)\\b';

RemovePaDoMa(string s) := IF(
REGEXFIND('(& *(PA|DO|MA|ET))$', s), REGEXREPLACE('(& *(PA|DO|MA|ET))$', s,''), s);

//remove etal, etux, etc.
RemoveEtAl(string s) := FUNCTION 
				s1 :=	MAP(
						REGEXFIND(rgxEtuxAtEnd, s) => REGEXREPLACE(rgxEtuxAtEnd, s,''),
						REGEXFIND(rgxEtuxAssumed, s) => REGEXREPLACE('(ETVIR|ET VIR|ETUX|ET UX)', s,''),
						REGEXFIND(rgxEtuxDual, s) => REGEXREPLACE(rgxEtux, s,'&'),
						REGEXFIND(rgxEtuxAtFrontDbl, s) => REGEXREPLACE(rgxEtuxAtFrontDbl, s,''),
						REGEXFIND(rgxEtuxAtFront, s) => REGEXREPLACE(rgxEtuxAtFront, s,''),
						REGEXFIND(rgxEtAl, s) => REGEXREPLACE(rgxEtAl, s,''),
						s);
				RETURN IF(REGEXFIND(rgxEtAl, s1), REGEXREPLACE(rgxEtAl, s1,''), s1);
END;

rgxMispelledTrust := ' (TRU ST|TRUS, T|TR, UST)$';
CheckMispelledTrust(string s) := IF(REGEXFIND(rgxMispelledTrust, s), REGEXREPLACE(rgxMispelledTrust, s, ' TRUST'), s);

rgxTitles := '^((ARCH)?BISHOP|HONOU?RABLE|(IR)?REVOCABLE) +[A-Z]+ +[A-Z]+ +[A-Z]+$';
rgxTitles1 := '^((ARCH)?BISHOP|HONOU?RABLE|(IR)?REVOCABLE)';
regxRevocable := '\\b((IR)?REVOCABLE)$';

RemoveTrustAndDegrees(string s) := 
			CheckMispelledTrust(
					MAP(
						REGEXFIND(rgxSlashTrustee, s) => REGEXREPLACE(rgxSlashTrustee, s, ' '),
						
						Nid.Trusts.IsTrust2BeginOrEnd(s) => Nid.Trusts.StripTrust2Words(s),
						
						REGEXFIND('^[A-Z-]+ +(MA|DO|TE)$', TRIM(s)) => s,
						REGEXFIND('^[A-Z-]+ +[A-Z] +(MA|DO)$', TRIM(s)) => s,
						REGEXFIND('^[A-Z-]+ *(&| AND ) *[A-Z]+ +(MA|DO|TE)$', TRIM(s)) => s,
						REGEXFIND('^[A-Z-]+ +(MA|DO|TE) +(JR|SR|II|III)$', TRIM(s)) => s,
						REGEXFIND('^[A-Z-]+ +[A-Z]+ +(MA|DO|TE) +(JR|SR|II|III)$', TRIM(s)) => s,
						REGEXFIND('^[A-Z-]+ +[A-Z]+ [A-Z]+ +(MA|DO|TE|LE)$', TRIM(s)) => TRIM(s[1..LENGTH(s)-3]),
						REGEXFIND(rgxCoTrustees, s) => REGEXREPLACE(rgxCoTrustees, s,''),
						REGEXFIND(rgxTrustees, s) => REGEXREPLACE(rgxTrustees, s,''),

						REGEXFIND(rgxDegreesBracketed, s) => REGEXREPLACE(rgxDegreesBracketed, s, ''),
						REGEXFIND(rgxDegrees, s) => REGEXREPLACE(rgxDegrees, s, ''),
						REGEXFIND(rgxDegreesAtEnd, s) => REGEXREPLACE(rgxDegreesAtEnd, s, ''),
						REGEXFIND(rgxMAException, s) => s,	// special check for MA
						REGEXFIND(rgxHonorFirst, s) => REGEXREPLACE(rgxHonorFirst, s,'$2'),
						REGEXFIND(rgxRT, s) => REGEXREPLACE(rgxRT, s,''),

						REGEXFIND(rgxIsHonor, s) =>	REGEXREPLACE(rgxIsHonor, s, ''),
						REGEXFIND('(,(ML|RV|LE|LT))$', s) => REGEXREPLACE('(,(ML|RV|LT))$', s,''),
						REGEXFIND('^(\\(?REM\\)?[:;, -]+)', s) => REGEXREPLACE('^(\\(?REM\\)?[:;, -]+)', s,''),
						REGEXFIND('(AND|OR) +[A-Z] [A-Z]$', s) => s, // override next statement for dual names
						REGEXFIND('^([A-Z]+[, ]+[A-Z]+ +[A-Z]+) +[A-Z] [A-Z]$', s) => REGEXREPLACE('^([A-Z]+[, ]+[A-Z]+ +[A-Z]+) +[A-Z] [A-Z]$', s,'$1'),
						REGEXFIND(rgxInmate, s) => REGEXREPLACE(rgxInmate, s,''),
						REGEXFIND(regxRevocable, s) => REGEXREPLACE(regxRevocable, s,''),
						//REGEXFIND(rgxTitles, s) => REGEXREPLACE(rgxTitles1, s,''),
						s
				));

string rgxPropertyIdentifiers := '\\b(A +|AN +)(UN +|UNMARRIED +|SINGLE +|MARRIED +)(MAN|WOMAN|HUSBAND|WIFE|PERS(ON)?|INDIVIDUAL)( SEPARATED)?[,) ]*|(A )?SEPARATED PERS(ON)?$';
string rgxPropertyIdentifiers1 := '\\b(A +|AN +)?(UN|UNMARRIED|SINGLE|MARRIED|DIVORCED|SEPARATED|WIDOWED) +(MAN|WOMAN|HUSBAND|WIFE|PERS(ON)?|INDIVIDUAL)([, ]+(SEPARATED|AS( HIS| HER)? SOLE( OWNER)?))?[)]?$';
string rgxPropertyIdentifiers2 := '\\b(A|AN) +(MAN|WOMAN|HUSBAND|WIFE|INDIVIDUAL)([, ]+(SEPARATED|AS +(HIS +|HER +)?SOLE( OWNER)?))?[)]?$';
string rgxPropertyIdentifiers3 := '[A-Z]+ *, *(SINGLE|(UN)?MARRIED|SOLE OWNER|WHO IS SINGLE)$';
string rgxPropertyIdentifiers3a := '\\b(SINGLE|(UN)?MARRIED|SOLE OWNER|WHO IS SINGLE)$';
string rgxAMan := '\\b(A|AN) +(MAN|WOMAN|HUSBAND|WIFE)([, ]+(SEPARATED|AS +(HIS +|HER +)?SOLE))?[)]?$';
rgxEstate := '\\b(LIFE ESTATE|LIFE ESTAT|LIFE EST|LIF EST|LF EST|LFEST|LFE EST|LIFE ESTS|LIFEESTATE|EST OF|(THE )?ESTATE OF|ESTATE-OF|ESTATEOF[A-Z]*|EST|LF|HEIRS|AS (HIS|HER) SEPARATE ESTATE|AS TENANTS BY THE ENTIRETY|(AS )?(HIS|HER) SOLE|AS SOLE|(AS )?TO UNDIVIDED 50 PERCENT INTERES)\\b';
rgxOwner := '\\b((AS |UN )?(SOLE )?OWNER)\\b';
rgxANO := ' *(([&/;-]| ET ) *ANO)$';	// ANO = AND ANOTHER	
string RemovePropertyIdentifiers(string s) := 
	MAP(
			REGEXFIND(rgxPropertyIdentifiers1, s) => REGEXREPLACE(rgxPropertyIdentifiers1, s, ''),
			REGEXFIND(rgxPropertyIdentifiers2, s) => REGEXREPLACE(rgxPropertyIdentifiers2, s, ''),
			REGEXFIND(rgxPropertyIdentifiers3, s) => REGEXREPLACE(rgxPropertyIdentifiers3a, s, ''),
			REGEXFIND(rgxAMan, s) => REGEXREPLACE(rgxAMan, s, ''),
			REGEXFIND(rgxOwner, s) => REGEXREPLACE(rgxOwner, s, ''),
			REGEXFIND(rgxEstate, s) => REGEXREPLACE(rgxEstate, s,''),
			REGEXFIND(rgxANO, s) => REGEXREPLACE(rgxANO, s,''),
			s);

string RemoveHonors(string s) := 
	FixAndOr(	// do it here for now
		FixNMN(ReverseGen(RemovePaDoMa(
			RemoveEtAl(
				RemoveTrustAndDegrees(
					RemovePropertyIdentifiers(
						RemoveAKA(
							Std.Str.CleanSpaces(s)
						)
					)
				)
			)
		)))
);

string RemoveDblHyphen(string s) := MAP(
	StringLib.StringFind(s, '--', 1) > 0 =>
		StringLib.StringFindReplace(s, '--', '-'),
	StringLib.StringFind(s, ' - ', 1) > 0 =>
		StringLib.StringFindReplace(s, ' - ', ' '),
	REGEXFIND('- [A-Z]', s) =>
		StringLib.StringFindReplace(s, '- ', '-'),
	REGEXFIND(' -[A-Z]',s) =>
		StringLib.StringFindReplace(s, ' -', '-'),
	REGEXFIND('([A-Z])-(JR|SR|I|II|III)\\b',s) =>
		REGEXREPLACE('([A-Z])-(JR|SR|I|II|III)\\b', s, '$1 $2'),
		// or double apostrophes
	StringLib.StringFind(s, '\'\'', 1) > 0 =>
		StringLib.StringFindReplace(s, '\'\'', '\''),
		s);

string RemoveDblComma(string s) :=
	IF(REGEXFIND(', *,', s) AND ~REGEXFIND(rgxFccL,s),
		REGEXREPLACE('^(.+), *,(.+)$', s, '$1,$2'),
		s);
	
string RemoveComma(string s) := 
	RemoveDblHyphen(RemoveDblComma(
		MAP(
			REGEXFIND(' [A-Z], ', s) =>	REGEXREPLACE(' ([A-Z]), ', s, ' $1 '),
			REGEXFIND('^[A-Z](,)[A-Z]+ +[A-Z]+$', s) =>	StringLib.StringFindReplace(s, ',',' '),
			REGEXFIND('^(O|D) ([A-Z]+),[A-Z ]+', s) => REGEXREPLACE('^(O|D) ([A-Z]+),', s, '$1$2,'),
			REGEXFIND('^(SW|DW|SM|DV|WR|MM),([A-Z ]+)', s) => REGEXREPLACE('^((SW|DW|SM|DV|WR|MM), +)', s, ''),
			REGEXFIND('^ *"?(\\d"? *, *"?OFFICER"?)\\b', s) => REGEXREPLACE('^ *"?(\\d"? *, *"?OFFICER"?)\\b', s, ''),
			Std.Str.FindCount(s, ' AND,') > 1 => Std.Str.FindReplace(s, ' AND,', ' AND '),
		s)));

			//REGEXFIND('L;[A-Z]',s) => StringLib.StringFilterOut(s, ';'),
			//REGEXFIND('[A-Z];L',s) => StringLib.StringFilterOut(s, ';'),
			//REGEXFIND('^[A-Z]+;?[A-Z]+ +[A-Z]+;?[A-Z]+$',s) => StringLib.StringFindReplace(s, ';', 'L'),

string StripoutSemicolon(string s) :=
		MAP(
			REGEXFIND('&AMP;',s) => StringLib.StringFindReplace(s, '&AMP;', '&'),
			REGEXFIND('&QUOT;',s) => StringLib.StringFindReplace(s, '&QUOT;', ' '),
			REGEXFIND(';UNIT\\b',s) => StringLib.StringFindReplace(s, ';UNIT', 'UNIT'),
			REGEXFIND('\\bET AL;',s) => StringLib.StringFindReplace(s, 'ET AL;', ' '),
			REGEXFIND('^ATTN; ',s) => RegexReplace('(ATTN;) ', s, ''),
			REGEXFIND(' [A-Z];[A-Z]+',s) => StringLib.StringFindReplace(s, ';', '&'),
			REGEXFIND('^[A-Z]+; +[A-Z]+ +[A-Z]+$',s) => StringLib.StringFindReplace(s, ';', ','),
			REGEXFIND('\\bO;[A-Z]',s) => StringLib.StringFindReplace(s, ';','\''),
			REGEXFIND('^[A-Z]+ *; *[A-Z]+$',s) => StringLib.StringFindReplace(s, ';',','),
			REGEXFIND(';[^A-Z]+$', s) => s,
			StringLib.StringFindReplace(s, ';', '&')
		);
		
string MultiSemicolons(string s) := FUNCTION
		t := MAP(
					REGEXFIND('(; *;)', s) => REGEXREPLACE('(; *;)', s, ';'),
					REGEXFIND('\\bET AL;',s) => StringLib.StringFindReplace(s, 'ET AL;', ' '),
					s);
		return IF(STD.Str.FindCount(t, ';') < 2,
						StripoutSemicolon(t),
						StripoutSemicolon(t[1..Std.Str.Find(t, ';', 2)-1]));
END;

string RemoveSemicolon(string s) :=
	CASE(STD.Str.FindCount(s, ';'),
			0 => s,
			1 => StripoutSemicolon(s),
			MultiSemicolons(s)
	);



string TrimRightPunct(string s) := REGEXREPLACE('[ .,+;!?_*&:=#%"\'/\\\\-]+$',s,'');
string TrimRightHyphenChar(string s) := REGEXREPLACE('([A-Z])-[A-Z]$',s,'$1');
string TrimRightDblGen(string s) := REGEXREPLACE('\\b(JR|SR|II|III) (\\1)\\b',s,'$1');

string TrimRight(string s) := 
	TrimRightDblGen(TrimRightHyphenChar(TrimRightPunct(s)));
	
string TrimLeftPunct(string s) := REGEXREPLACE('^[ .,+;!?_*&:=#%"\'/\\\\-]+',s,'');
string TrimLeftRight(string s) := TrimLeftPunct(TrimRight(s));

string Check0ForO(string s) := IF(
		REGEXFIND('\\b[A-Z]+0[A-Z]+\\b', s) OR REGEXFIND('^[A-Z]+ +0 +[A-Z]+$', s) 
			OR REGEXFIND('\\b0[A-Z]+',s) OR REGEXFIND('[A-Z]+0\\b',s),
			stringlib.StringFindReplace(s,'0','O'),
		s);
		
string FixupPlusSign(string s) :=
	MAP(
		REGEXFIND(' (&) *(SR|JR)$',s) => REGEXREPLACE(' (&) *(SR|JR)$',s,' $2'),
		REGEXFIND('\\+ *(SR|JR|II|III)$',s) => stringlib.StringFindReplace(s,'+',' '),
		REGEXFIND('^[A-Z]+ *\\+ *[A-Z]+',s) => stringlib.StringFindReplace(s,'+',' '),
		REGEXFIND('^[A-Z]+ +[A-Z] *\\+ *[A-Z]+$',s) => stringlib.StringFindReplace(s,'+',' '),
		s
	);
	
string FixupStray(string s) :=		// remove stray apostrophes
		REGEXREPLACE(' (\')([A-Z]+)',									// beginning of word
			REGEXREPLACE('\\b([A-Z]+)(\') ',						// end of word
				REGEXREPLACE('\\b([A-Z]+)(\')$',					// end of line
					REGEXREPLACE('([A-Z]{2,})(\')([A-Z])',	// middle of word
						REGEXREPLACE('([A-Z]-[ODANL])(\')([A-Z])',	// hyphenated WRIGHT-O'BRIEN
							REGEXREPLACE('([^ADLNO])(\')([A-Z])',	// not [ADLNO] P'BRIEN
								REGEXREPLACE('\\b(O)(\') ([A-Z]+)$',		//  O' BRIEN
									StringLib.StringFindReplace(		// space apostrophe space
										StringLib.StringFindReplace(s, '`','\'')
										,' \' ', ' ')
								,'$1$2$3')
							,'$1$3')
						,'$1$3')
					,'$1$3')
				,'$1')
			,'$1 ')
		,' $2');

string FixupStrayHyphen(string s) :=		MAP(	// remove stray hyphens
	REGEXFIND('^(LE +- +)',s) => REGEXREPLACE('^(LE +- +)',s,''),
	REGEXFIND('^[A-Z]+-[A-HJ-Z] ',s) => REGEXREPLACE('^([A-Z]+)(-)([A-Z]) ',s,'$1 $3 '),
	REGEXFIND('^([A-Z]+)(-) ',s) => REGEXREPLACE('^([A-Z]+)(-) ',s,'$1 '),
	s);
	
string RemoveDoubleAmpersands(string s) := MAP(
	REGEXFIND('& *&', s) => REGEXREPLACE('(& *&)', s, '&'),
	REGEXFIND('& *OR ', s) => REGEXREPLACE('(& *OR )', s, '& '),
	s);
	
// to avoid confusion with revocable trust
FixupReverend(string s) := MAP(
		NOT REGEXFIND('\\bREV\\b',s) => s,
		s[1..4]='REV ' => s[5..],
		REGEXFIND('\\bREV T$',s) => s,
		REGEXREPLACE('\\b(REV)\\b',s,' '));
		
//string FixupAttn(string s) := MAP(
//		REGEXFIND('^(ATTN)\\b', s) => REGEXREPLACE('^(ATTN)\\b', s, ''),	// ATTN name,
//		REGEXFIND('^(CO-ATTN)\\b', s) => REGEXREPLACE('^(CO-ATTN)\\b', s, ''),	// CO-ATTN name,
//		REGEXFIND('\\b(ATTN)\\b', s) => s[1..Std.Str.Find(s,'ATTN', 1)-1],	// name ATTN other name,
//		s);
rgxCareOf := '(C/O)\\b';
string FixupAttn(string s) := MAP(
						REGEXFIND('^'+rgxCareOf, s) => REGEXREPLACE('^'+rgxCareOf, s, ''),	// C/O name,
						REGEXFIND('\\b'+rgxCareOf, s) => s[1..Std.Str.Find(s,'C/O', 1)-1],	// name C/O other name,
						REGEXFIND('.+ %', s) => s[1..Std.Str.Find(s,'%', 1)-1],	// name % other name,
						REGEXFIND('^(CO-ATTN)\\b', s) => REGEXREPLACE('^(CO-ATTN)\\b', s, ''),	// CO-ATTN name,
						REGEXFIND('^(ATTN)\\b', s) => REGEXREPLACE('^(ATTN)\\b', s, ''),	// ATTN name,
						REGEXFIND('\\b(ATTN)\\b', s) => s[1..Std.Str.Find(s,'ATTN', 1)-1],	// name ATTN other name,
						REGEXFIND('^(ATTENTION)\\b', s) => REGEXREPLACE('^(ATTENTION)\\b', s, ''),	// ATTENTION name,
						REGEXFIND('^[A-Z]+:',s) => RegexReplace('([A-Z]+:)', s, ''),	// ATTN:
				s);
rgxAddApostrophe := '\\b([A-Z]{2,}-O) ([A-Z]+)$';
rgxLetterPrefix := '^[OD] [A-Z]+ *,';					// D ASCANIO , AMEMDEO
AddApostrophe(string s) := IF(REGEXFIND(rgxAddApostrophe, s),
								REGEXREPLACE(rgxAddApostrophe, s, '$1\'$2'), s);

AddApostrophe2(string s) := IF(REGEXFIND(rgxLetterPrefix, s), s[1] + '\'' + s[3..], s);
rgxDualMissingAmp1 := '^([A-Z]{2,}) +[A-Z]+ +[A-Z]+ +\\1 +[A-Z]+ +[A-Z]+$';
rgxDualMissingAmpFix := '^([A-Z]+ +[A-Z]+ +[A-Z]+) +([A-Z]+ +[A-Z]+ +[A-Z]+)$';
rgxDualMissingAmp2 := '^[A-Z]+ +[A-Z]+ +([A-Z]{2,}) +[A-Z]+ +[A-Z]+ +\\1+$';
rgxDualMissingAmp3 := '^[A-Z]+ +[A-Z]+ +(TR|TTEE|TRUSTEE|JTRS) +[A-Z]+ +[A-Z]+ +\\1+$';
rgxDualMissingAmpFix3 := '^([A-Z]+ +[A-Z]+) +[A-Z]+ +([A-Z]+ +[A-Z]+) +[A-Z]+$';

FixupDual(string s) := 
	MAP(
			REGEXFIND('\\b(AND,)', s) => Std.Str.FindReplace(s, ' AND,', ' AND '),
			REGEXFIND('\\bAND\\b', s) => s,
			REGEXFIND(rgxDualMissingAmp1, s) => REGEXREPLACE(rgxDualMissingAmpFix, s, '$1&$2'),
			REGEXFIND(rgxDualMissingAmp2, s) => REGEXREPLACE(rgxDualMissingAmpFix, s, '$1&$2'),
			REGEXFIND(rgxDualMissingAmp3, s) => REGEXREPLACE(rgxDualMissingAmpFix3, s, '$1&$2'),
			s);

rgxOneOther := rgxConnector + ' *((ANY|ONE|ALL) OTHER)\\b';
string RemoveOther(string s) := MAP(
		Std.Str.Contains(s, '- OTHER', true) => Std.Str.FindReplace(s, '- OTHER', ' '),
		//Std.Str.Contains(s, '+ ONE OTHER', true) => Std.Str.FindReplace(s, '+ ONE OTHER', ' '),
		REGEXFIND(rgxOneOther, s) => REGEXREPLACE(rgxOneOther, s, ''),
		s);
		
string OtherFixup(string s) := 
	RemoveOther(
		FixupReverend(
		 Check0ForO(
			RemoveDoubleAmpersands(
				FixupPlusSign(
					FixupStrayHyphen(
						FixupStray(
							FixupAttn(
								AddApostrophe(
									AddApostrophe2(
										FixupDual(s)
									)
								)
							)
						)
					)
				)
			)
		)
	)
);

Particles := '\\b(BS|DL|FT|LT|HW|H/W|L/E|MM|MW|NT|RM|PR|PS|SG|SH|SM|SP|SS|TC|UW|WD|WF|COC|RS|LC|CP|CPT|PLS|PT|WRS|WROS)\\b'; // removed JT
	
	
// miscellaneous words in a name
designations := 
'\\b(FACS|FAAP|FACP|(USN|USAF|USNR) RET(IRED|\'D)?|USN|USAF|USCG|RET|LSW|PHY & SUR|PHYS|ESQUI|ESQUIRE|MINISTER|SISTER|ENGNR|MFCC|MFT|DNTST|FACC|ATTY|CLU|CMT|CHFC|LWYR|AGNT|VET|PRES(IDENT)?|TREAS(URER)?|CNSLR|MGR|DECEASED|DIR|PLS|CAP|ADJ|INACTIVE|ASST|"OFFICER"|SEC(RETARY)?)\\b';

positionNames :=
'(INTERIM |ACTING |CO[- ]?)?(((SENIOR )?(VICE)[- ]?)?PRES(IDENT)?|CEO|(ASST[ .]+|ASSISTANT |CORPORATE )?SEC(RETARY)|SUPERINTENDENT|(ASST[ .]+|ASSISTANT )?TREAS(URER)?|(ASST[ .]+|ASSISTANT )?CONTROLLER|(VICE[ -]?)?CHAIRMAN|(CO[ -]*|IND(EPENDENT)? )?EXECUT(OR|RIX)|EX(EC)?[. ]*|(EXEC([ .]+|UTIVE )?|DEPUTY |SENIOR |MANAGING |CORPORATE |FINANCE |TAX |SALES |LEGAL |HR |H R )?DIRECTOR|C[.]?F[.]?O|CTO|COO|C O O|C E O|"OFFICER"|V\\.?P\\.? (FINANCE|DEVELOPMENT|HR|HUMAN RESOURCES|SALES|TAX)|(SEN(IOR|\\.)? |E(XECUTIVE )?)?V[.]?P[.]?|S[R]?VP|VPHR|GEN(ERAL)? (MGR|MANAGER)|(HR |ASSET )MANAGER|GEN(ERAL)? COUNSEL|VICE CHAIR|REG(ISTERED)? AGENT|BOARD MEMBER|SOLE (OFFICER|MEMBER))';
//'(INTERIM |ACTING )?(((SENIOR )?(CO|VICE)[- ]?)?PRES(IDENT)?|(ASST[ .]+|ASSISTANT |CORPORATE )?SEC(RETARY)|SUPERINTENDENT|(ASST[ .]+|ASSISTANT )?TREAS(URER)?|(ASST[ .]+|ASSISTANT )?CONTROLLER|(VICE[ -]?)?CHAIRMAN|(CO[ -]*|IND(EPENDENT)? )?EXECUT(OR|RIX)|EX(EC)?[. ]*|(EXEC([ .]+|UTIVE )?|DEPUTY |SENIOR |MANAGING |CORPORATE |FINANCE |TAX |SALES |LEGAL |HR |H R )?DIRECTOR|C[.]?F[.]?O|CTO|COO|C O O|CEO|C E O|"OFFICER"|V\\.?P\\.? (FINANCE|DEVELOPMENT|HR|HUMAN RESOURCES|SALES|TAX)|(SEN(IOR|\\.)? |E(XECUTIVE )?)?V[.]?P[.]?|S[R]?VP|VPHR|GEN(ERAL)? (MGR|MANAGER)|(HR |ASSET )MANAGER|GEN(ERAL)? COUNSEL|VICE CHAIR|REG(ISTERED)? AGENT|BOARD MEMBER)';

positions := '\\b' + positionNames+'[.)]*$';
rgxConnectorPosition := 	' *( AND |&|-|/) *';
dualPositions := '\\b' + positionNames + rgxConnectorPosition + positionNames+'[.)]*$';

// special fixup before punctuation is removed
rgxRatio := '\\(\\d+/\\d+\\)';
rgxPropAbbrev := '(\\(LE\\))';
rgxPrefix := '^(\\(?(REM|RE|LIFE( USE)?|FOR)\\)?[:;, -]+)';
rgxAndPrefix := '^(AND)\\b';
rgxHandW := '\\b(\\(?H ?& ?W\\)?|ET H&W|W&H|J ?& ?S)$';
rgxHandWException := '^[A-Z]+ +(\\(?H ?& ?W\\)?|ET H&W|W&H|J ?& ?S)$';

string FixupWithPunct(string s) := MAP(
	REGEXFIND(rgxPrefix, s) => REGEXREPLACE(rgxPrefix, s, ' '),
	REGEXFIND(rgxPropAbbrev, s) => REGEXREPLACE(rgxPropAbbrev, s, ' '),
	REGEXFIND(rgxRatio, s) => REGEXREPLACE(rgxRatio, s, ' '),
	REGEXFIND(rgxAKA6, s) => REGEXREPLACE(rgxAKA6, s, '$1'),
	REGEXFIND(rgxAndPrefix, s) => REGEXREPLACE(rgxAndPrefix, s, ''),
	REGEXFIND(rgxHandW, s) AND NOT REGEXFIND(rgxHandWException, s) => REGEXREPLACE(rgxHandW, s, ''),
	s);

string FixGen(string suffix) :=
		CASE(suffix,
			//'1' => '',	//'SR',
			//'2' => 'JR',
			//'3' => 'III',
			//'4' => 'IV',
			//'5' => 'V',
			//'6' => '',
			//'7' => '',
			//'8' => '',
			//'9' => '',
			//'6' => 'VII',
			//'7' => 'VIII',
			'JR' => 'JR',
			'JR,' => 'JR',
			'SR' => 'SR',
			'JNR' => 'JR',
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

string SuffixToAlpha(string name) := FUNCTION
	suffix := REGEXFIND('^.+[ ,]([A-Z0-9]+)$', name, 1);
	return IF (suffix = '', name,
			TRIM(REGEXREPLACE('^(.+)([ ,])([A-Z0-9]+)$', name,
			'$1$2') + FixGen(suffix)));	
END;

string FixupName(string s) := 
	Std.Str.CleanSpaces(
			TrimLeftRight(
				RemoveComma(
					RemoveSemicolon(
						OtherFixup(
							REGEXREPLACE(particles,
								RemoveHonors(
									REGEXREPLACE(titles,
										REGEXREPLACE(designations,
											RemoveMrMrs(
												StringLib.StringSubstituteOut(
													FixupWithPunct(
														REGEXREPLACE(positions,
															REGEXREPLACE(dualPositions,
																RemoveNickname(CheckMispelledTrust(SlamPeriods(s))),
															'')
														,'')
													),
												'.()"{}%?_*~[]^:=\\\r\n', ' ')
											),
										''),
									''),
								),
							'')
						)
					)
				)
			)
		);

rgxSlashAtEnd := '/$';		// slash at end
rgxNandNslashN := '^[A-Z]+ +(AND|OR) +[A-Z]+/[A-Z]+';	// JOHN AND MARY/SMITH
rgxLslashF := '^[A-Z]{2,}/[A-Z]+';		// SMITH/MARY 
rgxFLslashI := '^[A-Z]+ +[A-Z]{2,}/[A-Z]$';	// SMITH HARVEY/M
rgxFLslashO := '^[A-Z]+ +([A-Z]{2,})/([A-Z]{2,})$';	// SMITH HARVEY/MARY
rgxFLslashL := '[A-Z]+ +[A-Z]{2,}/[A-Z]+$';	// MARIA DIAZ/RUIZ
rgxLSslashF := '[A-Z]+ +([A-Z]|JR|SR|II|III|IV)/[A-Z]+$';	// MARIA JR DIAZ/RUIZ
rgxFLslashLSuf := '[A-Z]+ +[A-Z]{2,}/[A-Z]+ +' + rgxSuffix + '$';	// MARIA DIAZ/RUIZ JR
rgxFLslashLsp := '[A-Z]+ +[A-Z]{2,} / [A-Z]+$';	// MARIA DIAZ/RUIZ
rgxSlashS := ' /[A-Z]+$';		// stray slash
rgxMotherOf := '\\b(M/O|W/H|R/S)\\b';
rgxNoFirstName := '^(N/A)\\b';
rgxNAMiddleName := '^([A-Z]+) (N/A) ([A-Z]+)$';
rgxSlashedInitials := '\\b([A-Z])/[A-Z]\\b';		// 
rgxEquifaxFix := '\\b([A-Z]+-[A-Z]+)/[A-Z]+$';
rgxSlashCode := '(/[A-Z][A-Z])$';		// slash XX
rgxSlashAka := '(/AKA)$';		// slash AKA
rgxAKASlash := '^(AK[AN]/)';		// slash AKA
rgxSlashWife := '(/(WIFE|SPOUSE))$';		// slash WIFE
rgxSlashPunct := '/[&-]';
rgxPossibleDual := '/ *([A-Z ]+)$';		
rgxSlashMR := '^([A-Z]+)/(MR|MS|MRS) ';
rgxRandomSlash := '([A-Z])/ ';
rgxISlash := '^[A-Z]/';
rgxLSFsF := '^([A-Z]+, +(JR|SR|II|III|IV) +[A-Z]+)/([A-Z]+$)';	//RUBINO, JR DANIEL/ANNE
rgxStragglers := '(/COX)$';

string DetailedHyphen(string name) := FUNCTION
	nm1 := REGEXFIND(rgxFLslashO, name, 1);
	nm2 := REGEXFIND(rgxFLslashO, name, 2);
	return IF(SpanishNames.IsSpanishSurname(nm1) OR SpanishNames.IsSpanishSurname(nm2),
			StringLib.StringFindReplace(name, '/', '-'),
		IF(NameTester.IsFirstNameBasic(nm2),
			StringLib.StringFindReplace(name, '/', '&'),
		StringLib.StringFindReplace(name, '/', '-')));
END;

string PossibleDual(string name) := FUNCTION
	rgxAllConsonants := '\\b([B-DF-HJ-NP-TVWXZ]{3,})\\b';	
	nm := REGEXFIND(rgxPossibleDual, name, 1);
	RETURN IF(
		REGEXFIND(rgxAllConsonants, nm), StringLib.StringFindReplace(name, '/', ' '),
		StringLib.StringFindReplace(name, '/', '&'));
END;

//string CutoffEnd(string s, integer idx) := s[1..idx-1];

string FixupSlash(string s) := FUNCTION
	name := FixupName(s);
	return MAP(
		StringLib.StringFindCount(name, '/') > 1 => name,
		StringLib.StringFind(name, '&/OR', 1) > 0 => name,
		StringLib.StringFind(name, 'AND/OR', 1) > 0 => name,
		REGEXFIND(rgxMotherOf, name) => REGEXREPLACE(rgxMotherOf, name, ''),	//name,
		REGEXFIND('^'+rgxCareOf, name) => REGEXREPLACE('^'+rgxCareOf, name, ''),	// C/O name,
		REGEXFIND('\\b'+rgxCareOf, name) => name[1..Std.Str.Find(name,'C/O', 1)-1],	// name C/O other name,
		REGEXFIND(rgxStragglers, name) => REGEXREPLACE(rgxStragglers, name, ''),
		REGEXFIND(rgxNAMiddleName, name) => REGEXREPLACE(rgxNAMiddleName, name, '$1 $3'),	//name,
		REGEXFIND(rgxSlashedInitials, name) => REGEXREPLACE(rgxSlashedInitials, name, '$1 '),	//name,
		REGEXFIND(rgxNandNslashN, name) => StringLib.StringFindReplace(name, '/', ' '),
		REGEXFIND(rgxISlash, name) => name,
		REGEXFIND(rgxLSFsF, name) => REGEXREPLACE(rgxLSFsF, name, '$1&$3'),
//		REGEXFIND(rgxRandomSlash, name) => REGEXREPLACE(rgxRandomSlash, name, '$1 '),
		REGEXFIND(rgxSlashMR, name) => REGEXREPLACE(rgxSlashMR, name, '$1 '),
		REGEXFIND(rgxSlashTrustee, name) => REGEXREPLACE(rgxSlashTrustee, name, ' '),
		REGEXFIND(rgxSlashAka, name) => REGEXREPLACE(rgxSlashAka, name, ''),
		REGEXFIND(rgxAKASlash, name) => TRIM(name[5..],LEFT,RIGHT),
		REGEXFIND('^([A-Z \'-]+)/(WIFE|SPOUSE)$', name) => REGEXREPLACE('^([A-Z \'-]+)/(WIFE|SPOUSE)$', name, '$1'),
		REGEXFIND(rgxSlashCode, name) => REGEXREPLACE(rgxSlashCode, name, ''),
		REGEXFIND(rgxLslashF, name) => StringLib.StringFindReplace(name, '/', ' '),
		REGEXFIND(rgxFLslashI, name) => StringLib.StringFindReplace(name, '/', ' '),
		REGEXFIND(rgxFLslashO, name) => DetailedHyphen(name),
		REGEXFIND(rgxLSslashF, name) => StringLib.StringFindReplace(name, '/', '&'),
		REGEXFIND(rgxFLslashL, name) => StringLib.StringFindReplace(name, '/', '-'),
		REGEXFIND(rgxFLslashLSuf, name) => StringLib.StringFindReplace(name, '/', '-'),
		REGEXFIND(rgxFLslashLsp, name) => StringLib.StringFindReplace(name, ' / ', '-'),
		REGEXFIND(rgxEquifaxFix, name) => REGEXREPLACE(rgxEquifaxFix, name, '$1'),
		REGEXFIND(rgxSlashS, name) => StringLib.StringFilterOut(name, '/'),
		REGEXFIND('^([A-Z \'-]+)/H W$', name) => REGEXREPLACE('^([A-Z \'-]+)/H W$', name, '$1'),
		REGEXFIND(rgxSlashAtEnd, name) => TRIM(StringLib.StringFilterOut(name, '/')),
		REGEXFIND('\\b([A-Z]+-[A-Z]+)/[A-Z]+$',name) => REGEXREPLACE('\\b([A-Z]+-[A-Z]+)/[A-Z]+$', name, '$1'),
		REGEXFIND(rgxSlashPunct, name) => REGEXREPLACE(rgxSlashPunct, name, ''),
		StringLib.StringFind(name, '&', 1) > 0 => StringLib.StringFindReplace(name, '/', ' '),	// not two ampersands
		//StringLib.StringFind(name, '/', 1) > 4 => StringLib.StringFindReplace(name, '/', '&'),	// possible dual name
		REGEXFIND(rgxPossibleDual, name) => StringLib.StringFindReplace(name, '/', '&'),
		StringLib.StringFindReplace(name, '/', ' ')
	);
END;

rgxPunct := '[ ,+!?_*&:#%"\'/\\\\-]+';		//  ,+;!?_*&:#%"'/\-
string QuickTrim(string s) := 
			REGEXREPLACE(rgxPunct+'$',s,'');	

rgxApos1 := '[^A-Z0-9_]\'([A-Z0-9_]+)';
rgxApos2 := '([A-Z0-9_]+)\'( |$)';
rgxOname := '\\b(O|D)[\']+ *([A-Z]+)\\b';

string RemoveApostrophe(string s) :=  REGEXREPLACE(rgxApos2, 
																					REGEXREPLACE(rgxApos1, 
																						REGEXREPLACE(rgxOname, 
																							Std.Str.FindReplace(s,'\'\'', '\''),
																						 '$1$2'),
																					' $1'), ' $1 ');

export string PrecleanName(string name) := 
		Std.Str.CleanSpaces(
			QuickTrim(	
				SuffixToAlpha(
					FixupSlash(
						Std.Str.CleanSpaces(
							QuickTrim(
								RemoveApostrophe(
									StringLib.StringToUpperCase(
										NameTester.RemoveNonPrintingChars(name)
									)
								)
							)
						)	
					)
			)
		)
	);
