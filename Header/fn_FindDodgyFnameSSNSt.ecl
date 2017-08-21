//similar to rule 5 however DOB's are not relevant (in the case of twins who are overlinked)
//there's also a counter threshold that would negatively effect the results of this new rule

export fn_FindDodgyFnameSSNSt(dataset(header.Layout_Header) hdr_in) := function

//found instances where fname transpose would return records where fname and lname were the same
h0 := hdr_in(ssn<>'' and st<>'');
h1 := h0(~(fname=lname));

rslim := record
 h1.did;
 string20 fname;
 string9  ssn;
 h1.st;
end;

rslim t_slim(h1 le) := transform
 self := le;
end;

tslim := distribute(project(h1,t_slim(left)),hash(did,fname,ssn,st));

rslim_ctr := record
 tslim.did;
 tslim.fname;
 tslim.ssn;
 tslim.st;
 count_ := count(group);
end;

tslim_ctr0 := table(tslim,rslim_ctr,did,fname,ssn,st,local);
tslim_ctr  := distribute(tslim_ctr0(length(trim(fname))>1),hash(did));

rdodgy := record
 unsigned6 did;
 boolean   is_dodgy;
end;

rdodgy tdodgy(tslim_ctr le, tslim_ctr ri) := transform
 self.is_dodgy := if(le.ssn!=ri.ssn and le.st!=ri.st and header.ssn_value(le.ssn,ri.ssn)<=0,true,false);
 self          := le;				  
end;

dodgy := join(tslim_ctr,tslim_ctr,
              left.did=right.did and left.fname[1..2]!=right.fname[1..2],
		      tdodgy(left,right)
			  ,local
			 );

//if any records come back false, then it's not dodgy
rdodgy t_rollup(dodgy le, dodgy ri) := transform
 self.is_dodgy := if(le.is_dodgy=false,le.is_dodgy,ri.is_dodgy);
 self          := le;
end;

dodgy_final := rollup(dodgy,left.did=right.did,t_rollup(left,right));

dodgy_true  := dodgy_final(is_dodgy=true);
dodgy_false := dodgy_final(is_dodgy=false);
/*
final_rec := record
 dodgy_true.did;
 string1 rule_number;
end;

final_rec t_set_rule_number(dodgy_true le) := transform
 self.rule_number := '9';
 self             := le;
end;

dodgy_9s := project(dodgy_true,t_set_rule_number(left));

return dodgy_9s;
*/
return dodgy_true;

end;