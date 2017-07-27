export unsigned4 Fn_Hyphen_Match (string l, string r,unsigned1 minlen = 1) := BEGINC++
//int fn_hyphen_match(unsigned lenL, const char *l,unsigned lenR, const char *r)
#body
#option pure
	// 10 is as bad as it gets, complete no-match
	while ( lenL && l[lenL-1] == ' ' )
		lenL--;
	while ( lenR && r[lenR-1] == ' ' )
		lenR--;
	if ( lenL < minlen || lenR < minlen )
		return 10;
	if (*l == *r)
	{
		// Can try to match leading part
		unsigned pmatch = 1;
		unsigned ldelta = 0;
		unsigned rdelta = 0;
		do 
		{
			if ( pmatch+ldelta >= lenL )
			{
				if ( pmatch+rdelta >= lenR )
					return 0;
				if ( r[pmatch+rdelta] == ' ' || r[pmatch+rdelta] == '-' )
					return 1;
				return 2;
			}
			if ( pmatch+rdelta >= lenR )
				return l[pmatch+ldelta] == ' ' || l[pmatch+ldelta] == '-' ? 1 : 2;
			if ( l[pmatch+ldelta] == ' ' || l[pmatch+ldelta] == '-' )
				ldelta++;
			else if ( r[pmatch+rdelta] == ' ' || r[pmatch+rdelta] == '-' )
				rdelta++;
			else
			{
				if ( l[pmatch+ldelta] != r[pmatch+rdelta] )
					break;
				pmatch++;
			}
		} while (true);
	}
	if (l[lenL-1] == r[lenR-1])
	{
		// Can try to match trailing part
		unsigned pmatch = 2;
		unsigned ldelta = 0;
		unsigned rdelta = 0;
		do 
		{
			if ( pmatch+ldelta > lenL )
			{
				if ( pmatch+rdelta > lenR )
					return 0;
				if ( r[lenR-pmatch-rdelta] == ' ' || r[lenR-pmatch-rdelta] == '-' )
					return 1;
				return 2;
			}
			if ( pmatch+rdelta > lenR )
				return l[lenL-pmatch-ldelta] == ' ' || l[lenL-pmatch-ldelta] == '-' ? 1 : 2;
			if ( l[lenL-pmatch-ldelta] == ' ' || l[lenL-pmatch-ldelta] == '-' )
				ldelta++;
			else if ( r[lenR-pmatch-rdelta] == ' ' || r[lenR-pmatch-rdelta] == '-' )
				rdelta++;
			else
			{
				if ( l[lenL-pmatch-ldelta] != r[lenR-pmatch-rdelta] )
					break;
				pmatch++;
			}
		} while (true);
	}
	return 10;
ENDC++;
