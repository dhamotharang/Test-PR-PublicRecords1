//export mac_get_type_e(f_e_did, f_e_acctno, f_e_out, glb_purpose=0, data_restriction_mask='',includeRelativeCell=false) := macro
export mac_get_type_e(f_e_did, f_e_acctno, f_e_out, includeRelativeCell=false, modAccess) := macro

import doxie_raw, didville, ut, NID, Header, STD;

#uniquename(gong_addr_key)
%gong_addr_key% := gong.Key_History_Address;

#uniquename(gong_did_key)
%gong_did_key% := gong.key_did;

//get relatives and roomies
#uniquename(get_rel)
doxie_raw.Layout_RelativeRawBatchInput %get_rel%(f_e_did l) := transform
	self.input.seq := l.seq;
	self.input.did := l.did;
	self.input.glb_purpose := modAccess.glb;
	self.input.dppa_purpose := modAccess.dppa;
	self.input.ln_branded_value := true;
	self.input.include_relatives_val := true;
	self.input.include_associates_val := true;
	self.input.relative_depth := 1;
	self.seq := l.seq;
	self := [];
end;

#uniquename(f_rel_ready)
#uniquename(f_rel_match_init)
%f_rel_ready% := group(sorted(project(f_e_did, %get_rel%(left)), seq),seq);

%f_rel_match_init% := sort(group(doxie_raw.relative_raw_batch(%f_rel_ready%))(person2<>0),
                           input.seq, depth, p2_sort, p3_sort, p4_sort);

#uniquename(rel_with_rank_rec)
%rel_with_rank_rec% := record
	Doxie_Raw.Layout_RelativeRawBatchInput;
  unsigned4 rel_rank;	
end;

#uniquename(get_rel_rank)
%rel_with_rank_rec% %get_rel_rank%(%f_rel_match_init% l, unsigned cnt) := transform
     self.rel_rank := cnt;
	self := l;
end;

#uniquename(f_rel_match_w_title)
%f_rel_match_w_title% := project(%f_rel_match_init%, %get_rel_rank%(left, counter));

#uniquename(get_rel_did)
didville.Layout_Did_OutBatch %get_rel_did%(%f_rel_match_w_title% l) := transform
	self.seq := l.seq;
	self.did := l.person2;
	self := [];
end;

#uniquename(f_rel_did)				  	  			  
%f_rel_did% := project(%f_rel_match_w_title%, %get_rel_did%(left));

#uniquename(blue_recs) 
progressive_phone.mac_get_blue(%f_rel_did%, %blue_recs%, false, false, false, modAccess)

#uniquename(todays_date)
%todays_date% := (string8) Std.Date.Today();

#uniquename(f_six_months)
%f_six_months% := %blue_recs%(src<>'' and ut.DaysApart(%todays_date%, (string6)dt_last_seen + '15')<=180
                              or ut.DaysApart(%todays_date%,(string6)dt_vendor_last_reported + '15')<=180);
															
#uniquename(with_cohabit_did_rec)
%with_cohabit_did_rec% := record
	progressive_phone.layout_progressive_batch_out_with_did;
  integer rel_prim_range;
  boolean   same_lname;
	unsigned  recent_cohabit;
	unsigned4 rel_rank;
end;

#uniquename(by_addr_lname)
%with_cohabit_did_rec% %by_addr_lname%(%f_six_months% l, 
                                       %gong_addr_key% r) := transform
	self.acctno := if(r.phone10='', skip, (string20)l.seq);
     self.subj_first := l.fname;
     self.subj_middle := l.mname;
     self.subj_last := l.lname;
     self.subj_suffix := l.name_suffix; 
	self.subj_phone10 := r.phone10;
     self.subj_name_dual := r.listed_name;
     self.subj_phone_type := '4';
     self.subj_date_first := (string8)l.dt_first_seen;
     self.subj_date_last := (string8)l.dt_last_seen;
		 self.subj_phone_date_last := %todays_date%;
     self.phpl_phones_plus_type := map(r.listing_type_res<>''=>r.listing_type_res,
	                                  r.listing_type_bus<>''=>r.listing_type_bus,
						         r.listing_type_gov);
	self.did := l.did;	
	self.addr_suffix := r.suffix;
	self.zip5 := r.z5;
	self.p_did := r.did;
  self.p_name_last := r.name_last;
	self.p_name_first := r.name_first;
	self.sub_rule_number := 41;
	self := r;
	self := [];											   
