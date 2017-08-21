//export bwr_for_ssn_dodgy_rule := 'todo';

test_did := 49529973;

in_hdr := header.file_headers;

header_recs            := watchdog.fn_best_ssn(in_hdr).hdr1;
check_for_ssn_flipping := watchdog.fn_best_ssn(header_recs).check_for_ff;

output(header_recs(did=test_did),named('header_recs'));
output(check_for_ssn_flipping(did=test_did),named('check_for_ssn_flipping'));

f_potential_dodgy := dedup(check_for_ssn_flipping(ssn_switch='Y' and ssn_belongs_to_relative=false and other_ssn_belongs_to_relative=false and total_times_seen>25 and other_total_times_seen>25 and total_score>100 and other_total_score>100),did,all);

header.layout_header t1(header.layout_header le, f_potential_dodgy ri) := transform
 self := le;
end;

//get all of the original records for the ADL/SSN combination
j_get_orig_recs := join(header_recs,distribute(f_potential_dodgy,hash(did)),left.did=right.did and (left.ssn=right.ssn or left.ssn=right.other_ssn),t1(left,right),local);

header.layout_header t2(header.layout_header le, header.layout_header ri) := transform
 self := le;
end;

j_set1 := distribute(dedup(join(j_get_orig_recs,j_get_orig_recs,left.did=right.did and left.ssn>right.ssn,t2(left,right),local),record),hash(did));
j_set2 := distribute(dedup(join(j_get_orig_recs,j_get_orig_recs,left.did=right.did and left.ssn<right.ssn,t2(left,right),local),record),hash(did));

output(j_set1(did=test_did),named('j_set1'));
output(j_set2(did=test_did),named('j_set2'));

r_append_bname := record
 header_recs;
 string20 best_fname :='';
 string20 best_lname :='';
 string5  best_suffix:='';
end;

string pst1 := 'SKIPIT';//pass "_1" to write to a persist
string pst2 := 'SKIPIT';//pass "_2" to write to a persist

best_fname_set1 := join(j_set1,(watchdog.fn_bestfirstname_try2(j_set1,pst1))(fname<>''),left.did=right.did,transform({r_append_bname},self.best_fname:=right.fname,self:=left),left outer,local);
best_fname_set2 := join(j_set2,(watchdog.fn_bestfirstname_try2(j_set2,pst2))(fname<>''),left.did=right.did,transform({r_append_bname},self.best_fname:=right.fname,self:=left),left outer,local);

best_lname_set1 := join(best_fname_set1,(watchdog.fn_bestlastname_try2(j_set1,pst1))(lname<>''),left.did=right.did,transform({r_append_bname},self.best_lname:=right.lname,self:=left),left outer,local);
best_lname_set2 := join(best_fname_set2,(watchdog.fn_bestlastname_try2(j_set2,pst2))(lname<>''),left.did=right.did,transform({r_append_bname},self.best_lname:=right.lname,self:=left),left outer,local);

best_suffix_set1 := join(best_lname_set1,watchdog.fn_bestsuffix(j_set1,pst1)(name_suffix<>''),left.did=right.did,transform({r_append_bname},self.best_suffix:=right.name_suffix,self:=left),left outer,local);
best_suffix_set2 := join(best_lname_set2,watchdog.fn_bestsuffix(j_set2,pst2)(name_suffix<>''),left.did=right.did,transform({r_append_bname},self.best_suffix:=right.name_suffix,self:=left),left outer,local);

output(best_suffix_set1(did=test_did),named('best_suffix_set1'));
output(best_suffix_set2(did=test_did),named('best_suffix_set2'));

r_final := record
 unsigned6 did;
 string20  best_fname1;
 string20  best_lname1;
 string5   best_name_suffix1;
 string20  best_fname2;
 string20  best_lname2;
 string5   best_name_suffix2;
 string9   ssn1;
 string9   ssn2;
 integer   do_names_match;
 string1   gender1;
 string1   gender2;
 boolean   female_is_close;
 boolean   lnames_ever_cross:=false;
end;

fn_translate_suffix(string in_sfx) := function
 out_sfx := if(in_sfx in ['II','III','IV','3','4'],'JR',in_sfx);
 return out_sfx;
end;

