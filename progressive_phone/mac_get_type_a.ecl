export mac_get_type_a(f_a_acctno, f_a_out, mod_access, use_seq = false) := macro

import Suppress, STD, dx_Gong, ut, NID, progressive_phone, Person_Models;
#uniquename(gong_addr_key)
#uniquename(optout_tmp_layout)
%gong_addr_key% := dx_Gong.key_history_address();

//get name&addr match from weekly gong
#uniquename(by_gong_address)
progressive_phone.layout_progressive_batch_out_sid %by_gong_address%(f_a_acctno l, %gong_addr_key% r, unsigned sub_rule_num) := transform
  string6 todays_date := ((string) Std.Date.Today())[1..6];
  self.acctno := if(r.phone10='', skip, if(use_seq,(string20)l.seq,l.acctno));
     self.subj_first := l.fname;
     self.subj_middle := l.mname;
     self.subj_last := l.lname;
     self.subj_suffix := '';
     self.subj_phone10 := r.phone10;
     self.subj_name_dual := r.listed_name;
     self.subj_phone_type := '1';
     self.subj_date_first := r.dt_first_seen[1..6];
     self.subj_date_last := todays_date;
     self.subj_phone_date_last := todays_date;
     self.phpl_phones_plus_type := map(r.listing_type_res<>'' => r.listing_type_res,
      r.listing_type_bus<>'' => r.listing_type_bus,
      r.listing_type_gov);
     self.addr_suffix :=	r.suffix;
     self.zip5 :=	r.z5;
     self.p_did := r.did;  //did for phone record
     self.p_name_last := r.name_last;
     self.p_name_first := r.name_first;
     self.did := l.did;  // did of subject
     self.sub_rule_number := sub_rule_num;
     self.subj_phone_relationship := Person_Models.constants.str_subject;
     self.key_did := r.did;
     self.global_sid := r.global_sid;
     self.record_sid := r.record_sid;
     self := r;
     self := [];
end;

#uniquename(f_a_out_1)
%f_a_out_1% := join(f_a_acctno, %gong_addr_key%,
  keyed(left.prim_name = right.prim_name) and
    keyed(left.z5 = right.z5) and
    keyed(left.prim_range = right.prim_range) and
    keyed(left.st = right.st) and right.current_flag = true and
    ((metaphonelib.DMetaPhone1(left.lname) = metaphonelib.DMetaPhone1(right.name_last) and
    ((left.sec_range = '' and (left.fname[1] = right.name_first[1])) or
    (left.sec_range <> '' and NID.mod_PFirstTools.PFLeqPFR(left.fname,right.name_first)))) or
    (metaphonelib.DMetaPhone1(left.fname) = metaphonelib.DMetaPhone1(right.name_last) and
    (left.sec_range = '' and (left.lname[1] = right.name_first[1])))),
  %by_gong_address%(left, right,11), limit(ut.limits.PHONE_PER_PERSON, skip));

#uniquename(f_a_out_2)
%f_a_out_2% := join(f_a_acctno, %gong_addr_key%,
  keyed(left.prim_name = right.prim_name) and
    keyed(left.z5 = right.z5) and
    keyed(left.prim_range = right.prim_range) and
    keyed(left.st = right.st) and right.current_flag = true and
    (left.sec_range = '' and
    (left.lname = right.name_last or left.fname = right.name_first)),
  %by_gong_address%(left, right,12), limit(ut.limits.PHONE_PER_PERSON, skip));

#uniquename(get_2_only)
progressive_phone.layout_progressive_batch_out_sid %get_2_only%(%f_a_out_2% l) := transform
  self := l;
end;

#uniquename(pre_f_a_out_ready);
#uniquename(f_a_out_optout);
#uniquename(f_a_out_ready);

%pre_f_a_out_ready% := %f_a_out_1% + join(%f_a_out_2%, %f_a_out_1%,
  left.acctno=right.acctno, %get_2_only%(left), left only);

%f_a_out_optout% := Suppress.MAC_SuppressSource(%pre_f_a_out_ready%, mod_access, key_did);
%f_a_out_ready% := PROJECT(%f_a_out_optout%, progressive_phone.layout_progressive_batch_out_with_did);

f_a_out := dedup(sort(%f_a_out_ready%, acctno, subj_phone10, -subj_date_last, -subj_date_first), acctno, subj_phone10);

endmacro;
