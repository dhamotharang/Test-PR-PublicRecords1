export Persons := MODULE

shared rgxBasic := '([A-Z]+)';
shared rgxBasicX := '([A-Z-]+)';
shared rgxLast := '((DI |DA |DEL |DE LA |DE LOS |DELOS |DES |DE |DELLA |DELLO |DOS |DU |LA |MC |VON |VAN DER |VAN |VANDER |ST |AL |EL |BIN |BEN |ABU |ABD |ABDUL |LE |[ODANL]\')?([A-Z]+[A-Z\'-]+))';
//shared rgxLast := '(DI |DA |DEL |DE LA |DE LOS |DES |DE |DELLA |DELLO |DOS |VON |VAN DER |VAN |VANDER |ST |EL |[ODANL]\')?([A-Z][A-Z-]+)';
shared rgxLastStrong := '(DI |DA |DEL |DE LA |DELA |DE LOS |DES |DE |DELLA |DOS |DU |LA |MC |MAC |VON |VAN DER |VAN DEN |VAN |VANDER |ST |EL |LE |[ODANL]\'|A-|ABU-EL-|VAN-DEN-)([A-Z][A-Z-]+)';
shared rgxLastOrInitial := '(DI |DA |DEL |DES |DE LA |DE LOS |DE |DELLA |DELLO |DOS |DU |MC |VON |VAN DER |VAN |VANDER |ST |EL |LE |[ODANL]\'|A-|ABU-EL-|VAN-DEN-)?([A-Z][A-Z-]*)';
shared rgxSuffix := '(JR|SR|II|III|IV|V|VI|1ST|2ND|3RD|4TH|5TH|6TH|1|2|3|4|5|JUNIOR)';

shared rgxFL := '^' + rgxBasicX + ' +'  + rgxLast + '$';
shared rgxFLA := '^' + rgxBasicX + ' +'  + rgxLast + ' +\\(([A-Z]+)\\)$';
shared rgxFML := '^' + rgxBasicX + ' +' + rgxBasicX + ' +' + rgxLast + '$';
shared rgxFMML := '^' + rgxBasicX + ' +([A-Z -]+) +' + rgxLast + '$';
shared rgxFLNick := '^' + rgxBasic + ' +'  + rgxLast + ' +(THE [A-Z]+)$';
shared rgxIcFM	:=
'^([A-Z]) *, *' + rgxBasicX + ' +' + rgxBasicX +'$';
shared rgxIcF	:=
'^([A-Z]) *, *' + rgxBasicX + '$';
shared rgxLcF	:=
'^' + rgxLast + ' *, *' + rgxBasicX + '$';
shared rgxLcFS	:=
'^' + rgxLast + ' *, *' + rgxBasic + ' +\\(?' + rgxSuffix + '\\)$';
shared rgxLcFNick	:=
'^' + rgxLast + ' *, *' + rgxBasicX + ' +\\(([A-Z -]+)\\)$';
shared rgxLcFMNick	:=
'^' + rgxLast + ' *, *' + rgxBasicX + ' +([A-Z-]+ +\\([A-Z -]+\\))$';
shared rgxLScF	:=
'^' + rgxLast + ' +' + rgxSuffix + ' *, *' + rgxBasic + '$';
shared rgxLJrcF	:=
'^' + rgxLast + ' +' + '(JUNIOR)' + ' *, *' + rgxBasic + '$';
shared rgxLScFM	:=
'^' + rgxLast + ' +' + rgxSuffix + ' *, *' + rgxBasic + ' +' + rgxBasicX + '$';
shared rgxLcFhF	:=
'^' + rgxLast + ' *, *([A-Z]+-[A-Z-]+)$';
shared rgxLcFBen	:=
'^([A-Z -]+) *, *' + rgxBasicX + ' +((BEN|BIN|BENT|ABD)\\b[A-Z -]+)$';
shared rgxLcFMBen	:=
'^([A-Z -]+) *, *' + rgxBasicX + ' +([A-Z-]+ (BEN|BIN|BENT|ABD)\\b[A-Z -]+)$';
shared rgxLcFM	:=
'^' + rgxLast + ' *, *' + rgxBasicX + ' +' + rgxBasicX + '$';
shared rgxLcScF	:=
'^' + rgxLast + ' *, *' + rgxSuffix + ' *, *' + rgxBasicX + '$';
shared rgxLcScFM	:=
'^' + rgxLast + ' *, *' + rgxSuffix + ' *, *' + rgxBasicX + ' +' + rgxBasicX + '$';
shared rgxLcFMM	:=
'^' + rgxLast + ' *, *' + rgxBasicX + ' +([A-Z-]+ +[A-Z-]+)$';
shared rgxLcFMMM	:=
'^' + rgxLast + ' *, *' + rgxBasic + ' +([A-Z-]+ +[A-Z-]+ +[A-Z-]+)$';
shared rgxLcFMMMM	:=
'^' + rgxLast + ' *, *' + rgxBasic + ' +([A-Z-]+ +[A-Z-]+ +[A-Z-]+ [A-Z-]+)$';
shared rgxLcFMcS	:=
'^' + rgxLast + ' *, *' + rgxBasic + ' +' + rgxBasic + ' *, *' + rgxSuffix + '$';
shared rgxLcFMS	:=
'^' + rgxLast + ' *, *' + rgxBasic + ' +' + rgxBasic + ' +\\(?' + rgxSuffix + '\\)?$';
shared rgxL := '^' + rgxLast + '$';
shared rgxLP := '^' + rgxLast + ' +\\(.+\\)$';
shared rgxLLcF	:=
'^([A-Z -]+ +' + rgxLast + ') *, *' + rgxBasicX + '$';
shared rgxLLcFM	:=
'^([A-Z -]+ +' + rgxLast + ') *, *' + rgxBasicX + ' +' + rgxBasicX + '$';
shared rgxLLcFMM	:=
'^([A-Z -]+) *, *' + rgxBasicX + ' +([A-Z-]+ +[A-Z-]+)$';
shared rgxLLcFMMM	:=
'^([A-Z -]+) *, *' + rgxBasicX + ' +([A-Z-]+ +[A-Z-]+ +[A-Z-]+)$';
shared rgxLLcFMMMM	:=
'^([A-Z -]+) *, *' + rgxBasicX + ' +([A-Z-]+ +[A-Z-]+ +[A-Z-]+ +[A-Z -]+)$';

