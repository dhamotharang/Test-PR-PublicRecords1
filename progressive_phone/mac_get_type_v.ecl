import doxie, phonesplus, ut;

export mac_get_type_v(f_v_did, f_v_acctno, f_v_out, use_input=false, modAccess) := macro

#uniquename(blue_recs)
progressive_phone.mac_get_blue(f_v_did, %blue_recs%,,,true, modAccess)

#uniquename(f_six_months)
%f_six_months% := %blue_recs%(ut.DaysApart(StringLib.GetDateYYYYMMDD(),(string6)dt_last_seen + '15')<=180,
                              (unsigned)phone>0);
																													
#uniquename(conv_out)
progressive_phone.layout_progressive_batch_out_with_did %conv_out%(%f_six_months% l) := transform
	   self.acctno := (string20)l.seq;
     self.subj_first := l.fname;
     self.subj_middle := l.mname;
     self.subj_last := l.lname;
     self.subj_suffix := l.name_suffix; 
	   self.subj_phone10 := l.phone;
     self.subj_name_dual := trim(l.fname) + ' ' + trim(l.mname) + ' ' + trim(l.lname);
     self.subj_phone_type := '7';
     self.subj_date_first := (string8)l.dt_first_seen;
     self.subj_date_last := (string8)l.dt_last_seen;
		 self.subj_phone_date_last := '';
     self.phpl_phones_plus_type := 'R';
		 self.did := l.did;
		 self.addr_suffix := l.suffix;
		 self.zip5 := l.zip;
		 self.p_city_name := l.city_name;
		 self := l;
  	 self.p_name_last := l.lname;
	   self.p_name_first := l.fname;
		 self.p_did := l.did;
		 self.sub_rule_number := 71;
     self := [];											   
end;

#uniquename(f_v_out_ready1)
%f_v_out_ready1% := project(%f_six_months%, %conv_out%(left));

#uniquename(get_acctno_bk)
progressive_phone.layout_progressive_batch_out_with_did  %get_acctno_bk%(%f_six_months% l, f_v_acctno r) := transform
	   self.acctno := (string20)r.seq;
     self.subj_first := l.fname;
     self.subj_middle := l.mname;
     self.subj_last := l.lname;
     self.subj_suffix := l.name_suffix; 
	   self.subj_phone10 := l.phone;
     self.subj_name_dual := trim(l.fname) + ' ' + trim(l.mname) + ' ' + trim(l.lname);
     self.subj_phone_type := '7';
     self.subj_date_first := (string8)l.dt_first_seen;
     self.subj_date_last := (string8)l.dt_last_seen;
		 self.subj_phone_date_last := '';
     self.phpl_phones_plus_type := 'R';
		 self.did := l.did;
		 self.addr_suffix := l.suffix;
		 self.zip5 := l.zip;
		 self.p_city_name := l.city_name;
		 self := l;
  	 self.p_name_last := l.lname;
	   self.p_name_first := l.fname;
		 self.p_did := l.did;
	   self := r;
     self := [];	
end;

#uniquename(f_v_out_ready2)
%f_v_out_ready2% := join(%f_six_months%, f_v_acctno,
                         left.seq = (unsigned)right.acctno and
												 left.prim_name=right.prim_name and 
												 left.prim_range=right.prim_range and
												 left.zip = right.z5,
												 %get_acctno_bk%(left, right), keep(1));
												 
#uniquename(f_v_out_ready)
%f_v_out_ready% := if(use_input, %f_v_out_ready2%, %f_v_out_ready1%);												 
												 
#uniquename(f_v_out_dep)
%f_v_out_dep% := group(dedup(sort(%f_v_out_ready%, acctno, subj_phone10, -subj_date_last, -subj_date_first), 
                             acctno, subj_phone10), acctno);
					    
#uniquename(f_v_out_final)
%f_v_out_final% := topN(%f_v_out_dep%,3,acctno,-subj_date_last, -subj_date_first);					    

progressive_phone.mac_get_back_acctno(%f_v_out_final%, f_v_acctno, f_v_out_raw)

f_v_out := if(use_input, group(%f_v_out_final%), f_v_out_raw);
endmacro; 