export mac_get_type_r(f_r_did, f_r_acctno, f_out_r) := macro

import progressive_phone, relocations;
	
seq_final_rec := record	, maxlength(20000)
	progressive_phone.layout_progressive_batch_out_with_did.did;
	unsigned4 seq;
	dataset(Relocations.layout_wdtg.final) rls;
end;	

#uniquename(get_relocations_raw)
seq_final_rec %get_relocations_raw%(f_r_did l) := transform
	self.did := l.did;
	self.seq := l.seq;
	self.rls := choosen(relocations.wdtg.get_gong_by_did(l.did,,		
											        												 Relocations.wdtg.default_radius,
																        							 Relocations.wdtg.default_daysBefore,
																				        			 Relocations.wdtg.default_daysAfter),10);
end;

#uniquename(f_rls_raw)
%f_rls_raw% := project(f_r_did, %get_relocations_raw%(left));

#uniquename(norm_rls)
progressive_phone.layout_progressive_batch_out_with_did  %norm_rls%(%f_rls_raw% l, Relocations.layout_wdtg.final r) := transform
	self.acctno := if(r.phone10='', skip, (string20)l.seq);
	self.subj_first := r.name_first;
  self.subj_middle := r.name_middle;
  self.subj_last := r.name_last;
  self.subj_suffix := r.name_suffix; 
	self.subj_phone10 := r.phone10;  
  self.subj_name_dual := r.listed_name;
  self.subj_phone_type := '9';
  self.subj_date_first := r.dt_first_seen;
  self.subj_date_last := r.dt_last_seen;
	self.subj_phone_date_last := r.dt_last_seen;
	self.phpl_phones_plus_type := 'R';
	self.did := l.did;
	self.addr_suffix := r.suffix;
	self.zip5 := r.z5;
	self.sub_rule_number := 91;
	self := r;
	self := [];
end;

#uniquename(f_rls)
%f_rls% := normalize(%f_rls_raw%, left.rls, %norm_rls%(left, right));

progressive_phone.mac_get_back_acctno(%f_rls%, f_r_acctno, f_out_r)
	
endmacro;