// names with Alias
shared rgxLA	:=
'^' + rgxLast + ' +\\(([A-Z]+)\\)$';
shared rgxLAcF	:=
'^' + rgxLast + ' +\\(([A-Z]+)\\) *, *' + rgxBasicX + '$';
shared rgxLAcFM	:=
'^' + rgxLast + ' +\\(([A-Z]+)\\) *, *' + rgxBasicX + ' +' + rgxBasicX + '$';
shared rgxLAcFMS	:=
'^' + rgxLast + ' +\\(([A-Z]+)\\) *, *' + rgxBasicX + ' +' + rgxBasicX + ' +' + rgxSuffix +'$';
shared rgxLcFAM	:=
'^([A-Z -]+) *, *([A-Z\'-]+) +\\(([A-Z]+)\\) +([A-Z -]+)$';
shared rgxLcFMA	:=
'^([A-Z -]+) *, *([A-Z\'-]+) +([A-Z -]+) +\\(([A-Z]+)\\)$';


export NameFormat := ENUM(integer2, NoName=0,
	// single name formats
		FL, FML, FMML, FLNick, LF, LcF, LcFBen, LcFMBen, LcFS, LcFNick, LcFMNick, LcFhF, LcFM,  LScF, LScFM,
		LcFMM, LcFMMM, LcFMMMM, LcFMcS,LcFMS, LcScF, LcScFM,
		LLcF, LLcFM, LLcFMM, LLcFMMM, LLcFMMMM,
		IcF, IcFM, L, LP, LA, FLA, LcFAM, LcFMA,
		LAcF, LAcFM, LAcFMS, LJrcF, Invalid
		);

