import ut;

export Fn_ApplyDodgyDIDs(
	dataset(header.Layout_Header) merged,
	dataset(header.layout_DodgyDids) dodgies) :=
FUNCTION

r1 := record
 boolean   is_dodgy;
 unsigned6 new_did;
 string20  p_fname;
 string1   m_init;
 string5   name_suffix_temp;
 merged;
end;

r1 x1(merged le, dodgies ri) := transform
 
 self.is_dodgy         := le.did=ri.did;
 
 self.new_did          := le.rid;
 self.p_fname          := datalib.PreferredFirstNew(le.fname,false);
 self.m_init           := le.mname[1];
 //common-up the name_suffix - no need to have different groups because JR and II differences
 self.name_suffix_temp := if(ut.is_unk(le.name_suffix),'',
                          if(le.name_suffix in ['2','II'],'JR',
						  if(le.name_suffix='3','III',
						  if(le.name_suffix='4','IV',
						  le.name_suffix))));
 self                  := le;
end;

j1 := join(merged,dodgies,left.did=right.did,x1(left,right),lookup,left outer);

//to prevent poor linking as a result of poor grouping, only consider those records with both and SSN and DOB
    candidates          := sort(j1(is_dodgy and ssn<>'' and dob>0),did,ssn,dob,p_fname,m_init,name_suffix_temp);
not_candidates          :=      j1(is_dodgy and (ssn ='' or  dob=0));
not_dodgy_to_begin_with := project(j1(is_dodgy=false),recordof(merged));

//find the min RID of the group, this becomes the new DID for the group
r1 x2(r1 le, r1 ri) := transform
 self.new_did := ut.min2(le.new_did,ri.new_did);
 self         := le;
end;

p1 := rollup(candidates,left.did=right.did and left.ssn=right.ssn and left.dob=right.dob and left.p_fname=right.p_fname and left.m_init=right.m_init and left.name_suffix_temp=right.name_suffix_temp,x2(left,right));

//apply new DID to group
r1 x3(r1 le, r1 ri) := transform
 self.new_did := ri.new_did;
 self         := le;
end;

j2 := join(candidates,p1,
		   left.did=right.did and left.ssn=right.ssn and left.dob=right.dob and left.p_fname=right.p_fname and left.m_init=right.m_init and left.name_suffix_temp=right.name_suffix_temp,
		   x3(left,right)
		   );

concat := j2+not_candidates;

//all records coming in here are dodgy, IF conditioning no longer necessary
typeof(merged) x4(concat le) := transform
 self.did            := le.new_did;
 self.pflag1         := 'D';
 //increment the UNK if it was previously UNK
 self.dodgy_tracking := if(ut.is_unk(le.dodgy_tracking),unk_add(le.dodgy_tracking),'UNK');
 self                := le;
end;

p2 := project(concat,x4(left));

concat2 := distribute(p2+not_dodgy_to_begin_with,hash(did));

return concat2;

END;