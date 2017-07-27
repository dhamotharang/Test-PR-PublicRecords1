r := record
  string255 n; // Related to fsm.key_layout_names but cannot use directly because of cyclic dependency
	string1   src;
	unsigned  cnt;
  unsigned1 pcnt := 0;
  end;
f := fsm.First_Names;

r fi(f le) := transform
  self.n := le.fname;
	self.src := 'F';
	self.cnt := le.cnt;
  end;
	
f_n := project(f,fi(left));	

l := fsm.Last_Names;

r li(l le) := transform
  self.n := le.lname;
	self.src := 'L';
	self.cnt := le.cnt;
  end;
	
l_n := project(l,li(left));


c := fsm.Company_Words;

r ci(c le) := transform
  self.n := le.word;
	self.src := 'W';
	self.cnt := le.cnt;
  end;
	
c_n := project(c,ci(left));

cn := fsm.Company_Names_Only;

r cni(cn le) := transform
  self.n := le.company_name;
	self.src := 'C';
	self.cnt := le.cnt;
  end;
	
cc_n := project(cn,cni(left));

cf := fsm.Vanity_Companies;

r cnif(cf le) := transform
  self.n := le.company_name;
	self.src := 'V';
	self.cnt := le.cnt;
  end;
	
cf_n := project(cf,cnif(left));

cd := Cities;

r cnid(cd le) := transform
  self.n := le.city_name;
	self.src := 'D';
	self.cnt := le.cnt;
  end;
	
cd_n := project(cd,cnid(left));

pn := annotatedpeople_only;

r cnip(pn le) := transform
  self.n := le.pname;
  self.src := 'N';
  self.cnt := le.cnt;
  end;

pn_n := project(pn,cnip(left));

labs := distribute(f_n + l_n + c_n + cc_n + cf_n + cd_n + pn_n,hash(n));

pure_f := join(f_n,labs(src<>'F'),left.n=right.n AND left.cnt<right.cnt*100,transform(left),hash,left only);
pure_l := join(l_n,labs(src<>'L'),left.n=right.n AND left.cnt<right.cnt*100,transform(left),hash,left only);
pure_w := join(c_n,labs(src<>'W'),left.n=right.n AND left.cnt<right.cnt*100,transform(left),hash,left only);
pure_c := join(cc_n,labs(src IN ['F','L','D','N']),left.n=right.n AND left.cnt<right.cnt*100,transform(left),hash,left only); // don't penalize C for W or V
pure_v := join(cf_n,labs(src IN ['F','L','D','N']),left.n=right.n AND left.cnt<right.cnt*100,transform(left),hash,left only); // don't penalize C for W or V
pure_d := join(cd_n,labs(src<>'D'),left.n=right.n AND left.cnt<right.cnt*100,transform(left),hash,left only);
pure_n := join(cd_n,labs(src<>'N'),left.n=right.n AND left.cnt<right.cnt*100,transform(left),hash,left only);

pures := distribute(pure_f+pure_l+pure_w+pure_c+pure_v+pure_d+pure_n,hash(n));

remainder := join(labs,pures,left.n=right.n,transform(left),local,left only);

r tk(r le, r ri) := transform
  self.src := 'N';
	self.cnt := le.cnt + ri.cnt;
  self := le;
  end;

p_n := join(remainder(src IN ['F','L']),remainder(src IN ['D','V','W','C']),left.n=right.n,transform(left),local,left only);

pure_n0 := rollup ( sort ( p_n, n, local ), left.n=right.n, tk(left,right), local );

rem2 := join(remainder,pure_n0,left.n=right.n,transform(left),local,left only);

r weaken(r le) := transform
  self.src := MAP ( le.src = 'L' => 'l',
										le.src = 'W' => 'w',
										le.src = 'C' => 'c',
										le.src = 'D' => 'd',
										le.src = 'F' => 'f',
										le.src = 'V' => 'v',
										le.src = 'N' => 'n',
										'?' );
  self := le;
  end;
	
rem := project(rem2,weaken(left));

alln := rem+pures+pure_n0;

r_tot := record
  alln.n;
	unsigned cnt := sum(group,alln.cnt);
  end;
	
ntots := table(alln,r_tot,n,local);

r add_pcnt(r le, ntots ri) := transform
  self.pcnt := round( le.cnt * 100.0 / ri.cnt );
  self := le;
  end;
	
with_pcnt := join(alln,ntots,left.n=right.n,add_pcnt(left,right),local);

export Names := with_pcnt : persist('temp::names_c');