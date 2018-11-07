IMPORT lib_StringLib;
EXPORT ScrubCName (STRING40 CNAME, UNSIGNED2 pInstance = 1) := FUNCTION

	Special_CHAR					:=	'|0xA6|@|\\$|%|0xAC||\\*|\\(|\\)|_|\\=|:|;|!|0xA2|\\}|\\.|\\{|\\?|\\|<|>|"|`|~|&|0x00|0xFF|0xBA|0xBB|0x5B|0x5D|\'';
	Space_CHAR						:=	'\\,|\\\\|-';
	Number_Rest_Spl_CHAR	:= '^([0-9#$-])*$';
	hyphenated_number		 	:=  '^([0-9]+[-,/][0-9]+[-,/][0-9]+)$';
	hyphenated_number_2	 	:=  '^([0-9]+[-,/][0-9]+)$';
	web_site							:=	'^[a-zA-Z0-9\\-\\.]+\\.(COM|ORG|NET|MIL|EDU)$';

	UC := lib_StringLib.StringLib.StringCleanSpaces(lib_StringLib.StringLib.StringToUpperCase(CNAME));
	RemoveUnprinChar	:=	REGEXREPLACE ('[^[:print:]]', UC, '');
	boolean isDashNo	:=	REGEXFIND(hyphenated_number, RemoveUnprinChar) OR REGEXFIND(hyphenated_number_2, RemoveUnprinChar);
	RemoveDashNo			:=	IF (isDashNo,regexreplace('[-,/]', RemoveUnprinChar, ''), RemoveUnprinChar);
	boolean isWeb			:=	REGEXFIND(web_site, RemoveDashNo);
	RemoveSpecialChar :=	IF(isWeb,RemoveDashNo,REGEXREPLACE (Special_CHAR,RemoveDashNo,''));
	ReplaceWSpace			:=	REGEXREPLACE (Space_CHAR,RemoveSpecialChar,' ');

	RemoveBegSpecChar	:=	IF (pInstance = 1,REGEXREPLACE ('(^| )[-.&:\'@_\\\\/~]',ReplaceWSpace,'$1'),REGEXREPLACE ('(^| )[-.:\'@_\\\\/~]',ReplaceWSpace,'$1'));
	RemoveEndSpecChar	:=	REGEXREPLACE ('[-.:\'@_\\\\/~]( |$)',RemoveBegSpecChar,'$1');
	
	S_WORD 					:= TRIM (RemoveEndSpecChar,LEFT,RIGHT);
	boolean flag 		:= regexfind(Number_Rest_Spl_CHAR, S_WORD);
	ScrubName				:= if(flag, regexreplace('[#$-]', S_WORD, ''), S_WORD); 
	Clean_ScrubName := if(flag AND ScrubName <> '' , (string)(integer) ScrubName, ScrubName);			
	RETURN Clean_ScrubName;
END;