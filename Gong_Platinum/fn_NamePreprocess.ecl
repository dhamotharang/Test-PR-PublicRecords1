Designators := 
'\\b(ATTY AT LAW|DGN ATTY|ATTY|ATTYS|ATTORNEY|LWYR|LAWYE|OFC|CFS|PEDIATRIC|Court Reprtr|CCCA|Dgn Dntst|Dgn Arry|DCPC|Cva|Dentst|Faccp|Cdr|Vmd|Mvb|Ppa|Archt|PEDIATRC DNTST|PODIATRST|Cva|Lt Colonel|Rent House|OPTMTRST|DDSPA|CCCA|F A X|DMDMS|DABCI|LSCSW|LMSW|OAD|PT|LT|ACSW|RVT|U S N RET)\\b';
string RemoveDesignators(string s) :=
	TRIM(REGEXREPLACE(Designators, s, '', NOCASE));

string RemoveFax(string s) :=
	TRIM(REGEXREPLACE('\\b(FAX LINE|FAXLINE|MOBILE PHONE|DSL LINE)\\b', s, '', NOCASE));
	//TRIM(REGEXREPLACE('\\b(FAX|FAXLINE|MOBILE PHONE)\\b', s, '', NOCASE));


string TrimRight(string s) := TRIM(REGEXREPLACE('[.,&(\'/\\\\]$',s,''),LEFT,RIGHT);

// split indicators
set_typeBus 				:= ['4','5','7'];
 set_typeRes				:= ['1','5','7'];
 set_typeGov				:= ['6','7'];


rgxLast := '^(DI|DA|DEL|DE LA|DE LOS|DES|DE|DELLA|DELA|DELLO|DOS|DU|LA|MC|VON|VAN DER|VAN|VANDER|ST|EL|LE) ([A-Z]+)$';

string FixupGen(string s) := MAP(
		REGEXFIND('\\b(2ND)\\b', s) => REGEXREPLACE('(2ND)',s, 'II'),
		REGEXFIND('\\b(3RD|3D)\\b', s) => REGEXREPLACE('(3RD|3D)',s, 'III'),
		REGEXFIND('\\b(4TH)\\b', s) => REGEXREPLACE('(4TH)',s, 'IV'),
		s);

rgxSureGen := '\\b(JR|SR|II|III|IV|2ND|3RD|4TH|5TH|6TH)\\b';
GetGen(string s) := TRIM(REGEXFIND(rgxSureGen,s,1));

string fixupFirstName(string s) := FUNCTION
	s1aa := RemoveDesignators(s);
	s1a := RemoveFax(s1aa);
	s1b := IF(REGEXFIND('^[A-Z]\\.[A-Z]\\.$',s1a),s1a[1] + ' ' + s1a[3],s1a);
	s1 := FixupGen(s1b);
	s2 := IF(REGEXFIND('\\\\.*$',s1),REGEXREPLACE('^(.*)\\\\.*$',s1,'$1'),s1);
	s3 := IF(REGEXFIND('[A-Z]+/[A-Z]+$',s2),REGEXREPLACE('([A-Z]+)/([A-Z]+)$',s2,'$1&$2'),s2);
	s3a := IF(REGEXFIND('[A-Z]{2,}\'[A-Z]+$',s3),StringLib.StringFindReplace(s3,'\'',' '),s3);
	s4 := IF(REGEXFIND('\\bAND$',s3a),REGEXREPLACE('\\b(AND)$',s3a,''),s3a);
	s5 := IF(REGEXFIND('\\bOF$',s4),REGEXREPLACE('\\b(OF)$',s4,''),s4);
	return TrimRight(s5);
END;

string fixupLastName(string s) := 
	MAP(
		REGEXFIND(rgxLast, s) => s,
		REGEXFIND('^O [A-Z]', s) => REGEXREPLACE('^O ([A-Z])',s, 'O\'$1'),
		REGEXFIND('^O \'[A-Z]', s) => REGEXREPLACE('^O \'([A-Z])',s, 'O\'$1'),
		REGEXFIND('^D-[A-Z]', s) => REGEXREPLACE('^D-([A-Z])',s, 'D\'$1'),
		REGEXFIND('^[A-Z] \'S', s) => REGEXREPLACE('^([A-Z]) \'S',s, '$1\'S'),
		REGEXFIND('^([A-Z]+) (JR|SR|II|III|IV)$', s) => s,
		REGEXFIND('^([A-Z]+) AND$', s) => REGEXREPLACE('^^([A-Z]+) AND$',s, '$1'),
//		REGEXFIND('^([A-Z]{2,}) ([A-Z]{2,})$',s) => REGEXREPLACE('^([A-Z]+) ([A-Z]+)$',s, '$1-$2'),
		REGEXFIND('^([A-Z]{2,})\'([A-Z]{2,})$',s) => REGEXREPLACE('^([A-Z]+)\'([A-Z]+)$',s, '$1-$2'),
		REGEXFIND('^[A-Z]\\. [A-Z]', s) => StringLib.StringFilterOut(s,'.'),
		s[1] = '.' => s[2..],
		s = 'AND' => '',
		s = 'OR' => '',
		stringlib.StringFindReplace(s,'`','\'')
	);
	
