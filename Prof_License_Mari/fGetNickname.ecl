IMPORT lib_StringLib, ut, std;

//Logic to handle stripping out NICKNAME from NAME field.  NAMETYPE should be 'nick' to get NICKNAME or 'strip_nick' get the name w/ the nickname
EXPORT fGetNickname(string name, string nametype) := FUNCTION

// 'NICK' parsed name field  
// 'STRIP_NICK'full name

quote_pattern					:= '^(.*)\\"(.*)\\"(.*)$';
paren_pattern 				:= '^(.*)\\((.*)\\)(.*)$';
dbl_quote_pattern 		:= '^(.*)\\"\\"(.*)\\"\\"(.*)$';
paren_quote_pattern 	:= '^([A-Za-z ][^\\(]+)[\\(][\\"]([^\\"][A-Z ][^\\"]+)[\\"][\\)]*.';

// Identify NICKNAME in the various format 
			STRING	fNickName(STRING pStringIn) := FUNCTION
							STRING	lStdNickName				:= ut.CleanSpacesAndUpper(pStringIn);
							STRING  lGetNickName				:= MAP(std.str.find(lStdNickName,'""',1) >0 and REGEXFIND(dbl_quote_pattern,lStdNickName) => REGEXFIND(dbl_quote_pattern,lStdNickName,2),
																								std.str.find(lStdNickName,'(',1) >0 and REGEXFIND(paren_quote_pattern,lStdNickName) => REGEXFIND(paren_quote_pattern,lStdNickName,2),			  		
																								std.str.find(lStdNickName,'"',1) >0 => REGEXFIND(quote_pattern,lStdNickName,2), 
																								std.str.find(lStdNickName,'(',1) >0 and REGEXFIND(paren_pattern,lStdNickName)=> REGEXFIND(paren_pattern,lStdNickName,2),
																										'');
			RETURN lGetNickName;
			END;
			
			
//Remove NICKNAME from NAME Field			
			STRING	fStripNickName(STRING pStringIn) := FUNCTION
			STRING	lStdNickName		:= ut.CleanSpacesAndUpper(pStringIn);
			STRING	GetNick				:= fNickName(pStringIn);
			STRING 	lRmvNick				:= MAP(std.str.find(GetNick,'(',1) > 0 => StringLib.StringFindReplace(lStdNickName,GetNick,''),
																		 std.str.find(GetNick,'"',1) >= 1 => REGEXREPLACE(GetNick,lStdNickName,''),
																		 std.str.find(lStdNickName,'"',1) > 0 => REGEXREPLACE('\"'+ GetNick +'\"',lStdNickName,''),
																					STD.Str.FindReplace(lStdNickName,'('+ GetNick +')',''));
			// STRING 	lStripNick			:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(lRmvNick));
			RETURN	lRmvNick;
		END;
			
	
	PreppedName	:=	IF(nametype = 'nick',
									 	 fNickName(name),
											 IF(nametype = 'strip_nick',
													 fStripNickName(name),
													ERROR('Invalid name_type')
													)
												);										
		
	RETURN PreppedName;
END;

