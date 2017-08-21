export fn_rollup_death_records(dataset(recordof(header.layout_death_master_plus)) ds0) :=
function

garbage_records(string fname_field, string mname_field, string lname_field, string dod8_field, string dob8_field, string ssn_field) :=
   (trim(fname_field)='' and trim(lname_field)='')
or (fname_field<>'' and lname_field<>'' and trim(dod8_field)='' and trim(dob8_field)='' and trim(ssn_field)='');

junk_names := garbage_records(ds0.fname,ds0.mname,ds0.lname,ds0.dod8,ds0.dob8,ds0.ssn);

good_records := ds0(not junk_names);
bad_records  := ds0(    junk_names);

r1 := record
 good_records;
 integer rollup_ct := 1;
end;

r1 t_rollup_prep(good_records le) := transform
 self := le;
end;

rollup_prep := project(good_records,t_rollup_prep(left));

ds_supp_only := rollup_prep(state_death_id<>'');
ds_the_rest  := rollup_prep(trim(state_death_id)='');

ds_supp_only_dist := distribute(ds_supp_only,hash(fname,mname,lname,dob8,dod8,ssn));
ds_the_rest_dist  := distribute(ds_the_rest, hash(fname,mname,lname,dob8,dod8,ssn));

r1 t_rollup_supp(r1 le, r1 ri) := transform
 self.rollup_ct := le.rollup_ct+1;
 self           := le;
end;

rollup1 := rollup(ds_supp_only_dist,left.fname=right.fname
                                and left.mname=right.mname
								and left.lname=right.lname
								and left.dod8 =right.dod8
								and left.dob8 =right.dob8
								and left.ssn  =right.ssn,
								t_rollup_supp(left,right),local);

rollup2 := rollup(ds_the_rest_dist,left.fname=right.fname
                               and left.mname=right.mname
							   and left.lname=right.lname
							   and left.dod8 =right.dod8
							   and left.dob8 =right.dob8
							   and left.ssn  =right.ssn,
							   t_rollup_supp(left,right),local);

//only rollup people who are found once within each supplemental and death_master_plus								
supp_rollup_candidates := rollup1(rollup_ct=1);
supp_non_candidates    := rollup1(rollup_ct>1);

ssa_rollup_candidates := rollup2(rollup_ct=1);
ssa_non_candidates    := rollup2(rollup_ct>1);
 
r1 t_join(r1 le, r1 ri) := transform

 boolean has_matching_record := le.fname=ri.fname
                            and le.mname=ri.mname
							and le.lname=ri.lname
							and le.dod8 =ri.dod8
							and le.dob8 =ri.dob8
							and le.ssn  =ri.ssn;
							
 self.filedate          := if(le.filedate>ri.filedate,le.filedate,     ri.filedate);

 self.rec_type          := if(has_matching_record,le.rec_type,        ri.rec_type);
 self.rec_type_orig     := if(has_matching_record,le.rec_type_orig,   ri.rec_type_orig);
 self.ssn               := if(has_matching_record,le.ssn,             ri.ssn);
 self.lname             := if(has_matching_record,le.lname,           ri.lname);
 self.name_suffix       := if(has_matching_record,le.name_suffix,     ri.name_suffix);
 self.fname             := if(has_matching_record,le.fname,           ri.fname);
 self.mname             := if(has_matching_record,le.mname,           ri.mname);
 
 self.vorp_code         := ri.vorp_code;
 //self.vorp_code         := if(has_matching_record,le.vorp_code,ri.vorp_code);
 
 self.dod8              := if(has_matching_record,le.dod8,             ri.dod8);
 self.dob8              := if(has_matching_record,le.dob8,             ri.dob8);
 self.st_country_code   := if(has_matching_record,le.st_country_code,  ri.st_country_code);
 self.zip_lastres       := if(has_matching_record,le.zip_lastres,      ri.zip_lastres);
 self.zip_lastpayment   := if(has_matching_record,le.zip_lastpayment,  ri.zip_lastpayment);
 self.state             := if(has_matching_record,le.state,            ri.state);
 self.fipscounty        := if(has_matching_record,le.fipscounty,       ri.fipscounty);
 self.clean_title       := if(has_matching_record,le.clean_title,      ri.clean_title);
 self.clean_fname       := if(has_matching_record,le.clean_fname,      ri.clean_fname);
 self.clean_mname       := if(has_matching_record,le.clean_mname,      ri.clean_mname);
 self.clean_lname       := if(has_matching_record,le.clean_lname,      ri.clean_lname);
 self.clean_name_suffix := if(has_matching_record,le.clean_name_suffix,ri.clean_name_suffix);
 self.clean_name_score  := if(has_matching_record,le.clean_name_score, ri.clean_name_score);
 self.state_death_id    := if(has_matching_record,le.state_death_id,   ri.state_death_id);
 self.state_death_flag  := if(has_matching_record,le.state_death_flag, ri.state_death_flag);
 
 self                   := le;
end;
  
p_join := join(supp_rollup_candidates,ssa_rollup_candidates,
               left.fname=right.fname
		   and left.mname=right.mname
		   and left.lname=right.lname
		   and left.dod8 =right.dod8
		   and left.dob8 =right.dob8
		   and left.ssn  =right.ssn,
		   t_join(left,right)
		   ,full outer
		   ,local
		   );

header.layout_death_master_plus t_drop_rollup_ct_field(p_join le) := transform
 self := le;
end;

p_slim_join                := project(p_join,             t_drop_rollup_ct_field(left));
p_slim_supp_non_candidates := project(supp_non_candidates,t_drop_rollup_ct_field(left));
p_slim_ssa_non_candidates  := project(ssa_non_candidates, t_drop_rollup_ct_field(left));

concat := p_slim_join+p_slim_supp_non_candidates+p_slim_ssa_non_candidates+bad_records;

return concat;

end;