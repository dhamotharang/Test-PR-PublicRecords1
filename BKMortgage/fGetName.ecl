IMPORT $, STD;

EXPORT fGetName	:= MODULE

EXPORT	DBApattern	:= '(A/K/A | AKA |ALSO KNOWN AS| ALSO KNOWN OF RECORD AS |ALSO APPEARING OF RECORD AS | F/K/A| F/K/A:| F/K./A | XFKA | FKA |\\(FKA|D/B/A| DBA |FORMERLY KNOWN AS|FORMERLY |NOW KNOWN AS)(.*)';
EXPORT	XtraInfo		:= '(ACTING SOLELY| SOLOELY AS | (SOLELY AS )*NOMINEE FOR| SOLELY |(AND )*ITS SUCCESSOR([S]*) |SUCCESSOR BY| SUCCESSOR TO| (( IS| AS)* SUCCESSOR)|'+
														' SUCCESSOR| | AND TO ITS| A DIV OF|A DIVISION OF|AS GENERAL MANAGER|WHOSE ADDRESS | NOT IN ITS INDIVIDUAL |,ACT G | AS RECEIVER FOR | AS DESIGNATED|'+
														' CO-DEVISEE| INDIVIDUALLY AND| NOT AS TENANTS| AS TENANTS | AS JOINT TENANTS| EACH AS TO | AMARRIED MAN|A MARRIED MAN|A MARRIED WOMAN|'+
														' A MARRIED | AN UNMARRIED| A SINGLE | SINGLE,| HUSBAND AND WIFE| WIFE AND HUSBAND|HIS WIFE | (AND (HUSBAND|WIFE))| JOINED HEREIN | JOINING HEREIN)(.*)';

