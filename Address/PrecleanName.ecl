/*****
 This attribute is used by the name repository
 to preclean a name before cleaning it
 it removes punctuation and tokens that are not part of a name
******/

rgxGen := '(JR|SR|I|II|III|IV|V|VI|2ND|3RD|4TH|5TH|6TH|1|2|3|4|5|6|7|8|9)';
rgxSureGen := '(JR|SR|II|III|IV|2ND|3RD|4TH|5TH|6TH)';
rgxHonor := 
 '(MD|DMD|DDS|CNFP|CNM|CNP|CPA|CSW|DR|PHD|ESQ|RN|LN|DO|DC|DPM|DPC|DD|LMT|DVM|PSYD|ASID|CLU|JD|OD|CFP|AA|AS|NP|ARNP|MSW|LCSW|LSW|ACSW|LMHC|LMFT|CMT|LPCC|MA|SJ|MBA|MSD|CTM|DTM|CPS|ADJ|DWP|SEC|VDM|VMD|PA-C|PA|RPA-C|RPA|APA-C)';
rgxSureHonor := 	// no oriental names
 '(MD|DMD|DDS|CNFP|CNM|CNP|CPA|CSW|DR|PHD|ESQ|RN|LN|DC|DPM|DPC|DD|LMT|DVM|PSYD|ASID|CLU|JD|OD|CFP|AA|NP|ARNP|MSW|LCSW|LSW|ACSW|LMHC|LMFT|CMT|LPCC|SJ|MBA|MSD|CTM|DTM|CPS|ADJ|DWP|SEC|VDM|VMD|PA-C|PA|RPA-C|RPA|APA-C)';
rgxSuffix := '(' + rgxGen + '|' + rgxHonor + ')';
rgxSureSuffix := '(' + rgxSureGen + '|' + rgxSureHonor + ')';
rgxLast := '(DI |DA |DEL |DE LA |DE LOS |DES |DE |DELLA |DELLO |DOS |DU |LA |MC |VON |VAN DER |VAN |VANDER |VANDEN |ST |EL |LE |[ODANL]\')?([A-Z]+[A-Z\'-]+)';
rgxFccL := '^([A-Z]+),,(' + rgxLast + ')$';	// missing middle name
rgxMrMrs := '\\b((MR|MRS|DR|REV) *(&| AND ) *(MR|MRS|MS))\\b';
titles :=
 '\\b(MR|MRS|MS|MMS|MISS|DR|REV|RABBI|REVEREND|MSGR|PROF|PROFESSOR|FR|LT COL|COL|LCOL|LTCOL|LTC|CH|LT GEN|LT CDR|LCDR|LT CMDR|CDR|MAJ GEN|MAJ|RADM|SFC|SRTA|APCO|CAPT|LT|CPT|SGT|MSGT|SSG|MSG|MGR|CPL|CPO|SHRF|SMSG|SMSGT)\\b';
rgxConnector := 	'( AND |&| OR | AND/OR |&/OR |\\+)';

