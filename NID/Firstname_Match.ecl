import ut;

export FirstName_Match(string l, string r) :=
  MAP(l=r => 3,
      NID.PreferredFirstNew(l, true)=NID.PreferredFirstNew(r, true) or 
			NID.PreferredFirstNew(l, false)=NID.PreferredFirstNew(r, false)=> 2,
      ut.lead_contains(l,r) => 1, 0 );