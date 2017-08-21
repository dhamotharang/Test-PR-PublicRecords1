// Consider the ADL's which doesn't have multiple DOB's,SSN's and name_suffix
// Consider the Rare name combinations 
import ut,header; 
export fn_name_dob_collapses(dataset(recordof(header.layout_header)) hdr) := function

head := hdr(fname <>'' and lname<>'');
head_dist := distribute(head, hash(did)); 
head_slim_rec := record
	head.did;
	head.fname;
	head.lname;
	head.dob;
	head.ssn; 
	head.name_suffix;
	head.jflag1;
	
end;

head_slim_rec slimit(head l) := transform
	self := l;
end;
head_slim:= project(head_dist, slimit(left));
names_ddpd := dedup(sort(head_slim, did, fname, lname, dob,ssn,name_suffix,local), did, fname, lname, dob,ssn,name_suffix,local);

// skip the did's have multiple dob's or multiple ssn's 

rskip := record
names_ddpd;
 boolean   is_skip;
end;

rskip tskip(names_ddpd le, names_ddpd ri) := transform
 self.is_skip := if((le.ssn <> '' and ri.ssn<>'' and le.ssn!=ri.ssn) or 
                    (le.dob<>0 and ri.dob <>0 and le.dob!=ri.dob) or  
                    (ut.is_unk(le.name_suffix) or ut.is_unk(ri.name_suffix)) or // Check if this needed. Do we need to collpase the did's with UNK's or not? 
				    (le.name_suffix<>'' and ri.name_suffix<>''   and le.name_suffix != ri.name_suffix),true,false);
 self          := le;				  
end;

skip_1 := join(names_ddpd,names_ddpd,
              left.did=right.did,
		      tskip(left,right)
			  ,local
			 );
			 
//if any records come back true, then it's  skip
rskip t_rollup(skip_1 le, skip_1 ri) := transform
 self.is_skip := if(le.is_skip=true,le.is_skip,ri.is_skip);
 self          := le;
end;

skip_final := rollup(skip_1,left.did=right.did,t_rollup(left,right),local);
skip_true  := skip_final(is_skip=true);
skip_false := skip_final(is_skip=false);//:persist('namecount_skip_false_unk');

cand := join(head_dist, skip_false, 
						 left.did = right.did, 
						 transform(header.layout_header,
								   self := left),
						 local);

// find rare names from all the above did's 
				 
temp_rec := record
	cand.fname;
	cand.lname;
	cand.did;
end;

headname := distribute( table( cand, temp_rec ), hash(trim((string)fname), trim((string)lname)) );

tempcountrec := record
	headname.fname;
	headname.lname;
	counted := count(group);
end;

namecount := table(headname, tempcountrec, fname, lname,local);
nc0 := namecount(counted < 100); 

isn(string a) := a <> '' and stringlib.StringFilterOut(a,'0123456789') = '';
nc := nc0(length(trim((string)fname)) > 1, 
					  length(trim((string)lname)) > 1, 
				      not isn(fname),
					  not isn(lname)); 
					  
headrec := record
	head.did;
	head.fname;
	head.lname;
	head.dob;
	integer namecount:=0;
	head.ssn;
	head.name_suffix;
	head.jflag1 ; 
end;

headrec slimit1(cand l) := transform
	self := l;
end;
cand_slim:= project(cand, slimit1(left));

headrec tra(cand_slim l, nc r) := transform
	self.fname := r.fname;
	self.lname := r.lname;
	self.namecount := r.counted;
    self := l ; 
end;

//these are all the recs from the header where the person has a rare name
names := join(distribute(cand_slim, 
						 hash(trim((string)fname), trim((string)lname))),
			  nc, 
			  left.fname = right.fname and left.lname = right.lname,
			  tra(left, right), local);
			  
names_srtd0 := sort(names(dob >0,ssn<>''), did, fname, lname, dob,ssn,name_suffix, local);
names_ddpd0 := dedup(names_srtd0, did, fname, lname, dob,ssn,name_suffix ,local);
 
headrec1 := record 
headrec; 
integer r_did; 
end; 

headrec1 keepclean(names_ddpd0 l, names_ddpd0 r) := transform
 self := l;
 self.r_did := r.did ; 
 
end;

j := join(names_ddpd0, names_ddpd0, 
     left.fname = right.fname and 
     left.lname = right.lname and 
     left.dob=right.dob and
     left.ssn =right.ssn and 
     left.name_suffix = right.name_suffix and 
     left.did <> right.did ,
     keepclean(left,right), local);
	 
header.layout_pairmatch reftopairmatch(j le) := transform
 self.old_rid := ut.max2(le.did,le.r_did);
 self.new_rid := ut.min2(le.did,le.r_did);
 self.pflag   := 41;
end;
  
j41 := dedup(project(j,reftopairmatch(left)),record,all) :persist('did_rules_name_dob_collapses');

return j41;

end;