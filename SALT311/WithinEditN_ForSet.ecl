/**
	WithinEditN_ForSet returns index of the first element of the set 'l' which is found to be
	within edit distance 'd' from string 'r'; Otherwise it returns -1.
	When edit_threshold is defined then algorithm runs in the EDITX mode;
	When mode is set to NoTrailingHalfEdit, then trailing half-edit mode is disabled.
  Input parameters:
	  l - set of strings to compare edit distance against or ALL for a universal set
		r - a single string to compare edit distance against the set l
		d - edit distance
		edit_threshold - when defined (i.e. >0) apply edit1 if noth strings are smaller or equal to the
		                 threshold, otherwise apply edit2
		mode - Standard (use trailing half edit), or NoTrailingHalfEdit 							 
*/
alg := ENUM(UNSIGNED1, Standard=0, NoTrailingHalfEdit);
EXPORT INTEGER WithinEditN_ForSet(SET OF STRING l,STRING r,UNSIGNED1 d,UNSIGNED1 edit_threshold=0,UNSIGNED1 mode=alg.Standard) := BEGINC++
namespace ns_SALT311_WithinEditN_ForSet {
// almose exact copy of the SALTxx.utWithinEditN_WithLengths; olny changed parameter types
// to accomodate ECL to C++ mappings, and defined lenL and lenR types
bool utWithinEditN_WithLengths(const char * l,size32_t ll,const char * r,size32_t rl,unsigned char d,unsigned char mode)
{
	unsigned lenL = ll;
	unsigned lenR = rl;
	while ( lenL && l[lenL-1]==' ' ) lenL--;
	while ( lenR && r[lenR-1]==' ' ) lenR--; // Trim incoming strings
	if ( lenL > lenR + d * 2 || lenR > lenL + d * 2 )
		return false;
		// No fuzzy on very short strings
	if ( lenL <= lenR && lenL <= d-(lenR-lenL)/2 )
		d = (lenL || lenR)?(1+lenR-lenL)/2 + lenL-1:0;
	if ( lenL > lenR && lenR <= d-(lenL-lenR)/2 )
		d = (lenL || lenR)?(1+lenL-lenR)/2 + lenR-1:0;
	// while ( lenL && lenR && *l == *r )
	do
	{
			if ( !lenL )
				  return (!mode) ? lenR <= d * 2 : lenR <= d;
			if ( !lenR )
					return (!mode) ? lenL <= d * 2: lenL <= d;
			if ( *l != *r )
			{
					if ( !d )
					    return false;
					d--;
			    if ( lenR > 1 && lenL > 1 && *l == r[1] && *r == l[1] && !( lenR > 2 && lenR >= lenL && l[1] == r[2] ) && !( lenL > 2 && lenL >= lenR && r[1] == l[2] ) )
					{	// The switch case - counts as one edit
						// But if we can delete rather than switch and STILL have two matches in a row - go for it ...
						lenR--;
						lenL--;
						l++;
						r++;
					}
		else if (( lenR > 3 && lenL > 3 && lenR == lenL &&
										*l == r[1] && *r == l[1] && l[2] == r[2] && l[3] == r[3] ) ||
										( (lenR == 3 || lenL == 3) && lenR == lenL &&
										*l == r[1] && *r == l[1] && l[2] == r[2] ))
					{ // adjacent transposition counts as an edit
						lenR--;
						lenL--;
						l++;
						r++;
					}
					else if ( lenR > 1 && lenL > 1 && *l == r[1] && *r == l[1] &&
							( lenR > 2 && lenR >= lenL && l[1] == r[2] ) &&
						 !( lenL > 2 && lenL >= lenR && r[1] == l[2] ) )
					{ // Character missing from LHS
						lenR--;
						r++;
					}
					else if ( lenR > 1 && lenL > 1 && *l == r[1] && *r == l[1] &&
						 !( lenR > 2 && lenR >= lenL && l[1] == r[2] ) &&
							( lenL > 2 && lenL >= lenR && r[1] == l[2] ) )
					{ // Character missing from RHS
						lenL--;
						l++;
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
					/*
          else if ( d>0 && lenR > 2 && *l == r[2] && ( lenR > lenL+1 || lenR == lenL && l[1] != r[1] && l[2] != r[2]) ) 
          { // 2 consecutive characters missing from LHS
              lenR--;
              r++;
          }
          else if ( d>0 && lenL > 2 && *r == l[2] && ( lenL > lenR+1 || lenR == lenL && l[1] != r[1] && l[2] != r[2]) )
          { // 2 consecutive characters missing from RHS
              lenL--;
              l++;
          }	*/								
			}
			lenL--;
			lenR--;
			l++;
			r++;
	}		while ( 1 );
}
} //namespace
using namespace ns_SALT311_WithinEditN_ForSet;
#body
#option pure
{	
	if (isAllL) // if ALL (a.k.a. universal set) is passed in, any string will have a counterpart in the universal set which is 'withinEditN'
		return true;
		
  const char * cur = (const char *)l;	
	const char * end = cur + lenL;
	int index = 1;
	while (cur != end)
	{
		unsigned len = *(unsigned *)cur;
		cur += sizeof(unsigned);
		unsigned char ed = d;
		if (edit_threshold>0)
		{
			if (edit_threshold>len && edit_threshold>lenR)
				ed = 1;
			else
				ed = 2;
		}		
		if (ns_SALT311_WithinEditN_ForSet::utWithinEditN_WithLengths(cur,len,r,lenR,ed,mode))
			return index;
		cur += len;	
		index++;
	}
	return -1;
}
ENDC++;