string SlamPeriods(string s) := FUNCTION
	t := MAP(
		REGEXFIND('[ ,][A-Z]\\.[A-Z]\\.[A-Z]\\.?$', s) =>
			REGEXREPLACE('([ ,])([A-Z])\\.([A-Z])\\.([A-Z])\\.?$',s,'$1$2$3$4'),
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
	
string RemoveMrMrs(string s) := MAP(
	REGEXFIND(rgxMrMrs, s) => REGEXREPLACE(rgxMrMrs, s, ''),
	REGEXFIND('(' + rgxConnector + ' *(WIFE|JLRS|GUEST(S)?|PARENT(S)?|CHILD(REN?)))$', s) => 
		REGEXREPLACE('(' + rgxConnector + ' *(WIFE|JLRS|GUEST(S)?|PARENT(S)?|CHILD(REN?)))$', s,''),
	s);
	

rgxIsHonor := '[ /,-]+' + rgxHonor + '\\b';
rgxHonorFirst := '^' + rgxHonor + ' +([A-Z-]+ +.+)$';
//rgxExtractHonor := '^(.+) +' + rgxHonor + ' *(.*)$';
rgxDegrees := 
 '^(MD|DMD|DDS|DPM|DVM|RN|CPA|JD|BSC|BTR|SPC)\\b';
rgxDegreesAtEnd := '\\b(C. P. A.|M. D.|D. D. S.|D. M. D.|D. V. M.|D. P. M.)$'; 

string FixAndOr(string s) :=
	IF(REGEXFIND('\\bAND OR\\b',s),
		REGEXREPLACE('\\bAND OR\\b',s, ' AND/OR '), s);
		
string FixNMN(string s) :=
	IF(s[1..4] in ['NMI ','NMN '],s[5..],s);
	
rgxGenFirst := '^' + rgxSureGen + ' +(.+)$';
string ReverseGen(string s) :=
	MAP(
			REGEXFIND(rgxGenFirst, s) => REGEXREPLACE(rgxGenFirst, s, '$2 $1'),
			REGEXFIND('^[0-9] [0-9]', s) => s,	
			REGEXFIND('^[0-9] *& *[0-9]', s) => s,	
			REGEXFIND('^[0-9] ', s) => TRIM(s[2..],LEFT,RIGHT),	
			REGEXFIND('^(0)\'[A-Z]', s) => 'O'+s[2..],	
	s);

string RemoveAKA(string s) := MAP(
	s[1..4] = 'AKA ' => s[5..],
	REGEXFIND('( AKA)$',s) => REGEXREPLACE('( AKA)$',s,''),
	StringLib.StringFind(s, ' AKA ', 1) > 0 => StringLib.StringFindReplace(s, ' AKA ', ' '),
	StringLib.StringFind(s, '-AKA-', 1) > 0 => StringLib.StringFindReplace(s, '-AKA-', '-'),
	REGEXFIND('(/AKA)$', s) => REGEXREPLACE('(/AKA)$', s, ''),
	REGEXFIND('([A-Z])/AKA\\b', s) => REGEXREPLACE('([A-Z])/AKA\\b', s, '$1 '),
	s);
Trustees := '\\b(TRUSTEE|TRUSTE|TRUSTEES|TTEE|TRS|TRSTE|TRU|TTE|TE|TR|TRUST OFFICER|EXECUT(OR|RIX))\\b';
CoTrustees := '\\b(CO[ -]+(TRUSTEE|TRUSTE|TRUSTEES|TTEE|TRS|TRSTE|TRU|TTE|TR|EXECUT(OR|RIX)))\\b';
string RemoveHonors(string s) := 
	FixAndOr(	// do it here for now
	RemoveAKA(
	FixNMN(ReverseGen(
		MAP(
			REGEXFIND('^[A-Z-]+ +(MA|DO|TE)$', TRIM(s)) => s,
			REGEXFIND('^[A-Z-]+ +[A-Z] +(MA|DO)$', TRIM(s)) => s,
			REGEXFIND('^[A-Z-]+ +(MA|DO|TE) +(JR|SR|II|III)$', TRIM(s)) => s,
			REGEXFIND('^[A-Z-]+ +[A-Z]+ +(MA|DO|TE) +(JR|SR|II|III)$', TRIM(s)) => s,
			REGEXFIND('^[A-Z-]+ +[A-Z]+ [A-Z]+ +(MA|DO|TE|LE)$', TRIM(s)) => TRIM(s[1..LENGTH(s)-3]),
			REGEXFIND(rgxIsHonor, s) =>	REGEXREPLACE(rgxIsHonor, s, ''),
			REGEXFIND(rgxDegrees, s) => REGEXREPLACE(rgxDegrees, s, ''),
			REGEXFIND(rgxDegreesAtEnd, s) => REGEXREPLACE(rgxDegreesAtEnd, s, ''),
			REGEXFIND(rgxHonorFirst, s) => REGEXREPLACE(rgxHonorFirst, s,'$2'),
			REGEXFIND(CoTrustees, s) => REGEXREPLACE(CoTrustees, s,''),
			REGEXFIND(Trustees, s) => REGEXREPLACE(Trustees, s,''),
			REGEXFIND('(,(ML|RV|LT))$', s) => REGEXREPLACE('(,(ML|RV|LT))$', s,''),
			REGEXFIND('(& *PA)$', s) => REGEXREPLACE('(& *PA)$', s,''),
			s
		)
	))));
	
string RemoveDblHyphen(string s) := MAP(
	StringLib.StringFind(s, '--', 1) > 0 =>
		StringLib.StringFindReplace(s, '--', '-'),
	StringLib.StringFind(s, ' - ', 1) > 0 =>
		StringLib.StringFindReplace(s, ' - ', ' '),
	REGEXFIND(' -[A-Z]',s) =>
		StringLib.StringFindReplace(s, ' -', ' '),
	REGEXFIND('([A-Z])-(JR|SR)\\b',s) =>
		REGEXREPLACE('([A-Z])-(JR|SR)\\b', s, '$1 $2'),
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
		s)));
		
		
