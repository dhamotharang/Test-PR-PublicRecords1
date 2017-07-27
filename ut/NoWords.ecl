export unsigned4 NoWords(string s,string1 c=' ') := BEGINC++
  #option pure
	unsigned score = 0;
	while ( lenS > 0 && s[lenS-1] == *c ) lenS--;
	for ( unsigned i = 1; i < lenS; i++ )
	{
		if ( s[i] == *c && s[i-1] != *c )
		{
			score++;
		}
	}
	return score+1;
 ENDC++;