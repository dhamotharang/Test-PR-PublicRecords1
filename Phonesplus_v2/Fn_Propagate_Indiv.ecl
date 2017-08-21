//****************Function to propagate include/exclude flag to records with the same phoneL7 and did or phone10 and name********************

export Fn_Propagate_Indiv(dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function
					 
//Propagate exclusion flag to records that have the same phone, first and last name.							 
phplus_exclude_by_nm :=  dedup(sort(distribute(phplus_in(~in_flag and 
												   (Translation_Codes.fFlagIsOn(rules, Translation_Codes.rules_bitmap_code('Low-Vendor-Conf')) or
													 Translation_Codes.fFlagIsOn(rules, Translation_Codes.rules_bitmap_code('Deceased')) or
												    Translation_Codes.fFlagIsOn(rules, Translation_Codes.rules_bitmap_code('Non-pub-for-someone-else')) or
														Translation_Codes.fFlagIsOn(rules, Translation_Codes.rules_bitmap_code('Gongh-Disconnect')) or
														Translation_Codes.fFlagIsOn(rules, Translation_Codes.rules_bitmap_code('Consortium-Disconnect')) )), 
							  hash(npa+phone7)), 
						 npa+phone7, fname, lname, rules, local),
				   npa+phone7, fname, lname, local) ;							 

recordof(phplus_in) t_propagate_indiv_false (phplus_in le, phplus_exclude_by_nm ri) := transform 
	self.in_flag 	:= if(ri.rules <> 0b and 
	                      (le.rules = 0b or 
												Translation_Codes.fGet_rules_caption_from_bitmap(le.rules) = ('Disconnected-EDA')), 
						  ri.in_flag, 
						  le.in_flag);
	self.rules 	:= if(ri.rules <> 0b and 
						  (le.rules = 0b or 
						   Translation_Codes.fGet_rules_caption_from_bitmap(le.rules) = ('Disconnected-EDA')),
						   ri.rules, 
						   le.rules );
	self.src_rule := if(ri.rules <> 0b and 
						  (le.rules = 0b or 
						   Translation_Codes.fGet_rules_caption_from_bitmap(le.rules) = ('Disconnected-EDA')), 
						   le.src_all | ri.src_all | le.src_rule | ri.src_rule, le.src_all |le.src_rule);
   self := le;
end;


propagate_indiv_nm_false := join(distribute(phplus_in, hash(npa+phone7)), 
							 phplus_exclude_by_nm,
							 left.npa+left.phone7 = right.npa+right.phone7 and
							 left.lname = right.lname and
							 left.fname = right.fname,
							 t_propagate_indiv_false(left, right), 
							 left outer,
							 local);


phplus_include_by_did :=  dedup(sort(distribute(propagate_indiv_nm_false(in_flag and rules <> 0b), hash(phone7_did_key)), phone7_did_key, -in_flag, local),phone7_did_key, local) ;

//Propagate inclusion flag and rules at the did - phoneL7 level.
recordof(phplus_in) t_propagate_did_indiv_true(propagate_indiv_nm_false le, phplus_include_by_did ri) := transform
	self.in_flag 	   := if(ri.rules <> 0b and
						  (le.rules = 0b or 
						  Translation_Codes.fGet_rules_caption_from_bitmap(le.rules) = ('Disconnected-EDA')), 
						  ri.in_flag, 
						  le.in_flag);
	self.rules 	   := if(ri.rules <> 0b and 
	                      (le.rules = 0b or 
												Translation_Codes.fGet_rules_caption_from_bitmap(le.rules) = ('Disconnected-EDA')),
						  ri.rules, 
						  le.rules );
	
	self.src_rule := if(ri.rules <> 0b and 
	                      (le.rules = 0b or 
												Translation_Codes.fGet_rules_caption_from_bitmap(le.rules) = ('Disconnected-EDA')),
						  le.src_all | ri.src_all | le.src_rule | ri.src_rule, le.src_all |le.src_rule);
	self := le;
end;

propagate_indiv_did_true:= join(distribute(propagate_indiv_nm_false, hash(phone7_did_key)),
						   phplus_include_by_did,
						   left.phone7_did_key = right.phone7_did_key,
						   t_propagate_did_indiv_true(left, right),
						   left outer,
						   local);


phplus_include_by_nm := dedup(sort(distribute(propagate_indiv_did_true(in_flag and rules <> 0b), hash(npa+phone7)), npa+phone7, fname, lname, rules, local),npa+phone7, fname, lname, local) ;

//Propagate inclusion flag to records that have the same phone, first and last name.
recordof(phplus_in) t_propagate_indiv_true (propagate_indiv_did_true le, phplus_include_by_nm ri) := transform 
	self.in_flag 	:= if(ri.rules <> 0b and 
				          (le.rules = 0b or 
												Translation_Codes.fGet_rules_caption_from_bitmap(le.rules) = ('Disconnected-EDA')),
						  ri.in_flag, 
						  le.in_flag);
	self.rules 	:= if(ri.rules <> 0b and 
	                      (le.rules = 0b or 
												Translation_Codes.fGet_rules_caption_from_bitmap(le.rules) = ('Disconnected-EDA')),
						  ri.rules, 
						  le.rules );
		
	self.src_rule := if(ri.rules <> 0b and 
	                      (le.rules = 0b or 
												Translation_Codes.fGet_rules_caption_from_bitmap(le.rules) = ('Disconnected-EDA')), 
						  le.src_all | ri.src_all | le.src_rule | ri.src_rule, le.src_all |le.src_rule);
   
	 self := le;
end;


propagate_indiv_nm_true := join(distribute(propagate_indiv_did_true, hash(npa+phone7)), 
							 phplus_include_by_nm,
							 left.npa+left.phone7 = right.npa+right.phone7 and
							 left.lname = right.lname and
							 left.fname = right.fname,
							 t_propagate_indiv_true(left, right),
							 left outer,
							 local);
							 
return propagate_indiv_nm_true;

end;