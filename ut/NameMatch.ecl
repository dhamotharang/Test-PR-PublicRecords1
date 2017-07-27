import ut,lib_datalib;
LowPrefix := ['AL','EL','DE','BAR','VAN','O','MC','MAC'];
ElAlMatch(string s1, string s2) := 
  ut.Tails(s1,s2) and ut.StripTail(s1,s2) IN LowPrefix or
  ut.Tails(s2,s1) and ut.StripTail(s2,s1) IN LowPrefix;
SMatch(string s1, string s2) :=
  MAP( s1=s2 => 0, 
       ut.StringSimilar(s1,s2)< 2 or ElAlMatch(s1,s2) => 1, 
       ut.Lead_Contains(s1,s2) => 1, 
       ut.stringsimilar(s1,s2) < 3 => 2, 
       ut.tails(s1,s2) or ut.tails(s2,s1) or ut.stringsimilar(s1,s2)<4 => 3, 
       99 );

NSMatch(string s1, string s2) :=
  MAP ( s1='' and s2='' => 0, s1='' or s2='' => 1, SMatch(s1,s2));

Low (integer a, integer b) := if ( a < b, a, b);

Low4(integer a1, integer a2, integer a3, integer a4) := Low(Low(a1,a2),Low(a3,a4));

NameMatch1(string f1,string m1, string l1, string f2, string m2, string l2 ) := 
// Loose points for every blank field
if ( f1 = '' or f2 = '', 2, 0 ) +
if ( m1 = '' or m2 = '', 1, 0 ) +
if ( l1 = '' or l2 = '', 2, 0 ) +
MAP ( SMatch(l1,l2) < 99 =>
        // Last names match
        LOW4(
		  // Try the concat f+m+l = f+m+l
             LOW (
		     IF(l1=l2 or m1=m2,99,SMatch(trim(f1)+trim(m1)+trim(l1),trim(f2)+trim(m2)+trim(l2))),               
             // Two points lost for ignoring mname
             SMatch(f1,f2) + 2 
                  ),
		// Try last + first = last, eg ABBOT BRIGGS & DAVID BRIGGSABBOT
		// The middle initials may match, or match the first name that isn't used
             IF(l1=l2,99,LOW( IF(length(trim(f1))>1,SMatch(trim(l1)+f1,l2) + Low(SMatch(m1,m2),SMatch(m1,f2) ),99),
                  IF(length(trim(f2))>1,SMatch(trim(l2)+f2,l1) + Low(SMatch(m1,m2),SMatch(m2,f1)), 99)
                 )),
             // catch MARYANNE SMITH & MARY ANNE SMITH
             LOW(IF(m1 = '' and m2 <> '',Smatch(f1,trim(f2)+m2) + 1,99),         
		         IF(m2 = '' and m1 <> '',Smatch(f2,trim(f1)+m1) + 1,99)
                 ),
             LOW( NSmatch(f1,f2) + NSMatch(m1,m2),
                  // One point for the reversal
			      IF(m1<>'' or m2<>'',1 + NSmatch(f1,m2) + NSMatch(f2,m1),99)
                 )
             ) + SMatch(l1,l2),
      // Last names are a non-match
      // Try first / last reversal
      SMatch(f1,l2) < 99 and SMatch(f2,l1) < 99 => NSMatch(m1,m2) + SMatch(f1,l2) + SMatch(f2,l1) + 1,
      // S P ASHER & ASHER S PADEH
      SMatch(f1,m2) < 99 and SMatch(m1,l2) < 99 and SMatch(l1,f2)<2 => SMatch(f1,m2)+SMatch(m1,l2)+SMatch(l1,f2) + 1,
      // ASHER S PADEH & S P ASHER
      SMatch(f1,l2) < 2 and SMatch(m1,f2) < 99 and SMatch(l1,m2)<99 => SMatch(f1,m2)+SMatch(m1,f2)+SMatch(l1,m2) + 1,
      // Try middle+last = last eg DAVID BEN ASHER & DAVID BENASHER
      SMatch(trim(m1)+l1,l2) < 2 => SMatch(trim(m1)+l1,l2)+1 + SMatch(f1,f2),
      SMatch(trim(m2)+l2,l1) < 2 => SMatch(trim(m2)+l2,l1)+1+ SMatch(f1,f2),
      // Try first + last = last, eg ABBOT BRIGGS & DAVID ABBOTBRIGGS
      // The middle initials may match, or match the first name that isn't used
      SMatch(trim(f1)+l1,l2) < 2=> SMatch(trim(f1)+l1,l2)+2 + Low(SMatch(m1,m2),SMatch(m1,f2) ),
      SMatch(trim(f2)+l2,l1) < 2=> SMatch(trim(f2)+l2,l1)+2+ Low(SMatch(m1,m2),SMatch(m2,f1)),
      // Try first + last = first, eg JO LEE & JOLEE ABBOT
      SMatch(trim(f1)+l1,f2) < 2 => SMatch(trim(f1)+l1,f2)+2+ NSMatch(m1,m2),
      SMatch(trim(f2)+l2,f1) < 2 => SMatch(trim(f2)+l2,f1)+2+ NSMatch(m1,m2),
      SMatch(l1,l2)+SMatch(f1,f2)+NSMatch(m1,m2) );

export NameMatch(string f1,string m1, string l1, string f2, string m2, string l2 ) := datalib.namematch(f1,m1,l1,f2,m2,l2);