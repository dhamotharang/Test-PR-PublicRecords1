EXPORT fn_clean_name := module

Import Infutor_NARE, ut, Address;

	export	strippunctMisc(string pStringIn) := FUNCTION
						temp_name   := trim(StringLib.StringToUppercase(pStringIn),left,right);
						temp_name1  := StringLib.StringFindReplace(temp_name,'*','');
						temp_name2  := StringLib.StringFindReplace(temp_name1,'%','');
						temp_name3  := StringLib.StringFindReplace(temp_name2,',',' ');
						temp_name4  := StringLib.StringFindReplace(temp_name3,':',' ');
						temp_name5  := StringLib.StringFindReplace(temp_name4,';',' ');
						temp_name6  := StringLib.StringFindReplace(temp_name5,'.',' ');
						temp_name7  := StringLib.StringFindReplace(temp_name6,'+',' ');
						temp_name8  := StringLib.StringFindReplace(temp_name7,'"','');
						temp_name9  := StringLib.StringFindReplace(temp_name8,'>',' ');
						temp_name10  := StringLib.StringFindReplace(temp_name9,'{','');
						temp_name11  := StringLib.StringFindReplace(temp_name10,'}','');
						temp_name12  := StringLib.StringFindReplace(temp_name11,'@','');
						temp_name13  := StringLib.StringFindReplace(temp_name12,'?','');
						temp_name14	:= REGEXREPLACE('(^NULL|N/A |N / A )',temp_name13,'');
				return trim(temp_name14,left,right);
	END;
	
		export	strippunctMiscAddr(string pStringIn) := FUNCTION
						temp_Addr   := trim(StringLib.StringToUppercase(pStringIn),left,right);
						temp_Addr1  := StringLib.StringFindReplace(temp_Addr,'*','');
						temp_Addr2  := StringLib.StringFindReplace(temp_Addr1,'%','');
						temp_Addr3  := StringLib.StringFindReplace(temp_Addr2,'+',' ');
						temp_Addr4  := StringLib.StringFindReplace(temp_Addr3,'"','');
						temp_Addr5  := StringLib.StringFindReplace(temp_Addr4,'>',' ');
						temp_Addr6  := StringLib.StringFindReplace(temp_Addr5,'{','');
						temp_Addr7  := StringLib.StringFindReplace(temp_Addr6,'}','');
						temp_Addr8  := StringLib.StringFindReplace(temp_Addr7,'@','');
						temp_Addr9  := StringLib.StringFindReplace(temp_Addr8,'?','');
						temp_Addr10  := StringLib.StringFindReplace(temp_Addr9,'#','');
						temp_Addr11	:= REGEXREPLACE('(^NULL|N/A |N / A )',temp_Addr10,'');
				return trim(temp_Addr11,left,right);
	END;

shared quote_pattern					:= '^(.*)\\"(.*)\\"(.*)$';
shared paren_pattern 				:= '^(.*)\\((.*)\\)(.*)$';
shared dbl_quote_pattern 		:= '^(.*)\\"\\"(.*)\\"\\"(.*)$';
shared paren_quote_pattern 	:= '^([A-Za-z ][^\\(]+)[\\(][\\"]([^\\"][A-Z ][^\\"]+)[\\"][\\)]*.';

// Identify NICKNAME in the various format 
			export	fNickName(STRING pStringIn) := FUNCTION
							lStdNickName				:= ut.CleanSpacesAndUpper(pStringIn);
							lGetNickName				:= MAP(StringLib.stringfind(lStdNickName,'""',1) >0 and REGEXFIND(dbl_quote_pattern,lStdNickName) => REGEXFIND(dbl_quote_pattern,lStdNickName,2),
																								StringLib.stringfind(lStdNickName,'(',1) >0 and REGEXFIND(paren_quote_pattern,lStdNickName) => REGEXFIND(paren_quote_pattern,lStdNickName,2),			  		
																								StringLib.stringfind(lStdNickName,'"',1) >0 => REGEXFIND(quote_pattern,lStdNickName,2), 
																								StringLib.stringfind(lStdNickName,'(',1) >0 and REGEXFIND(paren_pattern,lStdNickName)=> REGEXFIND(paren_pattern,lStdNickName,2),
																								'');
					RETURN lGetNickName;
			END;

//Remove NICKNAME from NAME Field			
	export	fStripNickName(STRING pStringIn) := FUNCTION
						lStdNickName	:= ut.CleanSpacesAndUpper(pStringIn);
						GetNick				:= fNickName(pStringIn);
						lRmvNick			:= MAP(StringLib.StringFind(GetNick,'(',1) > 0 => StringLib.StringFindReplace(lStdNickName,GetNick,''),
																			StringLib.StringFind(GetNick,'"',1) >= 1 => REGEXREPLACE(GetNick,lStdNickName,''),
																			StringLib.StringFind(lStdNickName,'"',1) > 0 => REGEXREPLACE('\"'+ GetNick +'\"',lStdNickName,''),
																			StringLib.StringFindReplace(lStdNickName,'('+ GetNick +')',''));
				 STRING 	lStripNick		:= StringLib.StringCleanSpaces(REGEXREPLACE('[^a-zA-Z]',lRmvNick,' '));
			RETURN	lStripNick;
		END;
END;	