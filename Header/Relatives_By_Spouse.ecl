import ut,ExperianCred;

export Relatives_By_Spouse := FUNCTION

file_exp_base := experiancred.files.base_file_out;

filter_exp_base := file_exp_base(did>0 and nametype in ['SP1','C1'] and addressseq = 1);
dist_exp_base := distribute(filter_exp_base,hash(encrypted_experian_pin));
srt_exp_base := sort(dist_exp_base,encrypted_experian_pin,local);

Layout_Relatives_v2.temp t_join_exp(srt_exp_base le, srt_exp_base ri) := TRANSFORM
self.person1 := max(le.did,ri.did);
self.person2 := ut.min2(le.did,ri.did);
self.recent_cohabit := 0;
self.same_lname := true;
self.number_cohabits := 6;
self.zip := -7;
self.prim_range := -7;
self.Experian_PIN := le.Encrypted_Experian_PIN; 
end;

join_exp_base := join(srt_exp_base(nametype='SP1'),srt_exp_base(nametype='C1'),left.encrypted_experian_pin=right.encrypted_experian_pin and left.orig_lname=right.orig_lname and left.did <> right.did,t_join_exp(left,right));
dist_exp := distribute(join_exp_base, hash(person1));
srt_exp := dedup(sort(dist_exp, person1, person2, local),person1,person2,Experian_PIN,local);
dedup_exp_base := dedup(srt_exp,person1,person2,local,keep 5): PERSIST('PERSIST::Relatives_Spouse');
return dedup_exp_base; 

END;