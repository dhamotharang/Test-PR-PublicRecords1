IMPORT $, STD;

EXPORT fGetName	:= MODULE

EXPORT	DBApattern	:= '(A/K/A | AKA |ALSO KNOWN AS| ALSO KNOWN OF RECORD AS |ALSO APPEARING OF RECORD AS | D/B/A| DBA |NOW KNOWN AS)(.*)';
EXPORT	XtraInfo		:= '(ACTING SOLELY| SOLOELY AS | (SOLELY AS )*NOMINEE FOR| SOLELY |(AND )*ITS SUCCESSOR([S]*) |SUCCESSOR BY| SUCCESSOR TO| (( IS| AS)* SUCCESSOR)|'+
														' SUCCESSOR| | AND TO ITS| AS GENERAL MANAGER|WHOSE ADDRESS | NOT IN ITS INDIVIDUAL |,ACT G | AS RECEIVER FOR | AS DESIGNATED|'+
														' CO-DEVISEE| INDIVIDUALLY AND| NOT AS TENANTS| AS TENANTS | AS JOINT TENANTS| EACH AS TO | AMARRIED MAN|A MARRIED MAN|A MARRIED WOMAN|'+
														' AN UNMARRIED| A SINGLE | SINGLE, |HIS WIFE | JOINED HEREIN | JOINING HEREIN)(.*)';

EXPORT CleanName(STRING dname)	:= FUNCTION
				NameStripped 	:= MAP(REGEXFIND('([( ,]HUSBAND AND WIFE|[( ,]WIFE AND HUSBAND)',dname) => REGEXREPLACE('(.*)([( ,](AS*|A*) HUSBAND AND WIFE(.*)|[( ,]HUSBAND AND WIFE[ ]*$|[( ,]WIFE AND HUSBAND(.*)|[( ,]WIFE AND HUSBAND[ ]*$)',dname,'$1'),
														REGEXFIND('([( ,]*MARRIED|SINGLE|AN UNMARRIED)',dname) => REGEXREPLACE('(.*)(([( ,]*A* MARRIED (MAN|WOMAN|PERSON)|[(, ]*A SINGLE (MAN|WOMAN|PERSON)|, SINGLE$|AN UNMARRIED (MAN|WOMAN|PERSON(S)*))[ ,]*$)(.*)',dname,'$1'),
														REGEXFIND(XtraInfo,dname) => REGEXREPLACE('(.*)[ ,;\\.]+ '+XtraInfo+'[ ,]+(.*)',dname,'$1'),
														STD.Str.Find(dname,',',1)>0 and STD.Str.Find(dname,'CORP',1)>0   => REGEXREPLACE('(.*)(CORP[ORATION]+),(.*)',dname,'$1$2'),
														STD.Str.Find(dname,',',1)>0 and STD.Str.Find(dname,', BY ',1)>0  => REGEXREPLACE('(.*), BY (.*)',dname,'$1'),
														dname);
	RETURN NameStripped;
END;

EXPORT DBAName(string dname)	:= FUNCTION
					string upperDBA		:= STD.Str.ToUpperCase(dname);
					string temp_dba		:=	REGEXFIND(DBApattern,dname,2);
					string temp_dba2	:=	IF(REGEXFIND(DBApattern,temp_dba), REGEXFIND('(.*)'+DBApattern,temp_dba,1),temp_dba);
					string temp_dba3	:=	REGEXREPLACE('^(KNOW AS )|[,)]$',temp_dba2,'');
	RETURN STD.Str.CleanSpaces(temp_dba3);
END;

//Get name w/o DBA/AKA name from name field
EXPORT NoDBAName(string dname)	:= FUNCTION
				string uppername	:= TRIM(STD.Str.ToUpperCase(dname),LEFT,RIGHT);
				string temp_name	:= IF(REGEXFIND(DBApattern,uppername), REGEXFIND('(.*)'+DBApattern+'(.*)',uppername,1), uppername);
	RETURN STD.Str.CleanSpaces(temp_name);
END;

EXPORT RmvBracket(string dname)	:= FUNCTION
					string FixAKA 		:= MAP(STD.Str.Find(dname,'A/K]A',1)>0 => STD.Str.FindReplace(dname,'A/K]A','A/K/A'),
																		STD.Str.Find(dname,'A]K/A',1)>0 => STD.Str.FindReplace(dname,'A]K/A','A/K/A'),
																		STD.Str.Find(dname,'F/K]A',1)>0 => STD.Str.FindReplace(dname,'F/K]A','F/K/A'),
																		STD.Str.Find(dname,'F]K/A',1)>0 => STD.Str.FindReplace(dname,'F]K/A','F/K/A'),
																		dname);
					string ClnBracket	:= IF(REGEXFIND('(\\[|\\]|<|>)',FixAKA), REGEXREPLACE('(\\[|\\]|<|>)',FixAKA,''), FixAKA);
					
		RETURN STD.Str.CleanSpaces(ClnBracket);
END;

END;