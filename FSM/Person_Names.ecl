import header,ut;

tbase0 := sort( table(header.File_Headers,{fname,mname,lname,name_suffix,did,ssn,dob}), did, fname, mname, lname, name_suffix, local );

tbrc := record
  tbase0.did;
  rcnt := count(group);
	unsigned ssns := count(group,tbase0.ssn<>'');
	unsigned dobs := count(group,tbase0.dob>0);
  end;

tbasec := table(tbase0,tbrc,did,local); // local is ok - header is distributed

tbase_p := dedup(tbase0,did,fname,mname,lname,name_suffix,local); // local is ok - header is distributed
	
tbase := join(tbase_p,tbasec,left.did=right.did,local);
	
ht := typeof(tbase);
spaced := tbase(ut.NoWords(lname)=2);

hyphens := tbase( stringlib.stringfind(lname,'-',1)<>0 );

ht fake_hyphen(spaced le) := transform
  self.lname := ut.Word(le.lname,1)+'-'+ut.Word(le.lname,2);
  self := le;
  end;
	
fake_hyphens := project(spaced,fake_hyphen(left));

ht fake_space(spaced le) := transform
  self.lname := ut.Word(le.lname,1,'-')+' '+ut.Word(le.lname,2,'-');
  self := le;
  end;
	
fake_spaces := project(hyphens,fake_space(left));

ht fake_join(tbase le) := transform
  self.lname := stringlib.stringfilterout(le.lname,' -');
  self := le;
  end;
	
fake_joined	:= project(spaced+hyphens,fake_join(left));

ht blank_middle(tbase le) := transform
  self.mname := '';
	self := le;
  end;

ht init_middle(tbase le) := transform
  self.mname := le.mname[1];
	self := le;
  end;

hf0 := tbase+fake_hyphens+fake_spaces+fake_joined; // All forms of double-barreled names available

hf1 := hf0+project(hf0(length(trim(mname))>1),init_middle(left))+project(hf0(mname<>''),blank_middle(left)); // All forms of double-barreled names available

ht clear_suffix(tbase le) := transform
	self.name_suffix := '';
	self := le;
	end;
	
fake_suffix := project(hf1(name_suffix<>''), clear_suffix(left));	

hf := hf1 + fake_suffix;

string100 pname := cl(trim(hf.fname) + ' ' + trim(hf.mname) + ' ' + hf.lname + ' ' + hf.name_suffix);
h0 := distribute(table(hf(pname<>''),{fname,mname,lname,name_suffix,pname,did,ssns,dobs,rcnt}),hash(pname));

h := dedup( sort( h0, pname,did, local ), pname,did,local ); // still required as above 'extras' may have caused dups

h1 := record
  h.pname;
	unsigned4 dob_cnt := sum(group,h.dobs);
	unsigned4 ssn_cnt := sum(group,h.ssns);
	unsigned4 cnt := sum(group,h.rcnt);
  end;
	
t1 := table(h,h1,pname,local);

h11 := record
  t1;
	string30 fname;
	string30 mname;
	string30 lname;
	string10 name_suffix;	
  end;

h11 app(h1 le,h ri) := transform 
  self.fname := ri.fname;
  self.mname := ri.mname;
  self.lname := ri.lname;
	self.name_suffix := ri.name_suffix;
  self := le;
  end;

j := join (t1,dedup(h,pname,all),left.pname=right.pname,app(left,right));

export Person_Names := j : persist('temp::dab::person_names');