import ut;
h := header.file_headers(header.Blocked_data());
r := record
  h.fname;
  h.did;
  h.dob;
  h.ssn;
  h.valid_ssn;
  h.st;
  end;

rt := distribute(table(h(h.dob>18000000),r),hash(did));

rroll := record
  rt.did;
  dob_max := max(group,rt.dob);
  dob_min := min(group,rt.dob);
  end;

did_tab := table(rt,rroll,did,local);

rroll_days := record
  rt.did;
  day_dob_max := max(group,rt.dob % 100);
  day_dob_min := min(group,rt.dob % 100);
  end;

days_tab := table(rt(dob%100>1),rroll_days,did,local);

did_rec := record
  unsigned6 did;
  string1 rule_number;
  end;

b_dob := h(jflag1='B');

did_rec bad_one(b_dob l) := transform 
 self.rule_number := '1';
 self := l;
end;

bad_dob := project(b_dob,bad_one(left));

did_rec sli_day(days_tab le) := transform
  self.rule_number := '2';
  self := le;
  end;

days_wrong := project(days_tab(day_dob_max<>day_dob_min),sli_day(left));

rts := rt((unsigned8)ssn<>0);

ssns := record
  rts.did;
  rts.ssn;
  male := count(group,datalib.gender(trim(rts.fname))='M');
  female := count(group,datalib.gender(trim(rts.fname))='F');
  dob_max := max(group,rts.dob div 100);
  dob_min := min(group,rts.dob div 100);
  mob_max := max(group,(rts.dob div 100) % 100);
  day_max := max(group,rts.dob % 100);
  end;

did_ssn := table(rts,ssns,did,ssn,local);

did_rec sli_s(did_ssn le) := transform
  self.rule_number := '3';
  self := le;
  end;

gender_bias(unsigned2 m,unsigned2 f) :=
  MAP( m > f => 'M',
       f > m => 'F', 'U' );

j1 := join(did_ssn,did_ssn,left.did=right.did and
                           ( left.ssn<> right.ssn 
                             and left.day_max<>right.day_max 
                             and ( left.day_max>1 and right.day_max>1 
                                   or left.day_max>0 and right.day_max>0 
                                      and
                                      left.mob_max<>right.mob_max )  
                             or
                             ut.stringsimilar(left.ssn,right.ssn)>1 
                           ) and
                           (
							 gender_bias(left.male,left.female)<>
                             gender_bias(right.male,right.female) and 
                             gender_bias(left.male,left.female)<>'U' and 
                             gender_bias(right.male,right.female)<>'U' or 
                             ut.date_overlap(left.dob_min,left.dob_max,right.dob_min,right.dob_max) = 0
                           ),
                           sli_s(left),local);

split_by_ssn := dedup(sort(j1,did,local),did,local);
high := 99999999;
gender := record
  rts.did;
  male_dob_max := max(group,if(datalib.gender(trim(rts.fname))='M',rts.dob div 100,0));
  male_dob_min := min(group,if(datalib.gender(trim(rts.fname))='M',rts.dob div 100,high));
  female_dob_max := max(group,if(datalib.gender(trim(rts.fname))='F',rts.dob div 100,0));
  female_dob_min := min(group,if(datalib.gender(trim(rts.fname))='F',rts.dob div 100,high));
  end;

did_rec sli_g(gender le) := transform
  self.rule_number := '4';
  self := le;
  end;

did_gender := table(rts,gender,did,local);

did_question := did_gender(male_dob_min<>high,female_dob_min<>high);

gender_sbad := project(did_question(male_dob_min<>female_dob_min and female_dob_max<>male_dob_max),sli_g(left));
gender_bad := project(did_question(ut.date_overlap(male_dob_min,male_dob_max,female_dob_min,female_dob_max)=0),sli_g(left));


//=================== rule 5 ===================================
//Rule 5: if a did has 2 or more ssn, without sharing address st, no overlapping birthday either.
w_ssn := rt((unsigned8)ssn<>0, valid_ssn not in ['R', 'F']); // Don't filter out valid_ssn 'B': did 812696229 has 'B'.
ssn_st := w_ssn(st != '');
  
//j2_counter: dids with 2 or more ssn, shared address state between each ssn.
recSsnSt := record
  ssn_st.did;
  ssn_st.ssn;
  ssn_st.st;
end;

did_ssn_st_group := table(ssn_st,recSsnSt,did,ssn,st, local);

did_rec sli_s10(did_ssn_st_group le, did_ssn_st_group ri) := transform
  self.rule_number := 'F';
  self := le;
  end;
j2_counter := join(did_ssn_st_group,did_ssn_st_group,
    left.did=right.did 
    and left.ssn<> right.ssn and ut.stringsimilar(left.ssn,right.ssn)>1 
    and left.st = right.st
  , sli_s10(left, right),local);
j2_counter_dedup :=  dedup(sort(j2_counter,did,local),did,local);

//j2_pre: dids with 2 or more ssn, with non-overlapping dob. dob: day>0, but can be 01.
// rt also has h.dob>18000000.
recSsnStDob := record
  ssn_st.did;
  ssn_st.ssn;
  cnt := count(group);
  dob8_max := max(group, ssn_st.dob);
  dob8_min := min(group, ssn_st.dob);
end;
did_ssn_group := table(w_ssn(dob%100 > 0),recSsnStDob,did,ssn, local);

did_rec sli_s2(did_ssn_group le, did_ssn_group ri) := transform
  self.rule_number := '5';
  self := le;
  end;

j2_pre := join(did_ssn_group,did_ssn_group,
	left.cnt > 1 and right.cnt > 1 //make sure it is not due to a single record.
    and left.did=right.did 
    and left.ssn<> right.ssn and ut.stringsimilar(left.ssn,right.ssn)>1 
    and (left.dob8_max < right.dob8_min or right.dob8_max < left.dob8_min) //if year and month are the same
  , sli_s2(left, right),local);  //local: rt is distributed by did.
j2_pre_dedup := dedup(sort(j2_pre,did,local),did,local);

//j2: dids with 2 or more ssn, with non-overlapping dob, no shared address state between ssn.
did_rec sli_s3(did_rec le, did_rec ri) := transform
  self := le;
  end;
j2 := join(j2_pre, j2_counter, left.did=right.did, 
    sli_s3(left, right), left only);
st_dob := dedup(sort(j2, did), did);

//==================== END rule5 ====================================

np := dedup(sort(gender_sbad+split_by_ssn+bad_dob + st_dob, did),did, local);
export DodgyDids :=  np : persist('dodgy_dids');
