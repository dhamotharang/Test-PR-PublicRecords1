export mac_get_type_b(f_b_did, f_b_acctno, f_b_out, use_input=false, modAccess) := macro

import STD, gong, ut, progressive_phone, NID, Lib_Word;

#uniquename(f_b_did_set)
%f_b_did_set% := SET(f_b_did, did);
	
#uniquename(gong_addr_key)
#uniquename(gong_history_phone_key)
#uniquename(gong_did)
%gong_addr_key% := gong.Key_History_Address;
%gong_history_phone_key% := gong.Key_History_phone;
%gong_did% := gong.key_history_did;

#uniquename(blue_recs)
progressive_phone.mac_get_blue(f_b_did, %blue_recs%, true, false, false, modAccess)

#uniquename(blue_phone_recs)
%blue_phone_recs% := %blue_recs%(length(trim(phone))=10);

#uniquename(get_blue_phones)
progressive_phone.layout_progressive_batch_out_with_did %get_blue_phones%(%blue_phone_recs% l, %gong_history_phone_key% r) := transform
     self.acctno := (string20)l.seq;
	   self.subj_first := l.fname;
     self.subj_middle := l.mname;
     self.subj_last := l.lname;
     self.subj_suffix := if(l.name_suffix='UNK', r.name_suffix, l.name_suffix); 
	   self.subj_phone10 := l.phone;
     self.subj_name_dual := r.listed_name;
     self.subj_phone_type := '2';
     self.subj_date_first := (string6)l.dt_first_seen;
     self.subj_date_last := (string6)l.dt_last_seen;
		 self.subj_phone_date_last := ((string) Std.Date.Today()) [1..6];
     self.phpl_phones_plus_type := 'R';
		 self.did := l.did;
		 self.p_did := r.did;
  	 self.p_name_last := r.name_last;
	   self.p_name_first := r.name_first;
		 self.sub_rule_number := 21;
		 self := r;
	   self := [];
end;

#uniquename(f_b_out_from_blue)
%f_b_out_from_blue% := join(%blue_phone_recs%, %gong_history_phone_key%,
                            keyed (left.phone[4..10]=right.p7) and 
                            keyed (left.phone[1..3]=right.p3) and
                            wild (right.st) and
                            keyed (right.current_flag) and 
					   (left.fname=right.name_first or 
					    length(trim(left.fname))=1 and left.fname=right.name_first[1] or 
					    length(trim(right.name_first))=1 and left.fname[1]=right.name_first) and
					   left.lname=right.name_last, %get_blue_phones%(left, right), keep(1), limit(ut.limits.PHONE_PER_PERSON, skip));


#uniquename(f_to_match)
%f_to_match% := if(use_input, 
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

#uniquename(by_addr_lname)
progressive_phone.layout_progressive_batch_out_with_did %by_addr_lname%(%f_to_match% l, 
                                                               %gong_addr_key% r) := transform
	self.acctno := if(r.phone10='', skip, (string20)l.seq);
     self.subj_first := l.fname;
     self.subj_middle := l.mname;
     self.subj_last := l.lname;
     self.subj_suffix := if(l.name_suffix='UNK', r.name_suffix, l.name_suffix); 
	   self.subj_phone10 := r.phone10;
     self.subj_name_dual := r.listed_name;
     self.subj_phone_type := '2';
     self.subj_date_first := (string8)l.dt_first_seen;
     self.subj_date_last := (string8)l.dt_last_seen;
		 self.subj_phone_date_last := (string8) STD.Date.Today();
     self.phpl_phones_plus_type := map(r.listing_type_res<>''=>r.listing_type_res,
	                                  r.listing_type_bus<>''=>r.listing_type_bus,
						         r.listing_type_gov);
	self.did := l.did;
  self.addr_suffix := r.suffix;
	self.zip5 := r.z5;
	self.p_did := r.did;
  self.p_name_last := r.name_last;
	self.p_name_first := r.name_first;
	self.sub_rule_number := 22;
	self := r;
	self := [];											   
end;

#uniquename(f_b_out_ready)
%f_b_out_ready% := join(%f_to_match%, %gong_addr_key%,
                        keyed(left.prim_name = right.prim_name or 
				                      (length(trim(Lib_Word.Word(left.prim_name,1)))>3 and 
						                  Lib_Word.Word(left.prim_name,1)=right.prim_name)) and
	                      keyed(left.zip = right.z5) and
		                    keyed(left.prim_range = right.prim_range) and
												keyed(left.st = right.st) and right.current_flag = true and
													(left.lname = right.name_last or
				                 (length(trim(left.lname))>6 and length(trim(right.name_last))>6 and 
					                STD.Str.EditDistance(left.lname, right.name_last)<2) or
					               (length(trim(left.lname))>4 and 
					                left.lname=right.listed_name[1..length(trim(left.lname))]) or 
					               (STD.Str.Find(right.name_last,'-'+trim(left.lname),1) > 0 or 
					                STD.Str.Find(right.name_last,trim(left.lname)+'-',1) > 0) or  
			                    left.fname = right.name_first and 
				                 (STD.Str.EditDistance(left.lname, right.name_last)<2 or
				                  length(trim(left.lname))>5 and 
				                  STD.Str.EditDistance(left.lname, right.name_last)<3)) and
				                 (left.sec_range = '' or left.sec_range = right.sec_range or
				                  NID.mod_PFirstTools.PFLeqPFR(left.fname,right.name_first) or 
					                length(trim(right.name_first))=1 and left.fname[1]=right.name_first),					          
		                     %by_addr_lname%(left, right),limit(ut.limits.PHONE_PER_PERSON, skip)) + 
				%f_b_out_from_blue%;
				
#uniquename(trans_did)
progressive_phone.layout_progressive_batch_out_with_did %trans_did%(f_b_did l,%gong_did% r) := transform
     self.acctno := (string20)l.seq;
	   self.subj_first :=l.fname;
     self.subj_middle := l.mname;
     self.subj_last := l.lname;
     self.subj_suffix := if(l.suffix='UNK', r.name_suffix, l.suffix);
	   self.subj_phone10 := r.phone10;
     self.subj_name_dual := r.listed_name;
     self.subj_phone_type := '2';
     self.subj_date_first := (string6)r.dt_first_seen;
     self.subj_date_last := (string6)r.dt_last_seen;
		 self.subj_phone_date_last := (string6)r.dt_last_seen;
     self.phpl_phones_plus_type := 'R';
		 self.did := r.did;
		 self.p_did := r.did;
  	 self.p_name_last := r.name_last;
	   self.p_name_first := r.name_first;
		 self.sub_rule_number := 23;
		 self := r;
	   self := [];
end;
#uniquename(f_did)
%f_did% := join(f_b_did,%gong_did% , 
                keyed(left.did = right.l_did) and
                keyed(right.current_flag),
                %trans_did%(left,right),
                keep(ut.limits.GONG_PER_DID), limit(0));

// Need to make the sort more deterministic, we were getting different records choosen everytime this code was run.
#uniquename(f_b_out_dep)
%f_b_out_dep% := dedup(sort(%f_b_out_ready% + %f_did%, acctno, subj_phone10, -subj_date_last, -subj_date_first, -subj_phone_date_last, -(p_did IN %f_b_did_set%)), acctno, subj_phone10);

//get back acctno				  
progressive_phone.mac_get_back_acctno(%f_b_out_dep%, f_b_acctno, f_b_out_raw,,true)

f_b_out := if(use_input, %f_b_out_dep%, f_b_out_raw);
endmacro; 