end;

#uniquename(f_e_out_by_addr_lname)
%f_e_out_by_addr_lname% := join(%f_six_months%, %gong_addr_key%,
                                keyed(left.prim_name = right.prim_name) and
	                              keyed(left.zip = right.z5) and
		                            keyed(left.prim_range = right.prim_range) and
																keyed(left.st = right.st) and right.current_flag = true and
		                            (left.lname = right.name_last or
			                           left.fname = right.name_first and 
				                         (STD.Str.EditDistance(left.lname, right.name_last)<2 or
				                         length(trim(left.lname))>5 and 
				                         STD.Str.EditDistance(left.lname, right.name_last)<3)) and
				                        (left.sec_range = '' or left.sec_range = right.sec_range or left.unit_desig = 'LOT' or 
										             NID.mod_PFirstTools.PFLeqPFR(left.fname, right.name_first) or left.fname[1]=right.name_first),					          
		                            %by_addr_lname%(left, right),limit(ut.limits.PHONE_PER_PERSON, skip));
		
#uniquename(by_did)
%with_cohabit_did_rec% %by_did%(%f_rel_did% l, 
                                %gong_did_key% r) := transform
	self.acctno := if(r.phone10='', skip, (string20)l.seq);
     self.subj_first := r.name_first;
     self.subj_middle := r.name_middle;
     self.subj_last := r.name_last;
     self.subj_suffix := r.name_suffix; 
	   self.subj_phone10 := r.phone10;
     self.subj_name_dual := r.listed_name;
     self.subj_phone_type := '4';
     self.subj_date_first := (string8)r.filedate[1..8];
     self.subj_date_last := %todays_date%;
		 self.subj_phone_date_last := %todays_date%;
     self.phpl_phones_plus_type := map(r.listing_type_res<>''=>r.listing_type_res,
	                                  r.listing_type_bus<>''=>r.listing_type_bus,
						         r.listing_type_gov);
	self.did := l.did;	
	self.addr_suffix := r.suffix;
	self.zip5 := r.z5;
	self.p_did := r.did;
	self.p_name_last := r.name_last;
	self.p_name_first := r.name_first;
	self.sub_rule_number := 42;
	self := r;
	self := l;
	self := [];											   
end;
				
				
#uniquename(f_e_out_by_did)
%f_e_out_by_did% := join(%f_rel_did%, %gong_did_key%,
                         keyed(left.did = right.l_did),
					               %by_did%(left, right), limit(ut.limits.PHONE_PER_PERSON, skip));		
		
#uniquename(f_e_out_ready)
%f_e_out_ready% := %f_e_out_by_addr_lname% + %f_e_out_by_did%;

#uniquename(f_e_out_dep)
%f_e_out_dep% := dedup(sort(%f_e_out_ready%, record), record);