string RemoveSemicolon(string s) :=
	IF(StringLib.StringFind(s, ';', 1)=0, s,
		MAP(
			REGEXFIND('\\bAMP;',s) => StringLib.StringFindReplace(s, 'AMP;', '&'),
			REGEXFIND(';UNIT\\b',s) => StringLib.StringFindReplace(s, ';UNIT', 'UNIT'),
			REGEXFIND('^ATTN; ',s) => StringLib.StringFindReplace(s, 'ATTN; ', ''),
			REGEXFIND(' [A-Z];[A-Z]+',s) => StringLib.StringFindReplace(s, ';', '&'),
			REGEXFIND('L;[A-Z]',s) => StringLib.StringFilterOut(s, ';'),
			REGEXFIND('[A-Z];L',s) => StringLib.StringFilterOut(s, ';'),
			REGEXFIND('^[A-Z]+; +[A-Z]+ +[A-Z]+$',s) => StringLib.StringFindReplace(s, ';', ','),
			REGEXFIND('\\bO;[A-Z]',s) => StringLib.StringFindReplace(s, ';','\''),
			REGEXFIND('^[A-Z]+;?[A-Z]+ +[A-Z]+;?[A-Z]+$',s) => StringLib.StringFindReplace(s, ';', 'L'),
			REGEXFIND('^[A-Z]+ *; *[A-Z]+$',s) => StringLib.StringFindReplace(s, ';',','),
			REGEXFIND(';[^A-Z]+$', s) => s,
			StringLib.StringFindReplace(s, ';', '&')
		)
	);


string TrimRightPunct(string s) := REGEXREPLACE('[ .,+;!?_*&:#%"\'/\\\\-]+$',s,'');
string TrimRightHyphenChar(string s) := REGEXREPLACE('([A-Z])-[A-Z]$',s,'$1');
string TrimRightDblGen(string s) := REGEXREPLACE('\\b(JR|SR|II|III) (\\1)$',s,'$1');

string TrimRight(string s) := 
	TrimRightDblGen(TrimRightHyphenChar(TrimRightPunct(s)));
	
string TrimLeftPunct(string s) := REGEXREPLACE('^[ .,+;!?_*&:#%"\'/\\\\-]+',s,'');
string TrimLeftRight(string s) := TrimLeftPunct(TrimRight(s));

string Check0ForO(string s) := IF(
		REGEXFIND('\\b[A-Z]+0[A-Z]+\\b', s) OR REGEXFIND('^[A-Z]+ +0 +[A-Z]+$', s),
			stringlib.StringFindReplace(s,'0','O'),
		s);
		
