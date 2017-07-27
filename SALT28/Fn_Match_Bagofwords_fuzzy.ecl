EXPORT INTEGER4 fn_match_bagofwords_fuzzy(CONST STRING l, CONST STRING r, UNSIGNED mode=0, UNSIGNED1 score_mode=0) := BEGINC++
class wb
{
public: // Need to be fast - privacy a luxury
#define MAX_WORDS 32
    const char* words[MAX_WORDS];
    size32_t word_lengths[MAX_WORDS];
    int specs[MAX_WORDS];
    bool  used[MAX_WORDS];
    bool error;
    unsigned nwords;
    unsigned total_weight;
    unsigned spec; // The weight declared for the whole string
  wb(unsigned len,const char *s);
  inline bool equals(unsigned l, wb &r,unsigned &rl,unsigned &total, int &matching)
  {
      // 1. Try to match in linear fashion
      if ( !r.used[rl] && word_lengths[l] == r.word_lengths[rl] && !memcmp(words[l],r.words[rl],word_lengths[l]) )
      {
          used[l] = true;
          r.used[rl] = true;
          // Nice easy match case - increment both sides
          total -= r.specs[rl];
          matching += specs[l];
          //if ( rl < r.nwords )
            //  rl++;
          return true;
      }
      return false;
  }
  inline bool hyphen(unsigned l, wb &r,unsigned &rl,unsigned &total, int &matching, bool hyphen2, unsigned hyphen_min_distance) // Local is hyphenated form of rhs
  {
    if ( !used[l] && !r.used[rl] && // Target word not used
       rl < r.nwords-1 && // Extra word available
       !r.used[rl+1] && // Which is not used
       word_lengths[l] >= r.word_lengths[rl]+r.word_lengths[rl+1] && // longer form is long enough
			 hyphen_min_distance <= r.word_lengths[rl] && // minimum constraint is satisfied
       !memcmp(words[l],r.words[rl],r.word_lengths[rl]) && // leading part matches
       !memcmp(words[l]+word_lengths[l]-r.word_lengths[rl+1],r.words[rl+1],r.word_lengths[rl+1]) && // trailing matches
       ( word_lengths[l] == r.word_lengths[rl]+r.word_lengths[rl+1] || // Contrived expression will eventually allow us to distinguish hyphen1 & 2
         ( words[l][r.word_lengths[rl]] == '-' && word_lengths[l] == r.word_lengths[rl]+r.word_lengths[rl+1]+1 ) || //hyphen1
				 hyphen2 )
       )
      {
        used[l] = true;
        r.used[rl] = true;
        r.used[rl+1] = true;
        matching += specs[l] > r.specs[rl]+r.specs[rl+1] ? r.specs[rl]+r.specs[rl+1]:specs[l];
        total -= specs[l] > r.specs[rl]+r.specs[rl+1] ? specs[l] : r.specs[rl]+r.specs[rl+1];
        //if ( rl < r.nwords-1 )
          //  rl+=2;
        return true;
      }
      return false;
  }
  inline bool initial_equals(unsigned l, wb &r,unsigned &rl,unsigned &total, int &matching)
  {
      // LHS is the initial form of the RHS
      if ( !used[l] && !r.used[rl] &&
          word_lengths[l] < r.word_lengths[rl] && !memcmp(words[l],r.words[rl],word_lengths[l]) )
      {
          used[l] = true;
          r.used[rl] = true;
          // Only credit smaller side but remove penalty of larger side
          total -= r.specs[rl];
          matching += specs[l];
          //if ( rl < r.nwords )
            //  rl++;
          return true;
    }
    return false;
  }
  inline bool abbr_equals(unsigned l, wb &r,unsigned &rl,unsigned &total, int &matching,unsigned abbrType)
  {
      // RHS is the abbreviated form of the LHS
      if (isAbbreviation(word_lengths[l],words[l],r.word_lengths[rl],r.words[rl],abbrType))
      {
          used[l] = true;
          r.used[rl] = true;
          // Only credit smaller side but remove penalty of larger side
          total -= specs[l] > r.specs[rl] ?  specs[l] : r.specs[rl];
          matching += specs[l] > r.specs[rl] ? r.specs[rl] : specs[l];
          //if ( rl < r.nwords )
            //  rl++;
          return true;
    }
    return false;
  }
  inline bool withinEditRadiusAndMaxDistance(unsigned l, wb &r,unsigned &rl,unsigned &total, int &matching, unsigned radius, unsigned &maxDist)
  {
      if (maxDist==0) return false;
      unsigned eDist = withinEditRadius(word_lengths[l], words[l], r.word_lengths[rl], r.words[rl], radius);
      // eDist>radius represents a mismatch which should not reduce the maxDist
      maxDist = eDist<=radius ? (maxDist>eDist ? maxDist-eDist:0):maxDist;
      if ( eDist <= radius )
      {
          used[l] = true;
          r.used[rl] = true;
          // Only credit smaller side but remove penalty of larger side
          total -= specs[l] > r.specs[rl] ?  specs[l] : r.specs[rl];
          matching += specs[l] > r.specs[rl] ? r.specs[rl] : specs[l];
          //if ( rl < r.nwords )
            //  rl++;
          return true;
      }
      return false;
  }
  inline unsigned unmatched()
  {
      unsigned tot = 0;
      for ( unsigned i = 0; i < nwords; i++ )
          if ( !used[i] )
              tot += specs[i];
      return tot;
  }
private:
  inline int stringToNumber(unsigned &lenS, const char * &s)
  {
      int number = 0;
      while ( lenS && *s >= '0' && *s <= '9' )
      {
          number = number * 10 + *s++ - '0';
          lenS--;
      }
      return number;
  }
  inline void spaces(unsigned &lenS,const char * &s)
  {
      while ( lenS && *s == ' ')
      {
          lenS--;
          s++;
      }
  }
  inline unsigned toSpace(unsigned lenS,const char *s) // non-eating skip to next 'space;
  {
    unsigned res = 0;
    while ( res < lenS && s[res] != ' ' )
      res++;
    return res;
  }
  inline bool isAbbreviation(unsigned lenL, const char *l, unsigned lenR, const char *r, unsigned abbr_type)
  {
      if ( lenL <= lenR )
          return false;
      // LHS is now the longer string RHS is the abbreviation
      if (lenR == 1) // one character abbreviation does not count
          return false;
			// ABBR(FIRST)		
			if (abbr_type == 1 && *l!=*r)		
					return false;
					
      while (lenR)
      {
          do
          {
              if ( !lenL )
                  return false;
              if ( *l == *r )
                  break;
              l++;
              lenL--;
          } while ( true );
          l++;
          lenL--;
          r++;
          lenR--;
      }
      return true;
  }
  inline unsigned withinEditRadius(unsigned lenL, const char * l, unsigned lenR, const char * r, unsigned radius)
  {
    unsigned d = radius;
    //while ( lenL && l[lenL-1]==' ' ) lenL--;
    //while ( lenR && r[lenR-1]==' ' ) lenR--; // Trim incoming strings
    if ( lenL > lenR + d * 2 || lenR > lenL + d * 2 )
        return radius+1;
    // No fuzzy on very short strings
    if ( lenL <= lenR && lenL <= d-(lenR-lenL)/2 )
        d = (1+lenR-lenL)/2 + (lenL?lenL-1:0);
    if ( lenL > lenR && lenR <= d-(lenL-lenR)/2 )
        d = (1+lenL-lenR)/2 + (lenR?lenR-1:0);
				
		bool noFuzzy = (d != radius);		
    // while ( lenL && lenR && *l == *r )
    do
    {
        if ( !lenL )
            return (lenR <= d * 2)?(noFuzzy?0:radius-d):radius+1;
        if ( !lenR )
            return (lenL <= d * 2)?(noFuzzy?0:radius-d):radius+1;
        if ( *l != *r )
        {
            if ( !d )
                return radius+1;
            d--;
            if ( lenR > 1 && lenL > 1 && *l == r[1] && *r == l[1] && !( lenR > 2 && lenR >= lenL && l[1] == r[2] ) && !( lenL > 2 && lenL >= lenR && r[1] == l[2] ) )
            { // The switch case - counts as one edit
              // But if we can delete rather than switch and STILL have two matches in a row - go for it ...
                lenR--;
                lenL--;
                l++;
                r++;
            }
            else if ( lenR > 1 && *l == r[1] && ( lenR > lenL || (lenR == lenL && l[1] != r[1]) ) )
            { // Character missing from LHS
                lenR--;
                r++;
            }
            else if ( lenL > 1 && *r == l[1] && ( lenL > lenR || (lenR == lenL && l[1] != r[1]) ) )
            { // Character missing from RHS
                lenL--;
                l++;
            }
            else if ( d>0 && lenR > 1 && *l == r[2] && ( lenR > lenL+1 || (lenR == lenL && l[1] != r[1] && l[2] != r[2])) )
            { // 2 consecutive characters missing from LHS
                lenR--;
                r++;
            }
            else if ( d>0 && lenL > 1 && *r == l[2] && ( lenL > lenR+1 || (lenR == lenL && l[1] != r[1] && l[2] != r[2])) )
            { // 2 consecutive characters missing from RHS
                lenL--;
                l++;
            }
        }
        lenL--;
        lenR--;
        l++;
        r++;
    }  while ( 1 );
    return -1; // Error drop-out condition to make compiler happy
  }
};
wb::wb(unsigned len,const char *s)
{
  // Input strings MUST be in form nnnn WORD nn WORD nn
  // Avoiding full initialization, trying to be FAST
  nwords = 0;
  error = true;
  total_weight = 0;
  while ( len && s[len-1]==' ' )
    len--;
  spaces(len,s);
  spec = stringToNumber(len,s);
  spaces(len,s);
  while ( nwords < MAX_WORDS && len )
  {
      unsigned word_len = toSpace(len,s);
      if ( !word_len )
          break;
      words[nwords] = s;
      word_lengths[nwords] = word_len;
      used[nwords] = false;
      s += word_len;
      len-= word_len;
      spaces(len,s);
      if ( !len )
          return;
      specs[nwords] = stringToNumber(len,s);
      total_weight += specs[nwords];
      nwords++;
      spaces(len,s);
  };
  error = false;
}
#body
{
    wb L(lenL,l);
    wb R(lenR,r);
    if ( L.error || R.error )
        return -1; // Parsing error
    unsigned total_weight = L.total_weight+R.total_weight;
    if ( !total_weight )
        return 0; // If either side has no information then return 0
    int matching_weight = 0;
    // MORE - below was previous behavior; but feels wrong
    int spec = L.spec > R.spec ? R.spec : L.spec; // How many points are we fighting for? (proportion of longer string)
    // Short & Long
    wb &SH = L.nwords < R.nwords || lenL < lenR ? L : R;
    wb &LO = L.nwords < R.nwords || lenL < lenR ? R : L;
    // Now process the shorter string against the longer
    // Heuristic strategy
    //unsigned lo_finger = 0;
    unsigned hyphen_min_distance = ((mode >> 23) & 0xFF) ? ((mode >> 23) & 0xFF) : 1;
    unsigned edit_max_distance = ((mode >> 15) & 0xFF) ? ((mode >> 15) & 0xFF) : 0;
    unsigned edit_distance = (mode & 0x30)>>4;
		unsigned abbr_type = (mode & 0x300)>>8;
    bool phonetic = (mode & 0x40) != 0;
    bool hyphen2 = (mode & 8) != 0;
    bool hyphen1 = (mode & 4) != 0;
    bool abbr = (mode & 2) != 0;
    bool initial = ((mode & 1) != 0) || hyphen2;
    unsigned maxEdits = edit_max_distance?edit_max_distance:lenL+lenR; // ignore maxEdits if set to 0
		for ( unsigned lo_finger = 0; lo_finger < LO.nwords; lo_finger++ )
    for ( unsigned sh_finger = 0; sh_finger < SH.nwords && lo_finger < LO.nwords; sh_finger++ )
    {
      if ( !SH.used[sh_finger] && !LO.used[lo_finger])
      {
        if ( SH.equals(sh_finger,LO,lo_finger,total_weight,matching_weight) )
          continue;
        if ( hyphen1 || hyphen2 ) 
        {
          // 2. See if we can consume TWO tokens on one side
           if ( SH.hyphen(sh_finger,LO,lo_finger,total_weight,matching_weight, hyphen2, hyphen_min_distance) )
             continue;
           if ( LO.hyphen(lo_finger,SH,sh_finger,total_weight,matching_weight, hyphen2, hyphen_min_distance) )
           {
              //if ( sh_finger )
							//	sh_finger--;
             continue;
           }
        }
      if ( initial )
        {
          if ( SH.initial_equals(sh_finger,LO,lo_finger,total_weight,matching_weight) )
            continue;
          if ( LO.initial_equals(lo_finger,SH,sh_finger,total_weight,matching_weight) )
          {
              //if ( sh_finger )
								//sh_finger--;
            continue;
          }
        }
         if ( abbr )
          {
            if ( SH.abbr_equals(sh_finger,LO,lo_finger,total_weight,matching_weight,abbr_type) )
                continue;
            if ( LO.abbr_equals(lo_finger,SH,sh_finger,total_weight,matching_weight,abbr_type) )
            {
              //if ( sh_finger )
							//	sh_finger--;
              continue;
            }
          }
          if ( edit_distance )
          {
            if ( SH.withinEditRadiusAndMaxDistance(sh_finger,LO,lo_finger,total_weight,matching_weight, edit_distance, maxEdits ) )
                continue;
          } 
      }
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
        return (int)((double)spec * ( matching_weight - (int)(SH.unmatched()+LO.unmatched()) ) / total_weight);
    case 3:
        return 100*matching_weight < spec ? 100*matching_weight : spec;
    default:
        return 0;
    }
}
ENDC++;
