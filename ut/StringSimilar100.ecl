import lib_datalib;
maxi(integer l, integer r) := if ( l > r, l, r );
mini(integer l,integer r) := if ( l > r, r, l);

c3(integer l, integer r, integer s) := (l-r)*2/3+r-s;

c3a(integer l, integer r, integer s) := round(100/l * c3(l,r,s));

export StringSimilar100(string l, string r) := datalib.StringSimilar100(l,r);/*
c3a( maxi(length(trim(l)),length(trim(r))),
    mini(length(trim(l)),length(trim(r))),
    maxi( datalib.slidingmatch(trim(l),trim(r)) , 
          datalib.positionalmatch(trim(l),trim(r)))
);*/