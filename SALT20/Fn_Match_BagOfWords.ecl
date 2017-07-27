export integer4 fn_match_bagofwords(string l, string r, unsigned1 mode=0, unsigned1 score_mode=0) := BEGINC++
//int bagofwordmatch(unsigned lLen, const char *l,unsigned rLen, const char *r)
//{
	// Now deal with leading 'uber' weight
	// Input strings MUST be in form WORD nn WORD nn\n
	// Input strings MUST be in form WORD nn WORD nn\n
	// score mode 0 = many, 1=most, 2=all, 3 = any
bool abbr_eq(const char *l, unsigned lL, const char *r, unsigned rL)
{
	if ( lL == rL )
		return false;
	if ( lL < rL )
	{
		const char * t = l;
		unsigned tL = lL;
		l = r;
		lL = rL;
		r = t;
		rL = tL;
	}
	// LHS is now the longer string RHS is the abbreviatiation
	while (rL)
	{
		do
		{
			if ( !lL )
				return false;
			if ( *l == *r )
				break;
			l++;
			lL--;
		} while ( true );
		l++;
		lL--;
		r++;
		rL--;
	}
	return true;
}
#body
#option pure
	// Now deal with leading 'uber' weight
#define MAX_WORDS 32
	const char* words[MAX_WORDS];
	short word_lengths[MAX_WORDS];
	short specs[MAX_WORDS];
	bool  used[MAX_WORDS];
	short nwords = 0;
	while ( lenL && l[lenL-1] == ' ' )
		lenL--;
	while ( lenR && r[lenR-1] == ' ' )
		lenR--;
	// Process leading numbers
	unsigned lspec = 0;
	while ( lenL && *l >= '0' && *l <= '9' )
	{
		lspec = lspec * 10 + *l++ - '0';
		lenL--;
	}
	while ( lenL && *l == ' ' )
	{
		lenL--;
		l++;
	}
	unsigned rspec = 0;
	while ( lenR && *r >= '0' && *r <= '9' )
	{
		rspec = rspec * 10 + *r++ - '0';
		lenR--;
	}
	while ( lenR && *r == ' ' )
	{
		lenR--;
		r++;
	}
	unsigned spec = lspec > rspec ? lspec : rspec; // How many points are we fighting for? (proportion of longer string)
	if ( lenL < lenR )
	{
		unsigned t = lenL;
		lenL = lenR;
		lenR = t;
		char * s = l;
		l = r;
		r = s;
	}
	// Right is the shorter and so will the one assigned to the array
	unsigned total_weight = 0;
	do
	{
		int i;
		for ( i = 0; i < lenR; i++ )
			if ( r[i] == ' ' )
				break;
		words[nwords] = r;
		word_lengths[nwords] = i;
		used[nwords] = false;
		r += i;
		lenR -= i;
		if ( !lenR )
			return -1;
		r++;
		lenR--; // Skip space
		specs[nwords] = 0;
		while ( lenR && *r >= '0' && *r <= '9' )
		{
			specs[nwords] = specs[nwords] * 10 + *r - '0';
			r++;
			lenR--;
		}
		total_weight += specs[nwords];
		nwords++;
		if ( lenR )
		{ // Skip space
			*r++;
			lenR--;
		}
	} while ( nwords < MAX_WORDS && lenR );
	if ( !total_weight )
		return 0;
	// Now process the longer string against the search array
	int matching_weight = 0;
	int mismatching_weight = 0;
	short fail_specs[MAX_WORDS];
	const char *fail_words[MAX_WORDS];
	short fail_lengths[MAX_WORDS];
	short nfails = 0;
	do
	{
		int i;
		for ( i = 0; i < lenL; i++ )
			if ( l[i] == ' ' )
				break;
		const char *this_time = l;
		unsigned this_length = i;
		l += i;
		lenL -= i;
		if ( !lenL )
			return -1;
		l++;
		lenL--; // Skip space
		unsigned cost = 0;
		while ( lenL && *l >= '0' && *l <= '9' )
		{
			cost = cost * 10 + *l - '0';
			l++;
			lenL--;
		}
		if ( lenL )
		{ // Skip space
			*l++;
			lenL--;
		}
		total_weight += cost;
		// Now see if we can find a match
		bool failed = true;
		for ( int j = 0; j < nwords; j++ )
			if ( cost == specs[j] && this_length == word_lengths[j] && !used[j] && *this_time == *words[j] && !memcmp(this_time,words[j],this_length) )
			{
				matching_weight += cost;
				used[j] = true;
				failed = false;
				total_weight -= cost; // This word has been double-counted in total weight
				break;
			}
		if ( failed )
		{
			if ( mode && nfails < MAX_WORDS )
			{
				fail_specs[nfails] = cost;
				fail_lengths[nfails] = this_length;
				fail_words[nfails++] = this_time;
			}
			mismatching_weight += cost; // we have an unfound word
		}
	} while ( lenL );
	// Try initials
	for ( int i = 0; i < nfails; i++ )
	{
		for ( int j = 0; j < nwords; j++ )
			if ( !used[j] && *fail_words[i] == *words[j] && 
			(	 mode == 1 && !memcmp(fail_words[i],words[j],fail_lengths[i] < word_lengths[j] ? fail_lengths[i] : word_lengths[j])
			||   mode == 2 && abbr_eq(fail_words[i],fail_lengths[i],words[j],word_lengths[j])
			) )
			{
				mismatching_weight -= fail_specs[i]; // No longer a mis-matching word
				short cst = specs[j] < fail_specs[i] ? specs[j] : fail_specs[i];
				matching_weight += cst;
				used[j] = true;
				total_weight -= cst; // This word has been double-counted in total weight
				break;
			}
	}
	if ( score_mode == 2 )
	{ // Have to find mis-matches from stored word array too
		for ( int i = 0; i < nwords; i++ )
			if ( !used[i] )
				mismatching_weight += specs[i];
	}
	if ( !total_weight )
		return 0;
	switch ( score_mode )
	{
	case 0:
		return spec * matching_weight / total_weight;
	case 1:
		return 2 * spec * matching_weight / total_weight - spec;
	case 2:
		return (double)spec * ( matching_weight - mismatching_weight ) / total_weight;
	case 3:
		return 100*matching_weight < spec ? 100*matching_weight : spec;
	}
ENDC++;