export GetNameFormat(string s) := 
	MAP(
		REGEXFIND(rgxFL, s) => NameFormat.FL,
		REGEXFIND(rgxFML, s) => NameFormat.FML,
		REGEXFIND(rgxFLNick, s) => NameFormat.FLNick,
		REGEXFIND(rgxFMML, s) => NameFormat.FMML,
		REGEXFIND(rgxL, s) => NameFormat.L,
		//REGEXFIND(rgxLP, s) => NameFormat.LP,
		REGEXFIND(rgxLJrcF, s) => NameFormat.LJrcF,
		REGEXFIND(rgxLScF, s) => NameFormat.LScF,
		REGEXFIND(rgxLScFM, s) => NameFormat.LScFM,
		REGEXFIND(rgxLcF, s) => NameFormat.LcF,
		REGEXFIND(rgxLcFS, s) => NameFormat.LcFS,
		REGEXFIND(rgxLcFNick, s) => NameFormat.LcFNick,
		REGEXFIND(rgxLcFMNick, s) => NameFormat.LcFMNick,
		REGEXFIND(rgxLcFhF, s) => NameFormat.LcFhF,
		REGEXFIND(rgxLcFBen, s) => 	NameFormat.LcFBen,
		REGEXFIND(rgxLcFMBen, s) => 	NameFormat.LcFMBen,
		REGEXFIND(rgxLcFMS, s) => NameFormat.LcFMS,
		REGEXFIND(rgxLcFMcS, s) => NameFormat.LcFMcS,
		REGEXFIND(rgxLcScF, s) => NameFormat.LcScF,
		REGEXFIND(rgxLcScFM, s) => NameFormat.LcScFM,
		REGEXFIND(rgxLcFM, s) => NameFormat.LcFM,
		REGEXFIND(rgxLcFMM, s) => NameFormat.LcFMM,
		REGEXFIND(rgxLcFMMM, s) => NameFormat.LcFMMM,
		REGEXFIND(rgxLcFMMMM, s) => NameFormat.LcFMMMM,
		REGEXFIND(rgxFLA, s) => NameFormat.FLA,
		REGEXFIND(rgxLA, s) => NameFormat.LA,
		REGEXFIND(rgxLAcF, s) => NameFormat.LAcF,
		REGEXFIND(rgxLAcFM, s) => NameFormat.LAcFM,
		REGEXFIND(rgxLAcFMS, s) => NameFormat.LAcFMS,
		REGEXFIND(rgxLcFAM, s) => NameFormat.LcFAM,
		REGEXFIND(rgxLcFMA, s) => NameFormat.LcFMA,
		REGEXFIND(rgxLLcF, s) => NameFormat.LLcF,
		REGEXFIND(rgxLLcFM, s) => NameFormat.LLcFM,
		REGEXFIND(rgxLLcFMM, s) => NameFormat.LLcFMM,
		REGEXFIND(rgxLLcFMMM, s) => NameFormat.LLcFMMM,
		REGEXFIND(rgxLLcFMMMM, s) => NameFormat.LLcFMMMM,
		REGEXFIND(rgxIcF, s) => NameFormat.IcF,
		REGEXFIND(rgxIcFM, s) => NameFormat.IcFM,
		REGEXFIND('[0-9]', s) => NameFormat.Invalid,
		NameFormat.NoName
	);

