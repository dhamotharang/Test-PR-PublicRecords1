StrCmpFnType := ENUM(UNSIGNED1, ExactMatch=0, FuzzyMatch, Phonetic_Match);
export integer4 fn_match_bagofwords_fuzzy(const string l, const string r, unsigned1 mode=0, unsigned1 score_mode=0,StrCmpFnType fn=1, UNSIGNED1 fn_arg1=1,UNSIGNED1 fn_arg2=0) := BEGINC++
//int bagofwordmatch(unsigned lLen, const char *l,unsigned rLen, const char *r)
//{
	// Now deal with leading 'uber' weight
	// Input strings MUST be in form WORD nn WORD nn\n
	// Input strings MUST be in form WORD nn WORD nn\n
	// score mode 0 = many, 1=most, 2=all, 3 = any
	
int stringToNumber(unsigned &lenS, const char * &s)
{
    int number = 0;
    while ( lenS && *s >= '0' && *s <= '9' )
    {
        number = number * 10 + *s++ - '0';
        lenS--;
    }
    return number;
}	
	
unsigned EditDistance(unsigned lenL, const char * l, unsigned lenR, const char * r, unsigned radius) 
{
  unsigned d = radius;
	while ( lenL && l[lenL-1]==' ' ) lenL--;
	while ( lenR && r[lenR-1]==' ' ) lenR--; // Trim incoming strings
	if ( lenL > lenR + d * 2 || lenR > lenL + d * 2 )
		//return false;
        return radius+1;
		// No fuzzy on very short strings
	if ( lenL <= lenR && lenL <= d-(lenR-lenL)/2 )
		d = (1+lenR-lenL)/2 + (lenL?lenL-1:0);
	if ( lenL > lenR && lenR <= d-(lenL-lenR)/2 )
		d = (1+lenL-lenR)/2 + (lenR?lenR-1:0);
	// while ( lenL && lenR && *l == *r )
	do
	{
			if ( !lenL )
					//return lenR <= d * 2;
            		return (lenR <= d * 2)?radius-d:radius+1;
			if ( !lenR )
					//return lenL <= d * 2;
                    return (lenL <= d * 2)?radius-d:radius+1;
			if ( *l != *r )
			{
					if ( !d )
					    //return false;
                        return radius+1;
					d--;
			    if ( lenR > 1 && lenL > 1 && *l == r[1] && *r == l[1] && !( lenR > 2 && lenR >= lenL && l[1] == r[2] ) && !( lenL > 2 && lenL >= lenR && r[1] == l[2] ) )
					{	// The switch case - counts as one edit
						// But if we can delete rather than switch and STILL have two matches in a row - go for it ...
						lenR--;
						lenL--;
						l++;
						r++;
					}
					else if ( lenR > 1 && *l == r[1] && ( lenR > lenL || lenR == lenL && l[1] != r[1] ) )
					{ // Character missing from LHS
							lenR--;
							r++;
					}
					else if ( lenL > 1 && *r == l[1] && ( lenL > lenR || lenR == lenL && l[1] != r[1] ) )
					{ // Character missing from RHS
							lenL--;
							l++;
					}
			}
			lenL--;
			lenR--;
			l++;
			r++;
	}		while ( 1 );

}

bool editDistanceWithinRadius(unsigned lenL, const char * l, unsigned lenR, const char * r, unsigned radius, unsigned &maxDist)
{
    if (maxDist==0) return false;
    unsigned eDist = EditDistance(lenL, l, lenR, r, radius);
    // eDist>radius representsa mismatch which should not reduce the maxDist 
    maxDist = eDist<=radius ? (maxDist>eDist ? maxDist-eDist:0):maxDist;
    return eDist <= radius;
}
	
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
	if (rL == 1) return false;
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
//#option pure
	// Now deal with leading 'uber' weight
