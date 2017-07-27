export mac_get_back_acctno(f_out_seq, f_acctno_in, f_out_acctno, get_orig_name=false, is_level_tb=false) := macro
//get back acctno				  
#uniquename(get_back_acctno)
progressive_phone.layout_progressive_batch_out_with_did  %get_back_acctno%(f_out_seq l, f_acctno_in r) := transform
	self.acctno := r.acctno;
	self.subj_first := if(get_orig_name and (r.fname <> '' or r.lname <> ''), r.fname, l.subj_first);
  self.subj_middle := if(get_orig_name and (r.fname <> '' or r.lname <> ''), r.mname, l.subj_middle);
  self.subj_last := if(get_orig_name and (r.fname <> '' or r.lname <> ''), r.lname, l.subj_last);
  self.subj_suffix := if(get_orig_name and (r.fname <> '' or r.lname <> ''), r.suffix, l.subj_suffix);
	self.sort_order_internal := map(~is_level_tb => l.sort_order_internal,
	                                l.subj_suffix=r.suffix => 0,1);
	self := l;
end;				  
				  
f_out_acctno := join(f_out_seq, f_acctno_in,
                     (unsigned)left.acctno=right.seq,
		     	           %get_back_acctno%(left, right), left outer, KEEP(1));	
endmacro;