export GetNameFormatName(string s) := 
	MAP(
		REGEXFIND(rgxFL, s) => 'NameFormat.FL',
		REGEXFIND(rgxFML, s) => 'NameFormat.FML',
		REGEXFIND(rgxFLNick, s) => 'NameFormat.FLNick',
		REGEXFIND(rgxFMML, s) => 'NameFormat.FMML',
		REGEXFIND(rgxL, s) => 'NameFormat.L',
		//REGEXFIND(rgxLP, s) => 'NameFormat.LP',
		REGEXFIND(rgxLJrcF, s) => 'NameFormat.LJrcF',
		REGEXFIND(rgxLScF, s) => 'NameFormat.LScF',
		REGEXFIND(rgxLScFM, s) => 'NameFormat.LScFM',
		REGEXFIND(rgxLcF, s) => 'NameFormat.LcF',
		REGEXFIND(rgxLcFS, s) => 'NameFormat.LcFS',
		REGEXFIND(rgxLcFNick, s) => 'NameFormat.LcFNick',
		REGEXFIND(rgxLcFMNick, s) => 'NameFormat.LcFMNick',
		REGEXFIND(rgxLcFhF, s) => 'NameFormat.LcFhF',
		REGEXFIND(rgxLcFBen, s) => 	'NameFormat.LcFBen',
		REGEXFIND(rgxLcFMBen, s) => 	'NameFormat.LcFMBen',
		REGEXFIND(rgxLcFMS, s) => 'NameFormat.LcFMS',
		REGEXFIND(rgxLcFMcS, s) => 'NameFormat.LcFMcS',
		REGEXFIND(rgxLcScF, s) => 'NameFormat.LcScF',
		REGEXFIND(rgxLcScFM, s) => 'NameFormat.LcScFM',
		REGEXFIND(rgxLcFM, s) => 'NameFormat.LcFM',
		REGEXFIND(rgxLcFMM, s) => 'NameFormat.LcFMM',
		REGEXFIND(rgxLcFMMM, s) => 'NameFormat.LcFMMM',
		REGEXFIND(rgxLcFMMMM, s) => 'NameFormat.LcFMMMM',
		REGEXFIND(rgxFLA, s) => 'NameFormat.FLA',
		REGEXFIND(rgxLA, s) => 'NameFormat.LA',
		REGEXFIND(rgxLAcF, s) => 'NameFormat.LAcF',
		REGEXFIND(rgxLAcFM, s) => 'NameFormat.LAcFM',
		REGEXFIND(rgxLAcFMS, s) => 'NameFormat.LAcFMS',
		REGEXFIND(rgxLcFAM, s) => 'NameFormat.LcFAM',
		REGEXFIND(rgxLcFMA, s) => 'NameFormat.LcFMA',
		REGEXFIND(rgxLLcF, s) => 'NameFormat.LLcF',
		REGEXFIND(rgxLLcFM, s) => 'NameFormat.LLcFM',
		REGEXFIND(rgxLLcFMM, s) => 'NameFormat.LLcFMM',
		REGEXFIND(rgxLLcFMMM, s) => 'NameFormat.LLcFMMM',
		REGEXFIND(rgxLLcFMMMM, s) => 'NameFormat.LLcFMMMM',
		REGEXFIND(rgxIcF, s) => 'NameFormat.IcF',
		REGEXFIND(rgxIcFM, s) => 'NameFormat.IcFM',
		REGEXFIND('[0-9]', s) => 'NameFormat.Invalid',
		'NameFormat.NoName'
	);

shared string50 blank20 := ' ';
shared string6 blank5 := ' ';


shared string155 FormatNameFM(string rgx, string name, integer fn, integer mn) := 
	(string50)REGEXFIND(rgx, name, fn) +
	(string50)(REGEXFIND(rgx, name,mn)) +
	blank20 +
	blank5;
shared string155 FormatNameFL(string rgx, string name, integer fn, integer lnm) := 
	(string50)REGEXFIND(rgx, name, fn) +
	blank20 +
	(string50)(REGEXFIND(rgx, name,lnm)) +
	blank5;
shared string155 FormatNameFLS(string rgx, string name, integer fn, integer lnm, integer sn) := 
	(string50)REGEXFIND(rgx, name, fn) +
	blank20 +
	(string50)(REGEXFIND(rgx, name, lnm)) +
	(string6)REGEXFIND(rgx, name, sn);
shared string155 FormatNameFML(string rgx, string name, integer fn, integer mn, integer lnm) := 
	(string50)REGEXFIND(rgx, name, fn) +
	(string50)(TRIM(stringlib.StringFilterOut(REGEXFIND(rgx, name, mn),'()'), LEFT,RIGHT)) +
	(string50)(REGEXFIND(rgx, name, lnm)) +
	blank5;

shared string155 FormatNameFMLS(string rgx, string name, integer fn, integer mn, integer lnm, integer sn) := 
	(string50)REGEXFIND(rgx, name, fn) +
	(string50)REGEXFIND(rgx, name, mn) +
	(string50)(REGEXFIND(rgx, name, lnm)) +
	(string6)REGEXFIND(rgx, name, sn);
	
shared string155 FormatNameL(string rgx, string name, integer lnm) := 
	blank20 +
	blank20 +
	(string50)(REGEXFIND(rgx, name, lnm)) +
	blank5;
