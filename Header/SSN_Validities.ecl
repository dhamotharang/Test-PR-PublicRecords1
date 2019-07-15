import ut, mdr, watchdog, PRTE2_Header;

h := distribute(header.apt_patch(ssn <>''),hash(did)); // This will change

ofile := watchdog.fn_best_ssn(h).concat_them;


rels := header.File_Relatives_v3(number_cohabits>5);

r_ssn := record
  unsigned6 did1;
  unsigned6 did2;
  string9 ssn;
  end;

r_ssn take(rels le,unsigned1 ct) := transform
  self.did1 := if(ct=1,le.person1,le.person2);
  self.did2 := if(ct=1,le.person2,le.person1);
  self.ssn := '';
  end;

rls := normalize(rels,2,take(left,counter));

r_ssn take_ssn(r_ssn le, ofile ri) := transform
  self.ssn := ri.ssn;
  self := le;
  end;

ssn_annot := dedup(join(rls,ofile,left.did2=right.did,take_ssn(left,right),hash),did1,ssn,all);



hs := record
  h.did;
  h.rid;
  h.ssn;
  string1 val := '';
  h.dt_first_seen;
  h.dt_last_seen;
  //thought this would be helpful to carry thru
  string9 best_ssn:='';
  end;

ht := table(h,hs);

hs  first_cut(hs le, ofile ri) := transform
  self.val := MAP( ri.ssn='' => 'U',
                   le.ssn=ri.ssn and ri.old_ssn='N'=> 'G',
				   le.ssn=ri.ssn and ri.old_ssn='Y'=> 'O',
                   ut.StringSimilar(le.ssn,ri.ssn)<2 => 'F',
                   'B' );
  self.best_ssn := ri.ssn;
  self := le;
  end;

jt0 := join(ht,ofile,left.did=right.did,first_cut(left,right),left outer,hash);

ut.mac_ssn_diffs(jt0,best_ssn,ssn,jt1);

hs find_new_fs(jt1 le) := transform
 score:=header.fn_miskey_compare(le.best_ssn,le.ssn);
 self.val := if(le.ssn_switch='Y' or (le.val='B' and score in [1,2]),'F',le.val);
 self     := le;
end;

jt := project(jt1,find_new_fs(left));

hs  take_rel(hs le, ssn_annot ri) := transform
  self.val := IF( ri.ssn='','B','R' );
  self := le;
  end;

f_rel := join(jt(val='B'),ssn_annot,left.did=right.did1 and left.ssn=right.ssn,take_rel(left,right),hash,left outer);

all_recs := jt(val<>'B')+f_rel;

non_Gs := all_recs(val!='G');
first_Gs := distribute(all_recs(val='G'),hash(ssn));

//Only set one SSN to G for all DIDs
rec := record
 all_recs.did;
 all_recs.ssn;
 integer cnt := count(group);
 integer dur := max(group,all_recs.dt_last_seen) - min(group,if(all_recs.dt_first_seen=0,999999,all_recs.dt_first_seen));
end;

t := table(first_Gs,rec,did,ssn,local);

rec2 := record
 t.ssn;
 integer cnt := count(group);
end;

t2 := table(t,rec2,ssn,local);

//SSNs with only one DID
easy_G := t2(cnt=1);

hs blankbadG(first_Gs L, easy_G R) := transform
 self.val := if(r.ssn='','','G');
 self := l;
end;

easy_G_all := join(first_Gs,easy_G,left.ssn=right.ssn,blankbadG(left,right),left outer, local);

//Pick best DID per SSN based on duration of reported ssn
hard_g := easy_g_all(val='');

srt_t := sort(t,ssn,-dur,-cnt,did,local);
dup_t := dedup(srt_t,ssn,local);

hs blankbadG2(hard_g L, dup_t R) := transform
 self.val := if(r.ssn='','Z','G');
 self := l;
end;

last_set := join(hard_g,dup_t,left.ssn=right.ssn and left.did=right.did,blankbadG2(left,right),left outer, local);

#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
export SSN_Validities := non_Gs + easy_G_all(val='G')+last_set;
#ELSE
export SSN_Validities := non_Gs + easy_G_all(val='G')+last_set : persist('SSN_Validities');
#END;