//return the phone for the individual most recently cohabited with the subject
#uniquename(get_recent_cohabit)
%with_cohabit_did_rec% %get_recent_cohabit%(%f_e_out_dep% l, %f_rel_match_w_title% r) := transform
	self.recent_cohabit := r.recent_cohabit;
	self.rel_rank := r.rel_rank;
	self.same_lname := r.same_lname;
	self.rel_prim_range := r.rel_prim_range;
	self.subj_phone_type := map( r.TitleNo IN Header.relative_titles.set_Spouse => '41',
											         r.TitleNo IN Header.relative_titles.set_Parent => '42',
											         r.isRelative = FALSE													  => '44',
																																					      '43');
	self.sub_rule_number := map(self.subj_phone_type='41' and l.sub_rule_number=41 => 41,
	                            self.subj_phone_type='41' and l.sub_rule_number=42 => 42,  
	                            self.subj_phone_type='42' and l.sub_rule_number=41 => 43,
															self.subj_phone_type='42' and l.sub_rule_number=42 => 44,
															self.subj_phone_type='43' and l.sub_rule_number=41 => 45,
															self.subj_phone_type='43' and l.sub_rule_number=42 => 46,
															self.subj_phone_type='44' and l.sub_rule_number=41 => 47,
															self.subj_phone_type='44' and l.sub_rule_number=42 => 48,
														  l.sub_rule_number);																												
  self.subj_phone_relationship := if(r.titleNo > 0, STD.Str.CleanSpaces(Header.relative_titles.fn_get_str_title(r.TitleNo) 
																	+ IF(r.TitleNo = Header.relative_titles.num_associate,' '+Header.translateRelativePrimrange(r.rel_prim_range),'')
																  ), 
																									if(r.isRelative = FALSE, STD.Str.CleanSpaces(Header.relative_titles.fn_get_str_title(Header.relative_titles.num_associate) + ' ' + Header.translateRelativePrimrange(r.rel_prim_range)),
																																				Header.relative_titles.fn_get_str_title(Header.relative_titles.num_relative)));
															
	self := l;
	self := r;
end;

#uniquename(f_e_out_with_cohabit)
%f_e_out_with_cohabit% := join(%f_e_out_dep%, %f_rel_match_w_title%, 
                               (unsigned)left.acctno=right.seq and 
						 left.did=right.person2,
						 %get_recent_cohabit%(left, right), left outer, keep(1),limit(0))(subj_phone_type<>'4');

#uniquename(g_in)
// Join to get the correct account number makes data look like a typical request to macro g
%g_in% := join(%f_rel_match_init%,f_e_acctno,left.seq = right.seq,transform(recordof(f_e_did),self.acctno :=right.acctno,self.did := left.person2,self := left,self := []));

#uniquename(f_out_type_g_for_e)
progressive_phone.mac_get_type_g(%g_in%, f_e_acctno, %f_out_type_g_for_e%, modAccess)

#uniquename(f_g_to_e_ready)
// the join below assigns the sequence number vs the account number to the acctno to be like the other relative rows																										
%f_g_to_e_ready% := join(%f_out_type_g_for_e%,f_e_acctno, left.acctno = right.acctno,transform(%with_cohabit_did_rec%,
																										self.acctno := (string)right.seq,
																										self := left,
																										self := []));
#uniquename(f_g_to_e)
%f_g_to_e% := join(%f_g_to_e_ready%, %f_rel_match_w_title%, 
                               (unsigned)left.acctno=right.seq and 
						 left.did=right.person2,
						 %get_recent_cohabit%(left, right), left outer, keep(1),limit(0));
						 
#uniquename(f_all_e_with_cohabit)
%f_all_e_with_cohabit% := if (includeRelativeCell,%f_e_out_with_cohabit%+%f_g_to_e%,%f_e_out_with_cohabit%);

#uniquename(f_e_out_dep2)
%f_e_out_dep2% := dedup(sort(%f_all_e_with_cohabit%, acctno, subj_phone10, -recent_cohabit, -subj_date_last, 
                            -subj_last), acctno, subj_phone10);					
				
#uniquename(f_e_out_limit)
%f_e_out_limit% := group(topN(group(sort(%f_e_out_dep2%(subj_phone_type='43'), acctno, rel_rank),acctno), 10, acctno, rel_rank)) +
	                 sort(%f_e_out_dep2%(subj_phone_type='44', 
									                     ut.DaysApart(%todays_date%,(string6)recent_cohabit + '15')<=180), 
									      acctno, -recent_cohabit, rel_rank) +
                   %f_e_out_dep2%(subj_phone_type not in ['43', '44']); 	
			    
#uniquename(f_e_out_final)
%f_e_out_final% := project(%f_e_out_limit%,
                           transform(progressive_phone.layout_progressive_batch_out_with_did,
													           self.sort_order_internal := if(left.subj_phone_type='43', left.rel_rank, left.sort_order_internal), //the sort order might have a value if it came from phones plus.
																		 self := left));

//get back acctno		
progressive_phone.mac_get_back_acctno(%f_e_out_final%, f_e_acctno, f_e_out)
endmacro;