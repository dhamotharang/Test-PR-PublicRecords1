EXPORT INTEGER4 fn_match_bagofwords_fuzzy(CONST STRING l, CONST STRING r, UNSIGNED mode=0, UNSIGNED1 score_mode=0) := BEGINC++
namespace ns_SALT311_Fn_Match_Bagofwords_Fuzzy {
#define EQUALITY_MATCH_SCALE 100
#define HYPHEN1_MATCH_SCALE  100
#define HYPHEN2_MATCH_SCALE   90
#define ACRONYMFIRST_MATCH_SCALE  90
#define STEM_MATCH_SCALE      90
#define EDIT1_MATCH_SCALE     90
#define EDIT2_MATCH_SCALE     80
#define INITIAL_MATCH_SCALE   70
#define ACRONYM_MATCH_SCALE   50
#define ABBR_MATCH_SCALE      50
 
enum Abbr_Type { abbr_legacy, abbr_first, abbr_initial };
/*
    Porter stemmer in C++, based on the ECL-ML ML/Docs/PorterStemC port. The original paper is in
    Porter, 1980, An algorithm for suffix stripping, Program, Vol. 14, no. 3, pp 130-137,
    See also http://www.tartarus.org/~martin/PorterStemmer
*/
class PorterStem
{
private:
#define MAX_STEM_LENGTH 1024
/* The main part of the stemming algorithm starts here. b is a buffer
   holding a word to be stemmed. The letters are in b[k0], b[k0+1] ...
   ending at b[k]. In fact k0 = 0 in this demo program. k is readjusted
   downwards as the stemming progresses. Zero termination is not in fact
   used in the algorithm.
   Note that only lower case sequences are stemmed. Forcing to lower case
   should be done before stem(...) is called.
*/
    char b[MAX_STEM_LENGTH];  /* buffer for word to be stemmed */
    int k,k0,j;     /* j is a general offset into the string */
/* cons(i) is true <=> b[i] is a consonant. */
    int cons(int i)
    {
        switch (b[i])
        {
            case 'a': case 'e': case 'i': case 'o': case 'u': return false;
            case 'y': return (i==k0) ? true : !cons(i-1);
            default: return true;
       }
    }
/* m() measures the number of consonant sequences between k0 and j. if c is
   a consonant sequence and v a vowel sequence, and <..> indicates arbitrary
   presence,
      <c><v>       gives 0
      <c>vc<v>     gives 1
      <c>vcvc<v>   gives 2
      <c>vcvcvc<v> gives 3
      ....
*/
    int m()
    {
        int n = 0;
        int i = k0;
        while(true)
        {
            if (i > j) return n;
            if (! cons(i)) break;
            i++;
        }
        i++;
        while(true)
        {
            while(true)
            {
                if (i > j) return n;
                if (cons(i)) break;
                i++;
            }
            i++;
            n++;
            while(true)
            {
                if (i > j) return n;
                if (! cons(i)) break;
                i++;
            }
            i++;
        }
    }
/* vowelinstem() is true <=> k0,...j contains a vowel */
    int vowelinstem()
    {
        int i;
        for (i = k0; i <= j; i++)
            if (! cons(i)) return true;
        return false;
    }
/* doublec(j) is true <=> j,(j-1) contain a double consonant. */
    int doublec(int j)
    {
        if (j < k0+1) return false;
        if (b[j] != b[j-1]) return false;
        return cons(j);
    }
/* cvc(i) is true <=> i-2,i-1,i has the form consonant - vowel - consonant
   and also if the second c is not w,x or y. this is used when trying to
   restore an e at the end of a short word. e.g.
      cav(e), lov(e), hop(e), crim(e), but
      snow, box, tray.
*/
    int cvc(int i)
    {
        if (i < k0+2 || !cons(i) || cons(i-1) || !cons(i-2)) return false;
        {
            int ch = b[i];
            if (ch == 'w' || ch == 'x' || ch == 'y') return false;
        }
        return true;
    }
/* ends(s) is true <=> k0,...k ends with the string s. */
    int ends(const char * s, int length)
    {
        if (s[length-1] != b[k]) return false; /* tiny speed-up */
        if (length > k-k0+1) return false;
        if (memcmp(b+k-length+1,s,length) != 0) return false;
        j = k-length;
        return true;
    }
/* setto(s) sets (j+1),...k to the characters in the string s, readjusting
   k. */
    void setto(const char * s, int length)
    {
        memmove(b+j+1,s,length);
        k = j+length;
    }
/* r(s) is used further down. */
void r(const char * s, int length) { if (m() > 0) setto(s,length); }
/* step1ab() gets rid of plurals and -ed or -ing. e.g.
       caresses  ->  caress
       ponies    ->  poni
       ties      ->  ti
       caress    ->  caress
       cats      ->  cat
       feed      ->  feed
       agreed    ->  agree
       disabled  ->  disable
       matting   ->  mat
       mating    ->  mate
       meeting   ->  meet
       milling   ->  mill
       messing   ->  mess
       meetings  ->  meet
*/
    void step1ab()
    {
        if (b[k] == 's')
        {
            if (ends("sses",4)) k -= 2; else
            if (ends("ies",3)) setto("i",1); else
            if (b[k-1] != 's') k--;
        }
        if (ends("eed",3)) { if (m() > 0) k--; } else
        if ((ends("ed",2) || ends("ing",3)) && vowelinstem())
        {
            k = j;
            if (ends("at",2)) setto("ate",3); else
            if (ends("bl",2)) setto("ble",3); else
            if (ends("iz",2)) setto("ize",3); else
            if (doublec(k))
            {
                k--;
                {
                    int ch = b[k];
                    if (ch == 'l' || ch == 's' || ch == 'z') k++;
                }
            }
            else if (m() == 1 && cvc(k)) setto("e",1);
        }
    }
/* step1c() turns terminal y to i when there is another vowel in the stem. */
    void step1c() { if (ends("y",1) && vowelinstem()) b[k] = 'i'; }
/* step2() maps double suffices to single ones. so -ization ( = -ize plus
   -ation) maps to -ize etc. note that the string before the suffix must give
   m() > 0. */
    void step2()
    {
        switch (b[k-1])
        {
            case 'a': if (ends("ational",7)) { r("ate",3); break; }
                      if (ends("tional",6)) { r("tion",4); break; }
                      break;
            case 'c': if (ends("enci",4)) { r("ence",4); break; }
                      if (ends("anci",4)) { r("ance",4); break; }
                      break;
            case 'e': if (ends("izer",4)) { r("ize",3); break; }
                      break;
            case 'l': if (ends("bli",3)) { r("ble",3); break; } /*-DEPARTURE-*/
         /* To match the published algorithm, replace this line with
            case 'l': if (ends("\04" "abli")) { r("\04" "able"); break; } */
                      if (ends("alli",4)) { r("al",2); break; }
                      if (ends("entli",5)) { r("ent",3); break; }
                      if (ends("eli",3)) { r("e",1); break; }
                      if (ends("ousli",5)) { r("ous",3); break; }
                      break;
            case 'o': if (ends("ization",7)) { r("ize",3); break; }
                      if (ends("ation",5)) { r("ate",3); break; }
                      if (ends("ator",4)) { r("ate",3); break; }
                      break;
            case 's': if (ends("alism",5)) { r("al",2); break; }
                      if (ends("iveness",7)) { r("ive",3); break; }
                      if (ends("fulness",7)) { r("ful",3); break; }
                      if (ends("ousness",7)) { r("ous",3); break; }
                      break;
            case 't': if (ends("aliti",5)) { r("al",2); break; }
                      if (ends("iviti",5)) { r("ive",3); break; }
                      if (ends("biliti",6)) { r("ble",3); break; }
                      break;
            case 'g': if (ends("logi",4)) { r("log",3); break; } /*-DEPARTURE-*/
         /* To match the published algorithm, delete this line */
        }
    }
/* step3() deals with -ic-, -full, -ness etc. similar strategy to step2. */
    void step3()
    {
        switch (b[k])
        {
            case 'e': if (ends("icate",5)) { r("ic",2); break; }
                      if (ends("ative",5)) { r("",0); break; }
                      if (ends("alize",5)) { r("al",2); break; }
                      break;
            case 'i': if (ends("iciti",5)) { r("ic",2); break; }
                      break;
            case 'l': if (ends("ical",4)) { r("ic",2); break; }
                      if (ends("ful",3)) { r("",0); break; }
                      break;
            case 's': if (ends("ness",4)) { r("",0); break; }
                      break;
        }
    }
/* step4() takes off -ant, -ence etc., in context <c>vcvc<v>. */
    void step4()
    {
        switch (b[k-1])
        {
            case 'a': if (ends("al",2)) break; return;
            case 'c': if (ends("ance",4)) break;
                      if (ends("ence",4)) break; return;
            case 'e': if (ends("er",2)) break; return;
            case 'i': if (ends("ic",2)) break; return;
            case 'l': if (ends("able",4)) break;
                      if (ends("ible",4)) break; return;
            case 'n': if (ends("ant",3)) break;
                      if (ends("ement",5)) break;
                      if (ends("ment",4)) break;
                      if (ends("ent",3)) break; return;
            case 'o': if (ends("ion",3) && (b[j] == 's' || b[j] == 't')) break;
                      if (ends("ou",2)) break; return;
                      /* takes care of -ous */
            case 's': if (ends("ism",3)) break; return;
            case 't': if (ends("ate",3)) break;
                      if (ends("iti",3)) break; return;
            case 'u': if (ends("ous",3)) break; return;
            case 'v': if (ends("ive",3)) break; return;
            case 'z': if (ends("ize",3)) break; return;
            default: return;
        }
        if (m() > 1) k = j;
    }
/* step5() removes a final -e if m() > 1, and changes -ll to -l if    m() > 1. */
    void step5()
    {
        j = k;
        if (b[k] == 'e')
        {
            int a = m();
            if (a > 1 || (a == 1 && !cvc(k-1))) k--;
        }
        if (b[k] == 'l' && doublec(k) && m() > 1) k--;
    }
public:
    void stem(const char *word, unsigned word_length )
    {
        unsigned len = word_length<MAX_STEM_LENGTH?word_length:MAX_STEM_LENGTH;
        for (unsigned i = 0; i < len; i++)
            b[i] = tolower(word[i]);
        k = len-1; k0 = 0; /* initialize parameters */
        if (k <= k0+1) return; /*-DEPARTURE-*/
       /* With this line, strings of length 1 or 2 don't go through the
          stemming process, although no mention is made of this in the
          published algorithm. Remove the line to match the published
          algorithm. */
        step1ab(); step1c(); step2(); step3(); step4(); step5();
        b[k+1] = 0;
    };
    char * getStem( )
    {
        return b;
    }
    unsigned getStemLength()
    {
        return k+1;
    }
};
class wb
{
public: // Need to be fast - privacy a luxury
#define MAX_WORDS 32
    const char* words[MAX_WORDS];
    size32_t word_lengths[MAX_WORDS];
		size32_t wordstem_lengths[MAX_WORDS];
    // int specs[MAX_WORDS];
    unsigned specs[MAX_WORDS];
    bool  used[MAX_WORDS];
    bool error;
    unsigned nwords;
    unsigned total_weight;
    unsigned spec; // The weight declared for the whole string
  wb(unsigned len,const char *s, bool use_stemming);
  bool equals(unsigned l, wb &r,unsigned &rl,unsigned &total, int &matching)
  {
      // 1. Try to match in linear fashion
      if ( word_lengths[l] == r.word_lengths[rl] && !memcmp(words[l],r.words[rl],word_lengths[l]) )
      {
          updateMatchState(l,r,rl,total,matching,1,1,EQUALITY_MATCH_SCALE);
          return true;
      }
      return false;
  }
  bool hyphen(unsigned l, wb &r,unsigned &rl,unsigned &total, int &matching, bool hyphen2, unsigned hyphen_min_distance) // Local is hyphenated form of rhs
  {
    if ( rl < r.nwords-1 && // Extra word available
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
            updateMatchState(l,r,rl,total,matching,1,2,hyphen2?HYPHEN2_MATCH_SCALE:HYPHEN1_MATCH_SCALE);
						return true;
      }
      return false;
  }
	bool stem_equals(unsigned l, wb &r,unsigned &rl,unsigned &total, int &matching, unsigned stem_distance) //
  {
        if (wordstem_lengths[l] == r.wordstem_lengths[rl] && 
			      wordstem_lengths[l] > stem_distance &&
			      !memcmp(words[l],r.words[rl],wordstem_lengths[l]-1) ) // ignore the last character difference ('y' vs 'i')
        {
            updateMatchState(l,r,rl,total,matching,1,1,STEM_MATCH_SCALE);
            return true;
        }
        return false;
  }
  bool initial_equals(unsigned l, wb &r,unsigned &rl,unsigned &total, int &matching)
  {
      // LHS is the initial form of the RHS
      if ( word_lengths[l] < r.word_lengths[rl] && !memcmp(words[l],r.words[rl],word_lengths[l]) )
      {
            updateMatchState(l,r,rl,total,matching,1,1,INITIAL_MATCH_SCALE);
            return true;
      }
      return false;
  }
  bool abbr_equals(unsigned l, wb &r,unsigned &rl,unsigned &total, int &matching,unsigned abbrType, unsigned abbrSpcThreshold)
  {
      // RHS is the abbreviated form of the LHS
      if (word_lengths[l]<r.word_lengths[rl])
				return false;
  	  if (specs[l] > abbrSpcThreshold)
				return false;
      if (isAbbreviation(word_lengths[l],words[l],r.word_lengths[rl],r.words[rl],abbrType))
      {
            updateMatchState(l,r,rl,total,matching,1,1,ABBR_MATCH_SCALE);
            return true;
    }
    return false;
  }
	bool acronym_equals(unsigned l, wb &r,unsigned rl,unsigned &total, int &matching,unsigned abbrType, bool firstOnly)
  {
       // RHS is the abbreviated form of the LHS
      //if (word_lengths[l]<r.word_lengths[rl]) not valid for acronyms
      //    return false;
      if ( l == nwords-1 || used[l+1] ) // next token has to exist
          return false;
      unsigned count;
			bool match = firstOnly?isFirstOnlyAcronym(l, r.word_lengths[rl],r.words[rl],count):
			                       isAcronym(l, r.word_lengths[rl],r.words[rl],count,abbrType);
      if (match)
			{
            updateMatchState(l,r,rl,total,matching,count,1,firstOnly?ACRONYMFIRST_MATCH_SCALE:ACRONYM_MATCH_SCALE);
            return true;
      }
      return false;
  }
  bool withinEditRadiusAndMaxDistance(unsigned l, wb &r,unsigned &rl,unsigned &total, int &matching, unsigned radius, unsigned &maxDist)
  {
      if (maxDist==0) return false;
			if (word_lengths[l] <= radius || r.word_lengths[rl]<=radius) return false; // enforce minimum required length constraint
      unsigned eDist = withinEditRadius(word_lengths[l], words[l], r.word_lengths[rl], r.words[rl], radius);
      // eDist>radius represents a mismatch which should not reduce the maxDist
      maxDist = eDist<=radius ? (maxDist>eDist ? maxDist-eDist:0):maxDist;
      if ( eDist <= radius )
      {
            updateMatchState(l,r,rl,total,matching,1,1,eDist==1?EDIT1_MATCH_SCALE:EDIT2_MATCH_SCALE);
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
  void updateMatchState(unsigned l, wb &r, unsigned rl, unsigned &total, int &matching,unsigned lcount,unsigned rcount,unsigned scale)
  {
        int l_spec=0;
        int r_spec=0;
        for (unsigned i=0; i<lcount;i++)
        {
            used[l+i]=true;
            l_spec += specs[l+i];
        }
        for (unsigned i=0; i<rcount;i++)
        {
            r.used[rl+i]=true;
            r_spec += r.specs[rl+i];
        }
        // Only credit smaller side but remove penalty of larger side
        total -= l_spec > r_spec ? l_spec : r_spec;
        matching += l_spec > r_spec ? r_spec*scale/100 : l_spec*scale/100;
  }	
  bool isAbbreviation(unsigned lenL, const char *l, unsigned lenR, const char *r, unsigned abbr_type)
  {
      if ( lenL <= lenR )
          return false;
      // LHS is now the longer string RHS is the abbreviation
      if (lenR == 1) // one character abbreviation does not count
          return false;
			// ABBR(FIRST), or ABBR(INITIAL)		
			if (abbr_type && *l!=*r)		
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
	bool isFirstOnlyAcronym(unsigned l, unsigned lenAcronym, const char *acronym, unsigned &count) const
  {
        count=lenAcronym;
        unsigned aIndex = 0;
        while (aIndex<lenAcronym && l<nwords)
        {
            if (used[l] || acronym[aIndex] != *words[l])
                return false;
            aIndex++;
            l++;
        }
        return (aIndex<lenAcronym) ? false : true;
  } 
  bool isAcronym(unsigned l, unsigned lenAcronym, const char *acronym, unsigned &count, unsigned abbrType)
  {
      count=0;
      const char *p = acronym;
      unsigned lenP = lenAcronym;
      const char *word;
      unsigned index;
      bool matchFound;
      while (lenP && l<nwords)
      {
          if (used[l]) // acronym matching word candidates have to be consecutive and un-matched words
              return false;
          word = words[l];
          if (abbrType && *p != *word) // non-legacy abbr type (FIRST or INITIAL) the first characters have to match
              return false;
          index = 0;
          matchFound = false;
          do
          {
              if (!lenP)
                  break;
              if ( word_lengths[l]<=index )
                  break;
              if ( p-acronym >= lenAcronym )
                  break;
              if ( matchFound && (abbrType&abbr_initial) && *p != *(word+index))
                  break;
              if ( *p == *(word+index) )
              {
                  lenP--;
                  p++;
                  matchFound = true;
              }
              index++;
          } while ( true );
          if (!matchFound)
              return false;
          l++;
          count++;
      }
      return (lenP>0) ? false : true;
  }
  unsigned withinEditRadius(unsigned lenL, const char * l, unsigned lenR, const char * r, unsigned radius)
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
wb::wb(unsigned len,const char *s, bool use_stemming)
{
  // Input strings MUST be in form nnnn WORD nn WORD nn
  // Avoiding full initialization, trying to be FAST
	PorterStem stemmer;
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
			if (use_stemming)
			{
				stemmer.stem(s,word_len);
				wordstem_lengths[nwords] =stemmer.getStemLength();
			}
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
} //namespace
using namespace ns_SALT311_Fn_Match_Bagofwords_Fuzzy;
#body
#option pure
{
    unsigned hyphen_min_distance = ((mode >> 24) & 0xF) ? ((mode >> 24) & 0xF) : 1;
		unsigned edit_max_distance = ((mode >> 20) & 0xF) ? ((mode >> 20) & 0x0F) : 0;
    unsigned edit_distance = (mode & 0x30)>>4;
		unsigned abbr_spc_threshold = ((mode >> 10) & 0x1F) ? ((mode >> 10) & 0x1F) : 0x1F;
		unsigned stem_distance = ((mode >> 16) & 0xF);
		unsigned abbr_type = (mode & 0x300)>>8;
    // bool phonetic = (mode & 0x40) != 0;
    bool hyphen2 = (mode & 8) != 0;
    bool hyphen1 = (mode & 4) != 0;
    bool abbr = (mode & 2) != 0;
		bool acronym = (mode & 0x8000) != 0;
    bool initial = ((mode & 1) != 0) || hyphen2 || (abbr && (abbr_type & abbr_initial));
		bool stem = stem_distance>0;
    unsigned maxEdits = edit_max_distance?edit_max_distance:lenL+lenR; // ignore maxEdits if set to 0
		
    ns_SALT311_Fn_Match_Bagofwords_Fuzzy::wb L(lenL,l,stem);
    ns_SALT311_Fn_Match_Bagofwords_Fuzzy::wb R(lenR,r,stem);
    if ( L.error || R.error )
        return -1; // Parsing error
    unsigned total_weight = L.total_weight+R.total_weight;
    if ( !total_weight )
        return 0; // If either side has no information then return 0
    int matching_weight = 0;
    // MORE - below was previous behavior; but feels wrong
    int spec = L.spec > R.spec ? R.spec : L.spec; // How many points are we fighting for? (proportion of longer string)
    // Short & Long
    ns_SALT311_Fn_Match_Bagofwords_Fuzzy::wb &SH = L.nwords < R.nwords || lenL < lenR ? L : R;
    ns_SALT311_Fn_Match_Bagofwords_Fuzzy::wb &LO = L.nwords < R.nwords || lenL < lenR ? R : L;
    // Now process the shorter string against the longer
    // Heuristic strategy
    //unsigned lo_finger = 0;
for ( unsigned lo_finger = 0; lo_finger < LO.nwords; lo_finger++ )
{
    bool found = false;
    for (unsigned sh_finger = 0;sh_finger < SH.nwords && !found;sh_finger++)
    {
        if (!SH.used[sh_finger] && !LO.used[lo_finger])
        {
            if (*LO.words[lo_finger] == *SH.words[sh_finger])
            {
                if (SH.equals(sh_finger,LO,lo_finger,total_weight,matching_weight))
                    found=true;
                    //continue;
            }
        }
    }
}
		for ( unsigned lo_finger = 0; lo_finger < LO.nwords; lo_finger++ )
		{
				for (unsigned sh_finger = 0;sh_finger < SH.nwords && lo_finger < LO.nwords;sh_finger++)
				{
						if (!SH.used[sh_finger] && !LO.used[lo_finger])
						{
								if (*LO.words[lo_finger] == *SH.words[sh_finger])
								{
										if (hyphen1 || hyphen2)
										{
												// 2. See if we can consume TWO tokens on one side
												if (SH.hyphen(sh_finger,LO,lo_finger,total_weight,matching_weight,hyphen2,hyphen_min_distance))
														continue;
												if (LO.hyphen(lo_finger,SH,sh_finger,total_weight,matching_weight,hyphen2,hyphen_min_distance))
														continue;
										}
										if (stem)
										{
												if (SH.stem_equals(sh_finger,LO,lo_finger,total_weight,matching_weight,stem_distance))
														continue;
										}
									  if (acronym && (abbr_type & abbr_first))
                    {
											if (SH.acronym_equals(sh_finger,LO,lo_finger,total_weight,matching_weight,abbr_type,true))
													continue;
											if (LO.acronym_equals(lo_finger,SH,sh_finger,total_weight,matching_weight,abbr_type,true))
													continue;
										}
								}
								if (edit_distance)
								{
										if (SH.withinEditRadiusAndMaxDistance(sh_finger,LO,lo_finger,total_weight,matching_weight,edit_distance,maxEdits))
												continue;
								}
								if (*LO.words[lo_finger] == *SH.words[sh_finger])
								{
										if (initial)
										{
												if (SH.initial_equals(sh_finger,LO,lo_finger,total_weight,matching_weight))
														continue;
												if (LO.initial_equals(lo_finger,SH,sh_finger,total_weight,matching_weight))
														continue;
										}
								}
								if (acronym)
								{
										if (SH.acronym_equals(sh_finger,LO,lo_finger,total_weight,matching_weight,abbr_type,false))
												continue;
										if (LO.acronym_equals(lo_finger,SH,sh_finger,total_weight,matching_weight,abbr_type,false))
												continue;
								}								
								if (abbr && !(abbr_type & abbr_initial)) // ABBR(INITIAL) is equivalent to the initial mode
								{
										if (SH.abbr_equals(sh_finger,LO,lo_finger,total_weight,matching_weight,abbr_type,abbr_spc_threshold))
												continue;
										if (LO.abbr_equals(lo_finger,SH,sh_finger,total_weight,matching_weight,abbr_type,abbr_spc_threshold))
												continue;
								}
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
 