r_final t3(r_append_bname le, r_append_bname ri) := transform 
 self.did               := le.did;
 self.best_fname1       := le.best_fname;
 self.best_lname1       := le.best_lname;
 self.best_name_suffix1 := fn_translate_suffix(le.best_suffix);
 self.best_fname2       := ri.best_fname;
 self.best_lname2       := ri.best_lname;
 self.best_name_suffix2 := fn_translate_suffix(ri.best_suffix);
 self.ssn1              := le.ssn;
 self.ssn2              := ri.ssn;
 self.do_names_match    := datalib.DoNamesMatch(self.best_fname1,'',self.best_lname1,self.best_fname2,'',self.best_lname2,3);
 self.gender1           := if(datalib.gender(self.best_fname1) in ['M','F'],datalib.gender(self.best_fname1),'');
 self.gender2           := if(datalib.gender(self.best_fname2) in ['M','F'],datalib.gender(self.best_fname2),'');
 self.female_is_close   := self.gender1='F' and self.gender2='F' and self.ssn1[1..5]=self.ssn2[1..5] and ut.firstname_match(self.best_fname1,self.best_fname2)>0;
end;

j1 := dedup(join(best_suffix_set1((best_fname<>'' and best_lname<>'') or best_suffix<>''),best_suffix_set2((best_fname<>'' and best_lname<>'') or best_suffix<>''),left.did=right.did,t3(left,right),keep(1)),record,all);

output(j1(did=test_did),named('j1'));

lname_cross_candidates := j1(best_fname1=best_fname2 and best_lname1<>best_lname2 and ut.nneq(best_name_suffix1,best_name_suffix2));

output(lname_cross_candidates(did=test_did),named('lname_cross_candidates'));

r_final t4a(r_final le, header.layout_header ri) := transform
 self.lnames_ever_cross := if(le.best_lname2<>'' and le.best_lname2=ri.lname,true,false);
 self                   := le;
end;

r_final t4b(r_final le, header.layout_header ri) := transform
 self.lnames_ever_cross := if(le.best_lname1<>'' and le.best_lname1=ri.lname,true,false);
 self                   := le;
end;

j_lname_cross1 := join(distribute(lname_cross_candidates,hash(did)),j_set1,left.did=right.did,t4a(left,right),local);
j_lname_cross2 := join(distribute(lname_cross_candidates,hash(did)),j_set2,left.did=right.did,t4b(left,right),local);

output(j_lname_cross1(did=test_did),named('j_lname_cross1'));
output(j_lname_cross2(did=test_did),named('j_lname_cross2'));

f_lname_cross1 := dedup(j_lname_cross1(lnames_ever_cross=true),record,all,local);
f_lname_cross2 := dedup(j_lname_cross2(lnames_ever_cross=true),record,all,local);

output(f_lname_cross1(did=test_did),named('f_lname_cross1'));
output(f_lname_cross2(did=test_did),named('f_lname_cross2'));

r_final t5(r_final le, r_final ri) := transform
 self.lnames_ever_cross := ri.lnames_ever_cross;
 self                   := le;
end;

j2 := join(distribute(j1,hash(did)),distribute(f_lname_cross1,hash(did)),left.did=right.did,t5(left,right),left outer,local);

output(j2(did=test_did),named('j2'));

r_final t6(r_final le, r_final ri) := transform
 self.lnames_ever_cross := if(le.lnames_ever_cross=true or ri.did=0,le.lnames_ever_cross,ri.lnames_ever_cross);
 self                   := le;
end;

j3 := join(distribute(j2,hash(did)),distribute(f_lname_cross2,hash(did)),left.did=right.did,t6(left,right),left outer,local);

output(j3(did=test_did),named('j3'));

result := j3(best_fname1<>'' and best_lname1<>'' and best_fname2<>'' and best_lname2<>'' and ~((do_names_match< 5 and ut.nneq(best_name_suffix1,best_name_suffix2) and ut.nneq(gender1,gender2)) or female_is_close=true or lnames_ever_cross=true));

output(result(did=test_did),named('result_of_test_did'));
output(result,named('result'));
output(count(result),named('result_cnt'));

hdr     := header.file_headers;//(did=147627620);
//hdr_out := test_fn_FindDodgySSNandSourceBased(hdr);