shared string155 FormatNameF(string rgx, string name, integer fnm) := 
	(string50)REGEXFIND(rgx, name, fnm) +
	blank20 +
	blank20 +
	blank5;
shared string155 FormatNameLS(string rgx, string name, integer lnm, integer sfx) := 
	blank20 +
	blank20 +
	(string50)(REGEXFIND(rgx, name, lnm)) +
	(string6)REGEXFIND(rgx, name, sfx);

cleanupsfx(string s) := MAP(
	REGEXFIND('\\(?SENIOR\\)?', s) => REGEXREPLACE('(\\(?SENIOR\\)?)', s, 'SR'),
	REGEXFIND('\\(JUNIOR\\)', s) => REGEXREPLACE('(\\(JUNIOR\\))', s, 'JR'),
	REGEXFIND('\\(SR\\)', s) => REGEXREPLACE('(\\(SR\\))', s, 'SR'),
	REGEXFIND('\\(JR\\)', s) => REGEXREPLACE('(\\(JR\\))', s, 'JR'),
	REGEXFIND('\\(II\\)', s) => REGEXREPLACE('(\\(II\\))', s, 'II'),
	s);
	
string RemoveRigthParen(string s) :=
	IF(stringlib.StringFind(s,'(',1) = 0, 
		stringlib.StringFindReplace(s,')',''),s);
	
export PrecleanName(string rawname) := 
	TRIM(
		RemoveRigthParen(
		cleanupsfx(stringlib.StringFilterOut(rawname, '.\'')))
	,LEFT,RIGHT);
	
export string161 CleanName(string rawname) := FUNCTION
	s := PrecleanName(rawname);
	n := GetNameFormat(s);

	return blank5 +
		CASE (n,
			NameFormat.NoName => '',	//FormatNameL('(.+)', s, 1),
			NameFormat.FL =>	FormatNameFL(rgxFL, s, 1, 2),
			NameFormat.FML =>	FormatNameFML(rgxFML, s, 1, 2, 3),
			NameFormat.FMML =>	FormatNameFML(rgxFMML, s, 1, 2, 3),
			NameFormat.FLNick =>	FormatNameFML(rgxFLNick, s, 1, 5, 2),
			NameFormat.LcFMS => FormatNameFMLS(rgxLcFMS, s, 4, 5, 1, 6),
			NameFormat.LcScF => 	FormatNameFLS(rgxLcScF, s, 5, 1, 4),
			NameFormat.LcScFM => FormatNameFMLS(rgxLcScFM, s, 5, 6, 1, 4),
			NameFormat.LcFMcS => FormatNameFMLS(rgxLcFMcS, s, 4, 5, 1, 6),
			NameFormat.LJrcF => 	FormatNameFML(rgxLJrcF, s, 5, 1, 4),
			NameFormat.LScF => 	FormatNameFLS(rgxLScF, s, 5, 1, 4),
			NameFormat.LScFM => 	FormatNameFMLS(rgxLScFM, s, 5, 6, 1, 4),
			NameFormat.LcF => 	FormatNameFL(rgxLcF, s, 4, 1),
			NameFormat.IcF => 	FormatNameFL(rgxIcF, s, 2, 1),
			NameFormat.IcFM => 	FormatNameFML(rgxIcFM, s, 2, 3, 1),
			NameFormat.LcFS => 	FormatNameFLS(rgxLcFS, s, 4, 1, 5),
			NameFormat.LcFNick => 	FormatNameFML(rgxLcFNick, s, 4, 5, 1),
			NameFormat.LcFMNick => 	FormatNameFML(rgxLcFMNick, s, 4, 5, 1),
			NameFormat.LcFhF => 	FormatNameFL(rgxLcFhF, s, 4, 1),
			NameFormat.LcFM => 	FormatNameFML(rgxLcFM, s, 4, 5, 1),
			NameFormat.FLA =>	FormatNameFL(rgxFLA, s, 1, 2),
			NameFormat.LA => 	FormatNameL(rgxLA, s, 1),
			NameFormat.LAcF => 	FormatNameFL(rgxLAcF, s, 5, 1),
			NameFormat.LcFAM => 	FormatNameFML(rgxLcFAM, s, 2, 4, 1),
			NameFormat.LcFMA => 	FormatNameFML(rgxLcFMA, s, 2, 3, 1),
			NameFormat.LAcFM => 	FormatNameFML(rgxLAcFM, s, 5, 6, 1),
			NameFormat.LAcFMS => 	FormatNameFMLS(rgxLAcFMS, s, 5, 6, 1, 7),
			NameFormat.LcFBen => 	FormatNameFML(rgxLcFBen, s, 2, 3, 1),
			NameFormat.LcFMBen => 	FormatNameFML(rgxLcFMBen, s, 2, 3, 1),
			NameFormat.LcFMM => FormatNameFML(rgxLcFMM, s, 4, 5, 1),
			NameFormat.LcFMMM => FormatNameFML(rgxLcFMMM, s, 4, 5, 1),
			NameFormat.LcFMMMM => FormatNameFML(rgxLcFMMMM, s, 4, 5, 1),
			NameFormat.LLcF => FormatNameFL(rgxLLcF, s, 5, 1),
			NameFormat.LLcFM => FormatNameFML(rgxLLcFM, s, 5, 6, 1),
			NameFormat.LLcFMM => FormatNameFML(rgxLLcFMM, s, 2, 3, 1),
			NameFormat.LLcFMMM => FormatNameFML(rgxLLcFMMM, s, 2, 3, 1),
			NameFormat.LLcFMMMM => FormatNameFML(rgxLLcFMMMM, s, 2, 3, 1),
			NameFormat.L => 	FormatNameL(rgxL, s, 1),
			NameFormat.LP => 	FormatNameL(rgxLP, s, 1),
			NameFormat.Invalid => 	FormatNameL('(.+)', s, 1),
			'*****'
		);
