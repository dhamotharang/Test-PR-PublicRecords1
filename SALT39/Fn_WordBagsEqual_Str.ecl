/**
* Fn_WordBagsEqual_Str returns TRUE if consecutive corresponding words in l and r are 
* the same; numeric expanssions are ignored
* wb1 and wb2 MUST be in form nnnn WORD nn WORD nn
*/
EXPORT BOOLEAN Fn_WordBagsEqual_Str(CONST STRING l, CONST STRING r) := BEGINC++
namespace ns_SALT39_Fn_WordBagsEqual_Str {
class wb
{
public: // Need to be fast - privacy a luxury
#define MAX_WORDS 32
    const char* words[MAX_WORDS];
    unsigned word_lengths[MAX_WORDS];
    bool error;
    unsigned nwords;
    wb(unsigned len,const char *s)
    {
			 // Input strings MUST be in form nnnn WORD nn WORD nn
			 // Avoiding full initialization, trying to be FAST
			 unsigned word_len;
			 nwords = 0;
			 error = true;
			 while ( len && s[len-1]==' ' )
					 len--;
			 skipSpaces(len,s);
			 word_len = toSpace(len,s);
			 s += word_len;
			 len-= word_len;
			 skipSpaces(len,s); // skip/ignore spec
			 while ( nwords < MAX_WORDS && len )
			 {
					 word_len = toSpace(len,s);
					 if ( !word_len )
							 break;
					 words[nwords] = s;
					 word_lengths[nwords] = word_len;
					 s += word_len;
					 len-= word_len;
					 skipSpaces(len,s); // get to word spec
					 if ( !len )
							 return;
					 nwords++;
					 word_len = toSpace(len,s);
					 s += word_len;
					 len-= word_len;
					 skipSpaces(len,s); // skip/ignore word spec
			 };
			 error = false;
    };
    bool operator==(const wb &rhs) const
    {
        if (this->nwords == rhs.nwords)
        {
            for (unsigned i=0; i<this->nwords;i++)
                if ( this->word_lengths[i] != rhs.word_lengths[i] || memcmp(this->words[i],rhs.words[i],this->word_lengths[i]) )
                    return false;
            return true;
        }
        else
            return false;
    };
private:
    inline void skipSpaces(unsigned &lenS,const char * &s)
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
};
} //namespace
using namespace ns_SALT39_Fn_WordBagsEqual_Str;
#body
#option pure
{	
    ns_SALT39_Fn_WordBagsEqual_Str::wb wbLeft(lenL,l);
    ns_SALT39_Fn_WordBagsEqual_Str::wb wbRight(lenR,r);
    if ( wbLeft.error || wbRight.error )
      return false; // Parsing error
    return wbLeft==wbRight;
}
ENDC++;