EXPORT CleanName(STRING dname)	:= FUNCTION
				string uppername	:= STD.Str.ToUpperCase(dname);
				RmvDBA1			:=	IF(STD.Str.Find(dname,'(A/K/A',1)>0, dname[1..STD.Str.Find(dname,'(A/K/A',1)-1], dname);
				RmvDBA2			:=	IF(STD.Str.Find(RmvDBA1,'A/K/A',1)>0, RmvDBA1[1..STD.Str.Find(RmvDBA1,' A/K/A',1)], RmvDBA1);
				RmvDBA3			:=	IF(STD.Str.Find(RmvDBA2,'(AKA ',1)>0, RmvDBA2[1..STD.Str.Find(RmvDBA2,'(AKA ',1)-1], RmvDBA2);
				RmvDBA4			:=	IF(STD.Str.Find(RmvDBA3,' AKA ',1)>0, RmvDBA3[1..STD.Str.Find(RmvDBA3,' AKA ',1)], RmvDBA3);
				RmvDBA5			:=	IF(STD.Str.Find(RmvDBA4,'ALSO KNOWN',1)>0, RmvDBA4[1..STD.Str.Find(RmvDBA4,' ALSO KNOWN ',1)], RmvDBA4);
				RmvDBA6			:=	IF(STD.Str.Find(RmvDBA5,'ALSO APPEARING',1)>0, RmvDBA5[1..STD.Str.Find(RmvDBA5,' ALSO APPEARING ',1)], RmvDBA5);
				RmvDBA7			:=	IF(STD.Str.Find(RmvDBA6,'F/K/A',1)>0, RmvDBA6[1..STD.Str.Find(RmvDBA6,' F/K/A',1)], RmvDBA6);
				RmvDBA8			:=	IF(STD.Str.Find(RmvDBA7,'F/K./A',1)>0, RmvDBA7[1..STD.Str.Find(RmvDBA7,' F/K./A',1)], RmvDBA7);
				RmvDBA9			:=	IF(STD.Str.Find(RmvDBA8,'F/K/A:',1)>0, RmvDBA8[1..STD.Str.Find(RmvDBA8,' F/K/A:',1)], RmvDBA8);
				RmvDBA10		:=	IF(STD.Str.Find(RmvDBA9,'.FKA ',1)>0, RmvDBA9[1..STD.Str.Find(RmvDBA9,'.FKA ',1)], RmvDBA9);
				RmvDBA11		:=	IF(STD.Str.Find(RmvDBA10,'(FKA ',1)>0, RmvDBA10[1..STD.Str.Find(RmvDBA10,'(FKA ',1)-1], RmvDBA10);
				RmvDBA12		:=	IF(STD.Str.Find(RmvDBA11,' FKA ',1)>0, RmvDBA11[1..STD.Str.Find(RmvDBA11,' FKA ',1)], RmvDBA11);
				RmvDBA13		:=	IF(STD.Str.Find(RmvDBA12,'(FORMERLY',1)>0, RmvDBA12[1..STD.Str.Find(RmvDBA12,'(FORMERLY',1)-1], RmvDBA12);
				RmvDBA14		:=	IF(STD.Str.Find(RmvDBA13,' FORMERLY',1)>0, RmvDBA13[1..STD.Str.Find(RmvDBA13,' FORMERLY',1)], RmvDBA13);
				RmvDBA15		:=	IF(STD.Str.Find(RmvDBA14,'(D/B/A',1)>0, RmvDBA14[1..STD.Str.Find(RmvDBA14,'(D/B/A',1)-1], RmvDBA14);
				RmvDBA16		:=	IF(STD.Str.Find(RmvDBA15,'D/B/A',1)>0, RmvDBA15[1..STD.Str.Find(RmvDBA15,' D/B/A',1)], RmvDBA15);
				RmvDBA17		:=	IF(STD.Str.Find(RmvDBA16,'NOW KNOW',1)>0, RmvDBA16[1..STD.Str.Find(RmvDBA16,' NOW KNOW',1)], RmvDBA16);
				RmvDBA18		:=	IF(STD.Str.Find(RmvDBA17,'AS NOMINEE',1)>0, RmvDBA17[1..STD.Str.Find(RmvDBA17,' AS NOMINEE',1)], RmvDBA17);
										
				ParseName		:= IF(TRIM(RmvDBA18) = '',dname,RmvDBA18);
				NameStripped 	:= MAP(regexfind('([( ,]HUSBAND AND WIFE)',ParseName) => regexreplace('(.*)([( ,]HUSBAND AND WIFE(.*)|[( ,]HUSBAND AND WIFE[ ]*$)',ParseName,'$1'),
														regexfind('([( ,]*MARRIED|SINGLE|AN UNMARRIED)',ParseName) => regexreplace('(.*)(([( ,][A]* (MARRIED (MAN|WOMAN|PERSON)|SINGLE (MAN|WOMAN|PERSON))|AN UNMARRIED (MAN|WOMAN|PERSON))(.*)|[( ,]([A]* MARRIED (MAN|WOMAN|PERSON)|ASINGLE (MAN|WOMAN|PERSON))|AN UNMARRIED (MAN|WOMAN|PERSON)[ ]*$)',ParseName,'$1'),
														regexfind('([( ,]SOLELY AS NOMINE|ACTING SOLELY|AS DESIGNATED NOMINEE|AS TRUSTEE|NOT AS TENANTS|TRUSTEES)',ParseName) => regexreplace('(.*)([( ,]SOLELY AS NOMINE|ACTING SOLELY|AS DESIGNATED NOMINEE|AS TRUSTEE|NOT AS TENANTS|TRUSTEES)(.*)',ParseName,'$1'),
														regexfind('([( ]AS NOMINE)',ParseName) => regexreplace('(.*)([( ]AS NOMINE)(.*)',ParseName,'$1'),
														regexfind(XtraInfo,ParseName) => regexreplace('(.*)[ ,;\\.]+ '+XtraInfo+'[ ,]+(.*)',ParseName,'$1'),
														stringlib.stringfind(ParseName,',',1)>0 and stringlib.stringfind(ParseName,'CORP',1)>0   => regexreplace('(.*)(CORP[ORATION]+),(.*)',ParseName,'$1$2'),
														stringlib.stringfind(ParseName,',',1)>0 and stringlib.stringfind(ParseName,', BY ',1)>0  => regexreplace('(.*), BY (.*)',ParseName,'$1'),
														ParseName);
	RETURN NameStripped;
END;

EXPORT DBAName(string dname)	:= FUNCTION
					string upperDBA		:= STD.Str.ToUpperCase(dname);
					string temp_dba		:=	regexfind(DBApattern,dname,2);
					string temp_dba2	:=	IF(regexfind('^(.*)'+DBApattern+'(.*)',temp_dba), regexfind('^(.*)'+DBApattern,temp_dba,1),temp_dba);
					string temp_dba3	:=	REGEXREPLACE('^(KNOW AS )|[,)]$',temp_dba2,'');
	RETURN STD.Str.CleanSpaces(temp_dba3);
END;

END;