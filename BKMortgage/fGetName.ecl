IMPORT $, STD;

EXPORT fGetName	:= MODULE

EXPORT	DBApattern	:= '^(.*)(A/K/A | AKA |ALSO KNOWN AS| ALSO KNOWN OF RECORD AS | F/K/A| F/K/A:| F/K./A |FKA |D/B/A| DBA |FORMERLY KNOWN AS|FORMERLY | NOW KNOW AS )(.*)';
EXPORT	XtraInfo		:= '^(.*)(ACTING SOLELY| SOLOELY AS | ((SOLELY AS )*)NOMINEE FOR| SOLELY |((AND )*)ITS SUCCESSOR([S]*) |SUCCESSOR BY| SUCCESSOR TO| (( IS| AS)* SUCCESSOR)|'+
														' SUCCESSOR| | AND TO ITS| A DIV OF|A DIVISION OF|AS GENERAL MANAGER|WHOSE ADDRESS | NOT IN ITS INDIVIDUAL |,ACT G | AS RECEIVER FOR | AS DESIGNATED'+
														' CO-DEVISEE| INDIVIDUALLY AND| NOT AS TENANTS| AS TENANTS | AS JOINT TENANTS| EACH AS TO | AMARRIED MAN|A MARRIED MAN|A MARRIED WOMAN|'+
														' A MARRIED | AN UNMARRIED| A SINGLE | SINGLE,| HUSBAND AND WIFE| WIFE AND HUSBAND|HIS WIFE | AND HUSBAND| AND WIFE| ND WIFE| JOINED HEREIN | JOINING HEREIN)(.*)';

EXPORT CleanName(STRING dname)	:= FUNCTION
				string uppername	:= STD.Str.ToUpperCase(dname);
				string temp_name	:= IF(REGEXFIND(DBApattern,uppername), REGEXFIND(DBApattern,uppername,1),
															IF(REGEXFIND(XtraInfo,uppername), REGEXFIND(XtraInfo,uppername,1),uppername));
				string temp_name2	:= IF(REGEXFIND(DBApattern,temp_name), REGEXFIND(DBApattern,temp_name,1),
															IF(REGEXFIND(XtraInfo,temp_name), REGEXFIND(XtraInfo,temp_name,1),temp_name));
				string temp_name3	:= IF(REGEXFIND(DBApattern,temp_name2), REGEXFIND(DBApattern,temp_name2,1),
															IF(REGEXFIND(XtraInfo,temp_name2), REGEXFIND(XtraInfo,temp_name2,1),temp_name2));
				string temp_name4	:= IF(REGEXFIND(DBApattern,temp_name3), REGEXFIND(DBApattern,temp_name3,1),
															IF(REGEXFIND(XtraInfo,temp_name3), REGEXFIND(XtraInfo,temp_name3,1),temp_name3));
	RETURN REGEXREPLACE(',$',STD.Str.CleanSpaces(trim(temp_name4,left,right)),'');
END;				

EXPORT DBAName(string dname)	:= FUNCTION
					string upperDBA	:= STD.Str.ToUpperCase(dname);
					string temp_dba	:= REGEXFIND(DBApattern,upperDBA,3);
					string temp_name2	:= IF(REGEXFIND(DBApattern,temp_dba), REGEXFIND(DBApattern,temp_dba,1),
																	IF(REGEXFIND(XtraInfo,temp_dba), REGEXFIND(XtraInfo,temp_dba,1),temp_dba));
					string temp_name3	:= IF(REGEXFIND(DBApattern,temp_name2), REGEXFIND(DBApattern,temp_name2,1),
																	IF(REGEXFIND(XtraInfo,temp_name2), REGEXFIND(XtraInfo,temp_name2,1),temp_name2));
					string temp_name4	:= IF(REGEXFIND(DBApattern,temp_name3), REGEXFIND(DBApattern,temp_name3,1),
																	IF(REGEXFIND(XtraInfo,temp_name3), REGEXFIND(XtraInfo,temp_name3,1),temp_name3));
	RETURN STD.Str.CleanSpaces(temp_name4);
END;

END;