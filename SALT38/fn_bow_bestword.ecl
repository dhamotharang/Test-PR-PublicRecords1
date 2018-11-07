EXPORT STRING fn_bow_bestword(CONST STRING l) := BEGINC++
#option pure
	unsigned best_value = 0;
	unsigned bpos = 0;
	unsigned best_len = 0;
	while (lenL && l[lenL-1] == ' ')
		lenL--; // Remove trailing space
	unsigned ipos = 0;
	while ( ipos < lenL && l[ipos] >= '0' && l[ipos] <= '9' )
		ipos++;
	do
	{
		while ( l[ipos] == ' ' ) // skip spaces
			ipos++;
		unsigned cpos = ipos;
		while ( ipos < lenL && l[ipos] != ' ')
			ipos++;
		unsigned epos = ipos > cpos ? ipos-1 : cpos;
		unsigned tot = 0;
		while ( l[ipos] == ' ' )
			ipos++;
		while ( ipos < lenL && l[ipos] >= '0' && l[ipos] <= '9' )
			tot = tot*10 + l[ipos++] - '0';
		if ( tot > best_value )
		{
			best_value = tot;
			bpos = cpos;
			best_len = 1+epos-cpos;
		}
	} while ( ipos < lenL );
	__lenResult = best_len;
	__result = (char *)rtlMalloc(__lenResult);
	memcpy(__result,l+bpos,best_len);
ENDC++;