string FixupPlusSign(string s) :=
	MAP(
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
									StringLib.StringFindReplace(s, '`','\'')
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
	
string RemoveDoubleAmpersands(string s) :=
	IF(REGEXFIND('& *&', s), REGEXREPLACE('(& *&)', s, '&'), s);
	

rgxAddApostrophe := '\\b([A-Z]{2,}-O) ([A-Z]+)$';
string OtherFixup(string s) := 
   Check0ForO(RemoveDoubleAmpersands(
	FixupPlusSign(FixupStrayHyphen(
	 FixupStray(
		IF(REGEXFIND(rgxAddApostrophe, s),
			REGEXREPLACE(rgxAddApostrophe, s, '$1\'$2'), s))))));

Particles := '\\b(BS|DL|ET UX|ET-UX|ETUX|ET|FT|LF|LT|JT|HW|H/W|L/E|MM|MW|NT|RM|PR|PS|SG|SH|SP|SS|TC|UW|WD|WF|COC|RS|LC|EST|CPT|PLS|PT)\\b';
	
	
// miscellaneous words in a name
designations := 
'\\b(FACS|FAAP|FACP|(USN|USAF|USNR) RET(IRED)?|USN|USAF|USCG|RET|LSW|PHY & SUR|PHY|PHYS|ESQUI|ESQUIRE|MINISTER|SISTER|ENGNR|MFCC|MFT|DNTST|FACC|ATTY|CLU|CMT|CHFC|LWYR|AGNT|VET|PRES(IDENT)?|TREAS(URER)?|OWNER|CNSLR|MGR|DECEASED|DIR|PLS|CAP|ADJ|INACTIVE|OFFICE|SEC(RETARY)?)\\b';

positionNames :=
'(INTERIM |ACTING )?(((SENIOR )?VICE[- ]?)?PRES(IDENT)?|(ASST[ .]+|ASSISTANT |CORPORATE )?SEC(RETARY)|SUPERINTENDENT|(ASST[ .]+|ASSISTANT )?TREAS(URER)?|(ASST[ .]+|ASSISTANT )?CONTROLLER|(VICE[ -]?)?CHAIRMAN|(CO[ -]*|IND(EPENDENT)? )?EXECUT(OR|RIX)|(EXEC([ .]+|UTIVE )?|DEPUTY |SENIOR |MANAGING |CORPORATE |FINANCE |TAX |SALES |LEGAL |HR |H R )?DIRECTOR|C[.]?F[.]?O|CTO|COO|C O O|CEO|C E O|V\\.?P\\.? (FINANCE|DEVELOPMENT|HR|HUMAN RESOURCES|SALES|TAX)|(SEN(IOR|\\.)? |EX(EC)?[. ]*|E(XECUTIVE )?)?V[.]?P[.]?|S[R]?VP|VPHR|GEN(ERAL)? (MGR|MANAGER)|(HR |ASSET )MANAGER)';
//'((VICE[- ]?)?PRES(IDENT)?|(ASST[ .]+|ASSISTANT |CORPORATE )?SEC(RETARY)|SUPERINTENDENT|(ASST[ .]+|ASSISTANT )?TREAS(URER)?|(ASST[ .]+|ASSISTANT )?CONTROLLER|(VICE[ -]?)?CHAIRMAN|(CO[ -]*)?EXECUT(OR|RIX)|(EXEC([ .]+|UTIVE )?|DEPUTY |MANAGING |CORPORATE |HR |H R )?DIRECTOR|C[.]?F[.]?O|CTO|COO|CEO|C O O|V\\.?P\\.? (FINANCE|HR|HUMAN RESOUCRES|SALES|TAX)|(SEN(IOR|\\.)? |EX(EC)?[. ]*|E(XECUTIVE )?)?V[.]?P[.]?|S[R]?VP|VPHR|GEN(ERAL)? (MGR|MANAGER)|(HR |ASSET )MANAGER)';
//'((VICE[- ]?)?PRES(IDENT)?|(ASST[ .]+|ASSISTANT |CORPORATE )?SEC(RETARY)|SUPERINTENDENT|(ASST[ .]+|ASSISTANT )?TREAS(URER)?|CONTROLLER|CHAIRMAN|(CO[ -]*)?EXECUT(OR|RIX)|(EXEC([ .]+|UTIVE )?|DEPUTY |MANAGING |CORPORATE |HR |H R )?DIRECTOR|C[.]?F[.]?O|CTO|COO|CEO|V\\.?P\\.? (FINANCE|HR|HUMAN RESOUCRES|SALES|TAX)|(SEN(IOR|\\.)? |EX(EC)?[. ]*|E(XECUTIVE )?)?V[.]?P[.]?|S[R]?VP|VPHR|GEN(ERAL)? (MGR|MANAGER)|(HR |ASSET )MANAGER)';
//'((VICE[- ]?)?PRES(IDENT)?|SEC(RETARY)|SUPERINTENDENT|(ASST[ .]+|ASSISTANT )?TREAS(URER)?|CONTROLLER|CHAIRMAN|(CO[ -]*)?EXECUT(OR|RIX)|(EXEC([ .]+|UTIVE )?|DEPUTY |MANAGING |CORPORATE |HR |H R )?DIRECTOR|C[.]?F[.]?O|CTO|COO|CEO|V\\.?P\\.? (FINANCE|HR|HUMAN RESOUCRES|SALES|TAX)|(SEN(IOR|\\.)? |EX(EC)?[. ]*|E(XECUTIVE )?)?V[.]?P[.]?|S[R]?VP|VPHR|GEN(ERAL)? (MGR|MANAGER)|(HR |ASSET )MANAGER)';
//'((VICE[- ]?)?PRES(IDENT)?|SEC(RETARY)|SUPERINTENDENT|TREAS(URER)?|CONTROLLER|CHAIRMAN|(CO[ -]*)?EXECUT(OR|RIX)|(EXEC(\\.|UTIVE)?|DEPUTY) DIRECTOR|DIRECTOR|C[.]?F[.]?O|CTO|COO|CEO|V\\.?P\\.? (FINANCE|HR|HUMAN RESOUCRES|SALES|TAX)|(SEN(IOR|\\.)? |EX(EC)?[. ]*|E(XECUTIVE )?)?V[.]?P[.]?|S[R]?VP|VPHR|GEN(ERAL)? (MGR|MANAGER)|(HR |ASSET )MANAGER)';

positions := '\\b' + positionNames+'[.)]*$';
rgxConnectorPosition := 	' *( AND |&|-|/) *';
dualPositions := '\\b' + positionNames + rgxConnectorPosition + positionNames+'[.)]*$';

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

string FixupName(string s) := TRIM(StringLib.StringCleanSpaces(
										//LIB_Word.StripTail(LIB_Word.StripTail(
										TrimLeftRight(
										RemoveComma(RemoveSemicolon(OtherFixup(
										RemoveHonors(
										REGEXREPLACE(particles,
										REGEXREPLACE(titles,
										REGEXREPLACE(designations,
										RemoveMrMrs(
										StringLib.StringSubstituteOut(											
										REGEXREPLACE(positions,
										REGEXREPLACE(dualPositions,
												RemoveNickname(SlamPeriods(s)),
												''),''),
											'.()"{}%?_*~\\\r\n', ' ')),
											''),
										''),''))))))),
									  LEFT,RIGHT);

rgxSlashAtEnd := '/$';		// slash at end
rgxNandNslashN := '^[A-Z]+ +(AND|OR) +[A-Z]+/[A-Z]+';	// JOHN AND MARY/SMITH
rgxLslashF := '^[A-Z]{2,}/[A-Z]+';		// SMITH/MARY 
rgxFLslashI := '^[A-Z]+ +[A-Z]{2,}/[A-Z]$';	// SMITH HARVEY/M
rgxFLslashO := '^[A-Z]+ +([A-Z]{2,})/([A-Z]{2,})$';	// SMITH HARVEY/MARY
rgxFLslashL := '[A-Z]+ +[A-Z]{2,}/[A-Z]+$';	// MARIA DIAZ/RUIZ
rgxFLslashLSuf := '[A-Z]+ +[A-Z]{2,}/[A-Z]+ +' + rgxSuffix + '$';	// MARIA DIAZ/RUIZ JR
rgxFLslashLsp := '[A-Z]+ +[A-Z]{2,} / [A-Z]+$';	// MARIA DIAZ/RUIZ
rgxSlashS := ' /[A-Z]+$';		// stray slash
rgxSlashedInitials := '\\b[A-Z]/[A-Z]\\b';		// slash at end
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

string FixupSlash(string s) := FUNCTION
	name := FixupName(s);
	return MAP(
		StringLib.StringFindCount(name, '/') > 1 => name,
		StringLib.StringFind(name, '&/OR', 1) > 0 => name,
		StringLib.StringFind(name, 'AND/OR', 1) > 0 => name,
		REGEXFIND(rgxSlashedInitials, name) => name,
		REGEXFIND(rgxNandNslashN, name) => StringLib.StringFindReplace(name, '/', ' '),
		REGEXFIND(rgxISlash, name) => name,
//		REGEXFIND(rgxRandomSlash, name) => REGEXREPLACE(rgxRandomSlash, name, '$1 '),
		REGEXFIND(rgxSlashMR, name) => REGEXREPLACE(rgxSlashMR, name, '$1 '),
		REGEXFIND(rgxSlashAka, name) => REGEXREPLACE(rgxSlashAka, name, ''),
		REGEXFIND(rgxAKASlash, name) => TRIM(name[5..],LEFT,RIGHT),
		REGEXFIND('^([A-Z \'-]+)/(WIFE|SPOUSE)$', name) => REGEXREPLACE('^([A-Z \'-]+)/(WIFE|SPOUSE)$', name, '$1'),
		REGEXFIND(rgxSlashCode, name) => REGEXREPLACE(rgxSlashCode, name, ''),
		REGEXFIND(rgxLslashF, name) => StringLib.StringFindReplace(name, '/', ' '),
		REGEXFIND(rgxFLslashI, name) => StringLib.StringFindReplace(name, '/', ' '),
		REGEXFIND(rgxFLslashO, name) => DetailedHyphen(name),
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
string RemoveNonPrintingChars(string s) := REGEXREPLACE('([^ -~]+)',s,' ');
export string PrecleanName(string name) := TRIM(	
		SuffixToAlpha(FixupSlash(TRIM(StringLib.StringToUpperCase(RemoveNonPrintingChars(name)),LEFT,RIGHT))));
