export TokenManagement := MODULE

export string32 TerminateToken(string32 s) := BEGINC++
#option pure
#body
	memcpy(__result, s, 31);
	__result[31] = 0;
ENDC++ : DEPRECATED('Do not use');

export integer4 TokenCount(string s) := BEGINC++
//void tokenize(size32_t & __lenResult, char * & __result,
//				size32_t lenS, char *s); 
#option pure
#body

	int i = 0;
	int n = 0;
	bool endtoken = true;
	
	while (i < lenS)
	{
		if (isalnum(s[i]) || s[i] == '_' || s[i] == '\'')
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


ENDC++ : DEPRECATED('Do not use');

export set of string32 TokenSet(string s, integer4 n) := BEGINC++
//void tokenset(bool __isAllResult, size32_t & __lenResult, void * & __result
//				size32_t lenS, char *s, int n); 
#option pure
#body

	char *temp = (char *)0;
	if (n > 0)
		temp = (char *)rtlMalloc(32 * n);
	if ((n == 0) || (temp == (char *)0))
	{
		__isAllResult = false;
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
		if (isalnum(s[i]) || s[i] == '_' || s[i] == '\'')
		{
			if (len < 32)
			{
				temp[j++] = s[i];
			  ++len;		// word length
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

ENDC++ : DEPRECATED('Use Address.WordSplit');
/*
export SET OF STRING32 SortSet(SET OF STRING32 list) := BEGINC++
#option pure
//Function: void qsort (void *array, size_t count, size_t size, comparison_fn_t compare)
	char *array = (char *)rtlMalloc(lenList);
	memcpy(array, list, lenList);
	qsort(array, lenList/32, 32, (int (*)(const void*, const void*))strcmp);

	__isAllResult = false;
	__lenResult = lenList;
	__result = array;

ENDC++;
*/
export SET OF STRING32 SortAndTerminateSet(SET OF STRING32 list) := BEGINC++
#option pure
//Function: void qsort (void *array, size_t count, size_t size, comparison_fn_t compare)
	char *array = (char *)rtlMalloc(lenList);
	int n = lenList/32;
	memcpy(array, list, lenList);
	for (int i = 0; i < n; ++i)
	{
		//array[32*i + 31] = 0;
		char *s = array + 32*i + 31;
		*s-- =  0;
		int j = 31;
		while ((*s == ' ') && (j-- > 0))
			*s-- = 0;
	}
	qsort(array, n, 32, (int (*)(const void*, const void*))strcmp);

	__isAllResult = false;
	__lenResult = lenList;
	__result = array;

ENDC++ : DEPRECATED('Do not use');


export boolean FindToken(SET OF STRING32 list, string32 name) := BEGINC++
#option pure
	int entries = lenList/32;
	char	temp[32];
	memcpy(temp, name, 31);
	//temp[31] = 0;
	char *t = temp + 31;
	*t-- =  0;
	int j = 31;
	while ((*t == ' ') && (j-- > 0))
		*t-- = 0;

	char *s = (char *)bsearch(temp, list, entries, 32, 
				(int (*)(const void*, const void*))strcmp);
	return (s != NULL);

ENDC++ : DEPRECATED('Do not use');
/*
 boolean FindTokenX(SET OF STRING32 list, varstring name) := BEGINC++
#option pure
	int entries = lenList/32;

	char *s = (char *)bsearch(name, list, entries, 32, 
				(int (*)(const void*, const void*))strcmp);
	return (s != NULL);

ENDC++;
*/
export boolean AnyTokenInSet(SET OF STRING32 list, SET OF STRING32 tokens) := BEGINC++
#option pure
	int entries = lenList/32;
	int n = lenTokens/32;	// number of tokens to check
	char *t = (char *)tokens;
	
	for (int i = 0; i < n; ++i)
	{
		char	temp[32];
		memcpy(temp, t + 32*i, 31);
		temp[31] = 0;
		char *u = temp + 31;
		*u-- =  0;
		int j = 31;
		while ((*u == ' ') && (j-- > 0))
			*u-- = 0;
		char *s = (char *)bsearch(temp, list, entries, 32, 
				(int (*)(const void*, const void*))strcmp);
		if (s != NULL)
			return true;
	}
	return false;
ENDC++ : DEPRECATED('Do not use');
/*
export integer4 CountTokensInSet(SET OF STRING32 list, SET OF STRING32 tokens) := BEGINC++
#option pure
	int entries = lenList/32;
	int n = lenTokens/32;	// number of tokens to check
	char *t = (char *)tokens;
	int count = 0;
	
	for (int i = 0; i < n; ++i)
	{
		char	temp[32];
		memcpy(temp, t + 32*i, 31);
		temp[31] = 0;
		char *u = temp + 31;
		*u-- =  0;
		int j = 31;
		while ((*u == ' ') && (j-- > 0))
			*u-- = 0;
		char *s = (char *)bsearch(temp, list, entries, 32, 
				(int (*)(const void*, const void*))strcmp);
		if (s != NULL)
			++count;
	}
	return count;
ENDC++;
*/
export boolean AnyDigraphInSet(SET OF STRING32 list, SET OF STRING32 tokens) := BEGINC++
#option pure
	int entries = lenList/32;
	int n = lenTokens/32;	// number of tokens to check
	char *t = (char *)tokens;
	if (n < 2)
		return false;
	
	for (int i = 0; i < n - 1; ++i)
	{
		char	temp[66];
		//memset(temp, ' ', 65);
		char *	ptr = temp;
		char *u = t + 32*i;
		int j = 0;
		while ((*u != ' ') && (j++ < 32))
			*ptr++ = *u++;
		*ptr++ = ' ';
		u = t + 32*(i+1);
		//memcpy(ptr, u , 32);
		j = 0;
		while ((*u != ' ') && (j++ < 32))
			*ptr++ = *u++;
		*ptr = 0;
		//temp[31] = 0;
		char *s = (char *)bsearch(temp, list, entries, 32, 
				(int (*)(const void*, const void*))strcmp);
		if (s != NULL)
			return true;
	}
	return false;
ENDC++ : DEPRECATED('Do not use');
/*
export SET OF STRING32 GetDigraphs(SET OF STRING32 list) := BEGINC++
#option pure
	int entries = lenList/32;
	char	temp[32];
	
	//for 
	memcpy(temp, name, 31);
	temp[31] = 0;

	return (s != NULL);

ENDC++;
*/

END;