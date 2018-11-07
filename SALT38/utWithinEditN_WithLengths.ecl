alg := ENUM(UNSIGNED1, Standard=0, NoTrailingHalfEdit);
EXPORT BOOLEAN utWithinEditN_WithLengths(STRING l,UNSIGNED1 ll,STRING r,UNSIGNED1 rl,UNSIGNED1 d,UNSIGNED1 mode=alg.Standard) := BEGINC++
  #option pure
	lenL = ll;
	lenR = rl;
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
  ENDC++;
