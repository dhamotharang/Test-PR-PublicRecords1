import doxie, NID, ut, progressive_phone;

export mac_get_type_b2(f_b_did, f_b_acctno, f_b_out, use_input=false, data_restriction_mask='') := macro
	
#uniquename(blue_recs)
progressive_phone.mac_get_blue(f_b_did, %blue_recs%, true, false, false, data_restriction_mask)

#uniquename(f_to_match_raw)
%f_to_match_raw% := if(use_input, 
                       project(f_b_acctno(prim_name[1..6]<>'PO BOX', prim_name[1..3]<>'DOD'), 
				 					         transform(progressive_phone.layout_header_seq, 
													           self.dob := (integer4)left.dob,
																		 self.phone := left.phone10,
																		 self.name_suffix := left.suffix,
																		 self.suffix := left.addr_suffix,
																		 self.city_name := left.p_city_name,
																		 self.zip := left.z5,
													           self := left, self := [])),
                      %blue_recs%);

#uniquename(slim_addr_cnt_rec)
%slim_addr_cnt_rec% := record
	integer3 address_seq_no := -1;
	%f_to_match_raw%.seq;
	%f_to_match_raw%.prim_name;
	%f_to_match_raw%.prim_range;
	%f_to_match_raw%.sec_range;
     %f_to_match_raw%.zip;
end;

#uniquename(f_slim_addr_cnt)
%f_slim_addr_cnt% := project(dedup(sort(table(%f_to_match_raw%, %slim_addr_cnt_rec%),record),record),
                             transform(%slim_addr_cnt_rec%, self.address_seq_no := counter, self := left));

#uniquename(get_to_match)
doxie.Layout_Comp_Addresses %get_to_match%(%f_to_match_raw% l, %f_slim_addr_cnt% r) := transform
	self.address_seq_no := r.address_seq_no;
	self.county_name := (string18)l.seq;
	self := l;
	self := [];
end;

#uniquename(f_to_match)
%f_to_match% := join(%f_to_match_raw%,%f_slim_addr_cnt%,
                     left.seq = right.seq and
				 left.prim_name = right.prim_name and
				 left.prim_range = right.prim_range and
				 left.sec_range = right.sec_range and
				 left.zip = right.zip,
                     %get_to_match%(left, right)); 			    

#uniquename(f_blue_mark_phones)
%f_blue_mark_phones% := doxie.fn_addLVV(%f_to_match%).records_wListedPhone(listed_phone<>''); 

#uniquename(convert_to_prgout)
progressive_phone.layout_progressive_batch_out_with_did %convert_to_prgout%(%f_blue_mark_phones% l) := transform
	self.acctno := (string20)l.county_name;
     self.subj_first := l.fname;
     self.subj_middle := l.mname;
     self.subj_last := l.lname;
     self.subj_suffix := if(l.name_suffix='UNK', '', l.name_suffix); 
	self.subj_phone10 := l.listed_phone;
     self.subj_name_dual := trim(l.fname) + ' ' + trim(l.mname) + ' ' + trim(l.lname);
     self.subj_phone_type := '2';
     self.subj_date_first := (string8)l.dt_first_seen;
     self.subj_date_last := (string8)l.dt_last_seen;
	self.subj_phone_date_last := (string8)Stringlib.GetDateYYYYMMDD();
     self.phpl_phones_plus_type := 'R';
	self.did := l.did;
     self.addr_suffix := l.suffix;
	self.zip5 := l.zip;
	self.p_did := l.did;
     self.p_name_last := l.lname;
	self.p_name_first := l.fname;
	self.p_city_name := l.city_name;
	self.v_city_name := l.city_name;
	self.sub_rule_number := 24;
	self := l;
	self := [];											   
end;

#uniquename(f_b_out_ready)
%f_b_out_ready% := dedup(sort(project(%f_blue_mark_phones%, %convert_to_prgout%(left)), 
                              acctno, subj_phone10, -subj_date_last, -subj_date_first, -subj_name_dual, -prim_name, -prim_range, -zip5),
                         acctno, subj_phone10);

progressive_phone.mac_get_back_acctno(%f_b_out_ready%, f_b_acctno, f_b_out_raw,,true)

f_b_out := if(use_input, %f_b_out_ready%, f_b_out_raw);

endmacro; 