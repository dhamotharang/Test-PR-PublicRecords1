import business_header,marketing_best;

b := business_header.File_Business_Header(company_name<>'');
										
r := record										
  company_name := cl(b.company_name);
	b.bdid;
  end;
	
ta := table(b,r);

rp := record
  r;
	unsigned4 cnt;
	end;
	
	
rp note_emp(ta le, marketing_best.Key_Marketing_Best_BDID ri) := transform
  self.cnt := MAP ( ri.l_bdid=0 => 1,
	                  (unsigned)ri.exactemplcnt=0 => ((unsigned)ri.emplcntmin+(unsigned)ri.emplcntmax)/2,
										(unsigned)ri.exactemplcnt );
  self := le;
  end;
	
hres := join(ta,marketing_best.Key_Marketing_Best_BDID,left.bdid=right.l_bdid,note_emp(left,right),hash,left outer);	

h0 := distribute(hres,hash(company_name));

h := dedup( sort( h0, company_name,bdid, local ), company_name,bdid,local );

h1 := record
  h.company_name;
	unsigned4 cnt := sum(group,h.cnt);
  end;
	
t1 := table(h,h1,company_name,local);

export Company_Names := t1 : persist('temp::dab::company_names');