#define MAX_WORDS 32
    unsigned maxEdits = fn_arg2?fn_arg2:lenL+lenR; // ignore maxEdits if set to 0
    const char* words[MAX_WORDS];
    size32_t word_lengths[MAX_WORDS];
    int specs[MAX_WORDS];
    bool  used[MAX_WORDS];
    unsigned nwords = 0;
    char *cleanedL = (char *) alloca(lenL);
    char *cleanedR = (char *) alloca(lenR);
    if (mode == 3)
    {
        // eliminate hyphens
        unsigned pos = 0;
        for (unsigned i = 0; i < lenL; i++)
        {
            if (l[i]!='-')
            {
                cleanedL[pos++] = l[i];
            }
        }
        lenL = pos;
        l = cleanedL;
        pos = 0;
        for (unsigned i = 0; i < lenR; i++)
        {
            if (r[i]!='-')
            {
                cleanedR[pos++] = r[i];
            }
        }
        lenR = pos;
        r = cleanedR;
    }

    while ( lenL && l[lenL-1] == ' ' )
        lenL--;
    while ( lenR && r[lenR-1] == ' ' )
        lenR--;
    // Process leading numbers
    int lspec = stringToNumber(lenL, l);

    while ( lenL && *l == ' ' )
    {
        lenL--;
        l++;
    }

    int rspec = stringToNumber(lenR, r);
    while ( lenR && *r == ' ' )
    {
        lenR--;
        r++;
    }
    int spec = lspec > rspec ? lspec : rspec; // How many points are we fighting for? (proportion of longer string)
    if ( lenL < lenR )
    {
        unsigned t = lenL;
        lenL = lenR;
        lenR = t;
        const char * s = l;
        l = r;
        r = s;
    }
    // Right is the shorter and so will the one assigned to the array
    unsigned total_weight = 0;
    do
    {
        unsigned i;
        for ( i = 0; i < lenR; i++ )
            if ( r[i] == ' ' )
                break;
        // if this word is empty and total_weight is still 0 - return 0
        if (!i) break;		
        words[nwords] = r;
        word_lengths[nwords] = i;
        used[nwords] = false;
        r += i;
        lenR -= i;
        if ( !lenR )  // requires a following number
            return -1;
        r++;
        lenR--; // Skip an expected space
        while ( lenR && *r == ' ' ) // and all adjacent spaces
        {
            lenR--;
            r++;
        }

        specs[nwords] = stringToNumber(lenR, r);
        total_weight += specs[nwords];
        nwords++;
        if ( lenR )
        { // Skip space
            r++;
            lenR--;
        }
        while ( lenR && *r == ' ' ) // and all adjacent spaces
        {
            lenR--;
            r++;
        }
    } while ( nwords < MAX_WORDS && lenR );
    if ( !total_weight )
        return 0;
    // Now process the longer string against the search array
    int matching_weight = 0;
    int mismatching_weight = 0;
    short fail_specs[MAX_WORDS];
    const char *fail_words[MAX_WORDS];
    size32_t fail_lengths[MAX_WORDS];
    unsigned nfails = 0;
    do
    {
        unsigned i;
        for ( i = 0; i < lenL; i++ )
            if ( l[i] == ' ' )
                break;
        const char *this_time = l;
        size32_t this_length = i;
        l += i;
        lenL -= i;
        if ( !lenL )
            return -1;
        l++;
        lenL--; // Skip space
        while ( lenL && *l == ' ' ) // and all adjacent spaces
        {
            lenL--;
            l++;
        }
 
        int cost = stringToNumber(lenL,l);
        while ( lenL && *l == ' ' )
        { // Skip space
            l++;
            lenL--;
        }
        total_weight += cost;
        // Now see if we can find a match
        bool failed = true;
        for ( unsigned j = 0; j < nwords; j++ )
        {
            if ( !used[j] )
            {
                unsigned minED = (this_length < word_lengths[j])? word_lengths[j] - this_length: this_length - word_lengths[j];
                if (minED <= fn_arg1 && editDistanceWithinRadius(this_length, this_time,word_lengths[j], words[j],fn_arg1, maxEdits))
                      failed = false;
                if (!failed)
                {
                   unsigned cst = specs[j] < cost ? specs[j] : cost;
                    matching_weight += cst;
                    used[j] = true;
                    total_weight -= cst; // This word has been double-counted in total weight
                    break;               }
							 }
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
    for ( unsigned i = 0; i < nfails; i++ )
    {
        for ( unsigned j = 0; j < nwords; j++ )
        {
            if ( !used[j] && *fail_words[i] == *words[j]) 
            {
                unsigned minLength = fail_lengths[i] < word_lengths[j] ? fail_lengths[i] : word_lengths[j];
                bool  breakOut = false;
                bool failed = true;
                switch (mode)
                {
                case 3: // hyphen mode
                    if (editDistanceWithinRadius(minLength, fail_words[i],minLength, words[j],fn_arg1, maxEdits))
                        failed = false;
                    if (!failed)
                    {
                        const char *l, *r;
                        size32_t lenL, lenR;
                        failed = true;
                        if (fail_lengths[i] < word_lengths[j]) 
                        {
                            if (nfails == i+1)
                                break;
                            lenL = word_lengths[j]-fail_lengths[i];
                            l = words[j]+fail_lengths[i];
                            lenR = fail_lengths[i+1];
                            r = fail_words[i+1];
                        }
                        else
                        {
                            if (nwords == j+1)
                                break;
                            lenL = fail_lengths[i]-word_lengths[j];
                            l = fail_words[i]+word_lengths[j];
                            lenR = word_lengths[j+1];
                            r = words[j+1];
                        }
                        if (editDistanceWithinRadius(lenL, l, lenR, r, fn_arg1, maxEdits))
                                failed = false;
                        if (!failed)
                        {
                            int fail_spec = fail_lengths[i] < word_lengths[j] ? fail_specs[i] + fail_specs[i+1] : fail_specs[i];
                            int spec = fail_lengths[i] > word_lengths[j] ? specs[j] + specs[j+1] : specs[j];
                            if (fail_lengths[i] > word_lengths[j])
                                used[j+1] = true;
                            mismatching_weight -= fail_spec; // No longer a mis-matching word
                            unsigned cst = spec < fail_spec ? spec : fail_spec;
                            matching_weight += cst;
                            used[j] = true;
                            total_weight -= cst; // This word has been double-counted in total weight
                            breakOut = true;
                        }
                    }
                    break;
                case 1: // initial mode
                    if (*fail_words[i] == *words[j] && !memcmp(fail_words[i], words[j], minLength) )
                        failed = false;

                    if (!failed)
                    {
                        mismatching_weight -= fail_specs[i]; // No longer a mis-matching word
                        unsigned cst = specs[j] < fail_specs[i] ? specs[j] : fail_specs[i];
                        matching_weight += cst;
                        used[j] = true;
                        total_weight -= cst; // This word has been double-counted in total weight
                        breakOut = true;
                    }
                    break;
                case 2: // abbreviation mode
                    if (abbr_eq(fail_words[i],fail_lengths[i],words[j],word_lengths[j]))
                    {
                        mismatching_weight -= fail_specs[i]; // No longer a mis-matching word
                        unsigned cst = specs[j] < fail_specs[i] ? specs[j] : fail_specs[i];
                        matching_weight += cst;
                        used[j] = true;
                        total_weight -= cst; // This word has been double-counted in total weight
                        breakOut = true;
                    }
                    break;
                default:
                    break;
                }
                if (breakOut) 
                    break;
            }
        }
    }
		//return matching_weight;
    if ( score_mode == 2 )
    { // Have to find mis-matches from stored word array too
        for ( unsigned i = 0; i < nwords; i++ )
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
        return (int)((double)spec * ( matching_weight - mismatching_weight ) / total_weight);
    case 3:
        return 100*matching_weight < spec ? 100*matching_weight : spec;
    default:
        return 0;

    }
ENDC++;
