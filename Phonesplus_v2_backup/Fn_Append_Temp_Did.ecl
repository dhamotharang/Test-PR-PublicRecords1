import ut;
//****************Function to append Temp did when did = 0********************************
export Fn_Append_Temp_Did(dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

phplus_in_s := sort(distribute(phplus_in, hash(phone7_rec_key)), phone7_rec_key, local);
ut.MAC_Sequence_Records(phplus_in_s, pdid, phplus_prep_id);

phplus_prep_s := sort(group(phplus_prep_id, phone7_rec_key), pdid);


recordof(phplus_in) t_assign_did(phplus_prep_s le, phplus_prep_s ri) := Transform
		self.did 			:= if(ri.did > 0, ri.did, ut.Min2(ri.pdid, le.pdid));
		self.pdid			:= if(ri.did > 0, 0, ri.pdid);
		self.phone7_did_key := if(ri.did > 0, ri.phone7_did_key, hashmd5((data) le.phone7 + self.did));
		self := ri;
end;

pplus_did_i := iterate(phplus_prep_s, t_assign_did(left,right));

pplus_all := ungroup(pplus_did_i);
return pplus_all;
end;
