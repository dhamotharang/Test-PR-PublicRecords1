//Extract city name from the input string `address`. If nothing found, return null
//The input string should contain street #, name, city name where city name is the l
IMPORT Address, lib_stringlib, ut;

PATTERN_LAST_THREE_WORDS := '( [A-Z\\.\\-]+ [[A-Z\\.\\-]+ [A-Z\\.\\-]+$)';
PATTERN_LAST_TWO_WORDS := '( [A-Z\\.\\-]+ [A-Z\\.\\-]+)$';
PATTERN_LAST_ONE_WORD := ' ([A-Z\\.\\-]+)$';
EXPORT STRING fGetCityName(string address) := FUNCTION

	//New cities that are not defined in ut.Set_CityNames_1 - ct.Set_CityNames_7
	New_Cities := ['CENTENNIAL PARK', 'HADDON TOWNSHIP', 'FARMINGTON HILL', 'HELICONG'];     

	address_cap 			:= TRIM(StringLib.StringToUpperCase(address), LEFT, RIGHT);
	//repace st by saint and mt by mount
	address_clean1 		:= StringLib.StringFindReplace(address_cap,' ST. ',' SAINT ');
	address_clean2 		:= StringLib.StringFindReplace(address_clean1,' ST ',' SAINT ');
	address_clean3 		:= StringLib.StringFindReplace(address_clean2,' MT ',' MOUNT ');
	address_clean4 		:= StringLib.StringFindReplace(address_clean3,' MT. ',' MOUNT ');
	address_clean5		:= StringLib.StringFindReplace(address_clean4,' FT ',' FORT ');
	address_clean 		:= StringLib.StringFindReplace(address_clean5,' FT. ',' FORT ');
	last_3_words 			:= TRIM(REGEXFIND(PATTERN_LAST_THREE_WORDS,address_clean,1),LEFT,RIGHT);
	last_2_words 			:= TRIM(REGEXFIND(PATTERN_LAST_TWO_WORDS,address_clean,1),LEFT,RIGHT);
	last_word 		 		:= TRIM(REGEXFIND(PATTERN_LAST_ONE_WORD,address_clean,1),LEFT,RIGHT);
 	city_name	 		 		:= MAP(last_3_words <> ' ' AND (ut.IsCityName(last_3_words) OR last_3_words in New_Cities)
															=> TRIM(REGEXFIND(PATTERN_LAST_THREE_WORDS,address_cap,1),LEFT,RIGHT),
													 last_2_words <> ' ' AND (ut.IsCityName(last_2_words) OR last_2_words in New_Cities)
															=> TRIM(REGEXFIND(PATTERN_LAST_TWO_WORDS,address_cap,1),LEFT,RIGHT),	
													 last_word <> ' ' AND (ut.IsCityName(last_word) OR last_word in New_Cities)
															=> TRIM(REGEXFIND(PATTERN_LAST_ONE_WORD,address_cap,1),LEFT,RIGHT),	
													 '');
  RETURN city_name;
   	
END;
