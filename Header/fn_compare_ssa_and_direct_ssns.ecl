import death_master,ut;

export fn_compare_ssa_and_direct_ssns(dataset(recordof(header.file_death_master_plus)) deaths_in) := function

st  := deaths_in(state_death_flag='Y');
ssa := deaths_in(state_death_flag<>'Y');

    st_candidates      := st(  ssn<>'' and fname<>'' and lname<>'');
not_st_candidates      := st(~(ssn<>'' and fname<>'' and lname<>''));

    ssa_candidates := ssa(  ssn<>'' and fname<>'' and lname<>'');
not_ssa_candidates := ssa(~(ssn<>'' and fname<>'' and lname<>''));

st_candidates_dist  := distribute(st_candidates, hash(fname,lname,state,dod8,dob8));
ssa_candidates_dist := distribute(ssa_candidates,hash(fname,lname,state,dod8,dob8));
ssa_candidates_dupd := dedup     (ssa_candidates_dist,fname,lname,state,dod8,dob8,ssn,all,local);

r_ssn_candidates_prep := record
 ssa_candidates_dupd.fname;
 ssa_candidates_dupd.lname;
 ssa_candidates_dupd.state;
 ssa_candidates_dupd.dod8;
 ssa_candidates_dupd.dob8;
 ssa_candidates_dupd.ssn;
 rollup_ct := 1;
end;

r_ssn_candidates_prep t_ssn_candidates_prep(ssa_candidates_dupd le) := transform
 self := le;
end;

ssn_candidates_prep := project(ssa_candidates_dupd,t_ssn_candidates_prep(left),local);

r_ssn_candidates_prep t1(ssn_candidates_prep le, ssn_candidates_prep ri) := transform
 self.rollup_ct := le.rollup_ct+1;
 self           := le;
end;

ssn_candidates_rold := rollup(ssn_candidates_prep,
             left.fname=right.fname and 
			 left.lname=right.lname and 
			 left.state=right.state and
			 left.dod8 =right.dod8  and 
			 left.dob8 =right.dob8  and 
			 left.ssn<>right.ssn,
			 t1(left,right),
			 local
			);

//rollup_ct>1 means the SSA has more than 1 SSN for that person
//exclude those from consideration because we don't know which SSN is right
good_ssa_candidates := ssn_candidates_rold(rollup_ct=1);
bad_ssa_candidates  := ssn_candidates_rold(rollup_ct>1);

r1 := record
 string9 ssn_from_ssa;
 st_candidates;
end;

r1 t_j1(st_candidates le, good_ssa_candidates ri) := transform
 self.ssn_from_ssa := ri.ssn;
 self              := le;
end;

//same name
//same state
//born and died on the same day
j1 := join(st_candidates_dist,good_ssa_candidates,
		   left.fname=right.fname and
		   left.lname=right.lname and
		   left.state=right.state and
		   left.dod8=right.dod8   and
		   left.dob8=right.dob8   and
		   left.ssn<>right.ssn,
		   t_j1(left,right),
		   left outer,
		   local
		  );


ut.mac_ssn_diffs(j1,ssn,ssn_from_ssa,p_find_diff);

recordof(deaths_in) t_overwrite_bad_ssns(p_find_diff le) := transform
 
 self.ssn  := if(le.ssn_switch='Y',le.ssn_from_ssa,le.ssn);
 self.crlf := if(le.ssn_switch='Y','SA',le.crlf);
 self      := le;

end;

p_overwrite_bad_ssns := project(p_find_diff,t_overwrite_bad_ssns(left));

concat := ssa + not_st_candidates + p_overwrite_bad_ssns;

return concat;

end;