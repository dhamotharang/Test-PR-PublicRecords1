EXPORT boolean WithinEdit2Convey(const string hashl, const string bitvecl, const string hashr, const string bitvecr, string l, string r) := BEGINC++
#option pure
{
  int d = 2;
        
  if( (bitvecl[hashr[0] >> 3] & (1ull << (hashr[0] & 0x7))) != 0) {
    if( (bitvecr[hashl[0] >> 3] & (1ull << (hashl[0] & 0x7))) != 0) {
                
      while ( lenL && l[lenL-1]==' ' ) lenL--;
      while ( lenR && r[lenR-1]==' ' ) lenR--; // Trim incoming strings

      if ( lenL > lenR + d * 2 || lenR > lenL + d * 2 )
        return false;

      // No fuzzy on very short strings
      if ( lenL <= lenR && lenL <= d-(lenR-lenL)/2 )
        d = (1+lenR-lenL)/2 + (lenL?lenL-1:0);
      if ( lenL > lenR && lenR <= d-(lenL-lenR)/2 )
        d = (1+lenL-lenR)/2 + (lenR?lenR-1:0);

      // while ( lenL && lenR && *l == *r )
      do
      {
        if ( !lenL )
          return lenR <= d * 2;
        if ( !lenR )
          return lenL <= d * 2;
        if ( *l != *r )
        {
          if ( !d )
            return false;
          d--;
          if ( lenR > 1 && lenL > 1 && *l == r[1] && *r == l[1] && 
             !( lenR > 2 && lenR >= lenL && l[1] == r[2] ) && 
             !( lenL > 2 && lenL >= lenR && r[1] == l[2] ) )
          { // The switch case - counts as one edit
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
      } while ( 1 );
                        
      return false;
                        
    }
  }
        
  return false;
}
ENDC++;