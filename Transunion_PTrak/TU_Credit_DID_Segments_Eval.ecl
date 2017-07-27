#workunit('name', 'EXP - TU True DID Segments');
import header, Experian_Evaluation,Transunion_PTrak;


hdr_seg := header.fn_ADLSegmentation(header.file_headers).core_check;
hdr_pst_d := distribute(hdr_seg,hash(did)) : persist('persist::jtrost_hdr_seg');

hdr_pst := dedup(sort(distribute(hdr_pst_d, hash(did)) , did, LOCAL), did, LOCAL);

experian := DATASET('~thor400::base::Experian_CP', Experian_Evaluation.Layout_Experian_CP_Out.Layout_Experian_All_Out, THOR);
TU_credit  := DATASET('~thor400::base::TU_cp_credit', Transunion_PTrak.Layout_TU_CP_Credit_Out.Layout_TU_All_Out, THOR);

r1 := record
 unsigned6 did;
 string    in_exp;
end;

r2 := record
 unsigned6 did;
 string    in_tucs;
end;

r1 t1(experian le) := transform
 self.in_exp := '1';
 self        := le;
end;

r2 t2(TU_credit le) := transform
 self.in_tucs := '1';
 self         := le;
end;

p_experian := project(experian(did>0),t1(left));
p_tucs     := project(TU_credit(did>0),t2(left));

exp_dist  := distribute(p_experian,hash(did));
tucs_dist := distribute(p_tucs,hash(did));

exp_sort  := sort(exp_dist,did,local);
tucs_sort := sort(tucs_dist,did,local);

exp_dupd  := dedup(exp_sort,did,local);
tucs_dupd := dedup(tucs_sort,did,local);

r3 := record
 hdr_pst;
 exp_dupd.in_exp;
end;

r3 t3(hdr_pst le, exp_dupd ri) := transform
 self := le;
 self := ri;
end;

j1 := join(hdr_pst,exp_dupd,left.did=right.did,t3(left,right),left outer,local);

r4 := record
 j1;
 tucs_dupd.in_tucs;
end;

r4 t4(j1 le, tucs_dupd ri) := transform
 self := le;
 self := ri;
end;

j2 := join(j1,tucs_dupd,left.did=right.did,t4(left,right),left outer,local) : persist('persist::jtrost_hdr_seg_exp_tucs');

//output(j2);
//count(j2);

r5 := record
 j2.ind;
 count_ := count(group);
 integer tucs_only  := count(group,j2.in_tucs='1'      and trim(j2.in_exp)='');
 integer exp_only   := count(group,trim(j2.in_tucs)='' and j2.in_exp='1');
 integer in_both    := count(group,j2.in_tucs='1'      and j2.in_exp='1');
 integer in_neither := count(group,trim(j2.in_tucs)='' and trim(j2.in_exp)='');
end;

ta1 := table(j2,r5,ind,few);
output(ta1,all);

export TU_Credit_DID_Segments_Eval := 'todo';