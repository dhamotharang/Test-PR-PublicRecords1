//minor change to Vald's attribute
import didville;

export get_eah_bestphone(GROUPED DATASET (execathomev2.layout_eah_title) file_with_title
                         ) := function

didville.MAC_HHid_Append (file_with_title, 'HHID_NAMES', file_with_hhid);

didville.layout_did_outbatch get_ready(execathomev2.layout_eah_title L) := transform
	self := l;
	self := [];
end;

file_with_phones_raw := didville.gong_append(project(file_with_hhid, get_ready(Left)));

execathomev2.layout_eah_person_best get_phone(execathomev2.layout_eah_title l, 
                                              didville.layout_did_outbatch r) 
:= transform
     self.person_best_phone := r.best_phone;
	self.person_best_phone_active := if(r.best_phone<>'','Y','N');
	self.hhid := r.hhid;
	self := L;
end;

file_with_phones := JOIN(file_with_title, file_with_phones_raw,
                         left.did = right.did, get_phone(left, right), left outer, lookup);

return file_with_phones;	
	
end;
