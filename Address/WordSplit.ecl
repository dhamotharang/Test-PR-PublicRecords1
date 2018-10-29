//rgx := '([A-Z]+)([^A-Z]+)?([A-Z-]+)?([^A-Z]+)?([A-Z-]+)?([^A-Z]+)?([A-Z-]+)?([^A-Z]+)?([A-Z-]+)?([^A-Z]+)?([A-Z-]+)?([^A-Z]+)?([A-Z-]+)?([^A-Z]+)?([A-Z-]+)?';
/*
rgx := 
'([A-Z]+)([^A-Z]+)?([A-Z]+)?([^A-Z]+)?([A-Z]+)?([^A-Z]+)?([A-Z]+)?([^A-Z]+)?([A-Z]+)?([^A-Z]+)?([A-Z]+)?([^A-Z]+)?([A-Z]+)?([^A-Z]+)?([A-Z]+)?([^A-Z]+)?';

rec := RECORD
	STRING32	word;
END;
export DATASET WordSplit(string s) := FUNCTION

	SET OF STRING32 words := 
	[
		REGEXFIND(rgx, s, 1, NOCASE),
		REGEXFIND(rgx, s, 3, NOCASE),
		REGEXFIND(rgx, s, 5, NOCASE),
		REGEXFIND(rgx, s, 7, NOCASE),
		REGEXFIND(rgx, s, 9, NOCASE),
		REGEXFIND(rgx, s, 11, NOCASE),
		REGEXFIND(rgx, s, 13, NOCASE),
		REGEXFIND(rgx, s, 15, NOCASE),
		REGEXFIND(rgx, s, 17, NOCASE)
	];
	
	return DATASET(words, rec)(word != '');
END;
*/
integer4 TokenCount(string s) := BEGINC++
//void tokenize(size32_t & __lenResult, char * & __result,
//				size32_t lenS, char *s); 
#option pure
#body

	int i = 0;
	int n = 0;
	bool endtoken = true;
	
	while (i < lenS)
	{
		if (isalnum(s[i]) || s[i] == ('_'))
		{
			endtoken = false;
		}
		else if (!endtoken)
		{
			endtoken = true;
			++n;
		}
		
		++i;
	}
	if (!endtoken)
		++n;
	
	return n;


ENDC++;

set of string32 TokenSet(string s, integer4 n) := BEGINC++
//void tokenset(bool __isAllResult, size32_t & __lenResult, void * & __result
//				size32_t lenS, char *s, int n); 
#option pure
#body

	char *temp = (char *)0;
	if (n > 0)
		temp = (char *)rtlMalloc(32 * n);
	if ((n == 0) || (temp == (char *)0))
	{
		__isAllResult = true;
		__lenResult = 0;
		__result = (char *)0;
		return;
	}
	
	int i = 0;
	int j = 0;
	int k = 0;
	int len = 0;

	bool endtoken = true;
	
	while (i < lenS)
	{
		if (isalnum(s[i]) || (s[i] == '_'))
		{
			if (len < 32)
				temp[j++] = s[i];
			++len;		// word length
			if (len > 32)	// token too long
			{
				__isAllResult = true;
				__lenResult = 0;
				__result = (char *)0;
				return;
			}

			endtoken = false;
		}
		else if (!endtoken)
		{
			endtoken = true;
			if (len <= 32)
				for (k = len; k < 32; ++k)
					temp[j++] = ' ';
			len = 0;
		}
		++i;
	}
	if (!endtoken)
	{
		for (k = len; k < 32; ++k)
			temp[j++] = ' ';
	}
	
	__isAllResult = false;
	__lenResult = 32 * n;
	__result = temp;

ENDC++;

export DATASET WordSplit(string s) := 
	 DATASET(TokenSet(s,TokenCount(s)), {string32 word});