string FixupHyphen(string s) := FUNCTION
	s1 := REGEXREPLACE(' - ',s,'-');
	s2 := REGEXREPLACE('- ',s1,'-');
	s3 := REGEXREPLACE(' -',s2,'-');
	return s3;
END;

string fixupIdleCharacter(string s) := 
	IF(REGEXFIND('^[A-Z] [A-Z]',s),
		TRIM(s[3..]) + ' ' + s[1], s);
		
string RemoveParen(string s) := MAP(
	REGEXFIND('(\\(\\([A-Z -]*\\)\\))',s) => REGEXREPLACE('(\\(\\([A-Z -]*\\)\\))',s,''),
	REGEXFIND('(\\([A-Z -]+\\)).+\\1',s) => REGEXREPLACE('(\\([A-Z -]+\\))',s,''),
	s);
		
//string fixupWholeName(string s) := 
//	StringLib.StringCleanSpaces(
//	stringlib.StringFindReplace(
//		stringlib.StringFindReplace(fixupIdleCharacter(s),'(',' ')
//	,')',' '));
string fixupWholeName(string s) := TRIM(
	StringLib.StringCleanSpaces(
		RemoveParen(s)
		//fixupIdleCharacter(RemoveParen(s))
	)
		,LEFT,RIGHT);
		
string removeFtd(string s, string ftd) := MAP(
	ftd='' => s,
	Stringlib.StringFind(s, ' ' + ftd + ' ', 1) > 0 => Stringlib.StringFindReplace(s, ' ' + ftd + ' ', ' '),
	Stringlib.StringFind(s, ' ' + ftd, 1) > 0 => Stringlib.StringFindReplace(s, ' ' + ftd, ''),
	Stringlib.StringFind(s, '/' + ftd + ' ', 1) > 0 => Stringlib.StringFindReplace(s, '/' + ftd + ' ', ' '),
	Stringlib.StringFind(s, '/' + ftd, 1) > 0 => Stringlib.StringFindReplace(s, '/' + ftd, ''),
	s);
	
string RemoveMrMrs(string lstgn) := 
	TRIM(REGEXREPLACE('^& (MR|MRS|MS) ',
		REGEXREPLACE('MR & MRS', lstgn, '',NOCASE),
	'', NOCASE),LEFT);
	
boolean IsResidential(string1 split, boolean biz) :=
		IF(biz, split = '1', split in set_typeRes);
		
export string fn_NamePreprocess(string lstnm, string lstgn, string ftd, string1 split, boolean biz = false) := FUNCTION
	name1a := StringLib.StringToUpperCase(TRIM(lstnm,LEFT,RIGHT));
	name1b := REGEXREPLACE(' - ',name1a,'-');
	name1c := REGEXREPLACE('- ',name1b,'-');
	name1  := IF(IsResidential(split, biz), 
				fixupLastName(name1c),
				name1c);
	
	name2a := StringLib.StringToUpperCase(TRIM(lstgn,LEFT,RIGHT));
	name3a := RemoveMrMrs(name2a);
	ftd1 := StringLib.StringToUpperCase(TRIM(ftd));
	name2b := removeFtd(name3a, ftd1);
							//StringLib.StringFindReplace(name2a, ftd1, ''));
	gen := IF(IsResidential(split, biz),GetGen(name2b),'');
	ftd1aa := IF(split='1',RemoveDesignators(ftd1),ftd1);
	ftd1a := IF(IsResidential(split, biz),RemoveFax(ftd1aa),ftd1aa);
	ftd2 := TRIM(IF(gen='',ftd1a,gen + ' ' + ftd1a));
	sfx := IF(gen='',GetGen(ftd1a),gen);
	name2c := IF(gen='',name2b,StringLib.StringFindReplace(name2a, ' '+gen, ''));
	name2 := removeFtd(name2c, ftd1);
							//StringLib.StringFindReplace(name2c, ftd1, ''));
	fullname := MAP(
			name2 = '&' => name1,
			name2[1] = '&' => name1 + ' ' + name2 + if(ftd2='','',' ' + ftd2),
			name2[1] = '-' => name1 + name2 + if(ftd2='','',' ' + ftd2),
			name2[1] = '\'' => name1 + name2 + if(ftd2='','',' ' + ftd2),
			name1[1] = '&' => name2 + ' ' + name1 + if(ftd2='','',' ' + ftd2),
			IsResidential(split, biz) => fixupFirstName(name2) + ' ' + name1 + if(sfx='','',' ' + sfx),
			name1 + ' ' + name2 + if(ftd2='','',' ' + ftd2)
			);
			
	fullname1 := FixupHyphen(fullname);

	RETURN 	IF(IsResidential(split, biz),
					fixupWholeName(fullname1), TrimRight(RemoveParen(fullname1)));
END;
