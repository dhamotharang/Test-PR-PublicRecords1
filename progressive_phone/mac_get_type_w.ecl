export mac_get_type_w(f_w_did, f_w_acctno, f_out_w, mod_access) := macro

import paw, progressive_phone, Suppress;
		
#uniquename(paw_did_key)		
#uniquename(paw_contact_key)
%paw_did_key%	:= paw.Key_Did;
%paw_contact_key% := paw.Key_contactID;

#uniquename(f_with_contact_id)
%f_with_contact_id% := join(f_w_did, %paw_did_key%,
                            keyed(left.did != 0 and left.did = right.did), 
                            limit(50, skip));

#uniquename(layout_batch_out_with_paw_score)		
%layout_batch_out_with_paw_score% := record
  progressive_phone.layout_progressive_batch_out_with_did;
  unsigned4 paw_conf_score := 0;
  unsigned4 global_sid;
  unsigned8 record_sid;
end;

#uniquename(get_company_info)														
%layout_batch_out_with_paw_score% %get_company_info%(%f_with_contact_id% l, %paw_contact_key% r) := transform
  self.acctno := if((unsigned)r.company_phone=0, skip, (string20)l.seq);
  self.subj_first := l.fname;
  self.subj_middle := l.mname;
  self.subj_last := l.lname;
  self.subj_suffix := l.suffix; 
  self.subj_phone10 := r.company_phone;
  self.subj_name_dual := r.company_name;
  self.subj_phone_type := '10';
  self.subj_date_first := (string8)r.dt_first_seen;
  self.subj_date_last := (string8)r.dt_last_seen;
  self.subj_phone_date_last := '';
  self.phpl_phones_plus_type := 'B';
  self.paw_conf_score := (unsigned)r.score;
  self.did := l.did;
  self.prim_range := r.company_prim_range;
  self.predir := r.company_predir;
  self.prim_name := r.company_prim_name;
  self.addr_suffix := r.company_addr_suffix;
  self.postdir := r.company_postdir;
  self.unit_desig := r.company_unit_desig;
  self.sec_range := r.company_sec_range;
  self.p_city_name := r.company_city;
  self.st := r.company_state;
  self.zip5 := r.company_zip;
  self.sub_rule_number := 101;
  self.global_sid := r.global_sid;
  self.record_sid := r.record_sid;
  self := [];
end;														
														
#uniquename(f_with_company_info_unsuppressed)														
#uniquename(f_with_company_info)														
%f_with_company_info_unsuppressed% := join(%f_with_contact_id%, %paw_contact_key%,
                                          left.contact_id = right.contact_id,
                                          %get_company_info%(left, right),limit(50, skip));
%f_with_company_info% := Suppress.MAC_SuppressSource(%f_with_company_info_unsuppressed%, mod_access);															
#uniquename(f_out_type_w_dep)
%f_out_type_w_dep% := group(dedup(sort(%f_with_company_info%, acctno, subj_phone10, -subj_date_last, -subj_date_first),
                            acctno, subj_phone10), acctno);

#uniquename(f_out_type_w_ready)
%f_out_type_w_ready% := project(sort(%f_out_type_w_dep%, 
                                     acctno, -paw_conf_score, -subj_date_last, -subj_date_first, subj_phone10),
                                progressive_phone.layout_progressive_batch_out_with_did);
	
progressive_phone.mac_get_back_acctno(%f_out_type_w_ready%, f_w_acctno, f_out_w)	

endmacro;