END;

shared NamesWithAlias := [
	NameFormat.LA, NameFormat.FLA, NameFormat.LcFAM, NameFormat.LcFMA,
		NameFormat.LAcF, NameFormat.LAcFM, NameFormat.LAcFMS];

export boolean HasAlias(string name) := 
	GetNameFormat(PrecleanName(name)) in NamesWithAlias;
	
export string160 CleanAlias(string rawname) := FUNCTION
	s := PrecleanName(rawname);
	n := GetNameFormat(s);
	RETURN IF(n in NamesWithAlias,
		blank5 + CASE(n,
			NameFormat.FLA =>	FormatNameFL(rgxFLA, s, 1, 5),
			NameFormat.LA => 	FormatNameL(rgxLA, s, 5),
			NameFormat.LAcF => 	FormatNameFL(rgxLAcF, s, 5, 1),
			NameFormat.LcFAM => 	FormatNameFML(rgxLcFAM, s, 3, 4, 1),
			NameFormat.LcFMA => 	FormatNameFML(rgxLcFMA, s, 2, 4, 1),
			NameFormat.LAcFM => 	FormatNameFML(rgxLAcFM, s, 5, 6, 4),
			NameFormat.LAcFMS => 	FormatNameFMLS(rgxLAcFMS, s, 5, 6, 4, 7),
			''
		),
	'');
END;
	
export HasParen(string s) :=
	REGEXFIND('\\((.+)\\)', s);
	
export GetParen(string s) :=
	REGEXFIND('\\((.+)\\)', s, 1);
	
export RemoveParen(string s) :=
	stringlib.StringCleanSpaces(TRIM(REGEXREPLACE('(\\(.+\\))', s, ''),LEFT,RIGHT));
	
// these regular expression are for the new requirements Bugzilla #113443 
shared rgxLcAny := '^([^,]+),(.+)$';		//Last, First -- anything not a comma then comma then anything
shared rgxFany := '^([^ ,]+) +(.+)$';		//First Anything else -- first allows any but space or comma

// new functions:
export string FirstName(string name) := MAP(
	REGEXFIND(rgxLcAny, name) => REGEXFIND(rgxLcAny, name, 2),
	REGEXFIND(rgxFany, name) => REGEXFIND(rgxFany, name, 1),
	name)
	;
export string LastName(string name) := MAP(
	REGEXFIND(rgxLcAny, name) => REGEXFIND(rgxLcAny, name, 1),
	REGEXFIND(rgxFany, name) => REGEXFIND(rgxFany, name, 2),
	name)
	;
export string FullName(string name) := '';
	
END;