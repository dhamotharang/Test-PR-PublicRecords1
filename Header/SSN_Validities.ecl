import ut, mdr;

h := Apt_Patch(ssn<>''); // This will change

mac_best_ssn(h,did,ofile,'1')


rels := header.file_relatives(number_cohabits>5);

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
  end;

ht := table(h,hs);

hs  first_cut(hs le, ofile ri) := transform
  self.val := MAP( ri.ssn='' => 'U',
                   le.ssn=ri.ssn and ri.old_ssn='N'=> 'G',
				   le.ssn=ri.ssn and ri.old_ssn='Y'=> 'O',
                   ut.StringSimilar(le.ssn,ri.ssn)<2 => 'F',
                   'B' );
  self := le;
  end;

jt := join(ht,ofile,left.did=right.did,first_cut(left,right),left outer,hash);

hs  take_rel(hs le, ssn_annot ri) := transform
  self.val := IF( ri.ssn='','B','R' );
  self := le;
  end;

f_rel := join(jt(val='B'),ssn_annot,left.did=right.did1 and left.ssn=right.ssn,take_rel(left,right),hash,left outer);

export SSN_Validities := jt(val<>'B')+f_rel : persist('SSN_Validities');